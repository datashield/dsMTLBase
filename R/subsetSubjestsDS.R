################################################################################
#
# Package Name: dsMTLBase
# Description: The server-side functions of dsMTL
#
# dsMTL - a computational framework for privacy-preserving, distributed 
#   multi-task machine learning
# Copyright (C) 2021  Han Cao (han.cao@zi-mannheim.de)
# All rights reserved.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
################################################################################







################################################################################
#' @title Subset subjects given index
#' @description Subset subjects for cross-validation
#' @param symbol The name of the design matrix   
#' @param idx  The index of the selected subjects

#' @return The subset of the design matrix
#' @details In the k-fold in-site cross-validation, the sample in each server was randomly divided into k fold. The idx was to subset the
#' design matrix into the training or test sample in each of k fold cross-validation  

#' @export  
#' @author Han Cao
################################################################################

subsetSubjestsDS=function(symbol, idx){
  symbol<- eval(parse(text=symbol), envir = parent.frame())
  idx <- as.integer(unlist(strsplit(idx, split=",")))
  rData=  symbol[idx, , drop=F]
  return(rData)
}

