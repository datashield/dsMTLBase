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
#' @title Collect server-side information for updating H 
#' @description Estimate the shared component (H) using the local data for method dsMTL_iNMF 
#' @param X The name of the data matrix   
#' @param H The current estimate of shared component H   
#' @param W The current estimate of heterogeneous component W
#' @param Hv The current estimate of heterogeneous component Hv 
#' @param Sp, The hyper-parameter for controlling the sparsity   
#' @param lamb The hyper-parameter for balancing the amount of homogeneous and heterogeneous information   

#' @return The server-level information for aggregating a new estimate of H
#' @details The function was performed by each server when the client attempted to aggregate information to update H. The local variables of 
#' the server were used to estimate the H. These information will be aggregated on the client. 

#' @export  
#' @author Han Cao
################################################################################



updateHDS <- function(X, H, W, Hv, Sp, lamb) {
  
  X<- eval(parse(text=X), envir = parent.frame())   
  W<- eval(parse(text=W), envir = parent.frame())   
  Hv<- eval(parse(text=Hv), envir = parent.frame())   
  H<- eval(parse(text=H), envir = parent.frame())   
  lamb = as.numeric(lamb)
  Sp = as.numeric(Sp)
  
  X=as.matrix(X)
  updateH1  = (X %*% t(W))*H
  updateH2 = (H + Hv) %*% (W %*% t(W))
  
  Ht = H + Hv

  frob_c = norm(  (X - (Ht %*% W)), type = "F"   )^2
  pen_c = lamb*norm((Hv %*% W), type = "F")^2  
  sparse_c = Sp * sum(abs(W)) 
  
  
  return(list(updateH1, updateH2, frob_c, pen_c, sparse_c))
}