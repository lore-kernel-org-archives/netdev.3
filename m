Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489582;
	b=a8RAoYh7gCLTeoDBmu63FPt2JlpBPmvHQL+2ngrzTVdvVf/vrgxi7rlUqDmZwBkUXTB8
	 ALgC9ysHuRvxQ6Y3kMusS6PiuD5Czwmm9ijLGcNbkm44XyPXSyWbPzgGFmZdU0ow7NeDR
	 uKpWnEkRUI6METWbhWF4InCT4yQjaWugbZgwKf6GAoWLkGHR5WvklAF9KUaKksjGlflhb
	 4J34qh+ZnEp4k2Zj7v/fvosWWSz1R5wIcdbm5Ae2kxlLSS6ObF3gwMChU8Jy7mmCwd6Pj
	 9rs30CFYhUlS7otXAeq4bKrrt72PDGpnYdSwD1uLoszD7dmGNPRwDg3cezqTZMCJlcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489582;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=9uBWn4ujY48cINKbR1drR33IlZlPFmekvr9357yhA6I=;
	b=dK2mr9BbfiTPx+Kx26TlultudX8mCzzerx9bTvksp0tdKmHSo9knUOnIWNO5y4HeO3/4
	 Dg4qkXnXldf8klDb4P+egOtKTx4nKVRS8d+IaK6LR3IvOJ5UcvODlEmFt7Zh+dv45PhA8
	 DzeYrqH5Anoibj1gsY87KPaTi6hMSPh9bTjV4iW4jufRMEt9srkCM+u+vDoYv0xsF3RV9
	 DJQBXrhhU8DrgvK6wG002KLcyeiqCih7cLyg7at04hLRsRlqw7h2dKFtTTich4yyy6S97
	 dunNvl5+K+c2VvwGb/XuReiG1LEAN22Hy1CBfKs2Uapmv4zNn9l6wS0NBDk6iuC/ANA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0EaXiog;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706060A2603
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E706060A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0EaXiog
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489582; x=1824025582;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=WhvXwT7GlgsEYeY7EVgSlN2DQ7W00a7iO2julA5ZtNo=;
  b=i0EaXiog2+0gYNP5k4B4evO+8BkQueKNI5b428QOxON1rlinXSNXG1K7
   kx91SGXrU8dbBxugqeerbZyCBJ+Fnu2xkLSrvzW1JzEVuO01TUwKRnKxr
   bGG4Xv6EOhDFdPx8DzJ+b2suGg6XfwdPD44SC1k+taBRJUlnb89SzTwXX
   95YpsYGwd7hoUpAc90l1p/6VCo/dZBfZIBr+L1HV0vowiMFw02Rdy2UTa
   6KK+S7iU5Y5M5gJkVx0bj1k0IM/EzSV34x8R2WQx7KPkF5L5vj+zxbPfZ
   fnCd0yvljAZcn6pT61r5BlrvTFONYXLzn5iuBwdRUHJ4mOBVbqIf00ZfR
   Q==;
X-CSE-ConnectionGUID: eAQd/+vASv6ubaOIUzrevw==
X-CSE-MsgGUID: REr+qJu4Sx+MQCmx+1ZcRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287921"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287921"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: uSc02XHtSDaP2NWk/DZuiQ==
X-CSE-MsgGUID: u/qPneXFTgeO1VFcAey3RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2723913"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 20 Oct 2026 02:45:40 -0700
Subject: [PATCH iwl-net v4 09/13] ice: E825: clear PHY_TSTAMP memory prior
 to soft reset
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-9-3e30fc9adc73@intel.com>
References: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
In-Reply-To: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, jacob.e.keller@intel.com, 
 maciej.machnikowski@intel.com, przemyslaw.korba@intel.com, 
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com, 
 richardcochran@gmail.com, horms@kernel.org
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=11459;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=WhvXwT7GlgsEYeY7EVgSlN2DQ7W00a7iO2julA5ZtNo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzrFvHbUmUeuNto2yamuxq+n1fksuTFZmfzGcvb/m+at
 bLgtktbRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABM5+pSR4Y3Hf7Pf7G/e7g9g
 1yz8e8xA3eXszfVtSYn7VCIUbl8JcWZkuHTq5M/b3zI6OiwOM7Vq1K58zJdxXXhRu4jZGv+KYJH
 vbAA=
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

Since ice_ptp_reset_ts_memory now only works for E82X hardware, update its
kdoc comment to clarify what hardware is skipped and note specifically why
E825 is skipped.

Fixes: 3ec46e157c7f ("ice: perform PHY soft reset for E825C ports at initialization")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 110 ++++++++++++++--------------
 1 file changed, 57 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 07b55fbb88dd..5637925c0e68 100644
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
  */
-static void ice_ptp_reset_ts_memory_eth56g(struct ice_hw *hw)
+static void ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw *hw, u8 port)
 {
-	unsigned int port;
+	int err, failed = 0;
+	u8 idx;
 
-	for (port = 0; port < hw->ptp.num_lports; port++) {
-		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_L,
-					 0);
-		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_U,
-					 0);
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
@@ -5794,6 +5797,11 @@ static int ice_get_pf_c827_idx(struct ice_hw *hw, u8 *idx)
 /**
  * ice_ptp_reset_ts_memory - Reset timestamp memory for all blocks
  * @hw: pointer to the HW struct
+ *
+ * Only E82X hardware can directly reset memory for all blocks. E825 hardware
+ * can only safely reset timestamp memory as part of the soft reset, so is not
+ * reset here. E810 and E830 also do not implement direct reset of the
+ * timestamp memory region.
  */
 void ice_ptp_reset_ts_memory(struct ice_hw *hw)
 {
@@ -5801,10 +5809,6 @@ void ice_ptp_reset_ts_memory(struct ice_hw *hw)
 	case ICE_MAC_GENERIC:
 		ice_ptp_reset_ts_memory_e82x(hw);
 		break;
-	case ICE_MAC_GENERIC_3K_E825:
-		ice_ptp_reset_ts_memory_eth56g(hw);
-		break;
-	case ICE_MAC_E810:
 	default:
 		return;
 	}

-- 
2.56.0.212.g129ede20d986

