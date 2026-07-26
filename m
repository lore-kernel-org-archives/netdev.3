Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075441DE3B7
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785052858; cv=fail; b=YpNpUwNqobQUJB5nageZrrznQ3aWYCyXON0L3i86oHgTjQXS/5Y9ZCtCXCyvvuVmK3h01VGEDVnIHgyXZEZoWKGMnJHBEWKR7TQweHTsO/3ATf+mAAv6Q8Fvd6gr4Z5vx+FcodbyQj0I1BOkTiaceOMzeAEy7GyGFVUv3N+jTp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785052858; c=relaxed/simple;
	bh=2rzdmxXpaRaUdiTKWNWzwzYbxmT22BfLPPM5U6jDmns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IZreDr9uejQDMMyvBmRYW5V0YliKk1NwuQJdwLUdJ6W5/sGNnJZsc4RkH90IazIxqros6YPtZuq/UmyiAQNF8k3QvZ0GQ27wKbJjKEHKId4Vr2b8qbtq7JC9dcLZYFyqSnvv8s6BweHQxccPic+jU1myw4gO5cPHax0q6e9s7ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kqI1ZEOE; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kqI1ZEOE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCqIsXsLUIwKh+5L1Kg6gzwfub5fIjxwO3mGg5c3JXKOsrpM4/FVfOHfPQEOtZ/GygAqrH2DS+zKWZaroZ4I5L3ab9OPPjq4RXhxKQQah0wDN02nX0Lls7ljJxQ+7braVhsrwqK8Unppj4nevw6GcpDtIkQLg3LhxRk19AQRKsshZ/Yjsq2de12936ThxAJUvKCPhqyvlx4sZvB5Tycgmb/augCImH2ZnJNebdoIdXg62xyim15soH9CtFsJ90bbOVhW25azyIVGl5YksfCdZxtisbd2QrLv6RSltv49/7b6EMf1FLyrLlF+cv+3AaaY1b68+V8YqQrF5k30oEK74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIEJOckp4IyJouaG8ZFXBAQzXt/2x9LRVyGv4pw0WSs=;
 b=qfIAEGPy1KWLMUfE5nkg14AejDgKSQh3wUYe9H8Okh2bXu4+vA6T/4oxF11HjNVdhsT6ewnxj/T4iWVgsJsmwSKFRnuUVlFMJFqe+sC82j5G4idu49beotoqxOWK0iYJMc+TDWlwApD1JtGv0KbuHVwhitF77mDTs94ArdM/Jzd/q6c9Qh6pFO5Zd73o97VFtaSQZwwTrc95P1EdDRRYLSAfN9kB9CRCfwQh/BQeYjo1T3Pe2m7M6P75Apf+kEB1OuebumMbNLUyJJMsy629N7th+qp0cWnhLdL1fCe1CDOK4eAEgcYjExraCO+DiuU1VaarCg2T0PLjbIBs+2N/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIEJOckp4IyJouaG8ZFXBAQzXt/2x9LRVyGv4pw0WSs=;
 b=kqI1ZEOERBg2zWmGHA9zbj/VJ+YrvTRreqbXMU+zJkHdXlA4MycgGDHA7Q84L8q68549M+q4PHaq2g+SbOf9Mu+eSMButrtDAnBkNdWBEXdb1zGlXgAgWapLdUcffb/EcvirVj1xhQ7pDoYfR1LwXfakelEfI0lMzspMQYY4nQ166KyWTSzn2vPTu3RiohO4eQjCo+VuM5x8510rQV3XMLXFtI4yS/1Sw2OKNHPzHeEbGjlQY3V/H1B7vncEzqNn5NXWkcG+DWuxn/l0g51HRTZYGqNyyRuHhQ54h0CXcF4E91VqtcTubkC40+yL/BBSNYPwi1M9RbzmqoUZuUjCfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 08:00:53 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 08:00:53 +0000
Date: Sun, 26 Jul 2026 11:00:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: John Haxby <john.haxby@gmail.com>
Cc: John Haxby <jch@thehaxbys.co.uk>, dsahern@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] net/ipv4: discard icmp timestamp requests
Message-ID: <20260726080044.GA201128@shredder>
References: <20260722102441.8762-1-jch@thehaxbys.co.uk>
 <20260722102441.8762-2-jch@thehaxbys.co.uk>
 <20260723090858.GA3224213@shredder>
 <B4BAD3B3-D795-4863-B20A-F457BE24CB77@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B4BAD3B3-D795-4863-B20A-F457BE24CB77@gmail.com>
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e43548-6ce7-489f-b8e5-08deeaec03b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PxHTG2aV1kZSYO9kih+LME9MkX6LAEU4OwKIbQns7w+pzakL3t3k1Zz1wNdQKblMkKnXCLmNd6asSGFMd4DLRUOYSjCB2FJK4lqq5V4eS5ohGd1uYDI7UXRizBUlW8ke22aupu6e2zh8W71UyKV+4o/9OnvMbcLVOc/lcleaka8LRsCTG6EkmnzgxNXZZm0K7us/nrOSU2ICA4qIvfbQcMBxC7kpgQhUv8edE1AWmm9BdliaWFWsRueYwuDw4IhPPbwXZ2FgcjLJ1RHavUmEspdgexDJkpEVzAvAV6b5dyk5m/QPbnbFWBFNw3JSHeFQmfzErWlCODDc6Znflgul6xciRM/b9+cAmI6F//sb2bj/zLvbbxFIV3d8Fuf5RXlBTbv6ePWeiBXP+u73nq+eRcyWuRR/Nq+GT8sreKbhv2bTRsR3+mEPpQoSdefDXOwAXCpHE8APVGXAYMXJpl18xyyGIEiUmMflWCFoB1DRdT7BAI56pfP215t1w9CaQgs8DVFixydn38M2TEUsOVhTaoDdwKV7YxFRmyPB0ThQs7r8MZnYu7tujL4PI+TOsH79yXbOFsy1eKO0gBMZ51MzHRBhU9rlPleV6O+0VKTDjZpzjWejZqcf8sbJyJV8bh+vvQjIVjdbTNyJjfUH1hM034cl2EoziyVTwyJSI/KdZwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7XS7fsXKBYVXj0VEhaDahdn/b0Acg9T8bQn9Tze8B8BsbE2910n3m24EVQZx?=
 =?us-ascii?Q?BqzSi/D3eNZM1btJFWzVDjNPPNGbzqOjK9F25m1qHjpOQMsIMeCYPiYtzjzB?=
 =?us-ascii?Q?2UqysqYpUc1TitTfWQdSPM1C3jB+NmLHlAMWUksOF809W2lnCPm95Ipw8mhH?=
 =?us-ascii?Q?QCXqzpgJo1+Hwxt7yXnmmiwEyVHRPFr8Ta5ItjbcQHV85WxU+Je4QTaipMez?=
 =?us-ascii?Q?kvbjjHC9HiVVrCogeRjW2vov6I88F+rM8c5a2xow77cBI9c4/zqI3tHz4clC?=
 =?us-ascii?Q?hvGy4L4z4xCt7xIKXtZPZ+ob39wq20mkTVYVU78cSXt1WcjlQ7huPBJifBj5?=
 =?us-ascii?Q?UNQeZebe3A73KB4rekQg1qddRKbh7tj9YLzZYO/y1pJMW9W5yyQpP9nY0lu0?=
 =?us-ascii?Q?vZ2EiFET4HAybJq2x1KIltQhtIfT+CPKNvNbdarWoSBx8ir2UJ8jxaeLpBga?=
 =?us-ascii?Q?Jq6zs4IYqaCXW54z3IZyeyJF6V8pdC7a3oLBZzUNSDfI6/p+VntVfEXy3bfV?=
 =?us-ascii?Q?RE3ZbkPTQlMLgqtiQ44LG25lVmuuLIZXrMZZ6IOQFxoWQ0UDYeBB8lt9KFKz?=
 =?us-ascii?Q?4NE5JEsNF2bCBHgiLPuM/2tcQIcMVe53VBuieJF4tIdVZL0HiOkfw+JKoRP6?=
 =?us-ascii?Q?BKYdx4s8tEqatfvgkmcKx1BHIOJW36nHac+vS2Nr3ZOQbDyUub3ILeETptiQ?=
 =?us-ascii?Q?8Q1gpYAeZPcWA9wXhUn9DtzYh/OTPLGXCqEjGweF81QPwksvJlnMT7KhSiN5?=
 =?us-ascii?Q?1dCjwqsgJ/jwPkoKCCBk3QDpqktg3Fj8na2EA1q3LVLWPNF69ePhUbHvpLSB?=
 =?us-ascii?Q?uWQxS2CzQwe6mL1d+ITuhdoSpEuwjtGhTnSkAF/cli8EH6agdoBoilYoecNl?=
 =?us-ascii?Q?MRLIJWxni97AsFrc5fMRWV19eGG7BUWF27HQTgdNdDZn1Q9bXa8YFaxB6LEl?=
 =?us-ascii?Q?fAxbTEvAT460iDSTywbqRkQivbr00EQGJDGSL/hGPO7YFo/VglzXsgs9sPMh?=
 =?us-ascii?Q?dRFjPatcqePWrsHPs0V3LxrUU5rNT9DJk3HFs7jMBk91zDpQJM9K15ESuIMM?=
 =?us-ascii?Q?FW9XdTd/ZXO45DgWa/buRMCWPyk+AhvDFiMr9D4llo6kFb6dSoSciYlq3Rtz?=
 =?us-ascii?Q?/uX++YC9+utBW7f2eUD2qi2cvLIwbNbkLGjIiXxYUP+JmfCHm4cUXHfFzREW?=
 =?us-ascii?Q?bg8skjeDKgwiPI9VOpFQiTiXA+N4eGzEbYawq2NKMUlI9eOAdBH999+8neNA?=
 =?us-ascii?Q?0vxVATuCJ5aO4Rf4w8pKMZH6qUlwjur7NNm1XdY5B5Pghodt/VmhjnxJ1Aw+?=
 =?us-ascii?Q?rkD6gn5vTCuqlrO85hmUJ0Moly0kNcGbuObtl4JRQDqkJQEQ7TT40cLHfTWd?=
 =?us-ascii?Q?KsqtWj91Q+zr/yVWLM6MHxvNIJuard5zUGxM1szcYSaR8MATmGrBUOgYS+3o?=
 =?us-ascii?Q?AIitzKKSY0PcGZBWswxDXGYjGcV46ZLuITKbVrgV4xHgtXdVgdRrsMWBKN8a?=
 =?us-ascii?Q?EnuWKQqqDFp3458j2nHDyR+b9YIKEogMVRwVJphFAFzQpaNmrhAkrPrbvz31?=
 =?us-ascii?Q?L5t8QAqCjx9NzX/C0XLJpXP2Zd/KG+V9uSTxTMETfM1bhb5MKCxEDNBM3CEG?=
 =?us-ascii?Q?59SV91BvlObwWNeiijP0zM3B35B0MGgusuMDkl5ie3ekipgAkwoMQcVakYcq?=
 =?us-ascii?Q?0kaCKl32weDX1qTRB4LkSK4QTg4FKSWykeV6jME/Nzji1jBX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e43548-6ce7-489f-b8e5-08deeaec03b9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 08:00:53.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7QemXf7oY26MAamMO4CTursDcJD5TNezjfmlTfc+4fRB49qiCnhrPD5VKZgcXfkZUSdo+7b6inNWod/6RCuyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896

On Thu, Jul 23, 2026 at 05:37:50PM +0100, John Haxby wrote:
> In fact, there is a reason to revisit this.  CVE-1999-0524 went from having a CVSS score of 0.0 (ie not a vulnerability) to CVSS2 score 2.1 in 2022 and today it has a CVSS3.x score of 4.0.   Those first two links are messages in 2019, well before there was a non-zero score.  The last link is, admittedly, 2024 but rather than completely removing ICMP timestamp (as was done with ICMP address, the other part of CVE-1999-0524) is provides a sysctl to turn it off.   I wasn't aware of that possible patch, but it assumes that there's a use-case for ICMP timestamp and in the few years I've been aware of this as an issue (in my previous job) I haven't found one.

You didn't provide any new technical arguments that weren't already
discussed in the past and rejected. The premise that the time of day is
sensitive information was rejected there. Re-scoring of the CVE is not a
good enough argument to drop this functionality from the kernel and
potentially introduce a regression for some users.

> 
> Admittedly, it's easy to just disable the timestamp in a firewall (eg firewall-cmd --add-icmp-block=timestamp-request) but people have to discover that after a scanner has screamed warnings about unfixed vulnerabilities.  So now I have actual time on my hands not dealing with the daily firefight of kernel CVEs, I had time to actually do something about this that's been annoying me and quite a lot of other people -- I mentioned googling for "CVE-1999-0524 fix".

There is even less of a reason to remove this functionality when the
"fix" is widely known and easy to implement. Not everything needs to be
solved in the kernel, even if it's easier for some users.

> 
> If there's a genuine use-case for ICMP timestamp, then yes, it should stay and we'll just add to the documentation from Cisco, f5, Dell, Oracle, etc to explain how to disable it if you don't have that use case.  But lacking a use-case, I still think ICMP timestamp should simply be consigned to the bin.

We have no way of knowing who is using this feature and I don't think we
should remove it when the reason is effectively reduced to "pleasing
some scanners".
