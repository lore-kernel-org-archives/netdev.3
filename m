Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748C3A7F66;
	Tue,  1 Sep 2026 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236731; cv=none; b=QkqObU0XwUeJeCKJa/HBn1fCHOJPMkqDx7ra+983kSORdMX2W24h1VJTdo4bkOFRNjenpqQlXhaka/Wz+Q/3Pxob9fv7Oe2699IWBpCr6B+Ht9yHjSOmWxr+MiDSWosC1+lCKlQH8zSf6RX2GnhKlXEd9W3Lwd2wfcZ73X243pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236731; c=relaxed/simple;
	bh=hY3sDcghiMFGukVtOLTlXfv+Zr2iLfdxjsnZHzknuho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OtqgYXr2T2aPvzVKRP8XfoOyNvCfDLTGDptcI6EwjEMnEc+pX7giBayVW9vodfJwdZ1xf2yJzkUevC6yY0Z8ZUJdXpx7ICw+OthmoCpssmO2P0iCwTy5auIMyVjl3eXQ9WHO1L6ms5K44qyqal3x2zZgk7M4y8qYOGQTYUukbz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gjxIPuH3; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gjxIPuH3"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6811Gb3O2184756;
	Mon, 31 Aug 2026 21:25:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=6Cq5KTgZQp2nU9/LnUOde2C
	xGi5SbmNSc6SpHdZOzGw=; b=gjxIPuH3xj2aJms3z9dYo4BaaIp6NRo9YrJBAjf
	gpvY50GYfzU1qsbpVlfHOGfojJyFKO5GATNGFkKGpswzsLrfX7XFwSqhLJM0R3wX
	8rhKlLylJ++2bQT19O97JtPlW6qz1CEgpi48Qmnrk90Yq/+166yZgE3v3V5RcRld
	GZ/GuMrSsuyI1u3o6AwHj+YVX8AcCUmp+P0i1XTDxXq8AdmnvMFg7BVDJRMAwaMB
	z+7mVZXIKcdUvIaNVIiGAKTUtXVE0dnckOsonB8CctJeboV4C1WfHlXhyftw6ZbS
	lWUwQ4300hlJk3EUL/w1roChky0giyVSzf8DpBQhxUT1dWQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gdmvqrhac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 21:25:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 21:25:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 21:25:17 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 2E5DC5B6926;
	Mon, 31 Aug 2026 21:25:12 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Richard
 Cochran" <richardcochran@gmail.com>
Subject: [PATCH net-next] octeontx2-af: Show DMAC filter drop count
Date: Tue, 1 Sep 2026 09:55:02 +0530
Message-ID: <20260901042503.1182121-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDAzNiBTYWx0ZWRfX0a/UBgUAKxX0
 nA6UhvzShz60LMfo2V+d7AduWOfG4m1uW772N+aV7zosSshGMxp4sGcdz/GXJwomVZcmClC7Z+F
 uNnAhODVGmCE9kI/tlwBQulqEquqvc7UmmO0hjGLxGUhMFcN9YGwKjLjfRejT7j2/EQijVSWjAH
 bXToJ9RLoVSocy3l5kn0r67hxGm/qpzAnROGTOz+Z1nn8sDY+zaXPdz1ssejlKkh+ZfUCrHJ/Cr
 KgNoZgD/Eloo1qbTZfTmSvZ+qbSWA6IjYpMyynNOYUvFYbanCCMP9J/VpywwLTKZsY6gMzw+8sY
 /owfxXPOzA/b87r2Mu80rutkUvKy+n4Bd2fpPemHMmQerSoh62aNl8LrNUBhH10aeSN3mbtZxwu
 l1nb9Z86phqSECmC231EfMyHPT7mMtIcAou+Z0muMvNQMlHOHIabugCXvQJ3VzT9xzQqx3typTJ
 rOGukTzcNt94BYYMQ7w==
X-Authority-Analysis: v=2.4 cv=HYQkiCE8 c=1 sm=1 tr=0 ts=6a9653ae cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=UGxpMdJmOms3Uc27T-0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: l8SyybLIMiP_I72lZxoUY5b-y69tAxjp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDAzNiBTYWx0ZWRfX6jbcgrZ7gUC/
 93qHvGfw4ekkz4vGfMiLywtYYQ9UjYeUvxlMWnKOyrTVkz3Q+OvA4Y0kyPBjUAONYl+7b7fcjH1
 Odss2fwjCMAUnb6RlMqOrYKoAzh4ktQ=
X-Proofpoint-GUID: l8SyybLIMiP_I72lZxoUY5b-y69tAxjp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01

From: Hariprasad Kelam <hkelam@marvell.com>

Show the number of packets dropped by DMAC filters in the CGX/RPM
debugfs mac_filter entry.

CGX uses RX_STAT4 for this counter, while RPM/RPM2 use RX_STAT2.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 13 +++++-
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  2 +
 .../marvell/octeontx2/af/lmac_common.h        |  2 +
 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 40 +++++++++++++------
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |  2 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 12 ++++++
 .../marvell/octeontx2/af/rvu_debugfs.c        |  8 ++++
 8 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index f5fd6138c352..3696bec7a8fc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -752,6 +752,16 @@ u64 cgx_features_get(void *cgxd)
 	return ((struct cgx *)cgxd)->hw_features;
 }
 
+u64 cgx_get_dmacflt_dropped_pktcnt(void *cgxd, int lmac_id)
+{
+	struct cgx *cgx = cgxd;
+
+	if (!is_lmac_valid(cgx, lmac_id))
+		return 0;
+
+	return cgx_read(cgx, lmac_id, CGXX_CMRX_RX_STAT4);
+}
+
 int cgx_stats_reset(void *cgxd, int lmac_id)
 {
 	struct cgx *cgx = cgxd;
@@ -1943,7 +1953,8 @@ static struct mac_ops	cgx_mac_ops    = {
 	.pfc_config =                   cgx_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        cgx_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			cgx_lmac_reset,
-	.mac_stats_reset       =	cgx_stats_reset,
+	.get_dmacflt_dropped_pktcnt      =      cgx_get_dmacflt_dropped_pktcnt,
+	.mac_stats_reset		 =	cgx_stats_reset,
 	.mac_x2p_reset                   =      cgx_x2p_reset,
 	.mac_enadis_rx			 =      cgx_enadis_rx,
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 8411a75dd723..cd8858c4e41c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -39,6 +39,7 @@
 #define CGXX_CMRX_INT_ENA_W1S		0x058
 #define CGXX_CMRX_RX_ID_MAP		0x060
 #define CGXX_CMRX_RX_STAT0		0x070
+#define CGXX_CMRX_RX_STAT4		0x090
 #define CGXX_CMRX_RX_LOGL_XON		0x100
 #define CGXX_CMRX_RX_LMACS		0x128
 #define CGXX_CMRX_RX_DMAC_CTL0		(0x1F8 + mac_ops->csr_offset)
@@ -187,5 +188,6 @@ int cgx_lmac_get_pfc_frm_cfg(void *cgxd, int lmac_id, u8 *tx_pause,
 int verify_lmac_fc_cfg(void *cgxd, int lmac_id, u8 tx_pause, u8 rx_pause,
 		       int pfvf_idx);
 int cgx_lmac_reset(void *cgxd, int lmac_id, u8 pf_req_flr);
+u64 cgx_get_dmacflt_dropped_pktcnt(void *cgx, int lmac_id);
 u32 cgx_get_fifo_len(void *cgxd);
 #endif /* CGX_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index 6180e68e1765..f07139e1f4ce 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -128,6 +128,8 @@ struct mac_ops {
 						       u8 *tx_pause, u8 *rx_pause);
 	int			(*mac_reset)(void *cgxd, int lmac_id, u8 pf_req_flr);
 
+	u64			(*get_dmacflt_dropped_pktcnt)(void *cgxd, int lmac_id);
+
 	/* FEC stats */
 	int			(*get_fec_stats)(void *cgxd, int lmac_id,
 						 struct cgx_fec_stats_rsp *rsp);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 2e9945446199..d46e8ec7230f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -29,18 +29,19 @@ static struct mac_ops		rpm_mac_ops   = {
 	.mac_get_tx_stats  =	rpm_get_tx_stats,
 	.get_fec_stats	   =	rpm_get_fec_stats,
 	.mac_enadis_rx_pause_fwding =	rpm_lmac_enadis_rx_pause_fwding,
-	.mac_get_pause_frm_status =	rpm_lmac_get_pause_frm_status,
-	.mac_enadis_pause_frm =		rpm_lmac_enadis_pause_frm,
-	.mac_pause_frm_config =		rpm_lmac_pause_frm_config,
-	.mac_enadis_ptp_config =	rpm_lmac_ptp_config,
-	.mac_rx_tx_enable =		rpm_lmac_rx_tx_enable,
-	.mac_tx_enable =		rpm_lmac_tx_enable,
-	.pfc_config =                   rpm_lmac_pfc_config,
-	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
-	.mac_reset   =			rpm_lmac_reset,
-	.mac_stats_reset		 =	  rpm_stats_reset,
-	.mac_x2p_reset                   =        rpm_x2p_reset,
-	.mac_enadis_rx			 =        rpm_enadis_rx,
+	.mac_get_pause_frm_status   =	rpm_lmac_get_pause_frm_status,
+	.mac_enadis_pause_frm	    =	rpm_lmac_enadis_pause_frm,
+	.mac_pause_frm_config	    =	rpm_lmac_pause_frm_config,
+	.mac_enadis_ptp_config	    =	rpm_lmac_ptp_config,
+	.mac_rx_tx_enable	    =	rpm_lmac_rx_tx_enable,
+	.mac_tx_enable		    =	rpm_lmac_tx_enable,
+	.pfc_config		    =	rpm_lmac_pfc_config,
+	.mac_get_pfc_frm_cfg	    =	rpm_lmac_get_pfc_frm_cfg,
+	.mac_reset		    =	rpm_lmac_reset,
+	.get_dmacflt_dropped_pktcnt =   rpm_get_dmacflt_dropped_pktcnt,
+	.mac_stats_reset	    =	rpm_stats_reset,
+	.mac_x2p_reset              =   rpm_x2p_reset,
+	.mac_enadis_rx		    =   rpm_enadis_rx,
 };
 
 static struct mac_ops		rpm2_mac_ops   = {
@@ -73,6 +74,7 @@ static struct mac_ops		rpm2_mac_ops   = {
 	.pfc_config =                   rpm_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			rpm_lmac_reset,
+	.get_dmacflt_dropped_pktcnt =   rpm_get_dmacflt_dropped_pktcnt,
 	.mac_stats_reset	    =	rpm_stats_reset,
 	.mac_x2p_reset              =   rpm_x2p_reset,
 	.mac_enadis_rx		    =   rpm_enadis_rx,
@@ -449,6 +451,20 @@ int rpm_get_tx_stats(void *rpmd, int lmac_id, int idx, u64 *tx_stat)
 	return 0;
 }
 
+u64 rpm_get_dmacflt_dropped_pktcnt(void *rpmd, int lmac_id)
+{
+	rpm_t *rpm = rpmd;
+	u64 dmac_flt_stat;
+
+	if (!is_lmac_valid(rpm, lmac_id))
+		return 0;
+
+	dmac_flt_stat = is_dev_rpm2(rpm) ? RPM2_CMRX_RX_STAT2 :
+			RPMX_CMRX_RX_STAT2;
+
+	return rpm_read(rpm, lmac_id, dmac_flt_stat);
+}
+
 int rpm_stats_reset(void *rpmd, int lmac_id)
 {
 	rpm_t *rpm = rpmd;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index b8d3972e096a..443481010aba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -60,6 +60,7 @@
 #define RPMX_MTI_STAT_RX_STAT_PAGES_COUNTERX 0x12000
 #define RPMX_MTI_STAT_TX_STAT_PAGES_COUNTERX 0x13000
 #define RPMX_MTI_STAT_DATA_HI_CDC            0x10038
+#define RPMX_CMRX_RX_STAT2		     0x4010
 
 #define RPM_LMAC_FWI			0xa
 #define RPM_TX_EN			BIT_ULL(0)
@@ -129,6 +130,7 @@ int rpm_lmac_enadis_pause_frm(void *rpmd, int lmac_id, u8 tx_pause,
 			      u8 rx_pause);
 int rpm_get_tx_stats(void *rpmd, int lmac_id, int idx, u64 *tx_stat);
 int rpm_get_rx_stats(void *rpmd, int lmac_id, int idx, u64 *rx_stat);
+u64 rpm_get_dmacflt_dropped_pktcnt(void *rpmd, int lmac_id);
 void rpm_lmac_ptp_config(void *rpmd, int lmac_id, bool enable);
 int rpm_lmac_rx_tx_enable(void *rpmd, int lmac_id, bool enable);
 int rpm_lmac_tx_enable(void *rpmd, int lmac_id, bool enable);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 094227404ef9..9afb7ac8969b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1127,6 +1127,7 @@ int rvu_cgx_prio_flow_ctrl_cfg(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_
 			       u16 pfc_en);
 int rvu_cgx_cfg_pause_frm(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_pause);
 void rvu_mac_reset(struct rvu *rvu, u16 pcifunc);
+u64 rvu_cgx_get_dmacflt_dropped_pktcnt(void *cgxd, int lmac_id);
 u32 rvu_cgx_get_lmac_fifolen(struct rvu *rvu, int cgx, int lmac);
 void cgx_start_linkup(struct rvu *rvu);
 int npc_get_nixlf_mcam_index(struct npc_mcam *mcam,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 87d21889dc49..41f157ea27f4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -1356,6 +1356,18 @@ void rvu_mac_reset(struct rvu *rvu, u16 pcifunc)
 		dev_err(rvu->dev, "Failed to reset MAC\n");
 }
 
+u64 rvu_cgx_get_dmacflt_dropped_pktcnt(void *cgxd, int lmac_id)
+{
+	struct mac_ops *mac_ops;
+
+	mac_ops = get_mac_ops(cgxd);
+
+	if (!mac_ops || !mac_ops->get_dmacflt_dropped_pktcnt)
+		return 0;
+
+	return mac_ops->get_dmacflt_dropped_pktcnt(cgxd, lmac_id);
+}
+
 /* Do not allow CGX-mapped VFs to overwrite PKIND when special parse kinds
  * (HiGig, EDSA, etc.) are in use on the shared LMAC. VFs must not program
  * NPC_TX_DEF_PKIND on NIX_AF_LFX_TX_PARSE_CFG in that case: the PF owns
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 3456313d3b3c..e6ccaa29e05c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2957,8 +2957,10 @@ static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
 	struct rvu_cgx_lmac_dbgfs_ctx *dctx = s->private;
 	struct rvu *rvu = dctx->rvu;
 	struct pci_dev *pdev = NULL;
+	struct mac_ops *mac_ops;
 	void *cgxd = dctx->cgxd;
 	char *bcast, *mcast;
+	u64 drop_cnt;
 	u16 index, domain;
 	u8 dmac[ETH_ALEN];
 	u64 cfg, mac;
@@ -2997,6 +2999,12 @@ static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
 		}
 	}
 
+	mac_ops = get_mac_ops(cgxd);
+	if (mac_ops && mac_ops->get_dmacflt_dropped_pktcnt) {
+		drop_cnt = rvu_cgx_get_dmacflt_dropped_pktcnt(cgxd, lmac_id);
+		seq_printf(s, "\nDMAC filter drop count: %llu\n", drop_cnt);
+	}
+
 	pci_dev_put(pdev);
 	return 0;
 }
-- 
2.48.1

