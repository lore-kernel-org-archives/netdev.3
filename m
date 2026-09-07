Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843C472559
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795475; cv=fail; b=kY6RY3+iZMnEjFBHExqGcYNSLNWIULLnSCl2B5UiEHvbZV+fvI8PpEKo9QdKCeitCjMFi2+XTuFMf5BJS7WLJgWyv3dT8/9OhoRa96xQTBNK/qx7KsR+kMj+yZ0QKvMqcDYbFDkCCMpNCo0oSSW0NtwOEs7GyK00xbt1giICbbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795475; c=relaxed/simple;
	bh=YkI6tnKvNabBTBYFjDQs0X2vzgye1B395IUhamgYysw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d86L3ttVp6FdW0bMcKgKxOJLkD8VmRMFtWRQnWp+VrXqXnhT42jslIy31nNqDh2F7SwGKXCKJbCY6ALy9xZ4ctL/MF2I/zEUb4XyIlzuT77uP1Ilg2Ja15f4bvVmez18SfGh/OolAjgw8D3EG2uJEAb5Q0EcXg9RcNeTIuN71Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hdA60Hkk; arc=fail smtp.client-ip=40.93.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hdA60Hkk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPlH6TxVEzTGx6M2cIYzKqHVTkY2fu68kJq6Wcfy07xaeL/xJfv1iTFlkf1xLs9zmPmeRXEyPCcN6+8VN4IE3/y+scy1hX3YtnH/CKZ4J2Fy0XdYudpw10q8h9ydcU4usN4P5UY0Ck/vQQrAryi8Tm8fCboLXkPfsc0GZXsuh0qX0UNcOk7UyWaUCoS+FFoPCBjTnAg4bLu5i73lHzUA6/IJPqvhNO/n9z9CTSChDvy1jHXmBmMfN1Y/iMvCBdQU3ahm3oAqG9HDP9kRJRempuRehBcXJ+RUu62AOvthwCZ+MXpqC1+Wr54oRtxhlxymmNQihrGjY+c46XXX7ecbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbqgCwUDAXTKLYGeYKk+0kYrtPBlfMqxw6joIRXyyYQ=;
 b=UW9WjYdcztKjQJHl048caLtxLDve9grENcnwT/tsiuKuXnP0yk+Q/nEA/cDTyTai5fxDdbN5dRyIuRD2otj4Rn4mYHIWz6EmbGB8Ne1FaRytuYgqPCwX1O0bxGg8H9CATvRn/WkdOLWvBgloV22JPkteMnRYSJr2Fl9Yw1A04tZbrOoaEMNAyCNX5c6//SInCcpDkHAd06dv+o9Qy0e6wfsK1RQhKo87dSXtFrfhlQFS5anjb/fbVlBJvjMlEyyWehOfBGa3cpLJburXeMAOdCV2WGjyD1yUt7CSSB6NdnTsSnbeZ6+sqcNM+rnOcV6hp/SMpR20zY9eDc1cyInIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbqgCwUDAXTKLYGeYKk+0kYrtPBlfMqxw6joIRXyyYQ=;
 b=hdA60HkkNL2LPv2iwN73/OySr4wGjqwveycOXChWtlUjoT7B4BV++SLvc1aoB5TEKtnhNBeizD3EiYfZ1l9+ymMgBL1qx+X53zvwPCeiBveghMYq2JdJsE2XtPliGT5fIqB6t61I+5YHrnyMCr4EsMYckBOWT2PGaL4cUK3idpONsL2YN8E4caF6PgXceS2dLL3eqDfpw7KhvFpQhM425fYYPZ1l0SxN3wk6rvtGaDIjvV126fnBpucsJutS27zdrj0RGjvloUDEZHKzO8s5LfR0LfKqCfwBstF2EObFYo8/dKtzn3rwnmjd7hBhI9wqvJNhZOggjqRPEWJb4sbO5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 7 Sep
 2026 15:37:49 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 15:37:43 +0000
Date: Mon, 7 Sep 2026 18:37:33 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] selftests: icmp_redirect: remove xfail support
Message-ID: <20260907153733.GA755346@shredder>
References: <20260907132423.3353361-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907132423.3353361-1-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 43280d51-83a4-457d-d183-08df0cf5f55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B9lqq1QbEFSmS48MS+HIwMIvjmtG7xkdFLB753Ti9Gdwh7Z53T7WICMc4DkJvvmN03uoJ5zKka5wH0malk0G2gWsQX34gnoFjqAdqCI0/3oL+qMQDG61wHvo9xMUS1FhWQmwxsLIUlvXOFPIa0xU6FnB8SMSD/hlVPTu3mCe+fr/1BDypZXjzrpmtgAK0ix+JbOoqTH/iwsWoZ3T19jXosaxiOVYvxSfe8PWUsLi5zVeX0MUqv81LNGxKF/lVF+p/2dcAb2HXr4cUtGI31344GhG7gEu95/+7tjEohNaYLWVjppvZEqErlBq4f57C1dWdJGJFrBLqQwFNMfjPW76Xd67SqCfkjgYur2jWF8zn0pvtOSQfOESc8IVb8cZZXzNrNBsGdjZHT1paf52cZnAUIKYoibtZPaLf2jWLy6t3NI/EFspSogvtbOWUrBQ9ZeOLejsYjeGi6b8RlpDmnz7HydN99cWYBsltWNUPe4lc7KvkhVvyjYiptymtDucnu5W21m07lhI6pynIPDD86Z7nkXr0WnAqn2C17ASAwJxlzhEgpQqr8qFZU00lp7XXVOrdqZLEH+wy+Sb1FsLEfgUv7/IBajD/v6IFh2NjsKfMWPFPs8fmYyvViDxOmpxxLgy7RAnmSR6PXu0Tm7pJrCgNUpMycNtXnhM8OAnPFHDL+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBwx6/z4wN5DNB8SDmNufw2L2lkQv9eGHYFC11bzQ5GsLse2O0mXN0ircZt7?=
 =?us-ascii?Q?ap6SHr7l3+jSbnct3GizgrXy4MDMX3fb8CjpnkFH4heTEuCZzoh0DPseNrb4?=
 =?us-ascii?Q?oiyuj+9O++yxp76jIG6mgiAZJflHNz6wxBu8OmQ/PQD8xQntxw5vi4QTY4mk?=
 =?us-ascii?Q?Wl4xhJUHLDGU+oOQ/t+Z5tFWAjLCRkqxDxXDyjIix7y4Ti+gN1qkwJOtJ+Qt?=
 =?us-ascii?Q?N9PUneREL27LhECkK1AOMA9Dya1uNdH7Lu5kbljH2O3owTdl5+U4T5Zf1zND?=
 =?us-ascii?Q?4KhDQ62kUV0V3YZsEaRR69Ie2GIuuItbyN2opLLco393eydUachNLe/BZ3G8?=
 =?us-ascii?Q?3ucI8ynM4mEY3CCxyiXER/FjjCDvPFohXsxcf+xxU28sxbGOgCj2hWe7Hjje?=
 =?us-ascii?Q?BYHUXBdgxlp/dlt3Ild35tqYk9YkEJtuYChewYr8WXcqRcK61H5nyTotkAzM?=
 =?us-ascii?Q?BlUgCCW/dg8JeZfp1Srt2Wi3wdKGXi/3H+7pGcSCobTIX3PFJw9+0onibdIp?=
 =?us-ascii?Q?izqS2dSwqkN3bqgp/Qz9WYEeWn+Ajgydso7g99FjxXyvZzf4zVvNlD+o7YWN?=
 =?us-ascii?Q?2eK3/jEYRnORn1EDaeijz/Pyc7/oJGbv/XbzposBpiggggaR9uYBUYxICK2h?=
 =?us-ascii?Q?lLGzcayGwzZZhRpN3UHQGby20eYFUa6rikhXDfBI9mKT5fzVUYmbXEUD0Lop?=
 =?us-ascii?Q?sH8sYh6NTnNmc37N+u5GgTe9ByLv01YYL9UQWlzOoiiSwUy4lnrBUwF+Fez6?=
 =?us-ascii?Q?r0hPO/TKCQRkESFOv1q3CCbkJ/dnCmBd+b/YmRhL9sl9Y0qwQkSLYzJ/ShcR?=
 =?us-ascii?Q?prnsDV4WE0LzA/EJ/aFhGxZaUiLfiqIxgJ6Vw3U3nVznXFkxOG9GpCr0xopC?=
 =?us-ascii?Q?UOK4y5LTTH0HcPDQ2iM/F7xbBLeyxb8ZlXWZcCf/BQas/6BKakL2GpANn7U6?=
 =?us-ascii?Q?mfuhWL9vrSsaf8W/GDp8ArHqrVXc5VnYO7a8eTwrGRdcVrMGiXTsUFwl5sb+?=
 =?us-ascii?Q?FXa/IydHOQRfqg8nDPRYceDRkpeLenU7xZkKL85tiIPSMQXCNAU2cxooPdVB?=
 =?us-ascii?Q?L0BMXm/r0YbwIQqtM9tpnrvp0H+LagmXpPhszWQRTw+VwchhD1HujbAC3w6J?=
 =?us-ascii?Q?7XsBCxeYzV1WyDemv7ee89p41clXuv9kdWGyP3QfAGQ2Fm7L1krWj7I1Y4tu?=
 =?us-ascii?Q?BRe/MDpPnAO3emQF/RfQDBjXi7SZYKqLXh4MXs9OhKE7xi1AVCuXCMYwx2Od?=
 =?us-ascii?Q?8yBflcBfpw4vYIyaJgO6aw6Qw79p+tTe5NG3MfbUqvy+3WKU14moAIytfAOA?=
 =?us-ascii?Q?CktT7zWWZqqXYSXbMDEhSbMafjjBgt5Ix66VOzmYHd+4Z+rz9tUjT6Yw1E3q?=
 =?us-ascii?Q?eYEnnjWRi70M7ZnYjo37k3z9M4nlCbJGakwS49h1BwdON7/uAOPRR3xsv70R?=
 =?us-ascii?Q?WCOp8dGilPW4kctaN3PLsFOKqKkEJkobJYXQLdYp2IL4fQidmUgj4lTQCfHo?=
 =?us-ascii?Q?0TBdz8q25NtBKb2V4jyMWLEjaTN0HIVd8MVPWz8xMmVRjS5GmIeQYxTp9EGW?=
 =?us-ascii?Q?MpRpIPfmGLkY32KWIB1DOta6KwcpMaJxkmK0LBIobyO5HyH/U8CBedqqhqJx?=
 =?us-ascii?Q?0JU871oI1PDat6tQ6U/ylXAyGCsqpm69126/Fu/dfSxzljKn5XU0p1++zA1J?=
 =?us-ascii?Q?m/n32G7MOx/JE5HxIA+N+bsEBpNp+4G5tqTi1FPNcyxkAfvr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43280d51-83a4-457d-d183-08df0cf5f55f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 15:37:43.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPm7Na6UUbMo9ToXrEIJg1XdVwgKLzyI6cFD1yjViG+Fxk56FdYhkJjMeEB58nrjchNq7+xfbXXQho6vi31AMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766

On Mon, Sep 07, 2026 at 01:24:23PM +0000, Eric Dumazet wrote:
> Commit 0a36a75c6818 ("selftests: icmp_redirect: support expected failures")
> added xfail support to icmp_redirect.sh because IPv6 redirect tests
> (including the VRF variants) were failing due to bugs in the IPv6
> redirect logic.
> 
> Part of this was addressed in commit 0e02bf5de46a ("selftests:
> icmp_redirect: IPv6 PMTU info should be cleared after redirect"), which
> updated the test expectation that old PMTU information should be
> cleared following a redirect.
> 
> Recently, commit cd51b74bdd0b ("ipv6: Fix redirect exception creation for
> UDP/RAW sockets") fixed the underlying kernel bug in ip6_sk_redirect():
> previously, passing sk->sk_bound_dev_if caused exception creation to
> fail for sockets not bound to a device or bound to a VRF. Now that
> skb->dev->ifindex is used, redirect exceptions are created properly for
> UDP and RAW sockets, including in VRF environments.
> 
> With this fix in place, all IPv6 tests in icmp_redirect.sh pass as
> expected. Passing xfail=1 to log_test() for all IPv6 tests is no longer
> necessary and masks unexpected failures as XFAIL instead of FAIL.
> 
> Commit 3748939bce3f ("selftests: icmp_redirect: pass xfail=0 to log_test()")
> worked around a bash error caused by empty xfail arguments on IPv4 tests.
> 
> Remove the obsolete xfail support from log_test() and restore standard
> pass/fail reporting across all tests.
> 
> Tested:
> Tests passed:  40
> Tests failed:   0
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

FTR, I don't think cd51b74bdd0b ("ipv6: Fix redirect exception creation
for UDP/RAW sockets") is what fixed the xfail (I never saw xfail, even
before my patch). It's more likely that it was fixed by commit
0e02bf5de46a ("selftests: icmp_redirect: IPv6 PMTU info should be
cleared after redirect"):

1. The redirect message quotes an echo request, so it's going through
icmpv6_err() which calls ip6_redirect() using the correct oif. It's
possible that rawv6_err() later called ip6_sk_redirect(), but by then
the exception was already present / populated.

2. Both 0e02bf5de46a and 0a36a75c6818 mention the same test case: "mtu
exception plus redirect".
