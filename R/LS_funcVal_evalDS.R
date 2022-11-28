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
#' @title Access the function value of least-square loss
#' @description Calculate the function value of least-square loss of a given point
#' @param w  The current estimate of coefficient vector
#' @param x  The design matrix    
#' @param y  The label vector 

#' @return The function value of a given point 
#' @details The current estimate of w was sent to target server and applied on {x,y}.

#' @export  
#' @author Han Cao
################################################################################

LS_funcVal_evalDS <- function ( w, x, y){
  w <- as.numeric(unlist(strsplit(w, split=",")))
  x <- eval(parse(text=x), envir = parent.frame())
  y <- eval(parse(text=y), envir = parent.frame())
  funcVal <- 0.5*mean((y - x %*% w)^2)
  return(funcVal)
}