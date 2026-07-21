Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284B46D083
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657135; cv=fail; b=ZiaOeJKdmKG8JKrCJTfAiZaky4zjTvcQguYaIQVktiU7YN8QRsv3feZDz3MrdWOEDC1XUUfayR3mRgzzAFXFz8UCWZbc/oXVuJTgsjecCggNJwlqhBBrZyvqsdA9C1gZbjoiSd5qaTTZGgihrD+MklFCFsX+6aQ0SFqD2gGFevs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657135; c=relaxed/simple;
	bh=swwM18RypiHSlsigVbWiQYyezNY13iJL/akCoyArNks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E+zj3C6/4JfJCwKVqQu9dhqQlbS5ZfWIpPpoahqo8ICp9g00Q9dAS21DQUysfRKzW0VrVCVXialQAos4Cg1VYEu1LxbU054TpmzPfM/SfwYRASSkzjaL5AVfEV3nzoZBBToZwfrIm83deeQ7HnZRFam/P5/s+D5QuOo4uQKbLq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m4PznZba; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m4PznZba"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOI7bHXtYPwH27blM1d7++mkjTgW/GExPsr6uyYCVYK/3flMRGENaY1Cw3qqnRoX/Q3ooIJQFg0UacbXSTtLxlhKvDhPPMJMtvrNE7jT4Jt/EeK03ZiYmv1AGdE6mStmpO62jmjhObquY1Kw/fpnBKV4ZJXn7fmyceIh1qGA3RZoIb2/uPSTzCmkvLdk81NNvY1qW2gkt7KjxY70H56JIYdJGquTSKyxri4bPCFeAXYzw+Ux072Li6sNBMAwoLIIsRgunN5yR+CeGQoWJrLJEmCLJwmUNy3K/TRlzg0qDLJD3PzRDD1wwzDygzNy1QcAtCKAWILdVE3/QFMAk75bvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=277NT/LmpRYtkNshFiDGIJswDFONJw1aauzyYS7utc0=;
 b=yXoGPwGoW5sl1q7kFy/d2OR2b3TSt9wdqMPDQ3mbTqu5KMkiV/1b2tYbZe+6UOfwMpy6eBWVizOCpD/Oq6TsVPQrdM2cC5YfpUs9Kyg8ke8bx0s7hGS2EyjouIwTPk0iw5/GT40zKhE6N+Glu6YczV6TeJ74oQ28RDhFqnP7jgYcz+kP5UV+USMy/moweROnzthef9DPgb5VNyByScxKJZTl403eFVHWVOx8Dj/ao+uyegYWV9WPBYMXNuCzXEEPCvhnAlGUnJuRF/un2jEdyi58i0jbsrhYS06asKzEhY+W5p28IMtk+AsiIJud8DfSOdmgGwwNhISCMqOjnSotFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277NT/LmpRYtkNshFiDGIJswDFONJw1aauzyYS7utc0=;
 b=m4PznZbatBTefuxtnXhYA+xO7PcZEbcHlR9Ul12E9YG76gzIc8LWom4vsz9NgWKAxHbVWaRqmzUx0nBi7KOpp0Wb1Q/fdA4DjfH1EoKHPDPIxEKgonoJAohUS8IpPd/M1EMzcsrdNoZ9851C8bYkuHCuGVJN22qhBAN/HEOTDxv9sQK/PKSpw+HCfpOvetJzrYjVoBS1jqKPk36bGm5MS9S0U+G0ecgsYcIGuT+UZ5rUoprick4MHHsaLEmNoPV/V6pTjLUyedCaRNq6qD8nw3M7SBGukFPs5N8oIuPl62Ugf4KOQiHbqNDUETa/F+YDYh4Xzk7RKyrsKyKKrkZNzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 18:05:30 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 18:05:29 +0000
Date: Tue, 21 Jul 2026 21:05:19 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	dsahern@kernel.org
Subject: Re: [PATCH 3/3 net-next] ipv6: add CAP_NET_ADMIN check for
 forwarding and force_forwarding sysctl
Message-ID: <20260721180519.GA2769909@shredder>
References: <20260716203713.17392-1-fmancera@suse.de>
 <20260716203713.17392-4-fmancera@suse.de>
 <20260721122430.GC2592863@shredder>
 <4087bf3c-90ac-40d3-9c46-f0f95a60284c@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4087bf3c-90ac-40d3-9c46-f0f95a60284c@suse.de>
X-ClientProxiedBy: FR4P281CA0408.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::6) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d7df5c-77a9-4577-ea2e-08dee752a655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LoDkaunEFLZoOpzi6CGLSvbkimiPcGVQV1+zMRr10NZzt5z5i7X4cA7s0aMaHfRQUdi2jz7irN/Rbbxy6G5xHgYdpNng0u92e34/9Io7GKpK2pN97o9WJZaIhVOz3ErnQq+PL3XEf5MpfHrHO94jWzqGfSS0u8MO02r7QnYWZjs4YiqnwtkM+w0dVGnVx2Y2Q8BSzWIMDoa3kJtMZVLyU4XYAU3YAXUHeSNFZtwLZftw8aFv+TuAm0WIpNIWnEBAXQEz+SgRYz91Ucr0YwlgrpdDsT0AmuOCwbLnPYpEzItFcfXkE+HwEVcHM9Stsi3gHk0p3PTYGqvt6JINza7ovGkbYOj0tII4ADg0iZdGi2zC5ShjQDZyrMjjVPsD1Hw0CAhDSo0THDKa8oa6ZtldoxVolN1cRBBbtCuk9z5fQRUTVMIAVv7hsi/J0DVlXMFCurCc3Kvvm3HWtAe2t/Rxmdo7xrgcACyM6PYpCIvoXdMTGQFzzN7c0CFVG3NYuVIoX2Cp+7ukdQuOGMQuzXQDsdfZ1MsN7Yn57rXi2xQBOtlylXI32mWOepJabuFHjSvuDVByCFZH5/DtDHh7c0SZNcxt9iLCTMhs5oDSZ7OmpIPPwnUgDKa9zHngpeioqWeithPvbY2YBWFqZOTqhovQatKwYkb580ch9o/Mq45Vy0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uvuSRuJWEjWBqZd6BQ78SHdPjZaOh3TLRAEvNL8cY0pWbIaBp6EkEW3Ffc9U?=
 =?us-ascii?Q?veDF/e038FBn94RMuy4h0lYqY0YbX34DIKDOw4V9w8NTcovxwtAUBQ9gl+lW?=
 =?us-ascii?Q?9g9jRZMJZo8qEWQA5zd84nm5523zc9PhOnOf6FYSE5fD8SgJsyCzF7Sx7Q2R?=
 =?us-ascii?Q?TR9Dfln+T5uY6DXPKwfLWvX2OfI2WQW+BdJ1eIDt3tt807FbCq8v3eLjkCB6?=
 =?us-ascii?Q?zq8z/+oLl7iGGl+rowKs1p4e/dGzdFfgA6B59Yn4Ahi7gxRsRkU4Coum9INm?=
 =?us-ascii?Q?cr0JPyeCqf+Sz2xq+vEzAd5GxQt/CafNmTjw9axK+Hr2gWBIygwEb5qF7fQt?=
 =?us-ascii?Q?s0bGdRWdvvI3kZl9qd/mdR9vAuUn4x09tTXsz2y2gKghgPNFjqcynNbp+WUD?=
 =?us-ascii?Q?0Tbttkg9921HPM1ur7FZ+VKiP03scrHh+qp3qv06vVhaL/2bXyFkDx6hogUn?=
 =?us-ascii?Q?CC57Az6n4jFGYJdRE127HLLkpFs7EHBd5TNBqkszizQGsHYrnl/iuPeBvo8Y?=
 =?us-ascii?Q?RxQ4v/9U++IUwyAXH2RE/U8PXqunXT0RcpVsyFQw5xpBicqULdjAtehE+AtO?=
 =?us-ascii?Q?f9XUnhk+7FQmA4DI+KimcP+Zpmzo/+vfEzVtGaAlOjjZqafWiGn138xHoVdp?=
 =?us-ascii?Q?o8Z1wVBWrBPIm/yMUTDb8qb8CTQqlw8Xng36s8bwPu2/oCQfIy257Mvk88GN?=
 =?us-ascii?Q?dG/Vq0WXKzo4kaT9G/RTqiv+Ah6Xe6zG3kUqexY7ouqjw4f+oserA1uCyyvB?=
 =?us-ascii?Q?uJ41mfvD+0Bf9UsGDeT4zSqD1Xurvn3m/LE4p858dSmAydXUreTsgVVIaVAP?=
 =?us-ascii?Q?nr5FFSjyFeJH2hk6mn/qZVp0NkldSCBSBeWpVO5686P+xvT63sgCRrMRUXw4?=
 =?us-ascii?Q?57gRLcXqa330YtLz3dA1sSQZ5xc5pvNLA73jUn6emCL/N5UaHDPW9nPQhfsV?=
 =?us-ascii?Q?GBkcvEcv/1sCxHJSHLISasLyY3aj+YW00P0NsR9/ocwYvQgYrwrjz5nicjnf?=
 =?us-ascii?Q?PPnIzx9j8nq6aGuXBpt8kupbcVZ/iA8NneEJq6a1xdfXOFFEiP6HLpjKCcpp?=
 =?us-ascii?Q?N6d0qFOtg/QdNs50dFWAwzmdzdI/OippGf7kkP24iU9vvQwfyaTqfUcYlLhZ?=
 =?us-ascii?Q?c66Eq0yjQie3nZ8u5AFbHC1cInwj2W87RQ6mzUGQ6A7+5Uio6Dwa71mjZ85e?=
 =?us-ascii?Q?vGy7wB490tmik6VO7Wk3HYdWkUXys4od74FkxzzTBBkv2/2zLtXhMNui2TFp?=
 =?us-ascii?Q?eOdgj4ORe8i0dK6rt8IHAfnWxLjmrLlaefJ/Adq7b2peqODkMHvr7CdUqqzC?=
 =?us-ascii?Q?iI3xraUY4oM2CaBJmrpQMY15EjO0m4Fy8DFPOIjJhVMC1RFaWnSep4mvYygB?=
 =?us-ascii?Q?xKt9Y5zxFE7jxI2iCTg3IcMtZhx3X0fUd9XnGL2YfL1LfplT033CAPo1fv3I?=
 =?us-ascii?Q?APKJIN8eRSw/H3Oi2YU+/1zu3UgwY9a5kN6tDs9HSmN+qvJ8yh1/cZ56WuFo?=
 =?us-ascii?Q?6YtVCvu4P+0jqMSLJJzaKlmUtaj93NPcpEqll/4wSz/JjvvoH2x4yZtu8B/L?=
 =?us-ascii?Q?R+t5QlqUzO5YHmtmpHS2wVC7Q3K8Y8D14vOviQ9bpoPvg7HVWxjZBWO3cdSf?=
 =?us-ascii?Q?bkmK26VWNGRN0M5h2sqaUzcgqyY4vGB5E3hir9v4Hyo/WRujckHvE9MFc1lp?=
 =?us-ascii?Q?2r79NN8RNfqjF8MyEC4DT9vkq0z6m/nig6fF9q2TcXe1mCZPqX9ROoBXNZCD?=
 =?us-ascii?Q?jXwYOCqP8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d7df5c-77a9-4577-ea2e-08dee752a655
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:05:29.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anEnkYK5SiT773r2dGBG+2WrCjGgXgvZixmlL8PFfunZRF9azq7av5CK07jgIRXicUpUdCFxbe0fui3haNSdKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521

On Tue, Jul 21, 2026 at 03:46:38PM +0200, Fernando Fernandez Mancera wrote:
> On 7/21/26 2:24 PM, Ido Schimmel wrote:
> > On Thu, Jul 16, 2026 at 10:37:13PM +0200, Fernando Fernandez Mancera wrote:
> > > As commit 8292d7f6e871 ("net: ipv4: add capability check for net
> > > administration") did for IPv4, make sure that CAP_NET_ADMIN is required
> > > to modify IPv6 forwarding and force_forwarding sysctl. This keep the
> > > consistency of permission check logic between both protocols.
> > 
> > What's the value beyond protocol consistency given that it creates
> > intra-protocol inconsistency (none of the other IPv6 sysctl handlers
> > have this check)? 8292d7f6e871 does not explain why only forwarding was
> > changed. As-is, I don't see much value in this change. Tested using
> > [1].
> > 
> 
> Ideally, all IPv6 and IPv4 should require CAP_NET_ADMIN as they are indeed
> configuring networking interface configuration. I thought changing all of
> them all of a sudden would be too much so I went for forwarding only.
> 
> As to answer why it was done for IPv4 in first place, I guess it was done
> because forwarding is the most popular option and also quite relevant in
> terms of impact in the system behaviour.
> 
> If we don't want to merge this as it is, I see 3 ways forward:
> 
> 1. drop this patch from the series
> 2. drop the permission check in IPv4 forwarding sysctl
> 3. extend the check to all sysctls of IPv4 and IPv6
> 
> Ideally I would go for 3. if it isn't too much in your opinion. Otherwise,
> likely 1.

Please drop the patch given that it's merely trying to be consistent
with a change whose scope was never justified. Option 3 is not something
that fits in v2 of "Misc. minor improvements on IPv4/IPv6 sysctl
handling" and requires careful analysis / breakage assessment.
