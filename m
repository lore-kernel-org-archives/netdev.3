Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183144EA368
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367062; cv=none; b=WOLZJcfxSORiCX34zYiLkEX2ARpiAUpNAjXcnMEQ+ZCvjnVp0IRN/Y1R7QtUfP+hR3pwm84niQ85j+Db08YQbTYY1OqMdHwRNO6G8YD23p5N25UVYtmIecSS5mcfJ3OxizOokdcVHVKtHvRH60+GqejJI5qABDQXt5VrMlQ9Ryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367062; c=relaxed/simple;
	bh=Ms/jJvQh74i6s0Lc1TxdKZyutNeVLiaKxPMtgWlKLI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGrfHZlD6Ms9fgip2oizcNakOFrRVbg6qUN2a+woXM55KEpG/SJL4OUMUS9jY0Gn1F22GAeimk+TqotUbJYN68yGzFhxRnQDj1w4UwBtuGKl3ZHo0FfUxfG2Pw38MVaHGlNMgUTlUEX/0LDHurGursAK6HnwgXl906fmMls5iSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm+pneAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm+pneAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6A71F00899;
	Fri, 25 Sep 2026 20:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367044;
	bh=VGt0Xaf9zViW3xHKeiVgiRO1EBSd7u0PWW4Ob0x8ruo=;
	h=From:To:Cc:Subject:Date;
	b=jm+pneAEMlzkQaZDxcG0YrwcnTQX7TRCDGrT0NBg0W7pkE9pFrR6PgSZpHFJhzf78
	 nnGmNm/IIYtrrx8nKLU2cB5qp4TOsgXuYn4TSLIbP6EzF6zUjJ06RQW0RGDnDLye5V
	 NYYGmjLs/WcjqgRNhgXhqufO1009b1nsK0QjYRf+lid0YEFTrQfE6ajQPT4S17ClcI
	 8ETCYhJZBe0yNkIqwxYyBYi2gsWZH77rxKxyU7x3HbZMJA2yOWYAOutstadgrtna4B
	 tQoJPwmYCF9pCVxtDgXlfdFvN7Tw+aydfW39UXWqdToSYly3y1/YnFzz5Fpub9Uz9O
	 D4WvXSv/69o0g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	hch@infradead.org,
	sgoutham@marvell.com,
	rkannoth@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	bbhushan2@marvell.com,
	lcherian@marvell.com
Subject: [PATCH net-next] octeontx2: remove unneeded symbol exports
Date: Fri, 25 Sep 2026 13:10:42 -0700
Message-ID: <20260925201042.1174488-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

octeontx2 has a bunch of symbols not used outside the module which
defines them. Worse, still the macro which defines otx2_mbox_up_handler_*
adds exports for all the functions. Remove all the explicit exports
and the auto-export from that macro.

otx2_mbox_up_handler_cgx_link_event was exported by the macro and
is genuienly called from the VF driver, so add an export.

Link: https://lore.kernel.org/arYYTw8l90VNnKal@infradead.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
cc: hch@infradead.org
CC: sgoutham@marvell.com
CC: rkannoth@marvell.com
CC: gakula@marvell.com
CC: sbhatta@marvell.com
CC: bbhushan2@marvell.com
CC: lcherian@marvell.com
---
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c    | 1 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 8 +-------
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c  | 5 -----
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c  | 3 ---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c     | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c     | 1 -
 6 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
index fe8f926c8b75..8ebbf844f155 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
@@ -18,4 +18,3 @@ int rvu_mbox_handler_npa_cn20k_aq_enq(struct rvu *rvu,
 	return rvu_npa_aq_enq_inst(rvu, (struct npa_aq_enq_req *)req,
 				   (struct npa_aq_enq_rsp *)rsp);
 }
-EXPORT_SYMBOL(rvu_mbox_handler_npa_cn20k_aq_enq);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 175992188c18..6e4ad26a663a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -732,7 +732,6 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 
 	return otx2_sync_mbox_msg(&pfvf->mbox);
 }
-EXPORT_SYMBOL(otx2_txschq_config);
 
 int otx2_smq_flush(struct otx2_nic *pfvf, int smq)
 {
@@ -756,7 +755,6 @@ int otx2_smq_flush(struct otx2_nic *pfvf, int smq)
 	mutex_unlock(&pfvf->mbox.lock);
 	return rc;
 }
-EXPORT_SYMBOL(otx2_smq_flush);
 
 int otx2_txsch_alloc(struct otx2_nic *pfvf)
 {
@@ -828,7 +826,6 @@ void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq)
 
 	mutex_unlock(&pfvf->mbox.lock);
 }
-EXPORT_SYMBOL(otx2_txschq_free_one);
 
 void otx2_txschq_stop(struct otx2_nic *pfvf)
 {
@@ -1838,7 +1835,6 @@ int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable)
 
 	return otx2_sync_mbox_msg(&pfvf->mbox);
 }
-EXPORT_SYMBOL(otx2_nix_config_bp);
 
 int otx2_nix_cpt_config_bp(struct otx2_nic *pfvf, bool enable)
 {
@@ -1863,7 +1859,6 @@ int otx2_nix_cpt_config_bp(struct otx2_nic *pfvf, bool enable)
 
 	return otx2_sync_mbox_msg(&pfvf->mbox);
 }
-EXPORT_SYMBOL(otx2_nix_cpt_config_bp);
 
 /* Mbox message handlers */
 void mbox_handler_cgx_stats(struct otx2_nic *pfvf,
@@ -2110,8 +2105,7 @@ otx2_mbox_up_handler_ ## _fn_name(struct otx2_nic *pfvf,		\
 {									\
 	/* Nothing to do here */					\
 	return 0;							\
-}									\
-EXPORT_SYMBOL(otx2_mbox_up_handler_ ## _fn_name);
+}
 MBOX_UP_CGX_MESSAGES
 MBOX_UP_MCS_MESSAGES
 #undef M
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index 91d346d114af..e3d54009180d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -54,7 +54,6 @@ int otx2_pfc_txschq_config(struct otx2_nic *pfvf)
 
 	return 0;
 }
-EXPORT_SYMBOL(otx2_pfc_txschq_config);
 
 static int otx2_pfc_txschq_alloc_one(struct otx2_nic *pfvf, u8 prio)
 {
@@ -123,7 +122,6 @@ int otx2_pfc_txschq_alloc(struct otx2_nic *pfvf)
 
 	return 0;
 }
-EXPORT_SYMBOL(otx2_pfc_txschq_alloc);
 
 static int otx2_pfc_txschq_stop_one(struct otx2_nic *pfvf, u8 prio)
 {
@@ -262,7 +260,6 @@ int otx2_pfc_txschq_update(struct otx2_nic *pfvf)
 
 	return 0;
 }
-EXPORT_SYMBOL(otx2_pfc_txschq_update);
 
 int otx2_pfc_txschq_stop(struct otx2_nic *pfvf)
 {
@@ -285,7 +282,6 @@ int otx2_pfc_txschq_stop(struct otx2_nic *pfvf)
 
 	return 0;
 }
-EXPORT_SYMBOL(otx2_pfc_txschq_stop);
 
 int otx2_config_priority_flow_ctrl(struct otx2_nic *pfvf)
 {
@@ -395,7 +391,6 @@ void otx2_update_bpid_in_rqctx(struct otx2_nic *pfvf, int vlan_prio, int qidx,
 			 "Updating BPIDs in CQ and Aura contexts of RQ%d failed with err %d\n",
 			 qidx, err);
 }
-EXPORT_SYMBOL(otx2_update_bpid_in_rqctx);
 
 static int otx2_dcbnl_ieee_getpfc(struct net_device *dev, struct ieee_pfc *pfc)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 99d78fc5a2c4..6d095023d17b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -281,7 +281,6 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 			    count, allocated);
 	return allocated;
 }
-EXPORT_SYMBOL(otx2_alloc_mcam_entries);
 
 int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 {
@@ -420,7 +419,6 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	refcount_set(&flow_cfg->mark_flows, 1);
 	return 0;
 }
-EXPORT_SYMBOL(otx2_mcam_entry_init);
 
 /* TODO : revisit on size */
 #define OTX2_DMAC_FLTR_BITMAP_SZ (4 * 2048 + 32)
@@ -654,7 +652,6 @@ int otx2_get_maxflows(struct otx2_flow_config *flow_cfg)
 	else
 		return flow_cfg->max_flows;
 }
-EXPORT_SYMBOL(otx2_get_maxflows);
 
 int otx2_get_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc,
 		  u32 location)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c0e2100de1d9..7dc0ce669d0b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -959,6 +959,7 @@ int otx2_mbox_up_handler_cgx_link_event(struct otx2_nic *pf,
 	otx2_handle_link_event(pf);
 	return 0;
 }
+EXPORT_SYMBOL(otx2_mbox_up_handler_cgx_link_event);
 
 static int otx2_process_mbox_msg_up(struct otx2_nic *pf,
 				    struct mbox_msghdr *req)
@@ -3102,7 +3103,6 @@ int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 
 	return otx2_register_mbox_intr(pf, false);
 }
-EXPORT_SYMBOL(otx2_realloc_msix_vectors);
 
 static int otx2_sriov_vfcfg_init(struct otx2_nic *pf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 039fd47ebf52..dee38d5c7f65 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -1675,4 +1675,3 @@ void otx2_tc_apply_ingress_police_rules(struct otx2_nic *nic)
 			otx2_tc_config_ingress_rule(nic, node);
 	}
 }
-EXPORT_SYMBOL(otx2_tc_apply_ingress_police_rules);
-- 
2.55.0

