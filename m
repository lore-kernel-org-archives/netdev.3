Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CDA38656C;
	Wed,  7 Oct 2026 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361514; cv=fail; b=Njsle2Z/LwKKNID4lWH0WuS8pZemf+dzNZTa9cjglfHzcDD1ZxVOSeWq/BpMct7kq4OeuuOcPos3GcqOVK/CSxkwFCZzOCzu/8qBJMVUiQflej1iTEzJO9CpQklSyu7sp1hiy2bOxl1b0SKtZcRdaqiyGV3A+P2Q30CZi7vWb4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361514; c=relaxed/simple;
	bh=HNSbLcowLDSM/A/uy6NoofoVuzjjWqpK4+MRnWbchug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FXqhPu+FOheUATmxWJ9L55zB/+ZxzSTXxEBRDl3Z0FvboInn/lf9ZBr+ILkzGhpvB2dy5DRGg8HgIhNGvkajuJtKximQgjVSIv31ZrHlGS9tFtEVBFWKxXMI+RiA5SEZc1wZ338SH6uM7Ll+Fa9FyWgIpOPD3doCUv/OBnS1U8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ec2BP0k9; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ec2BP0k9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rbk5Rj3JxKT/RW4Mzvg5+u+wbpPnxDYDamu2luTE0N37c6pbkiKn934IZ3UQOZ1eGCTqgOyZxMtpfroh2Tt13tCDXSoT5FcKsP74hBHScFDFQwgO/Um/rNg8IdTKFY7DpwaX5Pud2sFsCbQK87/OULYdL/fGhbKbpwGRUgxv/06H26hpKRS5DPsTu5UWig2laDp69VuQIwXt0k2vOhCpQ/lYReGK1p9N1WUfcBaPtfjFk+JVpl8p4ONVvnP84cybQdrxQhju930UhgTpVif5IaU2FshGBb0FVcSUqR8bplCHhK3PPj83I6obVLQeXbdwLUInowZkI6IOJXFoJzuKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kauH6+bLFyKGR47A1p1k1Y8c0DIwmntvt9lsNdEqYk=;
 b=PN+lfaq2OIrNmQtftrwtrc18W3G4eu8IYCmlXTSOXEna3OxPtEcLEbNlx0mD7KybGl//90rSaghO9YpVjdYDr2Q2ZAinorh0RZC5QmUaBHCcQoGWJKzXxRNBv9ERMZOUW4Vv1UH/PHj1n3Vb8biDkaPXz1YgFAH/WAvfA72+v7CDR6V9F5JhZeQK18pdgNySDOl4uuN/bgHNXK+DaPj1DvdPAcxzelJ2ODWKogsKa4HCIr9GEbq7RUQc9Jy+/gWQLtDxGBeHzaW+5so+NMtqLdGJg0sOFvpK6VSjw9derld3xFnahdt1FarnQGsjon3ZPu1MaoOQVgF6sOYjG23zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kauH6+bLFyKGR47A1p1k1Y8c0DIwmntvt9lsNdEqYk=;
 b=ec2BP0k9s+hpefXL3gr7QmNUt+n5kbyDEXyVBVpnifRxulezmEcq0QbpRMUCVAHkUohbQkB0QQmc3DRwhprxOsSwNWwh6V+Ki7X2hg16jVnLbWOPJZVpuFk4OidJ6mgJVndF32UyjnT76GfYvvo/b8rFN8gqJzBabeedurBZm8dc8crIeN8JTnipaOmzSq66X1jm2Ex1Eejf+Cv7R06j/ZPMHc8MDgidIqXZ56URQQAhCkfIeH0SDYoENUmlwLBk16TTVRtTQ6TTZJk+2V1sF63xto6VrXpFtZoPOIGITlH/9l61wcrsKkqiWxUFT+BHyXDqg+fv2wiP9m5sJqb3VQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:25:10 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 08:25:10 +0000
Date: Wed, 7 Oct 2026 11:25:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kyle Zeng <kylebot@openai.com>, edumazet@kernel.org
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dsahern@kernel.org,
	outbounddisclosures@openai.com
Subject: Re: [PATCH net] neighbour: stop using device addresses in hashes
Message-ID: <20261007082500.GA918849@shredder>
References: <20261006224118.50200-1-kylebot@openai.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006224118.50200-1-kylebot@openai.com>
X-ClientProxiedBy: FR4P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 51df8c1f-f4ac-4034-5131-08df244c807e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|10067099003|4133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ek+aErikL37PhORmxc7kfO8mZqEDJDIkhQupXVZb5QW5YGXliX/nPHaPpBD5szoDER0pR1jKcpkmm1EoFjLF2aMMpdmsHzgT9Equxvyz2erTwsZLsk18adGSJjTimw+5jjVqHTGVD7vZnYDITBirglMb9XERT/LgS3p6PjbmaQ8r4V3xQZItoPIOKYY/mRzDCG6flIKS4kyEVQMIf5t2NS10o6WftsPwJTDz6bwkQurRKmZGqOna38Tj1I40RHjxw3cSWFaQDqIFvLS6jTRfCAvVaPabSFfpW4Edr657LJFvKDSkhv83TlNTVTfccdZlj6J7tr11Ef/jSoa/CX83FKUp3OAZM8ReMkdquVxdRlioKPniEBZl3JCtqXoj16lNoKNgDVkGjcYLE9A8eR69EwhUXcX3SOadG+x1lR0MFffRtxsMgs13nQlU1ZIyyd2YItFVP8Wn9Cvg00aSCRSu4kQQp1l3pUIRgtB58ducnS9P0IIvJ/Tqd9d4upwF7mtqR06stpJEJcG4aV9p9TIMIC4sd6kMkKMopOd84TiMp4SJENacG2v/mvDjEAJ+xuPexOGPM0Aa7FWGXviddms5SJ5UEHIe3/DxkvQzEHkXHVtTEfpOxjQ8KkwaeDzN95niMjE5kGtyRxzFPnnNyddk/gCYksX5R8l12z1oTHmFzBs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(4133799003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g9J49EHWFMZCTC+VX7NeqD74zc0QxReqNgK5Fl9vlu+wb9GSoIXhYifFNvzs?=
 =?us-ascii?Q?1N9xX2C+EJxqtSh48aG2Z8D3dnDNVB/XrEloFWzyumxhdWLSxcjLZdwNuYQ6?=
 =?us-ascii?Q?4PSLcpS7VFQXJqtqa8TGJdoxfwHVTwY6C1JcALzTNF7Mv0Y2/+yEs8067WjV?=
 =?us-ascii?Q?8q42zwKZjB48tTPC9t9WvdmWVo6o0PrUnxBHBdQBG6Bkj7lL+YH8w7h8GgTr?=
 =?us-ascii?Q?ZjsDvfJeAzy/5/6clu1En28E7LV31d9njkMahSPloOKFWXQ9GckP072ik9Mq?=
 =?us-ascii?Q?CIZhlYG/Lzi7nIAt9IQSdxPoSLN5Tc4U60B2QyuUFDS9FeZHjtvaeEg8q6Qo?=
 =?us-ascii?Q?Zg+K5sMdbr8YSKZGthkZn7DoLHKUUahlzWM1OGZzJfJQbSBkiVyIhi6p2+1Q?=
 =?us-ascii?Q?n+mAgYyrFiS400c/qcT6z2TT1uoUoS7S6Gbn6EcKWPmDTMceynReXAv2RYyj?=
 =?us-ascii?Q?G1Fe7duMT9fYSD7EZmi2WdE6LXfuUZWVObgjCWyjtFzfmjWYZS93fivRzyMm?=
 =?us-ascii?Q?Llx8E3NcgKdXPTA50WZP/VQ2/oRdMtUD+ls0XkI9MvAmxMFJYlLrpajHFX7S?=
 =?us-ascii?Q?pXuMPVvoYEliQ6Xq0jpo7zYAnRgVzMNGa6eQtorfaEbEM7vCwMjFNIjUK13c?=
 =?us-ascii?Q?7Kml1wcDZuNAXSBDTYGdgFlsvH613vHq6OoBYxlQqW7ZNnURpOmEuV3jmErp?=
 =?us-ascii?Q?8phRfBg6kXOyVo6YHt4E09S/02MEHdGZ9fI0qrPaKnGbitk8EbIK+eBck+Rd?=
 =?us-ascii?Q?4JDavbX1k7va/1GSMsWZ2kreXM2qeo11iAzp1tRZXlBEvc9zgwGkT8Id44oK?=
 =?us-ascii?Q?929cjbMrsTUdTVOqBSdo33uqAhQJp09DaKKQDVT6FFfp8jy13IyVVBj73xcz?=
 =?us-ascii?Q?vePRi+AMw2/V0Xz1xr22ZrtRpD4X01EC1mp2Q8DddnkgmgZGg5jSi5rAP666?=
 =?us-ascii?Q?/byS2/drwZglUZfZ/GdgQYVbesYJzp4tPYzvU2BpY0oo25qeBBkAxPVfX0A8?=
 =?us-ascii?Q?/2lP9UfG+qwIdah4ZrKVflinPKua4d4r8dU9pjAlAhOGA5AmkhIIxxh9gGXT?=
 =?us-ascii?Q?2RCcg6+N0ipFKoQ5OtSKEp9S4nPcJGwJoKIvp5iUX6mH0Ha8/JP+Q6DvknSy?=
 =?us-ascii?Q?IM7LwaByrT8rIxENe9p8jm7gjMkHIiEtORhoeVr8ORaPRZUT4M3uqoPse3ug?=
 =?us-ascii?Q?4LetwHM5xpPgyLtCB3KMjBE1uUUan7UUZn6Adpa4J4YAvB43f8RZT3RWjxu9?=
 =?us-ascii?Q?FaFKoshmh3XMHKf6I1DnzM3Jm2SxjPIGjMfBOjmUnhSOGauoRn26eyVN+cma?=
 =?us-ascii?Q?pPaeJwt0yE1caDi3MfMkk+GyIo29aPr3xyBlgQUvbdc2ehsVK/LZUv+/QtNN?=
 =?us-ascii?Q?5/89cMQpvugM2Lo1MgW8aR7ktHOSFILt+rlmC0axt+0ApnV9tWuo5V7HDZ3x?=
 =?us-ascii?Q?z/Zlc7/e8LRV1GGqthwjTmbqZQ8N/CVnwwmqJyRp6uzba8VH52KgD2o/wv0l?=
 =?us-ascii?Q?voGAG0ajCpqrUCQHM2movR6jNJsqNQYCG9rjVLbimkvaxwSrFn9AnpSxoC7M?=
 =?us-ascii?Q?LL2S3mpKQwXryioE9MoZDY7ygX6IgYuooETCztIEcwJ2SAA0LQLI648Pmfxw?=
 =?us-ascii?Q?Gz1tZ/7MtelG1P3o+kwJWZnFRb0KWYim9A0uEuki+9/dPwr7tRCoLTJos3fk?=
 =?us-ascii?Q?IWJL/Z/MkIBE/3a/BZBq1Y3IOrm6DEL76J5hRQiaJCUn992f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51df8c1f-f4ac-4034-5131-08df244c807e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:25:10.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: popHk7ulvtg8jI0392LAYctqU4jfBVqUjG+fqd2ylkvzva8mOHW0rbWf6/Ad9TBcgBTl1WrGeePQaeEg4zzJAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754

On Tue, Oct 06, 2026 at 03:41:18PM -0700, Kyle Zeng wrote:
> RTM_GETNEIGHTBL exposes the live hash multiplier and bucket mask. For
> ARP, that multiplier is applied to the IPv4 key XOR hash32_ptr(dev).
> Since hash32_ptr() merely folds the address, timing chosen-key misses
> through the unprivileged SIOCGARP ioctl can reveal the folded address
> of the loopback net_device. NDISC uses the same address-dependent
> first hash term.
> 
> Give each net_device an independent random neighbour hash discriminator
> at allocation time and use it in both protocol hashes. Keep it immutable
> so that lookups, insertion and rehashing agree even if the device's
> ifindex or network namespace changes. This retains the cross-namespace
> hash distribution that motivated using the device pointer, without
> putting a kernel address into the observable hash. A dedicated value
> also avoids making a salt used by unrelated network hashes observable.
> 
> The existing NDTA_CONFIG fields and neighbour key comparisons can stay
> unchanged. Update the net_device cacheline documentation and assertions
> for the new read-mostly field.
> 
> Fixes: b14f243a42c7 ("net: Dont use ifindices in hash fns")
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
>  Documentation/networking/net_cachelines/net_device.rst | 1 +
>  include/linux/netdevice.h                              | 2 ++
>  include/net/arp.h                                      | 3 +--
>  include/net/ndisc.h                                    | 3 +--
>  net/core/dev.c                                         | 4 +++-
>  5 files changed, 8 insertions(+), 5 deletions(-)

Eric,

Given [1], do you think this should be targeted at net-next?

In net-next the neighbour tables are per-netns, so we can return to
hashing based on the device index instead of its pointer. Something like
[2].

[1] https://lore.kernel.org/netdev/CAL4WiiqWwV+8JaYjsHrWDvoSt8Ng01xs9Orv4xhRpFAvhMnD6w@mail.gmail.com/
[2]
diff --git a/include/net/arp.h b/include/net/arp.h
index e932def63d62..9e583624f5b2 100644
--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -4,7 +4,6 @@
 #define _ARP_H
 
 #include <linux/if_arp.h>
-#include <linux/hash.h>
 #include <net/neighbour.h>
 
 static inline struct neigh_table *arp_table(struct net *net)
@@ -15,7 +14,7 @@ static inline struct neigh_table *arp_table(struct net *net)
 static inline u32 arp_hashfn(const void *pkey, const struct net_device *dev, u32 *hash_rnd)
 {
 	u32 key = *(const u32 *)pkey;
-	u32 val = key ^ hash32_ptr(dev);
+	u32 val = key ^ dev->ifindex;
 
 	return val * hash_rnd[0];
 }
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 96e3bb6e83af..a97be2e69409 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -54,7 +54,6 @@ enum {
 #include <linux/types.h>
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
-#include <linux/hash.h>
 
 #include <net/neighbour.h>
 
@@ -355,7 +354,7 @@ static inline u32 ndisc_hashfn(const void *pkey, const struct net_device *dev, _
 {
 	const u32 *p32 = pkey;
 
-	return (((p32[0] ^ hash32_ptr(dev)) * hash_rnd[0]) +
+	return (((p32[0] ^ dev->ifindex) * hash_rnd[0]) +
 		(p32[1] * hash_rnd[1]) +
 		(p32[2] * hash_rnd[2]) +
 		(p32[3] * hash_rnd[3]));

