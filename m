Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4B572687
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091495; cv=none; b=EgCuBsIUrZfTtIgrKNtHVaasTI2yne/r3e8trmMuqHcsguMEd4lc7vYfp9R7rwkAGZXFNxL2EDUHNiz722nH0LWRcyLnXV++s7o6vsaTueuoFbyfUKRCV9F6zxRIlsGIOsG3KzbmBXJD81a0eyimgXZzbNGfQHiokE0l2g6o0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091495; c=relaxed/simple;
	bh=DUyZYCD0K4zwdDCYanacQjYptDKYdCpnEW0aGlabzlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjETBdx8S11uNY5PWF6xOzFyNAsGdyE2dWsglJrWSess7rGnHJXPyfoIeMBcmkW/5wYeqFmnmfib7RjhGa9oybi1VBD+b+x/RICTAy5ZnyUBEfnj0nmYpO/xOU8Bqz2ck6Z7Jcss+4CSsyexQGu35KsYLcmoLxhaeXgwYTTFUEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmSYdxGu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmSYdxGu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091490; x=1823627490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DUyZYCD0K4zwdDCYanacQjYptDKYdCpnEW0aGlabzlo=;
  b=jmSYdxGu8bhnkdqXVfc8axk0f5HOpkeQXwwrupDxAkDt0/m8ghfe+NDF
   KWk+KkgUn4STS7AvoUSSGr21STdBQJd7gX7jaLpm1YFx9UrpKudkkxsop
   Hhvnnw6KUbv31Y+fWNe7dNW/HQL2qMNBvMIyd7gAhhO9e3dFhzHa7l5We
   V/YswnHEUNXyLTH5gVYu6rMk6kciiFMy3mnXCC22Z37aKBPe9kB37Gp7d
   pvOAmRgL/AGnivuGQnOdTt9rl/YZ61uRiZ4jLRkFc60cEF6xDPUBN96oz
   k746Pr8oq/WPFHzjLceAJRN7YKY1Cti/BYvbZCfQ6MoM6+ac1dLyyEFJG
   g==;
X-CSE-ConnectionGUID: qRN0UHowStOEfbwOJSOJ8A==
X-CSE-MsgGUID: RX1jncAET72MD4c5XjZEVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765594"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765594"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:11:15 -0700
X-CSE-ConnectionGUID: 3LSt9zSxSfiKi4R1i3Si+w==
X-CSE-MsgGUID: NYo80VSZT86nJZsMY2BMyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2078502"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 12:11:15 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.machnikowski@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org
Subject: [PATCH net v3 09/14] ice: E825: clear PHY_TSTAMP memory prior to soft reset
Date: Thu, 15 Oct 2026 12:10:55 -0700
Message-ID: <20261015191102.1174111-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

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
PHY_TSTAMP memory region containing the timestamp data is not
zero-initialized when the devices boots up. Instead, it is filled with
garbage. On a cold power on, attempts to read the stale data result in the
hardware triggering a counter decrement for a timestamp that never
happened. This underflows the counter, and prevents new timestamp
interrupts from being triggered for real timestamp requests.

In normal operation this is "fine" because the driver should never read
from the PHY_TSTAMP region without first checking if the
PHY_REG_TX_MEMORY_STATUS bit for a given index is set. However, driver bugs
or programmer error could result in accidentally reading this data.

Attempting to write to the PHY_TSTAMP region is also ineffective as the
registers are read only. Instead, reading a register triggers PHY action to
clear its valid bit. However, the PHY also performs other actions such as
clearing the bit in the PHY_REG_TX_MEMORY_STATUS and decrementing the
internal counter.

We must read the PHY_TSTAMP memory in order to clear stale timestamps. But
doing so may cause a desync with the counter. To prevent issues, perform
this clearing always and only right before initiating a PHY soft reset.

The soft reset will clear and reset the internal counter and the
PHY_REG_TX_MEMORY_STATUS ready bitmap. The reads to PHY_TSTAMP reagion will
reset the region valid bits ensuring that no stale data is left behind.
This combination ensures that we always have a clean slate with no stale
data and with the counter properly reset to zero.

If a read fails (i.e. due to a transient sideband queue failure) it is not
treated as a fatal error. There is already a dynamic debug message for each
read failure. Keep track of the total number of timestamp registers that
fail for a given port and log a warning message indicating the total number
of failures. Continuing is acceptable as clearing the memory is a
precaution against faulty software. Correct software access won't read the
index twice and won't read it at all except when it has already confirmed
that the index is valid by reading ice_get_phy_tx_tstamp_ready(), at which
point the hardware will have overwritten any stale data.

Fixes: 3ec46e157c7f ("ice: perform PHY soft reset for E825C ports at initialization")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 112 ++++++++++----------
 1 file changed, 58 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 07b55fbb88dd..38d0ded1d0cc 100644
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
@@ -1129,47 +1111,35 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
 }
 
 /**
- * ice_clear_ptp_tstamp_eth56g - Clear a timestamp from the quad block
+ * ice_clear_ptp_tstamp_eth56g - Clear a timestamp from PHY memory
  * @hw: pointer to the HW struct
- * @port: the quad to read from
+ * @port: the port to read from
  * @idx: the timestamp index to reset
  *
- * Read and then forcibly clear the timestamp index to ensure the valid bit is
- * cleared and the timestamp status bit is reset in the PHY port memory of
- * internal PHYs of the 56G devices.
+ * Read the timestamp index to ensure that the valid bit is cleared and the
+ * timestamp status bit is reset in the PHY port memory.
  *
- * To directly clear the contents of the timestamp block entirely, discarding
- * all timestamp data at once, software should instead use
- * ice_ptp_reset_ts_memory_quad_eth56g().
- *
- * This function should only be called on an idx whose bit is set according to
- * ice_get_phy_tx_tstamp_ready().
+ * This function should only be called on an index whose bit is set according
+ * to ice_get_phy_tx_tstamp_ready(), or as part of a full sweep when paired
+ * with a PHY soft reset via ice_ptp_phy_soft_reset_eth56g().
  *
  * Return:
  * * %0     - success
- * * %other - failed to write to PHY
+ * * %other - failed to read from PHY
  */
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
 
@@ -1177,19 +1147,43 @@ static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
 }
 
 /**
- * ice_ptp_reset_ts_memory_eth56g - Clear all timestamps from the port block
+ * ice_ptp_clear_tx_memory_status_eth56g - Reset one port's Tx timestamp memory
  * @hw: pointer to the HW struct
- */
-static void ice_ptp_reset_ts_memory_eth56g(struct ice_hw *hw)
-{
-	unsigned int port;
-
-	for (port = 0; port < hw->ptp.num_lports; port++) {
-		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_L,
-					 0);
-		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_U,
-					 0);
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
+ * Failure to read a given index (i.e. due to a transient sideband queue
+ * failure) is not considered fatal as the PHY port is about to be soft reset.
+ * While the soft reset does not clear the timestamp memory, software
+ * shouldn't be reading the timestamp memory without already knowing it is
+ * valid via ice_get_phy_tx_tstamp_ready(), and this sweep is just
+ * a precaution to ensure the memory is in a known state.
+ */
+static void ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw *hw, u8 port)
+{
+	int err, failed = 0;
+	u8 idx;
+
+	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
+		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
+		if (err)
+			failed++;
 	}
+
+	if (failed)
+		dev_warn(ice_hw_to_dev(hw), "Failed to clear %d PHY timestamp registers for port %u\n",
+			 failed, port);
 }
 
 /**
@@ -2295,6 +2289,7 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
  *
  * Trigger a soft reset of the ETH56G PHY by toggling the soft reset
  * bit in the PHY global register. The reset sequence consists of:
+ *   0. Reading every timestamp memory register to clear its valid bit
  *   1. Clearing the soft reset bit
  *   2. Asserting the soft reset bit
  *   3. Clearing the soft reset bit again
@@ -2303,6 +2298,12 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
  * to settle. This provides a controlled way to reinitialize the PHY
  * without requiring a full device reset.
  *
+ * To ensure that the internal counter matches the contents of the
+ * PHY_TSTAMP memory region, read every timestamp index prior to performing
+ * the soft reset. The read side effects ensure that the timestamp memory is
+ * cleared while the soft reset ensures that the PHY_REG_TX_MEMORY_STATUS and
+ * internal counter are reset to zero.
+ *
  * Return: 0 on success, or a negative error code on failure when
  *         reading or writing the PHY register.
  */
@@ -2311,6 +2312,8 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
 	u32 global_val;
 	int err;
 
+	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
+
 	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",
@@ -5802,8 +5805,9 @@ void ice_ptp_reset_ts_memory(struct ice_hw *hw)
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
2.47.1

