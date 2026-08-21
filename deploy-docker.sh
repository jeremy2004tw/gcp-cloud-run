
# Create an Artifact Registry repository
gcloud artifacts repositories create REPOSITORY \
    --repository-format=docker \
    --location=LOCATION \
    --description="DESCRIPTION" \
    --immutable-tags \
    --async

# Configure Docker to get access to Artifact Registry
gcloud auth configure-docker LOCATION-docker.pkg.dev

# Build using Cloud Build
gcloud builds submit --tag IMAGE_URL

# If you use Artifact Registry, the repository REPO_NAME must already be created. The URL follows the format of LOCATION-docker.pkg.dev/PROJECT_ID/REPO_NAME/PATH:TAG

# Build locally and push using Docker
docker build . --tag IMAGE_URL
docker push IMAGE_URL

# Build with Google Cloud's buildpacks using Cloud Build
gcloud builds submit --pack image=IMAGE_URL
