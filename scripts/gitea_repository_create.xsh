#!/usr/bin/env xonsh

import os
import json

print('GITEA_URL: {}\nGITEA_REPO_NAME: {}'.format(
    $GITEA_URL,
    $GITEA_REPO_NAME,
))

if 'GITEA_REPO_KEYS' in os.environ:
    keys = json.loads($GITEA_REPO_KEYS)
    print('GITEA_REPO_KEYS: {}'.format(
        keys
    ))
else:
    keys = []

cmd = !(gitea exists $GITEA_REPO_NAME)

print('\nCreating Gitea repository "{}"...'.format($GITEA_REPO_NAME))

if cmd.returncode == 0:
    print('Gitea repository already exists.')
else:
    cmd = !(gitea new $GITEA_REPO_NAME)
    if cmd.returncode == 0:
        print('Gitea repository created.')
    else:
        print('Failed creating Gitea repository: {}'.format(
            cmd.errors
        ))
        exit

for key in keys:
    print('\nCreating Gitea deploy key "{}"...'.format(key['name']))
    cmd = !(gitea deploy-key $GITEA_REPO_NAME key['name'] key['key'])
    if cmd.returncode == 0:
        print('Gitea deploy key created.')
    else:
        print('Failed creating Gitea deploy key: {}'.format(
            cmd.errors
        ))
        exit

