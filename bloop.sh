#!/bin/bash
rclone copy 1:brave/bdata1/ /.config/BraveSoftware -P; rclone copy /.config/BraveSoftware 1:brave/bdata1/ -P 
