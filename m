Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BB2E739D
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670109; cv=none; b=cffSYH/NgVWKRxJ/BKr3aOGyjPFlCvDWmp6HGDTvLvFfkhw+0ZJ8hORKqYc4YOnC/MS4+9+9lmdGqrECiYyAtuNxva/sx6GEiyWXq6xg4+mTa/ZrRJoLj2B+fqxGzIz+pImxAhCd32tfucKF+JJCtBtO6d4kAEmryC9ISHXhiuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670109; c=relaxed/simple;
	bh=vojxm2cBfZSwwCLqV7et8bOWdin6W8xCnXCXPEmQ4ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cS912lMwE/HKvM7cCUk1v4bqSicaQ23Z6sWyzbNT1p+1heaUEnsTfELfr4S0N4+sBmVqES27Dh8CFLe1A+/a8EXG43FPsNIOiuPThxCicLXc4LmwbWvRQWGrTIWGZMFTJSCsXVUCxHT6fV/t97qN7g8QSMl26BljiGdMm/MkxUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KspDIQzx; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KspDIQzx"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so6482645ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786670107; x=1787274907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vNL4BK7ke880Ctyeh+eAysFO2M/UXePPBICSuTgQErk=;
        b=Ry9tL97qy9sf0P9rgPME3dkSzAL4sg4AEalsc5LU2oaPpExpME2xk4LVdxdl594DUC
         B6ILDyA8MZchrbtv72WEvcwFyhtcbw658CPKNi7c9p0Hw6NwtS3Wvhur9+lYl0rCzjWp
         8CxSdXmd+vr+3l24oPEAuPH8kr4k5PG8oa/HBPO1MrVwOuidKX8m1UmPMNGS5XCWCjM3
         WOp1PVsRzUwFm8zVb9y34Z4tE1tIzjXYNN6TV8fhDYQjs/dl24IytmsvB8AvLX/eamT2
         wUMkRf8GX6Tq/VeDAXE+kTmUTyRnZwuwIOwxNc6SLcCbp37cCcSVbazo+2Z8Q3mdGyuT
         EDTA==
X-Gm-Message-State: AOJu0YyyOeoch6JhzEUR/tzpKuueLJ93wlVsI/J3CfBQDOU6LgRpLRFt
	uu+YCQV8a07Uty8yIxsi1M4xZelJGXM+Gq7PcGGMh32YiO2IAMuhg00q+UGy6vpPSoFDsuazBf+
	ijbfTpMJh9D/5ZTkEuN3IdqRauBrUKbzvN2wYxIgbC0FqGV7HQhbXu7KbO74+nSI0yR6PmwRw1F
	ckndv601y/eUo/85ehPXDmvF4FWm+BVvyLUt6o3/NDi4Rb3dYXoVMgYcASZ6J194PmsMPqEo2Gs
	vaYJs1eOA==
X-Gm-Gg: AR+sD13u9HrIhFHwK22ZDeLq1wzvPUgzE63qU1mKwtJ4i52sRtFmk0kXLrb0QIjjSs/
	szDDxA8VYVhYcxHegxr1A4003oTWeMHy4y1/1rW5NBXxxXE3zI8y/tB3s1phwtoTwh8Mk/7PHf2
	wFlhS+9jqgwQwagLgja8/na94Rnc1UbgLCg+c13zymcUTnR4hXP6dytpdRzlNIiSWAWmRvA2jnL
	4omL9MUBYDrgX2O9bxdF/DXRjJdia2QQL2YGUIYBFYERujbfB70MaVd2VnZftFPzMPX+tyoOkoj
	gO3ZYRCtZKoMXCOabgYbzGJeT0axmeRA/xtNLMMV3ogtPqG4GyV6oSEQEWpU9amn9yuVPYA54Kc
	P6c3E8Oq5MIWgeEk0NcLyjEr+flhURT6M4ubsYWVT3nc17xwEkUioV/Ja99OncU6I8rjBPEPUxM
	uy0NrI7YlOC9xLxLjn5nNZqMof+2CJTa5/eQ==
X-Received: by 2002:a17:90b:2891:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-3933b8744c2mr2107226a91.12.1786670106641;
        Thu, 13 Aug 2026 18:15:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-394ebbb5ba9sm101620a91.12.2026.08.13.18.15.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 18:15:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbeeaabcadfso476283a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786670105; x=1787274905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vNL4BK7ke880Ctyeh+eAysFO2M/UXePPBICSuTgQErk=;
        b=KspDIQzxlzqHkvoGyhHCFWg5jC0Ig1vkh6QKCbMy1uIBPqnNNC87zBMz4FUuoqaku+
         B22IJ6EAFL3buUnLwjl732c/e6vUvwDenQIgA70gE42Lkb9hPWrQrQn/plzgu2nYAwDq
         uWInUNFHmyaOhhWG40LIEltEGCa5VYRUvLDc8=
X-Received: by 2002:a05:6a20:12c8:b0:3c3:7fa2:9618 with SMTP id adf61e73a8af0-3cc71eb2586mr1878796637.37.1786670104962;
        Thu, 13 Aug 2026 18:15:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:12c8:b0:3c3:7fa2:9618 with SMTP id adf61e73a8af0-3cc71eb2586mr1878739637.37.1786670104438;
        Thu, 13 Aug 2026 18:15:04 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69fbbsm12174177eec.11.2026.08.13.18.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:15:04 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next 04/11] bnge: add helper functions for multi RSS contexts
Date: Fri, 14 Aug 2026 06:44:28 +0530
Message-ID: <20260814011435.194631-5-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260814011435.194631-1-vikas.gupta@broadcom.com>
References: <20260814011435.194631-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add infrastructure for creating, modifying, and deleting user-defined
RSS contexts. This helps the next patch implement commands for ethtool.
For each user RSS context, a VNIC is allocated.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   2 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   2 +-
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    | 113 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |  15 +++
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index c47a874df4ba..3c0fea0a7608 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -371,6 +371,8 @@ struct bnge_net {
 
 	u8			pri2cos_idx[8];
 	bool			pri2cos_valid;
+
+	u16			num_rss_ctx;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index e4090982099b..9604bd05ba37 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -213,7 +213,7 @@ static u16 bnge_get_total_vnics(struct bnge_dev *bd)
 		struct bnge_net *bn = netdev_priv(bd->netdev);
 
 		if (bn->priv_flags & BNGE_NET_EN_NTUPLE)
-			return 2;
+			return 2 + bn->num_rss_ctx;
 	} else if (bnge_is_arfs_cap(bd)) {
 		return 2;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
index c79eb403844a..417abc7e8c74 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
@@ -125,3 +125,116 @@ int bnge_alloc_rfs_vnic(struct bnge_net *bn)
 	vnic = &bn->vnic_info[BNGE_VNIC_NTUPLE];
 	return bnge_alloc_and_setup_vnic(bn, vnic, bn->bd->rx_nr_rings);
 }
+
+void bnge_modify_rss(struct bnge_net *bn, struct ethtool_rxfh_context *ctx,
+		     struct bnge_rss_ctx *rss_ctx,
+		     const struct ethtool_rxfh_param *rxfh)
+{
+	struct bnge_dev *bd = bn->bd;
+
+	if (rxfh->key) {
+		if (rss_ctx) {
+			memcpy(rss_ctx->vnic.rss_hash_key, rxfh->key,
+			       HW_HASH_KEY_SIZE);
+		} else {
+			memcpy(bn->rss_hash_key, rxfh->key, HW_HASH_KEY_SIZE);
+			bn->rss_hash_key_updated = true;
+		}
+	}
+
+	if (rxfh->indir) {
+		u32 i, pad, tbl_size = bnge_get_rxfh_indir_size(bd);
+		u32 *indir_tbl = bd->rss_indir_tbl;
+
+		if (rss_ctx)
+			indir_tbl = ethtool_rxfh_context_indir(ctx);
+		for (i = 0; i < tbl_size; i++)
+			indir_tbl[i] = rxfh->indir[i];
+		pad = bd->rss_indir_tbl_entries - tbl_size;
+		if (pad)
+			memset(&indir_tbl[i], 0, pad * sizeof(*indir_tbl));
+	}
+}
+
+void bnge_del_one_rss_ctx(struct bnge_net *bn, struct bnge_rss_ctx *rss_ctx,
+			  bool all)
+{
+	struct bnge_vnic_info *vnic = &rss_ctx->vnic;
+	int i;
+
+	bnge_hwrm_vnic_free_one(bn->bd, &rss_ctx->vnic);
+	for (i = 0; i < BNGE_MAX_CTX_PER_VNIC; i++) {
+		if (vnic->fw_rss_cos_lb_ctx[i] != INVALID_HW_RING_ID)
+			bnge_hwrm_vnic_ctx_free_one(bn->bd, vnic, i);
+	}
+
+	if (!all)
+		return;
+
+	if (vnic->rss_table)
+		dma_free_coherent(bn->bd->dev, vnic->rss_table_size,
+				  vnic->rss_table,
+				  vnic->rss_table_dma_addr);
+	bn->num_rss_ctx--;
+}
+
+void bnge_hwrm_realloc_rss_ctx_vnic(struct bnge_net *bn)
+{
+	bool set_tpa = !!(bn->priv_flags & BNGE_NET_EN_TPA);
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+
+	xa_for_each(&bn->netdev->ethtool->rss_ctx, context, ctx) {
+		struct bnge_rss_ctx *rss_ctx = ethtool_rxfh_context_priv(ctx);
+		struct bnge_vnic_info *vnic = &rss_ctx->vnic;
+
+		if (bnge_hwrm_vnic_alloc(bn->bd, vnic, bn->bd->rx_nr_rings) ||
+		    bnge_hwrm_vnic_set_tpa(bn->bd, vnic, set_tpa) ||
+		    bnge_setup_vnic(bn, vnic)) {
+			netdev_err(bn->netdev, "Failed to restore RSS ctx %d\n",
+				   rss_ctx->index);
+			bnge_del_one_rss_ctx(bn, rss_ctx, true);
+			ethtool_rxfh_context_lost(bn->netdev, rss_ctx->index);
+		}
+	}
+}
+
+void bnge_clear_rss_ctxs(struct bnge_net *bn)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+
+	xa_for_each(&bn->netdev->ethtool->rss_ctx, context, ctx) {
+		struct bnge_rss_ctx *rss_ctx = ethtool_rxfh_context_priv(ctx);
+
+		bnge_del_one_rss_ctx(bn, rss_ctx, false);
+	}
+}
+
+struct bnge_rss_ctx *bnge_get_rss_ctx_from_index(struct bnge_net *bn, u32 idx)
+{
+	struct ethtool_rxfh_context *ctx;
+
+	ctx = xa_load(&bn->netdev->ethtool->rss_ctx, idx);
+	if (!ctx)
+		return NULL;
+	return ethtool_rxfh_context_priv(ctx);
+}
+
+int bnge_alloc_vnic_rss_table(struct bnge_net *bn,
+			      struct bnge_vnic_info *vnic)
+{
+	unsigned int size = L1_CACHE_ALIGN(BNGE_MAX_RSS_TABLE_SIZE);
+
+	vnic->rss_table_size = size + HW_HASH_KEY_SIZE;
+	vnic->rss_table = dma_alloc_coherent(bn->bd->dev,
+					     vnic->rss_table_size,
+					     &vnic->rss_table_dma_addr,
+					     GFP_KERNEL);
+	if (!vnic->rss_table)
+		return -ENOMEM;
+
+	vnic->rss_hash_key = ((void *)vnic->rss_table) + size;
+	vnic->rss_hash_key_dma_addr = vnic->rss_table_dma_addr + size;
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
index 93c6d736cbeb..af066d8ff156 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
@@ -56,10 +56,25 @@ struct bnge_vnic_info {
 	u32		vnic_id;
 };
 
+struct bnge_rss_ctx {
+	struct bnge_vnic_info vnic;
+	u32 index;
+};
+
 void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 int bnge_hwrm_vnic_rss_cfg(struct bnge_net *bn,
 			   struct bnge_vnic_info *vnic);
 int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd);
 int bnge_alloc_rfs_vnic(struct bnge_net *bn);
+int bnge_alloc_vnic_rss_table(struct bnge_net *bn,
+			      struct bnge_vnic_info *vnic);
+struct bnge_rss_ctx *bnge_get_rss_ctx_from_index(struct bnge_net *bn, u32 idx);
+void bnge_modify_rss(struct bnge_net *bn, struct ethtool_rxfh_context *ctx,
+		     struct bnge_rss_ctx *rss_ctx,
+		     const struct ethtool_rxfh_param *rxfh);
+void bnge_del_one_rss_ctx(struct bnge_net *bn, struct bnge_rss_ctx *rss_ctx,
+			  bool all);
+void bnge_hwrm_realloc_rss_ctx_vnic(struct bnge_net *bn);
+void bnge_clear_rss_ctxs(struct bnge_net *bn);
 #endif /* _BNGE_VNIC_H_ */
-- 
2.47.1

