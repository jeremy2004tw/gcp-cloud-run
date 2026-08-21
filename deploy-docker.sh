
# Create a Repository
gcloud artifacts repositories create gcp-cloud-run-docker \
  --project="$PROJECT_ID" \
  --location="$REGION" \
  --repository-format=docker \
  --description="Docker repository for gcp-cloud-run-docker"

# gcloud artifacts repositories get-iam-policy gcp-cloud-run-docker \
#   --location="$REGION" \
#   --project="$PROJECT_ID"

# gcloud artifacts repositories add-iam-policy-binding gcp-cloud-run-docker \
#   --project="$PROJECT_ID" \
#   --location="$REGION" \
#   --member="serviceAccount:github-wif3@$PROJECT_ID.iam.gserviceaccount.com" \
#   --role="roles/artifactregistry.writer"

# gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT_EMAIL}" \
#   --project="$PROJECT_ID" \
#   --role="roles/iam.workloadIdentityUser" \
#   --member="principalSet://iam.googleapis.com/projects/$(gcloud projects describe "$PROJECT_ID" --format='value(projectNumber)')/locations/global/workloadIdentityPools/<POOL_ID>/attribute.repository/<OWNER>/<REPO>"

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#   --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" \
#   --role="roles/run.developer"

# Build and Tag the Image
# Configure Docker authentication
gcloud auth configure-docker us-central1-docker.pkg.dev

# Build the image with a production-ready tag
docker build -t us-central1-docker.pkg.dev/$PROJECT_ID/gcp-cloud-run-docker/gcp-cloud-run-docker:1.0.0 .

# Push the Image
docker push us-central1-docker.pkg.dev/$PROJECT_ID/gcp-cloud-run-docker/gcp-cloud-run-docker:1.0.0

# Deploy to Google Cloud Run
gcloud run deploy gcp-cloud-run-docker \
  --image=us-central1-docker.pkg.dev/$PROJECT_ID/gcp-cloud-run-docker/gcp-cloud-run-docker:1.0.0 \
  --platform=managed \
  --region=us-central1 \
  --allow-unauthenticated



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
