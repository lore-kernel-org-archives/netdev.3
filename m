Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940892472A2
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357703; cv=none; b=blM6xHdcZVOJsj46Ku0PhIdubnSsV+xVooI3h/Moif6gVGmzqz41wW33vCLGJjKewLJmJMMr90Wnr+xvn/UiAfArdxuAFQifPBcBPQtqSzgW2DBWx1wE2EdOlOkBGCTLwex/VVhZ++C5wPByX2qVXp2NZiovXOA8NzV8TR8kqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357703; c=relaxed/simple;
	bh=v9eFE5xOvrdwPdRVFGSjAioRp6GAx3IlfqYW70aCId4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAI02gxZy1WV7ey6ZQxfBeNPVOurnPBvM1SdDSGXGYrCSp6u365MW/kz8/eyP9XxsCkS5vx3QWFdppTxyVEu/Tvkj4NVIFfYfmmLa7d1Fj/qXpjjkYAhN2qutDkbr8uPV8cqkQvdkbr5csPPtwrl7Qc+Nr9nPh2q/0nfsvE2Mvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlAAZjCP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlAAZjCP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787357701; x=1818893701;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=v9eFE5xOvrdwPdRVFGSjAioRp6GAx3IlfqYW70aCId4=;
  b=YlAAZjCP1JnQi3Q4nVaVjA98OFQMPM7kj3MKmLdk3h9F6VL8W7Bk/v1S
   W27U8b6cku1FSswPoiLHY90SCrBxc8Ms8HVF/wG4nSJg4Y3ID+GWZknUS
   74eWFp+2pf/JRZApW5Fdr0dVEcAjST92mqiyR5DkWjVQicBAplKq9XG5Y
   3Wbp+38bdMiugUb8PttAiIJiqJryeoCLx3sn0LrolZ7G7eTVKyIjORvO1
   3zETZP7rZxAj5vcVrOALNIn17nteEHtsRR67UJSVYrmSSdPohOpbrVqnJ
   ZBgb3QrmWCLx7jZs+yTNyaN6lSewhKdXnZtMDOApB7D+/CyxchAyFjNCZ
   w==;
X-CSE-ConnectionGUID: wnQ02s8BSuyjpK3We/ykeA==
X-CSE-MsgGUID: /deyr84jS4yTkZoF0O6jlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584769"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91584769"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:59 -0700
X-CSE-ConnectionGUID: ywXt/LLqSsGoq3GonUCQTQ==
X-CSE-MsgGUID: v8/G21ywQZyMjqItdUOkHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="263836476"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:11 -0700
Subject: [PATCH iwl-net 06/12] ice: E825: clear PHY_REG_TX_MEMORY_STATUS
 prior to soft reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-6-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=8402;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=v9eFE5xOvrdwPdRVFGSjAioRp6GAx3IlfqYW70aCId4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl7/+2fKf2WuZIWdjfPHuW3d1vUnxFnb+7E/tP/650
 PlZTPJjRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABM5PYuR4dS6ns49ylJnBfLS
 j32q4S35s/76rx1ivWeUI1g2TLyV9oKR4eJKcesew5KdXQ+P3b72z6ZiZ/Z/97T5pSe79n23j1i
 2nxsA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The drivers current implementation of ice_ptp_reset_ts_memory_eth56g() is
flawed. It tries to clear the timestamp memory by writing to the
PHY_REG_TX_MEMORY_STATUS region. This does not work properly, as it does
not trigger appropriate PHY actions.

To clear outstanding timestamp memory, the driver must read the timestamps.
However, naively doing this as part of ice_ptp_reset_ts_memory() is
problematic. When reading the timestamp index, hardware kicks off a chain
of actions including clearing the ready bitmap index, and decrementing an
internal counter if the timestamp index was marked as valid.

This can potentially leave the internal hardware counter out of sync with
the actual number of timestamps. This occurs because the
PHY_REG_TX_MEMORY_STATUS region is not zero-initialized when the device
boots up. Instead, it is filled with garbage. On a cold power on, attempts
to read the stale data result in the hardware triggering a counter
decrement for a timestamp that never happened. This underflows the counter,
and prevents new timestamp interrupts from being triggered for real
timestamp requests.

We must read the PHY_REG_TX_MEMORY_STATUS in order to clear stale
timestamps. But doing so may cause a desync with the counter. To prevent
issues, perform this clearing always and only right before initiating a PHY
soft reset.

The soft reset will clear and reset the internal counter and the ready
bitmap. The reads to PHY_REG_TX_MEMORY_STATUS will reset the region valid
bits ensuring that no stale data is left behind. This combination ensures
that we always have a clean slate with no stale data and with the counter
properly reset to zero.

Fixes: 3ec46e157c7f ("ice: perform PHY soft reset for E825C ports at initialization")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 89 +++++++++++++++--------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index d48eb3c61823..b7d217ac31f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -737,24 +737,6 @@ static int ice_read_port_mem_eth56g(struct ice_hw *hw, u8 port, u16 offset,
 	return ice_read_port_eth56g(hw, port, offset, val, ETH56G_PHY_MEM_PTP);
 }
 
-/**
- * ice_write_port_mem_eth56g - Write a PHY port memory location
- * @hw: pointer to the HW struct
- * @port: Port number to be read
- * @offset: Offset from PHY port register base
- * @val: Pointer to the value to read (out param)
- *
- * Return:
- * * %0      - success
- * * %EINVAL - invalid port number or resource type
- * * %other  - failed to write to PHY
- */
-static int ice_write_port_mem_eth56g(struct ice_hw *hw, u8 port, u16 offset,
-				     u32 val)
-{
-	return ice_write_port_eth56g(hw, port, offset, val, ETH56G_PHY_MEM_PTP);
-}
-
 /**
  * ice_write_quad_ptp_reg_eth56g - Write a PHY quad register
  * @hw: pointer to the HW struct
@@ -1139,8 +1121,8 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
  * internal PHYs of the 56G devices.
  *
  * To directly clear the contents of the timestamp block entirely, discarding
- * all timestamp data at once, software should instead use
- * ice_ptp_reset_ts_memory_quad_eth56g().
+ * all timestamp data at once, software should instead perform a PHY soft
+ * reset via ice_ptp_phy_soft_reset_eth56g().
  *
  * This function should only be called on an idx whose bit is set according to
  * ice_get_phy_tx_tstamp_ready().
@@ -1152,11 +1134,11 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
 static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
 {
 	u64 unused_tstamp;
-	u16 lo_addr;
 	int err;
 
-	/* Read the timestamp register to ensure the timestamp status bit is
-	 * cleared.
+	/* Per the PHY spec, reading the timestamp memory location is what
+	 * clears the entry's valid bit and its corresponding (read-only)
+	 * ts_memory_status bit.
 	 */
 	err = ice_read_ptp_tstamp_eth56g(hw, port, idx, &unused_tstamp);
 	if (err) {
@@ -1164,32 +1146,40 @@ static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
 			  port, idx, err);
 	}
 
-	lo_addr = (u16)PHY_TSTAMP_L(idx);
-
-	err = ice_write_port_mem_eth56g(hw, port, lo_addr, 0);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to clear low PTP timestamp register for port %u, idx %u, err %d\n",
-			  port, idx, err);
-		return err;
-	}
-
 	return 0;
 }
 
 /**
- * ice_ptp_reset_ts_memory_eth56g - Clear all timestamps from the port block
+ * ice_ptp_clear_tx_memory_status_eth56g - Reset one port's Tx timestamp memory
  * @hw: pointer to the HW struct
+ * @port: port number to clear
+ *
+ * Fully reset a single PHY port's Tx timestamp memory. Per the PHY spec, the
+ * only way to clear a timestamp valid bit (and its read-only ts_memory_status
+ * bit) is to read the timestamp memory location, so read every entry for the
+ * port (two 32-bit reads each). This discards all timestamp data on the port,
+ * so it must only be used for a full reset; callers that must preserve
+ * in-flight timestamps clear individual indices via ice_clear_phy_tstamp().
+ *
+ * Due to interactions with an internal HW counter for the number of
+ * outstanding Tx timestamps, this *must* only be called as part of the
+ * ice_ptp_phy_soft_reset_eth56g() procedure. Otherwise, the internal counter
+ * may become out of sync and prevent new timestamp interrupts.
+ *
+ * Return: 0 on success, negative error code on failure to read the PHY.
  */
-static void ice_ptp_reset_ts_memory_eth56g(struct ice_hw *hw)
+static int ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw *hw, u8 port)
 {
-	unsigned int port;
+	int err = 0;
+	u8 idx;
 
-	for (port = 0; port < hw->ptp.num_lports; port++) {
-		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_L,
-					 0);
-		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_U,
-					 0);
+	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
+		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
+		if (err)
+			return err;
 	}
+
+	return 0;
 }
 
 /**
@@ -2290,6 +2280,7 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
  *
  * Trigger a soft reset of the ETH56G PHY by toggling the soft reset
  * bit in the PHY global register. The reset sequence consists of:
+ *   0. Reading every timestamp memory register to clear its valid bit
  *   1. Clearing the soft reset bit
  *   2. Asserting the soft reset bit
  *   3. Clearing the soft reset bit again
@@ -2298,6 +2289,12 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
  * to settle. This provides a controlled way to reinitialize the PHY
  * without requiring a full device reset.
  *
+ * To ensure that the internal counter matches the contents of the
+ * PHY_REG_TX_MEMORY_STATUS, read every timestamp index prior to performing
+ * the soft reset. The PHY_REG_TX_MEMORY_STATUS reads ensure that the region
+ * is cleared, while the soft reset procedure ensures that the timsetamp
+ * counter is reset to zero.
+ *
  * Return: 0 on success, or a negative error code on failure when
  *         reading or writing the PHY register.
  */
@@ -2306,6 +2303,13 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
 	u32 global_val;
 	int err;
 
+	err = ice_ptp_clear_tx_memory_status_eth56g(hw, port);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to clear PHY_REG_TX_MEMORY_STATUS for port %d, err %d\n",
+			  port, err);
+		return err;
+	}
+
 	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",
@@ -5797,8 +5801,9 @@ void ice_ptp_reset_ts_memory(struct ice_hw *hw)
 		ice_ptp_reset_ts_memory_e82x(hw);
 		break;
 	case ICE_MAC_GENERIC_3K_E825:
-		ice_ptp_reset_ts_memory_eth56g(hw);
-		break;
+		/* E825 hardware must only reset timestamp memory as part of
+		 * the soft reset procedure.
+		 */
 	case ICE_MAC_E810:
 	default:
 		return;

-- 
2.55.0.814.gc42f45431d0f

