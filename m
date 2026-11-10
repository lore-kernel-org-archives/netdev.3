Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794318001;
	b=YSeojjE1mZnB6i+OjswxP3l0884WXTxXpW+lpwI15vFI9M2kFR0+tDbS/LwZbJFCsCyS
	 VSslNsHf/N7iu5c7QudUDcMqQh6jBvhnNgxVdpsRMgzUXx665157P3dYRT/fW2w+8IFWu
	 vYZExu0qJ/ZRtSswavKTYxgkk3lR2KiQ69qKxjp/EFyjCHn4vGW0KvXqYodY0mUvhfMkx
	 TSn3YHS2IdT1oCrtemJPeNWwd1ftBw0MfUKEk54YE/4BAXbB0MSPyzvUodin0Wu0jdQjr
	 tdRxlZ7lHqx7JSmDVMYN6CbuWgMfKEBQn4ohBUWNZHbs1o6wbN5AMlWcZ61X0pyCbFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318001;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=3ucGLBWgR1TwnI88Y/LWHk8rGerLqW9I501GIdBfKwM=;
	b=Vy+8BXW5geXnxmqNA7M7xITQtaPQdToLnMW5fVS5RdIcjumkb60AidKMtyleOXTf7Ru9
	 mTVjfOZ2JUQ+Y6d5xcfj22Q5M96EjhUBAVZxCSeoEm8GX0TPH03X4eR5Z9ScAdD1dc5HM
	 d6w0xoqXOE8BqWQaApoXOMnFf3J4XQsyzkFSNq4mLEIO5U+Nqn3WCQZIdbbeg8Ao+BgKY
	 x3cjW1uRqelUzqCBBI/0MS9gx6DxbDhBiVL1Wd/f3fgEU2Qp7afz8W6kwyCHI+Lgg/tFO
	 hjPaRdTEupMJ2xLaF4SKJ1vFTTFimwHrlGHGIGoIRsizNUsnKe+5iDBhtyVQHQV1F+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=StUQuBlY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.25
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A9606A747
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 221A9606A747
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=StUQuBlY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTEyvBpbdBJhu3Uqt9YHa3tY17Z9MwxxdhCHDn7HfkGI7zZP9InIChApqFHW9iwDcmYZqWJsUAZDppep8T/+2F2zvu+U4vZCfO9GXE5AECaXprzydN0+7XyCFrt2hZF+jQgh3K19iosypGstCuNRusvzcr+/I2pZ9fRF0fsKfh/z1aUa8QjHXLapf5wHN8KJRNRgFNxMwVxglz3hfuQjFXz2KAWLPvvdQjvrt9jZodaF/n+p24hgR2Hx1mdjgzio50xmwQ+C6PUqelGOIMNmzXBeZxouRbKkyZzpCf54d+SN68dBJ7XGE/am1QUTGcAmlPMC/11kDHE5Muv3voEt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ucGLBWgR1TwnI88Y/LWHk8rGerLqW9I501GIdBfKwM=;
 b=JCZdaAFROcdO83IZA/OebhLfgoLzIFxbuiyTxqvn+cZQvb9LGVO9bCOUgTzUpDGdd3nLOIDcghIUAvvh8/E4vX7Q4RfsHeapRPQWPxKb9rKZqTYm4A4o4cq9dd9jvuF1n11djZgz2rbM1LX3BxP8DiPJCf93c+LfbJIdufpMXP/BZRNud5t3dLUy/GWiy2sqXDb0LhJ5v3l1L3xyb4ifD/rjM+wpmTiXnf/XBxwUHjbLv6fM3bfohp/4+0G7tXODD5Z6myhQ9P3/PGmdVhBZFlSY4mLVp/82z4zUhiTRP67pgDmzlcpYUe3oBcH+EnuAXcKh2Dr94OZ7w952IX7Olw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ucGLBWgR1TwnI88Y/LWHk8rGerLqW9I501GIdBfKwM=;
 b=StUQuBlYN6HNnfo0uaFkuMDX9pY0KmWdJR5V6U6e6re+O/R34C7x09C22A8SjUsgfwujNWjy0jzd3+paVJNpsms9X4NedQXAEjROyGFdJZ/buCI9s7VAqJHspLTszaiIONzidS5pSMZEU2+i5b3mtfXEyEjTE8yPHALh3YshgkzI9tcTWgC+MfANEj3CJpOUndwucV9tA0RTytHwdALUejvAoL+LoIUb3WMnAIwwVgz6By5XelRRY1zEglOjMS6N5fsXg1tokY+OP7fz+UNV9wWN/mbbdHd95YkEKXdJtuSFY5FiRLbn7y7nu7hFthxkktWFOjn4TfD0KoRiT+awpA==
Received: from CY8P220CA0037.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::7) by
 CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 13:39:33 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:930:47:cafe::8e) by CY8P220CA0037.outlook.office365.com
 (2603:10b6:930:47::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 13:39:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 13:39:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 05:39:13 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 05:39:09 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <ipsec@lists.linux.dev>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shannon Nelson
	<sln@onemain.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH ipsec] xfrm: replay: Fix late packet handling with ESN crypto offload
Date: Tue, 10 Nov 2026 15:38:21 +0200
Message-ID: <20261110133821.2548903-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: edfbdb52-2aac-4089-81b0-08df3f300dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|260925021311599003|260925021911599003|260925022911599003|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261021135927099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S9VzR81eiDfqTC2XanfTo7w9xqn5V7qJODjRvu8diekCeVKp+4jHwxduIcpd57Te6+sbyRSY9KSIYINutYLN/VDkIIyUWbKT8+Bl6xIaaX+ZwauQkDgMAl4pnbh97ce4XIccHwxTDhaGX+D4A3/Vqvok/yE8+npxBpi/Xe7fnhJNk2X28il5g7zmYL11lOYrXW5IwHSgFHnkep8AeyqVsqW4rnJuC/CTKlXUDpIhYRhgV1U88fcYfhiyoLt1WynpsoU++sWJU9FoALRP6kI4cvp8v6kbpZLd8vwHkh49KhIZwrNV0ZRceQP8R6Z7ks0PxhgLm/hVblY7plEvlcvauOeEN1HsOxeCK0n8o0laV9pdsPpTirDRZuwJvu0ohJNYa6r9a6ih2pL3nhHN9tImOPQ3VG7TuuMI7pWOs/Np3oiETNAbqSSCqfJ78+3QjCWbEVa9Fq2G+0mP2kJzku2spfxM1FKO4/70Gaw9xv10/3Jhy3MNLRdTl+hvoNYJQftkje7STuQmQ+GZh1M2Dxh2r5JNHXKd/Yw8nDg3Ai1kw6ZdyoAg4mtDxxhXpj3KvjMHQyqrhcBpKA4YAu/l1cuZpZhXIRxZDu/eq9f/Jh+iNQjEYJAKNf/PXy8yfyWLY77XmCF3jwqOw0IR394vG6RpAm89t291v7dnuOjxxKlGx4xuB92ku/SC1aXJ5XgHuhL9uH5BsMh7T7DFUF2UmLU9dg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021135927099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RxiWHdV/DKB4snz5k09MjQLkl7SOvJi0j7pHadSbNDE70NKI36XvuSDhmRprV74s8YfsZWO2MgjOKUF0qNCqTThK7uNIUQZBOHbp1gzpvgPTK6OwZlyOYiDB0i4EHPU9JI9K5JbIu54n+tqqNcgB+h5Za8evSqLaFrdqyEXulIh30l61wImeK0H7xt22PHY5IcgKZKJcr6jfDGWFuS2q16/lLfgEZqwqm7OO0vpyfjSTDz7eoac/ndSQ4rC7CB3ZuPOv4zVrLfNMQTGC2HDxYvYU5uzyoTL1fDR9XZFu4JRh//CE29Cjmk+jrJ5KL0xjnXBk13ssjr8YM8+jjqANvhL3sASX5kGvHJdgx9Y/oUGyznXaQlnjUtTFSm2lhCZJ6EaJ4GP+2LcQZFuuqxal/HbLL/XStBDgTY+Xybc3e+mGQuEnk+v06DDuWmHJ8ULp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:39:33.0939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edfbdb52-2aac-4089-81b0-08df3f300dc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220

xfrm_replay_seqhi() guesses seq_hi for a given ingress seq per RFC 4303
section A2.2. Packets with seq < bottom are interpreted as being ahead
and the function returns the next seq_hi. xfrm_replay_check_esn() redoes
the same computation and defers to the ICV check.

On SW crypto, such packets then fail the ICV check and are dropped,
unless they're actual packets ~2^32 in the future (very unlikely).

But on crypto offload, the ICV check already happened in HW and isn't
repeated. xfrm_replay_advance_esn() then increments replay_esn->seq_hi.

The problem becomes visible when the HW state is renewed (e.g. bond
failover or mlx5 mid-sequence ESN state update). The newly offloaded SA
carries the wrong seq_hi and completely breaks ingress since all future
packets fail ICV.

This was verified on b2b ConnectX NICs, with an 'iperf3 -P 2' test over
a pair of SAs over a bond device in active-backup mode.
After ~10s of traffic at ~10 Gbps, replay_esn->seq_hi was ~2.5M due to
the two streams sharing the ESN state.
Forcing a bond failover on both sides breaks traffic permanently.

Fix this by dropping packets up to 2^31 before the replay window for
crypto offload, since the SW seq_hi guess cannot be validated. Packets
up to 2^31 ahead are accepted as new, same as old code. A burst loss of
more than 2^31 packets now stalls the SA (previously up to 2^32-wsize).

SW crypto is unaffected.

Fixes: 50bd870a9e5c ("xfrm: Add ESN support for IPSec HW offload")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/xfrm/xfrm_replay.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index 9394953247ab..37c0c299cb10 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -451,6 +451,7 @@ static int xfrm_replay_overflow_esn(struct xfrm_state *x, struct sk_buff *skb)
 static int xfrm_replay_check_esn(struct xfrm_state *x,
 				 struct sk_buff *skb, __be32 net_seq)
 {
+	struct xfrm_offload *xo = xfrm_offload(skb);
 	unsigned int bitnr, nr;
 	u32 diff;
 	struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
@@ -469,7 +470,18 @@ static int xfrm_replay_check_esn(struct xfrm_state *x,
 
 	diff = top - seq;
 
-	if (likely(top >= wsize - 1)) {
+	if (xo && (xo->flags & CRYPTO_DONE)) {
+		/* The ICV was already verified by HW with its own seq_hi,
+		 * so the seq_hi guessed by xfrm_replay_seqhi() can't
+		 * be validated in SW.
+		 *
+		 * Treat seq up to 2^31 ahead of top as new, everything else as
+		 * behind: in-window ones go through the bitmap, the rest get
+		 * dropped.
+		 */
+		if (likely(diff >= BIT(31)))
+			return 0;
+	} else if (likely(top >= wsize - 1)) {
 		/* A. same subspace */
 		if (likely(seq > top) || seq < bottom)
 			return 0;
-- 
2.53.0

