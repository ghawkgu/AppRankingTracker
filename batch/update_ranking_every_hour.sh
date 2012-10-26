#!/usr/bin/env bash

source $HOME/.bash_profile

cd $HOME/workspace/app_ranking_tracker
rvm use 1.9.3@apprankingtracker

rails r batch/load_rankings.rb


