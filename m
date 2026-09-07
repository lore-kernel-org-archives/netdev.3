Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6A479862
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779070; cv=none; b=T3PdD1WAQiJsr6sVDt+PpXOITrNUU4o+K0YnoHCa4GzpoVPGWWNj9z59wrixhddhCh+lXqT0Sk9F8D1ttCEo25sehLYDluUK0RuTQJWpFV1aOTsDW+BsJAoJRjsyWSNIPRotGt62aNT8LyY0iEDD/2PGfopE2H13rdw8GxD+eic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779070; c=relaxed/simple;
	bh=YwHyl9oA50LZGhzE1cv//WWN/vhuWGl2+OkHmsE98+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cef6v35iZhRKcZaY6BpTpFj8taJA8hZmHMm7b2zsJ7O4R+O77Wx7WHvybrm6Cc/IEZViJ2BSvW31/+1b+wSJoSOmAzQj2dR2U3lt9leuqhso4jl2fs5ndhZXVRSZHe/aXNCVxwJNV9oxWohNf83MT77QD8iWUmcR1/nX6K9wSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDlNfQMV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDlNfQMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788779069; x=1820315069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YwHyl9oA50LZGhzE1cv//WWN/vhuWGl2+OkHmsE98+s=;
  b=CDlNfQMVNVgPgT2aJisBQ1twT/QOdQCR1GiQub4KB9iJD6EsvTEr36X5
   T4lKXQxyKXcc58or+KA8M12y5gXH2QThw0SxkDHgaujpQU9L4U6Jg4Cu1
   mnvzPJLmi16tH5psvXYGm2blBsQzgJew0V5Ap+NBpeTgeCgNKklmXRV7N
   nhp7qPhp9iayi9GpOaYUmX1D+6Lna1DKAVJYdgXCXOWZRcNN8AR99YWKo
   d4l/ZygHCKuHesipAAngOsBLNFDnr48a6SFF/4SVXC3eIgtalTgCTnIyn
   S0O66XjkaJAClazq9No69346ak/iBPxSpVJuDbLX8ZkbOO+uk0JHsO+sC
   A==;
X-CSE-ConnectionGUID: nxzcp8YsSta69IyIqgwKAg==
X-CSE-MsgGUID: D0ClNbD6RmOE0I8PNGHy0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214082"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="89214082"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 04:04:28 -0700
X-CSE-ConnectionGUID: lMJEkGf4QnKIzXkRYUILWw==
X-CSE-MsgGUID: QzPgpiIzQL6Y4kt+8uEEog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="274195461"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:26 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-next v1 07/10] libie, idpf: move parsing alloc vectors command to libie
Date: Mon,  7 Sep 2026 12:24:14 +0200
Message-ID: <20260907102418.2697317-8-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
References: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
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
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 85 +----------------
 drivers/net/ethernet/intel/libie/irq.c        | 91 +++++++++++++++++++
 include/linux/net/intel/libie/irq.h           |  7 ++
 3 files changed, 101 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 9377af87125f..c7bdd323ed85 100644
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
 		/* Unroll getting vectors and leave it in clean state for
 		 * the next try.
@@ -2381,9 +2304,7 @@ int idpf_send_dealloc_vectors_msg(struct idpf_adapter *adapter)
 	int buf_size, err;
 
 	/* dealloc vectors can fail, but irq_info still needs to be cleaned */
-	kfree(adapter->irq_info.vectors);
-	adapter->irq_info.vectors = NULL;
-	adapter->irq_info.num = 0;
+	libie_irq_destroy_info(&adapter->irq_info);
 
 	buf_size = struct_size(&ac->vchunks, vchunks,
 			       le16_to_cpu(ac->vchunks.num_vchunks));
diff --git a/drivers/net/ethernet/intel/libie/irq.c b/drivers/net/ethernet/intel/libie/irq.c
index eb47bfd34cdd..b8c144329aac 100644
--- a/drivers/net/ethernet/intel/libie/irq.c
+++ b/drivers/net/ethernet/intel/libie/irq.c
@@ -246,6 +246,97 @@ int libie_irq_reserve(struct libie_irq *irq)
 }
 EXPORT_SYMBOL_NS_GPL(libie_irq_reserve, "LIBIE_IRQ");
 
+/**
+ * libie_irq_create_info - Save vectors information from firmware
+ * @info: parsed information is stored here
+ * @caps: virtchannel capabilities
+ * @vectors: vector information from firmware to be parsed
+ * @num_vectors: number of vectors
+ *
+ * Returns 0 on success, negative on failure.
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
index e219fde575d8..47f3cdcd30b4 100644
--- a/include/linux/net/intel/libie/irq.h
+++ b/include/linux/net/intel/libie/irq.h
@@ -5,6 +5,7 @@
 #define __LIBIE_IRQ_H
 
 #include <linux/pci.h>
+#include <linux/net/intel/virtchnl2.h>
 
 /* In whole code in libie_irq index means the software 0-based irq index
  * for driver purpose, virq means the linux irq line number. Index can be used
@@ -105,5 +106,11 @@ struct msi_map libie_irq_alloc(struct libie_irq *irq, enum libie_irq_type type);
 void libie_irq_free(struct libie_irq *irq, struct msi_map map);
 int libie_irq_reserve(struct libie_irq *irq);
 void libie_put_irq(struct libie_irq *irq, unsigned int index);
+/* IPU specific functions. */
+void libie_irq_destroy_info(struct libie_irq_info *info);
+int libie_irq_create_info(struct libie_irq_info *info,
+			  const struct virtchnl2_get_capabilities *caps,
+			  const struct virtchnl2_alloc_vectors *vectors,
+			  const u16 num_vectors);
 
 #endif /* __LIBIE_IRQ_H */
-- 
2.49.0

