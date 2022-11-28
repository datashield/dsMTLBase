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
#' @title Initialize variables with given random seeds
#' @description The initialization of server-side variables for method dsMTL_iNMF
#' @param rank  The rank of data matrix in factorization
#' @param X     The name of the data matrix for factorization    
#' @param seedH  The seed for random initialization of the shared component matrix (H)

#' @return The initialized variable matrices 
#' @details In dsMTL_iNMF, variable matrices were initialized as drawn from the uniform distribution U(0,2). Since the heterogeneous 
#' component variables were updated locally, so only the seed of shared component matrix (H) were synchronized among all servers and client

#' @export  
#' @author Han Cao
################################################################################

initMatricesDS <- function(rank, X, seedH) {
  rank <-  as.numeric(rank)
  X <- eval(parse(text=X), envir = parent.frame())
  
  nowX=nrow(X)
  ncolX=ncol(X)
  
  Vars=list();
  set.seed(seedH)
  Vars$H=matrix(data = stats::runif(n=nowX*rank, min = 0, max = 2), nrow = nowX, ncol = rank)
  Vars$Hv=matrix(data = stats::runif(n=nowX*rank, min = 0, max = 2), nrow = nowX, ncol = rank)
  Vars$W=matrix(data = stats::runif(n=rank*ncolX, min = 0, max = 2), nrow = rank, ncol = ncolX)
  
  
  return(Vars)
}
