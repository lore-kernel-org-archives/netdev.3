Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB403DDAF5
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274375; cv=fail; b=ksNoI80BvvNFZ6ysXQoNKqRqBCj9hWEdh7XkrrJP5p1tlJT1mpIqVvmJIEGumH78FBs2Lkc/csZEsrSM6CeFYnbu57LbHy181ikcGte9w720fse0Q8vm58qnQT2icC9n27oW7YljaVZ/xv25ARVShuXvt1CZzR3Kp9aG+qrUNPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274375; c=relaxed/simple;
	bh=Zms3rf8SczcxPSkqpzPcHQPYS9862avARhbRn27hpM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rZcVCOzUOqnEHnA499XyroRYS8MnIFBkyelpPY5/IfJLXDq308tEm7e34wU7+dXWfS6zRh5jd4IbtG0YOWMopfHGNgY9wGOVDzSNXVSp4CmFWm+DnNoFWrwjL9bc2YDX3P68GtDkezHbHZ8wvyz3HFjb3H+Jq9obxoFJamedFfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQOx4QwI; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQOx4QwI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re3p7cjh5Mpa0gkDb6RE+8i0mnZsRsrFHiro3WrOuK7tdYW+nv/t14YqCAg4kJuD7/WuaSEm7vTOPVVh4qJniIxSFh+7nm7wXA5DtoLJdgjjevMxSPkzaAhqybwni7eBfXaaBRsGVkK2xvcyZF6kcmsZMY8D3o2w9640fDObUy0WcYKjm/foDwMVFF1tcj+oldbMxlqfIdxFexMHA+MMjfq6qcJcnEihFIrQsC8XaG10ARZXa8g7GDgDvv8Fp3Y1HwMpMx2di+haDfLFRc4mEFlEgIZ8y0uwEuIXh2EjIXE8i97GzQLlOl8MVVwnPU62rhQXZm0GRhH6NvZ4rhdLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH+S8yij+1mG8LgbTZ9S/pql6SOCBFXIrjFMp1hAQb0=;
 b=jJCfEXpdawUOl1awxYvru8X4marXr2L7AixvCrq5UYfYVx0XilUv6k9Y8mcz/YNga3uNjdgliq2HWrQI1/Yr+U0r4F4r03AyaSzZZLfMCgNsco4DvEB9LrxNzmoUUWXd7sNtjj9xuz/BxShcZ3CCHctgGToGd42GHdcN4mlVeykLMpZfhMrha+/ec54qDcJWed+7KOeJv9xkYpn6IarW7lq0CbUjwepDKCoOt6VUvQ7RgV0WrvgcvqMcZnbd/PheVrOfAn1YG02dJnV8mwH5aHAuq+GRds0Kue3txsy9iNi0nI+LCkZBZYzvckWj5bN8Lzh/Yd0Gl10Nwh3/y5womA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH+S8yij+1mG8LgbTZ9S/pql6SOCBFXIrjFMp1hAQb0=;
 b=pQOx4QwI/eLQ7dEEViGUUKUUg0xmNgltywKIJDkVf0s3agIO95LBju7vTZpS+PK4k8ICwxb4R6O9F78vtvvhj+ESO+VzWAtxkADCLPcLuvm3iKm7VHqkUvxpY1L3Z+7vPc8C49MkHbjTKpsBc7/k/XpBP2c09pdZHP55Eg776lQZKrJbfcy30J29GkG3JQS3YqGGm//mU4ntC2jHH5vFkDQPguKqCXvOd+59co0skTfzDMZ2RYJEOcpuYaWw6eyIXmXL0aQbEKHtpeCbPU0ke0eZAqwjvdI0jemgNQRPh1/K/hIXcSOFgcULCgmBt58hTvPe2jkcls1DqAdqAtQGaQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:12:46 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Tue, 6 Oct 2026
 08:12:46 +0000
Date: Tue, 6 Oct 2026 11:12:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chris J Arges <carges@cloudflare.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 0/6] ip: Batch flushing uncached routes per
 batched device unregistration.
Message-ID: <20261006081237.GA582799@shredder>
References: <20261001204752.2572265-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001204752.2572265-1-kuniyu@google.com>
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: 61fe9554-5557-4c3a-2596-08df23819a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3usVpjCaXk8HiFnLhRjgurmIqTCvnjfK+mlA5J1Lc+fIltjmDs9XL3eZGLvM7G6sgSOxoyr6vbGy9QpwtCorH1zcZcDvfAlHhEC0IItxrp90gdTZJZbin92icxrurb4cNKYf6V+ogpVRvlUDt5lDaI49iVg/T8JMA4lGKDq1VrM8a966rFEbEeJppnMQvGAcGcMOxS32Khcf7ekWLJpgbSeZzB4o6WISUzs3QhzZcB+zlVETfNmTR1YWQy4M9BmArojO64vZ6O4xyGdpnd7HOGJgL8SBT391PbJdzohwG+ObTym63fUCXv2zCBlTIUbNUUkWz+dq60r5QlmYNqZ3Fpo7Ba0yq/6laBCQhcq1U9801TE8+2/U5LmQcDCwf9ZsmvFKvBgBy1fxvr4UznONXrWonV8dp/+Dn0VIsm8sJyhjwZymIRrTsRsVSsyFUAlaB9q48q1/pqGai+M6cTzuEep5F5gKkLzIqjE2F381A0WKgL5fFpMZk8OaRq5L7d1hKKdM07F7m1S3l/HBcR8S+656468DGBlIMgtJWuLoRm+6keK6gKFag5+sXywtffFZmRoPcW8BoR7m4s3sQORzSHFJ/X4kxHNXcNb6EUPyWe9cY4lItbp6hbzks9swbUWYNOIFjIAq8DLS5GzI6va0oI+FO75rWJdi/mmjmu8VfAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uWBTYoJ31yYT3q7hsvtxdMqeRqXhvW5upUuIofyKF9Xg+4TvgB+m6iroiksj?=
 =?us-ascii?Q?kz9/OwuYCCC80irv/MPKAV1UYXMMkia2vi0KuPTQO6DfoOcoIHOZDBLhG+Xy?=
 =?us-ascii?Q?2B5iWiFf8QAb0NJV/INuA7zCsAGhf6E+psFlVNW6SK7eYTCnoIadD5Ll1KXb?=
 =?us-ascii?Q?lyis2ImzMSAAwTWHn7J/x9wFl8jR1QoE70LgLEqq1W441ntQWlBrgjECyjgN?=
 =?us-ascii?Q?FOX34GLNGTICMkrjRIYjPBMDlqLiIG/Qb4W1Tma2dgnd97k6PZL6COt/yIfm?=
 =?us-ascii?Q?mBWzSdYnCpj6hyYBoNTtxXVJP5sUDzUA2OAaGhhIe9dUU4dcQ5S9SgUnXgLQ?=
 =?us-ascii?Q?juVlOlsdW+0LYmE2iHAuqLlXBxVzBQCWnkLQfOTJc6TU46Dv3gYGyWJ737Q/?=
 =?us-ascii?Q?tVfGKTuoSTMBDbwb0OmqAuoAVsP3/Byqav9xsNi4g9UxC54N8sgKSIcQxAiw?=
 =?us-ascii?Q?vjVWKHNbp2AmCgL9w4ivJC931XNZj3f+nc6yf5jcYC0Q3sGGrE9vZNBhwIr6?=
 =?us-ascii?Q?fVJlj580GlyUrZahPkudc8dPnDKUcQ41rbtQCsokpBIk+6V4pVgpQ9MwF40g?=
 =?us-ascii?Q?ABdVD+15tJJ7vRkY6URy3GKNOJDUd5ymBJTqsyf3DeZidx8cw+OFWJRN8paA?=
 =?us-ascii?Q?BY0Yrsc6OFCsdyUnQ/QyXjK3ey+joHkg1vBpA8Ih2zc8HV++RTD/u5LuKUfV?=
 =?us-ascii?Q?U7WiLf4MAd+XWxF5T2Fz46fcGTuM6DxnkYSj42FBSnXfRwjg2A18/A42ZAZ4?=
 =?us-ascii?Q?brDMTFAeKqd6JaoiWTvC20V1C7jmdYZ2w8ud5m3+bJkK22nuYxtpBvgFWm4k?=
 =?us-ascii?Q?Kmq4WAvBED72l5CXJcNRzFFFe8ftXxSNe/m8AAmaAF5PhFOymU4dK3VSP6oD?=
 =?us-ascii?Q?kLQ6At3BXUzwQcY6Ci6nFz+h4ipdL17Ve7cExPu83w5TxpkWQTxZo12NYt2s?=
 =?us-ascii?Q?z+WxCZcQnL0P2hVPJiL7RGZ3f0Bj6EOjorAtN+FcmkUAo/GVE5iM9nHIM5mj?=
 =?us-ascii?Q?F7QBTaqfYO3N3fR1aYMW+Xh2r1ofDquZf649f4wnApjkd9oBC6IsKBsrWmyv?=
 =?us-ascii?Q?2rVsW2Mt3ofbPO71JWIKRpg2gzF5XXLT0tI4bs1jM+rf/MbFzfIW+ByPqgAN?=
 =?us-ascii?Q?bkwi3s+CgHVcGj8l2N7W+XmI6Qt2kO0mfpkTUSsfSwT6PQEwH+GMS7uQQxQt?=
 =?us-ascii?Q?IgDPyRTsL4yOk5A3iIzHE+L9vTgGgl+VpYpoGj7lRFfHKoH0KMKianLRb9Do?=
 =?us-ascii?Q?B9r7DCW7TOgGwpou4gfCLadTD4BnT4e1ppmd4idVMoOlcYEvwjzHxWd6DfWD?=
 =?us-ascii?Q?tEniD3MyoSmMFChdPfgQJw+KMKyHzK2WV9e+fFiKjGbZGDtzECbWWRHZUXZZ?=
 =?us-ascii?Q?RZeR8Zul3ArCCAyOaw7sVPtL2cus7IwdiZ2GgesxjsPeb7RJPwrtQwaCFYPL?=
 =?us-ascii?Q?32uTJ8JT7lSm47b6bEWtsyk1eluy1enYQ4RU1LtdbgX51JahPlSo1wSbUV2y?=
 =?us-ascii?Q?FZEg+l7GKSCF9EbrhdvmmT9BmNCjOXZgsHEL4hL0P0Zdm98r23yNB96B14Hl?=
 =?us-ascii?Q?7sNXb8xJJWzhIaXwnHEDR6GB3ZwvLxGNVu1WaXKUSiKfkzl1FMnRReGWxoaL?=
 =?us-ascii?Q?WVOPsMCjvPBNRabmq40yr0LzXC/iF6NV/daPtQZ+LSpS292eKHY4T3RR3Qzz?=
 =?us-ascii?Q?ExFQoGMdXZv4vgZgRVFJqyOmGeDU/MqGuz3v9PW7GAImmmxU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fe9554-5557-4c3a-2596-08df23819a61
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:12:46.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ygnz5BM6te22Bny1FpEj2eboO46DZ54SviIN19F2SgwPeCzSt09SqyJ/qm2lsq+8TERcas8GEwcpSp/Q0gD0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681

On Thu, Oct 01, 2026 at 08:47:12PM +0000, Kuniyuki Iwashima wrote:
> Chris J Arges reported high RTNL contention during cleanup_net()
> caused by rt_flush_dev() and rt6_uncached_list_flush_dev() iterating
> over the global per-cpu uncached route lists for every netdev in
> dying netns [0].
> 
> This series resolves the issue by batching the uncached route
> cleanup after __rtnl_unlock() in netdev_run_todo()
> 
> [0]: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/
> 
> 
> Changelog:
>   v3:
>     * Add patch 1 ~ 4

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

For next time:

The cover letter should explain how the patches fit together. Otherwise
it's up to the reviewer to figure it out. The dependency between patches
1 and 6 is not immediately clear. My understanding:

Patch 1 is needed so that the IPv6 uncached lists are initialized before
they can be traversed for devices that are unregistered due to failed
initialization.

Patch 2 is a cleanup that is made possible by patch 1.

Patches 3-4 are preparations for patches 5-6 that are going to walk the
uncached lists once per batch of unregistered devices. If a dst entry
that points to an unregistered device is put on the list after the walk,
nothing will clean it up after patches 5-6.

Patches 5-6 avoid walking the uncached lists for every device being
unregistered. Instead, walk the lists after one or more devices were
unregistered and delete from the lists entries that point to such
devices.
