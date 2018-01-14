# OpenCV開発環境

## 概要

Ubuntu, Anaconda(for pyenv)でOpenCV開発環境。
OpenCVはひとまず3.2を使ってます.

anaconda環境は自前のイメージを利用しています

## 使い方

### Dockerfileからビルド

```bash
$ git clone https://github.com/ukyoda/opencv_for_docker.git
$ cd ubuntu_pyenv
$ docker build -t {タグ名} .
```

### Dockerhubからpull

```bash
$ docker pull ukyoda/opencv_for_docker
```

## バージョン情報

工事中...
