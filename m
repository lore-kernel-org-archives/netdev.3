Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABDB288C2C
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785458895; cv=none; b=LGuKH7UWIcd+bks/MTCjte0YSXzekdopnP2EhWmaWKok2p/tu0b2V3LHm3Hd7NEvJYhAe69uRjOuImRsKgfiHMePYP1+mjjR7nYAyfc2sfoymvqBuefYB/qAjvYLj2sQ7UWtX/xtWO8dG0g3PWfSoUtUzjAgcrcr0B6fF72yVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785458895; c=relaxed/simple;
	bh=yIGwLcf7Nmh4kMY2DAC9ZJuqz9ffva+hqdWXe6pOG4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hpuQyXBxpJHVl4EQlszbmEoFje0a2+XwJ/Vhs56HzJqf9FJMMYwkICtJIphWnlVjd78beC3PfLefMaoTcLxhIizAILKKUZAfTXKw5raVcX0Q8b6EY13ZJb4D7cCw1b8QhoO22WWnGLXpbjk+wkyecYFyDskkYOjNdnP77CLt91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AH8m698p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AH8m698p"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNI770244047;
	Fri, 31 Jul 2026 00:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d35Fx4NsSi0WJoUbx
	rTLdGU2ifDXKJTUqE+t9b/NqSY=; b=AH8m698p7YE+yCkrW9eO2jKJmMj6Jgg7W
	k9ux3cBXlFxAtrIELqnWsDDpHg0A6+IOHuNcwV4+6Mq5sdAtGFcMRduH+RWu7YBJ
	jk756ZsVcMHkOng92UJtKxSaGP7F7l4qnxy8+IBt/deaeLnv80b5gPnr8jXZ//Kg
	zUfrPfLrMVz9A66PhD13dDg/VNY2Bt+P21mYg/poPuJHNYrqEP68knS3n94ZgGjh
	s4zkpkOlwMcRa3KVaJHpDf3p/pZUiMsLVxCJO5pe/0Sw6lKNBXv3ZOfHRZfOMe45
	ElTPrYY0XNGiWY79yPh5SASpWLidhYSwuEa0bjUGWdhZFl3ytH42w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd9n8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fL6k018174;
	Fri, 31 Jul 2026 00:47:52 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwe04w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0lpMD19071546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:47:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED09158059;
	Fri, 31 Jul 2026 00:47:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA82958061;
	Fri, 31 Jul 2026 00:47:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:47:49 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 04/14] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Thu, 30 Jul 2026 17:47:07 -0700
Message-Id: <e22471625e6a04bee87f099f467d575bcfd0c2c6.1785457143.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1785457143.git.mmc@linux.ibm.com>
References: <cover.1785457143.git.mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: RiGxbn7mtr7HraSLW51eP8XVD1Rnd9oY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX8G0GPbynF10s
 5UgftXeWTst4QcdbA00n51loe0xoeFVB+e8ASmxSG+qEGmja25qhqw8gdfGrldo5cIGJxdfmz6I
 weziiYFDe0wNuW72QVq/Mz80lyZ2D8Q=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6bf0b9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=tTB-aIKIKo--xvCzC8kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX+umSD3MNG8Om
 Cdret6koZzJqu7NOqhS4sv62eCQPvMXPJVdNDSEInLmGZdppC1RS7EOVPiNKYS9OmgoWZsapdSD
 s6QtDRLYl9WZJAzNgZNDP86E6i5Y427e9Irl8Zy/LyNuesc3LywyI36zMlFbbNSwKJ146Q7zKE3
 vLL0VC6sUOn8jOXY/fKQ9HvCVqX72SOSrQtnMoY4sSrz9Ig1OgjS2oi15/ZfjLB+zcY2mDQvsxE
 5SFPMj4hGox6hjSdygszPyjMEvDeHVfQEnEY5uaovlAj9oLJnqrVC4CxdjMGQGkEqyWV0FnWxoD
 woBhwLuSL5p6ncV4GT+1TbNjCnqsaPM2vGtiKzn9J2/9PqFwIN+Pd04YWi6Ez5gRNub0avNmBNC
 oo6Mzt9oU6z77smbq1igW8rV9g0R96dLxKqL3P17AWyy8iJhIloyaZCjKFORuQRDnRidM5DD8Zg
 xKvoQ7sg8pwgQH5cgpg==
X-Proofpoint-GUID: mVr8h-UpA4QOI8YMigJfcVHdcX1P1zDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310003

Legacy ibmveth uses five adapter-level RX buffer pools (512 B through
64 KiB). pool_active[] enables the standard-MTU pools by default;
larger pools activate when MTU requires them. With single-queue RX
that set is shared on one completion path.

MQ requires the same pool model per queue: buffers post with
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE against a queue handle and completions
return on that queue. Sharing pools across queues would mix ownership
and break queue-local replenish/drain/teardown.

Refactor around queue-local pools:

  rx_buff_pool[queue][pool]
  ibmveth_alloc_queue_buffer_pools()
  ibmveth_free_queue_buffer_pools()
  ibmveth_alloc_buffer_pools() / ibmveth_free_buffer_pools()

Queue 0 remains the template for pool geometry (size, buff_size,
threshold, index, active). For queues 1..N we copy metadata from
queue 0, then allocate backing arrays/skbs per queue.

Wire the helpers into open()/close() in the same patch. Runtime
remains single-queue (num_rx_queues is still 1).

Error handling is queue-safe:

  - allocation failure unwinds only what that queue allocated, then
    prior queues in the caller
  - free paths release by real allocations (free_map/dma_addr/skbuff),
    not only pool->active

That allocation-based free check is intentional: later resize and
failure paths can leave memory allocated after active was cleared.

Also disable the 64 KiB pool by default at standard MTU. MTU changes
activate it when required; leaving it enabled would pin about 16 MiB
per RX queue in MQ mode.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Introduce the pool helpers in the same patch that wires their first
  open/close callers, instead of leaving unused statics.
- Copy pool->index when cloning queue-0 geometry to later queues
  (needed for correlators; also required by incremental resize).

 drivers/net/ethernet/ibm/ibmveth.c | 164 +++++++++++++++++++++++++----
 drivers/net/ethernet/ibm/ibmveth.h |   2 +-
 2 files changed, 145 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 1007dd95cde0..7a2ed49cad4f 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -625,6 +625,145 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 	}
 }
 
+/**
+ * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Allocates all active buffer pools for the specified queue.
+ * Pool metadata must be initialized before calling this function.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int ibmveth_alloc_queue_buffer_pools(struct ibmveth_adapter *adapter,
+					    int queue)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		struct ibmveth_buff_pool *bpool =
+			&adapter->rx_buff_pool[queue][i];
+
+		if (!bpool->active)
+			continue;
+
+		if (ibmveth_alloc_buffer_pool(bpool)) {
+			netdev_err(netdev,
+				   "pool %d/%d alloc failed (size=%u count=%u)\n",
+				   i, queue,
+				   bpool->buff_size,
+				   bpool->size);
+			bpool->active = 0;
+
+			/* Free pools allocated so far for this queue */
+			while (--i >= 0) {
+				struct ibmveth_buff_pool *fpool =
+					&adapter->rx_buff_pool[queue][i];
+
+				if (fpool->active)
+					ibmveth_free_buffer_pool(adapter,
+								 fpool);
+			}
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Frees all active buffer pools for the specified queue.
+ */
+static void ibmveth_free_queue_buffer_pools(struct ibmveth_adapter *adapter,
+					    int queue)
+{
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		struct ibmveth_buff_pool *pool =
+			&adapter->rx_buff_pool[queue][i];
+
+		/* Free pool if it has allocated memory, regardless of
+		 * active flag. Pools may have memory allocated but not
+		 * marked active during queue scale-up, so we must check
+		 * for actual allocations.
+		 */
+		if (pool->free_map || pool->dma_addr || pool->skbuff)
+			ibmveth_free_buffer_pool(adapter, pool);
+	}
+}
+
+/**
+ * ibmveth_alloc_buffer_pools - Allocate buffer pools for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Initializes pool metadata for queues 1-N from queue 0 settings,
+ * then allocates buffer pools for all queues using the helper function.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int
+ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i, q, rc;
+
+	/* Initialize pool metadata for queues 1-15 from queue 0 settings */
+	for (q = 1; q < adapter->num_rx_queues; q++) {
+		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+			struct ibmveth_buff_pool *src =
+				&adapter->rx_buff_pool[0][i];
+			struct ibmveth_buff_pool *dst =
+				&adapter->rx_buff_pool[q][i];
+
+			dst->size = src->size;
+			dst->index = src->index;
+			dst->buff_size = src->buff_size;
+			dst->threshold = src->threshold;
+			dst->active = src->active;
+		}
+	}
+
+	/* Allocate actual buffers for all queues */
+	for (q = 0; q < adapter->num_rx_queues; q++) {
+		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
+		if (rc) {
+			/* Free pools for all previous queues */
+			while (--q >= 0)
+				ibmveth_free_queue_buffer_pools(adapter, q);
+			return rc;
+		}
+	}
+
+	netdev_dbg(netdev, "allocated buffer pools for %d queue(s)\n",
+		   adapter->num_rx_queues);
+	return 0;
+}
+
+/**
+ * ibmveth_free_buffer_pools - Free buffer pools for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Frees buffer pools for all queues using the helper function.
+ */
+static void
+ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
+{
+	int q;
+
+	/* Free buffer pools for all queues */
+	for (q = 0; q < adapter->num_rx_queues; q++)
+		ibmveth_free_queue_buffer_pools(adapter, q);
+
+	netdev_dbg(adapter->netdev, "freed buffer pools for %d queue(s)\n",
+		   adapter->num_rx_queues);
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
@@ -850,16 +989,9 @@ static int ibmveth_open(struct net_device *netdev)
 		goto out_free_tx_ltb;
 	}
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
-		if (!adapter->rx_buff_pool[0][i].active)
-			continue;
-		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
-			netdev_err(netdev, "unable to alloc pool\n");
-			adapter->rx_buff_pool[0][i].active = 0;
-			rc = -ENOMEM;
-			goto out_free_buffer_pools;
-		}
-	}
+	rc = ibmveth_alloc_buffer_pools(adapter);
+	if (rc)
+		goto out_free_tx_ltb;
 
 	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
 	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
@@ -884,11 +1016,7 @@ static int ibmveth_open(struct net_device *netdev)
 	return 0;
 
 out_free_buffer_pools:
-	while (--i >= 0) {
-		if (adapter->rx_buff_pool[0][i].active)
-			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[0][i]);
-	}
+	ibmveth_free_buffer_pools(adapter);
 out_free_tx_ltb:
 	while (--i >= 0)
 		ibmveth_free_tx_ltb(adapter, i);
@@ -927,14 +1055,10 @@ static int ibmveth_close(struct net_device *netdev)
 
 	ibmveth_update_rx_no_buffer(adapter);
 
+	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (adapter->rx_buff_pool[0][i].active)
-			ibmveth_free_buffer_pool(adapter,
-						 &adapter->rx_buff_pool[0][i]);
-
 	for (i = 0; i < netdev->real_num_tx_queues; i++)
 		ibmveth_free_tx_ltb(adapter, i);
 
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 8eaa3942fc40..abcd4054c67e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -265,7 +265,7 @@ static inline long h_illan_attributes(unsigned long unit_address,
 static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
 static int pool_count[] = { 256, 512, 256, 256, 256 };
 static int pool_count_cmo[] = { 256, 512, 256, 256, 64 };
-static int pool_active[] = { 1, 1, 0, 0, 1};
+static int pool_active[] = { 1, 1, 0, 0, 0};
 
 #define IBM_VETH_INVALID_MAP ((u16)0xffff)
 
-- 
2.50.1 (Apple Git-155)

