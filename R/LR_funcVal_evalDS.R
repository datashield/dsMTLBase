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
#' @title Access the function value of logistic loss
#' @description Calculate the function value of logistic loss of a given point
#' @param w  The current estimate of coefficient vector
#' @param x  The design matrix    
#' @param y  The binary label vector ({1,-1} vector)

#' @return The logistic loss value 
#' @details w was received from the client to apply on the server data pairs {x, y} and calculate the logistic loss value.

#' @export  
#' @author Han Cao
################################################################################



LR_funcVal_evalDS <- function (w, x, y){
  w <- as.numeric(unlist(strsplit(w, split=",")))
  x <- eval(parse(text=x), envir = parent.frame())
  y <- eval(parse(text=y), envir = parent.frame())
  l <- - y*(x %*% w)
  lp <- l
  lp[lp<0] <- 0
  return(mean( log( exp(-lp) +  exp(l-lp) ) + lp ))
}