Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8DBA45
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068209; cv=fail; b=KX5hsuzwCLT0w5Vv/Pbr4ByMcQbQrB0JLYNBVYQTfhIWaeS56nUxWXlNUT/OvHd5RjGwMC21EbjaOkOISqjkth/EUDLT4jNSnNOI5m7732QVLcI9sdh+1jnMsoxbBzqLHbMy0oqMd45Mtz9Z2Vd/a5XqBIOINZpFlTjsq1CNhdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068209; c=relaxed/simple;
	bh=wa6Um1Tl/wgkGzqB+fs+kNVwPp3neZny8qSH4+Tt8VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WVTmei2TSucvMJS++orTMR+OYZCmKWkawVMOnhHcCLa+zDBwmIHJLNBK/jm1lLddE+YXF1DHNK5WvIvcKMosAip67XvRDO9n8ZjhKK+NTqEdqqEGWCJ/M5efDgbZtMXG70kpTMKR5BTxM3tq2qyFrHuWrJyypXwPzV2cQX9iRSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bk17+/77; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bk17+/77"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTbps0XHULayCna1ve2Fx7qQBiTYZJNtoaWOcqRIZmKgnRWbNJ4RGy9Ng4hj3CSY6RR5tQ5Idshzw31cKSCdfI6aRxiw1O6aPKPfHn4u/z08GvamctbM4fgk4uJN0NvAWpXlSxD3MsIUfKK9iZ6dk0u9mbvYYvURW9i3xmn8B2ow2J+6mbM8j3mhso1nbL+ob3teG/l2y3NMWpKCRyfqrp6enbLiInAOFWHQwgaPeXu3xK6ffG/N2NkaJdDm1MtsyQD4vw3xNU47zxuP4HsEn6j4069/M4VK8mmZNkdTXJKeUhtF1Z7SkHK6izV10Ps3DckfTJ6phhmurlsRqyXWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZqbvPOzKVjWhGUG8HGHYXX8Mt9JOkyz3Fjbn1SczRw=;
 b=yOn/IcVAlD5B+qo0HTi4V4HKksDpuQ7uNBgKA1KrFlbkhwFHwm15UmYY0NXcssfoXoVRL5ykN/9Ves9t0eeBLtcaxL7jXjGMAOmHHTX2B9bCtJ/PdZsN9gTvwftun3/f3Bb7l7gHZEef3ydZJaqzPRFPiJ6fz5xyfhOZVpY3GeImZx1SqqY54iZfjQCqvMdly8+sFGb7taSNqo9XpR0bcTmQJfNwSAa4ZV+USb/tMfmCGDDo6eVAy3jio4YGr6lEEFl4I7QbGOpTx22SSeEhJHtLeIetFQw8d7KSBL9sNHsEJ5+nrNSW1C8q1rE1E0uLsXAmXOsFwdZOFvelGBXKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZqbvPOzKVjWhGUG8HGHYXX8Mt9JOkyz3Fjbn1SczRw=;
 b=bk17+/77WSa/jMRcDxupMms9H8X1oOzpxER3WrBXxFlDzG6ab+mUg7X3Uhfoe6sM72MhRgNOWUYoaLNM1H9PlOjydAoEwKOg8QQkKrE5vT+A+XgBp6PAsi/Qq06DJhQgnk1bTsLKhZmAczoYrIt0u0FPDQVOf/nUodeIBsApWjQJcycw+wQBxd0ID2C6+31tUXzUAae+pdxQUN2GH2Hmce+FsJRKOW3inVvmjEJuSBq4vnvXLR2vSQlWUpXmU+/1J/JuEW+YUUsDlb7CRMEuvYglAHwn0EtYehseYQsQ6X8SlVfdkLmg4cK58bX0aBTAHzBnpdukx/Ef5d55/acB9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB999079.namprd12.prod.outlook.com (2603:10b6:8:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 12:16:44 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 12:16:44 +0000
Date: Sun, 26 Jul 2026 15:16:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	Jason@zx2c4.com, vega@nebusec.ai, zhilinz@nebusec.ai
Subject: Re: [PATCH net 1/1] net: ipv6: clear suppressed fib6 rule result
Message-ID: <20260726121635.GA313345@shredder>
References: <cover.1784710966.git.zhilinz@nebusec.ai>
 <4b8acb7787d54e440155585dd32ebdf0bef7d122.1784710966.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8acb7787d54e440155585dd32ebdf0bef7d122.1784710966.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB999079:EE_
X-MS-Office365-Filtering-Correlation-Id: eba4dbdc-47b1-4444-31e7-08deeb0fc1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	yK7UzPH7BCkwq8a2bD2psMK/JKEl1xvTAq5tsVct0KAZpcQyL40P1e/Se8oUEI1Vn9yqFSRxZvNlCO5O0VOiZpAQGZ0Jsdy8cJ2DB7GbhcuTwiWLmcnBgoY05e8G0efLSNRqxvTfNlH4ffRWnROemWMqNTRplU8QuPu17DVUvFIobKvSlMfzhMZN26NfN/tQaTWv9iMf54GCjvi//r771OnENCNnBUcVtPJMsDq1Sx7UYrVcSRZsgNdI5GjiUK7CZ2Olu5oQ8upxa7hE9stUdeWJTfIccc+cM9qCWbGaiBTpcz90GAIC6SqFNvguSyxnj+2AIo8gXTeX07/6Ppp91CBhzaKdlGRVs8t7XAK0NHnBkxtc1yQEeFLkBBoNWj7AYmzVvnGoKDrUf9O3BlXK987wJJhTBnTOLkmKyNejTIWOdUis07DEoIEz/0quAtPfXh2whBIjVH1XWMfEUrq4EEAewvNkzd8x1U0IxjTGqHKsLih4769jXnIJ3yMFqkcJjs3RaBVbS/tlq7iWgE+vORUkvJPRnHBUmSL4/IWKSeKuiPcts1/OciINeMwRTUYUd3TvDnAvSxGWf31YTR8wru0hNWqGwjWMvmpkJbVmZrovpkgs9b+IRfqKHLOZnnVH9WEcRJaMkTKgYE3wWCS3aHOZfGyyBs+/ZP+3l5SRfXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bu0Edguhf7F5xXfJPjiy6bFEdNm2/nyIxEgYKCj874xLnx/VSJLNtFys/YLg?=
 =?us-ascii?Q?Ecmfb+kV+EVr9zn0xMEOXKu1g/r88hVYHyc3kutGuw0fdP84XFlUpahq5kAk?=
 =?us-ascii?Q?CeGGEKbJrj9q6NLbYJOq0/A/ke+qlD4lzhxCl8V8yqmrjsVF+tkouPfsVdcf?=
 =?us-ascii?Q?KF7T9lIWAYFR37sguKkY2c4xuMEwirMzL5hWpXvTfIElirQelqeA9EneAKiU?=
 =?us-ascii?Q?jHwOlPpPx8HXX2YRAIlbdhGMBV4BbAtr1FBXafdruOcdUqjxE3joN3MuIYc3?=
 =?us-ascii?Q?3nwtzcc76rR6ObZ2GHcPNtX0BqZXe2OXMhJJuQVaSPUzlADaMQVOzCvngSKz?=
 =?us-ascii?Q?9bLWVsLCrbsYdwqitrKOjyJitKjtFfqhHKxW8vl+GoEQD7ZloLCLKTItka5P?=
 =?us-ascii?Q?vwwtFE01MjESteOmBoTM5PBCqzBpf+0QlDKC2sfh2PmjRaQM4eiGO1GwFtth?=
 =?us-ascii?Q?F+q5P3iBdS2ZztYnX5JPoSGYT2xEf5WWcDpP9cNsdxtnv9x/hNtPvljFds9h?=
 =?us-ascii?Q?AlITk4p+NbWqTKJe4EyQnGvn7RBYF2gdtZyE/h1HkjCY9Y8cUmfglJDx2bql?=
 =?us-ascii?Q?7513I68oibTcGhjUCPiBHUpWuyAD9pXR6IbhDyTCVT1943ws29mIsnGtaS+r?=
 =?us-ascii?Q?G1pFW4fIEGTwGz6qHNqrXrHyjDe/FJsWwnOypLVywZbPzAncae8qPTWiqYGw?=
 =?us-ascii?Q?y6ZeuO9kmL4XnUMjRrmhfeyz9xOtaLajr/xJ+CnZ2KJzzE48YIrGH90j1CyO?=
 =?us-ascii?Q?N0B3DIUMq545n8Io1wEM9ilDan2/C0TgyFAdsg4NWf7wir5JLDZZ1tT+A4vD?=
 =?us-ascii?Q?W3rvlfBzT+wA8WtvbBMccQlEh3A7pxmo++riQWjoHbSvbIrJaM532aXw4elD?=
 =?us-ascii?Q?x8qtwDuF1mmHqNEjYOQJ4j0Lwk4dP3ekFhldLLankQLCnw/HBKXTWPv4nFk9?=
 =?us-ascii?Q?7/sdvDvlD5zIuONxS/t3amsTYofJW0xaGRBE7bO0i9JV/uxwKgo6ptg4sMM3?=
 =?us-ascii?Q?GpjJrBcxkR9T5bxgfaRloDQmNGhUu6III3KoP6/jY8uuupGPR7wXwAxJP+HA?=
 =?us-ascii?Q?OfPIs1vi7VHbsvIYetYU7McK67I9z/FiJZbw4WxdD9SwFNIkegPabRwPp7Q/?=
 =?us-ascii?Q?MrAjdrOcnWynWxlJAHsLp4UPK8I9ReMFIrrCo3FIEQIzXBal1Ll1ZODigv4T?=
 =?us-ascii?Q?mW9sEnSgiACCIQIUwyCVWOTeWUBAUeYpXMZ0JPAxLoGH5amki5e9wkanTZ5g?=
 =?us-ascii?Q?GdICZgh0UEzSJ58dBkU/xBBVrPu7D88Nb7NVyJEUYXiFM8AzqywR6bWFJe85?=
 =?us-ascii?Q?/bQnEigYH7KI8T0uwFWCxCtnx7BoVguJ97GsKFY2PjBD0c25oL1o+su//IS9?=
 =?us-ascii?Q?mDZOOJ3FZc74y6qokG+jkAxmHd1PP8cbcZEekWyZzxgACoFl4jzfi/BlD1OT?=
 =?us-ascii?Q?cZs1eAxtcOdDXd4HkzuxI4EvjulhZm8NtTxNs4s3KiPUuuft8kMzUfKn/zFd?=
 =?us-ascii?Q?pLFZoSmOZpeYlOTw43TD379F4DUIW0m3riuCRVXQm8z2S7RRA3SffAwDJExS?=
 =?us-ascii?Q?htK1vl9etk/JJNH9eidQ5e/KQ8cW3KnCt34NQQEX85pcdaXEPzryZJec+E7e?=
 =?us-ascii?Q?2xnDyHiL2GvjBfryGu/b0jPyAUs3DvKToTk9wEaQYE0U/ucs7BSSM4RXB/Bh?=
 =?us-ascii?Q?NAVX8H7/xXVha3j9Hn1HPdabbb6Zz+eMPiKKqkyEI6svCb4M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba4dbdc-47b1-4444-31e7-08deeb0fc1b6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 12:16:44.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQs0fQM9nASbh7LQChr5KSIw07Kjf1yhmuTshTbOfiZ0OZp/F8MSQhY5/Y+7xnPc0vbsdqv3fU5N9rDxTpssUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999079

On Fri, Jul 24, 2026 at 12:48:52AM +0800, Ren Wei wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> fib6_rule_suppress() drops a suppressed route with ip6_rt_put_flags(),
> but leaves res->rt6 pointing at the released rt6_info.
> 
> If no later rule supplies a replacement, fib6_rule_lookup() still sees
> res.rt6 and returns that stale dst to its caller. A suppressing rule can
> therefore leak a released route back to rt6_lookup(), and the next put
> hits rcuref_put_slowpath() from dst_release().
> 
> Clear res->rt6 when suppressing the route so suppressed lookups fall
> through to the null dst instead of reusing the released one.
> 
> Fixes: cdef485217d3 ("ipv6: fix memory leak in fib6_rule_suppress")

Doesn't matter in practice given this commit was backported, but it
seems that the bug was introduced by commit 7764a45a8f1f ("fib_rules:
add .suppress operation").

> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> ---
>  net/ipv6/fib6_rules.c | 1 +
>  1 file changed, 1 insertion(+)

AFAICT, IPv4 doesn't suffer from this bug given that:

1. fib4_rule_suppress() only drops the reference from the FIB info when
FIB_LOOKUP_NOREF is not set and it is always set by fib_lookup().

2. Unlike fib6_rule_lookup(), __fib_lookup() doesn't ignore the return
value of fib_rules_lookup() and propagates it to the callers.
