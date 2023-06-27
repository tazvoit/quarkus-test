FROM registry.access.redhat.com/ubi8/ubi-minimal

# Instala las dependencias necesarias para GraalVM
RUN microdnf install -y gcc glibc-devel zlib-devel

# Copia el archivo JAR de tu aplicación en la imagen
COPY target/my-app.jar /deployments/my-app.jar

# Configura las variables de entorno para GraalVM
ENV GRAALVM_HOME=/opt/graalvm-ce-<VERSION_DE_GRAALVM>
ENV JAVA_HOME=/opt/graalvm-ce-<VERSION_DE_GRAALVM>
ENV PATH=${GRAALVM_HOME}/bin:${PATH}

# Ejecuta la compilación de GraalVM
RUN gu install native-image

# Realiza el build de la aplicación utilizando native-image
RUN native-image --no-server -cp /deployments/my-app.jar -H:Name=/deployments/my-app

# Establece el comando de inicio de la aplicación
CMD ["/deployments/my-app"]
