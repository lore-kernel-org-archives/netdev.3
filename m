Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C373D669A;
	Tue, 30 Jun 2026 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787668; cv=none; b=jEvydETpE5zefYmc/CtkMn3nsLUn2Rj/Uiq5y3XF9KJGgISuG9zwpv1zlLF++VR0mQ2fHCRAYxEOmNzrv5xMopi5Z+KMTeb5n8JeZB7KpUzN2iDARxhftN6pKn6+n7JWhOGOVPEU/pRKzdoeaIlEE4Zz8jxkspP1/v9OqL8+9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787668; c=relaxed/simple;
	bh=+IMoTre7CWjOa5NuhAn0WU0Wa9KaQYCC5/wSYeXX0rU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MB4aeKbCDFgKaFJ9NGCNm+iTHRaPhlRj/aMFbsP7sjdTdlhi47PNO625f5H2kCZw/WbGuTiOvgmKh0u/e7FEcUF7Spbz+2+7nDZfD/jXMvOjZnovHFSljAWyXHKmf9gzBmhtPdeEx2tLUgoWcMTveRxPWmcxN+epbg1YY/dFZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Zn8r1IZu; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Zn8r1IZu"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U1IQaT3489322;
	Mon, 29 Jun 2026 19:47:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
	HFsZYLom6HK998b8B4XcdA3GPa5EaDnRe5Y6jLY8RM=; b=Zn8r1IZue5zPgXswZ
	hfHiMUin0VoN4mR5DBrXMCd0HfyikF6i2hMmDSQPCiQfbqJ9DAR7voSFB36W14Ds
	dSr80UzPuuOCr/JoWS4xTlIjNy7Q/jUIw9FUOSNjz4KB05AR/rpunRDUkxUa6kUp
	hofC9h7ZE5joqOE+fUqc60LT9lwxB5pYSchepIIV9HWFwB4C1X0UlpKjiGg7ZAPD
	2ZFDyqHZOyGWFOXtvKqEgo7otP2yrevoNpVlzi7IJ/3JoqmJ/EV9kr4RoBhzShCr
	zv9zlGRgV61US18BgvgSjS0keixyzNIkOChAMzMj1o0QswYIcA9yfoT9O1Rdv//7
	J6IkA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f2e1h7ypc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 19:47:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 19:47:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 19:47:38 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 010BC3F704E;
	Mon, 29 Jun 2026 19:47:35 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next 4/9] octeontx2-af: switch: Representor for switch port
Date: Tue, 30 Jun 2026 08:17:10 +0530
Message-ID: <20260630024715.4124281-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630024715.4124281-1-rkannoth@marvell.com>
References: <20260630024715.4124281-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9hPIX3pKC5p11b5rBbOQ0nyD-aZyVOkK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAyNCBTYWx0ZWRfXzVYSUWDo/cD2
 34a2h/gyOSN2Iw8euxZAuQ6cunx0PdcoS+JFG/kFPNKYbGbaHQPhLy6n4xJ9I7I8gQ/sMHG9QDy
 qJZB0jFI89FIlhI5P2HR2JoxyZQmu8c=
X-Authority-Analysis: v=2.4 cv=e802j6p/ c=1 sm=1 tr=0 ts=6a432e4b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=DoYLhwvCB9hUwP6ZXpoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 9hPIX3pKC5p11b5rBbOQ0nyD-aZyVOkK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAyNCBTYWx0ZWRfX4bu7hhgk7XzR
 LD5hJJ4B9mPblb1cdvJ7zLQ1/hsX3mn+hC7iTz6I/nhiviw5rVs6mFk/8Ma40HAH4PrMXpQYNuC
 mV0ZfaQ0PdL+abOKngR1H8a2qSu6pN29g86ASciz58mP+8P8PtrAPCS+G1Ph7Hq60qGgfd/485C
 3Lvpux5syXj2WTwlYZmKB57QtrqbmXxEs0ZyPM41YcoYySToTOwuCWmud+X1MBL7QczOWlfn4y8
 dgud+LDiOrPzZIe2wiUapoaRLgv+1hWpH2s26cX7cSq4kGnQiA7SkJxlMJMwRh+szLIIQl0PQqC
 6VnbszzOmLj86Bec8pzEX1ynh/IHyZVp9SiJ9zmazfs+qhO1pDWf4uwPeG8pfwJC/i+7EgGKwFa
 W+ASTKPdjAQHdXzML8aUUnCZbkc7ADMNGz3EiSM5WnZtUfCp2LKSxjYPPDLconUyeD1wpne0xcy
 ea5I5X0/zfJio5EtEdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01

Extends esw_cfg with a devlink-derived switch id, copies it into
rvu->rswitch on the AF, adds rvu_sw_port_id(), exports
rvu_rep_get_vlan_id().

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h   |  5 +++++
 .../net/ethernet/marvell/octeontx2/af/rvu_rep.c   |  3 ++-
 .../ethernet/marvell/octeontx2/af/switch/rvu_sw.c | 15 +++++++++++++++
 .../ethernet/marvell/octeontx2/af/switch/rvu_sw.h |  3 +++
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c  |  4 ++++
 6 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index eaea22a9cee8..1a6dcb6ff135 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1832,6 +1832,7 @@ struct get_rep_cnt_rsp {
 struct esw_cfg_req {
 	struct mbox_msghdr hdr;
 	u8 ena;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
 	u64 rsvd;
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 21803e257cae..3e34d56a5bd3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -576,6 +576,10 @@ struct rvu_switch {
 	u16 *entry2pcifunc;
 	u16 mode;
 	u16 start_entry;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
+#define RVU_SWITCH_FLAG_FW_READY BIT_ULL(0)
+	u64 flags;
+	u16 pcifunc;
 };
 
 struct rep_evtq_ent {
@@ -1197,4 +1201,5 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu);
 void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable);
 int npc_mcam_verify_entry(struct npc_mcam *mcam, u16 pcifunc, int entry);
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc);
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index a2781e0f504e..6bb6064b2391 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -189,7 +189,7 @@ int rvu_mbox_handler_nix_lf_stats(struct rvu *rvu,
 	return 0;
 }
 
-static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
 {
 	int id;
 
@@ -436,6 +436,7 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 		return 0;
 
 	rvu->rep_mode = req->ena;
+	memcpy(rvu->rswitch.switch_id, req->switch_id, MAX_PHYS_ITEM_ID_LEN);
 
 	if (!rvu->rep_mode)
 		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index fe143ad3f944..28f8281e9219 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -5,7 +5,22 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
+
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
+{
+	u32 port_id;
+	u16 rep_id;
+
+	rep_id  = rvu_rep_get_vlan_id(rvu, pcifunc);
+
+	port_id = FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
+		  FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
+
+	return port_id;
+}
 
 int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 				     struct swdev2af_notify_req *req,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
index f28dba556d80..847a8da60d0a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
@@ -8,4 +8,7 @@
 #ifndef RVU_SWITCH_H
 #define RVU_SWITCH_H
 
+/* RVU Switch */
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc);
+
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 0f5d5642d3f7..257a2ae6a53e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -399,8 +399,11 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 
 static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 {
+	struct devlink_port_attrs attrs = {};
 	struct esw_cfg_req *req;
 
+	rvu_rep_devlink_set_switch_id(priv, &attrs.switch_id);
+
 	mutex_lock(&priv->mbox.lock);
 	req = otx2_mbox_alloc_msg_esw_cfg(&priv->mbox);
 	if (!req) {
@@ -408,6 +411,7 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 		return -ENOMEM;
 	}
 	req->ena = ena;
+	memcpy(req->switch_id, attrs.switch_id.id, attrs.switch_id.id_len);
 	otx2_sync_mbox_msg(&priv->mbox);
 	mutex_unlock(&priv->mbox.lock);
 	return 0;
-- 
2.43.0

