Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B8A42B73B
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969880; cv=none; b=O8I5jH40wkNdd3EjpAXUDMz4nSa1kpWmGwGgcRxLsKTDa+q44RTR43lhp1NyOh3Rc37oVLiHJ34gch0Yn2hD/j/I1Q6NVy3k+p2Cszl3tIiO7iEsz7eAQtrdLIsLC653TVKmXcpyTWdg+XnuYeImu3SkXIb5NbP9SFQXBTlM2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969880; c=relaxed/simple;
	bh=1mojQo/yRXo1PCdKozlXf6rgC8SXD5dOULdsWCw6KCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LlibM0ER2TutPTOsINCsP6WmF6TjrkcPjWK4GQXwlAYNLiw5I17L0/p0PAobKvEkADuVp6v5EnBJU7DZWBkfVgRJqUEDerRXsC0gzt8Z8fWARQAP+zOqNP9odimyW6S2zqXpYpygbNBG28Q/VMTDg8P3L8ZlzISGuPWe7MvGzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gu6bkDY3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gu6bkDY3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Hlfo52655400;
	Wed, 5 Aug 2026 22:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZOd588qmGjKj4oBr3
	gd51bTpFU1ocvtcZNhqs5H3brw=; b=gu6bkDY3m0G/OgVLK4wGfaDMnKEcLcLPj
	RDKOChNm4fGFA79qI5ANzPvePI9HB1YmRTYTbFBd9BPexdud8l9JUwdluORiZXwE
	OBCNNLc+eT5nheF0lWaB8uUDUdwIXmGIon+Un4N3cfNj9OwwLmYftbdx3ws5o+KD
	OdHH59TRKv2SbRAyEMLwFKC6nKFgkWd5UNGDO9NRobrLFHxQpY5TnunufVeQq61U
	9M60g2JM6opcfVjdDzif/utDSGbkCv4UgHif38GUr6NU5h6a3zmv4mhfLxnmOkQD
	PYspVcRWVTx3KxejY10UGnTydY0f/hhPKeGFqD8V1X+Mf1BvseSEw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqwad0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675MfJB9016743;
	Wed, 5 Aug 2026 22:44:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qrs1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675MiRbY26411610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 22:44:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB1CC58054;
	Wed,  5 Aug 2026 22:44:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABA105805A;
	Wed,  5 Aug 2026 22:44:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.135.24])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 22:44:24 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
        ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
        vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mmc@linux.ibm.com
Subject: [PATCH net-next v1 4/6] ibmvnic: allocate new buffer pools before releasing the old ones
Date: Wed,  5 Aug 2026 15:43:59 -0700
Message-Id: <20260805224401.58791-5-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260805224401.58791-1-mmc@linux.ibm.com>
References: <20260805224401.58791-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: oSLV7owBPu5Pw8R-S9e0coTCFU0W_fnM
X-Proofpoint-ORIG-GUID: QGvzNl445bZsCxLXHJPEvdGo05ihxwD7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfX6XoQOXk/Datr
 cp+C7VmyIbCw09i2HPZ8DAHIudF9kkfItVdvMveECUeAY3OQaGNgNu96Fp3MXHV9B83Y7NJiM1s
 xBkicvck9rL7MIXgrHxuo7N8P8ejlwo=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a73bccd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=F51oz-FX4hxmwhorfIgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfX7paYWYAN6SaJ
 2QwnA9OD+ZBpgKVYG8NP1Ogh8Labw6IK/OQQHL6AHLX5uDeabDLydBFL4gzKkv+K3/jdD9V9/kW
 QEkXVh7LhRc/5DiEhk13vFzM3ueDYSbXJkh8COwz4pycUrBi+nv7c/OcRMlSKiCiSOYZ7oGHnjF
 LmSY4NA1xtgyDoaKYsea2V2JOH2y0z89/71LJDUfEnZefcnV925/pd6tYEfa69dMJ3Dedl2bhuC
 9tL7JuK8e4Vx2S3opjlRNZGw10MvD5UHhwbMVamuX/L22u8Yhix9OCp2s85VZ5tK+5xPSCftdN/
 /jd2whg+C+cW9RXEe3TbS/2KmL41/xT2lGj2lNiGdywfP0lJllQjj4Z75UWkF9yawggvz2a74Mz
 vsE2cSDr33h7MqikPTEj3fJ8HbeBwzxqj/d2kBZDDvBmzSQaBlepikibUiX1+rcodYj4r/CCsby
 YTHMURSyOo7rr+YfMSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050183

An mtu change goes through wait_for_reset() and then init_rx_pools() /
init_tx_pools(). Those helpers release the existing pools before
allocating their replacements:

  release_rx_pools(adapter);

  adapter->rx_pool = kzalloc_objs(struct ibmvnic_rx_pool, num_pools);
  if (!adapter->rx_pool) {
          dev_err(dev, "Failed to allocate rx pools\n");
          return -ENOMEM;
  }

If that allocation fails mid-reset the interface is left with no pools
and stays down after what should have been a refused mtu change, when
it could have kept running with the pools it still had.

Allocate first and only release once the allocation has succeeded. The
tx side has to swap ->tx_pool and ->tso_pool in together, so that
release_tx_pools() never sees one set without the other.

These are small allocations and failing them is unlikely, so this is
about the ordering rather than about any failure seen in the field.
alloc_long_term_buff() has the same shape for a much larger allocation
on the mtu-grow path and is dealt with next.

Fixes: 489de956e7a2 ("ibmvnic: Reuse rx pools when possible")
Fixes: bbd809305bc7 ("ibmvnic: Reuse tx pools when possible")
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Vaishnavi Bhat <vaishnavi@linux.ibm.com>
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 37 ++++++++++++++++--------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index e875f43a1ea1..24c8acc42a93 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1098,6 +1098,7 @@ static int init_rx_pools(struct net_device *netdev)
 {
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
 	struct device *dev = &adapter->vdev->dev;
+	struct ibmvnic_rx_pool *new_rx_pool;
 	struct ibmvnic_rx_pool *rx_pool;
 	u64 num_pools;
 	u64 pool_size;		/* # of buffers in one pool */
@@ -1113,15 +1114,16 @@ static int init_rx_pools(struct net_device *netdev)
 		goto update_ltb;
 	}
 
-	/* Allocate/populate the pools. */
-	release_rx_pools(adapter);
-
-	adapter->rx_pool = kzalloc_objs(struct ibmvnic_rx_pool, num_pools);
-	if (!adapter->rx_pool) {
+	/* Allocate before release so a failure keeps the old pools. */
+	new_rx_pool = kzalloc_objs(struct ibmvnic_rx_pool, num_pools);
+	if (!new_rx_pool) {
 		dev_err(dev, "Failed to allocate rx pools\n");
 		return -ENOMEM;
 	}
 
+	release_rx_pools(adapter);
+	adapter->rx_pool = new_rx_pool;
+
 	/* Set num_active_rx_pools early. If we fail below after partial
 	 * allocation, release_rx_pools() will know how many to look for.
 	 */
@@ -1333,6 +1335,8 @@ static int init_tx_pools(struct net_device *netdev)
 {
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
 	struct device *dev = &adapter->vdev->dev;
+	struct ibmvnic_tx_pool *new_tso_pool;
+	struct ibmvnic_tx_pool *new_tx_pool;
 	int num_pools;
 	u64 pool_size;		/* # of buffers in pool */
 	u64 buff_size;
@@ -1349,26 +1353,25 @@ static int init_tx_pools(struct net_device *netdev)
 		goto update_ltb;
 	}
 
-	/* Allocate/populate the pools. */
-	release_tx_pools(adapter);
-
+	/* Allocate before release so a failure keeps the old pools. */
 	pool_size = adapter->req_tx_entries_per_subcrq;
 	num_pools = adapter->num_active_tx_scrqs;
 
-	adapter->tx_pool = kzalloc_objs(struct ibmvnic_tx_pool, num_pools);
-	if (!adapter->tx_pool)
+	new_tx_pool = kzalloc_objs(struct ibmvnic_tx_pool, num_pools);
+	if (!new_tx_pool)
 		return -ENOMEM;
 
-	adapter->tso_pool = kzalloc_objs(struct ibmvnic_tx_pool, num_pools);
-	/* To simplify release_tx_pools() ensure that ->tx_pool and
-	 * ->tso_pool are either both NULL or both non-NULL.
-	 */
-	if (!adapter->tso_pool) {
-		kfree(adapter->tx_pool);
-		adapter->tx_pool = NULL;
+	new_tso_pool = kzalloc_objs(struct ibmvnic_tx_pool, num_pools);
+	if (!new_tso_pool) {
+		kfree(new_tx_pool);
 		return -ENOMEM;
 	}
 
+	/* Swap both in together for release_tx_pools(). */
+	release_tx_pools(adapter);
+	adapter->tx_pool = new_tx_pool;
+	adapter->tso_pool = new_tso_pool;
+
 	/* Set num_active_tx_pools early. If we fail below after partial
 	 * allocation, release_tx_pools() will know how many to look for.
 	 */
-- 
2.50.1 (Apple Git-155)

