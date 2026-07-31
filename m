Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5A2D060D
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785458898; cv=none; b=m9x//3GQwsYA1v/kquiGglURW45BgFXjgZdZD9i8WcNa2lz3yHwSoSFS1tt2nqIp4CO3odEW+SAGGe7JC1XZM1/IxZIS1TaX+iTavNi/qGkSRBcEjsz/z7sxK0+2x9lURZ/MOTM/LxFFKficVtkgJJ+t4P9URvExA+32wVZkn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785458898; c=relaxed/simple;
	bh=bPaXwSgvagtQX4NeXcj1owUShpA7KaqNBbV+HzdHHSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkwF8nNBvhXMBikHpn+e8FRmnHrkMVwd0EEn08SYvcKyqdkYTebcVWqkosAcHYMVBV0KDSAEsSIS7097dNMtlEfO0bxp5/Q7Q91CDDdt8PeppHx5/vc1HQha9HkLprE85ZvAQNgBwGZXUWxPbrWXhdjncSm2h12ZyOLTX9OaGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hFB7SOAG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hFB7SOAG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNI8Gh2519218;
	Fri, 31 Jul 2026 00:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/EeL24DDwGCXNTtFl
	onoYk13DISXnpLjeGTpsNWAIMI=; b=hFB7SOAGWDLIrTaWVvml7NbC4WA7mIKMv
	MbIVsZnCTjwZmLHjrJnymqe8XssxC2eNsKKWy944MeEKN9wwNKQrGWMbMEzZYP+v
	tbvqR+7Vi7TMjFx0buDQO2v1gC2UdVN4HHFxLtQi+6CL+Csfp/6sQvwhI0nCqPd1
	a/hQEZ88fIVZfS7wkUf8vmGvOxCTOT5q+WZP/rSw0mxaFMFALpfmrOjMVA5N58P/
	TfYgs/ywfppg3aYx1FfE2eLStXVv3QL2pE+e33h/kPBFqoo4Cws8qTWix8EQoySn
	byRddabQgP/L0+8L8hyYoi9krdhOcjIB0eckv0d1ypkU+mC8lTVkg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycthj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fnPC031717;
	Fri, 31 Jul 2026 00:47:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgnpdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0lubG38666626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:47:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A254B58058;
	Fri, 31 Jul 2026 00:47:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E5FB58057;
	Fri, 31 Jul 2026 00:47:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:47:55 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 07/14] ibmveth: Add RX queue register/deregister helpers for MQ
Date: Thu, 30 Jul 2026 17:47:10 -0700
Message-Id: <e415d7657c48f0848763b9781c7af3d8d3abc276.1785457143.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: s6qrAXGgWbuAjot7X7xzpDISaDZNF0JS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX0SvSliuNIRJV
 w2Fp40vxsuUssYsUm3cOToJQVE4J03wt+oF7rExonFGOpaZ/AjhgYQcM7gH3ywYRTy7uQipgUV0
 LkzkX88YND1txwEcSzBVWo6AItnIATGlw3KQTP4WaRkQ0nGdk1mHwVwk4Dyz+bzvF6LTiyIRLaM
 bL+vIDobl0VK3hz01b4G7Cpl8A9T4sVmqTemF6EvUCP+4pw1hwj6lfhonb98w/mV8+pjBryAxvr
 RvJvuq2l9w3s8fj0BAoMNuqyLcMYEEhT74avOOZ1wZT/wuCsMFS4SlT+mvRs4zMV5RDnRE36ini
 Rt54K/v5jvzrkEiXsZlHu4+pKRwztDOkKsjIe8VkbIUajJRZOARpHE8LbNrd60Lou1J9ArUlXoB
 VMU32n3jnOdgEoTM/gTU4I/97F2RloxTACVscSrJl8jcAAdtj9SF1L4FbhwhEpSE5phb03Xk4br
 cMt9RyQR1YaZfkjedVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX6uf256G+6CQU
 ai7mSooq6CnUwAvlnxBXsYKkMRRUhpYE9WxT+C0qdQeujHDid9C88xSyb155sb7kz2DMxslIhni
 p117AaRwes1oEiooCc6Dn8RTLp/AUsk=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6bf0bf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VDtk487BEgv0t-M-AEEA:9
X-Proofpoint-GUID: jPS1DTbAEPjayL6WYS4kfKyEu6D7mAZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310003

MQ RX changes queue lifecycle from one adapter-level register/free pair
to a mixed model:

  - queue 0: registered via h_register_logical_lan*()
  - queues 1..N: registered via H_REG_LOGICAL_LAN_QUEUE

This patch extracts the queue-0 control-plane helpers used by open/close
today and wires them in the same commit:

  ibmveth_register_rx_queues()
  ibmveth_free_all_queues()

Also update ibmveth_register_logical_lan() so that when multi_queue is
later enabled, queue 0 uses h_register_logical_lan_with_handle() and
stores queue_handle[0]. Runtime remains single-queue: multi_queue is
still false, so queue 0 keeps the legacy h_register_logical_lan() flow
and no subordinate queue is registered. Subordinate
register/deregister helpers arrive with the MQ enablement patch that
first calls them.

Introduce adapter->hcall_stats here for register/free path accounting
(first use).

Open/close unwind:
  - failures after successful LAN registration enter
    out_unregister_queues, then fall through to out_free_buffer_pools,
    so RX pools are not leaked;
  - free_all_queues() runs before free_buffer_pools() on open failure
    and close, so PHYP cannot retain a registered LAN while its
    DMA-backed RX pools are released.

Failures before registration go directly to out_free_buffer_pools.
RX interrupt masking before napi_disable is already handled by
cleanup_rx_interrupts() from the IRQ-helper patch.

With the helper patches through this one, open/close follow the
MQ-ready bring-up/teardown pipeline (still single-queue until MQ
enablement):

ibmveth_open():

  1. ibmveth_alloc_filter_list()
  2. ibmveth_alloc_rx_queues()       - buffer lists + RX rings
  3. ibmveth_alloc_buffer_pools()   - guest RX memory before PHYP
  4. ibmveth_register_rx_queues()   - PHYP registration (no IRQ enable)
  5. netif_set_real_num_rx_queues()
  6. ibmveth_setup_rx_interrupts()  - request_irq + napi_enable
  7. initial replenish kick         - schedule_rx_queue(0)
  8. ibmveth_alloc_tx_resources()

ibmveth_close():

  1. netif_tx_stop_all_queues()
  2. ibmveth_free_tx_resources()
  3. ibmveth_cleanup_rx_interrupts() - mask PHYP, napi_disable, free_irq
  4. ibmveth_free_all_queues()       - H_FREE_LOGICAL_LAN
  5. ibmveth_free_buffer_pools()
  6. ibmveth_cleanup_rx_resources()
  7. ibmveth_free_filter_list()

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Introduce register/free helpers in the same patch that wires their
  first open/close callers; keep subordinate-only helpers deferred
  until MQ enablement.
- Introduce adapter->hcall_stats here (first use); not in patch 2.
- Correct open/close unwind so free_all_queues() precedes
  free_buffer_pools().
- Drop the orphaned big-bang "open/close pipeline" patch from v3; that
  wiring is incremental across helper patches 3-7 instead.

 drivers/net/ethernet/ibm/ibmveth.c | 170 ++++++++++++++++++++---------
 drivers/net/ethernet/ibm/ibmveth.h |  14 +++
 2 files changed, 133 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 131c1a61d9e7..9d1242dbcb19 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -434,6 +434,9 @@ ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i, rc;
 
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		napi_enable(&adapter->napi[i]);
+
 	for (i = 0; i < adapter->num_rx_queues; i++) {
 		if (!adapter->queue_irq[i]) {
 			netdev_err(netdev, "queue %d has invalid IRQ (0)\n", i);
@@ -451,14 +454,13 @@ ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
 		}
 	}
 
-	for (i = 0; i < adapter->num_rx_queues; i++)
-		napi_enable(&adapter->napi[i]);
-
 	return 0;
 
 err_free_irqs:
 	while (--i >= 0)
 		free_irq(adapter->queue_irq[i], &adapter->napi[i]);
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		napi_disable(&adapter->napi[i]);
 	return rc;
 }
 
@@ -1156,9 +1158,14 @@ static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
 }
 
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
-        union ibmveth_buf_desc rxq_desc, u64 mac_address)
+					union ibmveth_buf_desc rxq_desc,
+					u64 mac_address)
 {
 	int rc, try_again = 1;
+	unsigned long ua = adapter->vdev->unit_address;
+	unsigned long buf_dma = adapter->buffer_list_dma[0];
+	unsigned long filter_dma = adapter->filter_list_dma;
+	u64 *qh0 = &adapter->queue_handle[0];
 
 	/*
 	 * After a kexec the adapter will still be open, so our attempt to
@@ -1166,13 +1173,25 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	 * try again, but only once.
 	 */
 retry:
-	rc = h_register_logical_lan(adapter->vdev->unit_address,
-				    adapter->buffer_list_dma[0], rxq_desc.desc,
-				    adapter->filter_list_dma, mac_address);
+	/* In multi-queue mode, obtain a queue handle for queue 0 so all RX
+	 * queues can use the same per-queue buffer hypercalls.
+	 */
+	if (adapter->multi_queue) {
+		rc = h_register_logical_lan_with_handle(ua, buf_dma,
+							rxq_desc.desc,
+							filter_dma,
+							mac_address,
+							qh0);
+	} else {
+		rc = h_register_logical_lan(ua, buf_dma, rxq_desc.desc,
+					    filter_dma, mac_address);
+	}
+	adapter->hcall_stats.reg_lan++;
 
 	if (rc != H_SUCCESS && try_again) {
 		do {
 			rc = h_free_logical_lan(adapter->vdev->unit_address);
+			adapter->hcall_stats.free_lan++;
 		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
 
 		try_again = 0;
@@ -1182,14 +1201,89 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 	return rc;
 }
 
+/**
+ * ibmveth_free_all_queues - Free all RX queues at once
+ * @adapter: ibmveth adapter structure
+ *
+ * Uses H_FREE_LOGICAL_LAN to free all queues in one hypercall.
+ * Used during interface close and registration error cleanup.
+ *
+ * Clears queue handles only; queue_irq[] is released by
+ * ibmveth_cleanup_rx_interrupts().
+ */
+static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
+{
+	unsigned long lpar_rc;
+	int i;
+
+	netdev_dbg(adapter->netdev, "freeing all RX queues at once\n");
+
+	do {
+		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
+		adapter->hcall_stats.free_lan++;
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(adapter->netdev,
+			   "h_free_logical_lan failed: %ld\n", lpar_rc);
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		adapter->queue_handle[i] = 0;
+}
+
+/**
+ * ibmveth_register_rx_queues - Register RX queues with hypervisor
+ * @adapter: ibmveth adapter structure
+ * @mac_address: MAC address for device registration
+ *
+ * Registers queue 0 via ibmveth_register_logical_lan(). Subordinate queue
+ * registration is added when multi-queue RX is enabled.
+ *
+ * Return: 0 on success, -ENONET if queue 0 registration fails
+ */
+static int
+ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
+{
+	struct net_device *netdev = adapter->netdev;
+	union ibmveth_buf_desc rxq_desc;
+	unsigned long lpar_rc;
+	int rc;
+
+	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
+				    adapter->rx_queue[0].queue_len;
+	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
+	adapter->queue_irq[0] = netdev->irq;
+
+	rc = ibmveth_disable_irq(adapter, 0);
+	if (rc != H_SUCCESS)
+		netdev_dbg(netdev,
+			   "Failed to disable IRQ for queue 0 before registration, rc=%d\n",
+			   rc);
+
+	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
+	if (lpar_rc != H_SUCCESS) {
+		netdev_err(netdev,
+			   "h_register_logical_lan failed: %ld\n", lpar_rc);
+		netdev_err(netdev,
+			   "buffer TCE:0x%llx filter TCE:0x%llx rxq desc:0x%llx MAC:0x%llx\n",
+			   adapter->buffer_list_dma[0],
+			   adapter->filter_list_dma,
+			   rxq_desc.desc, mac_address);
+		return -ENONET;
+	}
+
+	netdev_dbg(netdev,
+		   "registered 1 RX queue with hypervisor (single-queue mode)\n");
+	return 0;
+}
+
 static int ibmveth_open(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	u64 mac_address;
+	u64 mac_address = ether_addr_to_u64(netdev->dev_addr);
 	int rxq_entries = 1;
-	unsigned long lpar_rc;
 	int rc;
-	union ibmveth_buf_desc rxq_desc;
 	int i;
 
 	netdev_dbg(netdev, "open starting\n");
@@ -1205,37 +1299,23 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc)
 		goto out_free_filter_list;
 
-	mac_address = ether_addr_to_u64(netdev->dev_addr);
-
-	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
-					adapter->rx_queue[0].queue_len;
-	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
-
-	adapter->queue_irq[0] = netdev->irq;
-	ibmveth_disable_irq(adapter, 0);
-
-	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
-
-	if (lpar_rc != H_SUCCESS) {
-		netdev_err(netdev, "h_register_logical_lan failed with %ld\n",
-			   lpar_rc);
-		netdev_err(netdev, "buffer TCE:0x%llx filter TCE:0x%llx rxq "
-			   "desc:0x%llx MAC:0x%llx\n",
-				     adapter->buffer_list_dma[0],
-				     adapter->filter_list_dma,
-				     rxq_desc.desc,
-				     mac_address);
-		rc = -ENONET;
+	rc = ibmveth_alloc_buffer_pools(adapter);
+	if (rc)
 		goto out_free_queue_mem;
-	}
 
-	rc = ibmveth_alloc_buffer_pools(adapter);
+	rc = ibmveth_register_rx_queues(adapter, mac_address);
 	if (rc)
-		goto out_unregister_lan;
+		goto out_free_buffer_pools;
+
+	rc = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
+	if (rc) {
+		netdev_err(netdev, "failed to set number of rx queues\n");
+		goto out_unregister_queues;
+	}
 
 	rc = ibmveth_setup_rx_interrupts(adapter);
 	if (rc)
-		goto out_unregister_lan;
+		goto out_unregister_queues;
 
 	netdev_dbg(netdev, "initial replenish cycle\n");
 	ibmveth_schedule_rx_queue(adapter, 0);
@@ -1252,10 +1332,9 @@ static int ibmveth_open(struct net_device *netdev)
 
 out_cleanup_rx_interrupts:
 	ibmveth_cleanup_rx_interrupts(adapter);
-out_unregister_lan:
-	do {
-		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
+out_unregister_queues:
+	ibmveth_free_all_queues(adapter);
+out_free_buffer_pools:
 	ibmveth_free_buffer_pools(adapter);
 out_free_queue_mem:
 	ibmveth_cleanup_rx_resources(adapter);
@@ -1268,7 +1347,6 @@ static int ibmveth_open(struct net_device *netdev)
 static int ibmveth_close(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	long lpar_rc;
 
 	netdev_dbg(netdev, "close starting\n");
 
@@ -1277,18 +1355,8 @@ static int ibmveth_close(struct net_device *netdev)
 	/* PHYP mask + napi_disable + free_irq live in cleanup_rx_interrupts */
 	ibmveth_free_tx_resources(adapter);
 	ibmveth_cleanup_rx_interrupts(adapter);
-
-	do {
-		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-
-	if (lpar_rc != H_SUCCESS) {
-		netdev_err(netdev, "h_free_logical_lan failed with %lx, "
-			   "continuing with close\n", lpar_rc);
-	}
-
 	ibmveth_update_rx_no_buffer(adapter);
-
+	ibmveth_free_all_queues(adapter);
 	ibmveth_free_buffer_pools(adapter);
 	ibmveth_cleanup_rx_resources(adapter);
 	ibmveth_free_filter_list(adapter);
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index abcd4054c67e..2cfabddeee3d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -269,6 +269,17 @@ static int pool_active[] = { 1, 1, 0, 0, 0};
 
 #define IBM_VETH_INVALID_MAP ((u16)0xffff)
 
+struct ibmveth_hcall_stats {
+	u64 reg_lan_queue;	/* H_REG_LOGICAL_LAN_QUEUE */
+	u64 reg_lan;		/* H_REGISTER_LOGICAL_LAN */
+	u64 add_bufs_queue;	/* H_ADD_LOGICAL_LAN_BUFFERS_QUEUE */
+	u64 add_bufs;		/* H_ADD_LOGICAL_LAN_BUFFERS */
+	u64 add_buf;		/* H_ADD_LOGICAL_LAN_BUFFER */
+	u64 free_lan_queue;	/* H_FREE_LOGICAL_LAN_QUEUE */
+	u64 free_lan;		/* H_FREE_LOGICAL_LAN */
+	u64 send_lan;		/* H_SEND_LOGICAL_LAN */
+};
+
 struct ibmveth_buff_pool {
     u32 size;
     u32 index;
@@ -333,6 +344,9 @@ struct ibmveth_adapter {
 	u64 tx_large_packets;
 	u64 rx_large_packets;
 
+	/* Multi-queue statistics */
+	struct ibmveth_hcall_stats hcall_stats;
+
 	/* Ethtool settings */
 	u8 duplex;
 	u32 speed;
-- 
2.50.1 (Apple Git-155)

