Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260021;
	b=2D3G3SedKhvqDuEGcw19fbTmmDiMsah+TC9ShGbDEzc7YxzmafDatY91F3sEKFRoMeDB
	 IC9S5rQ3J2VHjM3kDAPdmwmlfnZ99SgoBbZuMD3zdDVJz3/b5qLfCcsTdhlWdOlM1Ebne
	 dkxyLyr/KT1jgmENsN49rtki06VBC2K1FLWrMz/0hZ3yoK/c1X34WgyAeveasCtgTLMQh
	 gFlrKoOvB+u3KbJaplMyI6q+4jF8dT8OIs4/3wzVfUEHuxC7UMOx4OO8I5YXNB3aBERiq
	 Obv7V4ULrB1KeAEOcWjPD0ruO5L7zx0/sxKRcHZzs/ZeD9xSVXL1kyMO+KrFu+xDESg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260021;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version;
	bh=7w1kF4JKD9yMYLJ1WZx0v2GmnR/7yGWA1vJOKp1xLeI=;
	b=wLTYMRfvNneTgjtAN+Nb7xHRCHULvQdNUFmbZRc41F2Ji7EXqNQh/a6gjCCHqUEEOIkF
	 W6/WA1ZDael7TYMHYf2cV/9Dha3scdlLfTz6j+L/OtUIPgqn1uvk0V2oijMJk2H8AbF/p
	 qtWu2f/KZ0DU5ttMsF6V8lDedTt0uenhsFIlShlYenPc9XlpKKL5TNMgQANSU99HBGPcM
	 j3x1Cm0emc0QPbIHXaC+tO3e11JuFY8zpKKhsjIyQZla9DFPyNlQKNwf8LrMohmusxY+Q
	 m21J/5mcdOr+9gH48EC8x+Qn8Cyws1b/FrdJ5m0trv3Ut4PIkopl70jQ7WnThWVrr8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=U57H5O4v;
	arc=none smtp.remote-ip=67.231.148.174
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3AE606A31C;
	Thu, 29 Oct 2026 07:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB3AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=U57H5O4v
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T6wEXq3214496;
	Thu, 29 Oct 2026 00:46:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=7w1kF4JKD9yMYLJ1WZx0v2G
	mnR/7yGWA1vJOKp1xLeI=; b=U57H5O4v2YOKEXiOYTyKk0WVTDlmsjahN23toyy
	FvXwmzfalINUegmr59WPo5p49TScGk6iOEcC21hSRUEIeJIaaDT6Gj2N1RmazHLu
	QIxn36PynytX0OXT5Ua0iJlvAJJCQccxa3VpQNnXtOv2htVHAOsZw7Hp06U9KYc4
	Aq/7S9nO6UrPZQzh88vOwii481Y6QC6uA8xXfvc+4RaFAW0/KGvik4qfdWuu5vLQ
	Exh+oXOS6Ma9MtvKMrdfoDWLPRZofTjNZD6hd3Q4ZeQuyRM6Ut5CNUv7+5X2gILk
	pE8xWXxtPEMdVjoPW9eNU831P6aOSA8vfi6oY41t4m8n1Aw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hm1bf05qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 00:46:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 Oct 2026 00:46:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 29 Oct 2026 00:46:40 -0700
Received: from localhost.localdomain (unknown [10.110.24.192])
	by maili.marvell.com (Postfix) with ESMTP id 5A2E65C68FD;
	Thu, 29 Oct 2026 00:46:39 -0700 (PDT)
From: vmukunda <vmukunda@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S
 . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "Naveen
 Mamindlapalli" <naveenm@marvell.com>,
        vmukunda <vmukunda@marvell.com>
Subject: [PATCH] octeontx2-af: fix TX hang after link mode change under traffic
Date: Thu, 29 Oct 2026 07:46:35 +0000
Message-ID: <20261029074635.4139111-1-vmukunda@marvell.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyOSBTYWx0ZWRfX0VRMdMWZVQ82
 OT7xybG5kpjJgXHpr++pPuo1Mdo/QxaA5ulZ/ZmBHYxQZ3R5btmCuRDaa0Yv63G8eALqTTjydvL
 1wtlV94PmpUtzmFuvh8BW0QAY3v+qz9nFoGtJK4UsyNpiUdGHmuTF5TvI8EwLL/G+ALcEp2WwA7
 lUnws3BhRB9gg/RuoydX1HMPcmmBFGQmHAD9QGSOY/xVQ5l4E4QSk2mjPDZrMwMqMjBPXNbZGNa
 hHTDkyPupjapiszZZCEEE2xVlDNmoekRffN+YaTF1x3Y9kK12y8tTX235/IxtFC3bOEHmiEbihP
 JzKsHfD+JRjpG80LKkTjC7qSVgkOTqxkGZx/5fPefusvtOl/wNh8cv4hHYMH74Mx/R0oleVqd/E
 JNmkMndSKgzik0uCfna5qOC0b9JgBefqBg5ncgtJ9C2qOLYwdu6mmM/x7v3ChRFHXqe5ea+dCQK
 vN8mIShP5mWd37O04RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyOSBTYWx0ZWRfX+V103RDzhjMm
 6RI1ggFOYAlBghl0QJzqqK1vOt5thGbPZ7blxW3lBSl708QVeX+nkRfi4pCcZHsDjOpDkYhtoxK
 ToNH35mIIb+wFq2yS4IrJQv0aqVl3LI=
X-Proofpoint-GUID: f_v6AtngsfN0Zr2NkuLS9QBuZn6_44jL
X-Proofpoint-ORIG-GUID: f_v6AtngsfN0Zr2NkuLS9QBuZn6_44jL
X-Authority-Analysis: v=2.4 cv=FaWiV5+6 c=1 sm=1 tr=0 ts=6ae2f9e1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=ls1hVQvxTW4bqZ7aOB4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01

From: Naveen Mamindlapalli <naveenm@marvell.com>

During a CGX/RPM link mode change while traffic is running, the link
state is disabled and the TX link credits go negative. Once the link is
active again the credits are not restored, which leads to a TX hang.

Set TL1 SW_XOFF before the link mode change and poll until the TX link
credits return to their original value. Clear TL1 SW_XOFF after the
change, including when it fails, so that a failed request does not leave
the link stopped. A timeout in the credit poll is only reported with a
warning, and the link mode change still proceeds.

Fixes: 62945033ea22 ("octeontx2-af: poll for tx link credits before link mode change")
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: vmukunda <vmukunda@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  5 ++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 50 +++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 094227404ef9..7fc10d17bde9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1048,6 +1048,8 @@ int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc,
 				u32 mcast_grp_idx);
 int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
 				    u32 mcast_grp_idx, u16 mcam_index);
+int rvu_nix_tl1_xoff_wait_for_link_credits(struct rvu *rvu, u16 pcifunc);
+int rvu_nix_tl1_xoff_clear(struct rvu *rvu, u16 pcifunc);
 void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc);
 int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
 			    int blkaddr, int nixlf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 87d21889dc49..a66abea6e676 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -1235,8 +1235,13 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *rvu,
 	else
 		linkmodes = &rvu->fwdata->cgx_fw_data[cgx_idx][lmac];
 
+	rvu_nix_tl1_xoff_wait_for_link_credits(rvu, req->hdr.pcifunc);
+
 	rsp->status = cgx_set_link_mode(cgxd, req->args, linkmodes,
 					cgx_idx, lmac);
+
+	rvu_nix_tl1_xoff_clear(rvu, req->hdr.pcifunc);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 68cf730a8372..ec51a3911da6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -6749,3 +6749,53 @@ void rvu_block_bcast_xon(struct rvu *rvu, int blkaddr)
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(0));
 	rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(0), cfg);
 }
+
+int rvu_nix_tl1_xoff_wait_for_link_credits(struct rvu *rvu, u16 pcifunc)
+{
+	int link, blkaddr, count = 1000;
+	u64 tx_credits, regval;
+	struct nix_hw *nix_hw;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	if (blkaddr < 0)
+		return NIX_AF_ERR_AF_LF_INVALID;
+
+	nix_hw = get_nix_hw(rvu->hw, blkaddr);
+	if (!nix_hw)
+		return NIX_AF_ERR_INVALID_NIXBLK;
+
+	/* set TL1 sw_xoff */
+	link = nix_get_tx_link(rvu, pcifunc);
+	rvu_write64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(link), 1);
+
+	/* wait for link credits to return */
+	tx_credits = nix_hw->tx_credits[link];
+	while (1) {
+		regval = rvu_read64(rvu, blkaddr,
+				    NIX_AF_TX_LINKX_NORM_CREDIT(link));
+		if (((regval >> 12) & 0xFFFFF) == tx_credits)
+			break;
+		count--;
+		if (!count) {
+			dev_info(rvu->dev, "TX link(%d) credit poll timeout, expected=%lld credits=%lld\n",
+				 link, tx_credits, ((regval >> 12) & 0xFFFFF));
+			return -ETIMEDOUT;
+		}
+		cpu_relax();
+		udelay(1);
+	}
+	return 0;
+}
+
+int rvu_nix_tl1_xoff_clear(struct rvu *rvu, u16 pcifunc)
+{
+	int blkaddr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	if (blkaddr < 0)
+		return NIX_AF_ERR_AF_LF_INVALID;
+
+	nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1,
+			  nix_get_tx_link(rvu, pcifunc));
+	return 0;
+}
-- 
2.25.1

