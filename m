Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E0366562
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790992673; cv=none; b=dSkhVPtcvmPOGnnviGcvNKO9yhz8d8i2HF8mPlH1E/QkMDNYCD25d6iIyaJDSTDDkRYqKWp0akclJ5G2hRwEvoaogz7T5ardrRWL+xlhM4qcj0VawswaqKUgj6n1tWHz/fyNzcI3lU0xTUe2lqZOFja/NL+5sj39GvkD08KyTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790992673; c=relaxed/simple;
	bh=IAk59FDkgE6V0xd32E3w6bUigNYYOsdXelslvnhKKUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/Ov1yOtL+MfRKif3NNoKCm5gygQinQYeb8b27uS6pih/Ys8fbdKd8SjB0JwiRol+qGfqLjjc/sVxfaZXV6ixnZg+m7JwRwzFHovLmwl6Eq50kIbooDgPs8o68mfvfkxqmgMIkKYnmi6Vecapnl4UqW8jMV0eY3JJwQLCkjbALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QHHaJWvz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QHHaJWvz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693079NG1899220;
	Sat, 3 Oct 2026 01:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GPMp2H8ZDsAXte6hj
	WHGBoERRDY1KGqgBi4/rHPKQ7I=; b=QHHaJWvzYEcbPEsU4Nkou9Z/mZMAie6MI
	ztQZ4FkPEYwDmjNgIIpYx/EQx5xxNE8ZBoA6LbwpgyeuoGNY18tnkFW9g6CCK85p
	KNFNNtp206VTfXGyXt6XXTrv3jDu0gd/S5vJRxVhKcS60bNZXBFc6t8oU8b8OnUi
	F9vdbS5u0OtefPcg7b3vbDpDey2OYahZw7Tnj1cQRZ6OdEtClBKGlOqq/UFQu/fq
	MGFWUJCPaA1XSNftUFiXmA93ygHqLrK7Z7eAmwcdCU/eRdWGhvZCFIey8co+lpJq
	UVp1nudMeCOy8dME1ucSRZlSyjYcEmwg4vMW18olhIcuYe3BQwcqA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5vef2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692NlroG1988532;
	Sat, 3 Oct 2026 01:57:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h2kfm8vup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6931vWba25887338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Oct 2026 01:57:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46B3D58055;
	Sat,  3 Oct 2026 01:57:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 105DF5804B;
	Sat,  3 Oct 2026 01:57:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.102.94])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  3 Oct 2026 01:57:29 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next 1/7] ibmveth: fix netpoll races with RX replenish
Date: Fri,  2 Oct 2026 18:57:13 -0700
Message-Id: <4efd18b3b511d47d0a0bacafa77ce3e007d2584f.1790991039.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790991039.git.mmc@linux.ibm.com>
References: <cover.1790991039.git.mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX6lkR8ZftZyOs
 dcqMKweS6tHuYOsmJ2rErAifEtff3qH7TY3iahjbZhMb+Rk7JnESLm8RNf6l5R8oV/0U7zIUg4E
 FvkOCtkfPGndRh2HPNFeNaIHXyAMIuE=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6ac0610f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=cwuRzhAPRJiUn7T7YroA:9
X-Proofpoint-GUID: Hb5eOzAGqp0FmG0CqjefUF0RKF9haxEl
X-Proofpoint-ORIG-GUID: Z8fDKquMtiuzC57Zum9vcTqpyvfHtIe8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX9TDumu4Q3yGJ
 b7ZQXJxdfFZNGH6TekLTmhsHqu7dfMdARqABOl46C0KYI4FNWdjfpoxNGdqDo62yjAm1HAZO41v
 Cq7KakZ9jiB3iHFF0JKyxNfAm3l/GLPBSGMhlZkeUYbXSpLKs06KpLjI1mbNkkEPDCZ4h1ec0Fv
 kXIN1vM0yM6jhs4O/Hrju9FlVaV92tlo5e1AagZtY7brXYbZx7SxZPHYSaoFB1McMC83p3IVb2N
 QQTIc0MfmhO9BWNiz5/eNmu6zr4kwwL50rzt/GQHp1kkMWqE0bbEZX/cgTORSSzO/P5njcPXacp
 QLGKAtp2EjI9nvAops2XzP7nWU2l/+jioRRWaO5bMTnF/OpQPXR6GXePEWH+SX6RsRuAtsu3VA+
 DpgerfOo/Vp5naJ01bOvuVIrW0sajNzw8sBrQ8rxeWxDGUgJjf1R45JSDMXeYZS9y4x9vxaZ1Ka
 E+q5D4V4Uvj4JwKvQ8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030005

ibmveth_poll_controller() runs RX replenish outside NAPI and without
a lock, racing NAPI's replenish on another CPU. Both can fill the
same slot, so an skb and its DMA mapping leak and PHYP can write
into an unmapped buffer. netpoll calls it from netconsole and from
netpoll-enabled bonds.

ibmveth_open() also enables NAPI before the RX resources exist.
ibmveth_change_mtu(), veth_pool_store(), ibmveth_set_csum_offload()
and ibmveth_set_tso() call close() and open() directly, so while
open() is still setting up, netpoll and the direct ibmveth_interrupt()
calls can replenish NULL pools and read freed memory.

Remove the callback, as Eric Dumazet did for many drivers after
commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional"),
including ibmvnic in commit 0c3b9d1b37df ("ibmvnic: remove
ndo_poll_controller"). netpoll then polls NAPI itself with budget 0,
serialized with NAPI by napi->poll_owner. ibmveth_poll() handles
budget 0 and TX completes synchronously, so nothing else is needed.

Enable NAPI just before request_irq(), once everything
ibmveth_poll() touches exists.

Neither race was reproduced. Tested on a POWER10 LPAR with netconsole
over ibmveth: a ping flood (678,470 packets, no loss) during a printk
flood, and MTU changes and buffer pool toggles under traffic, with no
warnings.

Fixes: 6b4223748895 ("[PATCH] ibmveth: Add netpoll function")
Fixes: bea3348eef27 ("[NET]: Make NAPI polling independent of struct net_device objects.")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 73e051d26b9d..aa2300e97081 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -623,8 +623,6 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netdev_dbg(netdev, "open starting\n");
 
-	napi_enable(&adapter->napi);
-
 	for(i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[i].size;
 
@@ -712,10 +710,18 @@ static int ibmveth_open(struct net_device *netdev)
 		}
 	}
 
+	/* NAPI can run as soon as it is enabled, from netpoll during the
+	 * direct close()/open() pairs or from a direct ibmveth_interrupt()
+	 * call, so enable it only once everything ibmveth_poll() touches
+	 * exists.
+	 */
+	napi_enable(&adapter->napi);
+
 	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
 	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
 			 netdev);
 	if (rc != 0) {
+		napi_disable(&adapter->napi);
 		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
 			   netdev->irq, rc);
 		do {
@@ -763,7 +769,6 @@ static int ibmveth_open(struct net_device *netdev)
 out_free_buffer_list:
 	free_page((unsigned long)adapter->buffer_list_addr);
 out:
-	napi_disable(&adapter->napi);
 	return rc;
 }
 
@@ -1680,14 +1685,6 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 	return -EINVAL;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-static void ibmveth_poll_controller(struct net_device *dev)
-{
-	ibmveth_replenish_task(netdev_priv(dev));
-	ibmveth_interrupt(dev->irq, dev);
-}
-#endif
-
 /**
  * ibmveth_get_desired_dma - Calculate IO memory desired by the driver
  *
@@ -1789,9 +1786,6 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
 	.ndo_features_check	= ibmveth_features_check,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= ibmveth_poll_controller,
-#endif
 };
 
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
-- 
2.39.3 (Apple Git-146)

