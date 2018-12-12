from invoke import task

@task
def init(ctx):
    ctx.run("terraform init -backend-config ./backend.conf")

@task
def test(ctx):
    ctx.run("AWS_PROFILE=default rspec spec")

@task
def plan(ctx):
    cmd = 'terraform plan ' \
          '-var-file=./variables.tfvars'

    ctx.run(cmd)

@task
def apply(ctx):
    cmd = 'terraform apply ' \
          '-auto-approve ' \
          '-var-file=./variables.tfvars'

    ctx.run(cmd)

@task
def destroy(ctx):
    cmd = 'terraform destroy ' \
          '-force ' \
          '-var-file=./variables.tfvars'

    ctx.run(cmd)

@task
def enc(ctx, file='local.env', encoded_file='env.ci'):
    ctx.run("openssl aes-256-cbc -e -in {} -out {} -k $FEEDYARD_CIRCLECI_ENC".format(file, encoded_file))

@task
def dec(ctx, encoded_file='env.ci', file='local.env'):
    ctx.run("openssl aes-256-cbc -d -in {} -out {} -k $FEEDYARD_CIRCLECI_ENC".format(encoded_file, file))
