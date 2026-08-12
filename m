Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82BC43849C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536522; cv=fail; b=pFu+PzyCK2EgF/sPhgGEEcKzwr24OeeLZGAGVc8+JOa1wJwEVtj9ZXCalqBfTzjDuYAuj6LVH06DFPsgHihF1LuTfIWXUcKhhmmqMmAw+cbecRXtE/Eo1CbIrI/uR0soH3cc4v03NGdJ7yAua1aQLTj8vkFASnsFGEjNgaKfe0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536522; c=relaxed/simple;
	bh=Gmdb3glXlqEoS9CjZk8FljTUAkcmTGnKswCXq0gObaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N2LTOonrycPr+/hzLf9tjtqsDB6N3EWTBwOzowsfRYUBHkg6kOfoGKk+wDpsjRDFdZvVnNPNgFO6W2EUeYXv+ONyjtFcnE9rPUxjiCIqkgLLXGAIhtMTyKTJwyU3sB3NiCocuPQAL4WkTW+NKNA1Hy6sRjSOT5lNsPvSNlVe04E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rer8rsB+; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rer8rsB+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL+o44OKuctszA/RvWTh4PgiXaSCcYYI1aC3CAs+eJOpF4cRVoiPk6+TA1QwxXItOFbsboHQg7xaRmkWpP3rMr0fJUhJff74qBntS8LtXOYxOAz2w5YIq2OjJXoUc2AGlu6+p9/KQzYniNTT/zQTG6Ws21Puei2hnaCxSrZMe3SWKc4nYPodwt61iC0krwZpjP5y34//NzIuA71GB+x/TcGDWKxAD2XplRB0pj79GyZkOtIH9vcqo4YyDDW/2UexRYxI7uJByfIdhzVw4Ic7Mb5gn18GTSiGC2yte4F8X+RlkvzF6Qj4rC6HiN5sPP6JMpQjKNeuTx5erwsid7ovCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTLPSp802+J9g04/Q/ELSTaZxrmhP6BlKLe6rOhLlQM=;
 b=acmevpfJzFSvD8ri4dK+wKOPIOuLfVF9SGLMSDeJLUJkJtMHjxzheClKq1hxHJpjax8ARC4PNkp4bR8cD/0Yx6JHN5bbsUzpat3A2XjkZh7n6BXBEKRXOCMS8K8Z/I+UxKnthPmdfMoLF97fxkEt/JnCe7hAyb/iSAw/bQ44F8JQ3hL3Sx2ozLC5DUbLFunV5nOuGvOR9V+yxn5o1EF5vRqpqIPR2yBy4tkmQF5g0L0ArYwSn+FL67mfEYkVsSboX/ZrG3AM9dqjZ6xjCZhhXH+mZkzQ20X3JHwntL+6S5hkFZ4kciSJaE8SFxEE9yOBjjWGz2VCZVRktuCTNjgQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTLPSp802+J9g04/Q/ELSTaZxrmhP6BlKLe6rOhLlQM=;
 b=Rer8rsB+Ikqe54y3/YFHvVh+lbyqjAgscdaZutq+C2TzsPg1WV/HstrGvgGOHJUX9hkh9K99mH+vZQ0iE9Ag2nxhDPOoPiYk4C51ru49SfJ6u4MsmBOTfWYCjlFx52VLWPSZJGQflkRWWQOIA3IfhYKPjtePqPw0Lx1dBEbScz1jAAOktRAOcl7F2rq7PmPFIdiWxrhWN9RvkxXsfswMrPE9EnAnvmW4jBVFuM8uO7bKiCg/OesSLRlbdg8wnlHzAx0l4B/LvmnByh0Vhil/hIi7/B545RMhXu3S6gg88vbc2BjkI+ZHPVH+xOgCUZHkdFUsXk1Xw9GpyOPuooB9Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA4PR12MB9809.namprd12.prod.outlook.com (2603:10b6:208:54f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 12:08:36 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 12:08:35 +0000
Date: Wed, 12 Aug 2026 15:08:27 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vega@nebusec.ai, edragain@163.com
Subject: Re: [PATCH net 1/1] ipv4: reject RTAX_MTU values below IPV4_MIN_MTU
Message-ID: <20260812120827.GA3410841@shredder>
References: <cover.1786094799.git.edragain@163.com>
 <ccd14fb1411b8b9c466065582e43f6a6c0743842.1786094799.git.edragain@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccd14fb1411b8b9c466065582e43f6a6c0743842.1786094799.git.edragain@163.com>
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA4PR12MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: dd72e8bb-22ab-44a5-7c1e-08def86a6fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|3023799007|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZE0OssRWCbAkhqq/mzYZswCzPjDuQtExsi3ywr1KHn7TzAOForUgEfqacyBewfNK7i/XzeBXHreMCpsX/9KcWguRrfLIaWUgypgl/2DK9aTLI8jrg3WTP/EGgiwB1prupqGkjjdWHZcQ6pi2n1RbxFGgRbrmeEGXJGraBDksTonVWlDrKa2umodx+AkWL4K3X6XWZXs2kV4/ujApLzCl4XpoeQA3J73yHKw+eRRQ0/8c/oS+GmVACT4ngYf61+mBqlB69CR+C9Aisn9obVaDejB4YjeLzm3uqVNHx9AN0bWE0ImCauBWskMiyA3dOmyDkItc/Ry2jrMoIjAv4a7N41hc9/q28/1yWgBjXpsLnUUl8GejypAur03tkDWSbJlO/b7iTG0K5FdVjluOj2dFoBvnG2pb6JCPeXMvfekxctq3E3p6a7ebtNEKJqeZNDPUn9FEYIQzr490VrCIscsDRrfrUvxrz4lgWDYy3mhOw8NYkkszBLsKzpFUNOcLQ+pol57o0dhbx9N5deCmEwtSPI8vXmGBy6/jbaGQqygRHyHCRfgIgXNXom5qwpuH+brv0lPJ7n63cxh/IGv6y2pIR2MUk8rI3XugDJ+oyTKk5S9agpmTGsK55JSFLj3haZHC36XwGMVDMxZHGuCB+VsBwlWOocnx9PHPxDuy1Gn5FMY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j6myjY+M249cIqv8vNogPKeRZ4/algi+lKcSlb5w2Up2qjaJ/CZJIy2SBmxV?=
 =?us-ascii?Q?VfDLTkM20DAOkAKNs9mlqgEC09O5PSBNFukB8UL5rXp0Dx6U0IvMCkFP9EcG?=
 =?us-ascii?Q?ssvNkhIA/amBIvMHAzkvw8cJrDzPvlwnW2KSyaITnIwtg7RBqMVtDVjR5e/d?=
 =?us-ascii?Q?FC3z4zWomS/8PJ4jkMfqHA9eVJtJCJi7eXTzGZarW/ID6osM6ztAm9nCyB69?=
 =?us-ascii?Q?XMv/qwOQYY84dUDloaQreNsAX0pi20CxN/5/J1SFK0G1z5yTZDq2U/KbXyXA?=
 =?us-ascii?Q?EMLFRJksUvzp1ZrAJJodUun9nuTR0xRYBxaY54UKSaHM/o/e2SOU8aMLrpVr?=
 =?us-ascii?Q?6MTthS6KUDzokegOaqPqIVuIZ1NfflIbG+3GXFPa0LpbnE4npYzH9TByph7U?=
 =?us-ascii?Q?QZjiE05EhjPdu+CQ2UPhn1dUozC6m9DlF2fsKGX7Vb9PIVgXgbJBwbtUIwOj?=
 =?us-ascii?Q?t/Az0esHvPx2kfHhHiuiuBy6oyHmDOfL9YQbGBJtKbfWfQMChLeAQw6dCi/P?=
 =?us-ascii?Q?GS26KYhxYsoIH9BD7yyvOKkayNiiORlES6slDTHL2rHghHE1lhXdVN90R1lv?=
 =?us-ascii?Q?tvEO7gkc5ow6Brz/doeZXFDLlXE4Wdb0WZfvWvdwSXfitzZffsSenmT9sJ/7?=
 =?us-ascii?Q?zYcgWxP3C+cdRX1CmHeWWasC7uRNgwPwMQSmAQR8gZvk9DwZX18dXII/vVX0?=
 =?us-ascii?Q?//VgABpAL5dBLBC6A4qu/02s1wslOJJTy/7OOuc0Bw8A+CZD5+quUA+GTf3V?=
 =?us-ascii?Q?uEX/fvFHDZtnzXfPM0VurBw9g+gBSv5qAmDhhwqxvsOf1vcVQ97Zt+azErwe?=
 =?us-ascii?Q?Y7iE6eZoWbAD5/yrI3/tuF0ChCr+nioqo7DJX8KyYyoKzK84KWH7wMQJLA1y?=
 =?us-ascii?Q?PI9B8uNByF2ocEuvLt07tVH3bttdVw+algiLQd1V4gybh9V+xp8iP4wo52E/?=
 =?us-ascii?Q?fPmO3xIf0PAyGtrsLwjyfxn+GHbdKoYWF0tLxruDcsFO9EpvI2P85au1iNzw?=
 =?us-ascii?Q?kbmsHK1jjO/QaknkF6MnZsGHXKXGZvIp4Rfre8Q/daqV7Y8pHl1P4o7kqDmC?=
 =?us-ascii?Q?G6ruNxU3JQgZLNKzc4JqNAcGplA0rHUyMlvJmrK1oRGmo8eKFOALxxYybVTg?=
 =?us-ascii?Q?IGfzN5XppRKAckB67M4ZRPe25bQzwWp1gOsriMn3Q0DPWw5nSiIqdKww6FIv?=
 =?us-ascii?Q?y7jcrzdL/5NBfexY/4Y/3qej47oFn9XfmnOjtZR4MkmWin1uCp+pQXc+I6or?=
 =?us-ascii?Q?DOa++JCV5wwUtt6KWypM1XJE3EoqWO/qHCShP8R/JVcOlUAAs7/2OWBgcXnw?=
 =?us-ascii?Q?rV9GpayRGX74JcfuKTakVdIsQirOlkQwR8Z5bxGGyNyS/R2rEUjCFcn8s2mn?=
 =?us-ascii?Q?EsU8Pwoow2ifwpsXlr5ngsbXNFEyU+vIHZyogKoKcTSthuIhx9LqOEb6nhiD?=
 =?us-ascii?Q?5jyDS+q6rnv9dQb23+l+ZwKE82FQ2mI1YkI1KjtOG/yyCUNQxRoRs2YBIl5h?=
 =?us-ascii?Q?GulYuZOyVra6SayIJJJFObLSlxFErexQK3MgCV0ur3ggPix5dduYcNj/3Vg3?=
 =?us-ascii?Q?jR9TJeMLawtbst1DrDl88lG8V/RXN/EYO/7juZGkMgDhsfy5Rzgxd161U+nr?=
 =?us-ascii?Q?Y3f1ageITusRyB6BdLVwDUN/uAsWwdiWqpNhl82N5SmsTQONAigJU11V/ebx?=
 =?us-ascii?Q?t4dA6hDXQZSgxMV8VwrdyPSnytBod5fnBpHgGz5pg8iJ3ACU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd72e8bb-22ab-44a5-7c1e-08def86a6fb3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:08:35.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueQXxaBQfB34zNksKt5ZXICJeLmZzWvRz/ztsUlp38n2w7SLvUXjTF6N7O753OZQwd9lF5Kxf1tsZYteqo8zAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9809

On Sat, Aug 08, 2026 at 04:01:15PM +0800, Ren Wei wrote:
> From: Yong Wang <edragain@163.com>
> 
> ip_metrics_convert() caps RTAX_MTU at the IPv4 maximum, but it still
> accepts undersized non-zero values from userspace.
> 
> A route installed with "mtu lock 20" can later reach the IPv4
> forwarding fragmentation path. With a normal 20-byte IPv4 header,
> ip_do_fragment() reduces the payload MTU to zero. ip_frag_next() then
> keeps producing zero-length payload fragments, so the fragmentation
> state never makes forward progress and the kernel loops until the
> softlockup detector fires.
> 
> Reject non-zero RTAX_MTU values smaller than IPV4_MIN_MTU while keeping
> the existing "0 means use default MTU" behavior intact.
> 
> This fixes the bug at the route metric input point and avoids adding
> redundant checks in the fragmentation path.

Sashiko is correct that this is also reproducible without setting an MTU
lock. See [1].

Better to fix it in ip_do_fragment(), in a similar fashion to IPv6.
Something like [2].

Sashiko review:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/ccd14fb1411b8b9c466065582e43f6a6c0743842.1786094799.git.edragain%40163.com

And please note:

"Patch authors are expected to proactively look into the AI-generated
reviews and handle such feedback as any other kind of review: either
debate it or address it. In both cases a reply on the mailing list is
expected."

https://docs.kernel.org/next/process/maintainer-netdev.html#review-timelines

[1]
#!/bin/bash

sysctl -w net.ipv4.ip_forward=1

ip link add name dummy1 up mtu 20 type dummy
ip address add 192.0.2.1/24 dev dummy1

ip link add veth0 type veth peer name veth1
ip addr add 198.51.100.1/24 dev veth0
ip link set veth0 up

ip netns add ns1
ip link set veth1 netns ns1
ip -n ns1 address add 198.51.100.2/24 dev veth1
ip -n ns1 link set veth1 up
ip -n ns1 route add default via 198.51.100.1
ip netns exec ns1 ping -M dont -s 1000 -c 1 192.0.2.2

[2]
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e6dd1e5b8c32..e6bbae103e4f 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -790,6 +790,12 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	 */
 
 	hlen = iph->ihl * 4;
+
+	if (mtu < hlen + 8) {
+		err = -EMSGSIZE;
+		goto fail;
+	}
+
 	mtu = mtu - hlen;	/* Size of data space */
 	IPCB(skb)->flags |= IPSKB_FRAG_COMPLETE;
 	ll_rs = LL_RESERVED_SPACE(rt->dst.dev);
