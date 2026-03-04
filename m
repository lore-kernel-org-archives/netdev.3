Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27072146588
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582891; cv=none; b=tD8bzwJ9ccm1m8OHycAD83OdpGYf+8EO7abVv3chA5RsvbAJo8LuIVBuZHJbvpb2SR+Dt67/Cj18kUB3i6TCxXdCmzcTvzsC37xJrNsBBEnNbSFoUXM40YFNMTkLiwmGEm6cW+uz3VIAH5jRrPaoXW2DoGWFoqaRDBn1MJecKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582891; c=relaxed/simple;
	bh=UbPtj7+MMJp78z/DrECap+upySFOT+Zvd1eyBeVmQvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkREIlmGKHVMDe8GNoNGbfeAmbg9A5pueFXggdk0HDZIIByfZ6V9qCOb+qTDQGwlFpOZcW1f8iSpVwIlh5VUXk8r1osMrgcgkpM0Dvc/BkGQUTUyemWiHUNUYd79xQzDqVQpEvnsE7W6AcOt12Ht4hpLgkqpWxDOZhUeCHP5icQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWymXptX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWymXptX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772582891; x=1804118891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UbPtj7+MMJp78z/DrECap+upySFOT+Zvd1eyBeVmQvY=;
  b=QWymXptX9Cu9JvusyI1nPZAAnJ1PvIq7uXEj4sCP7Qp8pSuaBLFvP+TO
   M5dhFPDC8dC/BMEDZThURSCBDkf/bI8LCqf7qA/xMtWBoJd8w/BS4Iaob
   STeXwrnz/o+bCkU9DNBwjtOvA82pXxPH//kd7xca++/UKQYNZz0YVq92+
   pmbi//w/zS67OJEX0AGVv92Gt339W2+5wzuMPDaAzRzuepXt/agjucclr
   w3GWliXcj7+DG9fe4jSWZmfq8zE8Gvkym3azThnWOO2UeQCOxPmQ/fe8s
   kqO5BMmhDDkIyMJxXoCS/SumU28xLPeiUI5ZGMehY7F9KDpeYtVwlp5Ps
   g==;
X-CSE-ConnectionGUID: e0K01CIcRA6tZG2RN52bpQ==
X-CSE-MsgGUID: dfeLJmVdRJ6T2g/yOGcOLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77243032"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="77243032"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 16:08:08 -0800
X-CSE-ConnectionGUID: C/mG0CzgQYCSCxux8huTrA==
X-CSE-MsgGUID: dax6/o7tS6ustX/vc0AHoA==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 03 Mar 2026 16:08:07 -0800
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
Subject: [PATCH net-next v2 2/4] i40e: drop useless bitmap_weight() call in i40e_set_rxfh_fields()
Date: Tue,  3 Mar 2026 16:07:54 -0800
Message-ID: <20260304000800.3536872-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260304000800.3536872-1-anthony.l.nguyen@intel.com>
References: <20260304000800.3536872-1-anthony.l.nguyen@intel.com>
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

