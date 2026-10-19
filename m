Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792431878;
	b=22uhyR6TZ64k8vGYTnx/41X+Lx2CIHkbi0jhnhv3/CVXMInX+3Ty0OCSrWc8w3dsjst9
	 +Rs9B8wqbNAs4TEtYs6+o8/KAgOMWQ8DW56uFK/wgszQ1idGkC6ItNT7Vgv4RABnEo2Ox
	 dSOAHB8rlKptR3u0qN1jhEwqJzF/NjIIODBnsCqdFWPlB65CicuFA5mTY77xSxfRG83mQ
	 8txdL0v96tPyTlOA6jWuawfE+sJsM0PjTRBYnziRvlt4uz8L5cTTnnABGcNNQQFaje1tZ
	 RO831NdS1nWCUgK3K//Hdxssq+iu6tYbHPSYbnHgrTKD4C7pZNPkA4yNnbg75+nNmRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431878;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Ebub4Glm0UQAFutNFg75rpD+4F59oa3DG017EF6RVgI=;
	b=OzL9IefXZHldKI3uMLrPP5qM/yuFYSHo7jc/dbGQ4GQ0eCthYxB4v6vubsA/MYYKsAqj
	 s9g6F7EvgJ+X+uxTjj7gdnOSxtWwAQsYKerouIc9h8IpIJJsVyVOPyHTWSXQ2v2ueocol
	 /BihI5OpFm1MNLV+4nKS8nyOfgt4NgdMs+wJvG6hcA5yVAfRLryB5bPmLa8Rf9fmC0whS
	 gF5diJkB3a9q2lAQFH+lPS+CSeiodpO4FMb15T2A0we/jGuyGN66Tn5z16GJGAxPHOF9l
	 uNeWGeUA4p/Rpg1w3t6XGLYri4kkm+j7B84WRtWHuZ+3CLPEm+Ge4L1IOqSyivjfXWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nLzTeS6F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.55
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BAD606A31F;
	Mon, 19 Oct 2026 17:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65BAD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nLzTeS6F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChncifsfmjEx76YBuAOIvVipj/Nlq1j5DyaM3tp25HNdA3GESEshYjkWKwKYjyc1VdwRHcuZ5O3+PKiasbep80unZYbLvnTyThNDeigaQS+wAJJlF5lU+ZOx1bPjo35XVpal7+L+x6Uobpll5AVV7+nhovLvj24On2mGsf8lmbRcQEeJ0+ShLQBik7Q/bNt/Y9HhGFsdhfRFl2JIkVMprQT1Qmyqa4Uexk8wliqXxpYIvbOqyGUxYkvfvCNxHG3mim7J/c3+v4uZinFpzdPlVclugoBE2ENPQXti98uw9ebGzqzDEIqhdlPCYI6T7U1o4nthfcGyBd2v98rVXlVz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebub4Glm0UQAFutNFg75rpD+4F59oa3DG017EF6RVgI=;
 b=JnkIroQt8EWTmKFtE9yIoSjKVXdkQUia/+NeRcH5fQpdQHtcK6WefN9/sS0kZvI1a8gzely8OHX2UELNrmL1HkZfYia762VriIaJk/DmlqVp8hSgLpU+07OVFhCOsKLlLUHzCSlfhoSyMw5JyblyYv+3biuemaEYKAZdYlKzcDzVkQooOQk7/wv9Iz7nM3YeGSgJ0UzKmQj+JvqiSELMRd2uQtGBsuXPzL5mHPSQihu2EdaEDihfs+weGpr820MxpiMWLSQ/wlh83n7MluYYxH4lEXgkJ7FhC6vwpZxF5ecqPWN72Tf4fTUil43zwSQLWcemLGIKvlKiiYExA3g7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebub4Glm0UQAFutNFg75rpD+4F59oa3DG017EF6RVgI=;
 b=nLzTeS6Fkfw2V0cN3Eml3oNQIRL2t+nWUw2fbi+/dnAyDQsdR2ZQtXbS1FiR8534p1GC50yn70jXpKUTMyVUgbnf3CyO3bq7nqI1Sk0BhOOpFG/rRehwyhTiOwFp85hRrmh/3FimiVBFEDEvEVvm56Oqs2M3bcSW2sOmAtWgeKcXUiRKp6mv65UjOSV/DX2oOEVk/rLmnJlgU7CNfc4BauvuItypn6OXR3mZ3BKdgUMVt3Ix2TuIDlvQGHT36HsNQ5xpDQPAHUm/KTafoxcnSTPJkFcKyS/a67oLqxFxhZ1g/qKU3kZFhgPVlnb9ZIfLmpnXfHPmcEVWZYCW0QYSew==
Received: from SJ0PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:33f::31)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 17:44:34 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::66) by SJ0PR05CA0056.outlook.office365.com
 (2603:10b6:a03:33f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 17:44:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 17:44:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 19 Oct
 2026 10:44:12 -0700
Received: from fedora.mtl.labs.mlnx (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 19 Oct
 2026 10:44:08 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH v3 net] net: skbuff: don't copy alloc_cpu in skb header copies
Date: Mon, 19 Oct 2026 20:41:52 +0300
Message-ID: <20261019174152.2932829-1-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: a2867012-0e19-45a0-f24b-08df2e08a320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IOomV/DCEdcktDtP4NI4FQtRNNJIT/reubTN8Fdy8AqMOesZVI0vMzfGd2C+SsoU8per4yBYkF4oiXDq3rB5QpgQvpdEMwUeEAfTBA97fFFRiCvKa+QnRAIl+VsDHLVKsMmdWnbaWxiSt3FEVr02DrqCrJ13+yocvBu6N9OtLVrQDuBLPQoaYOV3RT3okORZpHaNDnFllcD48vTGukXI+hFxuu9v2Ifr/a7R8xSKaVvwPOJFT/LXkFmEz5UDN+Pui6+AUR4/FfoTaAoJykSD7ra57UHJzikLgQe0HPqSq8owTQcKBQgWC1AxjqEcFDg5PY5QdtABzqhyxk0/6NnhlBWgFeGe1nTcSuQ4SgRdI5f1v18Kwj5NDYJ4fw9aiarIjfuKtZCiyz5uwS+M2KHnG/+c8wcVQd30Uk56fnoZgjHUioaPY8kvjZRBciUdMnZPxNUtNWFmwiSaU0/uyaWFOt8on5eCZcr1GA05AZ+4ORMxu32gXDe2Gc+1n0gYUWleTY138CirPDCW5XdHAzfnmvmC7nbJJhsF2DYsztUZ5DvSkYUvPpq7pmSoXNwNB1710E2xdlciEmXuWGD3mwM/0DE36CZNv2BJvyjQLWaRt35iwKr33iMueJPFjLTFpB8rJt2XO2kbVSFFpCHk+wXYGRhh6J5Wy4H5HgH3VGqUxzxV8aXbBBIOQHeaZ5HlMsROOzeG3mqJM1WLtc59NOQthw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LNkoJb27+jtITbI13ObnMeNTTGEe0ptaAlw+Ok9TSEyNFYM4cngqpyTbefRE4kCfdUDiq5WDhfyl3ukee9utu48bwt89ex3piIOHW1c0Ph8AkJrSxUj6thJIN+UOrQIABfCwb+VoTBWQtvPefghCtPkM55lE0tuEUGrwOQInVb2Q3BPeW58vPPXYOWI/duzVR+heFcfL3xEmVeSKHNsLrJAGtuNP+P0Cf+6lqOHixULUJPQmwg4MNKzUxJMPkt3lpsLjU/Z/Z3FM/8QHMPEhgmgNUhbrnF8dsT8jL4QsdtucolZGzUQ0K7BE+bK9Rfrce+h9pftoN2qQdReMk6fE9wBQ80IYDp0BCI9YqDIERC2hIHqwNrDP9ejwj8xWM7YLNfTeGYprvHM9mTe7pEpiSbirxQjnfeluEhkkTtAK8AxjlYYE442EPmYvHyl/nSlU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:44:34.0110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2867012-0e19-45a0-f24b-08df2e08a320
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

Commit 68822bdf76f1 ("net: generalize skb freeing deferral to
per-cpu lists") added alloc_cpu to struct sk_buff and placed it in the
headers group copied by __copy_skb_header().

This is wrong for newly allocated skbs. For example, skb_segment()
allocates a new skb and records the current CPU in alloc_cpu, but
__copy_skb_header() overwrites it with the value from the original skb.

If the original skb was allocated on another CPU, the segment may later
be treated as remotely allocated and unnecessarily deferred there when
it is freed.

Move alloc_cpu out of the headers group so it is preserved across
header copies. Copy it explicitly in skb_clone(), which allocates
the skb object directly instead of going through __alloc_skb().

This was discovered while investigating a throughput regression with
software IPsec. The load used 512 IPsec tunnels carrying traffic over
VXLAN, with 512 parallel iperf3 flows and an MTU of 4500.

Before the fix:

  16.09%  queued_spin_lock_slowpath
             |
             --15.90%--_raw_spin_lock_irqsave
                       |
                       --9.37%--__slab_free
                                 kfree
                                 skb_release_data
                                 napi_consume_skb
                                 mlx5e_poll_tx_cq

After the fix:

   6.84%  queued_spin_lock_slowpath
             |
             --6.57%--_raw_spin_lock_irqsave
                      |
                      --5.00%--__slab_free
                                kfree
                                skb_release_data
                                napi_consume_skb
                                mlx5e_poll_tx_cq

Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lists")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h | 4 ++--
 net/core/skbuff.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
---
V3 log:
- Add a blank line after alloc_cpu to separate it from the tail-end fields
  comment. (Sashiko)
- Move the alloc_cpu copy in __skb_clone() next to the tail-end copies.
- Change "Initialize" to "Copy" in the commit message. (Jason Xing)
- Remove an extra blank line. (Sashiko, Jason Xing)

V2 log:
- Move alloc_cpu after the headers group and fix the indentation. (Eric Dumazet)
---
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a3ff380d43f01..d6894f463bf43 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1036,8 +1036,6 @@ struct sk_buff {
 	__u16			tc_index;	/* traffic control index */
 #endif
 
-	u16			alloc_cpu;
-
 	union {
 		__wsum		csum;
 		struct {
@@ -1088,6 +1086,8 @@ struct sk_buff {
 
 	); /* end headers group */
 
+	u16			alloc_cpu;
+
 	/* These elements must be at the end, see alloc_skb() for details.  */
 	sk_buff_data_t		tail;
 	sk_buff_data_t		end;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 41beaf625421a..ab178af02a226 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1593,7 +1593,6 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	CHECK_SKB_FIELD(napi_id);
 #endif
-	CHECK_SKB_FIELD(alloc_cpu);
 #ifdef CONFIG_XPS
 	CHECK_SKB_FIELD(sender_cpu);
 #endif
@@ -1625,6 +1624,7 @@ static struct sk_buff *__skb_clone(struct sk_buff *n, struct sk_buff *skb)
 	C(pfmemalloc);
 	C(pp_recycle);
 	n->destructor = NULL;
+	C(alloc_cpu);
 	C(tail);
 	C(end);
 	C(head);
-- 
2.38.1

