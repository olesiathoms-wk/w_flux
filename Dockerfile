FROM drydock-prod.workiva.net/workiva/smithy-runner-generator:355624 as build

# Build Environment Vars
ARG BUILD_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG GIT_COMMIT
ARG GIT_BRANCH
ARG GIT_TAG
ARG GIT_COMMIT_RANGE
ARG GIT_HEAD_URL
ARG GIT_MERGE_HEAD
ARG GIT_MERGE_BRANCH
WORKDIR /build/
ADD . /build/
RUN echo "Starting the script sections" && \
		pub get --packages-dir && \
		xvfb-run -s '-screen 0 1024x768x24' pub run dart_dev test --web-compiler=dartdevc -p chrome -p vm && \
		echo "Script sections completed"
ARG BUILD_ARTIFACTS_BUILD=/build/pubspec.lock
FROM scratch