################################################################################
# 変数
################################################################################
IGNORE_OS       := linux,macos,windows
IGNORE_EDITOR   := vim,emacs,intellij+all,visualstudiocode
IGNORE_LANGUAGE := c,c++,rust,python,ruby,rust,go,java,kotlin,node,erlang,elixir,commonlisp,racket
IGNORE_UTIL     := vagrant
IGNORE_LIST     := $(IGNORE_LANGUAGE),$(IGNORE_OS),$(IGNORE_EDITOR),$(IGNORE_UTIL)
GIT_IGNORE_URL  := https://www.toptal.com/developers/gitignore/api/$(IGNORE_LIST)

################################################################################
# タスク
################################################################################
.gitignore:
	curl --output .gitignore $(GIT_IGNORE_URL)

.PHONY: setup-gitignore
setup-gitignore: .gitignore ## .gitignoreをsetup
	make --no-print-directory add-ytt-for-gitignore

.PHONY: add-ytt-for-gitignore
add-ytt-for-gitignore:
	grep 'ytt' .gitignore || echo 'ytt' >> .gitignore
