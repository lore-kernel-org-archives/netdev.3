Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A931D45FFA9
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982783; cv=fail; b=mGK5ISIeis/ZVwwtX7Nks1mEkHZf888cGQrMgNR2H9LofEHO2JvYC/xOKd9yMr/qrTK3A03Z+DixjkjdZZxRgSBYJiZ8RXsZSdULEq0YjlH2LyWJR1XZ2dvfrk/S34Qul+CaEVbessudj1rZesZtP9FwxYsJMfNZgIQotDbxHxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982783; c=relaxed/simple;
	bh=KN6hKzPnRMFh4/wY9yyt6hzkboFWEz139her9A18tEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ucKSnhDk9R44p4PUpJOSqekhphVAW+6C3CuNUeRc/wxUzmUPs68HgMnEMZ4I5g9hxpQ4COMZ3nwzAyZcSwWg7HNQ2EQ+2tExAc44LH+9Fc+wv2HFbd7dd9xD+/g3umdU3foKxEq4iiivqI3rgkBbkrP+lzDh7FSHSVqq+4tT6wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gt44NNyM; arc=fail smtp.client-ip=52.101.53.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gt44NNyM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwKIG1eY8muNBkGVDmRqmrbbKYQSk1l/LHztzUstoz73ulkHyYTNPkIqdT/5aXO+4UGrNzKi4ElXLQFRiam7lxhKMbKW6kp3q7GYqVhj+bzFRLgHmLDU49eY25Ct0wmHlTcjpW0I5wdG2tupzOsHx6Cb+pqZr0F4vAaehU88+bWu/VJWqjV2+uaAQc+padThA1oI4QgJQSgbk6cqdWUu3UKT0UbqxZWw3j2++ZRBkqTCYUQHjQXTBo4izZuClLBWrOZ/3Z1qJD/yUalS7nsx0cg3H3Cq4496ax2x2iUywOZ3zMjV5Vptlsrz3m/vVWMlYfOo9VXty7W57vDrS5duUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbxLkSulX7C6MwE9h3/fOnivkNEwPJiN5I74ChAqlRU=;
 b=U9ijJpNWK4nUgtKl8JN3OWV61kA5Z48G3Fz3/o8rhKQTG0az3C8MhuoItkIesd0P4iJcQi3raalM/tt7oAjBEZMaz5uxzXh9BUy0WQBywIgtlY6WHtmSK83rqSyvTr4fgFWR/fj+osmXzbxgI+gxReIPE2B3tCsJPIl7zaAqamLX6vO9jMEDAcRGQj+VNUVO3ucc7O08Ccjh3GXeg0uIBCIhx9J2VdLkQqqcr/qRTgP9oUSgbOV/1magKkfQJvNcBu5AOelHn0wwrc087mfCAWZAhd0D48pGVtZ1sraZVhCY0x5Rqq0DpKcbNjk4uYx7xLn/2BkSeu5n8XP0IU3yZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbxLkSulX7C6MwE9h3/fOnivkNEwPJiN5I74ChAqlRU=;
 b=gt44NNyM+EU4mRVzVezgVVlE+2Ob/Zvh+iPmgbYwBj2RBQZ3nzYi/fzzm4/5X/2XwFYylb+VA6EVwQXJ7AklXtYOMKYYmekhJDTSqLxhnnfVM6TW9QbuO3VLe3h3MBcW/0Pms2gj0ElnCWt67KVD+djjCdVm5Xn1ngEpY1hEC3UVNFH6iX5ptRCvqKUffQliunMxS7pwSKp3vzh8p2UXOtshUXLjOZCBlA2joT7l7DKlWJRArR+tQKhLN6vubsgpeO6uHxxJ2rtCDSk+k+rVclzYCrhilCV+iIExHnLjZ2/mxqyetkOdIKzt//8BcFvRZzQQVZvT+LcAlL+M4viIbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:26:16 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 09:26:16 +0000
Date: Mon, 21 Sep 2026 12:26:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH v2 net] ipv6: Fix dst leak for uncached routes.
Message-ID: <20260921092600.GA2103061@shredder>
References: <20260920191558.2990636-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920191558.2990636-1-kuniyu@google.com>
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 545041b7-5daf-4a49-14b5-08df17c262aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	CocWcGcrZ5kdMTFbLqU3f1HeY2eMVooFvglfKLEOLVXUUt7li17uVTXyAOnKh4Vg7++Kdq3lioRdQ+nR90M5/lxBvVvflkqJGcn7Qfe3zXZFb5fdsecbDRsJBu5T3LK4+AUmyDW59TAANhyYA33TA5/nApXBzhSZQQ8yAR5oCK4EaH/jNefTPjH/TpCURbd6efHfOHddABvTeyv/59ipiMCip46p9CPiFGVSGJ0Xkr1W7E2T4Gm0I+SwhaSXnSke5a2Y1UhY0rGa/se2nIkC9JK4PwLt33KjL8JMDrvrieRHE53bx9bzfNCE7wpnO99NBfDIYRwoCllYXTdPmKTvUfBqqPPmyV+cc+SNQu0KcLLBuTKhX5r62DoqU7Ny6GHgyC9pS4qV37FX0TcY5V/3X1AEe9U7b67q3I7ZJ4H38Ww38KOKRs/DcXjgoyATbGaohxBTwV0Hyrk398kigadeGCQsTok1L70rqsO4YBo6aqQPEubrdeIXary9Q9L048go0+hDlllcvVN+xDKU8I5jXF1h5bHZswvzx44AlsVwBkM/M8XPiqTFN1TryqdFz/gJHiTjUhfPJZ4txiJF7O7r4YRV/eWczyp9ShBxhrF+N2LGTZkvdg8xb5ZZD1LLwFmPui6usondOTdKxsfVDNBrgBMjqzzcywYG60aVKp+HCEw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EFs8r60F3QMSM8saTvWwasig1Edhyxhz/pPVRtcqjjI2FgGc6HqkKVljk5Bo?=
 =?us-ascii?Q?fFfzOu3xCDRRr/DEcIL/l9XVW+rJc76B8XyUQNf3yErtPka0Up5L1PQ/r29A?=
 =?us-ascii?Q?8LFNaWICgI1i1+s9w3r09/5HvK9w6GRpFv+vyJAZ90DCL2JTkwo/N8DajB8X?=
 =?us-ascii?Q?l+89ixh3Q5NVysUujgTb1BrtnE6iPTUHrEa0C66O1CbfKzQO0BtgLKE/92Nq?=
 =?us-ascii?Q?LKvvVu4WE+SefZInDB6vyJTg1106kqrSEpmqlvv0vKNVe2PyfSyg6HjizbkT?=
 =?us-ascii?Q?6YpYpfO1CJe6r4jeTNj4Q7N79GmpH7kPlJ5lcoRUoNNe5idfXsNI5ajxd/fz?=
 =?us-ascii?Q?eTH9OBwl9MaAr5aCX42tPnHCOtyZWIVQ4ysXv5ngxQzQ7JUKP1bvKWzh6PqF?=
 =?us-ascii?Q?uNoV/6kkCyLeUF2xUQ7dK2Jg0IJtijECCavOPETYTC9aYC6n++5hTSmV5DjM?=
 =?us-ascii?Q?uelYePMRQqfxhDK2UVzlQC9iPIKS/Ytxnc6FqtzTuMtfGnyyRTWlE+2qVzip?=
 =?us-ascii?Q?Dv96QDSqoN00iGCko0OCTP3QnunrAmrag/AGejmcxl9kyXqTx8JMj0mua4vX?=
 =?us-ascii?Q?eA86kolQmYzsUr50b6iqncs3Bu/a1J+dVREtSqBNct/gBWMn1kZH2Hgr1v/n?=
 =?us-ascii?Q?JyTXazzkTetasfgyl6eECDKenjUVNTp94YYOQFEy7GtpMm0kT63Waz/tzWz6?=
 =?us-ascii?Q?+kOUV9YlIHl1Xj9ovMtvASjuBUqp7PMRrbe7PUZL7NuLkjFg0jLX3c9fu0y2?=
 =?us-ascii?Q?HXOmNeaaOh7sXqVJV0QKSlvUZuJZLa28jSCcdcZGwwU8f6oSQS7l1Q7yQloF?=
 =?us-ascii?Q?0JHe5ga70l2+v+olsv/9Fj1aIdpMfZ5AFy3ZgMs1TO9RefOdVa8Wrbty+tlO?=
 =?us-ascii?Q?TDRqCGwELtuWdoh5ihT2aVXWF9l+YZoqNsOyj9HSaDh/6JHQ7PeTjEN4ZRpn?=
 =?us-ascii?Q?NEtlrNePFOswZHO41UXCTAzGDHX1H+9/PWTH7B38JqTHJ7/dUUXC2INot7Jh?=
 =?us-ascii?Q?GTugl0YHa+vyLR9qgw3PweVEY7hoKMjjeyGLeJdLJu1wZQ5tDoopw1cERBTG?=
 =?us-ascii?Q?sj0YWXSBN7QsD0bX7eN/29YTwntp4D5eXHIK2X53uyC2LR2xH2J+sJCbVNRc?=
 =?us-ascii?Q?ZzP/hRy75N+5nDCcDjdqKfyL8FHyh0KfRnxekQSvBy6QX1jUUknPuAxEaqS6?=
 =?us-ascii?Q?iMjK7zp18lf50B+BjOS5PzyHk37/Ngf6crmUcKNP2zEqtFmodqgtO3rIyXz3?=
 =?us-ascii?Q?mHlt45L5gZbe4ftoIYbEDRReQ+sEzzSdrQtwhRPG1lDgdtD1bHtrSPZJ/zHn?=
 =?us-ascii?Q?pRP/Er1uXn4Sssghs4hraKnRlVa7Lhilc2ewogKuwLhLZrc0sVO5TjoiRlIa?=
 =?us-ascii?Q?qdaWPkaj8AQW/F8D0aJL9IUhQE+7/Aty6giD3wVwlzkZzjCzi2f0WyTkZYX5?=
 =?us-ascii?Q?zgf6NkrQqNO6uUVqyznudwYmmgQYOJdsW86HkThixSSmG1lwCd3gXnpBTy6h?=
 =?us-ascii?Q?tnHJbeFNVtBBrzs6hSbBMjFxt3J4T1guqLxfGvnRqrVRsLDOoxy7bDo5YsNY?=
 =?us-ascii?Q?lIrCV4Eg+G87cdI+igS95VycIS+W4+coOhFtnL+0htd9s7YcyZMo+QWfx152?=
 =?us-ascii?Q?2dnHuiM3l6/CAOXEjtHjtav/Saxcaz/IepWcQgK60T5vnCVqzLXXLxkDSgeI?=
 =?us-ascii?Q?vYEVdPBC3MAxPUCDws1fMurIviC70TN1CQ/9Pkk/GlQL6uJRkeyPNAiHVz4c?=
 =?us-ascii?Q?wq9aWk8OMw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545041b7-5daf-4a49-14b5-08df17c262aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 09:26:16.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DShaJNSZA4myUv8lPu+vaAyqI/6oQukHLF5/ZSCGZb7uJ+hYZJhSAQ6ZAc6b2lrL5iA37wffkg/SanNlxdmCxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075

On Sun, Sep 20, 2026 at 07:14:32PM +0000, Kuniyuki Iwashima wrote:
> ip6_route_output_flags(), ip6_rt_put_flags(), and ip6_dst_check()
> detect an uncached route by list_empty(&rt->dst.rt_uncached),
> which replaced the static DST_NOCACHE flag check in commit
> a4c2fd7f7891 ("net: remove DST_NOCACHE flag").
> 
> When a device is unregistered, rt6_uncached_list_flush_dev()
> unlinks uncached routes tied to the device from rt6_uncached_list.
> 
> Previously, they were moved to another list with list_move()
> (__list_del_entry() + list_add()), and since commit 98aa546af5e4
> ("inet: remove (struct uncached_list)->quarantine"), the routes
> are just unlinked with list_del_init().
> 
> If list_del_init() runs concurrently, list_empty() evaluates to
> true; ip6_route_output_flags() calls dst_hold_safe() incorrectly
> and ip6_rt_put_flags() skips ip6_rt_put(), leaking dst, and thus
> dev tied via rt->from as well.
> 
> The same race is partially fixed by commit 9a6f0c4d5796 ("dst:
> fix races in rt6_uncached_list_del() and rt_del_uncached_list()").
> 
> Let's check rt6->dst.rt_uncached_list instead.
> 
> Note that IPv4 does not have the same issue.
> 
> Fixes: 98aa546af5e4 ("inet: remove (struct uncached_list)->quarantine")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
> Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
