Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED974D9F7A
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361578; cv=none; b=GsPOOj8fxx+k83MhgHFcrfFc/bYFAk3Kapfv4EmS/SCzcASM0O2TDF4iwwxGH6qMLC6A7vI++DYnLFk3wzBu6Vh4PQF9/yEHYEHvQ8z62d0u9v/geg8ykUBGI0mGPx+LUthQw0zcIG2vOB3yjy/aBl8g6fE8DaKTAFD/TtzRs1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361578; c=relaxed/simple;
	bh=3/zaNhmkDsyjOdG+xtxNRPTWOgAfcTZT0kg66vln38Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1AkuTrfqVY2h3DZg9DVwNe4Qy9HNjYDVh7wQAaniia7Wa98xAz2YdZpzHYd0WhEWVM63KTR4SrjsZRSOYFxuxW8LcSggZHPkU/rRLk4mFFsxRIm1ofj3rLZ3vOSLmmKUR31s6AdxS+loko103nvEhCOlqNfel7MkQ8LM4lmPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cc94g46p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cc94g46p"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5uQB1372049;
	Fri, 25 Sep 2026 18:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kAlUfVh4kl9bOjtcK
	HKIBb1mt4Txg8LtCJBf8uBmibM=; b=cc94g46pxbPjki673iUzlBfWrFFWqrDON
	oSbfIq5BoVKVtWMdXDpueyaW6RapFCyfaLP15+M6fjjzhuSU6pIcqDCGcrya+WU8
	vt1j0cEtLSQKVRy5iEhqMXchzVTZl09EYXzCJmiF9euyKvK1ojMexkJ6PNHuY8Od
	TOl/zDVMEv/I44F9yB5M3WAx3YZmGlO1HFXxY4JsC2mLDduO7pNYwBRy8T9PUkBX
	O2MXMR/6/Nokg8gRFzjlhu/N5Q8dZDX0u1kpuQa+2WJu9WWbiTsFQztHD03zmpUR
	Ev4tpolGXuZkdrou147+7LkcaYEzxz+Vg9ilA9sQdOaxFYuR57y/g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1yqmh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG3LqB4140698;
	Fri, 25 Sep 2026 18:39:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu93fpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:39:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PIdGDL20251266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:39:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 571725804B;
	Fri, 25 Sep 2026 18:39:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B050458055;
	Fri, 25 Sep 2026 18:39:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:39:13 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v7 04/15] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Fri, 25 Sep 2026 11:38:39 -0700
Message-Id: <f08dad35beac54cfcbcf96233025b977f5611b7d.1790319558.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790319558.git.mmc@linux.ibm.com>
References: <cover.1790319558.git.mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 6AqiChjNtX2BWjItOv72wcKvRxkoesCP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfXz3xZl6UKlUMj
 HLQya+3lGdUKPu9WefME2Sqo3L6RA5uRVH2c9LSdjTilPvFgVaGhN/i64MphEVRlmGoeKUai8pa
 AbmkN4gIT1dzGBsRhrhpUkyZ/0AQRqYLwW630Fn+vp5Nd8PrMVxNGuxYwTsmcoyaCiIOGkZ6rVJ
 Xk8rf/PLxCGLsfX8fXSeey9zdR20OEzH4Qt0/J++VqqH1k2VWGqK6uHcUynElK0aJKhkoUXhoAA
 JUnFrMzyTNdKj22CMPnaoLKZJlbLxYKd3UHhIxJ/DPBaaug0237qvD1ZOHfjoNntBw021C6QWxV
 sxQlnCWJ/+ejntyll9iM2EGfvFME21QJ0Yb/ULJX7E4qzrJN2+J7/q2c6wZQwnbp3zVzz81PUcb
 0o4QAJsa8Mz2YPvd8QNBeZF81QV9O6XGiAcBn+1B+6q5iX2xdayJVg3gdqXEa/5wduxlSTQoJzO
 zPxgB9ie0Cl+zYgylQg==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab6bfd8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=lp0D4TrqX67ggtpjc1wA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX490dWJ15gX6H
 qQA9tS+WvG/F+kL2YkJjdWSakulxmibzfRLIr4ytW0QznSLooDVhRzIxzV5k1nXzGYsNv7BEYVy
 us/Ri/dPRCiiMEcXJcGTc8qS4YUM+hQ=
X-Proofpoint-GUID: Izq4cb-P83oflAL3K0ykFbXib7pYoZzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

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

Queue 0 remains the template for pool geometry and activation policy
(size, buff_size, threshold, index, active). Queues 1..N copy that
metadata from queue 0, then allocate backing arrays/skbs per queue.
The existing poolN/ sysfs knobs stay adapter-wide on queue 0: writing
a pool size multiplies real memory by num_rx_queues (still 1 here).
Per-queue runtime state is exposed later via debugfs, not separate
per-queue pool sysfs nodes.

Wire the helpers into open()/close() in the same patch. Runtime
remains single-queue (num_rx_queues is still 1).

Pulling the pool loop out has one side effect worth naming: it no
longer consumes open()'s loop index, so a pool failure or a
request_irq() failure reaches out_free_tx_ltb with i still at
real_num_tx_queues and the TX LTBs actually get freed. The shared
index that swallowed them was pre-existing, so there is no
standalone Fixes: tag; the TX side gets its own unwind two patches
later.

Error handling is queue-safe: allocation failure unwinds only what
that queue allocated (then prior queues in the caller).
alloc_buffer_pool() already undoes its own partials, so this open-fail
slot is empty. Free paths still release by real allocations
(free_map/dma_addr/skbuff), not only pool->active, which later resize
needs when a pool can hold memory after active was cleared.

close() also reorders pool teardown ahead of cleanup_rx_resources()
and filter-list free. That is safe here because h_free_logical_lan(),
napi_disable(), and free_irq() have already run, so neither PHYP nor
NAPI still reference the pool buffers or RX completion queue.

Keep the legacy 64 KiB pool enabled by default at standard MTU (same
as single-queue policy).

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v7:
- no P04 code change
- commit message: request_irq() failure also reached
  out_free_tx_ltb with i spent
- noted: err_cleanup comment reworded in P03
- noted: no Fixes: peel of the shared-i TX LTB leak (named
  in the v6 body after v5); [PATCH net 2/2]
  <cover.1790357373.git.mmc@linux.ibm.com>
- noted: no pool-before-register reorder here; P06 issues h_free
  on the pool-fail path, P07 allocates pools before register

Changes in v6:
- retarget the free-by-presence comment to the later resize paths;
  alloc_buffer_pool() already undoes its own partials, so this
  open-fail slot is empty
- use %u for the two num_rx_queues dbg prints
- noted: pool-fail after register without h_free_logical_lan predates
  this patch; the inline pool loop reached the same labels. P06
  issues h_free before the pool DMA; P07 moves pools ahead of
  register_rx_queues

Changes in v5:
- vs mailed v4: keep pool_active[] = {1,1,0,0,1} (v4 set the 64 KiB
  pool inactive). No code delta vs prior patches here; SQ large-receive /
  CMO stay at the historical baseline. change_mtu does not re-enable
  pool4 at MTU 1500; MQ memory pressure belongs at scale-up, not SQ
  default
- Unwind / free pools by real allocations (free_map/dma_addr/skbuff),
  not only pool->active, so open-fail cannot leak partially allocated
  pools (v4 fail path freed by active and skipped the failing pool)
- Clarify kdoc: free paths use allocation presence (not "all active");
  queue 1..N metadata copy from queue 0 (v4 said "queues 1-15" while
  MAX is still 1 here)
- Document poolN sysfs size multiplies by num_rx_queues (queue 0 is the
  shared template; no per-queue pool sysfs in this series)
- Call out close() pool-free before cleanup_rx_resources, after LAN/
  NAPI/IRQ teardown (order already in v4; spell it for later drain)

Changes in v4:
- Introduce the pool helpers in the same patch that wires their first
  open/close callers, instead of leaving unused statics.
- Copy pool->index when cloning queue-0 geometry to later queues
  (needed for correlators; also required by incremental resize).

 drivers/net/ethernet/ibm/ibmveth.c | 163 +++++++++++++++++++++++++----
 1 file changed, 143 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 01efd318baab..5813352943fb 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -639,6 +639,144 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 	}
 }
 
+/**
+ * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Frees buffer pools that still hold allocations for the specified
+ * queue (by free_map / dma_addr / skbuff presence), regardless of the
+ * active flag.
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
+		 * active flag. Allocation and active can diverge on failure
+		 * paths, so check for actual allocations.
+		 */
+		if (pool->free_map || pool->dma_addr || pool->skbuff)
+			ibmveth_free_buffer_pool(adapter, pool);
+	}
+}
+
+/**
+ * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
+ * @adapter: ibmveth adapter structure
+ * @queue: queue index
+ *
+ * Allocates backing storage for each active pool on @queue.
+ * Inactive pools (!active) are skipped. Pool metadata must be
+ * initialized before calling this function.
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
+				   "queue %d pool %d alloc failed (size=%u count=%u)\n",
+				   queue, i,
+				   bpool->buff_size,
+				   bpool->size);
+			bpool->active = 0;
+			/* Free by allocation presence, not pool->active.
+			 * Needed on later resize paths (a pool can still
+			 * hold memory after active is cleared). This
+			 * open-fail slot is already empty:
+			 * alloc_buffer_pool() undoes its own partials.
+			 */
+			ibmveth_free_queue_buffer_pools(adapter, queue);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
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
+	/* Initialize pool metadata for queues 1..N from queue 0 settings */
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
+	netdev_dbg(netdev, "allocated buffer pools for %u queue(s)\n",
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
+	netdev_dbg(adapter->netdev, "freed buffer pools for %u queue(s)\n",
+		   adapter->num_rx_queues);
+}
+
 /**
  * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
  * @adapter: adapter instance
@@ -863,16 +1001,9 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -897,11 +1028,7 @@ static int ibmveth_open(struct net_device *netdev)
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
@@ -940,14 +1067,10 @@ static int ibmveth_close(struct net_device *netdev)
 
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
 
-- 
2.50.1 (Apple Git-155)

