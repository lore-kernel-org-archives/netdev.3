Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6757C726
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721728; cv=none; b=slCMXjpQUuzwvgDwNXubOPcNhD9xCSExVTsbbJRxog6Mn+/7Llp8QxpuQgUYVEvoIN+E+qIOt866j6hKPfdc3gyIWrUX3T7N8bi8wvAO+/V7cuMut3+Ka94LC8clf5Eitd2LH452DCcgy8Fl6WiAQoyFDZN4sqlAVVRTTyIaycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721728; c=relaxed/simple;
	bh=1jeofeOcIlSqrtgIJ5r5carB/17a4FMnpSTsXzeUI7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPK8RurQvtx0c62YQydXFyFaV1uyVh17KfcznB4TFVTk1ULiVFp8wkQ+nmePsjNseJ48Sp8dAUxa74G2wpYx7v2r/0a6J9BtJhgfYYSGA1zfXqIuJ+NsnYoLE+qkEay8T9Uwxp7EwPZMRlMRUY3zzkhCqdOC3kBCllNKN0utIA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWVr1nKR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWVr1nKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721725; x=1822257725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1jeofeOcIlSqrtgIJ5r5carB/17a4FMnpSTsXzeUI7k=;
  b=eWVr1nKRUotwkBUJs4foB1RYac+WASIsPG++6sofXYyDS8Z/6PXsK/sl
   aNQDwCv8Ku3FlqUudu/E4OZv1Jhq+75qnS+hkqi7THf1gKxmqvcXKzr3G
   Dt2HEei/l1pc2y10G44wpADZdZ4qFQa+tLHnr1zOHKyu+CLPyUmra2Y8Z
   VGCJnCfqynlbutNZmDzZbw0dkRrcV0HGA0dBgvLIpw/W83gPWRLpBPO9J
   Cg7eD6a1rUTgeeR4p8xNbNXzuTXKoF0ZRQAE31TgQb8xKOvougu506aW2
   nL4jo/Qt8lkIlmB3YOLeGcQesJLz9MvXjUDpawP5TKBmPhihf1PQRSTbf
   Q==;
X-CSE-ConnectionGUID: ct3BeLUeRLSzjn//9G1Rtg==
X-CSE-MsgGUID: RNn+0aSHQ52vOZZ1TsF6fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91548857"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91548857"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:42:01 -0700
X-CSE-ConnectionGUID: /aAk9UKpQQ2Zat+b7oF8OQ==
X-CSE-MsgGUID: 2K0l4enGQSKPpUiLqFz1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313452300"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2026 15:42:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@intel.com>,
	anthony.l.nguyen@intel.com,
	grzegorz.nitka@intel.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	xiongwm2026@163.com,
	ynorov@nvidia.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 02/10] ice: use ice_fill_eth_hdr() in ice_fill_sw_rule()
Date: Tue, 29 Sep 2026 15:41:42 -0700
Message-ID: <20260929224153.1455466-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 6a5875bd9c6b..4daee252e2a6 100644
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
2.47.1

