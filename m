Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E8522F00;
	Tue, 13 Oct 2026 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907198; cv=fail; b=BTXzOzXLO15HuWTDZEEToeVMdCzJZDSFigoQgV+ex7m2HDfZwXsZtSGJX0H8VNkgaZwoNfm0v5jGIp1VlRInOgQkrqVEq/214iUY9tDRlDbG6v/5HV3f+Gcb2zlRXx1UkDp09g94ggyiUfXx6pUcDaSk0DJd5vyqV4YeHHaZX1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907198; c=relaxed/simple;
	bh=ggrcxLwqB6g+x2eyYcbFO1lgZ5+RePES7zhIYmtT3F0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8/jae05LWHDpbmYqZU0Zv8gPmxnTvfLId1cVMrkw7pCtOvNRvhUsrxUha/ArDcMfSJOCSGME/eJaumFVemITR8DaYNAXT5hoC2JHSveEJ2MtgL8parkY7iiOpG95AJYNMa0WuKsRaipJhYww4FPx3Xi+O6JR2v/3jqr39qeuHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=plPTjPVA; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="plPTjPVA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0/BToGROC6L1Djjt32QoBua3EA8vvDfraP+KNapb/dsedfySKojbOW5bdhZhj3+ituDHjnZYKX1UTjFhjViZisUNC50kMpR2yClUPd9pBogyCZdFNUwgl2Th3mkDjH35XX4ox4qFIY/jAGdjULApb1NnigHS91U8CrVyQ+ko29TBSNaW0cWzZ+Or8aKAhFFjxDxgmLwLC4MLTmAev3MVSmFRUtDJtxseWxcnBDNXcdfQ+cTHrWPMaachsGQ73BBoI4547h86YSmLpnbjhzBibo2Q8lBwceiy+z2F5Rz58lMEkU/aXDvdxN7VhdQM8KAqc2cyOyrWeHiLza493yOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6MB8aGvnihfNcpJTG3+BUF44AKq9dps1HUbSrVK940=;
 b=bksiDjxVmeBWG22Z8v+0X+lDAfWUhiHZaxXcR86WXMa5o1XfzD0M4d8L0Cgc/OapEUJ8wO0KjOkKGriBjNtjybQfx9kF8IgFztdYslQN3uIf1DWVhg26BipSsZd5jfgYQFS7OVz3+haGAlZ4uDoXhFqTB0ebOZd4L2jkBQp6i5+7tNQRe44JPEe7SLNp9JxlFrHfC1V6XcRS1dVpYQ5bzMv5cd1YGb8YEFbttRrYFeAxrNUkljFDEravmr7xA6TRbcbFwDg/FA15NvmX8TPs2ONUD2oDZL8Sv0Z/R5lMmDLn/tgq7DMl17RHaoa/31UX3Jm8hpoqtnPpREHheuq5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6MB8aGvnihfNcpJTG3+BUF44AKq9dps1HUbSrVK940=;
 b=plPTjPVApbFPTHamwKRvyS37m1OssGoAr4KCA00y+KGr80l9rQs+/Z9F6HXAOpRnLNohWd+w+K+bJ21mw01xMowDWhkMT9PmALgHDxwDn0k2TZKNWrpaQIBikFYrAPad1jZk6jAAZ+OenFgNPaVOLh+B85usEZ6DUeYmNEAkq1aPSxzBMeOnx6Pm9y1LT8qWAsrLAQXLEomiMi0IcKKhyNd0amxmGRbKjZn0cyi1jFHzjrm3UT0XlzCIvhrAItOIHYal9Zv7WkPCUbcpcf7AREm95e0Flql4jO+mV2/dkW8e7xTBCIhKu2BJv2OZRXD7bg4/3F+Ki3R7N4zsXu0uTA==
Received: from CH0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:610:77::35)
 by SA3PR12MB196577.namprd12.prod.outlook.com (2603:10b6:806:533::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:59:53 +0000
Received: from DM3PEPF000265C3.namprd03.prod.outlook.com
 (2603:10b6:610:77:cafe::7a) by CH0PR04CA0060.outlook.office365.com
 (2603:10b6:610:77::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 15:59:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM3PEPF000265C3.mail.protection.outlook.com (10.167.23.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 15:59:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 08:59:25 -0700
Received: from fedora.mtl.labs.mlnx (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 08:59:21 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH v2 net] net: skbuff: don't copy alloc_cpu in skb header copies
Date: Tue, 13 Oct 2026 18:56:58 +0300
Message-ID: <20261013155658.2196020-1-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C3:EE_|SA3PR12MB196577:EE_
X-MS-Office365-Filtering-Correlation-Id: c31935bb-1e56-4a64-a448-08df29430438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9cGOSUJqtJUAgStO98So6dTRvjbdUccQ9TBHMLgb4p56FuM+CnG58f+Ohta1CDyN+cr1/Y0/+D/f+3rX9P5pC1Z02MGxrIfwf2Fkg3mPBiVnjxICUvbtryyWfejVjBI2AtOrc/l1JWlMIYupVF2GZv55V3TNJj/jm7X0q0bTHxn/SwGTglrFBfg79HxAmJxSOBHdTrsqAOkQ8b4T56kWQHW4jfIEmuJjHl9Z1O6vkxz75xcWf3ReVFhPc1EoYk+NkTjqZQ0gMpDdC/iGw1EsPAGkXMTPaG5+wkDIOeCtt4MIvjhgphT7xz4q8GeMjG7oSMu53VeliJbFRbYVs4f1DB6EA37AfNm+0VUKazvMxHUMnh+1uFQYlqeEJn9y4Lh6IZfKJhXm08ql/etIp53AFxjteXqSbAnTxopMacYnUXjrPw9Xu13nrlG9DSi+1tbkYa/dEyJ8AUZ4ecW8INoDVlWGEI47lL+hZ/RKlFwLFqTE4CfZNGGdHK8WAR+DOnuobTviaMfSWaLDkNzajFYVgvd+v+QXpLzwg0tASnUnxO0e/IpkHSnAACqc9gkckNeJZa8EYJVAwc8+J5rEU4PLQzmCxLAmkkkek/5v4PeUEjm9M2DFdOII/0HCkHRP9GLhAFyirtdX6+fBSXcMGVKNVyGdSJzajrNBYwu0QwRzMxL6355i/382aboqGpc1yj9Sj4IyGxPy1QcLP3wu44tpZA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0mqhD28p0wTQkZ2U/OfHoURot2XbBecbwBDfPcKjc97k8U7H+8ofewTlecG/+Mg81bA6RlIU6CDX5v/oCtRMxXN3xv1NfNw8MMizw3l7TLR4QZ8xwaRtunKEzPLhufyiQseXqQ5hghQRj5LYGsIlTy57CoCKlWpZ8IOnZDl3C6qwj52ga4FPXn5zAidOhM+htrWcN46MQYOPK3FgJ0RZ5C6rWtr12fUpLegJkutbPUFkiM9FIOj1K9Qr7T6nSTf7/tp95X7nOgCRo71bGUSBpwZz17t+pBaacYWpp5ZrnahMkIKX6o8XCWQEnEU+J76l4XHHPhRFAc4xsioSyUOyT41Fy+bJPN437+6pyowild5HlH3iJ+U0U2ZGWfMQmP/qOFj1sTALZz4MW71cmvLmrb7FuafbIg9BhanOE0D0PLlHR/9KzUTEgUCPTtNUXpQH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:59:51.8857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31935bb-1e56-4a64-a448-08df29430438
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB196577

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
Reviewed-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/skbuff.h | 2 +-
 net/core/skbuff.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
V2 log:
- Move alloc_cpu after the headers group and fix the indentation. (Eric Dumazet)
---
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a3ff380d43f01..b3272d379409e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1036,7 +1036,6 @@ struct sk_buff {
 	__u16			tc_index;	/* traffic control index */
 #endif
 
-	u16			alloc_cpu;
 
 	union {
 		__wsum		csum;
@@ -1088,6 +1087,7 @@ struct sk_buff {
 
 	); /* end headers group */
 
+	u16			alloc_cpu;
 	/* These elements must be at the end, see alloc_skb() for details.  */
 	sk_buff_data_t		tail;
 	sk_buff_data_t		end;
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

