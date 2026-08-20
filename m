Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548B3845BD;
	Thu, 20 Aug 2026 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787204243; cv=none; b=Iq6BIj0UF1EJI0QLFDvPiSZ0T0TvDpQT2HFNT1nNoLmg+iHxZ2oOv7HP/BLKhyqTfrlRcYNuD/dvX4bKiBwArzEeewgysOmnHGWJoA1j2o7jnVB8jQFfsL2tT7+I0B0IWD5yBeyKdICp4cAWAmYqZ0n8sOrWJ+sNG3uhlE9GyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787204243; c=relaxed/simple;
	bh=+05T+9TAkT4dQLwj6syIbjr1L6OwhWJuuziXCBR9G68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g51tud6VMfu3HmyOKp+gBnc6XIqwDSbkrSWC1HY7bgDkCsEu7CsDZ7KruXmradrIncqjBRF6syERdR6hRbtxKa7UoDXgZt/gTZkC2NrG6cxqJ4Y4CXHU5STZIEaR+pF/0FmC4Ra7vCtVmyXpqr6It3DUEUP89BnAlfuiT3EP828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jio2bV8+; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jio2bV8+"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JM8JDj211686;
	Wed, 19 Aug 2026 22:37:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=D0eQUSULQFdT9Mb3ScHJtMc
	Rd28bW6XJ3zo4k0oClo0=; b=jio2bV8+dhndW3RBMB8muimAeSdKSm+Tjz4Fjsb
	lwUdQgOa/FamK59/OobZBb73H2P1X+u87j018pqyXeF1zIdgcD3NAgbT72dYFIDS
	qiQnyYMCEgnYJ6orKrPgw3hn1m4T5AonvNbkxJGNH+bkbC5xzYcchuDFY74tIX4L
	HWVU35BLzEyVHLMR2NgkhZEsFIqa0COPN+Qjrs04szMpo0zYy74/DVpXPQffZoQ9
	FRulHMVSAZ6n6nH/6iHLsTe/6oDdQS0etgUDOLLfz6VFGIU6YGKoVAoNrzOYX+tV
	4rYr3POl8PbndCDITDrmNo6SwNcF3Pca4d58K4zfcDHG6Ug==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g5bbav4sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 22:37:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 19 Aug 2026 22:37:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 19 Aug 2026 22:37:13 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 94EC93F703F;
	Wed, 19 Aug 2026 22:37:09 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <saikrishnag@marvell.com>,
        <sbhatta@marvell.com>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: fix ng_rvu leak on repeated mailbox init
Date: Thu, 20 Aug 2026 11:06:56 +0530
Message-ID: <20260820053656.2614614-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzOCBTYWx0ZWRfXwR6/TGrHOp/Y
 aqYUxHiuIMPChqOWNWPAhKKOQB9B/enPC8js+IkatTlhcaV7q8XWToeS72Puxw5Jc84UdvWv37p
 3FexZlLPH8RpgsLEMgbT+x1X92f+M/i0Y8j7aTGtzvWzK7md64Se4vDSfoChRWwOGalohHzA+lq
 mfqpSNZ0MBaWiN88QvItWpLZy6fKlN7Y1y12RTgV+M0TLpqUP7iWiGzhEfJdWd93cV5TarioH5j
 JfQeHMjQ3aHnw6kiM7UWtZ8jaOuN49bWipQc5t7emwivMl23R2YPG40wiHBISuEhl7mQSZxnxZ/
 QsZbLJvHhlnN/R2gk9POiBu6FQDA5BwuvpvCIv6i9I3hgQLlv19a2Pltgg21eBFRCONg/1DU+k7
 fBy56J3QnFXU5wHmof69tngvzPY9MJxQY8vq9B9CgcZI8LZGH01pmivro9C/LvLzMQJcswn7Tx2
 x4UQQY4TnlgmwwmlTFg==
X-Proofpoint-GUID: nnGLZS0TEnWssorlWggt9zn3GRWKT6my
X-Proofpoint-ORIG-GUID: nnGLZS0TEnWssorlWggt9zn3GRWKT6my
X-Authority-Analysis: v=2.4 cv=COYamxrD c=1 sm=1 tr=0 ts=6a869289 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=JGRO9RXDlLQxvhZsI8MA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzOCBTYWx0ZWRfX0l7GHfz+FB5b
 jeobKIWSoVcdbx5G1RhfnDUCjNAOYjloxzs6rBzQUsJff5TLqlUZTdIkZ0vEI0W/gLR2lxxWIxQ
 t2JkBlsAEbB0eqhgZNpLjFFGVUcliHM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01

From: Sai Krishna <saikrishnag@marvell.com>

rvu_mbox_init() allocates an ng_rvu object on every call and assigns
it to rvu->ng_rvu. The function is invoked separately for AF-PF
mailboxes during probe and for AF-VF mailboxes when SR-IOV is enabled,
so the first allocation is leaked when the second call overwrites the
pointer.

Allocate ng_rvu only once and reuse it across subsequent mailbox init
paths.

Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.c    | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ffba56ee8a60..5cef4903179a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2585,12 +2585,6 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	if (!pf_bmap)
 		return -ENOMEM;
 
-	ng_rvu_mbox = kzalloc_obj(*ng_rvu_mbox);
-	if (!ng_rvu_mbox) {
-		err = -ENOMEM;
-		goto free_bitmap;
-	}
-
 	/* RVU VFs */
 	if (type == TYPE_AFVF)
 		bitmap_set(pf_bmap, 0, num);
@@ -2604,9 +2598,17 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		}
 	}
 
-	rvu->ng_rvu = ng_rvu_mbox;
+	if (!rvu->ng_rvu) {
+		ng_rvu_mbox = kzalloc_obj(*ng_rvu_mbox);
+		if (!ng_rvu_mbox) {
+			err = -ENOMEM;
+			goto free_bitmap;
+		}
+
+		rvu->ng_rvu = ng_rvu_mbox;
 
-	rvu->ng_rvu->rvu_mbox_ops = &rvu_mbox_ops;
+		rvu->ng_rvu->rvu_mbox_ops = &rvu_mbox_ops;
+	}
 
 	err = cn20k_rvu_mbox_init(rvu, type, num);
 	if (err)
-- 
2.43.0

