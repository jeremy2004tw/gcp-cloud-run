gcloud auth list

gcloud auth application-default login

# Enable Cloud Run and Artifact Registry APIs
gcloud services enable run.googleapis.com
gcloud services enable artifactregistry.googleapis.com

gcloud run services add-iam-policy-binding gcp-cloud-run \
    --member="allUsers" \
    --role="roles/run.invoker" \
    --region=us-central1

# Enable IAM Service Account Credentials API
gcloud services enable iamcredentials.googleapis.com

# Configure Workload Identity Federation (OIDC)
gcloud iam workload-identity-pools create github-pool \
--location=global \
--display-name="GitHub Pool"

gcloud iam workload-identity-pools providers create-oidc github-provider \
--workload-identity-pool=github-pool \
--display-name="GitHub Provider" \
--issuer-uri="https://token.actions.githubusercontent.com"

# Store IDs in GitHub Secrets
# GCP_PROJECT_ID
# GCP_WORKLOAD_IDENTITY_PROVIDER
# GCP_SERVICE_ACCOUNT
