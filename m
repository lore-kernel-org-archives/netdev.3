Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74C3939D2;
	Mon, 12 Oct 2026 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781566; cv=none; b=lVmAtEqttvuDIwmsSkiuDsautOsAr1SDoVT93YbIfyNv+x+O3h05iTt2yYneNIEAkYGaCDx0jygeEHQot265mGjfYoLTpy4jZ+7/n4HFM8ZzPUsPQhWVV47Ic6UcQW5PfZZ26DqN6OP7jQ/t70YAtRm2mWC3ZUsHYTcfDtNZ/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781566; c=relaxed/simple;
	bh=OrLsXn9uYnPprBTazk/p3P6XHUxlu0qYlEbf42K7tmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cD3HdqgS0OwS6FaAeT94BteEN5Dm3CNiAavQIlQOH5oAFDB9Qx65tjnvTrg4nqM3n5DT5lxr8GSBrF5+3Kum99flmD4yGwirZVJmWG0e2gWL34KxPUL1ojlMBNERna0HWIcSdsGsRVG6iCZm4ta36LKk7E/uBLRwMpkla8FKAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PaPtx/ak; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PaPtx/ak"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2F1BC2913783;
	Mon, 12 Oct 2026 05:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RgapHiZQhB+FyBulk
	gR5Ji7QSU1cb3+YnNv/3b5rlpQ=; b=PaPtx/akR6brIZB0Vz8YticHiKcvQw/7k
	we+8ixjqSGjYFrjFsoL+p0V+MI2V1SKpkUnCKF1+ZvKfb1E8N9sLwjXu7oUomU6B
	+G+oNk1EMWMDuhdIUykrywQDkwLw+WSwfIB2URgnmMWcj44a2kY9HVH8mI6igmha
	oEF4LPFmPi/n9Z9jm7+1qL6BEbX92BIyvUWnO6mqZxonEfwOdVZ8hor3YOtGVQTQ
	rYPQSE5zhkC3c/FyPcGugF8oD7Miw51pwMlMH/hw2VNn+f9ACvNTcT7mXKENhN/t
	KTwS6aj2bi0ciYWvGNwpXkRQBR/6/wSoSmbkX8aSU5dph2O0kCUzw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhpyqh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C550uM754998;
	Mon, 12 Oct 2026 05:05:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppkx1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C55YSW34275900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 05:05:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E508C58121;
	Mon, 12 Oct 2026 05:05:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0BE75811C;
	Mon, 12 Oct 2026 05:05:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.163.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 05:05:30 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, jeff@garzik.org
Subject: [PATCH net-next v4 2/9] ibmveth: do not close twice after a failed reopen
Date: Sun, 11 Oct 2026 22:05:11 -0700
Message-Id: <20261012050518.88858-3-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfXx+u/r45bSAVN
 5xI5mwwelf6Sm0NAAvmpVsonhzIU53R373rCnlAFyY5ZsyUsnZ7mVsPqCS38gcUKtI4megl8ioR
 kuTXqhKxpoVZb6ZynL+WFoXhfMhLn7cItC92xgI0L1RSFwbXFiuW9QTbWyI6mjFQTNCnyUiGu8H
 +mJUQEd7Thy6zS/Mah0z9lsH1NPjjKFZtkx9PcqFjCt5tDYcCc07zBhtuK09+5HUIUh8zsg/f+X
 FJA1BdWCc5QZEJY+pCs7L1kP0ZRqGs+L1uzCJ90njtiGTxTt7i10wCJnOWxxAloRKMrQgSEH9bN
 QuARhaTpe226GkoHm3blDdGFsqnW+UfPjHOitvBpSTbU7TB2kWKiycCiGqo2Tdk24ziqEv5/meI
 ZohKjZ77Sl76guwX42MYjx5DSI/fZZ5lFUBEfzEPmjf4kZB5Rn3joK1I/A+wUCldDdCriI2lrO6
 nvtwQKjKzTv1xXsdxnQ==
X-Proofpoint-GUID: Dh1z_peKRb7Kl9KTctAQFcHl1P6gZwzS
X-Proofpoint-ORIG-GUID: UypN2xjaLoTrF5apJRDUhYqN5t6JdwPm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX3IbHtH99aWM4
 SVPDmNk91xaZejU28HTay6GRBeVp27GS1NsyF1Pu6RBfkoMHvRZ7cnpHrm7FO72eR0YMPipWjhH
 fDFwguKzafFsT6cHWYwrdJ21+bbo8Js=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acc6aa1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=PY5afY-jqzY7CZaCxLEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120018

ibmveth_change_mtu(), veth_pool_store(), ibmveth_set_csum_offload()
and ibmveth_set_tso() call close() and open() directly. If open() fails,
NAPI is left disabled while IFF_UP stays set, so the next close()
(ifdown, unregister or another reconfiguration) calls napi_disable()
again and waits forever with RTNL held. Networking and shutdown
hang; only a reboot recovers. ethtool -L in that state also wakes
queues that have no TX buffer and dereferences NULL in
ibmveth_start_xmit().

Any open() failure on those paths triggers it, for example an
allocation failure on an MTU change to jumbo frames.

Track a successful open in adapter->opened. close() returns early
when it is clear, and set_channels() checks it instead of IFF_UP.

The open() error-path leaks were fixed separately in net by
commit af0524bf4ce1 ("ibmveth: h_free logical LAN on open-fail after
register") and commit 84bec0bf0352 ("ibmveth: fix TX LTB and filter
unwind on open-fail"), which are now in net-next too, so a failed
open() no longer leaves TX buffers or the logical LAN registration
behind for the early return to skip.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection. Tested on a POWER10 LPAR with
ibmveth_open() forced to fail by a test-only module parameter (not part
of this patch): 'ip link set dev eth1 mtu 9000' fails, then 'ip link set
dev eth1 down' returns at once and 'ip link set dev eth1 up' recovers
the interface. No kernel selftests cover ibmveth.

Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v3:
- commit message: the two open() fixes are now in net-next

Changes in v2:
- commit message: say what a failed open() leaves behind without the
  two net fixes

 drivers/net/ethernet/ibm/ibmveth.c | 24 +++++++++++++++++-------
 drivers/net/ethernet/ibm/ibmveth.h |  2 ++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 4a5869183be6..4665447997ea 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -739,6 +739,7 @@ static int ibmveth_open(struct net_device *netdev)
 
 	netif_tx_start_all_queues(netdev);
 
+	adapter->opened = true;
 	netdev_dbg(netdev, "open complete\n");
 
 	return 0;
@@ -781,6 +782,14 @@ static int ibmveth_close(struct net_device *netdev)
 	long lpar_rc;
 	int i;
 
+	/* change_mtu, pool sysfs, set_csum and set_tso call close() and
+	 * open() directly. If that open() fails, IFF_UP stays set and
+	 * NAPI is disabled; a second close() would hang in napi_disable().
+	 */
+	if (!adapter->opened)
+		return 0;
+	adapter->opened = false;
+
 	netdev_dbg(netdev, "close starting\n");
 
 	napi_disable(&adapter->napi);
@@ -832,10 +841,10 @@ static int ibmveth_close(struct net_device *netdev)
  *
  * @w: pointer to work_struct embedded in adapter structure
  *
- * Context: This routine acquires rtnl_mutex and disables its NAPI through
- *          ibmveth_close. It can't be called directly in a context that has
- *          already acquired rtnl_mutex or disabled its NAPI, or directly from
- *          a poll routine.
+ * Context: This routine acquires rtnl_mutex and, if the device is open,
+ *          disables its NAPI through ibmveth_close. It can't be called
+ *          directly in a context that has already acquired rtnl_mutex or
+ *          disabled its NAPI, or directly from a poll routine.
  *
  * Return: void
  */
@@ -1129,10 +1138,11 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		     goal = channels->tx_count;
 	int rc, i;
 
-	/* If ndo_open has not been called yet then don't allocate, just set
-	 * desired netdev_queue's and return
+	/* If the device is not open (including a failed close/open with
+	 * IFF_UP still set) then don't allocate, just set desired
+	 * netdev_queue's and return
 	 */
-	if (!(netdev->flags & IFF_UP))
+	if (!adapter->opened)
 		return netif_set_real_num_tx_queues(netdev, goal);
 
 	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index d87713668ed3..3f2240823f6a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -172,6 +172,8 @@ struct ibmveth_adapter {
 	int rx_csum;
 	int large_send;
 	bool is_active_trunk;
+	/* Set by a successful ibmveth_open(), cleared by ibmveth_close(). */
+	bool opened;
 	unsigned int rx_buffers_per_hcall;
 
 	u64 fw_ipv6_csum_support;
-- 
2.50.1 (Apple Git-155)

