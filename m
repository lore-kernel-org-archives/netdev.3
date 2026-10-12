Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EFC1FC0;
	Mon, 12 Oct 2026 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781558; cv=none; b=KjzpG8/iKiZABYC7kPBtGBfb3EzEw/uTBGlvC0o0wEufXBtAQM1pyV/PNcXbUeddkHHyyEQq9fhUvvFlq8Gq9TCrwBn5wVMx8YCjrQEf6bXrRvj6yejVISSyYgPGeDlCADq0bd7jl4IuaFn40VEjeuOrgS3LuxJnU2btADn60XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781558; c=relaxed/simple;
	bh=CcpN2jVpWgdnS45uMZ9+22fUnYvql/KcQKhvC/kNH84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R1OgvqlQDX7m3QvsBN6iJ87yuhoCr+9h8yqq8iI0YLD+OOIezB+z80zcyJAnHTpvndHpsBgKwkvW9juzNvX35J9S9a8C/ozA+PlHySYrG0gcvZfwlc++5/SQl/tbOGHOSPgXMzFfj4R22ssyrrUU49ND6bqk/EaTDxhid2dYQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VW9WT0i5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VW9WT0i5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2Eebl3156732;
	Mon, 12 Oct 2026 05:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3EBvXPumlT2fyXtoN
	fIDmN3jzRtNvFFz6Mp5uSriNhE=; b=VW9WT0i566J/qX0WcvMBUuartUdLh+B81
	2wzdMl+PGJQybszYb+N3MEUVE/k0MWCs3LnV+Tk6V14fKiPNmAiFeEG/OM0TaZ1r
	BQlKvhYkr3o1GCPnvyb0UKO4+wDHQ+/IeECfnoWajytx9naLAz96QURUso7IK3ge
	fbrPH/5sEA7+2i5zSJbvUfqJDM/tw+R5DPASv+aHm8umSN+AZ3yEh5pojlUk2sz6
	A/R/pcCpUXu/GvbxGBDKqenmHzNu0HYl2ILk2OcQC376VRSjwzKXGizxEwl2YOtA
	Hx4LMvWjbfCkQwSYBMJzsbj3mQGyFRe3Znz3swR567r2y58IuyAoQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug78t4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C552AI3726512;
	Mon, 12 Oct 2026 05:05:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfukn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C55TTk29360662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 05:05:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3295358124;
	Mon, 12 Oct 2026 05:05:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C848A58121;
	Mon, 12 Oct 2026 05:05:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.163.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 05:05:25 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, santil@us.ibm.com, jeff@garzik.org,
        stephen@networkplumber.org
Subject: [PATCH net-next v4 1/9] ibmveth: fix netpoll races with RX replenish
Date: Sun, 11 Oct 2026 22:05:10 -0700
Message-Id: <20261012050518.88858-2-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261012050518.88858-1-mmc@linux.ibm.com>
References: <20261012050518.88858-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acc6a9c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=qzTZ72RhqM2DaLNR-rAA:9
X-Proofpoint-GUID: gL6pnpBSXza2ieIwZpJfQQig8FMcvxPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX/ST37LpRtbZQ
 56ssnw4NXqvMu8d6NbHH0XSHuXCyiBkiWsilDVTTAzVN0dzW3XWDwBOmD10YSxGzsCiKCub4Rvq
 E5BKQC6fKRZlXITOhBLEDwo5RLKYQpaqteCRqXV/gyaMCJMcoBdZ4DYlSTdQsRT2Ef8yQz0uoDD
 Jgooj6P3ZXKkEryWFRCttPFn3vzdu/6fKNp0YW21SmmwKLz6smdy3X6qNv5Rn8mww5ORVAfzosA
 hTf69hxKzTS3t8LyfVUPLtL3j/bGbNDzmjJtiWzLVZIkFqmOMPoxN+HepB9C/iLbNHGJ3Msu9Zm
 4LO1bLpBJaTNVF0QQiBHncYPzItSnUIEtInQCShcLUXO2jjj0058d06aQjdBsndGm4/dG9MWVE5
 vWTebizVI3uoM9h34auocMqwzAE131AECgK9o5HgRSXfTyrGyMfdgCOJLV6A1QDAtMvQPOP27/J
 8/XUo2JIbfbdDNwxwaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfXw7pq1gspcVw5
 hzZd7D8ZpR6Kcwhud+K1vOh3X2Og8qxK/dfCAJNH8Jq2IioZ+P60jENvgHtImhBNZ4f9AjoNKfQ
 LYLLlbb4qtDL2OZgc05KpiB2XzwmDdQ=
X-Proofpoint-ORIG-GUID: DthJQrb7-sSjZKIvxVxkxj-KO9atBiL4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120018

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
ndo_poll_controller"). netpoll then polls NAPI itself with budget 0.
napi->poll_owner serializes that with NAPI, but not with a NAPI poll
that was already running when netpoll was set up, so skip RX
replenish at budget 0, which netpoll uses for TX only. TX completes
synchronously, so ibmveth_poll() has nothing else to do for netpoll.

Enable NAPI just before request_irq(), once everything
ibmveth_poll() touches exists.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection of poll_one_napi() and the direct
close()/open() callers; neither race was reproduced. Tested on a POWER10
LPAR with netconsole over ibmveth: a ping flood (678,470 packets, no
loss) during a printk flood, and MTU changes and buffer pool toggles
under traffic, with no warnings. No kernel selftests cover ibmveth.

Fixes: 6b4223748895 ("[PATCH] ibmveth: Add netpoll function")
Fixes: bea3348eef27 ("[NET]: Make NAPI polling independent of struct net_device objects.")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v2:
- skip RX replenish when ibmveth_poll() runs with budget 0:
  napi->poll_owner does not serialize netpoll with a NAPI poll
  that was already running when netpoll was set up

 drivers/net/ethernet/ibm/ibmveth.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index abebdb1fc262..4a5869183be6 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -628,8 +628,6 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netdev_dbg(netdev, "open starting\n");
 
-	napi_enable(&adapter->napi);
-
 	for(i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		rxq_entries += adapter->rx_buff_pool[i].size;
 
@@ -717,10 +715,18 @@ static int ibmveth_open(struct net_device *netdev)
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
 		goto out_free_buffer_pools;
@@ -765,7 +771,6 @@ static int ibmveth_open(struct net_device *netdev)
 out_free_buffer_list:
 	free_page((unsigned long)adapter->buffer_list_addr);
 out:
-	napi_disable(&adapter->napi);
 	return rc;
 }
 
@@ -1542,7 +1547,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	ibmveth_replenish_task(adapter);
+	/* netpoll polls with budget 0 for TX only, and is not serialized
+	 * with a NAPI poll that was already running when it was set up
+	 */
+	if (budget)
+		ibmveth_replenish_task(adapter);
 
 	if (frames_processed == budget)
 		goto out;
@@ -1682,14 +1691,6 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
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
@@ -1791,9 +1792,6 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
 	.ndo_features_check	= ibmveth_features_check,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= ibmveth_poll_controller,
-#endif
 };
 
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
-- 
2.50.1 (Apple Git-155)

