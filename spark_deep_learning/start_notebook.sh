BigDL_HOME="/environments/general_env/lib/python3.5/site-packages/bigdl"
BIGDL_VERSION="0.3.0"
#SPARK_HOME="/usr/local/share/spark"
MASTER="local[*]"
PYTHON_API_ZIP_PATH=${BigDL_HOME}/share/lib/bigdl-${BIGDL_VERSION}-python-api.zip
BigDL_JAR_PATH=${BigDL_HOME}/share/lib/bigdl-${BIGDL_VERSION}-jar-with-dependencies.jar

export PYTHONPATH=${PYTHON_API_ZIP_PATH}:$PYTHONPATH
export PYSPARK_DRIVER_PYTHON="/environments/general_env/bin/jupyter"

export PYSPARK_PYTHON="/environments/general_env/bin/python"

export PYSPARK_DRIVER_PYTHON_OPTS="notebook --notebook-dir=./  --ip=0.0.0.0 --port=8080 --no-browser --allow-root"
   
${SPARK_HOME}/bin/pyspark \
   --master ${MASTER} \
   --properties-file ${BigDL_HOME}/share/conf/spark-bigdl.conf \
   --driver-cores 5  \
   --driver-memory 10g  \
   --total-executor-cores 8  \
   --executor-cores 1  \
   --executor-memory 20g \
   --py-files ${PYTHON_API_ZIP_PATH} \
   --jars ${BigDL_JAR_PATH} \
   --conf spark.driver.extraClassPath=${BigDL_JAR_PATH} \
   --conf spark.executor.extraClassPath=${BigDL_JAR_PATH}
