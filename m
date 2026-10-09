Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534F5226B1;
	Fri,  9 Oct 2026 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570826; cv=none; b=tQexSZknC+UzN3k5UZcr0nHu8/BHEkc6ba5Gj01+hAVbi1RpGotL4AXG/bfWvCPMGxQVVAbJYhwizbP3Td4ifbxbrCZ/cESJd7Q6jOKFgxCHCI7Zl6bhEgIRWMjsrMCyBTrF+ra72Pzm3/ECmWdIoV6jvxzpxJqy83ssRLvdpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570826; c=relaxed/simple;
	bh=CcpN2jVpWgdnS45uMZ9+22fUnYvql/KcQKhvC/kNH84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ftq+VwcmmdOUO5t27U+Kh6fmGbPOpk16w2un9PrmQqNFXL6VWvvVtV5I+Pp9y7E08r833kUdIKIgtlDkbmVlXICjbmsllHMBVYAwdEMsiTstoESXIMAAWl0BdlcpYCjbe6oogEtGt/ARakGREbkv7S+a7XmWPKodSFAlyxJkYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qHr3XAwI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qHr3XAwI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699HaFGx737194;
	Fri, 9 Oct 2026 18:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3EBvXPumlT2fyXtoN
	fIDmN3jzRtNvFFz6Mp5uSriNhE=; b=qHr3XAwIk1DWXx4GklCIbfGygSIVLmz0Y
	8o+stryoHiAX8c7p2Pqhyh5YpwCBpWdpw4S9ZqxydNm8O6sC3w9FVOkdySUi5sCK
	JX1r5hGI0iS6ROSaUJt/ZfzZ3xUwPHB7rhiDhs9Rv0G1C+FGthgr8HH22Gl289cp
	5WRC9u82BdtlEHeREHhqOe19JXj/LS1pNhn/25xO+/EK+EqXvGVTzsnip5LTmCcB
	9wR5h9lO/DDVGGagUaz7nePBooNNl+ymDmZsh0ORnMRAHwtXHlnwWXxPMhMSl4FE
	gfyrk8+AVUKS0eCuCAAknuH7mlRESTR/gIz6YBumglelXphS9YaWw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdr8yr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699H8GLr1162533;
	Fri, 9 Oct 2026 18:33:15 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6v76t67e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699IXCgJ13238906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 18:33:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62D3A58051;
	Fri,  9 Oct 2026 18:33:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0C4B5805F;
	Fri,  9 Oct 2026 18:33:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.110.242])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 18:33:09 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnac123@linux.ibm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        santil@us.ibm.com, jeff@garzik.org, stephen@networkplumber.org
Subject: [PATCH net-next v3 1/8] ibmveth: fix netpoll races with RX replenish
Date: Fri,  9 Oct 2026 11:32:51 -0700
Message-Id: <20261009183258.18624-2-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261009183258.18624-1-mmc@linux.ibm.com>
References: <20261009183258.18624-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=JL6uIMKb c=1 sm=1 tr=0 ts=6ac9336c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=qzTZ72RhqM2DaLNR-rAA:9
X-Proofpoint-ORIG-GUID: IlytHUAdrLb1bvefShS8FGEKLGq-kjxG
X-Proofpoint-GUID: Jtz1Rm8dRs4_5MBJ-2hy0mSKrAan8wal
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX/qNcefKQCo2q
 IQTF74KSrqs1aM9ncoxAqlXRBQbU/lvWpWZLNWaRVCZ4qXIJedSyEvRLMU7toMRx25Cmo5FjrHs
 lbg75Z1EP2cFxjC8U0KDSq9uWhF43pA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXy5Xc1SKb3qsj
 X55nEAqaVKzvy18kVnnHTsUmtePDaNCbCNwBt2Ix4LWjC6qQglJ4oA6Xk7hkJp3kipdFsU4v5le
 VV1ksun0qWgxz4I0JedAzxPYSK2HUyacWgfSYBArcDB5X5JdQYymOexaiWo12/k8CzPSluU15BO
 qdSCAo+5cAOf6lYIwGfM5YdLmJYq4dqFGrDFwCQxzwAmf8+Oa8viHx9/wfDOgdyiXjMbo6bsqJo
 lRM3Cp/kn/ZHCqsQ3RYFpGsVFwhoHdUF66Jb7XaEkDAd6aPQyEMh3wABPStk4T3X2xVYnvISSK1
 rfwhzGW7hVog9ARn5f9HPsp40G0F5+eqyxYaRWA/QgxBA29Jwm9tXVOShgcKdOkFz0t+15xQigw
 jJMGBQ0CoQ9/08Q4TxihLQ6242KlRujmDP3Eos5+CIAnx49roNliiagRwFO/sRYdIIadOo+L0gq
 VfAft0kYDGcoCHne82Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090072

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

