Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C54908CB
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698517; cv=none; b=RmC38CYaTUilJUxwYMKDVt5MAAF77LjL5iKd2ZtzJYSsyxdk8GHSEYurGywYCtb+SVKRrLyO+0EIHNm3b1SrlQGTq6bDnWio3AdVY4KGyY8ws4FUKjrDIw4kKU5T6KGLKNJZJhyS5JFYeK8qYxWnhWv/9aabgy7DgmmKXihbpHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698517; c=relaxed/simple;
	bh=PC3Rpj0YgxvmZKBQBGoQcX5jNOQBeqeaJ/KsIdkV9iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BKV5L7Zw4Z7pGq6Ps7ObAUC/RVmNaaU4wXDS60aIT8IoXhy83WLuwG+oBdE7t07qkOWHg3Pu3QmaoUMqWmCMHtJ34gc7EnzjccKLzxVW/wibMiS13lK/CNtANh+vt1UcGgXw79Nx4eSnGSEa0NpMoG7gBSNZ0mYu/oo6ZPYb754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFjoj+pX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFjoj+pX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698512; x=1819234512;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PC3Rpj0YgxvmZKBQBGoQcX5jNOQBeqeaJ/KsIdkV9iU=;
  b=WFjoj+pXp6972ojQzmrdhk+66mRBIFhNlIeyAxOvbrgMrhilJ4WfzERQ
   OS/vgiMcnOFwIPh2VlhnJfmRR9V0mWV5oZvzyDGwkyajZusQazbNTbi17
   h0X/rNvu5xxUSm3C9jNZ4EQJbh5b7uzs0JWzi1o12nZAgF9Pq6FLugD+Y
   aOzdWfA4CRyBQen43hG+F4FxqoTNO6HRe3CwuPoUmV8GQvpxvSg7Y4PJZ
   GN1CV9PpJdgHMBpYDy8ZNWTHkqq1V/mN2fo2dUW6pwYiMtkebSn4w+8G0
   GQHp5WLQlFTvNUB+n7DCJCHPgIzy9QzIh3eSNXIWf8EdRYJALpQv/Vgjn
   Q==;
X-CSE-ConnectionGUID: WuB3sfSZTROS9T1M/UqBng==
X-CSE-MsgGUID: ujXzQ01ATyyLun7lZdPzlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120435"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120435"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:07 -0700
X-CSE-ConnectionGUID: 4//0J7MxT1a5pqeNvzllAw==
X-CSE-MsgGUID: j/ieZbXkQYyxxrji1ti1lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789684"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:32 -0700
Subject: [PATCH iwl-net v2 08/14] ice: E825: clear PHY_REG_TX_MEMORY_STATUS
 prior to soft reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-8-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=8487;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=PC3Rpj0YgxvmZKBQBGoQcX5jNOQBeqeaJ/KsIdkV9iU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WRtvuYNFxxIL/ooFvb84OdfIn6OIZVPL/aVHM5i7T
 MSLzFQ7SlkYxLgYZMUUWRQcQlZeN54QpvXGWQ5mDisTyBAGLk4BmIhoLyPD3/Q/kqnftnIfa3Z5
 aHx21wWJG5k2OtcWz5226r1+3vk3Egz/i1TtvmwRubapryXF7bWZjuw+CWP+OVr2f6OFo3Zf8Sr
 mAgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The current implementation of ice_ptp_reset_ts_memory_eth56g() is flawed.
It tries to clear the timestamp memory by writing to the
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
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 88 +++++++++++++++--------------
 1 file changed, 47 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index d48eb3c61823..a3a9f7ce04d2 100644
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
@@ -1152,24 +1134,16 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
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
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read the PHY timestamp register for port %u, idx %u, err %d\n",
 			  port, idx, err);
-	}
-
-	lo_addr = (u16)PHY_TSTAMP_L(idx);
-
-	err = ice_write_port_mem_eth56g(hw, port, lo_addr, 0);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to clear low PTP timestamp register for port %u, idx %u, err %d\n",
-			  port, idx, err);
 		return err;
 	}
 
@@ -1177,19 +1151,36 @@ static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
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
@@ -2290,6 +2281,7 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
  *
  * Trigger a soft reset of the ETH56G PHY by toggling the soft reset
  * bit in the PHY global register. The reset sequence consists of:
+ *   0. Reading every timestamp memory register to clear its valid bit
  *   1. Clearing the soft reset bit
  *   2. Asserting the soft reset bit
  *   3. Clearing the soft reset bit again
@@ -2298,6 +2290,12 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
  * to settle. This provides a controlled way to reinitialize the PHY
  * without requiring a full device reset.
  *
+ * To ensure that the internal counter matches the contents of the
+ * PHY_REG_TX_MEMORY_STATUS, read every timestamp index prior to performing
+ * the soft reset. The PHY_REG_TX_MEMORY_STATUS reads ensure that the region
+ * is cleared, while the soft reset procedure ensures that the timestamp
+ * counter is reset to zero.
+ *
  * Return: 0 on success, or a negative error code on failure when
  *         reading or writing the PHY register.
  */
@@ -2306,6 +2304,13 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
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
@@ -5797,8 +5802,9 @@ void ice_ptp_reset_ts_memory(struct ice_hw *hw)
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

