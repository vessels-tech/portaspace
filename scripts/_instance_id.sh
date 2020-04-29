#!/usr/bin/env bash
make outputs | grep instance_id | sed 's/instance_id = //g'