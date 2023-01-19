FROM rust as builder
RUN rustup toolchain add nightly
RUN rustup default nightly
RUN cargo +nightly install -f cargo-fuzz

ADD . /TinyTemplate
WORKDIR /TinyTemplate/fuzz

RUN cargo fuzz build render_template

# Package Stage
FROM ubuntu:20.04

COPY --from=builder /TinyTemplate/fuzz/target/x86_64-unknown-linux-gnu/release/render_template /
