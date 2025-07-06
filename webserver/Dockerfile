# Multi-stage build for Dart webserver
# Build stage - using Debian to match production stage
FROM instrumentisto/flutter:latest AS build

# Set the working directory
WORKDIR /app

# Copy only the required folders to access database_models package
COPY webserver/ ./webserver/
COPY packages/ ./packages/

# Change to webserver directory
WORKDIR /app/webserver

# Get dependencies
RUN dart pub get

# Compile the application to native executable
RUN dart compile exe bin/webserver.dart -o webserver

# Production stage
FROM alpine:latest

# Install minimal runtime dependencies
RUN apk add --no-cache \
    ca-certificates \
    libc6-compat \
    sqlite

# Create a non-root user
RUN addgroup -g 1001 -S dartuser && \
    adduser -S dartuser -u 1001 -G dartuser

# Set the working directory
WORKDIR /app

# Copy the compiled binary from build stage
COPY --from=build /app/webserver/webserver /app/webserver
COPY --from=build /app/webserver/assets/ /app/assets/

# Change ownership to non-root user
RUN chown -R dartuser:dartuser /app

# Switch to non-root user
USER dartuser

# Expose the port
EXPOSE 8080

# Run the application
CMD ["./webserver", "--host", "0.0.0.0", "--port", "8080"]