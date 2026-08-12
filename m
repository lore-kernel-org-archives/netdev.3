Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AD439908;
	Wed, 12 Aug 2026 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535581; cv=none; b=IPqukvLNMRw/KATanW3r94HdTVkp4LHmUlfrkSomYs1wqOzXaLa07z+DoLh+tUo0NPX7Jzx1upgdfW+9/zSt9a5L7rkRmVZxwaVKT/CHYAWFaAPlY7gxNUjQBP5iNYFg0GR2fRYjjkiNNxeYXeRx/wI0kWtzZcqZRLlfrxp51TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535581; c=relaxed/simple;
	bh=Ik49andZcrO9inhTscTBN+qu9SMHBhuO1XGBf3sW9bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqnptDt8OUBpHdBMWgnt9n+8CFDbloy8d3txCBNHhks6nL90iV9ecxuAPnVDnWat4H1WLw3dXySBZU5c6UYY+M7EGmkCjumiVsc8Owwyb7r68ne7VcD0Lvkjixvam9SdZwIZatPGH5wMMDovqoa5yAA0LUJX1/m1mLeu3m8dCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BBGl9qfS; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BBGl9qfS"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BLbMOv3328932;
	Wed, 12 Aug 2026 11:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=HVaoLMEjMXBjuXQOXqBJYK6T4MvwX
	CwRroL0ETVgX44=; b=BBGl9qfSfZikTp6zuoSeUHP6FdkNguTFOM/wX+Ja+aPgm
	cMYYxXYS/Ggp4jU+0ftN0jy/Erusjo3NIF3npCN9jbcfAVSnAp2faIDGLorTomuI
	aNSgr6YQco3fqmFanJJr/E2EObCuM8o/iQKZIXx8ezNLriXZS0ZtqQRNEsR3rGJi
	77SnVYL2F3RvydYE5x9jU5XwE92iQOaEgYxq68J2U8V0tt0zM6Y31bCSQwZUbB1z
	MjplL8wGGc7wkJr4XlFMHhkmBttrMeQLEVZHkgcFfX/+zarvh6ENnd7wmvZJVdbv
	9HRxrVPnvBsaNDksZg3bzYfuX/CcKxXQJi97nAN9A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvfxxk1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:52:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBoCn4002334;
	Wed, 12 Aug 2026 11:52:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwegc4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:52:49 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67CBqmOh012137;
	Wed, 12 Aug 2026 11:52:48 GMT
Received: from aakhoje-nft-test1.osdevelopmeniad.oraclevcn.com (aakhoje-nft-test1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.248.219])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fwtwegc49-1;
	Wed, 12 Aug 2026 11:52:48 +0000 (GMT)
From: Anand Khoje <anand.a.khoje@oracle.com>
To: Shannon Nelson <snelson@pensando.io>, drivers@pensando.io,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Joe Dobosenski <joseph.dobosenski@oracle.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: anand.a.khoje@oracle.com
Subject: [PATCH net-next] net/ionic: avoid OOB TX partner lookup for hwstamp RXQ
Date: Wed, 12 Aug 2026 11:52:47 +0000
Message-ID: <20260812115247.308464-1-anand.a.khoje@oracle.com>
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
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608120096
X-Proofpoint-GUID: T-c0wmiDKoGqK1GnOL2J3RIJW68H2jui
X-Authority-Analysis: v=2.4 cv=K/sS2SWI c=1 sm=1 tr=0 ts=6a7c5e92 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=vHwtaBK_cnxrrt37sGYA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: T-c0wmiDKoGqK1GnOL2J3RIJW68H2jui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5NiBTYWx0ZWRfX4H18dWVcCIG9
 T+WSwbv1YnySa9z4UvNm+/jgi9NBfXKI5kI7adK3tU2py4CxuEpHua1djm1ojdFn7JfZGv3ijKr
 D9IYVDQsxXP7OorD81hwXS4f0zue/T7RFuLTs+zXuyWrYcFPKcCPwrpMEJZWdlmwKGh7YQ9Q1Lq
 GpxRb1AlGjGEU85GYzWDTqW3aqsrMTtm96+wukIN1Zwsi6WU9oawCt2IFMTTylWcbGBlrkfunIc
 zd/2XngUhBBINRzqGv+VFIcpquFWXMpmztTF3YlgEozwNB55+9a4H1j5WkTSGYBqRTxvjeMAxfg
 F5oD7zCwE5rnBbK1KeLo2q3PPm4Chv51/BeYheBpl+QtsA4L17cE8zGMzntrjdcypcXXo8+AG4A
 swLFeAH25/CM9jMzU9K0hTNS26q3noNM/oC8xOQQCXYkf4bzOnz1o+GW8ASVjGkN+Yx8RZSAdXO
 JOSoUoLoeUnkBjcMl/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5NiBTYWx0ZWRfX/Lk+gSB8l8sj
 Y+ZGKnOT/SzhVCrQkphfMekYdthLh4dQFmV7ed/SvWjtkQIQQFUe+roiPP1ryBpfMY+wGEFwdOU
 8PXV1MtLlAErMJpUMghurThYDIExDjw5achpLrDj0ZF4zIpiLYrT

The dedicated hardware timestamp RX queue is allocated with q->index
equal to lif->ionic->nrxqs_per_lif. The normal txqcqs array only
contains the regular queue pairs, so using that index to set rxq->partner
can read one entry past txqcqs[] and then write through the derived
pointer.
Only link RX/TX partners for normal queue-pair indexes. Leave the hwstamp
RX queue unpaired, and make the XDP_TX path abort cleanly if an RX queue
has no TX partner.

Fixes: e1615dda41144 ("net/ethernet/pensando: Add out-of-tree network drivers")
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c  | 14 ++++++++++++++
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index fd3ee9820531..1822361e1070 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -920,9 +920,23 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	};
 	int err;
 
+	q->partner = NULL;
+
+	/* Only normal RX queues have matching TX queue partners,
+	 * skip partner pairing for hwstamp RX queue.
+	 */
+	if (q->index >= lif->nxqs)
+		goto skip_partner;
+
+	if (WARN_ON_ONCE(!lif->txqcqs ||
+	    q->index >= lif->ionic->ntxqs_per_lif ||
+	    !lif->txqcqs[q->index]))
+		return -EINVAL;
+
 	q->partner = &lif->txqcqs[q->index]->q;
 	q->partner->partner = q;
 
+skip_partner:
 	if (!lif->xdp_prog ||
 	    (lif->xdp_prog->aux && lif->xdp_prog->aux->xdp_has_frags))
 		ctx.cmd.q_init.flags |= cpu_to_le16(IONIC_QINIT_F_SG);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 301ebee2fdc5..73998d61593a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -545,13 +545,18 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		break;
 
 	case XDP_TX:
+		txq = rxq->partner;
+		if (unlikely(!txq)) {
+			err = -EIO;
+			break;
+		}
+
 		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
 		if (!xdpf) {
 			err = -ENOSPC;
 			break;
 		}
 
-		txq = rxq->partner;
 		nq = netdev_get_tx_queue(netdev, txq->index);
 		__netif_tx_lock(nq, smp_processor_id());
 		txq_trans_cond_update(nq);
-- 
2.52.0

