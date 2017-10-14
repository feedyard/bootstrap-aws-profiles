from invoke import task

@task
def init(ctx):
    ctx.run("terraform init")

@task
def test(ctx):
    ctx.run("rspec")

@task
def plan(ctx):
    cmd = 'terraform plan ' \
           '-var profile_account_id=$profile_account_id ' \
           '-var profile_access_key=$profile_access_key ' \
           '-var profile_secret_key=$profile_secret_key ' \
           '-var profile_region=$profile_region'

    ctx.run(cmd)

@task
def apply(ctx):
    cmd = 'terraform apply ' \
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
          '-var profile_region=$profile_region -f'

    ctx.run(cmd)

@task
def enc(ctx, keyfile):
    ctx.run("openssl aes-256-cbc -e -in {} -out env.ci -k $KEY".format(keyfile))

@task
def dec(ctx):
    ctx.run("openssl aes-256-cbc -d -in env.ci -out env -k $KEY")


    # \
    # '-var sandbox_access_key=$sandbox_access_key ' \
    # '-var sandbox_secret_key=$sandbox_secret_key'