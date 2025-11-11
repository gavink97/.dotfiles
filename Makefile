.PHONY: alias
alias:
	python3 ansible/files/alias.py

.PHONY: encrypt
encrypt:
	python3 ansible/files/encrypt.py


.PHONY: decrypt
decrypt:
	python3 ansible/files/encrypt.py -d
