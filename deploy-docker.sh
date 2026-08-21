
# Create a Repository
gcloud artifacts repositories create gcp-cloud-run-docker \
  --project="$PROJECT_ID" \
  --location="$REGION" \
  --repository-format=docker \
  --description="Docker repository for gcp-cloud-run-docker"

gcloud run services add-iam-policy-binding gcp-cloud-run-docker \
    --member="allUsers" \
    --role="roles/run.invoker" \
    --region=$REGION



# Build and Tag the Image
# Configure Docker authentication
# gcloud auth configure-docker us-central1-docker.pkg.dev

# Build the image with a production-ready tag
# docker build -t us-central1-docker.pkg.dev/$PROJECT_ID/gcp-cloud-run-docker/gcp-cloud-run-docker:1.0.0 .

# Push the Image
# docker push us-central1-docker.pkg.dev/$PROJECT_ID/gcp-cloud-run-docker/gcp-cloud-run-docker:1.0.0

# Deploy to Google Cloud Run
# gcloud run deploy gcp-cloud-run-docker \
#   --image=us-central1-docker.pkg.dev/$PROJECT_ID/gcp-cloud-run-docker/gcp-cloud-run-docker:1.0.0 \
#   --platform=managed \
#   --region=us-central1 \
#   --allow-unauthenticated



# Create an Artifact Registry repository
# gcloud artifacts repositories create REPOSITORY \
#     --repository-format=docker \
#     --location=LOCATION \
#     --description="DESCRIPTION" \
#     --immutable-tags \
#     --async

# Configure Docker to get access to Artifact Registry
# gcloud auth configure-docker LOCATION-docker.pkg.dev

# Build using Cloud Build
# gcloud builds submit --tag IMAGE_URL

# If you use Artifact Registry, the repository REPO_NAME must already be created. The URL follows the format of LOCATION-docker.pkg.dev/PROJECT_ID/REPO_NAME/PATH:TAG

# Build locally and push using Docker
# docker build . --tag IMAGE_URL
# docker push IMAGE_URL

# Build with Google Cloud's buildpacks using Cloud Build
# gcloud builds submit --pack image=IMAGE_URL
