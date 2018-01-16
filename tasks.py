from invoke import task

@task
def init(ctx):
    ctx.run("terraform init -backend-config $CIRCLE_WORKING_DIRECTORY/backend.conf")

@task
def test(ctx):
    ctx.run("AWS_PROFILE=default rspec spec")

@task
def plan(ctx):
    cmd = 'terraform plan ' \
          '-var profile_account_id=$profile_account_id ' \
          '-var profile_access_key=$profile_access_key ' \
          '-var profile_secret_key=$profile_secret_key ' \
          '-var profile_region=$profile_region'

    ctx.run("echo $profile_region")
    ctx.run(cmd)

@task
def apply(ctx):
    cmd = 'terraform apply ' \
          '-auto-approve ' \
          '-var profile_account_id=$profile_account_id ' \
          '-var profile_access_key=$profile_access_key ' \
          '-var profile_secret_key=$profile_secret_key ' \
          '-var profile_region=$profile_region'

    ctx.run(cmd)

@task
def destroy(ctx):
    cmd = 'terraform destroy ' \
          '-var profile_account_id=$profile_account_id ' \
          '-var profile_access_key=$profile_access_key ' \
          '-var profile_secret_key=$profile_secret_key ' \
          '-var profile_region=$profile_region -force'

    ctx.run(cmd)

@task
def enc(ctx, keyfile):
    ctx.run("openssl aes-256-cbc -e -in {} -out env.ci -k $KEY".format(keyfile))

@task
def dec(ctx):
    ctx.run("openssl aes-256-cbc -d -in env.ci -out env -k $KEY")
