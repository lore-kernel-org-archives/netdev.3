Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4433F59B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494873; cv=none; b=eAix1iLY7//kpdP3mXi8+91fAH/l3dDVFME0H+HDKjpjPvRwytP1bII6Lyi0VTxz+yp49ZoIAgM3SvorqGDi4ZT0pTPvGgPVsBcVGa/fjD2vDFS/JF5T3dne9G1baQrZbe489zhtJstsl6CGQ7so91X4ecFAE52vZbVSw/nBOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494873; c=relaxed/simple;
	bh=UbPtj7+MMJp78z/DrECap+upySFOT+Zvd1eyBeVmQvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZyn04/+CsXKWSOIYL/Mn3dV7R2fr1zCP3Dd8XO+cAryCTkmNLhckQtXMURQGzunpxYEiWvTnJMID5NnPNDbtfrJpzj6eoNzvqcCCne/s2psP1jpe1oWjqD7L5f4l72UXNObHNrXJ1wfXAgKeiWbP3b39V+ZyX4d1NutpmWWB08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfqgPuJx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfqgPuJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772494872; x=1804030872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UbPtj7+MMJp78z/DrECap+upySFOT+Zvd1eyBeVmQvY=;
  b=dfqgPuJxbrBclCt+qs/heWgkH0omICcTIrp1yuaLjjaX1ogWlJTUblZA
   Y/JEdAMdq0xFWuvV0cMWl6nIQjWSoXvWZ1Ia+bwMjSOQOqOVbhSuOs+la
   s2XmxZYnNhYIKt53+9r+B0lK+ZJO1JNr0FjF5YVnXVLBhkbYrEsjTlIK3
   rFud1BtfeKXOJST0sS8PpgW02WayufOHtA7Okp50nC1YJaZUyU7krYj4f
   1jID9HvtPCyAryLmx1e4v2/IHCFrsOeXSpSLA56PMGUhuBBmI8UV654Ps
   D7yjtXfiHkE4Y8hYZf1/09rXF+Z6FLuyztkFDdY0wGC7X9iLii163cw9q
   A==;
X-CSE-ConnectionGUID: tzATAOqjRricV4Neaq/r8Q==
X-CSE-MsgGUID: SbouqO3nTEG1j2AJzERR9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73585738"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73585738"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 15:41:09 -0800
X-CSE-ConnectionGUID: qXik7NvBRruyYDLYcwbFaw==
X-CSE-MsgGUID: NWwtP7AmScqatS65qmhdjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="216233669"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 02 Mar 2026 15:41:09 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 2/4] i40e: drop useless bitmap_weight() call in i40e_set_rxfh_fields()
Date: Mon,  2 Mar 2026 15:41:00 -0800
Message-ID: <20260302234105.2658400-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260302234105.2658400-1-anthony.l.nguyen@intel.com>
References: <20260302234105.2658400-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>

bitmap_weight() is O(N) and useless here, because the following
for_each_set_bit() returns immediately in case of empty flow_pctypes.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 8c27f7ba4adc..3da9ec49cc74 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3624,6 +3624,7 @@ static int i40e_set_rxfh_fields(struct net_device *netdev,
 		   ((u64)i40e_read_rx_ctl(hw, I40E_PFQF_HENA(1)) << 32);
 	DECLARE_BITMAP(flow_pctypes, FLOW_PCTYPES_SIZE);
 	u64 i_set, i_setc;
+	u8 flow_id;
 
 	bitmap_zero(flow_pctypes, FLOW_PCTYPES_SIZE);
 
@@ -3707,20 +3708,14 @@ static int i40e_set_rxfh_fields(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	if (bitmap_weight(flow_pctypes, FLOW_PCTYPES_SIZE)) {
-		u8 flow_id;
+	for_each_set_bit(flow_id, flow_pctypes, FLOW_PCTYPES_SIZE) {
+		i_setc = (u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id)) |
+			 ((u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id)) << 32);
+		i_set = i40e_get_rss_hash_bits(&pf->hw, nfc, i_setc);
 
-		for_each_set_bit(flow_id, flow_pctypes, FLOW_PCTYPES_SIZE) {
-			i_setc = (u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id)) |
-				 ((u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id)) << 32);
-			i_set = i40e_get_rss_hash_bits(&pf->hw, nfc, i_setc);
-
-			i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id),
-					  (u32)i_set);
-			i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id),
-					  (u32)(i_set >> 32));
-			hena |= BIT_ULL(flow_id);
-		}
+		i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id), (u32)i_set);
+		i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id), (u32)(i_set >> 32));
+		hena |= BIT_ULL(flow_id);
 	}
 
 	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), (u32)hena);
-- 
2.47.1

