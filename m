Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147C4483A1
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723332; cv=none; b=g7x8WR5LN6v7d4R/g8X+1+QSInjjItjgJd+NrmWLsTwdzUwA3oWEX9142JH5orgGhPijO4Qf60IhibiZYIsiurf2wKvxRxgkAdwt2PDSP6tNMTbGbS+mTbWMerHSTpw8BMPWIzSPbVWnuqg4GYG6IAXoj+A8TBoXLByjTUBNKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723332; c=relaxed/simple;
	bh=UhK0joTp4xoZr3RRY9XO4aT5ifDORmmWaROnHyTpmDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqR9vI50aOUDuhMB7djfXEWZQGVTr6jfYFo4TrAs8kgSy0ix1B4vDxxpNP8Frd0f4lfCS9t4UTJKwG6xi/aicQVrj/cDOxtUE5Q5fXHsAQXg0TGRS2y9tS3++t4gi2z3wohFtl6O5PoZ3XOvpEiV3vwk3paMSyR5IGHWxHYvv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CcP7gKDK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CcP7gKDK"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69BBt2QI3412570;
	Sun, 11 Oct 2026 12:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=upVqDL3who/0Wv2oPzbEwRG5SaVap
	2prEYcrpv9n0oU=; b=CcP7gKDKW2KT7d4xPncmAEZMmvdL6cyhYzJ3zjdoBojdW
	BCwtQYazbMeifTkRDpqcyqJCi6RHAoG9lgO1RIVH8cw3YdYoFIbK4Cw9YyFt2NfT
	Vk3uL4K9k7Jy0PfqCsHoMzh/h4ofVrVhEsUT68xIxXkra1fwaD46zPG3FUHChHiI
	JWmKWQM9PFeHa0CqUsxWZxwjhHpTb2IP4Aof2GH/0exYZoE2qZ1nbJcE84WHJA6x
	wnR0ErEWdzX6V7t2qGZ/PPd6sveD+AzoeEukSqEG85WwjepgQKCNKiJKBbQfFa7X
	evP8L9VYCoINC2J04uAFXbH7ltt7HL+pVyAzD6sjA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dwt90w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Oct 2026 12:55:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69BCpf7i019575;
	Sun, 11 Oct 2026 12:55:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btm1a0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Oct 2026 12:55:12 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69BCtC9W025827;
	Sun, 11 Oct 2026 12:55:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btm1a0c-1;
	Sun, 11 Oct 2026 12:55:12 +0000 (GMT)
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sbhatta@marvell.com, gakula@marvell.com, sgoutham@marvell.com,
        rkannoth@marvell.com, skardach@marvell.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net] octeontx2-af: Fix CQ enable state tracking after AQ writes
Date: Sun, 11 Oct 2026 05:54:59 -0700
Message-ID: <20261011125508.534618-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610110051
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX0VUN/kpZoqZi
 l1s+tQCDnFTxBakPVqsdbUuXwJ5n+4yiY25c4XTIFYZz4XZpbtYWrAOulOVeAJMW/l4MGEYhM9Q
 iE0vgaQDAe62erDCHocz8Ox7KFJLtC/Hmp5+MlOBbJirtIsfC4i7hqFqp/22qLSuMbIGDjWsZ6K
 yC0Haa6JmcblliKUqEUVnykfU/hkkkyxFsSM8m9HbssaNtbGAma/uNscQb1I8gl7qPw3CwG+IUk
 RAoQpoatYHm5cT0R9eDaeIOZ8OD03afsSgmW/hSC8vLdPvpxBhGXHvCVlJ+M6J+2Xto2uVHyGv2
 Cdep8byqAsxzOI4BYewHwrJXANqbxv1RaX5JUh+UntRdFqQezgNYfz1Q92mUe3AvYcQ6NAvoEpG
 fcG9fe3zu2YlKJkEcOxpS9RHsk5zPk0MnJtlp2UYCW/LI7wMzx1c8E9WNE0gTQC+zNtNptvsUYD
 ighHVO30JKWwCgaQju4ZedUJsNQ9oTHpb8cjJtuE=
X-Authority-Analysis: v=2.4 cv=Kp7YSmWN c=1 sm=1 tr=0 ts=6acb8731 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=8n1vMWH4bYHyriNCS_YA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-ORIG-GUID: UzryNzp0bn126dzVG-BNAKwyhp4D_44c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX4PlHlBuy53Vn
 jBmsxfxUHK9WSnH5brT08fCEXNq9/05Gd6LnydgX3BHzJdIbKjZXvDgGccz9h+acG+1SgayinZL
 J3ypNLXuTXcxYSfPYH5l8PvNat8zI/09X9XB0HQgn+NPI1d+ofro
X-Proofpoint-GUID: UzryNzp0bn126dzVG-BNAKwyhp4D_44c

Use the CQ context's ena field when updating the CQ enable bitmap.
The current code reads rq.ena, which overlaps bit 0 of the CQ base address
and can leave the bitmap out of sync with the hardware context. This can
cause enabled CQs to be skipped during teardown.

Use sq.ena for the SQ bitmap update as well, so each queue type reads
its own context.

Fixes: 557dd485eaeb ("octeontx2-af: Support for disabling NIX RQ/SQ/CQ contexts")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 964bcaae098e..69c49adaaec2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1231,7 +1231,7 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 				__clear_bit(req->qidx, pfvf->rq_bmap);
 		}
 		if (req->ctype == NIX_AQ_CTYPE_SQ) {
-			ena = (req->rq.ena & req->sq_mask.ena) |
+			ena = (req->sq.ena & req->sq_mask.ena) |
 				(test_bit(req->qidx, pfvf->sq_bmap) &
 				~req->sq_mask.ena);
 			if (ena)
@@ -1240,7 +1240,7 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 				__clear_bit(req->qidx, pfvf->sq_bmap);
 		}
 		if (req->ctype == NIX_AQ_CTYPE_CQ) {
-			ena = (req->rq.ena & req->cq_mask.ena) |
+			ena = (req->cq.ena & req->cq_mask.ena) |
 				(test_bit(req->qidx, pfvf->cq_bmap) &
 				~req->cq_mask.ena);
 			if (ena)
-- 
2.52.0

