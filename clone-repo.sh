#!/bin/bash

# Script to clone a GitHub repository using a personal access token
# Usage: ./clone-repo.sh [REPO_URL] [TOKEN] [DESTINATION_DIR]

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [REPO_URL] [TOKEN] [DESTINATION_DIR]"
    echo ""
    echo "Arguments:"
    echo "  REPO_URL        GitHub repository URL (e.g., https://github.com/user/repo.git)"
    echo "  TOKEN           GitHub Personal Access Token"
    echo "  DESTINATION_DIR Directory to clone into (optional, defaults to repo name)"
    echo ""
    echo "Examples:"
    echo "  $0 https://github.com/user/repo.git ghp_xxxxxxxxxxxx"
    echo "  $0 https://github.com/user/repo.git ghp_xxxxxxxxxxxx ./my-project"
    echo ""
    echo "Environment Variables (alternative to arguments):"
    echo "  GITHUB_REPO_URL    Repository URL"
    echo "  GITHUB_TOKEN       Personal Access Token"
    echo "  CLONE_DIR          Destination directory"
}

REPO_URL=https://github.com/DartViet/vinamed
TOKEN=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
GITHUB_REPO_URL=${REPO_URL}
GITHUB_TOKEN=${TOKEN}
DESTINATION_DIR=~/monorepo/vinamed
CLONE_DIR=${DESTINATION_DIR}

# Function to validate GitHub token format
validate_token() {
    local token="$1"
    if [[ ! "$token" =~ ^(ghp_|github_pat_|gho_|ghu_|ghs_|ghr_).{36,}$ ]]; then
        print_error "Invalid GitHub token format. Token should start with ghp_, github_pat_, gho_, ghu_, ghs_, or ghr_"
        return 1
    fi
    return 0
}

# Function to extract repo name from URL
extract_repo_name() {
    local url="$1"
    # Remove .git suffix if present and extract last part of path
    basename "$url" .git
}

# Function to validate repository URL
validate_repo_url() {
    local url="$1"
    if [[ ! "$url" =~ ^https://github\.com/.+/.+$ ]]; then
        print_error "Invalid GitHub repository URL format. Expected: https://github.com/user/repo"
        return 1
    fi
    return 0
}

# Main function
main() {
    print_info "GitHub Repository Clone Script"
    echo ""

    # Use hardcoded variables
    REPO_URL_TO_USE=$REPO_URL
    TOKEN_TO_USE=$TOKEN
    DESTINATION_DIR_TO_USE=$DESTINATION_DIR

    # Validate inputs
    if ! validate_repo_url "$REPO_URL_TO_USE"; then
        exit 1
    fi

    if ! validate_token "$TOKEN_TO_USE"; then
        exit 1
    fi

    # Extract repository name if destination not provided
    if [[ -z "$DESTINATION_DIR_TO_USE" ]]; then
        DESTINATION_DIR_TO_USE=$(extract_repo_name "$REPO_URL_TO_USE")
        print_info "Using default destination directory: $DESTINATION_DIR_TO_USE"
    fi

    # Check if destination directory already exists
    if [[ -d "$DESTINATION_DIR_TO_USE" ]]; then
        print_warning "Directory '$DESTINATION_DIR_TO_USE' already exists!"
        read -p "Do you want to continue? This will delete the existing directory. (y/N): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Operation cancelled."
            exit 0
        fi
        print_info "Removing existing directory..."
        rm -rf "$DESTINATION_DIR_TO_USE"
    fi

    # Construct authenticated URL
    # Extract user and repo from URL
    if [[ "$REPO_URL_TO_USE" =~ https://github\.com/([^/]+)/([^/]+)(\.git)?$ ]]; then
        USER="${BASH_REMATCH[1]}"
        REPO="${BASH_REMATCH[2]}"
        AUTHENTICATED_URL="https://${TOKEN_TO_USE}@github.com/${USER}/${REPO}.git"
    else
        print_error "Failed to parse repository URL"
        exit 1
    fi

    print_info "Starting clone operation..."
    print_info "Repository: $USER/$REPO"
    print_info "Destination: $DESTINATION_DIR_TO_USE"

    # Clone the repository
    if git clone "$AUTHENTICATED_URL" "$DESTINATION_DIR_TO_USE"; then
        print_success "Repository cloned successfully!"
        
        # Change to the cloned directory and show some info
        cd "$DESTINATION_DIR_TO_USE"
        
        # Remove the token from git remote URL for security
        print_info "Securing git remote URL..."
        git remote set-url origin "$REPO_URL_TO_USE"
        
        # Show repository information
        echo ""
        print_info "Repository Information:"
        echo "  📁 Location: $(pwd)"
        echo "  🌿 Branch: $(git branch --show-current)"
        echo "  📝 Latest commit: $(git log -1 --oneline)"
        echo "  🔗 Remote URL: $(git remote get-url origin)"
        
        # Count files and directories
        file_count=$(find . -type f ! -path './.git/*' | wc -l)
        dir_count=$(find . -type d ! -path './.git/*' ! -path '.' | wc -l)
        echo "  📊 Contents: $file_count files, $dir_count directories"
        
    else
        print_error "Failed to clone repository!"
        print_error "Please check:"
        print_error "  - Repository URL is correct"
        print_error "  - Personal Access Token has proper permissions"
        print_error "  - Token has 'repo' scope for private repositories"
        print_error "  - Network connection is working"
        exit 1
    fi

    echo ""
    print_success "Clone operation completed successfully!"
    print_info "You can now work with the repository in: $DESTINATION_DIR_TO_USE"
}

# Run main function
main
