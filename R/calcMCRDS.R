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
#' @title Calculate missing classification rate (MCR)
#' @description Calculate missing classification rate (MCR)
#' @param ws The list of coefficient vectors for all servers   
#' @param x  The design matrix on a target server
#' @param y, The response vector on a target server
#' @param average The indicator to average or not the prediction probability over all coefficient vectors

#' @return The MCR of each coefficient vectors (or averaged MCR)
#' @details For MTL methods, ws contained the coefficient vectors of all servers. {x, y} referred to the data pairs on the target server.  
#' The function calculated the MCR of {x, y} of the target server using the model ws. If average==TRUE, the averaged predicted probability 
#' was returned.

#' @export  
#' @author Han Cao
################################################################################

calcMCRDS <- function ( ws, x, y, average){
  ws <- as.numeric(unlist(strsplit(ws, split=",")))
  nFeats=ws[1]
  ws=ws[-1]; ws=matrix(ws, nrow=nFeats)
  x <- eval(parse(text=x), envir = parent.frame())
  y <- eval(parse(text=y), envir = parent.frame())
  
  if(average){
    yhat <- rowMeans(1/(1+exp(-x%*%ws)))
    yhat=sign(yhat-0.5); yhat[yhat==0]=1
    mcr=mean(yhat!=y)
  } else{
    yhat <- 1/(1+exp(-x%*%ws))
    yhat=sign(yhat-0.5); yhat[yhat==0]=1
    mcr=apply(yhat, 2, function(x)mean(x!=y))
  }
  return(mcr)
}