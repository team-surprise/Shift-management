FROM ruby:3.2.0

# Node.js & PostgreSQL client
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
  && apt-get install -y nodejs postgresql-client

# UID/GIDを引数で受け取れるように
ARG UID=1000
ARG GID=1000

# ユーザー作成（UID/GIDをホストと合わせる）
RUN groupadd -g $GID appuser && \
    useradd -m -u $UID -g $GID appuser

WORKDIR /app

# 権限をユーザーに付与
RUN chown appuser:appuser /app

# ユーザー切り替え
USER appuser

# GemfileとGemfile.lockをコピー（初回はGemfile.lockがなくてもOK）
COPY Gemfile Gemfile.lock* ./
RUN bundle install

COPY . .

CMD ["bin/rails", "server", "-b", "0.0.0.0"]

