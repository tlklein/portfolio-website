name: Terraform Plan & Apply
on:
  push:
    branches: [ main ]
  pull_request:

permissions:
  id-token: write
  contents: read

jobs:
  tf:
    runs-on: ubuntu-latest
    env:
      AWS_REGION: us-east-2
      TF_IN_AUTOMATION: true

    steps:
      - uses: actions/checkout@v4

      - name: Configure AWS (OIDC)
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::${{ secrets.AWS_ACCOUNT_ID }}:role/TerraformGitHubOIDCRole
          aws-region: ${{ env.AWS_REGION }}

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3

      - name: Init
        working-directory: infra/envs/prod
        run: terraform init -input=false

      - name: Plan
        working-directory: infra/envs/prod
        run: terraform plan -input=false -out=tfplan -var='environment=prod'

      # Optional: require manual approval via PR before apply
      - name: Apply (main only)
        if: github.ref == 'refs/heads/main'
        working-directory: infra/envs/prod
        run: terraform apply -input=false -auto-approve tfplan
