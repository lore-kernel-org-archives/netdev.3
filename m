Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611556;
	b=ECveeAAXopnaYM2HylZfoW1oMmmtnKyj2dvp4CIXDvKKheEZO8Epnv/dZUoD1XYIiG1s
	 obZVlFQmVdPmgSHRRs6RpalVD8cUedDySBsZzmBu23oSTMUL56qLBdIrqHtqpwtmvpxW3
	 In5VYTWSemFlR252hWEYNjgaMWNvc3Ev3q7vtazAZ3uNrK12NnMS29yzWaKdFBJqcqgNP
	 kmW312FeDNfHF86RC6LWor8FHqUqUQYfhuXvRsseBs2HWd8N0E+k+mO+L55lb58HOPvng
	 ow1vv1BUDuA7X0hiPcmuoyrpdvNWcpJe8krUjUlmagd59RqvIr7EyhrGPCx8+fx8b9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611556;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NOZKIgri6zea010s+SHE1ngecsGavQ1mEHdPKG2zTSo=;
	b=X0uR81CpqWisO0C0Wz/3I+BP6NBkb75cBU4HsyYXi65diUVKntrKvEDR2MKZ4DJbUL8K
	 H1b2ugwFN0117TufGKDkHBsA4UKL/I9Z5wxcc1f+KlnZoRubd3dkKbtcmcN3bzfeJcZZ2
	 SyvXrHcKQGwXujSsUi7rvXU0pF2Y0pHYyg2lzfteDPO3iVEerQAnEZsaKCweBsIRrhI2n
	 8SZVMBZZz1/zEmCJ7VGtFC37qtJ21MsN/aNahNqyFbY0sycZu8YFRjSyhbV1hSe6OeIaU
	 dJl5JxIfFE9PCCgyWOk4joj23Na92BQGHjI3W8rjqpQVVo8uWyjYNQpA6wE2dzrSu8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k36DrVLX;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384BB606A887
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 384BB606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k36DrVLX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794611556; x=1826147556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/7QW3H6CBUg7Rm3jejScIevAeOAShHhYSnbg25aEFCc=;
  b=k36DrVLX8p+aS48bMun5on9luCAzPBWiDucTXYuslfBaaORsFGmHyIWX
   D7+zfD+iuFe9z/jHHno1laf2SRzLBNOrfa5R21QVEe2tqtKQwksbe4Hah
   RwAAEvItUdnMEuPa9V417w5YRXiBCJqGX9nhfgG4wA2Tyq6UvIyyoYY81
   w1dGdVoNKLRY1wfgLL4nXe3R5ZE1LHff8LzXEL24Ue+tzGsaAKnms8B5A
   otbA1W70MEP+FZYVHmj4rbYnWSsily/HqI9TBj6N4/SQJmSnAwrni6AKR
   dBdI7jBMwctN7UcBNsuHjiSoW4oh7CbzwRnevmA1UcivKiPywHYSJfmgR
   A==;
X-CSE-ConnectionGUID: brsunvDmRS6V1YJF5s6P6Q==
X-CSE-MsgGUID: ZXZb98V9RGSO8TcmADSarA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3443165"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3443165"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:12:35 -0800
X-CSE-ConnectionGUID: ML6Z/qfuRjur9tn24JMELQ==
X-CSE-MsgGUID: 16ybXmQRSi+Wh1jeTEi2Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9360992"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2026 15:12:34 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	poros@redhat.com,
	david.m.ertman@intel.com,
	przemyslaw.kitszel@intel.com,
	jedrzej.jagielski@intel.com,
	arkadiusz.kubalewski@intel.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 5/6] ice: propagate ETH56G deskew poll failures
Date: Fri, 13 Nov 2026 15:12:22 -0800
Message-ID: <20261113231225.1864810-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

ice_ptp_calc_deskew_eth56g() ignores the return value of
read_poll_timeout(). If register reads succeed but the DESKEW valid bit
never appears, the timeout is treated as success. If a register read fails,
the poll condition can also inspect deskew_i before a successful read and
continue polling instead of stopping on the hard error. The function then
returns an int error through its u32 deskew return type.

Return the deskew value through an output parameter. Stop polling when
either the read fails or the valid bit appears, then propagate the register
error or the poll timeout separately before calculating and applying the
deskew value.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 42 ++++++++++++++-------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751..da48d3adf94f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1736,24 +1736,30 @@ static u32 ice_ptp_calc_bitslip_eth56g(struct ice_hw *hw, u8 port, u32 bs,
  * @ds: deskew multiplier
  * @rs: RS-FEC enabled
  * @spd: link speed
+ * @deskew: output parameter for the calculated deskew value
  *
- * Return: calculated deskew value
+ * Return: 0 on success, negative error code otherwise
  */
-static u32 ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
-				      bool rs, enum ice_eth56g_link_spd spd)
+static int ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
+				      bool rs, enum ice_eth56g_link_spd spd,
+				      u32 *deskew)
 {
-	u32 deskew_i, deskew_f;
-	int err;
+	u32 deskew_i = 0, deskew_f;
+	int err, ret;
 
-	if (!ds)
+	if (!ds) {
+		*deskew = 0;
 		return 0;
+	}
 
-	read_poll_timeout(ice_read_ptp_reg_eth56g, err,
-			  FIELD_GET(PHY_REG_DESKEW_0_VALID, deskew_i), 500,
-			  50 * USEC_PER_MSEC, false, hw, port, PHY_REG_DESKEW_0,
-			  &deskew_i);
+	ret = read_poll_timeout(ice_read_ptp_reg_eth56g, err,
+				err || FIELD_GET(PHY_REG_DESKEW_0_VALID, deskew_i),
+				500, 50 * USEC_PER_MSEC, false, hw, port,
+				PHY_REG_DESKEW_0, &deskew_i);
 	if (err)
 		return err;
+	if (ret)
+		return ret;
 
 	deskew_f = FIELD_GET(PHY_REG_DESKEW_0_RLEVEL_FRAC, deskew_i);
 	deskew_i = FIELD_GET(PHY_REG_DESKEW_0_RLEVEL, deskew_i);
@@ -1766,7 +1772,9 @@ static u32 ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
 	deskew_i = FIELD_PREP(ICE_ETH56G_MAC_CFG_RX_OFFSET_INT, deskew_i);
 	/* Shift 3 fractional bits to the end of the integer part */
 	deskew_f <<= ICE_ETH56G_MAC_CFG_FRAC_W - PHY_REG_DESKEW_0_RLEVEL_FRAC_W;
-	return mul_u32_u32_fx_q9(deskew_i | deskew_f, ds);
+	*deskew = mul_u32_u32_fx_q9(deskew_i | deskew_f, ds);
+
+	return 0;
 }
 
 /**
@@ -1789,6 +1797,7 @@ static int ice_phy_set_offsets_eth56g(struct ice_hw *hw, u8 port,
 {
 	u32 rx_offset, tx_offset, bs_ds;
 	bool onestep, sfd;
+	int err;
 
 	onestep = hw->ptp.phy.eth56g.onestep_ena;
 	sfd = hw->ptp.phy.eth56g.sfd_ena;
@@ -1805,11 +1814,16 @@ static int ice_phy_set_offsets_eth56g(struct ice_hw *hw, u8 port,
 	if (sfd)
 		rx_offset = add_u32_u32_fx(rx_offset, cfg->rx_offset.sfd);
 
-	if (spd < ICE_ETH56G_LNK_SPD_40G)
+	if (spd < ICE_ETH56G_LNK_SPD_40G) {
 		bs_ds = ice_ptp_calc_bitslip_eth56g(hw, port, bs_ds, fc, rs,
 						    spd);
-	else
-		bs_ds = ice_ptp_calc_deskew_eth56g(hw, port, bs_ds, rs, spd);
+	} else {
+		err = ice_ptp_calc_deskew_eth56g(hw, port, bs_ds, rs, spd,
+						 &bs_ds);
+		if (err)
+			return err;
+	}
+
 	rx_offset = add_u32_u32_fx(rx_offset, bs_ds);
 	rx_offset &= ICE_ETH56G_MAC_CFG_RX_OFFSET_INT |
 		     ICE_ETH56G_MAC_CFG_RX_OFFSET_FRAC;
-- 
2.47.1

