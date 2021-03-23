npm run build
aws s3 sync dist s3://sso-demo.testnet.verida.io --profile verida-testnet --delete
aws cloudfront create-invalidation --distribution-id E1XXF6OW52EPIJ --profile verida-testnet --paths "/*"
