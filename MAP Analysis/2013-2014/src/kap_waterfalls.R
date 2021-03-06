# Script to get Winter Data 

require(ProjectTemplate)
load.project()
# Fall - Winter ####
info(logger, "Prepping F13-W14 data")
FW.dt<-PrepMAP(map.F13W14, season1="Fall13", season2="Winter14")

info(logger, "Print KAP Waterfall PDFs by grade.")
pdf_waterfall(FW.dt, school="KAP", season1="Fall13", season2="Winter14", alpha=.6)

info(logger, "Print KAP Waterfall PDFs by class.")
pdf_waterfall(FW.dt, school="KAP", .by="class", season1="Fall13", season2="Winter14", alpha=.6)


# Fall - Spring ####
info(logger, "Prepping F13-S14 data")

FS.dt<-PrepMAP(map.F13W14, season1="Fall13", season2="Spring14")

info(logger, "Print KAP Waterfall PDFs by grade.")
pdf_waterfall(FS.dt, school="KAP", season1="Fall13", season2="Spring14", alpha=.6)

info(logger, "Print KAP Waterfall PDFs by class.")
pdf_waterfall(FS.dt, school="KAP", .by="class", season1="Fall13", season2="Spring14", alpha=.6)

