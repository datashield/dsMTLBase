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
#' @title Update all heterogeneous variables 
#' @description Update the heterogeneous variables for method dsMTL_iNMF 
#' @param X The name of the data matrix   
#' @param newH The aggregated estimate of shared component H   
#' @param W The current estimate of heterogeneous component W
#' @param Hv The current estimate of heterogeneous component Hv 
#' @param Sp, The hyper-parameter for controlling the sparsity   
#' @param lamb The hyper-parameter for balancing the amount of homogeneous and heterogeneous information   

#' @return The updated heterogeneous variables for eacg server
#' @details The function was performed when the server received the aggregated H, the server would update all variables in the server

#' @export  
#' @author Han Cao
################################################################################


updateOtherMatsDS=function(X, newH, W, Hv, lamb, Sp){
  H <-  as.numeric(unlist(strsplit(newH, split=",")))
  X <- eval(parse(text=X), envir = parent.frame())   
  W <- eval(parse(text=W), envir = parent.frame())   
  Hv <- eval(parse(text=Hv), envir = parent.frame())   
  lamb = as.numeric(lamb)
  Sp = as.numeric(Sp)
  
  H=matrix(H, nrow=nrow(X))
  
  HHt = H + Hv 
  HvtHv = t(Hv) %*% Hv  
  
  newW = (t(HHt) %*% X) / ( (t(HHt) %*% HHt + lamb*HvtHv) %*% W + Sp) * W
  newW[is.nan(newW)]=0
  
  W=newW
  WWt = W %*% t(W)
  newHv= (X %*% t(W)) / ( (H + (1+lamb) * Hv) %*% WWt) * Hv
  newHv[is.nan(newHv)]=0
  
  Vars=list(H=H, W=newW, Hv=newHv)
  
  return(Vars)
}