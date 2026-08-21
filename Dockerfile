# Use a current patched Python runtime image to reduce known OS package vulnerabilities
FROM python:3.13-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the application's code to the working directory first for easy debugging
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Run main.py when the container launches
CMD ["python", "main.py"]
