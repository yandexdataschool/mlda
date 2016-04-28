FROM jupyter/minimal-notebook:

COPY environment.yml /work/
RUN conda env update -f /work/environment.yml