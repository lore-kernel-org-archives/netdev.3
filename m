Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2F3B71A5
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104660; cv=fail; b=WmUVZv12kC9QRSR4my65ihHGzKott1L7mn9tw+lLLXjg5zoYzIj+iWl4FrTsDkrZCJk1WelvJYPDe8q3aWkWxPZRTd9mtFSAxMa4k/xDrL9pucCo1Ochw/jfko1X9m5N2RN0ZGKegrm6jgQgFcqdk/o45QP6PwPoJhqaTr84GEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104660; c=relaxed/simple;
	bh=h5JjPFAErqavkBFiai/sHszE6xmLluE/nLNDtMoDhTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ma9voS+5x4G51bRMtYJmlHOL12HTJx+ZDzgu+ELFF48v7wWnGEhCupIcWfgBWj0OBJ0yrcHrz9wZiawtiFtbflxBUwHGL7YtRp+4u7A22AGiNVavqB7wb61Hfbyj80Pv7p6RaavJredV1jwcwEl8OxhbdurK7rZ8KNi/ZILNx2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KXRn92Kt; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KXRn92Kt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGTXXOyqgaKOczdn+oi39EyjlGoHjjc9nfx7T7CInX77zhb2mBj4NJsXBF0zwD1ACsccfwU2iyN9ZTE1pnELqRY1BbSOYZLtXAZRYodJVTGvX7BW+TNA5XIbRKYYLln2WWMfP93Nx6e7kCvMSx8Ia+JvEJ7AJfCa8nnr9el65VgvnrSnUG6SeaLmwoepPwhPi33TyasvQR+81bVogY0g7CikofuXSEvg6DyrKMHhIkcCS8dMFIAG7+5rHzIDlhFkAdrIyqQWLrrOD8m7MJ2pqBAkS/CSRpuai8C9Cx31NrnK3q2SnTT7yE8+Wo2ehyWaGMDbnoGQeiXlgFFvyssZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25pNKpuu+IICSyIL/FujsS60iRsuoE2DYYYdH+CWepE=;
 b=bvVMu+DgNwSTgQxLcaLdePwbPVLKzfBU4AdJrKPwODvtSFTB4kXoxg2kuK1KRgQhBTAn9Fm9MCVOGHWTOqigEcd5uKRNlHvp65cS7LVjU8PjbPnlPC0udK9SZq4GpMjLQRcGMzqifsC1iAUHgUXNCyU1r7vRoNfN5OS8ezKLjt+ahW3Z9CY77P8CY2hzetomXWKV9u+xafT+Q1L7ESTgxSVHB9mhDQNCYUMu7h+B+AJzRCHekvLtdZ9GfLDJSM3b2EyQgMCi0zzCwWDx3rr4GmU6/Vy4028kPKvZEw3zR4VVQOZBZRQJOt663gH9KsKirINudWrVxH3kanaoCAnLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25pNKpuu+IICSyIL/FujsS60iRsuoE2DYYYdH+CWepE=;
 b=KXRn92Kt+c6yMsE6lsHwQS6cjejpnubewmIiwsAtYNyeAGEtC+CUw3qOH8sTeqzw309YLNq8q21rUlZlO8iJSEvKt8mwqCc975P759ArgljDbOtUogB6ZB1kY+5Y/Qe9bqkZVNK+YtvkBISC6nCFlcE22iNWHdj0ItMjlhkZDTKRIcYyLCvEg8gXsabRDwtZQ7eFkFCOtbIUj8LMT1U0rN4NpO1/60NS9t1OhGQnIoqxwG14QO655Xh9aZfJiZnxwXNOrsBQoVjnncYp9q3zOFamWGzOUYMrzcgxyIpG2V4Rc1GSAN2UPHGaNznYDg7vl/xDX2iL6p7iqQnehHdd3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:44:16 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 15:44:16 +0000
Date: Sun, 30 Aug 2026 18:44:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH v2 net 1/5] ipv6: mcast: fix RCU list diversion in
 ip6_mc_del1_src()
Message-ID: <20260830154406.GA2974032@shredder>
References: <20260828084531.1826790-1-edumazet@google.com>
 <20260828084531.1826790-2-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828084531.1826790-2-edumazet@google.com>
X-ClientProxiedBy: FR2P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca0fce6-a8c7-4a9b-bdb5-08df06ad8c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TFDPoMfNxD6bbUDHY3NNn6hfBko7VFR4nQ519xDk5S0+xw+vV9fSaR4JlulytY6RYo+vIwjFwQrrQkO+NyUWryNieoLBBlQuR8eDbNot/qb5jG9cSblHttMhqGzOe/MGTimz8VRus/KDV37N8Zp3qZY0wBHVthua/iheLxksZqEK98We7wK5/YXw7mi34yByLMUlQ8bFbi1B1zuZQLnVn9fKMEspv8B5sFuzkgs4uHU6oFohxYs6e0CSeemWH0psbWXKpUFsAeTqi5ogCxMOy424qwO+ib+sBSI2BkKmzD/N5LmuUNZCqrv51LZhjWF+oJdgfQ0jUKBavTNl23kgSCGidDjpBIjJ0cJg8E29OMJRQQ9yRyywVg9DuXcVj9HlUNoaqNhStRuGKT6k1gtwgC5keC/xRrRLvlWyYmcZ8Ua5ZIhvDuzlJK0eSgvH+orytfI4KkfoxKmAdo4oL/FytmgUIudyOWFZRgc9xKumecQ3osELEQE5avaEjz3r/uQcCzndKqEiSWW8BOdfEHerOvUhlqwoqSYnjWUCyhuWbEb0gUmWtZxsDy1xLsZflw1ufYeXIJu4gqBC/fmmVmPsueycmxUrIEMaAljS0ULWW3RbIxDDZ8SBRU8WZqOmuIjtHkcLgoVWMZpwKbfaLcMYfwLI6jQepae6/vF0SwaNYDY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UYmYEs3g78/HWzNlhrOzLfN9HekJTqLrOyBK9xubftidQH07I8OEkOsGxX47?=
 =?us-ascii?Q?Ack/y/SgRABXHOUesYmIAYUI1L5enoJ+/R9fEhjY5hgKT5oCTDoSyaL+wMNE?=
 =?us-ascii?Q?bTOGCoe6vgGfahmEuKSK302V+RE8OZ1kyH4V6e6Eymx4DXloqvwgRq4l0a7C?=
 =?us-ascii?Q?G+5sI9/2MsxhBMRoRztMFXlxxqlSM7Eh3OgaURxTc++85r1Q5/j3VjaGYIRK?=
 =?us-ascii?Q?a1nwtH7ef8Cl7+3wkQcyb/3WlfbKfdFHucNfXNNQtEcHCv2B0SQWSXxWitzi?=
 =?us-ascii?Q?dFjirDfUNoQRQU9XkjD7DaczKO5gOfh7P9athUvHkvX59G2TfGr42kjuZ0d5?=
 =?us-ascii?Q?amqVQSthSzUkFqjw8/w/wVs8HxI4MVDV9sYY3az0SUvYv9bkQ2c3kM/l3Gkz?=
 =?us-ascii?Q?VxWe12g8qgmgyL7449P87ntLFiGPC0nJegI5Olne/PsNqnyMpK0EWfzFEGQG?=
 =?us-ascii?Q?dAohD7sIZUQmC5bMOnQW9zI3aOcOTppMRwz7bg/HSjGM077NxJl6DJ58AQmu?=
 =?us-ascii?Q?D3xhfGubct+YQXpqzhbQgtRV0dWdiohu5rxLfaUU/+HMkXz1PwkcwHIolsck?=
 =?us-ascii?Q?yYlESS/C2aVDNrx2S9UmtMeVNgnnkLdli2kQuOzjTw02Q9XGN9eFjOso+jwY?=
 =?us-ascii?Q?uvYwF+esDEoD0bonFxphU2OMyM2wniHcZqnzenTznPRY0gwZfbJ7FjU8pah/?=
 =?us-ascii?Q?J0a15Kgy1lQ8z5OFVDuapt7crlzpHRUFwZPuw3alTUfNAgCBd2y45OdTZwQp?=
 =?us-ascii?Q?Pt3VfTDC3I6ucdDMS5y8T7YPEQTawd0udXk7VEVQ7McajnQWRs9yJmF9ruT3?=
 =?us-ascii?Q?yQ2pFCATcT161je9jMeEba5VLsEhEr+/nA/t/t0WjkesG6k8aIrxhMImWRF7?=
 =?us-ascii?Q?w90fwS7Bse7NE4oPwGpEXg5pPxFIbAeR3GHxCj2LiZN9jRbdHnc/z2IrFiR0?=
 =?us-ascii?Q?MP1ybKrA3YZgtso+dgrSKf9ytD/VyYdQD+RG7IaYFBTZblaT5hx9xDCdcjEj?=
 =?us-ascii?Q?/xoaQzePfVv+Qr7fjMFwoObQn2A4gb1V35nkR3B2Vwe1VHxNfgpYNR3BT8kC?=
 =?us-ascii?Q?snQjHWTA4vIueSi1fdYW9xoxIlFQ6ro2fHnuLO73ZhV/2d8qNb7+O44Vp2Og?=
 =?us-ascii?Q?geGh62f2H6vSbZoEQmYz8cJbfinTuEiY7glXqW399InTxT3/Fy76DozB0+IA?=
 =?us-ascii?Q?7JhbEnHxrI6gHEwX9sTwpm4WQeZK+1zrEIYZveXH8EPWwqhGowNmTFlCS2du?=
 =?us-ascii?Q?5g2mg3EjkaXUrqu2YsVaZVBxAvZ+t4ZnUCqzLE7KA2FANLltKI13t4ka5pWo?=
 =?us-ascii?Q?KWt6X9Rziq0FWNGcYVYfpraIk0Z7F3XED75n0FefjcFvF98jzvPI5dY+KuFG?=
 =?us-ascii?Q?SpdHoOQerv3LXkCMjBT7svaQF2VUE7U1R1HyPpACIXLx4erNc9tMwTvZ9I9s?=
 =?us-ascii?Q?93625qWnVlf3JCpwqeRXqAQOqOC2UsJPr5pYoSEt4Ku2C611s706vkBPX3Lg?=
 =?us-ascii?Q?uEOCuv8O379tQoDsUOufWeJaGmvUflbDGSWvy7BroDDoxjoEoEx1tuF+hDPz?=
 =?us-ascii?Q?1KjwRY1filntCPYJadenQlf+i/c9hptjcpDDYanGYdcNFcJXoO5LlwLJ9p9s?=
 =?us-ascii?Q?YyImjUEu6UB/T9xM6KZZktuWtNJjzksWvZYdv6UZP+WmSCJKRZ9mmO/jdIXM?=
 =?us-ascii?Q?HguNjgCjF+jlcCLiI8Nc7Pipq24/oc5sR5PpWL/LHfkahdA9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca0fce6-a8c7-4a9b-bdb5-08df06ad8c1b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:44:16.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sa1RCFUONUn8ueW5BplH3GM8C3H/4+mcRSmJQtT1PQDe3KcHE9Hl5LhC0Fwl5ktT8yKAb0JXUjqEu5TjISI+iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223

On Fri, Aug 28, 2026 at 08:45:27AM +0000, Eric Dumazet wrote:
> When removing a source filter whose count reaches zero, ip6_mc_del1_src()
> unlinks psf from pmc->mca_sources. If the filter was previously active,
> the code moved psf directly into pmc->mca_tomb by updating psf->sf_next.
> 
> Because pmc->mca_sources is traversed locklessly under RCU (e.g. by
> ipv6_chk_mcast_addr()), mutating psf->sf_next before a grace period
> elapses diverts concurrent readers to the tombstone list. Consequently,
> readers miss remaining active sources in pmc->mca_sources and improperly
> examine deleted tombstone entries.
> 
> Fix this by allocating a new tombstone node for pmc->mca_tomb (as done
> in sf_setstate()) and retiring the original psf via kfree_rcu().
> 
> Fixes: 4b200e398953 ("mld: convert ip6_sf_list to RCU")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
