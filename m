Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A94AD4AE
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361618; cv=none; b=iuYz8SdLZkc/S7BLe28yUGjGzkX99TUa9d8lWQ2bH2k+P7kTYfZ9VGy0CuimP1qgPaF9g6q/QEE8ToURDLPeszehJtNwVJiWq7O38qvt61fb0cz0D54LMxsv/7+VLBcTQuZisyRdtEMVmjWvLmOo6FFyYodY1tLC5Wrd7ZAggxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361618; c=relaxed/simple;
	bh=HvlYsEz4ESshxuCyT6W+PLPFp7nPXt1CHgG54z4LTDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHz4llPSjUJQj/Kr0zUHBthWCEd4ESMg/Kqo5HtzXpblRU90lE/BGEHE0ixoJr4k3DTtvao9bC92ukYcpGTD39Y8oHowPamfPoeHJbTYsc8Xq4BU8/WvIAT5degsxaSjDyiRt51TJHT4v/qx1HQs1Bkfdptjif32k+6kaj9qezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HwC7VFTF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HwC7VFTF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5J0t3853680;
	Fri, 25 Sep 2026 18:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QlHWjTXJQ8rGNla4r
	3a9jVTbDgwlszxBSywkgxh60U4=; b=HwC7VFTFtkAslWyhNxdoI9q8HeF3Peb1V
	wkzyxs1C0eLDadSu+3ESZZVg0iDY/+ZPv8QHhDht3HdcY8OHyaBNoEUBAsSN8oax
	8SoOeJ14xi5JqK13VhFIefJMBdM6k/JrT7ODr6mFj3VUN3XWe7O+HgnzACA/lJIg
	/9+Juj0fvf7icLxsLqGm+LuxHkLGxsRmxISgfjkeHD7p2yyDJ0IoHyNkpLpkQPAQ
	kKsxGjwBBDfcwe5eBHomwm3b7TgsGdjFoLkRv8Epgp9sl31WlgIDkfDgylBaBr+8
	J8i+nVjjWyvj9L12MR1VmlWMf6bxBCnfM0L0kif7YkaUb0ieP43fg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske28nfw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:40:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG36xY4184499;
	Fri, 25 Sep 2026 18:40:01 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qukd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:40:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PIdxau32965128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:39:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0886B58065;
	Fri, 25 Sep 2026 18:39:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5927658059;
	Fri, 25 Sep 2026 18:39:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:39:56 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v7 15/15] ibmveth: Complete set_channels down-path and mq_fallback max_rx cap
Date: Fri, 25 Sep 2026 11:38:50 -0700
Message-Id: <de05d82d2d02c021de1e215656d1302d2cd41c46.1790319558.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: j1xYvUlLrej1eQWKCwE7FpsG9t5YzoRM
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab6c003 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=QfwA01cfH_qfFI-V7SEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX+vCRbD3A9qpT
 q6tsNVDP5rhWujw6C3eqhEnUZEEob2IoTQu2ZV5FfDruBb2WYcwSL7H037s2xyci32tjeK2PN1U
 m2QsqHkPRx7Rpj+xoWuL90RcbTmcDW4=
X-Proofpoint-GUID: blmjP_EVP1f-2Bbek0Nl1AXY8AV5B0vD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX33taHjn01w7D
 21r1TAwEsFI9x8XdXPOgweYEwlH3YMHDmHHw7ihhWqZXbURNDTtz0suA51xKWpsV2uC3AUoWA8T
 aTGzXkqLz25xOdYb0h0J7dZFIIPIGaOwqn4ezIMBqFR1sLbFD9SZdYdnCTiVYrBRb17nTDWKFbc
 g5Dgnbl9Mt4agZXY4fP1BzXnwM+KRJtE76Ay2vuQQQrIPWNDg00ywytLSnsA1xSXti6bbZHTWN2
 JPBGev995xu7gF959SxXLPxnvR7Q/pvLWJQXGDSYFVkphjxqCHhCTH2LwOG+5LOgf1wQHq50xk/
 b999G5M3kSJwcbrRDokY1u7j3QCITBdETTvKsL+XrIY95zhAx51ZnPIOH6qRgtNzYyHvzhlZe9E
 QJhcpt+8yJs+/lCQcO75YFhM5muG5PYj7Np/mfxjoKI1YNDNHqUkcJ8Y8hShcpnddqBRrSyjJJU
 EZ35CregMbjyNzazBiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

Patch 14 wires live ethtool -L rx. This patch completes the down-path
publish/rollback and get_channels() once mq_fallback is set, replacing
patch 14's temporary -EOPNOTSUPP for an RX count change while down.

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
TX-only ethtool -L into a silent RX shrink. Advertising max_rx = 1
while rx_count is still live fails the core the same way (rx_count >
max_rx) and blocks that TX-only request. Capping max_rx at the live
count blocks growth without misreporting what is configured.

max_tx is at least the live tx_count. After CPU offline,
ibmveth_real_max_tx_queues() can drop below real_num_tx_queues;
ethtool -L resubmits that count and the core rejects tx_count >
max_tx, which also blocked an RX-only request. set_channels uses
the same ceiling (live count or the online-CPU cap, whichever is
larger) and refuses only a request above that.

i = old_tx before the TX alloc loop is readability; the old
for-initializer already defined i for the free walk.

Guard poll_controller() with adapter->opened so netpoll cannot walk
unallocated queue state while closed.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v7:
- refresh the TX-fail RX rollback comment
- get_channels max_tx is at least the live
  tx_count; set_channels uses that same
  ceiling and refuses only a request above it
- lift patch 14's temporary -EOPNOTSUPP for an RX
  count change while down
- noted: get_channels keeps the live rx_count;
  mq_fallback caps max_rx at that count; do
  not advertise max_rx = 1 and do not clamp
  rx_count

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

 drivers/net/ethernet/ibm/ibmveth.c | 170 +++++++++++++++++++++++------
 1 file changed, 134 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 1b1dd89dadf7..da14c6915211 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -3399,15 +3399,32 @@ static void ibmveth_get_channels(struct net_device *netdev,
 				 struct ethtool_channels *channels)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+	unsigned int rx_count = ibmveth_get_num_rx_queues(adapter);
 
-	channels->max_tx = ibmveth_real_max_tx_queues();
 	channels->tx_count = netdev->real_num_tx_queues;
+	/*
+	 * Never advertise max_tx below the live count. After CPU
+	 * offline, real_max can drop below real_num_tx_queues;
+	 * ethtool -L is read-modify-write and the core rejects
+	 * tx_count > max_tx, which would also block an RX-only
+	 * request. set_channels uses this same ceiling.
+	 */
+	channels->max_tx = max_t(unsigned int, channels->tx_count,
+				 ibmveth_real_max_tx_queues());
 
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
@@ -3416,9 +3433,8 @@ static void ibmveth_get_channels(struct net_device *netdev,
  * @goal_rx: requested RX queue count
  *
  * Rejects rx > 1 without MQ firmware (-EOPNOTSUPP) and rx outside
- * 1..IBMVETH_MAX_RX_QUEUES (-EINVAL). An RX count change while the
- * device is down is rejected (-EOPNOTSUPP); publishing it without
- * allocating arrives in the next patch. When up, apply via
+ * 1..IBMVETH_MAX_RX_QUEUES (-EINVAL). When RX resources are not live
+ * (!opened), only validate; do not allocate. When up, apply via
  * ibmveth_resize_rx_queues_incremental().
  *
  * Return: 0 or negative errno
@@ -3461,14 +3477,9 @@ static int ibmveth_resize_rx_channels(struct ibmveth_adapter *adapter,
 		return -EOPNOTSUPP;
 	}
 
-	/*
-	 * Down / failed-open: there is nothing to resize, and publishing
-	 * the desired count without allocating arrives in the next
-	 * patch. Refuse rather than report success for a request that
-	 * would be discarded.
-	 */
+	/* Down / failed-open: do not allocate. */
 	if (!adapter->opened)
-		return -EOPNOTSUPP;
+		return 0;
 
 	rxq_entries = adapter->rx_queue[0].num_slots;
 	rc = ibmveth_resize_rx_queues_incremental(adapter, goal_rx,
@@ -3482,28 +3493,90 @@ static int ibmveth_set_channels(struct net_device *netdev,
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
+	unsigned int max_tx;
+	bool rx_changed = false;
 	int rc, i;
 
-	/* Validate RX (and resize when opened) before the down-path
-	 * early return so MQ/range errors are reported here. Publishing
-	 * the desired RX count and CMO while down is the next patch.
+	/*
+	 * Same ceiling get_channels reports: live count or the
+	 * online-CPU cap, whichever is larger.
 	 */
-	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
+	max_tx = max_t(unsigned int, old_tx,
+		       ibmveth_real_max_tx_queues());
+	if (goal_tx < 1 || goal_tx > max_tx) {
+		netdev_err(netdev,
+			   "Invalid TX queue count %u (must be 1-%u)\n",
+			   goal_tx, max_tx);
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
 
@@ -3512,28 +3585,48 @@ static int ibmveth_set_channels(struct net_device *netdev,
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
+			 * Restore the RX count from before this -L.
+			 * num_slots is the live size after that resize.
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
@@ -4203,9 +4296,14 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
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

