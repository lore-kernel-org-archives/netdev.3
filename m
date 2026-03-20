Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF312DF6E6
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983160; cv=none; b=O9QZNYQxM5/zSx9s1eWTrjvu3+Gfzk2L/YZKJUK8G0v1y8rafSaMDOKTRqpkz9deH9QCI+Xi05a9gEnJ+PNg5EoAfvuw7obPt4dFBXaDa+VuUSKKxfQnU13OPfD5Ib3YakUdagDoB/+AXvojyQvHwMO6jOWe1i+NHl2LbvOptuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983160; c=relaxed/simple;
	bh=LxEywRrRZkpe4jxH/2u4lRCW8+puW7+zbqXpiIYZ+7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+xjgfJ+XoYYvLMNAuwWJ9ioT40h6cwUFPKAAx2XnAbjRUnrGZZoUst39eBAhXk4M8ocxn1+D2sjFI1Kob5SrjnEb3/A+682nYHX6n6g4qzdOsS9tGWUpiXnR4DUBD0mkNPiG5KmshACaP1wOPjZe6J8Dlj2qJzOppb2kA4d6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSpctJRe; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSpctJRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773983159; x=1805519159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LxEywRrRZkpe4jxH/2u4lRCW8+puW7+zbqXpiIYZ+7k=;
  b=FSpctJReDHQGlGgG/Svkm0Uq3o+GiPG7G4/Hkp0k4PlmqrDMuHn1HbT1
   eamUCwJugI19Y2h7M4c7Yr3intSzOBOCoahHUpvVmSgRfjtvIWPEOP/L2
   qkYfwqgjKB7q0gFK22oCDNJXQK+1abpyXdP2C1sMpop/r5kjnKiT12zSO
   Ge9WPHYcnttbP+IwFDNuwZLNrYL/N+E3x9WpUSnHSYoE2hu2qwm02vd3q
   YP6GrSLfuCzubGIKv50YTX90lBbTHwEwSUWdLqTPXN0ECfYMo9Q13MHnx
   BmAHppklNBzHeyhLLfT4b4CnDQQVbTMrjuRxGUdB03YqpF/fqr+MynUK8
   g==;
X-CSE-ConnectionGUID: EMXglT86RbicTe4edYbbAQ==
X-CSE-MsgGUID: wLky7nTtRPKVzBi1cxqqJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75251822"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75251822"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:05:59 -0700
X-CSE-ConnectionGUID: RJ3+qZZdRzeIErmzfNHdcQ==
X-CSE-MsgGUID: YbQQwoUQRu+C4tpP1NTBhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222399193"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa010.jf.intel.com with ESMTP; 19 Mar 2026 22:05:57 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
Subject: [PATCH iwl-next] ice: use ice_fill_eth_hdr() in ice_fill_sw_rule()
Date: Fri, 20 Mar 2026 06:05:56 +0100
Message-ID: <20260320050556.422762-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@intel.com>

Use the already existing helper function to fill Ethernet header. Also
replace sizeof with a (also existing) macro to reduce the number of
variables.

Suggested-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index bb0f990..6496534 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2612,7 +2612,6 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
 	u16 vlan_id = ICE_MAX_VLAN_ID + 1;
 	u16 vlan_tpid = ETH_P_8021Q;
 	void *daddr = NULL;
-	u16 eth_hdr_sz;
 	u8 *eth_hdr;
 	u32 act = 0;
 	__be16 *off;
@@ -2625,11 +2624,10 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
 		return;
 	}
 
-	eth_hdr_sz = sizeof(dummy_eth_header);
 	eth_hdr = s_rule->hdr_data;
 
 	/* initialize the ether header with a dummy header */
-	memcpy(eth_hdr, dummy_eth_header, eth_hdr_sz);
+	ice_fill_eth_hdr(eth_hdr);
 	ice_fill_sw_info(hw, f_info);
 
 	switch (f_info->fltr_act) {
@@ -2730,7 +2728,7 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
 
 	/* Create the switch rule with the final dummy Ethernet header */
 	if (opc != ice_aqc_opc_update_sw_rules)
-		s_rule->hdr_len = cpu_to_le16(eth_hdr_sz);
+		s_rule->hdr_len = cpu_to_le16(DUMMY_ETH_HDR_LEN);
 }
 
 /**
-- 
2.52.0

