Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BA44D796A
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548177; cv=none; b=jDPjXpokBuZPLJSgA0GTb44C8pJIxuuQ0NUiX/vx1Y3qkkbJIq1dCte7jCBxCNhSui5325lhnfY12yq2RWbOvVLd3MMJjh53aZUerLYR0zO7PqSVWNWlEnsUZeSfodBhVqYbDgzsaAqPPIqJYM4RLO9eYp7/1L9HMrNAjtkfutk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548177; c=relaxed/simple;
	bh=k9es75hegqAddIvsJ4/lr0i+YP3glq/3OuyPBszFEmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5kS97lDQ6fhkzqCNgMiMJldojrOmdt20+Y6gMR0TROdKhHxuYOK57LttiWmGxqiERfi6Ry53P8SRnrRJJ54JNDdMmL3nAelEF2mC3SeSb869ZyLDWSzDsiy6F9xLhDE59wP2MtjIoyl61jciEJsE0dNBJPoSrsVfLuLnzLoaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODhO/Km0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODhO/Km0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791548154; x=1823084154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k9es75hegqAddIvsJ4/lr0i+YP3glq/3OuyPBszFEmE=;
  b=ODhO/Km0S0VjKHV9cPHNmHygOeg/khNyRJah80pmYMpIJr5XU10WgcLg
   yDINlE30DZiIgTpRElykHJf1qMXu4hDXmQhC1xnyqQr2au7UC53or0+2U
   7Bkv3neRMYCNg7stbgjnetxHEnhrLCVpimYm7/OkcyFabkywmX87+FbpC
   ubhbIE0KLcFNhsCWxEVewl4XE4poslrUZ9D6M275VQwOT/jZ4Zs93J2L/
   WAcK/DUO4RcvCDluifzznf9ZcWLjAsuXXB/WOEKWJgdU+3LKPgq0/NQqX
   O+hsMmZsiGGBHWfg4+8H4rtdlqpTSC3P0wbMst5MDPK+Y4SjSUyLMO1q3
   A==;
X-CSE-ConnectionGUID: xPYCRde4SkuuULIfDwn+vA==
X-CSE-MsgGUID: 5TdZZwcnSfWXLpuCQ2wcjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251286"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251286"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:15:16 -0700
X-CSE-ConnectionGUID: NAcmaEsrSKWAgze7LB/FIw==
X-CSE-MsgGUID: WP/+eJ0uTcuVwHzTl2DjGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420592"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:15:09 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2E9282879A;
	Fri,  9 Oct 2026 13:15:06 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Jonathan Corbet <corbet@lwn.net>,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	anzaki@gmail.com,
	brett.creeley@amd.com,
	jtornosm@redhat.com,
	ohartoov@nvidia.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 14/14] ice: support up to 256 VF queues
Date: Fri,  9 Oct 2026 14:04:25 +0200
Message-ID: <20261009121433.30347-15-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for up to 256 VF queues. To enable more than usual 16, user
needs to assign GLOBAL LUT (devlink resource named "rss/lut_512") for 64
queues or PF LUT (name "rss/lut_2048") for maximum of 256 queues. There is
a need to assign the GLOBAL LUT to PF first, then release the PF LUT
(initially assigned to PF) from PF, to finally assign it to VF, see
examples further below. Usual default of number of CPU cores does still
apply, but queues could be requested later by usual ethtool -L command.

Add devlink instance of VF device to track RSS LUT resources under
a respective PF devlink instance.

Number of MSI-X vectors assigned to VF is orthogonal to this.

Note that VF reset is deferred to service task.

How to use:
1. Up to 64 queues
   a. assign one of 16 GLOBAL LUTs to VF:
      sudo devlink resource set pci/0000:18:01.0 path rss/lut_512 size 1
   b. if more queues than the default (num of vCPU/CPU cores) are wanted:
      sudo ethtool -L $vfiface combined $more

2. Up to 256 queues
   a. assign a GLOBAL LUT to PF:
      sudo devlink resource set pci/0000:18:00.0 path rss/lut_512 size 1
   b. free the PF LUT from PF:
      sudo devlink resource set pci/0000:18:00.0 path rss/lut_2048 size 0
   c. assign the PF LUT to VF:
      sudo devlink resource set pci/0000:18:01.0 path rss/lut_2048 size 1
   d. if more queues than the default (num of vCPU/CPU cores) are wanted:
      sudo ethtool -L $vfiface combined $more

3. display current RSS LUT or RSS table:
   a. see if RSS is mapped correctly (e.g. for lut_512 there are 512
      entries expected):
      ethtool -x $vfiface
   b. see what devlink devices are present:
      devlink dev show # note the "whole dev aggregate" device over your pci netdevs
   c. see PF, VF, and "whole device aggregate" resources:
      devlink resource show pci/0000:18:00.0 # PF
      devlink resource show pci/0000:18:01.0 # VF
      devlink resource show devlink_index/3 # whole dev

output will look like below, for a device with one PF LUT and one GLOBAL LUT:
pci/0000:18:00.0:
  name rss size 2 unit entry size_min 0 size_max 2 size_gran 1 dpipe_tables none
    resources:
      name lut_512 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
      name lut_2048 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none

Big thanks to Mateusz for working together on the whole story for long
time! Big thanks to Alex Loktionov for pointing the reason of one nasty
bug with the message size!

Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
 * drop getting VF ref around vf->needs_deferred_reset, it only opened
   a window for resource leak and was not needed anyway (Sashiko)
 * replace needs_deferred_reset bitfield with ICE_VF_STATE_NEEDS_RESET
   bit, consumed by test_and_clear_bit() before the reset, so a request
   coming in during the reset is not lost
 * take vfs.table_lock in service task only when a deferred VF reset
   is pending, so freshly enabled VFs do not time out on
   VIRTCHNL_OP_VERSION
 * add !CONFIG_PCI_IOV stub for ice_schedule_vf_reset()
 * create VF devlink in ice_start_vfs() under vfs.table_lock instead
   of lazily from the virtchnl handler; take PF devlink lock around
   devl_nested_devlink_set(); handle VF without devlink on teardown
 * take cfg_lock before the adapter devlink lock in VF resource setters,
   and reject changes while the VF is not ready (ice_vf_is_ready())
 * switch VF VSI context to the new LUT synchronously, so HW no longer
   uses the old LUT when it is released
 * use logical_pf_id for VF allocation of PF LUT slots
 * report the RSS qregion width from LUT capacity, and reject VF queue
   requests above it
 * keep clamping rss_size to num_rxq for non-VF VSIs, so after
   ethtool -L and PF reset the LUT does not point at absent queues
 * limit PF rss_size to the queue capacity of its current RSS LUT
   (64 for GLOBAL), on devlink LUT switch and on ethtool -L; restore it
   from num_rxq when switching back to the PF LUT
 * drop ICE_VSI_FLAG_RELOAD, it was set but never tested (and
   overwritten on VF reset anyway)
 * use ice_get_vf_vsi() instead of open coding it (Sashiko)
 * commit message: the whole device aggregate is a shared devlink
   instance (devlink_index/N), not a faux device
 * check devl_nested_devlink_set() return value (Sashiko)
---
 .../net/ethernet/intel/ice/devlink/resource.h |   3 +
 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  23 ++++
 drivers/net/ethernet/intel/ice/virt/rss.h     |   1 +
 .../net/ethernet/intel/ice/virt/virtchnl.h    |   4 +
 .../net/ethernet/intel/ice/devlink/resource.c | 121 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  14 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  31 ++++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  25 ++++
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  11 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  57 +++++++++
 drivers/net/ethernet/intel/ice/virt/queues.c  |   7 +
 drivers/net/ethernet/intel/ice/virt/rss.c     |  37 +++++-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |  42 +++++-
 15 files changed, 357 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/resource.h b/drivers/net/ethernet/intel/ice/devlink/resource.h
index 8999e0413c51..956e0f7368a6 100644
--- a/drivers/net/ethernet/intel/ice/devlink/resource.h
+++ b/drivers/net/ethernet/intel/ice/devlink/resource.h
@@ -10,14 +10,17 @@ struct devlink;
 struct ice_adapter;
 struct ice_hw;
 struct ice_pf;
+struct ice_vf;
 
+void ice_devlink_vf_resources_register(struct ice_vf *vf);
 void ice_devl_pf_resources_register(struct ice_pf *pf);
 void ice_devl_whole_dev_resources_register(const struct ice_hw *hw,
 					   struct ice_adapter *adapter);
 
 bool ice_rss_lut_is_reassigned(struct ice_pf *pf);
 int ice_take_rss_lut_pf(struct ice_pf *pf);
 void ice_release_rss_lut_pf(struct ice_pf *pf);
 void ice_free_rss_lut_flr(struct ice_pf *pf);
+void ice_free_rss_lut_vf(struct ice_vf *vf);
 
 #endif /* _ICE_DEVL_RESOURCE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index d28ff576a342..fac1cb124d11 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -297,6 +297,7 @@ enum ice_pf_state {
 	ICE_SIDEBANDQ_EVENT_PENDING,
 	ICE_MDD_EVENT_PENDING,
 	ICE_VFLR_EVENT_PENDING,
+	ICE_VF_RESET_PENDING,
 	ICE_FLTR_OVERFLOW_PROMISC,
 	ICE_VF_DIS,
 	ICE_CFG_BUSY,
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 15b65a757beb..320edbdece3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -18,6 +18,8 @@ enum ice_l2tsel {
 	ICE_L2TSEL_EXTRACT_FIRST_TAG_L2TAG1,
 };
 
+u16 ice_lut_type_to_qs_num(enum ice_lut_type lut_type);
+
 const char *ice_vsi_type_str(enum ice_vsi_type vsi_type);
 
 bool ice_pf_state_is_nominal(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 396dfb2b2d97..8abc8c844c96 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -40,6 +40,7 @@ enum ice_vf_states {
 	ICE_VF_STATE_DIS,
 	ICE_VF_STATE_MC_PROMISC,
 	ICE_VF_STATE_UC_PROMISC,
+	ICE_VF_STATE_NEEDS_RESET,	/* reset deferred to service task */
 	ICE_VF_STATES_NBITS
 };
 
@@ -145,6 +146,7 @@ struct ice_vf {
 	struct kref refcnt;
 	struct ice_pf *pf;
 	struct pci_dev *vfdev;
+	struct devlink *devlink;
 	/* Used during virtchnl message handling and NDO ops against the VF
 	 * that will trigger a VFR
 	 */
@@ -243,6 +245,12 @@ static inline bool ice_vf_is_lldp_ena(struct ice_vf *vf)
 	return vf->num_mac_lldp && vf->trusted;
 }
 
+static inline bool ice_vf_is_ready(struct ice_vf *vf)
+{
+	return test_bit(ICE_VF_STATE_INIT, vf->vf_states) &&
+	       !test_bit(ICE_VF_STATE_DIS, vf->vf_states);
+}
+
 /* VF Hash Table access functions
  *
  * These functions provide abstraction for interacting with the VF hash table.
@@ -319,9 +327,12 @@ int
 ice_vf_clear_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 promisc_m);
 int ice_reset_vf(struct ice_vf *vf, u32 flags);
 void ice_reset_all_vfs(struct ice_pf *pf);
+void ice_schedule_vf_reset(struct ice_vf *vf);
 struct ice_vsi *ice_get_vf_ctrl_vsi(struct ice_pf *pf, struct ice_vsi *vsi);
 void ice_vf_update_mac_lldp_num(struct ice_vf *vf, struct ice_vsi *vsi,
 				bool incr);
+void ice_init_vf_devlink(struct ice_vf *vf);
+void ice_deinit_vf_devlink(struct ice_vf *vf);
 #else /* CONFIG_PCI_IOV */
 static inline struct ice_vf *ice_get_vf_by_id(struct ice_pf *pf, u16 vf_id)
 {
@@ -393,11 +404,23 @@ static inline void ice_reset_all_vfs(struct ice_pf *pf)
 {
 }
 
+static inline void ice_schedule_vf_reset(struct ice_vf *vf)
+{
+}
+
 static inline struct ice_vsi *
 ice_get_vf_ctrl_vsi(struct ice_pf *pf, struct ice_vsi *vsi)
 {
 	return NULL;
 }
+
+static inline void ice_init_vf_devlink(struct ice_vf *vf)
+{
+}
+
+static inline void ice_deinit_vf_devlink(struct ice_vf *vf)
+{
+}
 #endif /* !CONFIG_PCI_IOV */
 
 #endif /* _ICE_VF_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/virt/rss.h b/drivers/net/ethernet/intel/ice/virt/rss.h
index 784d4c43ce8b..388f980b4cdf 100644
--- a/drivers/net/ethernet/intel/ice/virt/rss.h
+++ b/drivers/net/ethernet/intel/ice/virt/rss.h
@@ -14,5 +14,6 @@ int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg);
 int ice_vc_config_rss_hfunc(struct ice_vf *vf, u8 *msg);
 int ice_vc_get_rss_hashcfg(struct ice_vf *vf);
 int ice_vc_set_rss_hashcfg(struct ice_vf *vf, u8 *msg);
+int ice_vc_get_max_rss_qregion(struct ice_vf *vf);
 
 #endif /* _ICE_VIRT_RSS_H_ */
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.h b/drivers/net/ethernet/intel/ice/virt/virtchnl.h
index d11789b3ae1f..18024f13fb5d 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.h
@@ -78,6 +78,10 @@ struct ice_virtchnl_ops {
 	int (*get_ptp_cap)(struct ice_vf *vf,
 			   const struct virtchnl_ptp_caps *msg);
 	int (*get_phc_time)(struct ice_vf *vf);
+	int (*get_max_rss_qregion)(struct ice_vf *vf);
+	int (*ena_qs_v2_msg)(struct ice_vf *vf, u8 *msg, u16 msglen);
+	int (*dis_qs_v2_msg)(struct ice_vf *vf, u8 *msg, u16 msglen);
+	int (*map_q_vector_msg)(struct ice_vf *vf, u8 *msg, u16 msglen);
 };
 
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/net/ethernet/intel/ice/devlink/resource.c b/drivers/net/ethernet/intel/ice/devlink/resource.c
index 09672da3ad39..a6c99d6c311f 100644
--- a/drivers/net/ethernet/intel/ice/devlink/resource.c
+++ b/drivers/net/ethernet/intel/ice/devlink/resource.c
@@ -107,6 +107,16 @@ void ice_free_rss_lut_flr(struct ice_pf *pf)
 	}
 }
 
+void ice_free_rss_lut_vf(struct ice_vf *vf)
+{
+	struct ice_pf *pf = vf->pf;
+
+	scoped_guard(ice_adapter_devl, pf->adapter) {
+		ice_devl_res_free(pf, ICE_RSS_LUT_GLOBAL, vf);
+		ice_devl_res_free(pf, ICE_RSS_LUT_PF, vf);
+	}
+}
+
 static int ice_devl_res_owned_idx(struct ice_adapter *adapter,
 				  enum ice_devl_resource_id res_id, void *owner)
 {
@@ -178,6 +188,37 @@ static u64 ice_rss_lut_pf_occ_get_both(void *priv)
 		       ice_is_devl_res_owned_by(adapter, ICE_RSS_LUT_GLOBAL, pf);
 }
 
+static u64 ice_rss_lut_vf_occ_get_global(void *priv)
+{
+	struct ice_adapter *adapter;
+	struct ice_vf *vf = priv;
+
+	adapter = vf->pf->adapter;
+	scoped_guard(ice_adapter_devl, adapter)
+		return ice_is_devl_res_owned_by(adapter, ICE_RSS_LUT_GLOBAL, vf);
+}
+
+static u64 ice_rss_lut_vf_occ_get_pf(void *priv)
+{
+	struct ice_adapter *adapter;
+	struct ice_vf *vf = priv;
+
+	adapter = vf->pf->adapter;
+	scoped_guard(ice_adapter_devl, adapter)
+		return ice_is_devl_res_owned_by(adapter, ICE_RSS_LUT_PF, vf);
+}
+
+static u64 ice_rss_lut_vf_occ_get_both(void *priv)
+{
+	struct ice_adapter *adapter;
+	struct ice_vf *vf = priv;
+
+	adapter = vf->pf->adapter;
+	scoped_guard(ice_adapter_devl, adapter)
+		return ice_is_devl_res_owned_by(adapter, ICE_RSS_LUT_PF, vf) +
+		       ice_is_devl_res_owned_by(adapter, ICE_RSS_LUT_GLOBAL, vf);
+}
+
 static int ice_devl_resource_deny_occ_set(u64 size,
 					  struct netlink_ext_ack *extack,
 					  void *priv)
@@ -223,7 +264,9 @@ static int ice_maybe_change_rss_lut(struct ice_pf *pf, void *owner,
 	struct ice_hw *hw = &pf->hw;
 	enum ice_lut_type lut_type;
 	int err, lut_size, lut_id;
+	struct ice_vf *vf = NULL;
 	struct ice_vsi *vsi;
+	u16 rss_size;
 	u8 *lut;
 
 	if (old & new & ICE_HAS_PF_LUT)
@@ -249,14 +292,16 @@ static int ice_maybe_change_rss_lut(struct ice_pf *pf, void *owner,
 	if (pf == owner) {
 		vsi = ice_get_main_vsi(pf);
 	} else {
-		return -EOPNOTSUPP;
+		vf = owner;
+		vsi = ice_get_vf_vsi(vf);
 	}
 
 	lut_size = ice_lut_type_to_size(lut_type);
 	lut = kmalloc(lut_size, GFP_KERNEL);
 	if (!lut)
 		return -ENOMEM;
-	ice_fill_rss_lut(lut, lut_size, vsi->rss_size);
+	rss_size = min(vsi->num_rxq, ice_lut_type_to_qs_num(lut_type));
+	ice_fill_rss_lut(lut, lut_size, rss_size);
 	params.lut = lut;
 	params.lut_size = lut_size;
 	params.lut_type = lut_type;
@@ -278,6 +323,12 @@ static int ice_maybe_change_rss_lut(struct ice_pf *pf, void *owner,
 		vsi->global_lut_id = params.global_lut_id;
 	vsi->rss_table_size = lut_size;
 	vsi->rss_lut_type = lut_type;
+	if (vf) {
+		vsi->rss_size = ice_lut_type_to_qs_num(lut_type);
+		ice_schedule_vf_reset(vf);
+	} else {
+		vsi->rss_size = rss_size;
+	}
 out:
 	mutex_unlock(&pf->rss_lut_lock);
 	kfree(lut);
@@ -374,6 +425,41 @@ static int ice_rss_lut_pf_occ_set_global(u64 size,
 					   ICE_ANY_SLOT, extack);
 }
 
+static int ice_rss_lut_vf_occ_set_pf(u64 size, struct netlink_ext_ack *extack,
+				     void *occ_priv)
+{
+	struct ice_vf *vf = occ_priv;
+	struct ice_pf *pf = vf->pf;
+	int pf_id;
+
+	pf_id = pf->hw.logical_pf_id;
+	scoped_guard(mutex, &vf->cfg_lock) {
+		if (!ice_vf_is_ready(vf))
+			return -EBUSY;
+
+		scoped_guard(ice_adapter_devl, pf->adapter)
+			return ice_devl_res_change(size, ICE_RSS_LUT_PF, pf, vf,
+						   pf_id, extack);
+	}
+}
+
+static int ice_rss_lut_vf_occ_set_global(u64 size,
+					 struct netlink_ext_ack *extack,
+					 void *occ_priv)
+{
+	struct ice_vf *vf = occ_priv;
+	struct ice_pf *pf = vf->pf;
+
+	scoped_guard(mutex, &vf->cfg_lock) {
+		if (!ice_vf_is_ready(vf))
+			return -EBUSY;
+
+		scoped_guard(ice_adapter_devl, pf->adapter)
+			return ice_devl_res_change(size, ICE_RSS_LUT_GLOBAL, pf,
+						   vf, ICE_ANY_SLOT, extack);
+	}
+}
+
 /**
  * ice_rss_lut_is_reassigned - check if RSS LUTs of PF are in non-default state
  * @pf: the PF to check
@@ -525,3 +611,34 @@ void ice_devl_pf_resources_register(struct ice_pf *pf)
 	devl_assert_locked(devlink);
 	ice_devl_res_register(devlink, pf_resources, pf);
 }
+
+void ice_devlink_vf_resources_register(struct ice_vf *vf)
+{
+	struct ice_devl_resource vf_resources[ICE_DEVL_RESOURCES_COUNT] = {
+		[ICE_RSS_LUT_GLOBAL] = {
+			.name = "lut_512",
+			.parent_id = ICE_RSS_LUT_BOTH,
+			.max_size = 1,
+			.get = ice_rss_lut_vf_occ_get_global,
+			.set = ice_rss_lut_vf_occ_set_global,
+		},
+		[ICE_RSS_LUT_PF] = {
+			.name = "lut_2048",
+			.parent_id = ICE_RSS_LUT_BOTH,
+			.max_size = 1,
+			.get = ice_rss_lut_vf_occ_get_pf,
+			.set = ice_rss_lut_vf_occ_set_pf,
+		},
+		[ICE_RSS_LUT_BOTH] = {
+			.name = "rss",
+			.parent_id = ICE_TOP_RESOURCE,
+			.max_size = 2,
+			.get = ice_rss_lut_vf_occ_get_both,
+			.set = ice_devl_resource_deny_occ_set,
+		},
+	};
+	struct devlink *devlink = vf->devlink;
+
+	scoped_guard(devl, devlink)
+		ice_devl_res_register(devlink, vf_resources, vf);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 5b68e6802c74..1f910058d8c8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3839,14 +3839,15 @@ ice_get_channels(struct net_device *dev, struct ethtool_channels *ch)
 
 /**
  * ice_get_valid_rss_size - return valid number of RSS queues
- * @hw: pointer to the HW structure
+ * @vsi: VSI to get the RSS LUT type of
  * @new_size: requested RSS queues
  */
-static int ice_get_valid_rss_size(struct ice_hw *hw, int new_size)
+static int ice_get_valid_rss_size(struct ice_vsi *vsi, int new_size)
 {
-	struct ice_hw_common_caps *caps = &hw->func_caps.common_cap;
+	struct ice_hw_common_caps *caps = &vsi->back->hw.func_caps.common_cap;
 
-	return min_t(int, new_size, BIT(caps->rss_table_entry_width));
+	new_size = min_t(int, new_size, BIT(caps->rss_table_entry_width));
+	return min_t(int, new_size, ice_lut_type_to_qs_num(vsi->rss_lut_type));
 }
 
 /**
@@ -3879,7 +3880,7 @@ static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
 		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags))
 			vsi->rss_size = 1;
 		else
-			vsi->rss_size = ice_get_valid_rss_size(hw,
+			vsi->rss_size = ice_get_valid_rss_size(vsi,
 							       req_rss_size);
 
 		/* create/set RSS LUT */
@@ -3976,7 +3977,8 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 	}
 
 	/* Update rss_size due to change in Rx queues */
-	vsi->rss_size = ice_get_valid_rss_size(&pf->hw, new_rx);
+	scoped_guard(mutex, &pf->rss_lut_lock)
+		vsi->rss_size = ice_get_valid_rss_size(vsi, new_rx);
 
 adev_unlock:
 	if (locked) {
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index ad43d52ea83c..43c8bfedbea2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -12,6 +12,23 @@
 
 #include "devlink/resource.h"
 
+#define ICE_LUT_VSI_MAX_QS	16
+#define ICE_LUT_GLOBAL_MAX_QS	64
+#define ICE_LUT_PF_MAX_QS	256
+
+u16 ice_lut_type_to_qs_num(enum ice_lut_type lut_type)
+{
+	switch (lut_type) {
+	case ICE_LUT_PF:
+		return ICE_LUT_PF_MAX_QS;
+	case ICE_LUT_GLOBAL:
+		return ICE_LUT_GLOBAL_MAX_QS;
+	case ICE_LUT_VSI:
+	default:
+		return ICE_LUT_VSI_MAX_QS;
+	}
+}
+
 /**
  * ice_vsi_type_str - maps VSI type enum to string equivalents
  * @vsi_type: VSI type enum
@@ -1663,7 +1680,9 @@ int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi)
 	    (test_bit(ICE_FLAG_TC_MQPRIO, pf->flags))) {
 		vsi->rss_size = min_t(u16, vsi->rss_size, vsi->ch_rss_size);
 	} else {
-		vsi->rss_size = min_t(u16, vsi->rss_size, vsi->num_rxq);
+		/* VF rss_size is the queue capacity of its LUT, keep it */
+		if (vsi->type != ICE_VSI_VF)
+			vsi->rss_size = min_t(u16, vsi->rss_size, vsi->num_rxq);
 
 		/* If orig_rss_size is valid and it is less than determined
 		 * main VSI's rss_size, update main VSI's rss_size to be
@@ -2697,11 +2716,11 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 	if (vsi->flags & ICE_VSI_FLAG_INIT) {
 		if (vsi->type == ICE_VSI_PF) {
 			ice_free_rss_lut_flr(pf);
-			/* reset restores PF LUT, user LUT has wrong size */
-			if (vsi->rss_lut_type != ICE_LUT_PF) {
-				devm_kfree(ice_pf_to_dev(pf), vsi->rss_lut_user);
-				vsi->rss_lut_user = NULL;
-			}
+		} else if (vsi->type == ICE_VSI_VF) {
+			struct ice_vf *vf = vsi->vf;
+
+			vf->num_req_qs = 0;
+			vf->num_vf_qs = min(vf->num_vf_qs, pf->vfs.num_qps_per);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fec25a362cb1..f86f4d7d7f55 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2274,6 +2274,30 @@ static void ice_check_media_subtask(struct ice_pf *pf)
 	}
 }
 
+static void ice_handle_deferred_vf_reset(struct ice_pf *pf)
+{
+	struct ice_vf *vf;
+	unsigned int bkt;
+	int err;
+
+	if (!test_and_clear_bit(ICE_VF_RESET_PENDING, pf->state))
+		return;
+
+	mutex_lock(&pf->vfs.table_lock);
+	ice_for_each_vf(pf, bkt, vf) {
+		if (!test_and_clear_bit(ICE_VF_STATE_NEEDS_RESET, vf->vf_states))
+			continue;
+
+		dev_info(ice_pf_to_dev(pf), "doing deferred reset of VF %d\n",
+			 vf->vf_id);
+		err = ice_reset_vf(vf, ICE_VF_RESET_NOTIFY | ICE_VF_RESET_LOCK);
+		if (err)
+			dev_warn(ice_pf_to_dev(pf), "deferred reset of VF %d failed: %d\n",
+				 vf->vf_id, err);
+	}
+	mutex_unlock(&pf->vfs.table_lock);
+}
+
 static void ice_service_task_recovery_mode(struct work_struct *work)
 {
 	struct ice_pf *pf = container_of(work, struct ice_pf, serv_task);
@@ -2356,6 +2380,7 @@ static void ice_service_task(struct work_struct *work)
 		return;
 	}
 
+	ice_handle_deferred_vf_reset(pf);
 	ice_process_vflr_event(pf);
 	ice_clean_mailboxq_subtask(pf);
 	ice_clean_sbq_subtask(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index d7c4a6540008..c86c4b96a016 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -494,6 +494,7 @@ static int ice_start_vfs(struct ice_pf *pf)
 			}
 		}
 
+		ice_init_vf_devlink(vf);
 		set_bit(ICE_VF_STATE_INIT, vf->vf_states);
 		ice_ena_vf_mappings(vf);
 		wr32(hw, VFGEN_RSTAT(vf->vf_id), VIRTCHNL_VFR_VFACTIVE);
@@ -657,6 +658,15 @@ static void ice_sriov_post_vsi_rebuild(struct ice_vf *vf)
 	wr32(&vf->pf->hw, VFGEN_RSTAT(vf->vf_id), VIRTCHNL_VFR_VFACTIVE);
 }
 
+static struct ice_q_vector *ice_sriov_get_q_vector(struct ice_vsi *vsi,
+						   u16 vector_id)
+{
+	/* Subtract non queue vector from vector_id passed by VF
+	 * to get actual number of VSI queue vector array index
+	 */
+	return vsi->q_vectors[vector_id - ICE_NONQ_VECS_VF];
+}
+
 static const struct ice_vf_ops ice_sriov_vf_ops = {
 	.reset_type = ICE_VF_RESET,
 	.free = ice_sriov_free_vf,
@@ -667,6 +677,7 @@ static const struct ice_vf_ops ice_sriov_vf_ops = {
 	.clear_reset_trigger = ice_sriov_clear_reset_trigger,
 	.irq_close = NULL,
 	.post_vsi_rebuild = ice_sriov_post_vsi_rebuild,
+	.get_q_vector = ice_sriov_get_q_vector,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 320b393ddaaf..6bc71cdc624c 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -6,6 +6,7 @@
 #include "ice_lib.h"
 #include "ice_fltr.h"
 #include "virt/allowlist.h"
+#include "devlink/resource.h"
 
 /* Public functions which may be accessed by all driver files */
 
@@ -1010,6 +1011,18 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 	return err;
 }
 
+/**
+ * ice_schedule_vf_reset - reset VF, deferred to next service_task context
+ * @vf: VF to reset
+ */
+void ice_schedule_vf_reset(struct ice_vf *vf)
+{
+	set_bit(ICE_VF_STATE_NEEDS_RESET, vf->vf_states);
+	/* pairs with test_and_clear_bit() in ice_handle_deferred_vf_reset() */
+	smp_mb__after_atomic();
+	set_bit(ICE_VF_RESET_PENDING, vf->pf->state);
+}
+
 /**
  * ice_set_vf_state_dis - Set VF state to disabled
  * @vf: pointer to the VF structure
@@ -1064,6 +1077,9 @@ void ice_deinitialize_vf_entry(struct ice_vf *vf)
 {
 	struct ice_pf *pf = vf->pf;
 
+	ice_free_rss_lut_vf(vf);
+	ice_deinit_vf_devlink(vf);
+
 	if (!ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
 		list_del(&vf->mbx_info.list_entry);
 }
@@ -1450,3 +1466,44 @@ void ice_vf_update_mac_lldp_num(struct ice_vf *vf, struct ice_vsi *vsi,
 	if (was_ena != is_ena)
 		ice_vsi_cfg_sw_lldp(vsi, false, is_ena);
 }
+
+void ice_init_vf_devlink(struct ice_vf *vf)
+{
+	struct devlink *pf_devlink = priv_to_devlink(vf->pf);
+	static const struct devlink_ops noop = {};
+	struct devlink *devlink;
+	int err;
+
+	lockdep_assert_held(&vf->pf->vfs.table_lock);
+
+	devlink = devlink_alloc(&noop, 0, &vf->vfdev->dev);
+	if (!devlink)
+		return;
+
+	scoped_guard(devl, pf_devlink)
+		err = devl_nested_devlink_set(pf_devlink, devlink);
+	if (err) {
+		devlink_free(devlink);
+		return;
+	}
+
+	vf->devlink = devlink;
+	devlink_register(devlink);
+
+	ice_devlink_vf_resources_register(vf);
+}
+
+void ice_deinit_vf_devlink(struct ice_vf *vf)
+{
+	struct devlink *devlink = vf->devlink;
+
+	lockdep_assert_held(&vf->pf->vfs.table_lock);
+
+	if (!devlink)
+		return;
+
+	vf->devlink = NULL;
+	devlink_resources_unregister(devlink);
+	devlink_unregister(devlink);
+	devlink_free(devlink);
+}
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 3c5c5099a73d..57ef0696775b 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -1004,18 +1004,25 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 	u16 max_allowed_vf_queues;
 	u16 tx_rx_queue_left;
 	struct device *dev;
+	u16 max_lut_queues;
 	u16 cur_queues;
 
 	dev = ice_pf_to_dev(pf);
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
 	}
 
 	cur_queues = vf->num_vf_qs;
+	max_lut_queues = ice_lut_type_to_qs_num(ice_get_vf_vsi(vf)->rss_lut_type);
 	tx_rx_queue_left = min_t(u16, ice_get_avail_txq_count(pf),
 				 ice_get_avail_rxq_count(pf));
 	max_allowed_vf_queues = tx_rx_queue_left + cur_queues;
+	if (req_queues > max_lut_queues) {
+		vfres->num_queue_pairs = max_lut_queues;
+		goto error_param;
+	}
+
 	if (!req_queues) {
 		dev_err(dev, "VF %d tried to request 0 queues. Ignoring.\n",
 			vf->vf_id);
diff --git a/drivers/net/ethernet/intel/ice/virt/rss.c b/drivers/net/ethernet/intel/ice/virt/rss.c
index 960012ca91b5..0fb79ec1f9f7 100644
--- a/drivers/net/ethernet/intel/ice/virt/rss.c
+++ b/drivers/net/ethernet/intel/ice/virt/rss.c
@@ -3,6 +3,7 @@
 
 #include "rss.h"
 #include "ice_vf_lib_private.h"
+#include "ice_lib.h"
 #include "ice.h"
 
 #define FIELD_SELECTOR(proto_hdr_field) \
@@ -1746,7 +1747,13 @@ int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if (vrl->lut_entries != ICE_LUT_VSI_SIZE) {
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto error_param;
+	}
+
+	if (vrl->lut_entries != vsi->rss_table_size) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
 	}
@@ -1762,7 +1769,7 @@ int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if (ice_set_rss_lut(vsi, vrl->lut, ICE_LUT_VSI_SIZE))
+	if (ice_set_rss_lut(vsi, vrl->lut, vrl->lut_entries))
 		v_ret = VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
 error_param:
 	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_RSS_LUT, v_ret,
@@ -1920,3 +1927,29 @@ int ice_vc_set_rss_hashcfg(struct ice_vf *vf, u8 *msg)
 				     NULL, 0);
 }
 
+int ice_vc_get_max_rss_qregion(struct ice_vf *vf)
+{
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
+	struct virtchnl_max_rss_qregion max_rss_qregion = {};
+	struct ice_vsi *vsi;
+	int err, len = 0;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto reply;
+	}
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto reply;
+	}
+
+	len = sizeof(max_rss_qregion);
+	max_rss_qregion.vport_id = vsi->vsi_num;
+	max_rss_qregion.qregion_width = ilog2(ice_lut_type_to_qs_num(vsi->rss_lut_type));
+reply:
+	err = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_GET_MAX_RSS_QREGION, v_ret,
+				    (u8 *)&max_rss_qregion, len);
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
index ca8018e3dd42..d3b63032e402 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
@@ -246,10 +246,10 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 {
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_vf_resource *vfres = NULL;
+	int ret, allowed_queues, len = 0;
 	struct ice_hw *hw = &vf->pf->hw;
+	enum ice_lut_type lut_type;
 	struct ice_vsi *vsi;
-	int len = 0;
-	int ret;
 
 	if (ice_check_vf_init(vf)) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
@@ -330,16 +330,24 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_CAP_PTP;
 
 	vfres->num_vsis = 1;
-	/* Tx and Rx queue are equal for VF */
-	vfres->num_queue_pairs = vsi->num_txq;
+
+	lut_type = vsi->rss_lut_type;
+	if (vf->driver_caps & VIRTCHNL_VF_LARGE_NUM_QPAIRS &&
+	    lut_type != ICE_LUT_VSI) {
+		vfres->vf_cap_flags |= VIRTCHNL_VF_LARGE_NUM_QPAIRS;
+		allowed_queues = ice_lut_type_to_qs_num(lut_type);
+	} else {
+		allowed_queues = vsi->num_txq;
+	}
+	vfres->num_queue_pairs = allowed_queues;
 	vfres->max_vectors = vf->num_msix;
 	vfres->rss_key_size = ICE_VSIQF_HKEY_ARRAY_SIZE;
-	vfres->rss_lut_size = ICE_LUT_VSI_SIZE;
+	vfres->rss_lut_size = vsi->rss_table_size;
 	vfres->max_mtu = ice_vc_get_max_frame_size(vf);
 
 	vfres->vsi_res[0].vsi_id = ICE_VF_VSI_ID;
 	vfres->vsi_res[0].vsi_type = VIRTCHNL_VSI_SRIOV;
-	vfres->vsi_res[0].num_queue_pairs = vsi->num_txq;
+	vfres->vsi_res[0].num_queue_pairs = allowed_queues;
 	ether_addr_copy(vfres->vsi_res[0].default_mac_addr,
 			vf->hw_lan_addr);
 
@@ -2533,6 +2541,10 @@ static const struct ice_virtchnl_ops ice_virtchnl_dflt_ops = {
 	.cfg_q_quanta = ice_vc_cfg_q_quanta,
 	.get_ptp_cap = ice_vc_get_ptp_cap,
 	.get_phc_time = ice_vc_get_phc_time,
+	.get_max_rss_qregion = ice_vc_get_max_rss_qregion,
+	.ena_qs_v2_msg = ice_vc_ena_qs_v2_msg,
+	.dis_qs_v2_msg = ice_vc_dis_qs_v2_msg,
+	.map_q_vector_msg = ice_vc_map_q_vector_msg,
 	/* If you add a new op here please make sure to add it to
 	 * ice_virtchnl_repr_ops as well.
 	 */
@@ -2670,6 +2682,10 @@ static const struct ice_virtchnl_ops ice_virtchnl_repr_ops = {
 	.cfg_q_quanta = ice_vc_cfg_q_quanta,
 	.get_ptp_cap = ice_vc_get_ptp_cap,
 	.get_phc_time = ice_vc_get_phc_time,
+	.get_max_rss_qregion = ice_vc_get_max_rss_qregion,
+	.ena_qs_v2_msg = ice_vc_ena_qs_v2_msg,
+	.dis_qs_v2_msg = ice_vc_dis_qs_v2_msg,
+	.map_q_vector_msg = ice_vc_map_q_vector_msg,
 };
 
 /**
@@ -2901,6 +2917,20 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 	case VIRTCHNL_OP_GET_QOS_CAPS:
 		err = ops->get_qos_caps(vf);
 		break;
+	case VIRTCHNL_OP_GET_MAX_RSS_QREGION:
+		err = ops->get_max_rss_qregion(vf);
+		break;
+	case VIRTCHNL_OP_ENABLE_QUEUES_V2:
+		err = ops->ena_qs_v2_msg(vf, msg, msglen);
+		if (!err)
+			ice_vc_notify_vf_link_state(vf);
+		break;
+	case VIRTCHNL_OP_DISABLE_QUEUES_V2:
+		err = ops->dis_qs_v2_msg(vf, msg, msglen);
+		break;
+	case VIRTCHNL_OP_MAP_QUEUE_VECTOR:
+		err = ops->map_q_vector_msg(vf, msg, msglen);
+		break;
 	case VIRTCHNL_OP_CONFIG_QUEUE_BW:
 		err = ops->cfg_q_bw(vf, msg);
 		break;
-- 
2.51.1

