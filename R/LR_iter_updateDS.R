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
#' @title Access the gradient and function value of logistic loss
#' @description Calculate the gradient and  function value of logistic loss of a given point
#' @param w  The current estimate of coefficient vector
#' @param x  The design matrix    
#' @param y  The label vector ({1,-1} vector)

#' @return The gradient and  function value of a given point 
#' @details The current estimate of w was sent to target server and applied on {x,y}.

#' @export  
#' @author Han Cao
################################################################################



LR_iter_updateDS <- function( w, x, y){
  w <- as.numeric(unlist(strsplit(w, split=",")))
  x <- eval(parse(text=x), envir = parent.frame())
  y <- eval(parse(text=y), envir = parent.frame())
  l <- -y*(x %*% w) 
  lp <- l
  lp[lp<0] <- 0
  funcVal <- mean( log( exp(-lp) +  exp(l-lp) ) + lp )
  b <- -y*(1 - 1/ (1+exp(l)))
  grad_w <- t(x) %*% b/length(y)
  
  ###############Caution: After this option was enabled, the gradient was rejected to return when the coefficient
  ###############         vecter contained more non-zero values than the number of subject size.This would improve 
  ###############         the security level of the model. However, if such "rejection" happen, the client side would crash.
  ###############         Therefore, when the server administrator enabled this feature, please select a large enough lambda 
  ###############         in the client side
  #if (sum(w!=0)>nrow(x)) grad_w="the number of coefficients larger than the number of subjects"
  return(list(grad_w, funcVal))
}