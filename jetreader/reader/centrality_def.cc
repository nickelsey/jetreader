#include "jetreader/reader/centrality_def.h"

namespace jetreader {

CentralityDef &CentralityDef::instance() {
  static CentralityDef instance_;
  return instance_;
}

CentralityDef::CentralityDef() {
  // initialize each centrality definition

  // Run 14 low/mid
  runid_.insert({CentDefId::Run14LowMid, {15076101, 15167014}});
  zdc_range_.insert({CentDefId::Run14LowMid, {0.0, 60000.0}});
  vz_range_.insert({CentDefId::Run14LowMid, {-30.0, 30.0}});
  zdc_norm_.insert({CentDefId::Run14LowMid, 30000.0});
  vz_norm_.insert({CentDefId::Run14LowMid, 0.0});
  zdc_par_.insert({CentDefId::Run14LowMid, {188.392, -0.32269}});
  weight_bound_.insert({CentDefId::Run14LowMid, 400});

  vz_par_.insert({CentDefId::Run14LowMid,
                  {529.123, 0.19706, 0.00433184, -0.000183687, -1.29087e-05,
                   3.82464e-07, -1.70998e-09}});
  weight_pars_.insert({CentDefId::Run14LowMid,
                       {1.34842, -12.8629, 0.767038, 4.2547, -0.00264771,
                        357.779, 5.10897e-06}});
  cent_bounds_.insert({CentDefId::Run14LowMid,
                       {10, 15, 22, 30, 42, 56, 74, 94, 120, 149, 184, 224, 269,
                        321, 381, 450}});
}

} // namespace jetreader