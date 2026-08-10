Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668824E016
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348623; cv=none; b=qDvtB8ZQu52DvS60RqxyEO+38iNICXnclZsVYvjWilX4PDDbA64QrgOsA1nvABAU9ZqqUEmQI1kICs0mMynmFIJNNCxVR4el2hgpGR4NcqABY4CUlN4XVlYkX6tA1t95M3+LZ4YORgD9i0Wqq0fhcQLDrXxviT7puWcsk2X/YA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348623; c=relaxed/simple;
	bh=K3dGZxx+dFdUL7gnm6sbE+ZMC4jTvvyK6dHc60lLDNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W329rnaj0YgOBZLFIw+c4oDlQLbb43tpi3L+h25QM9ww3/RjHRdoJ929MhO+ZGW8OhZ30zIRTdRid/YRMJDGL6hW9qPwt8mT4ZMxcREtBF+ltsS11vzdIPw1xhcEtqvMrNyfiODTIgS84ZThQEBfTUdAD3Ub8y5Xpy05mH2XX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZYBNsuS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZYBNsuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786348621; x=1817884621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K3dGZxx+dFdUL7gnm6sbE+ZMC4jTvvyK6dHc60lLDNg=;
  b=KZYBNsuS3rnPMXFFMmToQ8DSh6bFN1fQO+biDIHNzjYBaMZmKqgxuAFU
   T3oj4UtFTJaJkTyXnLHeXMxtcip6AXl7F65az3jxOpd0bLBGpbl5TUvvr
   x50XuDUZjgzE6cuvSbknnBodzrVV2XrxdLDdWdbzzU8V6Af7ziFupttyF
   DZP3ItHtpvMJIJObp1Z8WixhSTggvqdUyYJcjVYLVTCz6ch18yO2iiQ+z
   xnDvZasm7kLXfzUIjYyS0vaDgkWUOqtyIHE/WsUPbl9Tyl1W/7ihNkKJd
   1RfLEHYX7WnkrcP4IwCrqGi8g7Ne1ZlqUIcJz8GS2vhgZuOk/9LMef6eQ
   g==;
X-CSE-ConnectionGUID: NplBfpiVSdKQuLJ8KT2Ogw==
X-CSE-MsgGUID: imyTXlLCRPKxas4GolxJrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86615161"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86615161"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 00:57:00 -0700
X-CSE-ConnectionGUID: ZK3DD+3aS3aczdK1fDddXw==
X-CSE-MsgGUID: h0HSaT1WTHqmvps8KTSS2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="256756179"
Received: from os-delivery.igk.intel.com ([10.123.220.8])
  by fmviesa009.fm.intel.com with ESMTP; 10 Aug 2026 00:56:53 -0700
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
Subject: [iwl-next] ixgbe: implement Total Port Shutdown for E610
Date: Mon, 10 Aug 2026 09:56:52 +0200
Message-ID: <20260810075652.27915-1-tomasz.lichwala@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement Total Port Shutdown (TPS) for E610. When TPS is provisioned
in the NVM (by the platform firmware), the port's PHY is powered down
whenever the interface is administratively down.

When the PORT_DIS bit is set in the Link Default Override TLV in
the NVM PFA area, enable Total Port Shutdown (TPS). This forces the
link-down-on-close private flag and prevents the user from changing
it via ethtool, ensuring the PHY is powered down when the interface
is brought down as provisioned in the NVM.

The Link Default Override TLV (0x134) is read from the NVM PFA during
driver init. Each port has its own 10-word configuration block within
the TLV. If the PORT_DIS bit is set in the port's link_options field,
the driver sets both TOTAL_PORT_SHUTDOWN_ENA and LINK_DOWN_ON_CLOSE
flags.

Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 38 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  2 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 13 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 14 ++++++-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 13 +++++++
 6 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 02e7d6f0d852..41f43294465b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -684,6 +684,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_API_MISMATCH		BIT(23)
 #define IXGBE_FLAG2_FW_ROLLBACK			BIT(24)
 #define IXGBE_FLAG2_LINK_DOWN_ON_CLOSE		BIT(25)
+#define IXGBE_FLAG2_TOTAL_PORT_SHUTDOWN_ENA	BIT(26)
 
 	/* Tx fast path data */
 	int num_tx_queues;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index c92a586ee9b6..46a7c3ef7396 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -4051,6 +4051,44 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
 	return -ENODATA;
 }
 
+/**
+ * ixgbe_get_link_default_override - Get link default override from NVM
+ * @hw: pointer to hardware structure
+ * @ldo: pointer to link default override struct to populate
+ *
+ * Read the Link Default Override TLV from the NVM PFA and return
+ * the per-port override configuration.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int ixgbe_get_link_default_override(struct ixgbe_hw *hw,
+				    struct ixgbe_link_default_override_tlv *ldo)
+{
+	struct ixgbe_adapter *adapter = hw->back;
+	u16 tlv, tlv_len;
+	u32 tlv_start;
+	u8 pf_func;
+	int err;
+
+	err = ixgbe_get_pfa_module_tlv(hw, &tlv, &tlv_len,
+				       IXGBE_E610_SR_LINK_DEFAULT_OVERRIDE_PTR);
+	if (err)
+		return err;
+
+	pf_func = PCI_FUNC(adapter->pdev->devfn);
+
+	tlv_start = tlv + IXGBE_E610_SR_PFA_TLV_HDR_SIZE +
+		    pf_func * IXGBE_E610_SR_PFA_LINK_OVERRIDE_WORDS;
+
+	if (tlv_start + IXGBE_E610_SR_PFA_LINK_OVERRIDE_WORDS >
+	    tlv + IXGBE_E610_SR_PFA_TLV_HDR_SIZE + tlv_len)
+		return -ERANGE;
+
+	return ixgbe_read_ee_aci_buffer_e610(hw, tlv_start,
+					     IXGBE_E610_SR_PFA_LINK_OVERRIDE_WORDS,
+					     (u16 *)ldo);
+}
+
 /**
  * ixgbe_read_pba_string_e610 - Read PBA string from NVM
  * @hw: pointer to hardware structure
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 1f4c8b022698..fc96d67e018e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -82,6 +82,8 @@ int ixgbe_read_ee_aci_e610(struct ixgbe_hw *hw, u16 offset, u16 *data);
 int ixgbe_read_ee_aci_buffer_e610(struct ixgbe_hw *hw, u16 offset,
 				  u16 words, u16 *data);
 int ixgbe_validate_eeprom_checksum_e610(struct ixgbe_hw *hw, u16 *checksum_val);
+int ixgbe_get_link_default_override(struct ixgbe_hw *hw,
+				    struct ixgbe_link_default_override_tlv *ldo);
 int ixgbe_reset_hw_e610(struct ixgbe_hw *hw);
 int ixgbe_get_flash_data(struct ixgbe_hw *hw);
 int ixgbe_aci_nvm_update_empr(struct ixgbe_hw *hw);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 6a35630f8421..1e1db8435506 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3852,6 +3852,19 @@ static int ixgbe_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 		}
 	}
 
+	/* Do not allow any change to link-down-on-close when Total Port
+	 * Shutdown is enabled - the flag is managed by TPS exclusively.
+	 */
+	if (adapter->flags2 & IXGBE_FLAG2_TOTAL_PORT_SHUTDOWN_ENA) {
+		bool cur = !!(adapter->flags2 & IXGBE_FLAG2_LINK_DOWN_ON_CLOSE);
+		bool req = !!(priv_flags & IXGBE_PRIV_LINK_DOWN_ON_CLOSE);
+
+		if (req != cur) {
+			e_warn(probe, "Setting link-down-on-close not supported on this port\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	flags2 &= ~IXGBE_FLAG2_LINK_DOWN_ON_CLOSE;
 	if (priv_flags & IXGBE_PRIV_LINK_DOWN_ON_CLOSE) {
 		if (adapter->hw.mac.type == ixgbe_mac_e610) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 79d5d652d3cf..5f8f9884cbea 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7001,9 +7001,21 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	if (hw->mac.ops.init_swfw_sync)
 		hw->mac.ops.init_swfw_sync(hw);
 
-	if (hw->mac.type == ixgbe_mac_e610)
+	if (hw->mac.type == ixgbe_mac_e610) {
+		struct ixgbe_link_default_override_tlv ldo = {};
+		int err;
+
 		mutex_init(&hw->aci.lock);
 
+		err = ixgbe_get_link_default_override(hw, &ldo);
+		if (!err && (ldo.link_options & IXGBE_LINK_OVERRIDE_PORT_DIS)) {
+			adapter->flags2 |=
+				IXGBE_FLAG2_TOTAL_PORT_SHUTDOWN_ENA |
+				IXGBE_FLAG2_LINK_DOWN_ON_CLOSE;
+			e_dev_info("Total Port Shutdown enabled\n");
+		}
+	}
+
 #ifdef IXGBE_FCOE
 	/* FCoE support exists, always init the FCoE lock */
 	spin_lock_init(&adapter->fcoe.lock);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 959cacecae49..43e2d3e1cd59 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -29,6 +29,19 @@
 #define IXGBE_E610_SR_NETLIST_BANK_PTR		0x46
 #define IXGBE_E610_SR_NETLIST_BANK_SIZE		0x47
 
+/* Link Default Override TLV in PFA */
+#define IXGBE_E610_SR_LINK_DEFAULT_OVERRIDE_PTR	0x134
+#define IXGBE_E610_SR_PFA_LINK_OVERRIDE_WORDS	10
+#define IXGBE_E610_SR_PFA_TLV_HDR_SIZE		2
+
+#define IXGBE_LINK_OVERRIDE_PORT_DIS		BIT(2)
+
+struct ixgbe_link_default_override_tlv {
+	u16 link_options;
+	u16 phy_options;
+	u16 phy_types[8];
+};
+
 /* The OROM version topology */
 #define IXGBE_OROM_VER_PATCH_MASK		GENMASK_ULL(7, 0)
 #define IXGBE_OROM_VER_BUILD_MASK		GENMASK_ULL(23, 8)
-- 
2.54.0

