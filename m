Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127A34DB6D;
	Wed, 22 Jul 2026 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707984; cv=none; b=MLjJ5rbc7a0MH0dM8bgCnEakAZxgm7qBIoiuWthh/fRj8yir9Iuh4jRP85X1FqCTPbGYVJFAVLDNUlH/a+E0+wwJOZewTSSuTbMQ9rAgfXFU0wcFNAlVw9fMyKGDAb9CRVduS1yM6L4yeXEJ4+zL78BWShlDOO3O0TqllXRyu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707984; c=relaxed/simple;
	bh=sRGTCJAqUluSte4+RCJ7hg8vJMRioNT/Onb3nU++ADY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Awz7yiCbgdmE/n3g6Np67W/6QZ6UvvfaEdspe755WJdQF4lBoD5co8+qIv/7ONy9Iu5mQezb+KWK4yT2ur+tYTQP4rCX4vCexWf8XMesidxZp6PXiQ1z9SHB+vSw0bUbk0jn4N98jWRva/xO+N1zNMdfDez922GC1vaumB/96+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jBX55uQ9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jBX55uQ9"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M6BUQS4097077;
	Wed, 22 Jul 2026 01:12:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=dLyuLrIK3LfFLjBidibHQYy
	GT/V4ojEEnEp5NUtjuR8=; b=jBX55uQ9ec8h0/37r4AU4qtYoLu7tc5A8y6uXWF
	uBBf/JHZnH2Z8W/ODOQ4gd73QknIM/Xvq/O2astyK68abdELuZesGRtVgDCsf9a4
	KFQKuwOQb55tz95RxrIjj97y/VqBlX8tAV20hjvrreOVwvMLGMxXryl0cSoWSOq7
	BmFoQ0dV7HulhgCmJOX06oYGaYax9NVEIooVeB5hRHHQf7KzHKR3pyrQy0lMEGdc
	6qRlBejmr/ix9Vt6kn7RjipDdZIcRfYlLbN12i1vql9J28KZgYQ9HuqMhcuEozxm
	JQzPT+1ySaVtW9OBoWQAuncQQvz8f6DoKMDPSMN9fP8/IiQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fj631uubh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 01:12:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 22 Jul 2026 01:12:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 22 Jul 2026 01:12:40 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 778B43F7052;
	Wed, 22 Jul 2026 01:12:37 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Hariprasad Kelam <hkelam@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v5 net] octeontx2-af: Block VFs from clobbering special CGX PKIND state
Date: Wed, 22 Jul 2026 13:42:29 +0530
Message-ID: <20260722081229.1653619-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=E7P9Y6dl c=1 sm=1 tr=0 ts=6a607b7a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=t4iUwf73pONSdXt1NB0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: aqjAJcWyU_djTiLBy7gL8ncFFwazwRbn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3NCBTYWx0ZWRfX299rGPW9jMZp
 W/y2nYdWOLiUCU48ornpk8eRJO6JMxWce6fu5ktSXocu8SUKQ/78OPie6KbVKNLTF2X5AnJKc7x
 Uwm+MPIPIEb0DyciEfDUM5o5Jc1LoDm1CUQRSlpz7tv1nY8km9FCmkJ7Xf2W7ZMiddeYY3z7wZH
 cUUkqbqWjLTOROvuUlpudJBA6QDx7PebdjSpxfLCftICA5ykAulhAdvc5aJbRUBI1gFhc9VQ+0d
 dSVHAalC4B+ayDRvF9C8oTgkSje3pJxSXKgmJ/JA1hYx8DuxNamr/rYl2uOqUphlpAcNY/Rw0kl
 X4eHTex+DEwIIL3uDC6WwC/PFGI6dZ9p9RPzF2j3anWr6ueZW+ZBQOOgPv1Ld/1NXsdynhR1kms
 kjW3m9OBHcE67bGaatuQSIPsL5ED542cpGMd66fjfjgixiXWVhQxW7EWpO5UpstrVCzygH9iSDV
 fXWUtB3vVpCHyFs73Hg==
X-Proofpoint-GUID: aqjAJcWyU_djTiLBy7gL8ncFFwazwRbn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3NCBTYWx0ZWRfX7JvFSRfyd8Wl
 pRcf2ulnuCyzjND6mZWJVmKw57/QdHL3GBHaRcFo5hr8PoUd2+A5ksJcNQBIhxwCysgaUebvWHH
 pfzYs5Fg67isodcUriOwprbP99eSMjA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01

From: Hariprasad Kelam <hkelam@marvell.com>

PF and VF NIX LFs that share a CGX LMAC reuse the same hardware PKIND
programming. When HiGig2 or EDSA parsing is enabled, a VF NIX LF alloc must
not reset the LMAC RX PKIND or default TX parse config over the PF setup.

Add cgx_get_pkind() and rvu_cgx_is_pkind_config_permitted() so VFs skip
cgx_set_pkind(), rvu_npc_set_pkind(), and NIX_AF_LFX_TX_PARSE_CFG updates
when the LMAC is using NPC_RX_HIGIG_PKIND or NPC_RX_EDSA_PKIND.

Fixes: 94d942c5fb97 ("octeontx2-af: Config pkind for CGX mapped PFs")
Cc: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---

v4 -> v5: Addressed sashiko comments
    https://lore.kernel.org/netdev/20260721062907.784484-1-rkannoth@marvell.com/
v3 -> v4: Addressed simon comments
    https://lore.kernel.org/netdev/20260713121902.3938875-1-rkannoth@marvell.com/
v2 -> v3: Addressed simon comments
    https://lore.kernel.org/netdev/20260709122648.1552103-2-horms@kernel.org/
v1 -> v2: Addressed simon comments
    https://lore.kernel.org/netdev/20260619041002.1773822-1-rkannoth@marvell.com/
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 12 +++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 79 +++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 22 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 29 ++++---
 6 files changed, 131 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 2e94d5105016..f5fd6138c352 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -518,6 +518,18 @@ int cgx_set_pkind(void *cgxd, u8 lmac_id, int pkind)
 	return 0;
 }
 
+int cgx_get_pkind(void *cgxd, u8 lmac_id, int *pkind)
+{
+	struct cgx *cgx = cgxd;
+
+	if (!is_lmac_valid(cgx, lmac_id))
+		return -ENODEV;
+
+	*pkind = cgx_read(cgx, lmac_id, cgx->mac_ops->rxid_map_offset);
+	*pkind = *pkind & 0x3F;
+	return 0;
+}
+
 static u8 cgx_get_lmac_type(void *cgxd, int lmac_id)
 {
 	struct cgx *cgx = cgxd;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 92ccf343dfe0..8411a75dd723 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -141,6 +141,7 @@ int cgx_get_cgxid(void *cgxd);
 int cgx_get_lmac_cnt(void *cgxd);
 void *cgx_get_pdata(int cgx_id);
 int cgx_set_pkind(void *cgxd, u8 lmac_id, int pkind);
+int cgx_get_pkind(void *cgxd, u8 lmac_id, int *pkind);
 int cgx_lmac_evh_register(struct cgx_event_cb *cb, void *cgxd, int lmac_id);
 int cgx_lmac_evh_unregister(void *cgxd, int lmac_id);
 int cgx_get_tx_stats(void *cgxd, int lmac_id, int idx, u64 *tx_stat);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 7f3505ae6860..9d5b7b51bdfa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1115,6 +1115,8 @@ void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			 u8 *intf, u8 *ena);
 int npc_config_cntr_default_entries(struct rvu *rvu, bool enable);
 bool is_cgx_config_permitted(struct rvu *rvu, u16 pcifunc);
+bool rvu_cgx_check_permission_and_set_pkind(struct rvu *rvu, u16 pcifunc, int pkind);
+bool rvu_cgx_is_pkind_config_permitted(struct rvu *rvu, u16 pcifunc);
 bool is_mac_feature_supported(struct rvu *rvu, int pf, int feature);
 u32  rvu_cgx_get_fifolen(struct rvu *rvu);
 void *rvu_first_cgx_pdata(struct rvu *rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 4ff3935ed3fe..87d21889dc49 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -1355,3 +1355,82 @@ void rvu_mac_reset(struct rvu *rvu, u16 pcifunc)
 	if (mac_ops->mac_reset(cgxd, lmac, !is_vf(pcifunc)))
 		dev_err(rvu->dev, "Failed to reset MAC\n");
 }
+
+/* Do not allow CGX-mapped VFs to overwrite PKIND when special parse kinds
+ * (HiGig, EDSA, etc.) are in use on the shared LMAC. VFs must not program
+ * NPC_TX_DEF_PKIND on NIX_AF_LFX_TX_PARSE_CFG in that case: the PF owns
+ * parse mode and no separate NPC_TX_HIGIG_PKIND is installed on the VF LF.
+ * TX-parse callers skip the write when denied; rvu_lf_reset() clears each LF
+ * before alloc so the next permitted owner programs NPC_TX_DEF_PKIND.
+ */
+bool rvu_cgx_is_pkind_config_permitted(struct rvu *rvu, u16 pcifunc)
+{
+	int pf, err, rxpkind;
+	u8 cgx_id, lmac_id;
+	void *cgxd;
+
+	pf = rvu_get_pf(rvu->pdev, pcifunc);
+
+	if (!(pcifunc & RVU_PFVF_FUNC_MASK))
+		return true;
+
+	if (!is_pf_cgxmapped(rvu, pf))
+		return true;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+	cgxd = rvu_cgx_pdata(cgx_id, rvu);
+	err = cgx_get_pkind(cgxd, lmac_id, &rxpkind);
+	if (err)
+		return false;
+
+	switch (rxpkind) {
+	case NPC_RX_HIGIG_PKIND:
+	case NPC_RX_EDSA_PKIND:
+		return false;
+	default:
+		return true;
+	}
+}
+
+/* Do not allow CGX-mapped VFs to overwrite PKIND when special parse kinds
+ * (HiGig, EDSA, etc.) are in use on the shared LMAC.
+ */
+bool rvu_cgx_check_permission_and_set_pkind(struct rvu *rvu, u16 pcifunc, int pkind)
+{
+	int pf, err, rxpkind;
+	u8 cgx_id, lmac_id;
+	struct cgx *cgxd;
+
+	pf = rvu_get_pf(rvu->pdev, pcifunc);
+
+	if (!is_pf_cgxmapped(rvu, pf))
+		return false;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+	cgxd = rvu_cgx_pdata(cgx_id, rvu);
+
+	mutex_lock(&cgxd->lock);
+	if (!is_vf(pcifunc))
+		goto set;
+
+	err = cgx_get_pkind(cgxd, lmac_id, &rxpkind);
+	if (err)
+		goto err;
+
+	switch (rxpkind) {
+	case NPC_RX_HIGIG_PKIND:
+	case NPC_RX_EDSA_PKIND:
+		goto err;
+	default:
+		break;
+	}
+
+set:
+	cgx_set_pkind(rvu_cgx_pdata(cgx_id, rvu), lmac_id, pkind);
+	mutex_unlock(&cgxd->lock);
+	return true;
+
+err:
+	mutex_unlock(&cgxd->lock);
+	return false;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 6a0ce2665031..964bcaae098e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -363,8 +363,8 @@ static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
 		pfvf->tx_chan_cnt = 1;
 		rsp->tx_link = cgx_id * hw->lmac_per_cgx + lmac_id;
 
-		cgx_set_pkind(rvu_cgx_pdata(cgx_id, rvu), lmac_id, pkind);
-		rvu_npc_set_pkind(rvu, pkind, pfvf);
+		if (rvu_cgx_check_permission_and_set_pkind(rvu, pcifunc, pkind))
+			rvu_npc_set_pkind(rvu, pkind, pfvf);
 		break;
 	case NIX_INTF_TYPE_LBK:
 		vf = (pcifunc & RVU_PFVF_FUNC_MASK) - 1;
@@ -1505,13 +1505,15 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 				  struct nix_lf_alloc_req *req,
 				  struct nix_lf_alloc_rsp *rsp)
 {
-	int nixlf, qints, hwctx_size, intf, rc = 0;
+	int nixlf, qints, hwctx_size, intf, rc = 0, pf;
 	u16 bcast, mcast, promisc, ucast;
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = req->hdr.pcifunc;
+	u8 cgx_id = 0, lmac_id = 0;
 	bool rules_created = false;
 	struct rvu_block *block;
 	struct rvu_pfvf *pfvf;
+	struct cgx *cgxd;
 	u64 cfg, ctx_cfg;
 	int blkaddr;
 
@@ -1685,8 +1687,20 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RX_CFG(nixlf), req->rx_cfg);
 
 	/* Configure pkind for TX parse config */
+
+	pf = rvu_get_pf(rvu->pdev, pcifunc);
 	cfg = NPC_TX_DEF_PKIND;
-	rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
+
+	if (is_pf_cgxmapped(rvu, pf) && is_vf(pcifunc)) {
+		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+		cgxd = rvu_cgx_pdata(cgx_id, rvu);
+		mutex_lock(&cgxd->lock);
+		if (rvu_cgx_is_pkind_config_permitted(rvu, pcifunc))
+			rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
+		mutex_unlock(&cgxd->lock);
+	} else {
+		rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
+	}
 
 	if (is_rep_dev(rvu, pcifunc)) {
 		pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c7bc0b3a29b9..38554d51164e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -19,6 +19,7 @@
 #include "cn20k/npc.h"
 #include "rvu_npc.h"
 #include "cn20k/reg.h"
+#include "lmac_common.h"
 
 #define RSVD_MCAM_ENTRIES_PER_PF	3 /* Broadcast, Promisc and AllMulticast */
 #define RSVD_MCAM_ENTRIES_PER_NIXLF	1 /* Ucast for LFs */
@@ -4200,10 +4201,11 @@ int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
 
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
-	int blkaddr, nixlf, rc, intf_mode;
 	int pf = rvu_get_pf(rvu->pdev, pcifunc);
+	int blkaddr, nixlf, rc, intf_mode;
+	u8 cgx_id = 0, lmac_id = 0;
 	u64 rxpkind, txpkind;
-	u8 cgx_id, lmac_id;
+	struct cgx *cgxd;
 
 	/* use default pkind to disable edsa/higig */
 	rxpkind = rvu_npc_get_pkind(rvu, pf);
@@ -4227,12 +4229,8 @@ int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
 		/* rx pkind set req valid only for cgx mapped PFs */
 		if (!is_cgx_config_permitted(rvu, pcifunc))
 			return 0;
-		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
-
-		rc = cgx_set_pkind(rvu_cgx_pdata(cgx_id, rvu), lmac_id,
-				   rxpkind);
-		if (rc)
-			return rc;
+		if (!rvu_cgx_check_permission_and_set_pkind(rvu, pcifunc, rxpkind))
+			return -EINVAL;
 	}
 
 	if (dir & PKIND_TX) {
@@ -4241,8 +4239,19 @@ int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
 		if (rc)
 			return rc;
 
-		rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf),
-			    txpkind);
+		if (is_pf_cgxmapped(rvu, pf) && is_vf(pcifunc)) {
+			rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id,
+					    &lmac_id);
+			cgxd = rvu_cgx_pdata(cgx_id, rvu);
+			mutex_lock(&cgxd->lock);
+			if (rvu_cgx_is_pkind_config_permitted(rvu, pcifunc))
+				rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf),
+					    txpkind);
+			mutex_unlock(&cgxd->lock);
+		} else {
+			rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf),
+				    txpkind);
+		}
 	}
 
 	pfvf->intf_mode = intf_mode;
-- 
2.43.0

