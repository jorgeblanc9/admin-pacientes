run:
	git pull && export NVM_DIR="$$HOME/.nvm" && [ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh" && nvm use && npm install &&  npm run dev

quality-gate:
	./quality-gate.sh

test-unit:
	npm run test:unit

test-e2e:
	npm run test:e2e

test-all:
	npm run test:all

test-coverage:
	npm run test:unit:coverage

test-quality:
	npm run test:quality

setup-env:
	./setup-environment.sh

setup-full:
	./setup-environment.sh