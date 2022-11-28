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
#' @title Receive Set data matrix on server
#' @description Receive the data matrix from the valid client
#' @param remoteKey A key(string) created by the server administrator   
#' @param data  The name of the target matrix on the server

#' @return The requested matrix or error message 
#' @details The "Datakey" mechanism allowed the valid client upload the data matrix directly into the memory of the server. The validity 
#' was granted by the server administrator. To achieve this, the administrator generated a key and put the local copy in the dataset 
#' serverDataKey.myKey(project: serverDataKey; table: myKey) where the dataset was created normaly using DataSHIELD. The remote ropy
#' of the key was hand over to the trustworthy analyst. This was determined by the server administrator 

#' @export  
#' @author Han Cao
################################################################################



setMyServerDataDS=function(remoteKey, data){
  localKey<- eval(parse(text="localKey"), envir = parent.frame())
  data <- as.numeric(unlist(strsplit(data, split=",")))
  rData=  NULL
  
  if(as.character(localKey)==remoteKey){
    n=data[1]; data=data[-1]
    rData=matrix(data, nrow=n)
  } else{
    rData="Key not matched"
  }
  return(rData)
}