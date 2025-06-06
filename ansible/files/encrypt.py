import subprocess as sp
import os
import string
import pathlib
import argparse

HOME = pathlib.Path.home()
VAULT_PASSWORD_FILE = f'{HOME}/.ansible-vault/vault.secret'


def _command_(arg, filepath: string) -> None:
    sp.run([
        'ansible-vault',
        arg,
        '--vault-password-file',
        VAULT_PASSWORD_FILE,
        filepath
    ])


def _check_status(filepath: string) -> bool:
    with open(filepath) as file:
        body = file.read()

    return body.__contains__('ANSIBLE_VAULT')


def _check_error(error: OSError) -> None:
    print('Error: ' + error.strerror)


def _args() -> string:
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "-d",
        "--decrypt",
        action="store_true",
        default=False,
        help="Choose a platform:"
    )

    args = parser.parse_args()

    if (args.decrypt):
        return 'decrypt'

    else:
        return 'encrypt'


def main() -> None:
    _action = _args()
    keys = f'{HOME}/.dotfiles/keys'
    ssh = f'{HOME}/.dotfiles/ssh'

    filepaths = [
        f'{HOME}/.dotfiles/tmux-powerline/config.sh',
    ]

    for dir_path in [keys, ssh]:
        try:
            entries = os.listdir(dir_path)
            for entry in entries:
                full_path = os.path.join(dir_path, entry)

                if os.path.isfile(full_path) and entry != '.DS_Store':
                    filepaths.append(full_path)

        except OSError as e:
            _check_error(e)

    for file in filepaths:
        match f'{_action}-{_check_status(file)}'.lower():
            case 'encrypt-true':
                print(f'Skipping Encrypted File: {file}')

            case 'encrypt-false':
                _command_(_action, file)

            case 'decrypt-true':
                _command_(_action, file)

            case 'decrypt-false':
                print(f'Skipping Decrypted File: {file}')


if __name__ == '__main__':
    main()
