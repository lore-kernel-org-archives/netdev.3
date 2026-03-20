Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F32DC357
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983144; cv=none; b=ksRfRGGsnfnEKP1mm0nYujhfU0TrpVEpQL7Y8FIhCljyaFQTXBZwNckKbZCu7oIGA+cqN6+mNI78J1rwIzsZcQQJEqkuCvNgdwUQZzd6M+E21c7/RN0LlmWR5gJAC7j0yEQb+jql1/QubODId07h60jRNjp2piKdmfi1M35OHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983144; c=relaxed/simple;
	bh=iFNr/Ozkk9eyLzFtKdItjdVVoPA6I8UzXs9nhcOrgwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=on3g7fKj9MmOfj+C9ZgPPHQrbNVV2t50VCJ2BPy1FycxrO6AOxlEXhkB0+sN2mYrBRxwHz+ezw4jbCNh7UkOjFwdqT//T1aX491TWsgY1KQ72HW0w1QdVbPT3mYKlkuaBSZ7VgMdThxcXUsFR6ZYmi0kmlweJJOMMC9Y4nxIJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0py6cFL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0py6cFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773983144; x=1805519144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iFNr/Ozkk9eyLzFtKdItjdVVoPA6I8UzXs9nhcOrgwU=;
  b=i0py6cFLEoyUIw00duqXrAK94TTohAcUOQtec0yr9+OaTmGYhDms93cu
   ABV85VTk83e8WzADZPwrc07C6JQn9A9wdUsqO6MpwRgZ3LMLluEaid2zg
   XQgE2UvD8sf4AzbR+n4DDuHWzQMvPOmhmNjp5+AZEOfqJFWpzmNcwvz2P
   aXmkFpa4bCMoOdzNWQ0ZL0KXtBGBhuGdzxSvMyXtihue8azc4r+XePjwX
   laemy3QWFFQNNDU6NBY/rlPyTHTwxyBxwWtjRJqH2g/lFlPu3ud4X0geg
   sjIjY1XhWKMGyCvsHboe8zllmphqE68iGXqz1Tl/HeKZ7Cm6MysVVPrpQ
   Q==;
X-CSE-ConnectionGUID: In41rVuJS2GHDmD4Tm1KjA==
X-CSE-MsgGUID: qfA14emkR6WVWvfQh6JBow==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522747"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100522747"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:05:43 -0700
X-CSE-ConnectionGUID: a7IlZjjPTcOIrFw199eP1Q==
X-CSE-MsgGUID: s4TtrwfrRQGHeu9tjLl9qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227307328"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:42 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: [PATCH iwl-next] ice: init desired_dcbx_cfg in default DCB config
Date: Fri, 20 Mar 2026 06:05:41 +0100
Message-ID: <20260320050541.422592-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

When DCBX is disabled in firmware the driver falls back to software LLDP
mode and applies a default DCB configuration via ice_dcb_sw_dflt_cfg().
This function properly initializes local_dcbx_cfg with valid parameters
including etscfg.maxtcs from hardware capabilities. However,
desired_dcbx_cfg was never initialized in this path.

All DCB netlink functions (ice_dcbnl_setpfc, ice_dcbnl_setets, etc.)
use desired_dcbx_cfg as the base configuration for user-requested changes.
When desired_dcbx_cfg remains uninitialized with etscfg.maxtcs=0, the
firmware rejects the configuration for 4+ port NICs, causing DCB
configuration commands to fail.

It is not a problem for 1 or 2 port NICs where we support 8 TCs - in
that case FW accepts maxtc=0, treating it as 8.

Fix it by copying local_dcbx_cfg (which was freshly initialized) into
desired_dcbx_cfg after the default config is applied.

Fixes: b94b013eb626 ("ice: Implement DCBNL support")
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bd77f1c..060744c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -669,6 +669,9 @@ int ice_dcb_sw_dflt_cfg(struct ice_pf *pf, bool ets_willing, bool locked)
 	if (ret)
 		return ret;
 
+	/* init desired_dcbx_cfg from local_dcbx_cfg */
+	pi->qos_cfg.desired_dcbx_cfg = pi->qos_cfg.local_dcbx_cfg;
+
 	return ice_query_port_ets(pi, &buf, sizeof(buf), NULL);
 }
 
-- 
2.52.0
