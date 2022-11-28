################################################################################
#
# Package Name: dsMTLBase
# Description: The serverside functions of dsMTL
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
#' @title Set intercept model   
#' @description The option to turn on or off intercept model.   
#' @param x.mat The name of design matrix  
#' @param intercept The indicator to turn on (=TRUE) or off (=FALSE) the intercept model

#' @return The designed matrix
#' @details If intercept==TRUE, the "1" column was attached on the left side of x.mat, the combination was returned. If intercept==FALSE,
#' x.mat was returned. In the linear regression,  \eqn{y=x \beta+b}, the non-intercept model referred to b==0. In this case, the design matrix 
#' and response should be z-standardized. The default was non-intercept model

#' @export  
#' @author Han Cao
################################################################################

addInterceptDS=function(x.mat, intercept=FALSE){
  x.mat <- eval(parse(text=x.mat), envir = parent.frame())
  x.mat=cbind(1,x.mat)
  if (!is.null(colnames(x.mat))){
    colnames(x.mat)[1]="intercept"
  }
  return(x.mat)
}