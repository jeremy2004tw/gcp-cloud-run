
# Enable IAM Service Account Credentials API
gcloud services enable iamcredentials.googleapis.com

# Create Workload Identity Pool
gcloud iam workload-identity-pools create github-pool3 \
  --location="global" \
  --display-name="github-pool3"

# Create Workload Identity Provider for GitHub Actions with attribute mapping and condition
gcloud iam workload-identity-pools providers create-oidc github-provider3 \
  --location="global" \
  --workload-identity-pool="github-pool3" \
  --display-name="github-provider3" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
  --attribute-condition="assertion.repository == 'jeremy2004tw/gcp-cloud-run'" \
  --issuer-uri="https://token.actions.githubusercontent.com"

# Create Service Account for GitHub Actions to impersonate
gcloud iam service-accounts create github-wif3 \
  --display-name="github-wif3"

# To deploy Cloud Run from source using GitHub Actions, your service account primarily requires the following roles:
# Cloud Run Admin
# Service Account User
# Artifact Registry Writer
# Cloud Build Editor
# Workload Identity User
# Storage Admin
for role in \
  roles/run.admin \
  roles/iam.serviceAccountUser \
  roles/artifactregistry.writer \
  roles/cloudbuild.builds.editor \
  roles/storage.admin; do
  gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-wif3@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="$role"
done

# Create binding between the service account and the workload identity provider:
gcloud iam service-accounts add-iam-policy-binding "github-wif3@$PROJECT_ID.iam.gserviceaccount.com" \
  --project="$PROJECT_ID" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/github-pool3/attribute.repository/jeremy2004tw/gcp-cloud-run"

# Store IDs in GitHub Secrets
# PROJECT_ID
# terraform-demo-504200

# WIF_PROVIDER
# projects/79495184008/locations/global/workloadIdentityPools/github-pool3/providers/github-provider3

# SA_EMAIL
# github-wif3@terraform-demo-504200.iam.gserviceaccount.com
