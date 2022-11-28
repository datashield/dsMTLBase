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
#' @title Calculate mean-squared errors (MSE)
#' @description Calculate mean-squared errors (MSE)
#' @param ws The list of coefficient vectors for all servers   
#' @param x  The design matrix on a target server
#' @param y, The response vector on a target server
#' @param average The indicator to average or not the prediction scores over all coefficient vectors

#' @return The MSE of each coefficient vector (or averaged MSE)
#' @details For MTL methods, ws contained the coefficient vectors of all servers. {x, y} referred to the data pairs on the target server.  
#' The function calculated the MSE of {x, y} of the target server using the model ws. If average==TRUE, the averaged predicted probability 
#' was returned.

#' @export  
#' @author Han Cao
################################################################################
calcMSEDS <- function ( ws, x, y, average){
  ws <- as.numeric(unlist(strsplit(ws, split=",")))
  nFeats=ws[1]
  ws=ws[-1]; ws=matrix(ws, nrow=nFeats)
  x <- eval(parse(text=x), envir = parent.frame())
  y <- eval(parse(text=y), envir = parent.frame())
  if(average){
    yhat <- rowMeans(x%*%ws)
    mse=colMeans((yhat -y)^2)
  } else{
    yhat <- x%*%ws
    mse=apply(yhat, 2, function(x)mean((x-y)^2))
  }
  
  return(mse )
}