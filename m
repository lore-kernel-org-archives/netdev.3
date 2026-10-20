Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792493343;
	b=BYDPhpyZxaFrvwm9kht2q4gTyMsfK7sMC3K9r8O7QDZQA+77S8NnX1cOcNxG/kSdv6o+
	 yZxSJYr9h5HGGMNEGyTmoA+UuxJw/N+Nxfo31JgX5Z9sCc9p4R3Ed4ebFf+kI0jk4cMMb
	 NqNxy/Dif0KoEKIoPpT96obW1WU1CRKiHHFfBVfb7zKg3peNoxVuXqiSY9zWVmQN4/Q5M
	 Dq+bXGPblwRw6btASBdmbcsBXuhOw8Y5GpO8zNpkejRrfefwCKjNuG67rqmyZdVKievld
	 lBRf8YGscTmCVS1zDtIvu1dps23tVAggk44l0n+8Yj0LCWI8aKCzBYq8gbqbb1QVpXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493343;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=knCCLV7lKIk/h138b9+LspZznpi6TuENOSk+jl434w8=;
	b=3qOREdVEUt4FlhebYTwnAflmDBjcWPBbEdx5nLnj1Dw+MhZ6vnKAhBA5anLxIjXChOc1
	 7FO7CihUAJ/7CCaILMdAU7oN7yHn9mah+U6mGfiMu+LST5sbDElvwKVuj6FAePnPQhfsz
	 sGuR+GQdqnugIygcSIBfP+S1RyhgNYGkrHGk9XNxiiDto3XPljlozyEUFg6AwlOdUaSPt
	 X6MsGSQloEByzpTOf9LQ4WGBbR+lm4g5jqM1Nj8NplHzu7YOjtJgK4Y9hOZFXOnJe8DVS
	 qyyfQsxouV+5MRTUFqkZjQ4UVvmosn4J4Col+hRFZ7baqak9rSibbTXDGUU/wtNLjkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=VS2mnDtT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.4
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F87606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60F87606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=VS2mnDtT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qScDOjerc202O9GsaxBgkS6VwmCA/wA8nf0JugEzpLzLQ52Yn501DTTo8Q+YuDdzMr8dqQNT+sl16CCeet/S8Z9bFX5ozPr3GrRSiseRQKfTv8w/8wpzvYJuul/cpiMk/HruaXnVidoQ0fvNuNO2x2X4g+XHIUapacVhkYJvo6BK1UJHBzX8P0jKCLhre4zf5dXbPVUbv4iKkeenyylv/rdrmJ2TDEPUefrAOlVNPuHjOKkB0Xx1TqPKw/5sR2U/xb0Y7ovvAyvyIhwXv/G0mtz9tioNUkmBrKcXjTW838tEnAegT0hq3bvMUmoS+hO5guMdC/C6lWy84RNlZ872kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knCCLV7lKIk/h138b9+LspZznpi6TuENOSk+jl434w8=;
 b=QiOw7qAES3DoKnVg8b67BJTAqZ/+hLGAP45qKZdKFOeOp7OSYQqm1smeTGQ0dtwEfC25pe9SfBb15QaWoqWa4E7oHYsdoyFyXuSmTFPdbQVrjiEriF/59u/NXx22JvoIj/ztcgsc3Mn+y8Q8TooxTogOHUb06+PfeKUJAOzf+O2FX4PMp03jDdgkKXrNmTnCSKhowOiQGBU8eatmK+ZxR7YEOX/NRtSFayehLsmYYzuh3ahyJdZ4Dn3XAd67fv5i6LgxWJQu+EXNAh/JrqShg9oMkNUa1kWkX3pMUV6pJ0s6KXH6daibiv7GbVZDdbqPrgIAXrY/G0PV8/L7jQua7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knCCLV7lKIk/h138b9+LspZznpi6TuENOSk+jl434w8=;
 b=VS2mnDtTclsN9sxySEkjJAbGI35gvsa4jYZro36eZIN2Sub99KCpysrIpw5bl012Uc85dB+KXDzpF/pEAz2RaQsrj8UM6+mUR9wByqI5zFFcvUEvDcTu5P22YuVIdyyKlYGlhnxUI5cUiM4wWvgwtDpqcu9pm1hITrtcCE2SWiE7WEpNgJ8Y37WBdI6PeB1P8kWtm/nilwiuWn0q1jou1L+bF9H9dsfY4wNH9duvOGGMEXkP7Fk0cSRibQvKM5vZkzcPhIcE0Zxsk88+GKC25x7psHxkCcmsX20y8bpecmB0Tt1nWSdhHOxdn4TKp4UUSAfwMKDFtwGhktvkegTO3A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by BR0P189MB046623.EURP189.PROD.OUTLOOK.COM (2603:10a6:2c8:29::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:48:58 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:48:58 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
Subject: [PATCH net v2] tipc: fix refcount panic in tipc_rcv() when receiving shared skb
Date: Tue, 20 Oct 2026 17:48:25 +0700
Message-ID: <20261020104852.90350-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::7) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::23)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|BR0P189MB046623:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c9c711-9614-48be-13b4-08df2e97be6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10070799003|6133799003|18002099003|260925022911599003|11063799006|260925021911599003|10067099003|261009223027099003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HYZ4l0OqQxsXEcTRdK7vrYj+mYab0ndnQktz15p6tTKTFV4O5ZxXrK9WXjvQL95I1du7q7FGU8nFjYAxCttNJo4RQMiPgq+EinmR0kYAPs1VBwQMolahwnP8A6aib/ReOwtOHGz4newnXdXUtlATxZe3D4mH1hGqm5M6AyJfZM97GkD3Uvc+PA5Kv6EiyVRYpCFVHLMPzCt5Oar6XS4R5Pu7aHRUGhnBiryMXuy3ES4Zkc30JdqlAu3KJMca4zQFZMJXl/yp66hxUP56YQyQ0fQ4YtWVFw2AnqBqpAxjawCbhJWvdOynRjbnMgJW6AfWmecPVJ47hb8yzFgUrtDOdXW9pLBNfRpxuVMfca+cuPLIlf3cpD+1g/znpP0HydVoN5F3fqCDXtWV+h4Z63go6cluulHo3+ytPg6DY8T/5LFzOhqc1Fd3cQ0ty+vHrc097zuzqzo7UEBSha2s4TVAsOyRssi0R9hJZow3fof0xBI/YW2iFStOBlUbjXFTaI+PWf1q80Wy1S6cztBalnLPxMsZDFOczx/+fRQ6RaFiSSv64zyK7r2kgKH/kQFbHqO83QNrJNiw8Qlb/frZrvitgue9bVZy3FwKAzt//q8Joqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10070799003)(6133799003)(18002099003)(260925022911599003)(11063799006)(260925021911599003)(10067099003)(261009223027099003)(260925021311599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0D9Q/Oos/2hVGElPyvSDvUw2lUsJZz89yxoNhWX25bUPd5NTorbR3IBOPV72?=
 =?us-ascii?Q?BOY7rJkvSZGAY9fOQCM8AQM8yS6NFFkxohuPt7Aw1j5g5ftfPWWw/D1P91Ps?=
 =?us-ascii?Q?QGQTbcW1rBA6m+UAdyGoxuAZJOPAGc+ExAlAxgnZhpppZeoNhPzTgoqM8iUq?=
 =?us-ascii?Q?fbLUKtKy5Xg5PbwtQJ6SBlD9bo2i0+Ncl54zpQED97otpAUTa/dVIfMFyv2Z?=
 =?us-ascii?Q?jBnxilbLjBeUxlwCl/uEsELh1YYGA079oSkmDa3C3tbaGxb7DM8jgJeBrOe8?=
 =?us-ascii?Q?8Gcb3X7+YfcnEtOjczSoj0ebITWZPEOwFRCFlHExem5H9oKmVtcsGQEGnDVr?=
 =?us-ascii?Q?HptblqN1muoML0WpfOSP3Xi+/opgOqsT/QTVchSsmg5K+KIy1P7Bhy49VD/o?=
 =?us-ascii?Q?Tnco3D7z6ckX1mauOC+7ptZQrsQTx4JLw0kiyJX62Za5/eD+WkUihWcBGK7G?=
 =?us-ascii?Q?BkBBxuW5RiBAxyzhaBJU4hVFD9HS+evvqKm4GPxT9HF98E4fRvEL5R05dlXQ?=
 =?us-ascii?Q?sr/8/nDd9DdbOeWDYt7bejaJH5nmp1dopxJb31/CiLyljcXVv9o7LRzgfI8G?=
 =?us-ascii?Q?ddenjBabDzby6ewP/QrrHR3HQ9Fy9x9HFpwqlvUaKU0s11R7dJVBCAGvS5ZF?=
 =?us-ascii?Q?4yPKNKXnWpSfcKKNnvVwilRKFQPDgjgzWDSmDEdzzist18AE7ClisIMLFuS2?=
 =?us-ascii?Q?1mPGZDddUNXusWfKs8gWO9jK8y2Z4tQGO7Rl/CVgX5krG0etWeM0OcyE10BZ?=
 =?us-ascii?Q?xyDjxmDSfsLvAZGRDmV6cj2qY2Kkd28VQ6OgVCO3FdShvcFLgx6EWkwuxio5?=
 =?us-ascii?Q?NzhxmyL1fpVBqsw0zO+6UhLh2FgheGp+f2IVPHX4f3trGLTh1uGMXHzK70nD?=
 =?us-ascii?Q?JHF4Br5dXSG/vYJ2/l6vzQ3lz1BSOx3JBlCVlAXR/sKGZBa2Dw937tBRNXUO?=
 =?us-ascii?Q?CHaxkiCJNmFRcRdDJOJM6Rz26BO89B2ck/D4VN3NWA+eFVtuIHSYWwHZgSjK?=
 =?us-ascii?Q?Rv4DDjftxvmK0QVM8R1ctaQnlFg3A3ROy2eOZ6EqpcxL8bQouBmXDx/NioaI?=
 =?us-ascii?Q?Ukjz8nG6mpustYAZi2OfcMM9ApSuDu0egaFDWs68JNoMssQ3RPpZjE82Hi6/?=
 =?us-ascii?Q?PyYT1gM2ig+XG+AYqSgqH2RQI9t3mCPpZwqzz6piDH3EOerqLliLcc0nVsEg?=
 =?us-ascii?Q?evsTJL+aYZskSF8Jms0t1/ImW9LpYB3l+oR5LWMs06iQWhBjCjrtHvQ94moT?=
 =?us-ascii?Q?+gr8SnGyTfP0v/xyp4RdwCGAYKaNYAFBG21rVqGJC/mlWUtt+qtLwoC16/cA?=
 =?us-ascii?Q?TlO/kmHUBjuaqg1Ttx3hFWOFxWXVZutKpjOTU25Qxuoj1r0epC3ACFi7KUT2?=
 =?us-ascii?Q?YEBiUwym9hkAPQ6paaFxKZ0NB+FrsfPWtyo4ekHsKmGZRRaEGOVBugtF3hfK?=
 =?us-ascii?Q?Igff03U3O37Uh+h+3FlmbvGyr7/WkHKgYbCGuvWxK4LxUMGa+5UgsJTX9tqo?=
 =?us-ascii?Q?AB2hKiUWjQ4TApILunk1mEq5Mc9QpTVlDpQpKHkhkLAa0X51Y+Tbdu4FtTrk?=
 =?us-ascii?Q?MHWS+uucG7EN9b5f20VfdUyTlvYdfrXOypDYAunSQdE+lUS2AJBY5Rd0tNEQ?=
 =?us-ascii?Q?hLjVGbBQt+rgnIVTJ5S+9DgwVykTzrnVdcR128jva7hjXsnZgqN8ejb1SQTF?=
 =?us-ascii?Q?NFTDP9ThzWvevOvWWKLyKgjv1yA1gd7MFL6SXzXa/k3Bc02OG1VypkgCHO6c?=
 =?us-ascii?Q?obC6ymk/rGY9ZOrtYSHiG/GMB/ek95aze+LexCskVs1lBn4SwTWHX0l5l7sp?=
X-MS-Exchange-AntiSpam-MessageData-1: 6Yxdi1CLVEw6ZIrMUTvVFDDEnWhvhXwnPCM=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c9c711-9614-48be-13b4-08df2e97be6c
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:48:58.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYRBsISsoRlQCSYQ+oHbFz/pBLZTSJd78p6L3s+It6HbxYc52IIjZp0Z+oARLsIefS+zXzX0Pm28y1zogtTvc8AjQJ51FDfMJWcQQgbvSF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0P189MB046623

TIPC assumes that the received skb is not shared with other users.
However, syzbot reports a bug triggered by receiving a shared skb:

...
RIP: 0010:pskb_expand_head+0x135a/0x13a0 net/core/skbuff.c:2308
__pskb_pull_tail+0x111/0x1870 net/core/skbuff.c:2890
skb_cow_data+0x2ed/0xc50 net/core/skbuff.c:5398
tipc_aead_decrypt net/tipc/crypto.c:892 [inline]
tipc_crypto_rcv+0x346/0x23d0 net/tipc/crypto.c:1843
tipc_rcv+0x4b7/0x1040 net/tipc/node.c:2119
tipc_l2_rcv_msg+0x2d9/0x470 net/tipc/bearer.c:669
deliver_ptype_list_skb net/core/dev.c:2533 [inline]
...

The root cause is that local delivery hooks in the kernel (e.g.,
deliver_skb()) may increment the skb's reference count (`users`) before
TIPC processes it on ingress.

Fix this by copying the shared or cloned skb to ensure exclusive ownership
before passing it to tipc_rcv(), as TIPC needs to modify the skb's data.

Reported-by: syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0017742620a9d06f06ef
Closes: https://lore.kernel.org/all/20261018145928.58317-1-ngocthang2710.1999@gmail.com/T/
Fixes: 6e967adf798a ("tipc: relocate common functions from media to bearer")
Fixes: d0f91938bede ("tipc: add ip/udp media type")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v2: Fix typo in function comment of tipc_skb_unshare() and call
    skb_cloned() to ensure exclusive ownership as sashiko's feedback
v1: https://lore.kernel.org/all/20261019050648.287309-1-tung.quang.nguyen@est.tech/T/

 net/tipc/bearer.c    |  4 ++++
 net/tipc/msg.h       | 26 ++++++++++++++++++++++++++
 net/tipc/udp_media.c |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..1f8d85e083e1 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -659,6 +659,10 @@ static int tipc_l2_rcv_msg(struct sk_buff *skb, struct net_device *dev,
 {
 	struct tipc_bearer *b;
 
+	skb = tipc_skb_unshare(skb);
+	if (!skb)
+		return NET_RX_DROP;
+
 	rcu_read_lock();
 	b = rcu_dereference(dev->tipc_ptr) ?:
 		rcu_dereference(orig_dev->tipc_ptr);
diff --git a/net/tipc/msg.h b/net/tipc/msg.h
index c5eec16213d7..4ee2faf5d86e 100644
--- a/net/tipc/msg.h
+++ b/net/tipc/msg.h
@@ -1307,4 +1307,30 @@ static inline struct sk_buff *__tipc_skb_dequeue(struct sk_buff_head *list,
 	return NULL;
 }
 
+/**
+ * tipc_skb_unshare - make a copy of a shared buffer
+ * @skb: buffer to check
+ *
+ * Return:
+ *
+ * * skb  - Original skb or its copy with the reference count at 1
+ * * NULL - Memory allocation failure
+ *
+ */
+static inline struct sk_buff *tipc_skb_unshare(struct sk_buff *skb)
+{
+	if (unlikely(skb_shared(skb)) || unlikely(skb_cloned(skb))) {
+		struct sk_buff *nskb = skb_copy(skb, GFP_ATOMIC);
+
+		if (likely(nskb))
+			consume_skb(skb);
+		else
+			kfree_skb(skb);
+
+		skb = nskb;
+	}
+
+	return skb;
+}
+
 #endif
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 230645cc01c9..ea1122510d97 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -372,6 +372,10 @@ static int tipc_udp_recv(struct sock *sk, struct sk_buff *skb)
 	struct tipc_msg *hdr;
 	int err;
 
+	skb = tipc_skb_unshare(skb);
+	if (!skb)
+		return 0;
+
 	ub = rcu_dereference_sk_user_data(sk);
 	if (!ub) {
 		pr_err_ratelimited("Failed to get UDP bearer reference");
-- 
2.53.0

