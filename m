Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E51485955
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133403; cv=none; b=E2JTMuEW9WLDjD4PAL+EXTssjp0qKrvaBIt4uNW1SyJ1b5naYi26xUijZwOmzTt2OxAmPA+ZR8vKUaq4IXdP71OWxc+HmWsw4vVFqY5cpfbceik4b2efd8+0fD5AEiElkyi36WoibCrDkxO9+oy2MxYpRvWPmMW1C52fASQtKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133403; c=relaxed/simple;
	bh=QG3ur83XOtOOg25xuU310Iz7aILIS2X6R2xAAnUmZ/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/WQ5o31MPXK+GTTPv8FfIAv3a2Z9Q64rEoJUqe5RZG6mW4a+G+xSHpPJAYImP46ZnOcp7mkH4VR6IM3vFQNPmS21WUkQkC8bHBy/JWy5x7/dCCdpQTERVWVvO1URyxSFWTR54UVfgc533nbu3QnZrl+C5k+b8jL/vdzSGE879c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRyW6DGF; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRyW6DGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789133402; x=1820669402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QG3ur83XOtOOg25xuU310Iz7aILIS2X6R2xAAnUmZ/I=;
  b=TRyW6DGFPd+JHnFiiuOxWXIsj5p1Xmxdvu2PSpS9HUJOXPouwHxZEo3n
   W+ao6Bp1zs+NxomLvIabSoCWJl2MK3ZayBNuJOuPjhXyOnoElfiFrJtXk
   uYILXF6vEJbW1zoym5G4txfy6eaHnug/V1WX7B93XZBAEGa732nRNtPpM
   aoxsZqb6dJD7N3O/QNAdK8R9u0inv1eDQQ9BcM/LI7dbBeqCb1gvJX/ea
   2iVsHQy+joqysKGz50Yaun8iiIA6K+aTArG5+wCEl3R4OnFD+V7fAtetW
   VG3UgpIkPnv6OIDLfiCGTJ7mX+P7ZR++Awl+XCe5HHKDF7TH59d3zPxc8
   Q==;
X-CSE-ConnectionGUID: 91T86SvpR3m7fVPQeZyKZw==
X-CSE-MsgGUID: KIMHUrf+TqScE2RsVoLQpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107540"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107540"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 06:30:01 -0700
X-CSE-ConnectionGUID: HinyNYxgQR6wH51IcRAerQ==
X-CSE-MsgGUID: 00BpB9msRE2vg4HMfGhB1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270541287"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:30:00 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 07/10] libie, idpf: move parsing alloc vectors command to libie
Date: Fri, 11 Sep 2026 14:49:18 +0200
Message-ID: <20260911124921.2881348-8-michal.swiatkowski@linux.intel.com>
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

No functional changes. Just moving to make it available from other
ipu drivers.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 85 +----------------
 drivers/net/ethernet/intel/libie/irq.c        | 92 +++++++++++++++++++
 include/linux/net/intel/libie/irq.h           |  9 ++
 3 files changed, 104 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 20e471def235..3df6ad291e64 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2229,83 +2229,6 @@ int idpf_send_add_queues_msg(struct idpf_adapter *adapter,
 	return err;
 }
 
-/**
- * idpf_create_vectors_info - Save vectors information from firmware
- * @info: parsed information is stored here
- * @caps: virtchannel capabilities
- * @vectors: vector information from firmware to be parsed
- * @num_vectors: number of vectors
- *
- * Returns 0 on success, negative on failure.
- */
-static int idpf_create_vectors_info(struct libie_irq_info *info,
-				    const struct virtchnl2_get_capabilities *caps,
-				    const struct virtchnl2_alloc_vectors *vectors,
-				    const u16 num_vectors)
-{
-	const struct virtchnl2_vector_chunks *chunks = &vectors->vchunks;
-	int all_vectors = num_vectors + IDPF_MBX_Q_VEC;
-	struct libie_hw_vector *vector;
-	int reg_cnt;
-
-	if (le16_to_cpu(vectors->num_vectors) < num_vectors)
-		return -EINVAL;
-
-	info->vectors = kzalloc_objs(*info->vectors, all_vectors);
-	if (!info->vectors)
-		return -ENOMEM;
-	/* Mailbox irq information are stored in different places. Fill index 0
-	 * of our vectors info with capabilities and rest with information
-	 * from vector chunks.
-	 */
-	vector = &info->vectors[0];
-	vector->idx = le16_to_cpu(caps->mailbox_vector_id);
-	vector->regs.dyn_ctl = le32_to_cpu(caps->mailbox_dyn_ctl);
-	reg_cnt = IDPF_MBX_Q_VEC;
-
-	for (int i = 0; i < le16_to_cpu(chunks->num_vchunks); i++) {
-		const struct virtchnl2_vector_chunk *chunk = &chunks->vchunks[i];
-		u32 dyn_spacing, itrn_spacing;
-		struct libie_vec_regs reg_val;
-		u16 vec_id;
-
-		reg_val.dyn_ctl = le32_to_cpu(chunk->dynctl_reg_start);
-		reg_val.itrn = le32_to_cpu(chunk->itrn_reg_start);
-		reg_val.itrn_index_spacing =
-			le32_to_cpu(chunk->itrn_index_spacing);
-
-		dyn_spacing = le32_to_cpu(chunk->dynctl_reg_spacing);
-		itrn_spacing = le32_to_cpu(chunk->itrn_reg_spacing);
-		vec_id = le16_to_cpu(chunk->start_vector_id);
-
-		for (int j = 0; j < le16_to_cpu(chunk->num_vectors); j++) {
-			if (reg_cnt >= all_vectors)
-				break;
-
-			vector = &info->vectors[reg_cnt];
-
-			vector->regs = reg_val;
-			vector->idx = vec_id;
-
-			reg_val.dyn_ctl += dyn_spacing;
-			reg_val.itrn += itrn_spacing;
-
-			vec_id += 1;
-			reg_cnt += 1;
-		}
-	}
-
-	if (reg_cnt != all_vectors) {
-		kfree(info->vectors);
-		info->vectors = NULL;
-		return -EINVAL;
-	}
-
-	info->num = num_vectors + IDPF_MBX_Q_VEC;
-
-	return 0;
-}
-
 /**
  * idpf_send_alloc_vectors_msg - Send virtchnl alloc vectors message
  * @adapter: Driver specific private structure
@@ -2350,8 +2273,8 @@ int idpf_send_alloc_vectors_msg(struct idpf_adapter *adapter, u16 num_vectors)
 		goto free_rx_buf;
 	}
 
-	err = idpf_create_vectors_info(&adapter->irq_info, &adapter->caps,
-				       rcvd_vec, num_vectors);
+	err = libie_irq_create_info(&adapter->irq_info, &adapter->caps,
+				    rcvd_vec, num_vectors);
 	if (err)
 		idpf_send_dealloc_vectors_msg(adapter);
 
@@ -2378,9 +2301,7 @@ int idpf_send_dealloc_vectors_msg(struct idpf_adapter *adapter)
 	int buf_size, err;
 
 	/* dealloc vectors can fail, but irq_info still needs to be cleaned */
-	kfree(adapter->irq_info.vectors);
-	adapter->irq_info.vectors = NULL;
-	adapter->irq_info.num = 0;
+	libie_irq_destroy_info(&adapter->irq_info);
 
 	buf_size = struct_size(&ac->vchunks, vchunks,
 			       le16_to_cpu(ac->vchunks.num_vchunks));
diff --git a/drivers/net/ethernet/intel/libie/irq.c b/drivers/net/ethernet/intel/libie/irq.c
index 0f73f8becefb..d26ffeffdcb2 100644
--- a/drivers/net/ethernet/intel/libie/irq.c
+++ b/drivers/net/ethernet/intel/libie/irq.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include <linux/net/intel/libie/irq.h>
+#include <linux/net/intel/virtchnl2.h>
 
 /**
  * libie_irq_init - init irq for whole device
@@ -250,6 +251,97 @@ int libie_irq_reserve(struct libie_irq *irq)
 }
 EXPORT_SYMBOL_NS_GPL(libie_irq_reserve, "LIBIE_IRQ");
 
+/**
+ * libie_irq_create_info - Save vectors information from firmware
+ * @info: parsed information is stored here
+ * @caps: virtchannel capabilities
+ * @vectors: vector information from firmware to be parsed
+ * @num_vectors: number of vectors
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int libie_irq_create_info(struct libie_irq_info *info,
+			  const struct virtchnl2_get_capabilities *caps,
+			  const struct virtchnl2_alloc_vectors *vectors,
+			  const u16 num_vectors)
+{
+	const struct virtchnl2_vector_chunks *chunks = &vectors->vchunks;
+	struct libie_hw_vector *vector;
+	const int mb_vectors = 1;
+	int reg_cnt, all_vectors;
+
+	if (le16_to_cpu(vectors->num_vectors) < num_vectors)
+		return -EINVAL;
+
+	all_vectors = num_vectors + mb_vectors;
+	info->vectors = kzalloc_objs(*info->vectors, all_vectors);
+	if (!info->vectors)
+		return -ENOMEM;
+	/* Mailbox irq information are stored in different places. Fill index 0
+	 * of our vectors info with capabilities and rest with information
+	 * from vector chunks.
+	 */
+	vector = &info->vectors[0];
+	vector->idx = le16_to_cpu(caps->mailbox_vector_id);
+	vector->regs.dyn_ctl = le32_to_cpu(caps->mailbox_dyn_ctl);
+	reg_cnt = mb_vectors;
+
+	for (int i = 0; i < le16_to_cpu(chunks->num_vchunks); i++) {
+		const struct virtchnl2_vector_chunk *chunk = &chunks->vchunks[i];
+		u32 dyn_spacing, itrn_spacing;
+		struct libie_vec_regs reg_val;
+		u16 vec_id;
+
+		reg_val.dyn_ctl = le32_to_cpu(chunk->dynctl_reg_start);
+		reg_val.itrn = le32_to_cpu(chunk->itrn_reg_start);
+		reg_val.itrn_index_spacing =
+			le32_to_cpu(chunk->itrn_index_spacing);
+
+		dyn_spacing = le32_to_cpu(chunk->dynctl_reg_spacing);
+		itrn_spacing = le32_to_cpu(chunk->itrn_reg_spacing);
+		vec_id = le16_to_cpu(chunk->start_vector_id);
+
+		for (int j = 0; j < le16_to_cpu(chunk->num_vectors); j++) {
+			if (reg_cnt >= all_vectors)
+				break;
+
+			vector = &info->vectors[reg_cnt];
+
+			vector->regs = reg_val;
+			vector->idx = vec_id;
+
+			reg_val.dyn_ctl += dyn_spacing;
+			reg_val.itrn += itrn_spacing;
+
+			vec_id += 1;
+			reg_cnt += 1;
+		}
+	}
+
+	if (reg_cnt != all_vectors) {
+		kfree(info->vectors);
+		info->vectors = NULL;
+		return -EINVAL;
+	}
+
+	info->num = all_vectors;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(libie_irq_create_info, "LIBIE_IRQ");
+
+/**
+ * libie_irq_destroy_info - free memory allocated during building irq_info
+ * @info: libie_irq_info struct to be freed
+ */
+void libie_irq_destroy_info(struct libie_irq_info *info)
+{
+	kfree(info->vectors);
+	info->vectors = NULL;
+	info->num = 0;
+}
+EXPORT_SYMBOL_NS_GPL(libie_irq_destroy_info, "LIBIE_IRQ");
+
 /* Module */
 
 MODULE_DESCRIPTION("Helper functions for managing MSI-X in driver");
diff --git a/include/linux/net/intel/libie/irq.h b/include/linux/net/intel/libie/irq.h
index e219fde575d8..8d5873f13871 100644
--- a/include/linux/net/intel/libie/irq.h
+++ b/include/linux/net/intel/libie/irq.h
@@ -105,5 +105,14 @@ struct msi_map libie_irq_alloc(struct libie_irq *irq, enum libie_irq_type type);
 void libie_irq_free(struct libie_irq *irq, struct msi_map map);
 int libie_irq_reserve(struct libie_irq *irq);
 void libie_put_irq(struct libie_irq *irq, unsigned int index);
+/* IPU specific functions. */
+struct virtchnl2_get_capabilities;
+struct virtchnl2_alloc_vectors;
+
+void libie_irq_destroy_info(struct libie_irq_info *info);
+int libie_irq_create_info(struct libie_irq_info *info,
+			  const struct virtchnl2_get_capabilities *caps,
+			  const struct virtchnl2_alloc_vectors *vectors,
+			  const u16 num_vectors);
 
 #endif /* __LIBIE_IRQ_H */
-- 
2.49.0

