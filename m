Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E03F4DD0
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965761; cv=none; b=KGPhG4sbd9yhiyboveWciUnUda4mhtUu5v/0FkCoE073Megs0a0jXCtoa6NunGWP4eq86Im3UCKD3WL/Z5ixek7EkJ8fzYC5FrNc5mJHMtICKF/r5ezH4UielLBdSBqfNYsAN7iAsQ+3YLVIvccZozLHUDTGVUar/vuvRwg4Gw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965761; c=relaxed/simple;
	bh=1jeofeOcIlSqrtgIJ5r5carB/17a4FMnpSTsXzeUI7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Axx4ioY1rjGCdnafB0cxlSo/LixvFL8Y+8pZeEzdw/o9kaz9WArGSOZEz+OeIawuPtuSpHX83HnlJwMUsFZZ5frMLkYcDin7LPrVY0ZXlmvXFmhbyOXoJ0jXybRqExBquSYPrfjaTDbQk/4gbqFP1UOari4307orq35BxvHNCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUOJ/6jb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUOJ/6jb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965754; x=1817501754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1jeofeOcIlSqrtgIJ5r5carB/17a4FMnpSTsXzeUI7k=;
  b=IUOJ/6jbB2tKL7iI782EK1JansMUWU1YjReM04MYZZRkpWDJRDD91bHZ
   J+pNwmEixS80CQpQtqaMa8FnaWqWR4tOP8t/vzComiSITEKgxPeXFPzMH
   vx0ODxBrc1UhGsZ74OeqTXjA+q4Ndh+8JiSMfKctLKTWlAjow6liI1cEL
   0JJZgmPCPEXBidESLiRUCSRFLPZNvTut0yYNLV06eT6Vczw5Ps2o9K1hf
   asRSaCzgF9B8CNa/cCs00q97Ef+kDNXDk/E5NLoHPQUbOEFBSxSwWgUqY
   teqijhtqm4+AOhpW3GttgxYnisKFWPTQjPSYyVpdgfm4KWcTIZsPVNBL9
   Q==;
X-CSE-ConnectionGUID: Jtcfhy8hRgeky0B2nkrAOw==
X-CSE-MsgGUID: YjVX0iw5QfGifHh0WGSSqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343562"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343562"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:50 -0700
X-CSE-ConnectionGUID: nloxVO3gQQqhE6FapgBfLg==
X-CSE-MsgGUID: LKrtOfJwTYqzWQQF4GbD+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576111"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 07/15] ice: use ice_fill_eth_hdr() in ice_fill_sw_rule()
Date: Wed,  5 Aug 2026 14:35:32 -0700
Message-ID: <20260805213541.2281287-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
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

