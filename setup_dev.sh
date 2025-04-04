#!/bin/bash

echo "Setting up the Survey App for development..."

# Step 1: Ensure Docker is running
if ! docker info > /dev/null 2>&1; then
  echo " Docker is not running. Please start Docker and try again."
  exit 1
fi

# Step 2: Build Docker images
echo "Building Docker containers..."
docker-compose build # Build the Docker images defined in the docker-compose.yml file.

# Step 3: Install Ruby gems
echo "Installing Ruby dependencies..."
docker-compose run web bundle install # Install the required Ruby gems inside the web container.

# Step 4: Set up the database
echo "Setting up the database..."
docker-compose run web bin/rails db:setup # Create, migrate, and seed the database.

# Step 5: Precompile assets (optional)
echo "Precompiling assets..."
docker-compose run web bin/rails assets:precompile # Precompile assets for production or testing.

# Step 6: Start the app
echo "Starting the app..."
docker-compose up # Start all services defined in the docker-compose.yml file.

echo "Setup complete! Visit http://localhost:3000 to view the app."