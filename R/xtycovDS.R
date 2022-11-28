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



#Modification by Augusto Anguita-Ruiz.
#Version: 05.07.2022
#Detail: Adding functionality of adjusting for confounders in lasso regression.



################################################################################
#' @title Estimation of lambda max
#' @description Lambda max corresponds to the lambda for which all beta are equal to 0, except for covariate betas, which fully vary
#' @param x One matrix for multiplication   
#' @param y The other matrix for multiplication    
#' @param covar Positions corresponding to adjusting covariates in the X dataset
#' @param betaCov estimated beta coefficients from a linear model including only covariates as predictors
#' @return The result matrix
#' @details This was used to estimate the maximum  \eqn{\lambda}

#' @export  
#' @author Han Cao & Augusto Anguita-Ruiz
################################################################################


xtycovDS = function(x, y, covar, type, betaCov){

if (type=="regress") {

betaCov <-  as.numeric(unlist(strsplit(betaCov, split=",")))
  covar <- as.numeric(unlist(strsplit(covar, split=",")))
  x <- eval(parse(text=x), envir = parent.frame())
  y <- eval(parse(text=y), envir = parent.frame())
  
  return(abs(base::t(x)%*%y - t(x)%*%x[, covar]%*%betaCov))
  
}else if (type=="classify") {

betaCov <-  as.numeric(unlist(strsplit(betaCov, split=",")))
  covar <- as.numeric(unlist(strsplit(covar, split=",")))
  x <- eval(parse(text=x), envir = parent.frame())
  y <- eval(parse(text=y), envir = parent.frame())
  
  return(abs(t(x) %*% (y/(exp(x[, covar]%*%betaCov * y) + 1))))
  
}else{ 

print("Error: Please, specify a valid type argument (regression(=regress) or classification(=classify)).") 
  break;
  
  }

 
  
}

