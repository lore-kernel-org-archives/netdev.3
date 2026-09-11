Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0B48822D
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133406; cv=none; b=P1GgP3OSOD9sdo1ygsxCeIpCtXLtNtSgaGWIbcPwGxKLiyaBiaEbQ3zOdCPKrGZv+Ds/ql2ZwY+MYsPie5/r9q2E0eef2A0zEE2RZeebocYr/zr6s8O2MyCP9n7AmFiDmOWleOXggmjK9OGSz2Tj+xlGTAI9AfQM7DnDjHALLbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133406; c=relaxed/simple;
	bh=qHS1b2tjdRdvqr4P/sS38v3L3WhD2s8Lh9q0gj/hIiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXrItrT9E7clX3B5fvZrBFusEu1sXvqiq9gWUVVo6/Qhht8OluklICz5B0JwV0B9hgkIm4Y4hYwW7o7HsXtlvzq2TIvKGc4Y/WSwA1dGpS1zCDFjyB3Zeq0Ov186mOTsO+IOxi2qDNUpDtqePZVumOZymOAXsytwN5uLSYnHhFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDLPkmo1; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDLPkmo1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789133405; x=1820669405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qHS1b2tjdRdvqr4P/sS38v3L3WhD2s8Lh9q0gj/hIiw=;
  b=UDLPkmo1JFT1sTuXRKHgJpqbrKatmduakveG8PppR8wKUUKwqMDK0jjp
   MNYxLa8oISfkytH2hM7mPyGsfZFqT2viRAzdN93n3x7oArkf5cm1G11OO
   XNPO6N1bqh4mtCxIphp2bMpR4dwbOtErznwlmVg25enuCsepWcTClzOQh
   tDWlNyZ2y/5Mu1UdFJn+c64m25tT/66HsahFRweWkygNjoOT3D0zt98ok
   MIogHGuAvXGPqz7qWwhbshEZYMmosKM2IgeLAgl9X00OJY6AsAauhPYj6
   a4MQRHXI0Ya0zcfq9j27D3CKbjCUPM2Jrob22g0MUcS1dHmrAcXnL82+Y
   A==;
X-CSE-ConnectionGUID: 84HcC1b2SdKLyVo+9poUIg==
X-CSE-MsgGUID: DZddnE58TvCdCGKBw/Vfrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107547"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107547"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 06:30:04 -0700
X-CSE-ConnectionGUID: 47hF93LsR8mgeD/zGZZk9A==
X-CSE-MsgGUID: RJ7LK1itTGehIeud5m0z6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270541296"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:30:03 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 09/10] ixd: support for getting lan memory regions
Date: Fri, 11 Sep 2026 14:49:20 +0200
Message-ID: <20260911124921.2881348-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send and parse get lan memory regions command. Map the regions from
the command response.

It is needed to set number of regions to not zero value even when
just sending the command. Set it to 1 and add comment about that.

It is possible that get lan memory regions isn't supported. Driver
should cover this situation by mapping regions needed for running.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ixd/ixd.h          |   3 +
 drivers/net/ethernet/intel/ixd/ixd_main.c     | 131 +++++++++++++++---
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  90 +++++++++++-
 3 files changed, 201 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
index 2a09ccba13d5..4a1590f937b5 100644
--- a/drivers/net/ethernet/intel/ixd/ixd.h
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -63,5 +63,8 @@ bool ixd_check_reset_complete(struct ixd_adapter *adapter);
 void ixd_init_task(struct work_struct *work);
 int ixd_init_dflt_mbx(struct ixd_adapter *adapter);
 void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter);
+int ixd_iomap_running_regions(struct ixd_adapter *adapter);
+bool ixd_iomap_is_not_start_region(struct libie_mmio_info *info,
+				   struct libie_pci_mmio_region *reg);
 
 #endif /* _IXD_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index 5db992d4f9fb..488a919f3b1b 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -48,37 +48,124 @@ static void ixd_shutdown(struct pci_dev *pdev)
 
 /**
  * ixd_iomap_regions - iomap PCI BARs
- * @adapter: adapter to map memory regions for
+ * @mmio_info: PCI resources info
+ * @num: number of regions to map
+ * @regions: array of regions to map (offset and size)
  *
  * Returns: %0 on success, negative on failure
  */
-static int ixd_iomap_regions(struct ixd_adapter *adapter)
+static int ixd_iomap_regions(struct libie_mmio_info *mmio_info, int num,
+			     const struct ixd_bar_region *regions)
 {
-	const struct ixd_bar_region regions[] = {
-		{
-			.offset = PFGEN_RTRIG,
-			.size = PFGEN_RTRIG_REG_LEN,
-		},
-		{
-			.offset = PF_FW_MBX,
-			.size = PF_FW_MBX_REG_LEN,
-		},
-	};
-
-	for (int i = 0; i < ARRAY_SIZE(regions); i++) {
-		struct libie_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
+	for (int i = 0; i < num; i++) {
 		bool map_ok;
 
 		map_ok = libie_pci_map_mmio_region(mmio_info,
 						   regions[i].offset,
 						   regions[i].size);
-		if (!map_ok) {
-			dev_err(ixd_to_dev(adapter),
-				"Failed to map PCI device MMIO region\n");
-
-			libie_pci_unmap_all_mmio_regions(mmio_info);
+		if (!map_ok)
 			return -EIO;
-		}
+	}
+
+	return 0;
+}
+
+/* Regions needed to reset the device and to talk to the control plane.
+ * They are mapped in probe and stay mapped for the whole driver life.
+ */
+static const struct ixd_bar_region ixd_start_regions[] = {
+	{
+		.offset = PFGEN_RTRIG,
+		.size = PFGEN_RTRIG_REG_LEN,
+	},
+	{
+		.offset = PF_FW_MBX,
+		.size = PF_FW_MBX_REG_LEN,
+	},
+};
+
+/**
+ * ixd_iomap_is_not_start_region - check if the region isn't a start region
+ * @info: PCI resources info, unused
+ * @reg: region to check
+ *
+ * Return: %true if it isn't a start region, %false otherwise
+ */
+bool ixd_iomap_is_not_start_region(struct libie_mmio_info *info,
+				   struct libie_pci_mmio_region *reg)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(ixd_start_regions); i++) {
+		if (reg->bar_idx == 0 &&
+		    reg->offset == ixd_start_regions[i].offset &&
+		    reg->size == ixd_start_regions[i].size)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * ixd_iomap_start_regions - iomap PCI BARs needed for driver startup
+ * @adapter: adapter to map memory regions for
+ *
+ * Returns: %0 on success, negative on failure
+ */
+static int ixd_iomap_start_regions(struct ixd_adapter *adapter)
+{
+	struct libie_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
+	int err;
+
+	err = ixd_iomap_regions(mmio_info, ARRAY_SIZE(ixd_start_regions),
+				ixd_start_regions);
+	if (err) {
+		dev_err(ixd_to_dev(adapter),
+			"Failed to map startup PCI device MMIO region\n");
+
+		libie_pci_unmap_all_mmio_regions(mmio_info);
+	}
+
+	return err;
+}
+
+/**
+ * ixd_iomap_running_regions - iomap PCI BARs needed for driver when running
+ * @adapter: adapter to map memory regions for
+ *
+ * It should be called only when the GET_LAN_MEMORY_REGIONS virtchnl command
+ * isn't supported. Calculate the offsets and sizes for the regions before,
+ * in between, and after the start regions (mailbox and reset registers) and
+ * map those ranges.
+ *
+ * Returns: %0 on success, negative on failure
+ */
+int ixd_iomap_running_regions(struct ixd_adapter *adapter)
+{
+	struct libie_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
+	resource_size_t start, size;
+	bool ok = true;
+
+	/* Region preceding the mailbox */
+	size = PF_FW_MBX;
+	ok &= !size || libie_pci_map_mmio_region(mmio_info, 0, size);
+
+	/* Region between the mailbox and the reset registers */
+	start = PF_FW_MBX + PF_FW_MBX_REG_LEN;
+	size = PFGEN_RTRIG - start;
+	ok &= !size || libie_pci_map_mmio_region(mmio_info, start, size);
+
+	/* Region after the reset registers */
+	start = PFGEN_RTRIG + PFGEN_RTRIG_REG_LEN;
+	size = pci_resource_len(mmio_info->pdev, 0) - start;
+	ok &= !size || libie_pci_map_mmio_region(mmio_info, start, size);
+
+	if (!ok) {
+		dev_err(ixd_to_dev(adapter),
+			"Failed to map running PCI device MMIO region\n");
+
+		libie_pci_unmap_fltr_regs(mmio_info,
+					  ixd_iomap_is_not_start_region);
+
+		return -EIO;
 	}
 
 	return 0;
@@ -109,7 +196,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, adapter);
 
-	err = ixd_iomap_regions(adapter);
+	err = ixd_iomap_start_regions(adapter);
 	if (err)
 		goto free_adapter;
 
diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
index fc3b6d2e28c5..3487183b49c9 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
@@ -3,6 +3,7 @@
 
 #include "ixd.h"
 #include "ixd_ctlq.h"
+#include "ixd_lan_regs.h"
 #include "ixd_virtchnl.h"
 
 /**
@@ -62,6 +63,14 @@ static int ixd_handle_caps(struct ixd_adapter *adapter, void *recv_buff,
 	return 0;
 }
 
+static void ixd_fill_caps(struct ixd_adapter *adapter, void *send_buff,
+			  void *ctx)
+{
+	struct virtchnl2_get_capabilities *caps = send_buff;
+
+	caps->other_caps = cpu_to_le64(VIRTCHNL2_CAP_LAN_MEMORY_REGIONS);
+}
+
 /**
  * ixd_req_vc_caps - Request and save device capability
  * @adapter: The adapter to get the capabilities for
@@ -74,13 +83,18 @@ static int ixd_req_vc_caps(struct ixd_adapter *adapter)
 		.opcode = VIRTCHNL2_OP_GET_CAPS,
 		.send_size = sizeof(struct virtchnl2_get_capabilities),
 		.ctx = NULL,
-		.send_buff_init = NULL,
+		.send_buff_init = ixd_fill_caps,
 		.recv_process = ixd_handle_caps,
 	};
 
 	return ixd_ctlq_do_req(adapter, &req);
 }
 
+static bool ixd_is_cap_ena(struct ixd_adapter *adapter, u64 cap)
+{
+	return (le64_to_cpu(adapter->caps.other_caps) & cap) == cap;
+}
+
 /**
  * ixd_get_vc_ver - Get version info from adapter
  *
@@ -160,6 +174,69 @@ static int ixd_req_vc_version(struct ixd_adapter *adapter)
 	return ixd_ctlq_do_req(adapter, &req);
 }
 
+static void ixd_fill_lan_mmio_regions(struct ixd_adapter *adapter,
+				      void *send_buff, void *ctx)
+{
+	struct virtchnl2_get_lan_memory_regions *lan = send_buff;
+
+	/* Needed to be parsed correctly, this mem_region doesn't matter. */
+	lan->num_memory_regions = cpu_to_le16(1);
+}
+
+static int ixd_handle_lan_mmio_regions(struct ixd_adapter *adapter,
+				       void *recv_buff, size_t recv_size,
+				       void *ctx)
+{
+	struct libie_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
+	struct virtchnl2_get_lan_memory_regions *recv_mmio = recv_buff;
+	int num_regions;
+
+	if (recv_size < sizeof(*recv_mmio))
+		return -EBADMSG;
+
+	num_regions = le16_to_cpu(recv_mmio->num_memory_regions);
+	if (!num_regions)
+		return -EBADMSG;
+
+	if (recv_size < struct_size(recv_mmio, mem_reg, num_regions))
+		return -EBADMSG;
+
+	for (int i = 0; i < num_regions; i++) {
+		struct virtchnl2_mem_region *reg = &recv_mmio->mem_reg[i];
+		resource_size_t offset, size;
+
+		offset = le64_to_cpu(reg->start_offset);
+		size = le64_to_cpu(reg->size);
+
+		/* Empty regions are used as a padding, skip them. */
+		if (!size)
+			continue;
+
+		if (!libie_pci_map_mmio_region(mmio_info, offset, size)) {
+			/* Unmap already mapped */
+			libie_pci_unmap_fltr_regs(mmio_info,
+						  ixd_iomap_is_not_start_region);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int ixd_req_lan_mmio_regions(struct ixd_adapter *adapter)
+{
+	const struct ixd_ctlq_req req = {
+		.opcode = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
+		.send_size = sizeof(struct virtchnl2_get_lan_memory_regions) +
+			     sizeof(struct virtchnl2_mem_region),
+		.ctx = NULL,
+		.send_buff_init = ixd_fill_lan_mmio_regions,
+		.recv_process = ixd_handle_lan_mmio_regions,
+	};
+
+	return ixd_ctlq_do_req(adapter, &req);
+}
+
 /**
  * ixd_vc_dev_init - virtchnl device core initialization
  * @adapter: device information
@@ -186,5 +263,16 @@ int ixd_vc_dev_init(struct ixd_adapter *adapter)
 		return err;
 	}
 
+	if (ixd_is_cap_ena(adapter, VIRTCHNL2_CAP_LAN_MEMORY_REGIONS))
+		err = ixd_req_lan_mmio_regions(adapter);
+	else
+		/* Fallback to mapping the remaining regions of the whole BAR */
+		err = ixd_iomap_running_regions(adapter);
+
+	if (err)
+		dev_warn(ixd_to_dev(adapter),
+			 "Getting LAN mmio regions failed, error=%pe\n",
+			 ERR_PTR(err));
+
 	return err;
 }
-- 
2.49.0

