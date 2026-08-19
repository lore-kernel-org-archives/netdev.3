Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997047F76F;
	Wed, 19 Aug 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152519; cv=fail; b=YTANUKtshGJqjLUzHFyfjeyYDUzl86GLi8k8cXUGUFxs1vE0GypKsBW/7Vj4wEXvZpO4EaO/Nc2qdUILsfAAd2qRbB3Hy/i5p+RV3hyoEH7vyfFiTpJIicyvwXBlMvdjSk6avHIum6u0R5BIiX12twF7TRTV0VwlBQCvFGddG64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152519; c=relaxed/simple;
	bh=Z8udBGmVpJj+GCq4QjpDDVn7TPGE6UndcL7OUDGTiUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MtgxDfzwUum71KQ+4RX40yoSaSuAjxerI05hnPY4Jn4mcmbiEQwkx0fCZJWqn3ump7/pcKzVOyERJpB4jLrawQ7BQLi+niHoTL8KPs/edzARlN7byRcNx+TwzO8rMQiFCVplj6GJ6gMPPbteEY/CgFLsZWlsQp6IbKNqZlPC/MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gue93vLp; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gue93vLp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4CkjnhKL4tlZvcuvS0R0RQYR+qbJ9DlCcGZR33pDRHmXLe7gZyLseKCthamOl/tHkbq0SG68ibAqIMIEeXq84OKIoeRIHs9blEMo9R141TOReR8erIoawnGR6KnAePiiAGV5KCrSDIG0e45c9jX7U2glQKh/IyLCk0wBEnrKxsmZYyeD7SIB2sTr7rVFrsJRPeFVeanl4tIEKfe6dp3kbJqomn9fCmz3LOWrZGUQDLmp+1Nhj6mm2OZQfIyokgsLhIIozqsbB+YbYvSGpMLSdCNIjEhP40Q+LHzawJiGloPkdSi1xZp2dDSV2fGYVbfo+uYpRmkftiR17tOgUvisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/QcZDWXrGuOr42SwzG6OczVTWTR0KV0D5qz8XyDErE=;
 b=QbUJIQU+Ij4vBsgAwnCyhVk/Qn5boEEiLjkOKzB2IMExbsGGUeJX9mL0St4wCO/i+EJqsmkCKPUWyr9/U8G7kjtJTyHXDZJXrtkD8KocjhQMwAvAL25eSFSGkdx3EqAzzDpnEW9sKNWBBzL7DzwVDPl4xnzAoZSX2G4lEK0cFvc4OzJtOfTht4h8scUk78cUsH2M1UBcmQgmW32Ba5OmqNl9VHUwqmgzlaJYr8qQmHZx33NOjuLIalshXs65PBBjn3KW7MaXR+3FtpyhbZifIepoQvzlZP0T/KN6tsJi5PL+26ovFwOdlUFqAtYEtmRmEENWx9Qu9ZP62c8y9EKgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/QcZDWXrGuOr42SwzG6OczVTWTR0KV0D5qz8XyDErE=;
 b=gue93vLpRF88FyX9vbwS6twm+uvA4BDdU+rgOrS9UVAyBEMYihtpMPK8XNePVOLve9GYxtQ4pv1NiFJYl1tyrJ+YsDI/st7VWq5EhU9v3dKyLULhqZF3MTBXFXh8RnGM+qd5nRQM0ycXyVua07kjZYSrR7zPlFQ2eAbRP2omI5irLOQLPOmlO+SrsozqGfsef0jNMalx3I3E+3KEEG1ESGpqE3f4Mo9ZuYjRWhTbQCIfw11CVaB66F93jNd4wUQc/8V/2tt7o6QHN5uxT1ZbbzxFFk5UplL70CGL35IxrHxB3p00rrAfKb1MJVETMqxJSQVoafbxFCC17ip/zkWk6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 15:15:13 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:15:13 +0000
Date: Wed, 19 Aug 2026 18:15:04 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kuniyu@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu, tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net] ipv6: avoid divide by zero in rt6_multipath_rebalance
Message-ID: <20260819151504.GA1248049@shredder>
References: <20260817013237.2797-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817013237.2797-1-blbllhy@gmail.com>
X-ClientProxiedBy: FR4P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a708814-6218-4eb6-7a96-08defe04aa9b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|6133799003|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	cc1ZPfHCL6JMpPU4bcm/32NkHYSYY2h19DC07zIajJeQgFjb/XyFjOBPKmnFWtFQT1RQXWDhHlkeWy/ksHQsVfsj6/7X81ghaAJI7IuODQhuUtVhhjt+hTMWaptaC3wR4NKZffEauR3UpcOZKD1P1ljiHwq9ncJW8LP81P9Nlmvad5Au04CR5esql+J6hB3xxbBy3Ts+oGBUcL0wJcGOQLbRJ0OErCBk9humTmRg809Rys+XS/Jgb5U/Kycf7y3hxZeKMU+svAjjG1R/ZPSQ1Zd03Y6wGrcJGzANrsblmzu9dMkXR3MRiH210zNxbkgPr1e0HYjUoSqZPz7mXGBQxDwkYQgEHiRyMq9b5OdrXi5RrhWXj1P2Mw/6Lb448AAQbJn5caZGbBqLvmq0hbX9+hh0EHrlpnhBZYPVrVt0/h9MuNPZ4yGKzVhi2g/XwU6Vb3WqiYIZgbUe304JrMNy2zRIYHUxDGokSBAkUReNG9KMkzmHxSDH5ivbwX0cdrLSbHt9K7UPFp6YOESkeMKZK857JDloWDVAxOQ7XDOn+4ZZIHZ/MmTDMUnf0jaeF4PKLRKTE8ZPMrHzH+Ar/kxKnjIY1aJuW92G9PUlbh+o0T2nBAq+1nIrK7blBvscr1+JsZ6S8XxpVfVXtaQ77gNRC0qaggfi27nvkWDo0kDW4h0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n+w/ptqS6ZvHZsRT8mHgMEbpSPsmKWCohVLkOI/togzozsuKpi3v5EAVm8Jw?=
 =?us-ascii?Q?NEwCMEf3dEoHQTv/znmXFjVnd31n8kGawHZKNEMpwv6GB2aI1qZw67vfpj9p?=
 =?us-ascii?Q?BvYAV61wB2qwYp5ubHcEpxNi2Fm/XtGOzMQjRBNBkpxMIU8vjvRdXVkCYtwQ?=
 =?us-ascii?Q?xzgRQRTut0jyMysTQmZPaUk++axeZCZMtDK85A44I9IvCObTBu3iob32CmCp?=
 =?us-ascii?Q?DLiy9zInDlkVs99a+VwZXMDkECbegvBJkYCkqybO2rdvzhsvED0Db7UCz70C?=
 =?us-ascii?Q?b61/VNRVyDcutC3m7EOyB9PfaNCcOWBbkk1cL3tzQMgG6qIdUP9D7XEvaqIX?=
 =?us-ascii?Q?9/Enbv6zhRsiKGWHRDEtjpQYXsvP5kmMjwQ+N2GPZIQElqOoA0Ap02b+H71z?=
 =?us-ascii?Q?zY2mMYxd9APBlJ7r7nGudTX5UAV4NTF4T40eNt+3qpnRl6nXZQCD54mTZro4?=
 =?us-ascii?Q?b8gpuG+9l6JfxgrVLq6u7s9EGzJ9LpBbGe/kbyFvarA78TsiOjRzT8ayxkjs?=
 =?us-ascii?Q?9LeN9OUJzKBf/S2yhxL7srfvwlo71yJLwi72wRr22dq7y3fySC28608exHqQ?=
 =?us-ascii?Q?m8mTqomrdxZGBzVimJ8qd3nxvJewSpZfmWp8li4mPdphgIrraN1EKpBTlk/q?=
 =?us-ascii?Q?GuPk0OnyRREClUq/DjzvKI5ngfX85r2oC+5B0ZJ1FUTYqW9C5auBIgbtxg9l?=
 =?us-ascii?Q?4kJl8lTrx9nHaOuKzSckPotIiIKxw+goSW8Tnr5iaSYkgM9iKM8f1XjyilOo?=
 =?us-ascii?Q?h4VVasgmNUO0b4OQMJV83qRoKDyBTiaU4UKdihRN6D/BLodGvqpwJT95AgAr?=
 =?us-ascii?Q?RL55nKx4Pnbxo5qJgbEvBL+0B9WBADNNI+3s04273wNsEOUtsimevK3utj1b?=
 =?us-ascii?Q?EiwZ+59gUg8egkYEuM7HMlc5cFLKlSx+1pWr5OfWBamydoXB+kNGDSkgjbMj?=
 =?us-ascii?Q?3G9nAm4hPNYcpWzkxXXxxuBNPTpI5+d362JWXSM5N9ivzBEEgfXXex4YT+wN?=
 =?us-ascii?Q?CAgAn6yzUNDgWTm//9ouNqcyO4iA7a3Osp82PrkNXJD7BQqxD5geUKJ8U21n?=
 =?us-ascii?Q?tiGR043L6yXlChx4MJBY3EifuaJEo87Alldf7ZUvnBfuPrdZW1RL9suvpMBf?=
 =?us-ascii?Q?e9zt2DzSAxx0YzZ89NWegxZ/B/NBWK/esgbp+z45avDbntf2tf4EJ7VKkuRS?=
 =?us-ascii?Q?9ZwNYG0QK66SI8ESrZiTvDoRoTRHwr2vePgeNu+9sDgw/k8QdBKp4p+VjfIA?=
 =?us-ascii?Q?NjGsiWduFT6JyZJSFgVxMX7vhHBJ9c9XaIIgKC5NWLEzSgMha49bnBfu19AN?=
 =?us-ascii?Q?GPEu9bHcczTHXSdzMctZzK2zlFKsPIXcUMXvDo1kSxe2TRWPcIYDF5pdjdkz?=
 =?us-ascii?Q?MXFttz6BpIjdUqN2aBQbnZQ/Jo5k6aUCXjA8ah8+dNhZVg8HboXX+VEMUBug?=
 =?us-ascii?Q?OuDvqHyufutfVf4Q5IwuMqLoFm21LBVpejZAcy6cHfLmK2GzYAXXUvWHJ/jN?=
 =?us-ascii?Q?ExeeDc6C2rlhAHWPxCHYu3OZMsDVQKeAt5cdduQtK+pNtCGLp3eVTFkXcfEZ?=
 =?us-ascii?Q?gPc8O0oT9vo9ZQ0CKHlxwYQAFGfZuOnZvQTG3dXALofFhiaL8tRSy8s87XIF?=
 =?us-ascii?Q?9nNuVSuXI7a24hThwnxQOaMIwRS4wtXoigtI9UW36NR+SAk12LjmRZiyKx4g?=
 =?us-ascii?Q?1EjDMqp0Y5GosN46zn5Giu93U+O0dW/lWTgqVML4LXTuk8H+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a708814-6218-4eb6-7a96-08defe04aa9b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:15:13.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tx2iv5FnchPJU+skWya3ZA5gxwtlTxYbfW23s9Du7CEkCgfkBM9JYqhqzt+EpeKB8c5A/SPWAsq6fQgqntDHwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105

On Sun, Aug 16, 2026 at 09:32:37PM -0400, Cen Zhang (Microsoft) wrote:
> rt6_multipath_rebalance() calculates the total eligible nexthop weight
> in one pass and programs upper bounds in a second pass. Since
> RTM_NEWROUTE is RTNL-free, a concurrent
> ignore_routes_with_linkdown update can make the first pass return zero
> while the second sees an eligible nexthop, causing
> rt6_upper_bound_set() to divide by zero.
> 
> UBSAN: division-overflow in net/ipv6/route.c:4845:17
> Oops: divide error: 0000 [#1] SMP KASAN NOPTI
>   rt6_upper_bound_set() net/ipv6/route.c:4845
>   rt6_multipath_rebalance()
>   fib6_add_rt2node()
>   ip6_route_multipath_add()
>   inet6_rtm_newroute()
> 
> Skip upper-bound calculation when the first pass reports a zero total.
> This respects the lock-free performance considerations here and solves
> insecure scenarios.
> 
> Fixes: bd11ff421d36 ("ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

FYI:

"Patch authors are expected to proactively look into the AI-generated
reviews and handle such feedback as any other kind of review: either
debate it or address it. In both cases a reply on the mailing list is
expected."

https://docs.kernel.org/next/process/maintainer-netdev.html#review-timelines

I went over the feedback from Sashiko [1]. Most of it is correct, but
irrelevant.

Changing the value of "ignore_routes_with_linkdown" on the fly never
worked correctly and it is not interesting: It is expected that the user
configures it during initialization, not after configuring routes.

When this sysctl is changed, the kernel does not iterate over all the
nexthop groups and rebalances them. For example, if we have two nexthops
in a group, one is down and now we set "ignore_routes_with_linkdown" to
1, the kernel can still pick the down nexthop until some event causes
the group to be rebalanced.

Also note that this only affects legacy nexthop groups. Nexthop objects
do not make use of "ignore_routes_with_linkdown".

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260817013237.2797-1-blbllhy%40gmail.com
