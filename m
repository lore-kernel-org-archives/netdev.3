Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6A373C00;
	Mon, 12 Oct 2026 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809303; cv=fail; b=K5Z8mpkMZydg9SdKCbos+LDDOzHuuhRxJT5bMfQQ4HZn11s5S2fOYTe1jWg83UT09fBAExDVM0eDwXRGd5jzRcQN/mqYR4EibyQjIxN0lwLOW74R7Bqzfez1ZAcuZ28YB1gShI0gWILpGg89OuqU+6EOsk18SDr61C4fm5mquso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809303; c=relaxed/simple;
	bh=7kjJlbuqAgIsOuI2QPccF+4s6dvDYaaXlNUOf/B0jwA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qZJ02kxLzmFj8PJI7b3GkevG9kY7XrDinolQlzz+ugdlSxtVgRLS4B+K08oTvk4ge1oIzatknTFBsq0OFm5jeCpSy2BYvBj34x5JX9YiUffaBXB5Ek3fYBBpK3mSRQpB+JhJkEDzM9abgk3sc7hL/z1qlccOoa9u58CpOGcSGKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gQmPHp60; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gQmPHp60"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5Dfv53QgDiHlejtgbQYjA0uCpFuZavrqZZ+6qaNHnf3Q7XWqPltArx1wreru6KWWFxQ4QVXycTB9o+hGJwheIPodChYEzNF1URyKNvjsqYrL6HNxTgfX4KcxsGoZxrPTi1aZ96MS0LlUh+2k17YkwQ5HCL+WJJ8zqLWgheVB4hwkolxx0U3kWvcoh4Ibg7XAZDvLa9lto4ky+uz4ik31Uc6R3X9q96B0YVUzyw/Sci7f4HKUgZhOpOYSMTuDnzy6qP/6+bx2ZLGkQX8XjyqvhoDFEmNdTb8m9nUGrktziCWXbWM5lx/67anNnv/CXrTGsv0pm803FXQ9nDWp093SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSjMzCVunffm+eyzG38DLmq1zd6A6lVJaTscM1Acepk=;
 b=wEhNByZtAZlQVWAZdYFQp3OasATuVjpOcdAnrfQGG53Jzc+5//LnzhmnFUykH98eSunM5yxYPDUvlV3WvNxyDsfhjttbvo4jnxYfVPSktOZtNrgFcsT91x9Q9aC+nvnkP4grwK0EQKZNIhcp0oZ5yoRx8M6xP+H6BwsD3ASRAzILG4Uk8mikyuaZ7H9nvwE/YXihC/ROW9FQkh11U8ZsTaisxxY3WllZcTlskJZgflREZPrrBZgd3uDDYJx/M2uPuAx8mwx/nlC76t4WZ0oTP/8u8NTDd/xlsld3JECwpJXuU6cV6xOaxHaK+7GYxDW47lJkXTtbJAvQT8wjfWg8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSjMzCVunffm+eyzG38DLmq1zd6A6lVJaTscM1Acepk=;
 b=gQmPHp60hKANHXMIuqQ4vWn1MHAQt2L0glQOLb5sYfj5qPyLWpG9QzgIiHla94pYgFUilv93ql7bZ58SNonSHXoXLJs+pvHP7rk0FV2Wt57JirsxvDlujS363N6+3uf+iTUuWuWI9ja/14oy6l0CHmfBro/9Mb7k+9Df9tNpvv6m1/eeJ3ohREEBseWrS0WklnFUmvbwcgBMCrZWpqayGsljrWNLFUFM7J8yQX71GPFgIJsbfGTriQzj/5eLnBhb9JbxcguJY4TIAYGzgfClN173szx8m+EcHRaZ+gNEcZMZOuK/pC71DA8tXObwcbObgfI1e/z522MdFbh0hbcSRg==
Received: from BN9P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::21)
 by LY0PR12MB320750.namprd12.prod.outlook.com (2603:10b6:404:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 12:48:17 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::33) by BN9P222CA0016.outlook.office365.com
 (2603:10b6:408:10c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 12:48:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 12:48:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 05:47:57 -0700
Received: from fedora.mtl.labs.mlnx (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 05:47:53 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=
	<bjorn@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net] net: skbuff: don't copy alloc_cpu in skb header copies
Date: Mon, 12 Oct 2026 15:45:44 +0300
Message-ID: <20261012124544.2018007-1-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|LY0PR12MB320750:EE_
X-MS-Office365-Filtering-Correlation-Id: 1813b293-8f08-43a0-f7b1-08df285f161c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|23010399003|36860700016|56012099006|260925021911599003|260925022911599003|260925021311599003|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4kys1ufcwv3WJQ4P4ys/AekIwwJtuM5YBia2/o4T1wBFX5FOdjxFYI1mkzaT0QeqbYXJ8qbMs/5gTHnpEGE/uozzATnzGWGMAcJA4rKURGxc6b0HIQfR/NwycZfUs2dI1STACe9tiQfDhIrgWN4+kMI6WyWgmwnBffA1Am7YiD0FROG61jjBAmV1eHFUmlVMYQKpZKNd60MJ0PyTUIjFnUwhytAM4eaFg2D+j/obA/gK0xN23AEuOloTQtz3qtqc8tg1w/NKdjB/VyCmhg2lAhcgLqHQGlGUCdr+3fYiWq3hXv6l1+A8VWmlsifnOsMv9JplDC0sYF+imXEjCM9VCeh5vPdZatQpO6hUCmNktiQMRFsbdtHkxNhRQ9FuPTbBbvaVJgrsl6VQxl9Dahe4FoRn8RxubOsAWWceuVnRr7VX/GQk6/8mMumyvuLOZ6g+zb2qIeGu8aC6qkM4evc6KZaoMHTmJbCjiGNBefCZmcXG5ZFfzcWdll/uZEEwzJWERq6TVZq64v+0Hur9fmxUPPmfEMc9kFmKT3HjYLFsC7S8yMv4xd6zmu5BBUJphGugYsOrshHiR+sE4ePvKai56cAENy9fIym3iTtxvnS4N5nw7j7tdeR9VDR3fE2YgbMw+NGFEQRNrqDTQkE1ZKDpwB8N6dQwXHfWlj9/1lWoWSKWprXuTcvMczebCYroALaU5C/vlRfm//RokSiWU+NY8g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(23010399003)(36860700016)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2OkVeg2kl/5Bul3SOlTk2DsyZ2fDnwKvNXjHFwP9J7OXxkM3pUt9bwavWW8rx3pJwm1DCogGbm+JkAuWQdzj3jBMqZKZ4A6FMSGLG+oP8CU1ngcRnNW0divR5uTTS+Rlgot3XvrBULZeGexhjlCUyNtEW9zBdUWXpxhgnQLzO/r9H6XknWF1msjqktTPt/dm5uyyn9Td56Yovfgy15qprx+huG/ok0b7dolvYrPA7T1ThSvtaDOdtceGym8O3B/TvesmT3RfVf9e736LiXlsr2igy0EzARL5Rbkt71nZm/29xx4A47QAViRTBLY9y1pZwkkhSAFRFe4jHNLsIv3s2KAj6BsIq1UpSud06QEIkQCzJP5NkPm3y8GxJNVP/b4D4ZFQ/zgeSiSCDEXNj4gAUWctWa0n8xl6aGkociI37BiGlPtQQMZr4mZQxCrrYCJT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 12:48:16.6049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1813b293-8f08-43a0-f7b1-08df285f161c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB320750

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
header copies. Initialize it explicitly in skb_clone(), which allocates
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
---
 include/linux/skbuff.h | 2 +-
 net/core/skbuff.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a3ff380d43f01..2d5277765939f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -963,6 +963,7 @@ struct sk_buff {
 #ifdef CONFIG_SKB_EXTENSIONS
 	__u8			active_extensions;
 #endif
+	u16                     alloc_cpu;
 
 	/* Fields enclosed in headers group are copied
 	 * using a single memcpy() in __copy_skb_header()
@@ -1036,7 +1037,6 @@ struct sk_buff {
 	__u16			tc_index;	/* traffic control index */
 #endif
 
-	u16			alloc_cpu;
 
 	union {
 		__wsum		csum;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 41beaf625421a..3d82eb87f4582 100644
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
@@ -1618,6 +1617,7 @@ static struct sk_buff *__skb_clone(struct sk_buff *n, struct sk_buff *skb)
 	C(len);
 	C(data_len);
 	C(mac_len);
+	C(alloc_cpu);
 	n->hdr_len = skb->nohdr ? skb_headroom(skb) : skb->hdr_len;
 	n->cloned = 1;
 	n->nohdr = 0;
-- 
2.38.1

