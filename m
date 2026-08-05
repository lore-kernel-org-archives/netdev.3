Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67914346AC0
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917872; cv=fail; b=dRsDUeWwI0ztAg8iPbJcA/Ekua7Tjki5JFMSBklyS1CEIBXpZxvR7gdQY6QLaX6Ype+aEFINwH6Ex+TOjBL+EOKYwd/7olnaFrWhmKZ60VicmbuZROXWLkOkdlHLxtCY9DEBM4gYLIiAsaNEdeu0kJivcx6Kj75tV8g+7cd3qVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917872; c=relaxed/simple;
	bh=rwp99Rj1yxpJVluSUcMi3vucgYHL3/VIFhgMNgWfuGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mqcg2lUDjIy+8zWSuoPIrNRcqj/iczJmo27MPhhVTYDEvIEDLje50hmuajDFamBabikDI8tv9nH07YMn6/+mkrx4tNB5n+GiSkNSktC2jtj3UXrHcF4VCzR0xvxNwKdrUVdUffxunIlh4lJhzP5RsUm3zuuyv9ehpT2BUX7SliY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UQ/YC7GB; arc=fail smtp.client-ip=40.93.194.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UQ/YC7GB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/167QTmG5dldijs0aYgs0kHNJDhY8ulEp+gSWSUHEjmR/yjx6Jw6M+o7MbnyEPrpMgmgt/L958pPcgrWYnQAjRE4XLQpLTnuZtczA7CBM6fxfv+PFswYi2tAFlkD+OIanbz59Kf2hBuJdAE4/47V2aO4cczXwA3BsZngWU/IXFbq6/2Qx9eMAtFYFwJwMXDEvxnlIlxawII7bkcPKiwqjpZMO34FDaLnuMGSM4VOdV/6KHqVudfqv+fNinR1cWeezDsdaarb+quNG89W2mMb7DjdCbW7LQBQUnWWELK7ACPCra7YRnYYZQsRhKHkpltAO3QXrldl9U7GL4VFxy4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsgzaVyUtCxrTpTjyPKyaFuZ8lMetOS4rL6qcaPAjno=;
 b=bFHzxgZDoHVokldBhF+cEBAgVsqUMo6g60CFrqrnDWBhFkdyqG8t/VCWHHbPQIWna/4MWAWC/tFm9MoQLQGSf4mUA5B8B5ZpJohj2rhJTdhfes5tU8b/qrwNhAGHZkqIvwcHKPPZN6IVZN9yJGGOsyaSzcUVr3IWYbPdEt/uGCMT66boQQEOApEx+7bh/aApkMn8pbFX7xtOYt1XFX75UMRWOZTd8RoETtFdwjPuoFTDC+qApPH+rl3hrcx0JO/KyHu1YBlVuLioG+J8f0oJubpfKTIg2My9xtwq7/6UOVMVA4PxqW65A7q7ecdgT0OPfUjBG9VKmltrCM5pE7QvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsgzaVyUtCxrTpTjyPKyaFuZ8lMetOS4rL6qcaPAjno=;
 b=UQ/YC7GBKKflIXgMO3eE8jfno0TLh7MaRnboOiTg2n92e9xYzujcn2dw2RZ2CzaOVX2Msy1/Yio/6+z8GCh6qkXc6VCBEVOiFU+a6xohn2AJ0CwwGIhrO133UiJn8ux3hsV5rThS4AERipWdKqBUWKLCfoZHN4XTxKzeC3jQ9+l4I0aw/7GJ33SUtJTos1U0aBUY2a7Z0PwIKAHwG0mhRRLhTraT4x6afJa5YUHYIoYPa0c9JnyZBvAqXDXYe/MzRP7UcJsHNHK4EAL28G/qxdD1dChuELxog8K8wpYevqraXSLW4AjsfvC1t8G+6aLWvQJENNsdB1tQcty6nDxTjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 08:17:46 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 08:17:46 +0000
Date: Wed, 5 Aug 2026 11:17:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: zhilinz@nebusec.ai, netdev@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] ipmr: only copy pktinfo to cache reports
Message-ID: <20260805081737.GA1284302@shredder>
References: <e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai>
 <20260805013126.4161847-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805013126.4161847-1-kuba@kernel.org>
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: f96e26aa-a0bc-443d-03cd-08def2ca07ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|5023799004|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	X5lmX+ECFIS8VNweLIhHZEj+LbeT1v3M3IQG4jhKdYgIGSp6+WmyvTA0DW4s1NHvoi0BhylKFODIaHFi201R9L5+4Ht6HEAZxN8yT84mb4MwLcAl0A9+OuoZH0Gfc0LYRnY9cyqaeyPuXDyn2axSt/pfoABFjRlTd3SdWSUSApOj4hLbcsB0RhqWyAA6X35vey62Z1eOso3BxbTw8krlXDqdf1mY98TeR2Zx01BU7k4mW4j3gGxlHMiB+jfVGVwgVuO4MVBudMlwMYR/qD4leyyVApMYtSycJ6HNyRFnPUPdvN8cJhP43Cz0eAD6z23oGG6FklXyaj3EZepYZHQ8bcQyjVhpFokrZTPE99t2pUUgJhKeNplHAnLFXtfZtbxRCZIIkrnGTFL80lufBCb00EUHc7VGycWTfigk3jZWrKURZhsqr4FBqMmLeIeq9ZcZXTzyO+g2BrGt2heQ0OleVzwPNYL/pxvVFTzMlLyBJUWiqwTInIOM9J6B/3EqG9EC4lYYO5mDk2ublpXkrNSjRPPfsNTbEc9u60yuYZ34oK0CR+2gZvEnQ88lQl5VKZm9UXDtQRLIhqBBleoRkHk+BonemLqv7pkQlO8GTpRf9JpjsIJunPXE3fkPF/XOuzfnY5pLA+qU81HV7V27c5cSgu9A6cfi47a3wAM3Fwt6kDo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M3hP05PH1Xu6HHJ2WGfey34OvuJUeqooJEzIiutRgTS/2wd1bgVCz8yNBn9T?=
 =?us-ascii?Q?PEswqNknSgtWjWYMOX7W0A5VEV/ucgqm1q4ANsvVMUtYePFqWAMrqcQC7/mC?=
 =?us-ascii?Q?EXQ/ut+wDxCtymPIRf9r4cn/fhL6KGQBE2o2mjbFdseboxLY/bJ2eVdceeNg?=
 =?us-ascii?Q?QRCHJfQvx4s4yoQB3OGS/iE3GuKElC4qthCzZBqIP4l/b5SrvNUW9nHVDpJl?=
 =?us-ascii?Q?6XzYZYQs+JXRjlb7muWUxpUepEw8gJg3H4lnQUec1GG1m2n6ogkxEraQp5Yb?=
 =?us-ascii?Q?CIS3xNBom7oMgQ+LqtY6m3cnVXsu8JAnQVQCYt4IJsqnmUSPSm/DhvlZ3n4l?=
 =?us-ascii?Q?ybl5a1wvqjFrBOTXcs6QnxDLRwKyWOgGVaM/gSDiVv5zurAuF6arNwoohLCN?=
 =?us-ascii?Q?pvZ6mhBi3u0WhhUG6IJRocbz7VqmIq4q+yawvKxudfGvWEEDr0Bvi0lnQRha?=
 =?us-ascii?Q?lm5TNk8vXr6b9xXnZwiI6fymMuKSWIUb/h2pmnEsRJ5vsbbrqtjy43Bu/2sH?=
 =?us-ascii?Q?mWuFZRZVEi5t6zITl7jdRdXj4NgJxiH/QzrsaoP96BFpMu3MK5pL3Otvsg2i?=
 =?us-ascii?Q?C1/UAvIe5dLPIsMuL1N6qrJSPWbkU4RBIHmhZDokIyvfl+ByLKCT74SOis2t?=
 =?us-ascii?Q?JEpOiPUlGuEm02RMbNX5rAsg03oH4kh0Xw1kIt1BRGIG0Zt47TW2e+N+uyu6?=
 =?us-ascii?Q?mdv6p3JeXP5ef7z4xjT6W7lb7KQRx/8RPuJtxDHIM0M6e1lfuLpKnrZZ4pii?=
 =?us-ascii?Q?rtW8iEOSPHdCXtXK8F+RYHqMRBxONBD4LwLQSHsVokzePO4rZIB8ntWfJjMZ?=
 =?us-ascii?Q?MROjIaJi2TvsltiHF0zJ8ANbR/TZXwparXOu28K3NHUU74F+VeVa/CNWsCtc?=
 =?us-ascii?Q?/iypA7bLjScpYKwofge+Lo4nEL+f61hehQksu5olXk3rME//vmcR4ocf7lRa?=
 =?us-ascii?Q?2a8ylwN1v16KRVNQ3OHvz2hpimWPiczphle9LAVtShQU0uEN/+cH9ImfXd3D?=
 =?us-ascii?Q?696JjUhvBCy5wX8f+him8o5fP5DO7bPZraulTpASb+tth9MHUj6/QmVzPLfL?=
 =?us-ascii?Q?3CNibJuVJt/Rg1Z0cXkGcSuN+kkjaJNrSPdsgnb/467yPeel8JW4+ugSKpk8?=
 =?us-ascii?Q?vHpRO2aX/yCD0o3NQaDfYXDUVxjzJFttvbkagamE+n+Y/c5RITRP5I9rxKkC?=
 =?us-ascii?Q?bEFN5j1T5tv9GBt8JlQl+ScuRb963URzR1dIUIgtHtXH3ArpYoeXqmtOm5q1?=
 =?us-ascii?Q?zAYPd7CYZEpDOcEZnrDLGsvsALduVi0cr5RqnUG6KlCFKBVg4LDEsePV5XaJ?=
 =?us-ascii?Q?zAmqQ+7brEzFFNjTykoJE/cwWz3gTGxTagk0WouYur3ZVBbUP7TXr9+Fz4M2?=
 =?us-ascii?Q?PxFuTRvLx4XDKQvtNDPcLw/YnatGnI7sfz411Byma7WilMGpTz44FGuWhzJD?=
 =?us-ascii?Q?I+KSBOnV+8zvGlOk0GIMJ4ZeXaU3+8hrYNDt6PAGfykY+UX+uT1qxLsUYuhU?=
 =?us-ascii?Q?pf5jslIVwiE7trF8Atf771g6h5+2AjhKEzADKwrxacZJ5QK3UJsaqg5mjaYo?=
 =?us-ascii?Q?vKYguq08eE7wKqh13fvSxxKTeYdlTLTwYS0zMFmRde1qZPs9lmlFgbw+vyf1?=
 =?us-ascii?Q?kQ9rhlM9f+CMTqEVi/1jxsKEatWWBX1IVUKo9HK3C24I2btxsE2hmwCPFzE0?=
 =?us-ascii?Q?Bj+rLgyZSBImkLNE1bIvLbkDLcMLI15maJ/3fsaNCuYqyvJmqQL+UMpchKvS?=
 =?us-ascii?Q?hrOofwkjSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96e26aa-a0bc-443d-03cd-08def2ca07ba
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:17:46.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsNCGSAHnZ6YFpPUw702tUpcU9k5H+NMWhiLKz//K925yMP3EVxEk/nzdwmHx0x39j1naExTLope0T7v/GY8Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366

On Tue, Aug 04, 2026 at 06:31:26PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Looks legit, let's fix both in one patch?"

I suggested [1], but the bug in the IGMPMSG_WHOLEPKT /
IGMPMSG_WRVIFWHOLE branch needs a different Fixes tag (it precedes
bb7403655b3c) and Sashiko [2][3] found another bug in this code:

ipv4_pktinfo_prepare() modifies the control block of 'pkt', which can
result in this packet being processed incorrectly after
ipmr_cache_report() returns. I *think* that [4] takes care of it, but
all of this needs to be explained in the commit message which should
carry the appropriate Fixes tags (bb7403655b3c + 1da177e4c3f4).

Note that this upcall is not fast path, so the extra work shouldn't be a
problem.

Is this what you prefer?

[1] https://lore.kernel.org/all/20260729091227.GA1258429@shredder/
[2] https://sashiko.dev/#/patchset/1b809975e5bd9c0a1dd6fdd1db534e701fe5a4b6.1785379072.git.zhilinz%40nebusec.ai
[3] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/1b809975e5bd9c0a1dd6fdd1db534e701fe5a4b6.1785379072.git.zhilinz%40nebusec.ai
[4]
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1d9a4ac14fce..cdc84eb05c79 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1057,6 +1057,7 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
+	unsigned char pkt_cb[sizeof(pkt->cb)];
 	const int ihl = ip_hdrlen(pkt);
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
@@ -1112,8 +1113,6 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg = (struct igmpmsg *)skb_network_header(skb);
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
-		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
-		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
 		/* Add our header.
 		 * Note that code, csum and group fields are cleared.
 		 */
@@ -1124,6 +1123,12 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		skb->transport_header = skb->network_header;
 	}
 
+	memcpy(pkt_cb, pkt->cb, sizeof(pkt_cb));
+	ipv4_pktinfo_prepare(mroute_sk, pkt, false);
+	memset(skb->cb, 0, sizeof(skb->cb));
+	*PKTINFO_SKB_CB(skb) = *PKTINFO_SKB_CB(pkt);
+	memcpy(pkt->cb, pkt_cb, sizeof(pkt_cb));
+
 	igmpmsg_netlink_event(mrt, skb);
 
 	/* Deliver to mrouted */
