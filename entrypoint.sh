#!/bin/sh

# Use exec to replace the shell with the Flask process
# This ensures that Flask receives any signals sent to the shell
exec flask run -h 0.0.0.0 -p $PORT
