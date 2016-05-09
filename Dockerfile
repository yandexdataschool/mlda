FROM jupyter/minimal-notebook

ENV HOME /home/jovyan
VOLUME ["$HOME/work"]
COPY environment.yml /work/
RUN conda env update -f /work/environment.yml -n root && \
	conda create --yes --clone root -n root-py2 && \
	conda remove --yes -n root-py2 conda-env && \
	conda install --yes -n root-py2 python=2.7 && \
	conda clean --yes -a
USER root
RUN /bin/echo -e "export PATH=${CONDA_DIR}/bin:${PATH}\nsource activate root-py2" | tee /etc/profile.d/conda-activate.sh
USER jovyan
CMD ["bash", "--login", "-c", "/usr/local/bin/start-notebook.sh"]