Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B573447D461
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961330; cv=fail; b=neUlqIcRyvOFcSGRC9NGCRbdlXKr7M1ffu+PIcV/GXmdADyb9/plASCTXhqZlVE0+/H6AFD0HFAnXe5dj0TZGYLHwybJrl5kYvOTxPWCwE9RDnkN4FoaFmnf//0pxjN3bD4EmYDxGrPtGUJSUixIoaXIZmty2NzUHWQ+Y5hX50o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961330; c=relaxed/simple;
	bh=lA1SwfiPYoFJcvfRScrEvhVF0XNgcVEe8B2rbWCwFxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N7tEwh2hkSF6eCEL4nAmU+rFr8ocOaEp4RcUdpjmQlGdplyrE4GoclIBKv4l6ttb84ayiRbW39ZVu4JmoznhO/E0OtALduVIim8r59+rDbv846Y9eQ41c8Y/GP149snsXrMmNdRj7TN4WtZLOead+X1wPyqzGiqOxMQrUyL30XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I7WPJy4Z; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I7WPJy4Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXHXRRSqHVFNjOLd1mCEuMrVmOZcJKel/ON1LGhX2AM/9xXvcUQzr+63vKsgpRGw1svsNwKizXqDDa6FkVYaGg5BZUkt8DvtQInWuCb7lwcLAhzb5zRiHbiTCnPszeQiRulWNfa+3kE65g16LPfSpOuJj1mgKdYT8wmMpBmJyouV3dDoI6DuKEuQT57ilZ3faaYAKCo8OeX2zrapal9ZM6gzCW6uMJfAqrw5Yh3ot0Feo9YG6A3TekZH7DHN14FrbjdJISra5tQQgOzurXnXGBYLyVqcAr0zH8waAOdNTpiiA8UeZTR/6l//np151guDCrpegtzhfiN3yiN9mrtVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RAc1VeSj+Eff1dn2JgNqEwslIHsVMqthVfvELn1GO0=;
 b=mtgLiTIMq0ZOVwYFqk3MHercyyXXUBMfRDYLwbaGLzlTpTjLFtWYRsnBfwlj8XBe2fsqzrfy373QBrEGe2MKNWGDlMwiHyKrl1+s7OB6/BGrGTuf9enex20gLGLmeqBenzi05wyIh6YSaWehhxWCLU2K4pSZzGrhy58cT0+i1dqVQ2ZTBJzJPOT1S2q1Z99YBUkOyJ5PgHopWAam4OalkVrR9iBqjX40VQDbJGvI0FC+Maiab9Bt7Tq0yY46Cg6HbgjyFksxDSIZlDmBc9U/IMHaUmZllE9qJnpwmilN0SWHi0Rng082c3S+cBfPoSgLepKJ2yScQpckywt69oDm6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RAc1VeSj+Eff1dn2JgNqEwslIHsVMqthVfvELn1GO0=;
 b=I7WPJy4Z3Q3s9RDaG8Nh6KERBO/4zaBTLMEtVaK/D2oLVXDchqB1am4Hlz9FfL8v+G06aRpASJ6qO1F2kG81Mn+mTx05sX5weD/vVWBHjAGOiyvbT8EgAnq9F0N3cNQiZ9mLJ1AQlKGuyk7UP5e7JV7EhXdV33ohpeDLSbjqvlMqkPvI/Cat6xX4qt9h7pc+YUIq6zQ0bAtJLA38vTfl89DNLRK4eZPF3OyGPZsPZMQMARPYN/e2atVRv5MineWyqHvVVkP4+d2e/sMwhUdETE7Fhc5cQxH/nYwOueQXS5T3qmRhuSrHnxds43MXM/zEAgoVodx/GdRkaNaxOKqpzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Wed, 14 Oct
 2026 07:02:06 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 07:02:06 +0000
Date: Wed, 14 Oct 2026 10:01:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 5/5] neighbour: Floor neigh_periodic_work()
 interval at 1s.
Message-ID: <20261014070155.GC1220477@shredder>
References: <20261013205816.1642597-1-kuniyu@google.com>
 <20261013205816.1642597-6-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013205816.1642597-6-kuniyu@google.com>
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 5646b222-869d-48bf-b6a1-08df29c10e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|261009223027099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/ujYMRpcTPfcTPoXINan1tSQ5ogaeH+L0t48mtMQCXUcxLgY+oHLEk8JLEs0SNTKcZQWoQLJES8HObKYxUfzvB3U9kSN7JHBPbAkPLH+Yi/6EryNfCLxTVARDfdjE0uqbzI2Vm6bP9Y2dRAWv9q0KbFoywVI0zptsois6MEnaunmJvFaDPvL1B/Xz65CquntnOCMl9UuqldP+Ar85TOsRJkUTdaJu/KpuMJXfKgTTLNdjIc2ngoOtJWqXcLKptUcP/2b1QzbNWQYG909U6+HsUP7K4+G47sY7py8LZ41PlDNDRMy9bBTL/25oiYxpi8sNoSW90DLeqcZh8hQE97nxc2OFpkQpRl3F1FJooux4S/OWgctpH8EhCYGX+91zOejPXlRBrAoWYWu55+2Pulcf0jnZDGpZSbribLTTmt+7pVht4c70RIJiVUpoV6L7u5BWewgfJiHdWYXX4iqgxlBgajcMkku2HqX4u9T7OtgcH5PdWfTGvHBjHvAkTuQjIu6Tm6Ta/hRgn+HlEIEg3gtz5qr5kDnCHOm6W7cgWEL111SN1tvEHBpuCbTONJISS9ARxub5VShnJ2SgEWVq5zFnTODJNvXXWJEQW6OSoWkg+eLcAhIBAIH1M4kB0IAI3Glo1NfutRekKcT84uwl21afLmvvIJnHHCwhUhZGWJxs1w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(261009223027099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f9bcKbkwbaU7MW4bpHsa3QO83cSGrgxAs2KTc613HmwRELR9tQlHercueZw2?=
 =?us-ascii?Q?k6+439GhBG6bN/tUfOM+p3hIZMOUErAoLmhyWXoSylM/qXdzXinqDS3JkqsY?=
 =?us-ascii?Q?g57x073OjYiStvibYySm2KeCgK6ZzcH4nfbYvtaQsR5n0qXEqe3/MndtdK3l?=
 =?us-ascii?Q?i+TdxwJDGHfqjFuHKd66NhWs+SzVtEBHru325mihn79c66lMIJ3XVoosO7s4?=
 =?us-ascii?Q?YB+5Urdk6UFzeCKuuddJ1SADtY/2SeknwIYe+aUITdnpahN7kpWKAothPKzX?=
 =?us-ascii?Q?ip70i6VcuEnwJDEVr6LtKvMCXIq331s2t/0NAQYChHBjn8XWmxb0Sut/p7ax?=
 =?us-ascii?Q?ABd0ZG1OKtvOGsRv21jHJDF+sLcw4/set8KSS4H6wmzg9kzpUM4KhZPMcjBq?=
 =?us-ascii?Q?A5iKD7Xp8Fyxz2id+jhPJ+rVfePPfl42QxsFyz6LGcYpmaym7d0Az8/nK1XL?=
 =?us-ascii?Q?MAfDN9WHzqXbKCk63DByP4dtsMAgmeC6FBJdK5G1viUMA0DFazL95ndgOqxS?=
 =?us-ascii?Q?dd4a1JkL8WdowCo5cXn5EdO572BkVTQxwZoWES0hH0mzKIO5px34UzrWs3QD?=
 =?us-ascii?Q?xSHHMG7F4rmId5zusrMgzFyW7pmWinpUeWSck4mqA/iAg8HS/leHrOMTQSHp?=
 =?us-ascii?Q?lkVYaDivhLIEpWwkEyGp1to+cgDgFaPgBo9+m76f/MJtPpYwmy9Uzw1vtXeJ?=
 =?us-ascii?Q?h11uQ896pPPCZczunwscngGxA9DE7KbvW52bct67/iT6mQLuGdvKT8c/BNVQ?=
 =?us-ascii?Q?2YPCTTQigsX25spxwbNxb/DuQbpyaBLQZ0E3FWi4iut8ijZWtP4ekE9XnM7J?=
 =?us-ascii?Q?cJkYRwwT/upRoiex8ZEEIX9PPIin1Ns0IxJa9vCA0v2FvXWy8Q28WzFbqB+y?=
 =?us-ascii?Q?0J0UtBMk24fm88gmkHm4h5H7T18Dngrpu0M84jaouLkb83VzeXTVbNdeRN0D?=
 =?us-ascii?Q?46rYdCl79oI166b9Sf+m2/DL/TFkMTBB+xulhw+cYndpEmDVoeuG07M5lFVK?=
 =?us-ascii?Q?MRcw2+hvouEvaYofsk9v470IYt81hxAvu4I38aN8TvsKNx7qMFDE8Pl9PMZ6?=
 =?us-ascii?Q?KvYJz5dUxi0Fe3Uh6sfqO/Qt4dU1pK96XjXyyRDz0FN3E8VHX44xo09h/nJA?=
 =?us-ascii?Q?8vLfXI2v6dU9pR8W+wFexD00OHh0uZrIyXrhr37vuqT5jtKptKs6tH3D9BxR?=
 =?us-ascii?Q?C0ds2ROsCBqwYpVL7CmyVmtgaXW4tpn8I6UR4aD8w4lb5gI+xtMfzF/dEnhh?=
 =?us-ascii?Q?9AlB+HO12/9IDZeZ18MaUqL+ITZhuen9/yonMa1BYt9cTmceTL5+uB6qlCEV?=
 =?us-ascii?Q?zzdD189vhumM0IodkHHUhHBBQbOysV2ilifDw2biV2lMbp2Q128kyNmPHCJ3?=
 =?us-ascii?Q?dga3PKb8VTptvqu5hCtGeQUxjXyFcfxXr83xurWyCENBLdMjb65fATJmyHH3?=
 =?us-ascii?Q?tgnFZsRuhZm7S5+dTZ9rcWVg+whe3ThSrGUzH2CjO13IgubXXNTfDk1zuQU2?=
 =?us-ascii?Q?YNpT1sOG+UDJtB6/UCixWq5r9aneHQv9cL/p3aUsTGuSd5M1S7I7x9eGwbhD?=
 =?us-ascii?Q?uYHgCE6OWcYTW+3PonrwJ8NSNxYxZXVkYVucTy+WRR9yYXSjrQIpB7ARKS2A?=
 =?us-ascii?Q?fH78qWn7Z3kAd3Im/TtcNs6fh1fkr+yJnd/SUm9uHcpVHmUQwILRVMY5rNye?=
 =?us-ascii?Q?OWUX8QIbg+CBd96l79/0zujmtPyS4idVSD49y6wn6Bj+GXQ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5646b222-869d-48bf-b6a1-08df29c10e90
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:02:06.0360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YRxfEB3EJqnOgV0THgtBjeVHvk0GY4aQIp4mRYfcWM7YvUof48fgJpJ6sbNRZdN1CBVdnFJHqcTajpS6QErsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

On Tue, Oct 13, 2026 at 08:57:32PM +0000, Kuniyuki Iwashima wrote:
> neigh_periodic_work() reschedules tbl->gc_work with a delay of
> BASE_REACHABLE_TIME >> 1.
> 
> neigh_table is now per-netns, and a user could hog CPU by setting
> BASE_REACHABLE_TIME to a small value.
> 
> Unlike INTERVAL_PROBE_TIME_MS, BASE_REACHABLE_TIME is also used to
> compute reachable_time for NUD_REACHABLE entries.
> 
> Let's floor only the GC interval at 1 second.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!
