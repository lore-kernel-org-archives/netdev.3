Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0834B0E21
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638205; cv=none; b=DtLDtTVn8oohTutdGWHD/hW9c9mmT0+pxqcOYnPsle/yI5NCm1tbmlsxyYijQ/k+nZrN5Q9bstsFzncWzaetp9uBd6VvUJ6JXAmBZwgdwZAx4DNs4+t6e9VZgsUkn60gu9CveM9k9EpfiYrG2S6Xq9b5aUkNDg5pe42ay5GxRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638205; c=relaxed/simple;
	bh=/BAU9fM10RY8rU47cWaGcpIhfOTKVAOERSObnvW3YXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXXM9FvvbdZmzzQ81/jdsKK1qBLAULXnu504JdY2+YPCYbf5Ov/V/r3U70EJfk/Q2lVeGmQudwwAhD4dIsj/UINjYJeEsuDQLsgDTWcjigNHhnahsqtfyRw2Q87Rfi2tDbnFdMoFwhV1xy4KuVYWTL+xi97tHT7zjNhsWJjUlZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUxbf5lx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUxbf5lx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789638202; x=1821174202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/BAU9fM10RY8rU47cWaGcpIhfOTKVAOERSObnvW3YXs=;
  b=cUxbf5lx3CGSU2XwmFPxDtihlDCY1xcH9+084skOJ/DQirTAsNfs+rte
   HGzpt8XNKSyNwvwS0p0DrSf/Xm6jxCuxFT05miM6YS2Fhrn82kO1OB9Ps
   G+yP4YfhMzZoAEyKOA1Sn9cblHVJBIlxKAIXUR3dJjWiBNXH/zSFDlqhn
   sCCYpgiFLJsuWUCQB6woHO8/8KmjUI7ohsRYLOGHtzKmzn9UeqiUDZ+ku
   xcHLwYN0ekNnD1XxTpQHUO7XIcQKDXGoSVL77L5GOTTsa77qAVhOoF8XY
   tQdhUC4wKJzriiLW63kNJ0u/u51FPJjH3ccbGWt4A2JGZcEvwk1eIMJVg
   w==;
X-CSE-ConnectionGUID: GzsDOsMAQKqGG+JkcxtcdQ==
X-CSE-MsgGUID: 4VwnMKelQa+UP0FNO8Bs5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100706509"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100706509"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:43:20 -0700
X-CSE-ConnectionGUID: NUzE5kMeQJOpH/NnhcDf5A==
X-CSE-MsgGUID: L9mp1qzbS7Ot3OPFZ+KGxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269400593"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2026 02:43:17 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	e02905820face5404ac5eb8193ba94f9823c4606,
	Mon,
	Sep,
	17,
	00:00:00,
	2001,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Thu, 17 Sep 2026 11:43:12 +0200
Message-ID: <20260917094312.1567881-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917094312.1567881-1-aleksandr.loktionov@intel.com>
References: <20260917094312.1567881-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On eRoT adapters, firmware rejects partial NVM updates mid-session.
Detect this proactively before any flash writes by tracking which PLDM
components have been presented in ice_send_component_table().

All four authentication components must be present for an eRoT update:
NVM Bank, OROM, NetList, and Manifest.  If any are absent when
ice_flash_component() is called, reject with -EPERM and a clear
netlink error message before erasing any flash bank.

NVM_COMP_ID_MANIFEST only exists on eRoT adapters; the Shadow RAM
pointer backing it (module 0x4E) is unallocated on other hardware.
Accept it in ice_send_component_table() only when ICE_F_EROT is
supported, so a non-eRoT adapter still rejects it as an unknown
component before any flash write, same as before this patch. Its
activate-select flag is 0, since the ACTIV_SEL bitmask only defines
bits for NVM, OROM, and NetList.

Duplicate component IDs within a single PLDM image are also rejected
in ice_send_component_table() before the component table is sent to
firmware.

Unlike its NVM/OROM/NetList siblings, the manifest bank has no
ICE_SR_PQC_MANIFEST_BANK_SIZE counterpart: nothing reads the manifest
area size back via ice_read_sr_area_size(), so only the bank pointer
is defined.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 .../net/ethernet/intel/ice/ice_fw_update.c    | 80 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 3 files changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 42878ab..b240f2c 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1747,6 +1747,7 @@ struct ice_aqc_nvm_comp_tbl {
 #define NVM_COMP_ID_OROM	0x5
 #define NVM_COMP_ID_NVM		0x6
 #define NVM_COMP_ID_NETLIST	0x8
+#define NVM_COMP_ID_MANIFEST	0x12
 
 	u8 comp_class_idx;
 #define FWU_COMP_CLASS_IDX_NOT_USE 0x0
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index 3631461..fe68efa 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -9,6 +9,18 @@
 #include "ice_lib.h"
 #include "ice_fw_update.h"
 
+/* Bitmask values for ice_fwu_priv::seen_components */
+#define ICE_FWU_COMP_NVM		BIT(0)
+#define ICE_FWU_COMP_OROM		BIT(1)
+#define ICE_FWU_COMP_NETLIST		BIT(2)
+#define ICE_FWU_COMP_MANIFEST		BIT(3)
+/* Components required for a complete eRoT-authenticated update.
+ * If firmware adds further authentication components in future
+ * hardware, this mask must be extended to match.
+ */
+#define ICE_FWU_COMP_ALL_EROT		(ICE_FWU_COMP_NVM | ICE_FWU_COMP_OROM | \
+					 ICE_FWU_COMP_NETLIST | ICE_FWU_COMP_MANIFEST)
+
 struct ice_fwu_priv {
 	struct pldmfw context;
 
@@ -29,6 +41,9 @@ struct ice_fwu_priv {
 
 	/* Track if EMP reset is available */
 	u8 emp_reset_available;
+
+	/* Bitmask of auth components seen in this image (ICE_FWU_COMP_*) */
+	u8 seen_components;
 };
 
 /**
@@ -108,6 +123,9 @@ ice_check_component_response(struct ice_pf *pf, u16 id, u8 response, u8 code,
 	case NVM_COMP_ID_NETLIST:
 		component = "fw.netlist";
 		break;
+	case NVM_COMP_ID_MANIFEST:
+		component = "fw.pqc_manifest";
+		break;
 	default:
 		WARN(1, "Unexpected unknown component identifier 0x%02x", id);
 		return -EINVAL;
@@ -220,12 +238,28 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
 	struct ice_pf *pf = priv->pf;
 	struct ice_hw *hw = &pf->hw;
 	size_t length;
+	u8 comp_bit;
 	int status;
 
 	switch (component->identifier) {
 	case NVM_COMP_ID_OROM:
+		comp_bit = ICE_FWU_COMP_OROM;
+		break;
 	case NVM_COMP_ID_NVM:
+		comp_bit = ICE_FWU_COMP_NVM;
+		break;
 	case NVM_COMP_ID_NETLIST:
+		comp_bit = ICE_FWU_COMP_NETLIST;
+		break;
+	case NVM_COMP_ID_MANIFEST:
+		if (!ice_is_feature_supported(pf, ICE_F_EROT)) {
+			dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
+				component->identifier);
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Unable to update due to unknown firmware component");
+			return -EOPNOTSUPP;
+		}
+		comp_bit = ICE_FWU_COMP_MANIFEST;
 		break;
 	default:
 		dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
@@ -234,6 +268,14 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
 		return -EOPNOTSUPP;
 	}
 
+	if (priv->seen_components & comp_bit) {
+		dev_err(dev, "Duplicate component in PLDM image: component ID 0x%02x\n",
+			component->identifier);
+		NL_SET_ERR_MSG_MOD(extack, "Duplicate component in PLDM image");
+		return -EOPNOTSUPP;
+	}
+	priv->seen_components |= comp_bit;
+
 	length = struct_size(comp_tbl, cvs, component->version_len);
 	comp_tbl = kzalloc(length, GFP_KERNEL);
 	if (!comp_tbl)
@@ -623,6 +665,24 @@ ice_switch_flash_banks(struct ice_pf *pf, u8 activate_flags,
 	return 0;
 }
 
+/**
+ * ice_has_erot_incomplete - check whether an eRoT update is missing a component
+ * @priv: PLDM firmware update private data
+ *
+ * On eRoT adapters all four authentication components must be present.
+ *
+ * Return: true when a required component is absent on an eRoT adapter (the
+ * update must be rejected), false otherwise (including non-eRoT adapters).
+ */
+static bool
+ice_has_erot_incomplete(struct ice_fwu_priv *priv)
+{
+	if (!ice_is_feature_supported(priv->pf, ICE_F_EROT))
+		return false;
+
+	return priv->seen_components != ICE_FWU_COMP_ALL_EROT;
+}
+
 /**
  * ice_flash_component - Flash a component of the NVM
  * @context: PLDM fw update structure
@@ -667,6 +727,16 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
 		reset_level = NULL;
 		name = "fw.netlist";
 		break;
+	case NVM_COMP_ID_MANIFEST:
+		module = ICE_SR_PQC_MANIFEST_BANK_PTR;
+		/* Manifest has no ACTIV_SEL bit of its own; ACTIV_SEL only
+		 * defines activation bits for NVM, OROM, and NetList, so
+		 * there is nothing to add to priv->activate_flags here.
+		 */
+		flag = 0;
+		reset_level = NULL;
+		name = "fw.pqc_manifest";
+		break;
 	default:
 		/* This should not trigger, since we check the id before
 		 * sending the component table to firmware.
@@ -676,6 +746,16 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
 		return -EINVAL;
 	}
 
+	/* ice_send_component_table() is called for every component in the
+	 * PLDM image before pldmfw_flash_image() ever calls this function,
+	 * so priv->seen_components is already fully populated by the time
+	 * the first component reaches ice_flash_component().
+	 */
+	if (ice_has_erot_incomplete(priv)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "eRoT adapter requires all four components (NVM, OROM, NetList, Manifest) in a single update");
+		return -EINVAL;
+	}
 	/* Mark this component for activating at the end */
 	priv->activate_flags |= flag;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 1375106..847f17e6 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1154,6 +1154,7 @@ struct ice_aq_get_set_rss_lut_params {
 #define ICE_SR_OROM_BANK_SIZE		0x45
 #define ICE_SR_NETLIST_BANK_PTR		0x46
 #define ICE_SR_NETLIST_BANK_SIZE	0x47
+#define ICE_SR_PQC_MANIFEST_BANK_PTR	0x4E
 #define ICE_SR_SECTOR_SIZE_IN_WORDS	0x800
 
 /* CSS Header words */
-- 
2.52.0


