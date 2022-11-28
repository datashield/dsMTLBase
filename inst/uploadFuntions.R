library("opalr")

options(opal.opts=list(ssl.verifypeer=0, ssl.verifyhost=0))
opals=c(opal.login(url = "http://xxx.xxx.xxx.xxx:8080/", user = "xxx", password = "xxx"),
        opal.login(url = "http://xxx.xxx.xxx.xxx:8080/", user = "xxx", password = "xxx"))
####
#note: set func=null. 
####
#calculate variables' updates per iterations 
dsadmin.set_method(opal = opals, name = "LS_iter_updateDS", func=NULL, path = "./R/LS_iter_updateDS.R", type = "aggregate")
dsadmin.set_method(opal = opals, name = "LR_iter_updateDS", func=NULL, path = "./R/LR_iter_updateDS.R", type = "aggregate")
dsadmin.set_method(opal = opals, name = "LS_funcVal_evalDS", func=NULL, path = "./R/LS_funcVal_evalDS.R", type = "aggregate") 
dsadmin.set_method(opal = opals, name = "LR_funcVal_evalDS", func=NULL, path = "./R/LR_funcVal_evalDS.R", type = "aggregate") 
dsadmin.set_method(opal = opals, name = "updateHDS", func=NULL, path = "./R/updateHDS.R", type = "aggregate") #for inmf
dsadmin.set_method(opal = opals, name = "updateOtherMatsDS", func=NULL, path = "./R/updateOtherMatsDS.R", type = "assign") #for inmf

#initialize the matrix
dsadmin.set_method(opal = opals, name = "addInterceptDS", func=NULL, path = "./R/addInterceptDS.R", type = "assign") # for lasso and mtl
dsadmin.set_method(opal = opals, name = "initMatricesDS", func=NULL, path = "./R/initMatricesDS.R", type = "assign") # for inmf
dsadmin.set_method(opal = opals, name = "initRanMatsWithSeedsDS", func=NULL, path = "./R/initRanMatsWithSeedsDS.R", type = "assign") #inmf


#calculate mean squared error and miss classification rate
dsadmin.set_method(opal = opals, name = "calcMSEDS", func=NULL, path = "./R/calcMSEDS.R", type = "aggregate")
dsadmin.set_method(opal = opals, name = "calcMCRDS", func=NULL, path = "./R/calcMCRDS.R", type = "aggregate")


#matrix calculate t(X)%*%Y 
dsadmin.set_method(opal = opals, name = "xtyDS", func=NULL, path = "./R/xtyDS.R", type = "aggregate")

#get/set my data with key
dsadmin.set_method(opal = opals, name = "getMyServerDataDS", func=NULL, path = "./R/getMyServerDataDS.R", type = "aggregate") 
dsadmin.set_method(opal = opals, name = "setMyServerDataDS", func=NULL, path = "./R/setMyServerDataDS.R", type = "assign") 
dsadmin.set_method(opal = opals, name = "subsetSubjestsDS", func=NULL, path = "./R/subsetSubjestsDS.R", type = "assign") 



opal.logout(opals)
