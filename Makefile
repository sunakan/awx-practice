include makefiles/gitignore.mk
include makefiles/ytt.mk
include makefiles/help.mk

################################################################################
# 変数
################################################################################
TMP_DIR_PREFIX := vagrant-ssh-keys
SSH_COMMAND := $(shell (command -v kyrat) || (command -v sshrc) || (command -v ssh))
ANSIBLE_IP  := 192.168.10.11

################################################################################
# マクロ
################################################################################
# $(1)：秘密鍵の場所
# $(2)：VMマシン名(VirtualBox側の名前)
define ssh-option
-o StrictHostKeyChecking=no \
-o UserKnownHostsFile=/dev/null \
-i $(1)/.vagrant/machines/$(2)/virtualbox/private_key
endef

################################################################################
# タスク
################################################################################
.PHONY: ssh-ansible
ssh-ansible: setup-vagrant-keys
	$(SSH_COMMAND) $(call ssh-option,$(TMP_DIR),ansible) vagrant@$(ANSIBLE_IP)

# Windowsだとsshの秘密鍵の権限がWSLで400にできないため
# Macなら不要だけど、依存しているので動かす
.PHONY: setup-vagrant-keys
setup-vagrant-keys: ## VMの秘密鍵をtmp/以下に持っていき、400にする
	rm -rf /tmp/$(TMP_DIR_PREFIX)*
	$(eval TMP_DIR := $(shell mktemp -d -t $(TMP_DIR_PREFIX)-XXXXX))
	mkdir -p $(TMP_DIR)
	ls .vagrant/machines/*/virtualbox/private_key | xargs -I {key} rsync --relative {key} $(TMP_DIR)/
	chmod 400 $(TMP_DIR)/.vagrant/machines/*/virtualbox/private_key

.PHONY: deploy-docs
deploy-docs: ## ドキュメントをデプロイする
	git subtree push --prefix docs/html/ origin gh-pages
