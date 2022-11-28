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
#' @title matrix multiplication 
#' @description matrix multiplication x * t(y) 
#' @param x One matrix for multiplication   
#' @param y The other matrix for multiplication    

#' @return The result matrix
#' @details This was used to estimate the maximum  \eqn{\lambda}

#' @export  
#' @author Han Cao
################################################################################


xtyDS = function(x, y){

  x <- eval(parse(text=x), envir = parent.frame())
  y <- eval(parse(text=y), envir = parent.frame())
  return(base::t(x) %*% y)
  
}
