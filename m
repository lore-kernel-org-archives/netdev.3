Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA45A3939A6
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314431; cv=none; b=lLdnZIPVnFZ0Yc9J1+zdFLNE5ilgV6PObr1IxzcZYNxk+mM1zkU8QNacKqR17aMnsS8AoEpFgS9Y4ALfkjWNFc0eq1UpBf3hEvMUFUb6IkT6KajVmeMrUMvl2A0KNGSszEes5geRT8YBRPB7vezLXbckKs8lUXHhh0XTqQ7E5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314431; c=relaxed/simple;
	bh=aF/S8y1i2+O+sMLM37mftZstyVHAE3gtM1bVSB/Jb9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dc9lx2T4HvonS7RJekGGo525TehGb3ZgQNLYUZKBVlzTU7B961Dqg93R4BM+I6Sb0QhvbQoywHQQvXsBue+yhJwNYtvZFVkgQs9mJJnq/Ae/EKdk885gPYQ9MvFRyJShAcaRa9pqx/dTm1R3oJLhIU78aBHPbfzUAzJ1ZQXScwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwqFfrZO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwqFfrZO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314430; x=1815850430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aF/S8y1i2+O+sMLM37mftZstyVHAE3gtM1bVSB/Jb9Q=;
  b=HwqFfrZO2x4gkRQ4P1x61hp9APQroZp4pkQ3D+NMwwEvdSJAoXiju59O
   RfE9bKsTNaKKQbvqz66pxdsAMW6ORxY9pP/6qmkp3oCBkQiQ5d1TOJdJT
   jeUbzN9R0VpAoIrNxM+5vSVs8sOrNHL8moN6AIjIEVMfRu9U6v+VskYdk
   H5a+/2ZUYg8/AALk1VAK7/ACAQtNFaAfCaCRYVpGDQfrejs6RmG897ulH
   clTYStH9cwvmPm7/O0lkJOHbJ2zpLCG+9pA2JKkRAEnzdzigbP3MNIiLf
   icZrOnjndD60gmzzfyUthwIDu4nvPChfjwAvw9zmTDxJuGpcoTRSZdhiY
   A==;
X-CSE-ConnectionGUID: 6ZVsFYJXRRamiEI2Gapwlg==
X-CSE-MsgGUID: eVJZ5/yzRv2b8s0wQ6X8wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347624"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347624"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:48 -0700
X-CSE-ConnectionGUID: J9XloURHSSigJr4jfjqznw==
X-CSE-MsgGUID: hbXD2SDjQCu3r/WSgj3Jmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827244"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <anthony.l.nguyen@intel.com>,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 07/13] ice: support SBQ posted writes with non-posted support for CGU
Date: Fri, 17 Jul 2026 11:53:29 -0700
Message-ID: <20260717185340.3595286-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
References: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Sideband queue (SBQ) is a HW queue with very short completion time. All
SBQ writes were posted by default, which means that the driver did not
have to wait for completion from the neighbor device, because there was
none. This introduced unnecessary delays, where only those delays were
"ensuring" that the command is "completed" and this was a potential race
condition.

Add the possibility to perform non-posted writes where it's necessary to
wait for completion, instead of relying on fake completion from the FW,
where only the delays are guarding the writes.

Flush the SBQ by reading address 0 from the PHY 0 before issuing SYNC
command to ensure that writes to all PHYs were completed and skip SBQ
message completion if it's posted.

E810 only supports opcode 0x01, but its FW always sends completion
responses for this opcode, so the driver waits for each write to complete.
This makes E810 writes synchronous and eliminates the need for SBQ flush.

To analyze if delays are gone, look for and compare time spent in
ice_sq_send_cmd - posted writes should return immediately after the wr32.
That can be done for example by adjusting phc time with phc_ctl on E830
device, for less than 2 seconds to use this new mechanism. Without it,
command below will fail.

Reproduction steps:
phc_ctl eth13 adj 1
phc_ctl[4478170.994]: adjusted clock by 1.000000 seconds

Check trace for timing for comparisons:
echo ice_sbq_send_cmd > /sys/kernel/debug/tracing/set_ftrace_filter
echo function_graph > /sys/kernel/debug/tracing/current_tracer
cat /sys/kernel/debug/tracing/trace

Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c   | 25 ++++++++--
 drivers/net/ethernet/intel/ice/ice_controlq.c |  4 ++
 drivers/net/ethernet/intel/ice/ice_controlq.h |  1 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 47 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |  2 +-
 5 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ef1ce106f81b..53974ebaaffa 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1762,6 +1762,7 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 {
 	struct ice_sbq_cmd_desc desc = {0};
 	struct ice_sbq_msg_req msg = {0};
+	struct ice_sq_cd cd = {};
 	u16 msg_len;
 	int status;
 
@@ -1774,19 +1775,33 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 	msg.msg_addr_low = cpu_to_le16(in->msg_addr_low);
 	msg.msg_addr_high = cpu_to_le32(in->msg_addr_high);
 
-	if (in->opcode)
+	switch (in->opcode) {
+	case ice_sbq_msg_wr_p:
+	case ice_sbq_msg_wr_np:
 		msg.data = cpu_to_le32(in->data);
-	else
+		/* E810 FW only supports opcode 0x01, convert non-posted to posted */
+		if (hw->mac_type == ICE_MAC_E810)
+			msg.opcode = ice_sbq_msg_wr_p;
+		break;
+	case ice_sbq_msg_rd:
 		/* data read comes back in completion, so shorten the struct by
 		 * sizeof(msg.data)
 		 */
 		msg_len -= sizeof(msg.data);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* E810 doesn't support posted mode, always wait for completion */
+	cd.posted = in->opcode == ice_sbq_msg_wr_p &&
+		    hw->mac_type != ICE_MAC_E810;
 
 	desc.flags = cpu_to_le16(flags);
 	desc.opcode = cpu_to_le16(ice_sbq_opc_neigh_dev_req);
 	desc.param0.cmd_len = cpu_to_le16(msg_len);
-	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, NULL);
-	if (!status && !in->opcode)
+	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, &cd);
+	if (!status && in->opcode == ice_sbq_msg_rd)
 		in->data = le32_to_cpu
 			(((struct ice_sbq_msg_cmpl *)&msg)->data);
 	return status;
@@ -6547,7 +6562,7 @@ int ice_write_cgu_reg(struct ice_hw *hw, u32 addr, u32 val)
 {
 	struct ice_sbq_msg_input cgu_msg = {
 		.dest_dev = ice_get_dest_cgu(hw),
-		.opcode = ice_sbq_msg_wr,
+		.opcode = ice_sbq_msg_wr_np,
 		.msg_addr_low = addr,
 		.data = val
 	};
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index dcb837cadd18..a6008dc77fa4 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -1086,6 +1086,10 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	wr32(hw, cq->sq.tail, cq->sq.next_to_use);
 	ice_flush(hw);
 
+	/* If the message is posted, don't wait for completion. */
+	if (cd && cd->posted)
+		goto sq_send_command_error;
+
 	/* Wait for the command to complete. If it finishes within the
 	 * timeout, copy the descriptor back to temp.
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 788040dd662e..c50d6fcbacba 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -77,6 +77,7 @@ struct ice_ctl_q_ring {
 /* sq transaction details */
 struct ice_sq_cd {
 	struct libie_aq_desc *wb_desc;
+	u8 posted : 1;
 };
 
 /* rq event information */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 8e5f97835954..c6049097f49d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -352,6 +352,20 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_sbq_dev_phy_0,
+		.opcode = ice_sbq_msg_rd,
+	};
+	int err;
+
+	/* Flush SBQ to ensure posted writes complete before SYNC command.
+	 * Skip for E810 - FW always sends completions, so writes are synchronous.
+	 */
+	if (hw->mac_type != ICE_MAC_E810) {
+		err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
+		if (err)
+			dev_warn(ice_hw_to_dev(hw), "Failed to flush SBQ: %d\n", err);
+	}
 
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
@@ -442,7 +456,7 @@ static int ice_write_phy_eth56g(struct ice_hw *hw, u8 port, u32 addr, u32 val)
 {
 	struct ice_sbq_msg_input msg = {
 		.dest_dev = ice_ptp_get_dest_dev_e825(hw, port),
-		.opcode = ice_sbq_msg_wr,
+		.opcode = ice_sbq_msg_wr_p,
 		.msg_addr_low = lower_16_bits(addr),
 		.msg_addr_high = upper_16_bits(addr),
 		.data = val
@@ -2614,16 +2628,18 @@ ice_read_64b_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 low_addr, u64 *val)
  * @val: The value to write to the register
  *
  * Write a PHY register for the given port over the device sideband queue.
+ * Uses posted writes - requires SBQ flush before SYNC_EXEC_CMD.
  */
 static int
 ice_write_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 offset, u32 val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.opcode = ice_sbq_msg_wr_p,
+		.data = val
+	};
 	int err;
 
 	ice_fill_phy_msg_e82x(hw, &msg, port, offset);
-	msg.opcode = ice_sbq_msg_wr;
-	msg.data = val;
 
 	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 	if (err) {
@@ -2811,16 +2827,16 @@ ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val)
 int
 ice_write_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.opcode = ice_sbq_msg_wr_p,
+		.data = val
+	};
 	int err;
 
 	err = ice_fill_quad_msg_e82x(hw, &msg, quad, offset);
 	if (err)
 		return err;
 
-	msg.opcode = ice_sbq_msg_wr;
-	msg.data = val;
-
 	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
@@ -4514,18 +4530,19 @@ static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
  * @val: the value to write to the PHY
  *
  * Write a value to a register of the external PHY on the E810 device.
+ * E810 FW sends completions for opcode 0x01, making writes synchronous.
  */
 static int ice_write_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_sbq_dev_phy_0,
+		.opcode = ice_sbq_msg_wr_p,
+		.msg_addr_low = lower_16_bits(addr),
+		.msg_addr_high = upper_16_bits(addr),
+		.data = val
+	};
 	int err;
 
-	msg.msg_addr_low = lower_16_bits(addr);
-	msg.msg_addr_high = upper_16_bits(addr);
-	msg.opcode = ice_sbq_msg_wr;
-	msg.dest_dev = ice_sbq_dev_phy_0;
-	msg.data = val;
-
 	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
index 226243d32968..eedcd2481a59 100644
--- a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
@@ -55,7 +55,7 @@ enum ice_sbq_dev_id {
 
 enum ice_sbq_msg_opcode {
 	ice_sbq_msg_rd		= 0x00,
-	ice_sbq_msg_wr		= 0x01,
+	ice_sbq_msg_wr_p	= 0x01,
 	ice_sbq_msg_wr_np	= 0x02
 };
 
-- 
2.47.1

