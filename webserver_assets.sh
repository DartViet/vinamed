#!/bin/bash

# Script to copy webserver assets to remote server via SSH
# This script copies everything from local webserver/assets to remote /opt/vinamed/webserver/assets

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

# Remote connection variables (to be set later)
USERNAME="dngo"
PASSWORD="linux123"
SERVERIP="192.168.0.4"

# Local and remote paths
LOCAL_ASSETS_PATH="webserver/assets"
REMOTE_ASSETS_PATH="~/monorepo/vinamed/webserver/assets"

# Function to validate connection variables
validate_connection() {
    if [[ -z "$USERNAME" ]]; then
        print_error "USERNAME variable is not set!"
        return 1
    fi
    
    if [[ -z "$PASSWORD" ]]; then
        print_error "PASSWORD variable is not set!"
        return 1
    fi
    
    if [[ -z "$SERVERIP" ]]; then
        print_error "SERVERIP variable is not set!"
        return 1
    fi
    
    return 0
}

# Function to validate local assets directory
validate_local_assets() {
    if [[ ! -d "$LOCAL_ASSETS_PATH" ]]; then
        print_error "Local assets directory '$LOCAL_ASSETS_PATH' does not exist!"
        print_error "Please run this script from the monorepo root directory."
        return 1
    fi
    
    # Count files in assets directory
    local file_count=$(find "$LOCAL_ASSETS_PATH" -type f | wc -l)
    if [[ $file_count -eq 0 ]]; then
        print_warning "No files found in '$LOCAL_ASSETS_PATH'"
        return 1
    fi
    
    print_info "Found $file_count files in local assets directory"
    return 0
}

# Function to test SSH connection
test_ssh_connection() {
    print_info "Testing SSH connection to $USERNAME@$SERVERIP..."
    
    # Use sshpass to provide password and test connection
    if command -v sshpass >/dev/null 2>&1; then
        if sshpass -p "$PASSWORD" ssh -o ConnectTimeout=10 -o StrictHostKeyChecking=no "$USERNAME@$SERVERIP" "echo 'SSH connection successful'" >/dev/null 2>&1; then
            print_success "SSH connection test successful"
            return 0
        else
            print_error "SSH connection test failed"
            return 1
        fi
    else
        print_warning "sshpass not installed. Installing sshpass..."
        # Check if we're running as root or with sudo
        if [[ $EUID -eq 0 ]]; then
            apt-get update && apt-get install -y sshpass
        else
            print_error "Please install sshpass: sudo apt-get install sshpass"
            return 1
        fi
        
        # Retry connection test
        if sshpass -p "$PASSWORD" ssh -o ConnectTimeout=10 -o StrictHostKeyChecking=no "$USERNAME@$SERVERIP" "echo 'SSH connection successful'" >/dev/null 2>&1; then
            print_success "SSH connection test successful"
            return 0
        else
            print_error "SSH connection test failed after installing sshpass"
            return 1
        fi
    fi
}

# Function to create remote directory structure
create_remote_directories() {
    print_info "Creating remote directory structure..."
    
    if sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USERNAME@$SERVERIP" "mkdir -p '$REMOTE_ASSETS_PATH'"; then
        print_success "Remote directory structure created: $REMOTE_ASSETS_PATH"
        return 0
    else
        print_error "Failed to create remote directory structure"
        return 1
    fi
}

# Function to copy assets using rsync over SSH
copy_assets() {
    print_info "Copying assets from '$LOCAL_ASSETS_PATH' to '$USERNAME@$SERVERIP:$REMOTE_ASSETS_PATH'..."
    
    # Check if rsync is available
    if ! command -v rsync >/dev/null 2>&1; then
        print_warning "rsync not found. Installing rsync..."
        if [[ $EUID -eq 0 ]]; then
            apt-get update && apt-get install -y rsync
        else
            print_error "Please install rsync: sudo apt-get install rsync"
            return 1
        fi
    fi
    
    # Use rsync with sshpass for secure copy with progress
    if sshpass -p "$PASSWORD" rsync -avz --progress \
        -e "ssh -o StrictHostKeyChecking=no" \
        "$LOCAL_ASSETS_PATH/" \
        "$USERNAME@$SERVERIP:$REMOTE_ASSETS_PATH/"; then
        print_success "Assets copied successfully!"
        return 0
    else
        print_error "Failed to copy assets"
        return 1
    fi
}

# Function to verify remote files
verify_remote_files() {
    print_info "Verifying remote files..."
    
    local remote_file_count=$(sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USERNAME@$SERVERIP" "find '$REMOTE_ASSETS_PATH' -type f | wc -l")
    local local_file_count=$(find "$LOCAL_ASSETS_PATH" -type f | wc -l)
    
    print_info "Local files: $local_file_count"
    print_info "Remote files: $remote_file_count"
    
    if [[ "$remote_file_count" -eq "$local_file_count" ]]; then
        print_success "File count verification passed!"
        return 0
    else
        print_warning "File count mismatch. Some files may not have been copied."
        return 1
    fi
}

# Function to show remote directory listing
show_remote_listing() {
    print_info "Remote assets directory listing:"
    echo "----------------------------------------"
    sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USERNAME@$SERVERIP" "ls -la '$REMOTE_ASSETS_PATH'"
    echo "----------------------------------------"
}

# Main function
main() {
    print_info "Webserver Assets Copy Script"
    print_info "=============================="
    echo ""
    
    # Validate connection variables
    if ! validate_connection; then
        print_error "Connection variables not properly set!"
        print_info "Please set the following variables before running this script:"
        print_info "  USERNAME - SSH username for remote server"
        print_info "  PASSWORD - SSH password for remote server"
        print_info "  SERVERIP - IP address of remote server"
        exit 1
    fi
    
    # Validate local assets directory
    if ! validate_local_assets; then
        exit 1
    fi
    
    # Test SSH connection
    if ! test_ssh_connection; then
        print_error "Cannot establish SSH connection to remote server"
        exit 1
    fi
    
    # Create remote directories
    if ! create_remote_directories; then
        exit 1
    fi
    
    # Copy assets
    if ! copy_assets; then
        exit 1
    fi
    
    # Verify files
    if ! verify_remote_files; then
        print_warning "Verification had issues, but copy may have succeeded"
    fi
    
    # Show remote listing
    show_remote_listing
    
    echo ""
    print_success "Asset copy operation completed!"
    print_info "Assets have been copied to: $USERNAME@$SERVERIP:$REMOTE_ASSETS_PATH"
}

# Run main function
main
