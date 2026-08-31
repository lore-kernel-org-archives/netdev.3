Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290AA4A99B8
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188975; cv=none; b=EHvd4+9hDO1znzWXnr2UI6rr3IyUnZz7ihQ81tgG1X6Qn4RniSQ5TYHwSiiOhfpdhCyAjwfZbm4EqV3dVCgiMFEfEUXd+ErJdR44VtoF1p4v0bE5DKr9SofY1/9SOYkTZ38y7V0/ja5U9aKs88Ak/HliXSPPDaeXQuCtDgK1PNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188975; c=relaxed/simple;
	bh=KCPlqrQdbtK+ZuJ+3bPU7hF+qDxRz8/poaEWmu/A5yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l9YYgxVTAurfU1P22hbZcx0KNys0s+pOYbdblarwmT9q90xHT7nLM5QE9fcNerkA3S3Q6+wBQfZ4oYxjzQQbBp0i9poBPIrHQEylgkIatBTpzgcgmwR4GgG6o7l8VwIFP7VMTpOKEoDfBMOQzHxHhMKQKS8Waoe58gXhBPfuJtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dlb1db3T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dlb1db3T"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ3fY2525447;
	Mon, 31 Aug 2026 15:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EzmWpstpnyOVLG84t
	igbW6B2OWareAYlpdlicDCZZBo=; b=Dlb1db3ToUL2UOgGV8UZVm74Cd4X9fpaA
	zVYCO4BwsDH58KlIglxMfxcPFVxHOwfz0VFSmBTVgL5LH29iTyTISkwMB13Jj5lH
	rm7gWbirAsWFYEQlF8VEav1lXLY7/FRdFqV5bImFxcK34B3FoXLtkJOMcbNo/75N
	SaGLlbi8FU3VyWisqtU9DjqhfLBECyHfKrLKZrf+O2ac0Q59Pf3a2xBe3k8LKUxV
	UWYwPqIXxSRGktcTukAAyLSBCTo/4rGEBE32rEpWy5JQ9gHaxq/Q6XnCT9bf3yRI
	mENqaTOPJlvfFno8+fsIslj7uogE+375Pr2ciI5LDtfYBGCZXGQtQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54j3x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:09:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuM5j003228;
	Mon, 31 Aug 2026 15:09:18 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq6r02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:09:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF9CGC11338286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:09:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E594258051;
	Mon, 31 Aug 2026 15:09:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A6035805A;
	Mon, 31 Aug 2026 15:09:08 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:09:07 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 15/15] ibmveth: Complete set_channels down-path and mq_fallback max_rx cap
Date: Mon, 31 Aug 2026 08:07:26 -0700
Message-Id: <7096819367d53e08c1f4d317616c2624a2867b7a.1788102125.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1788102125.git.mmc@linux.ibm.com>
References: <cover.1788102125.git.mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX62KKgE2ALCxf
 xoohg1Pk7cFTW+kOYwZbfg9SBQi41K+OfAYCE//y3iobiIPOKStg0k5/Uhf6Dcj2C0MkeoYXLl5
 j6aCbK4t83imh7DoJmdOKsNdoKneIf2u7BAmVr9MGR/cvp4eyZSUmyJF6x+wkzy6HY4dPhc6UTN
 RVpttJ90N2JLKCQL4/dWL9Y44hIGS5mvzNTQUDeaC6yCFQ5I1Q1Tlg02JOK9Q1EtDxBRhfygCS0
 XMFSUzmsJNxg6qyGMNXWP9R5SkWaP7pfAAiVzSdj00c0ivctk/FDqZ/usyvOGbRAeLPFlr2dWtg
 ZoDGAktrOhi+qC9c0AEKatT7hRdIUw86l6Omu0rjFCiiLIyk/pJIs5TpjRJTI0TxnJ2vkp2H5uT
 qwaf222/oom1kz4FE5Cd0SnItcC0KOsXkmjMXzam+7ElCnw1P7giyeN4VJ0D5y1lb7JzoxaXlYM
 Py6vMzBj4r82/AKW79A==
X-Proofpoint-ORIG-GUID: iSdC-2VQxHqRAwtbSBx72p9HVWLIn0OM
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95991f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=2q2IIZmVrjWqPTRBqXcA:9
X-Proofpoint-GUID: 0UmXbqA48M5HRxMAte45jH2aLPcy8fAR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX0HrlCrrtiEsz
 63h8iEpke31P3yU2gjm+NHkmZp7piJl1258J7T+wiXIp8qtWKRUfG2HBUwPS2xx/QugOiSWsqqy
 SJEsOxGoTjEqUc6Ox9UPLTMHzAfQ/rs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130

Patch 14 wires live ethtool -L rx. This patch completes the down-path
publish/rollback and get_channels() once mq_fallback is set.

When down: set TX queues first, then publish the desired RX count in
adapter->num_rx_queues and netdev->real_num_rx_queues (rx-N sysfs and
CMO desired change immediately). Do not allocate RX mappings, buffers
or IRQs while down. If RX set_real fails, restore the old TX real_num.

When up: resize RX, then the existing TX LTB
stop/alloc/set_real_num_tx/free/wake path. Skip that path when the TX
count is unchanged. If TX cannot reach the requested count, roll RX
back; that rollback is best-effort.

Validate tx_count before touching RX so a request the driver will
reject does not resize RX first. The ethtool core already range-checks
against the max_tx get_channels() reports; this is the driver's own
guard.

get_channels() always reports the live rx_count. When mq_fallback is
set it caps max_rx at that count. Understating rx_count would turn a
TX-only ethtool -L into a silent RX shrink. Capping max_rx blocks
growth in the core without misreporting what is configured.

i = old_tx before the TX alloc loop is readability; the old
for-initializer already defined i for the free walk.

Guard poll_controller() with adapter->opened so netpoll cannot walk
unallocated queue state while closed.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v6:
- get_channels() caps max_rx at the live rx_count when mq_fallback
  is set; rx_count stays live
- roll back TX real_num if down-path RX set_real fails
- poll_controller() returns if !opened
- noted: rx > 1 reject once mq_fallback is set is patch 14

Changes in v5:
- set_channels / resize_rx_channels read via get_num_rx_queues()
- Series renumber: mailed v4 13/14 set_channels -> tip P15 (end; 14->15)
- set_channels: gate on adapter->opened (not IFF_UP) for live RX resize
  vs while-down stash
- Down-path RX stash also refreshes CMO (publish + set_real_num_rx)
- When up: resize RX then TX; roll RX back if TX cannot reach goal

Changes in v4:
- On !IFF_UP, stash num_rx_queues only after TX set succeeds; do not
  allocate live subordinate IRQs/buffers while down.
- Initialize i = old_tx on the TX adjust path.
- Always return rc from set_channels().
- Split from the resize-helper patch (same split as v3) while keeping
  a live caller of resize_rx_channels() in the previous patch.

 drivers/net/ethernet/ibm/ibmveth.c | 143 +++++++++++++++++++++++------
 1 file changed, 117 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 5aef8a1f2c23..4cd00ff3d43e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -3156,15 +3156,24 @@ static void ibmveth_get_channels(struct net_device *netdev,
 				 struct ethtool_channels *channels)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+	unsigned int rx_count = ibmveth_get_num_rx_queues(adapter);
 
 	channels->max_tx = ibmveth_real_max_tx_queues();
 	channels->tx_count = netdev->real_num_tx_queues;
 
-	if (adapter->multi_queue)
+	/*
+	 * Always report the live RX count. ethtool -L is read-modify-
+	 * write, so a TX-only request echoes rx_count back at us; an
+	 * understated value would be applied as a silent RX shrink.
+	 * mq_fallback instead caps max_rx at the live count, which
+	 * blocks growth in the core without misreporting what is
+	 * currently configured.
+	 */
+	channels->rx_count = rx_count;
+	if (adapter->multi_queue && !adapter->mq_fallback)
 		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
 	else
-		channels->max_rx = 1;
-	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
+		channels->max_rx = rx_count;
 }
 
 /**
@@ -3233,28 +3242,83 @@ static int ibmveth_set_channels(struct net_device *netdev,
 				struct ethtool_channels *channels)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	unsigned int old = netdev->real_num_tx_queues,
-		     goal = channels->tx_count;
+	unsigned int old_rx = ibmveth_get_num_rx_queues(adapter);
+	unsigned int goal_rx = channels->rx_count;
+	unsigned int old_tx = netdev->real_num_tx_queues;
+	unsigned int goal_tx = channels->tx_count;
+	unsigned int want_tx = goal_tx;
+	bool rx_changed = false;
 	int rc, i;
 
-	/* Validate RX (and resize when opened) before the down-path
-	 * early return so MQ/range errors are reported here. Publishing
-	 * the desired RX count and CMO while down is the next patch.
-	 */
-	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
+	if (goal_tx < 1 || goal_tx > ibmveth_real_max_tx_queues()) {
+		netdev_err(netdev,
+			   "Invalid TX queue count %u (must be 1-%u)\n",
+			   goal_tx, ibmveth_real_max_tx_queues());
+		return -EINVAL;
+	}
+
+	/* RX range / MQ checks live in ibmveth_resize_rx_channels(). */
+	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
 	if (rc)
 		return rc;
 
-	if (!adapter->opened)
-		return netif_set_real_num_tx_queues(netdev, goal);
+	/* If RX resources are not live (never opened, or close+open failed
+	 * while IFF_UP stayed set), publish desired queue counts without
+	 * allocating.
+	 */
+	if (!adapter->opened) {
+		/* Apply TX first so a failure leaves the published RX
+		 * count unchanged.
+		 */
+		rc = netif_set_real_num_tx_queues(netdev, goal_tx);
+		if (rc)
+			return rc;
+
+		/* Publish desired RX count for next open() and refresh CMO;
+		 * do not allocate while down.
+		 */
+		if (goal_rx != ibmveth_get_num_rx_queues(adapter)) {
+			ibmveth_publish_num_rx_queues(adapter, goal_rx);
+			rc = netif_set_real_num_rx_queues(netdev, goal_rx);
+			if (rc) {
+				int tx_rc;
+
+				ibmveth_publish_num_rx_queues(adapter, old_rx);
+				tx_rc = netif_set_real_num_tx_queues(netdev,
+								     old_tx);
+				if (tx_rc)
+					netdev_err(netdev,
+						   "Failed to restore TX queues to %u after RX failure: %d\n",
+						   old_tx, tx_rc);
+				return rc;
+			}
+			if (firmware_has_feature(FW_FEATURE_CMO)) {
+				unsigned long dma;
+
+				dma = ibmveth_get_desired_dma(adapter->vdev);
+				vio_cmo_set_dev_desired(adapter->vdev, dma);
+			}
+		}
+		return 0;
+	}
+
+	if (goal_rx != old_rx)
+		rx_changed = true;
 
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
 	 * but we may need to alloc/free the ltb's.
 	 */
+	if (goal_tx == old_tx)
+		return 0;
+
 	netif_tx_stop_all_queues(netdev);
 
-	/* Allocate any queue that we need */
-	for (i = old; i < goal; i++) {
+	/* Allocate any new TX LTBs. i starts at old_tx for the free walk
+	 * below when this loop body never runs (goal_tx == old_tx already
+	 * returned; goal_tx < old_tx is scale-down).
+	 */
+	i = old_tx;
+	for (; i < goal_tx; i++) {
 		if (adapter->tx_ltb_ptr[i])
 			continue;
 
@@ -3263,28 +3327,50 @@ static int ibmveth_set_channels(struct net_device *netdev,
 			continue;
 
 		/* if something goes wrong, free everything we just allocated */
-		netdev_err(netdev, "Failed to allocate more tx queues, returning to %d queues\n",
-			   old);
-		goal = old;
-		old = i;
+		netdev_err(netdev, "Failed to allocate more tx queues, returning to %u queues\n",
+			   old_tx);
+		goal_tx = old_tx;
+		old_tx = i;
 		break;
 	}
-	rc = netif_set_real_num_tx_queues(netdev, goal);
+	rc = netif_set_real_num_tx_queues(netdev, goal_tx);
 	if (rc) {
-		netdev_err(netdev, "Failed to set real tx queues, returning to %d queues\n",
-			   old);
-		goal = old;
-		old = i;
+		netdev_err(netdev, "Failed to set real tx queues, returning to %u queues\n",
+			   old_tx);
+		goal_tx = old_tx;
+		old_tx = i;
 	}
 	/* Free any that are no longer needed */
-	for (i = old; i > goal; i--) {
+	for (i = old_tx; i > goal_tx; i--) {
 		if (adapter->tx_ltb_ptr[i - 1])
 			ibmveth_free_tx_ltb(adapter, i - 1);
 	}
 
 	netif_tx_wake_all_queues(netdev);
 
-	return rc;
+	if (netdev->real_num_tx_queues != want_tx) {
+		if (rx_changed) {
+			/*
+			 * Only meaningful once RX is live. num_slots is
+			 * embedded in the adapter and outlives the DMA ring,
+			 * so reading it at function entry is safe but can
+			 * return a stale geometry from before the resize.
+			 */
+			int rxq_entries = adapter->rx_queue[0].num_slots;
+			int rb;
+
+			rb = ibmveth_resize_rx_queues_incremental(adapter,
+								  old_rx,
+								  rxq_entries);
+			if (rb)
+				netdev_err(netdev,
+					   "Failed to roll back RX queues to %u after TX failure: %d\n",
+					   old_rx, rb);
+		}
+		return rc ? rc : -ENOMEM;
+	}
+
+	return 0;
 }
 
 static const struct ethtool_ops netdev_ethtool_ops = {
@@ -3951,9 +4037,14 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 static void ibmveth_poll_controller(struct net_device *dev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
-	unsigned int num = ibmveth_get_num_rx_queues(adapter);
+	unsigned int num;
 	int i;
 
+	if (!adapter->opened)
+		return;
+
+	num = ibmveth_get_num_rx_queues(adapter);
+
 	for (i = 0; i < num; i++)
 		ibmveth_replenish_task(adapter, i);
 
-- 
2.50.1 (Apple Git-155)

