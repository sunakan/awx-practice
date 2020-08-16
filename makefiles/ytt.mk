################################################################################
# 変数
################################################################################
SYSTEM_INFORMATION := $(shell uname | tr '[:upper:]' '[:lower:]')
YTT_VERSION        := v0.30.0
YTT_DARWIN_SHA256  := a1a56c3292e355b9891b2c4ce7525d78f0e1ffd8630b856d300e9a7f383e707c
YTT_LINUX_SHA256   := 456e58c70aef5cd4946d29ed106c2b2acbb4d0d5e99129e526ecb4a859a36145
YTT_SHA256         := $(shell bash -c 'if [ "$(SYSTEM_INFORMATION)" == "linux" ]; then echo $(YTT_LINUX_SHA256); else echo $(YTT_DARWIN_SHA256); fi')
YTT_URL            := https://github.com/k14s/ytt/releases/download/$(YTT_VERSION)/ytt-$(SYSTEM_INFORMATION)-amd64

################################################################################
# タスク
################################################################################
.PHONY: install-ytt
install-ytt:
	( command -v ./ytt ) \
	|| curl --location -o ytt $(YTT_URL)
	chmod +x ./ytt

.PHONY: check-sum-ytt
check-sum-ytt:
	echo '$(YTT_SHA256)  ytt' | shasum --algorithm 256 --check -

.PHONY: setup-ytt
setup-ytt: ## yttのインストール
	@make --no-print-directory install-ytt
	@make --no-print-directory check-sum-ytt
	./ytt --version

.PHONY: uninstall-ytt
uninstall-ytt: ## yttのアンインストール
	command -v ./ytt && rm ./ytt
