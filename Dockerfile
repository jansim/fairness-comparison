FROM ubuntu:16.04

# Install python 3.6
RUN apt-get update
RUN apt-get install -y build-essential git libreadline-dev zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev curl
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
RUN echo 'export PATH="/root/.pyenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
# Since we're not by default running in bash, we have to use . instead of source
RUN . ~/.bashrc
RUN pyenv install 3.6.0
RUN pyenv global 3.6

# Install dependencies
RUN apt-get install -y \
    gfortran \
    libopenblas-dev \
    liblapack-dev

# Download code (to get requirements.txt)
RUN git clone --depth 1 https://github.com/algofairness/fairness-comparison.git
RUN cd fairness-comparison

# Install Python dependencies
RUN pip3 install numpy==1.14.0
RUN pip3 install scipy==0.19.0

# Install dependencies for matplotlib
RUN apt-get install -y libpng-dev libfreetype6 libfreetype6-dev pkg-config
RUN pip3 install packaging
RUN pip3 install tornado
RUN pip3 install matplotlib==2.0.0

RUN pip3 install pandas==0.21.1
RUN pip3 install statsmodels==0.8.0

RUN pip3 install cycler==0.10.0
RUN pip3 install decorator==4.0.11
RUN pip3 install networkx==1.11
RUN pip3 install pyparsing==2.1.4
RUN pip3 install python-dateutil==2.6.0
RUN pip3 install pytz
RUN pip3 install scikit-learn==0.18.1
RUN pip3 install six==1.10.0
RUN pip3 install wheel==0.29.0
RUN pip3 install fire==0.1.1
RUN pip3 install BlackBoxAuditing>=0.1.26
RUN pip3 install pip==9.0.1

RUN pip3 install -r requirements.txt

RUN printf "from fairness.benchmark import run\nrun()" > test-run.py

CMD [ "bash" ]
