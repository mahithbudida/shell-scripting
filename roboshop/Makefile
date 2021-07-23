help: ##Print this message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/://' -e 's/##//'
frontend: ## Install Ngnix setup
	@bash frontend.sh
mongodb: ## Install mongodb setup
	@bash mongodb.sh
mysql: ## Install mysql setup
	@bash mysql.sh