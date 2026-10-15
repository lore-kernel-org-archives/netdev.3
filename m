Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE263B8D4F;
	Thu, 15 Oct 2026 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074765; cv=fail; b=q4gf+NNp+AV1R++vZoh+zI9OgILaUPNXIDESKtmsqjP+QYuODpNSGpvwlGO3WM7kR9PPJ2bPvGeqDdZBe4COqlW56OaHG+TovbIZR2zAkAsEND98JslHLs2ua34ITqq0u+q+ZKK/QFA7ILT7viUlsPFCbiHznoU9I7Dx7fz4qn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074765; c=relaxed/simple;
	bh=EVONQVYSMozThdGIx24GboubR3LDbOulcKdn+Kroly0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KY3W8tc4h29+R3IME5f9PU9uw23zEqYaISKtrl/FZkPLlRZ1kgnId4TLgtGUakNIfSP1ubbgMFojhKZlzzXgKGKLG+6wuLeq5ikzK53JHH26TThqlDe8+de61Jn56aAof+G6v8IThufysww/iyhdpt9/aMdZ9drmw73ew/dsnvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ParGgLuK; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ParGgLuK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xansgwu9D7zftYo/l7CTo3buG29cqf+4xRgGd5h9qWKyTHv+urLUZWXB+Rcxh2oQMqa6NRREoM0gwSA9TDBHYPZrOIWOedN0AaDfN70zlBwFEWfwlne6pqbYeKodciIEx0PxZ7b5ZR5qs3KtHO/bv7awe95/mj21uuTkUMuxdWEMO4Aym+jD9Es60TehsasoBAGm3TmUMVtCANGyMZkq90cI44xX3/kgCFF7e/ytabzCTycuUckJw7hRvPu5hpujeFNKbBbNH05XCGjQvQ2VB/Luu0MC1MQ56MS166/DS9FOcAstbrGCV9owPmoH85Q9U8m9jjmju7PzN/vpDS+jig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NzdNi6134i0I9CXeMjDEaaLvW1SfppH5fLySnQK4A4=;
 b=e+2xVV22BE7BOhzM4dbvJP/C+hTBZYQiExZOrTI321GNxfOgNwLWKpUWotweKBZZ9oKK+rPHtfU5zjyWHxdac2WbME3siOksY8bosRnVr6fqnkVDX5fNVaBD0QpKknzk5jngqU7KcEwOXsV3gYz5z2RX5pYKnhyc9n0BeFO36RG6K3hCWAaHyRmnbXL7iNugFwfrM5nYluRxYWUkH7FXr5/FHU/R1Uxv9/TqF4ufl6gNnv0cgU1l4PH7pz6R+O++D1/MpV070NuQqF318W0QkdvMtd/zdDwIegCDjtlLSJLi/AlnhDlCZmDvJk0P6fblAVVEAPoO4/rfPN/6rANQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NzdNi6134i0I9CXeMjDEaaLvW1SfppH5fLySnQK4A4=;
 b=ParGgLuKfOZ4FT5OECSyv9EDtOV6OUUgeyr5K6P6LWPV/zKeHw6Sl9lMI8vuYtQb37Jh+LtJhJHVmOigNXtsLPpOXJUzXVx4CbxbSoyjQTSCzZ6+0kFLZJTM6i66WLX92ZOf1JJwZqw6Oi+lBzXHbdoVxZBks43GWtV0e1pYb+yeYRoJyuWoUZSnFkgjKf+w6MZnzp16By2HZ9naeh6u74V7ZnZtAzc2QV46d9rT0bdOj0eitlBQYfGNwN1euR3dedJCFARfrswE6QIPCskExiWQFG1wk9RAHAME0INhS2fqiGC2A0SMbeGrCgSWMzYoR8BkLvSp/LeHDWDRQzlrqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:32:39 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:32:39 +0000
Date: Thu, 15 Oct 2026 17:32:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/4] ipv6: initialize temporary ifaddr before
 publication
Message-ID: <20261015143230.GC1794897@shredder>
References: <20261015050651.1841557-1-4ncienth@gmail.com>
 <20261015050651.1841557-4-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015050651.1841557-4-4ncienth@gmail.com>
X-ClientProxiedBy: MR1P264CA0061.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::25) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e468b9b-02ef-4b1b-152e-08df2ac929e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|6133799003|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	pGb4l0A97+PgqoaJVpuTxuCfwNAtFP2yVvWKrUcVcw+WLsVrnLeUKgQ2HeLCfp45gm+5qfKgQPAHpMXCVmECV40CDl7pc4/it5Mvn0uy9oZdwhXdq36QqR0UBnQb773GelASd2DBNq7rv60tAX679afRC6/1/OSYLtHuEUzGylY2SKUlnTEerjUBn6o4yenWcmZ93LzO3RevYGk/sQUAoLBEUSNq+Yb2aaI0aV7IMcokankseFSQPrWEVw2HOyo6EUw2Ty8uP8veILfYc1RXv62l25hRLmu1My9ghjmCf4+TM8lTr3b36usWejzXHOMTm6mblou7Yh+RHDBG0e9A1tjYg7xn9vYZuzXe6XA1FEOmAmraS1i1ajk0Q81xAqCRNUJSUXpMZP1pelt0SuF8pKYKzXVlZDja6U9c7UO4UiitEeWI4QM5RzhMmb73DScMtWiQD7oHG7LuWk/hW0cYJT0GyqbAAzIw/acOjcwBfEiU0dlr4pcrxH9Q50zulAQIqTkch/17hg9ePKd6eqq5X7C6dQBNDWrnj78DR5MlQsDC2VkCzugNVXmUgtAozkO7m9U6I3w1BAwj+sAxG7PjiOI4o+aYZQuV2oA2NjGjqLHrO0LBsSw+yXI72sNIDvy86lgDXGIz2gLqN/KkhhqTxNdvFEMLWgYQFVz7CE2K9Kk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qONfLrdFJD6kONQ3dPRG9aMBh9xswozaatlZz3ECPhNENQmZy5G+ikriRwlS?=
 =?us-ascii?Q?NAK44SNZ4CJfRkKmolkVOebCEwk5+Fmzde3YcVKArb8p5I/A+R8JYAkekHnS?=
 =?us-ascii?Q?CQ4HGgg3J+vvRg9N9TxdtClmwlbjreGSxP80QlyipoChZT000y8j7CYXajUT?=
 =?us-ascii?Q?0nX3qy8237B7jSDABw8Th/rSR3oqqU4fONtNlBMQasus6YimMiMTKH2kUmdq?=
 =?us-ascii?Q?8GW0dY63rNSY0u8Oh9UgCgmY4WWImb5xY6Qg46OteTRQ8f5lr+GIYP0DVIhd?=
 =?us-ascii?Q?rBPKK5N0I7xrX2lLV0NqlxVlqDIsnGo5wFdesSrnmIBKXMwzsVlE8cs1KxwS?=
 =?us-ascii?Q?CE1rxdfWcbjVMva2LzE9nDkBFRPOVLSGZ7PUG6yRcbNq+SluLKXQKgkXLMfV?=
 =?us-ascii?Q?X4uunIEo4wqlTTdzl0qSHhjW37XkQ8CDU+3pkTR+opnFR6+NzwvPfYsXjlTb?=
 =?us-ascii?Q?bvn15oOpuDwD8LcHbp7z3zdCB7EKbXsO5hYpgoP47j/2/Z+9qruIS5BM1Zdh?=
 =?us-ascii?Q?8amwTw1hV7vLzXJ5qKW3q8ckpY9A6aQXNtET+cx9d/sKXLIjOHMDspAHgzUg?=
 =?us-ascii?Q?coa5Wq+HW3doRChHKt5RWDidze+RolHsj4i9QtMJBemKllcBhKLAoVP6QRME?=
 =?us-ascii?Q?smG/yZknM7lWsFfx4mQnro5tts4oZo/NfhC8PYxlXbXTc6YDXp/Akamp3fxp?=
 =?us-ascii?Q?NBczrRJSFN7Pzo48pvCarEWSa1dFs9MbGGiXJpq9VAmkhsBCOF2jFU2uvrb/?=
 =?us-ascii?Q?J3bG9NRlfHWoRafYrBnNM6K8xop+aWD0OQylRN8fAXH5+40/7ZyuQ0CCc0y6?=
 =?us-ascii?Q?O0i0oTzsUdL5TV0vnbLzoJ5ZT2rlzy+OfaNmwRNurXPaQpLccRrtP0p2PXdD?=
 =?us-ascii?Q?SLOOvqszfHlD4F2QlKVvmS1QGK97RTmn64+SR9io3Qx6CymRMCv1zVBj3ffq?=
 =?us-ascii?Q?+ue7uw/RJcHEIeMQ4daYBOzKIg5g5194SdvuuPNYjfGPHNpvSPbhmlgZH0um?=
 =?us-ascii?Q?vxv/758E3uPReuNJWhPT4ySdlGEiy6+jboJ6EMBYy6d32p+xU0oFbvBg7P6l?=
 =?us-ascii?Q?8nt2E32zF+EQLfrdCdJQvoEIN/HTRJJ084eXmCg4jQ0iPICCCz3X1E3hXz/M?=
 =?us-ascii?Q?TBedR8sBEuZAZ34s4j9sY4KApFTG6EIaoz8vqnfvsmLgaCu5iP20BQG9MGRC?=
 =?us-ascii?Q?aHRcjFEIlYptiqpP52FxTrhUsEbEua7GhVkaLeh0wbhSl31NdnnaZamHYsc3?=
 =?us-ascii?Q?mzCN9Ws83AvF1w9E3W94BPBmnKVuKPDrAts9NaGuvNLXIblq/bKMd6QXGJmN?=
 =?us-ascii?Q?9h5XwUyNlmErcWhkivZAcCTZVdpNvmZ2QGE0Via0mVlGPuF71COHF/drrfVS?=
 =?us-ascii?Q?0syAXAfh8vw/VhuK+95j7rA9iWmze5RZ8Te2UHNDsHDyq/hBA8lOLFLEPcsq?=
 =?us-ascii?Q?sw7iqj/EUZAbdEXydRaPi2LIIDE50ITI1prSE7vg/Tql5tJdlY3KzsFSnbT9?=
 =?us-ascii?Q?blFmVI+PSBfPxZI32E1hzF6Whmw27SXkYjko/qfwUbAKjsdUg/hYdkuDxgiF?=
 =?us-ascii?Q?d8mJ8xgPxncwy0yPLyLJe81dDFS2+8ddbMu0CtId1HJ9SbFcBSPQN7cx3Dgh?=
 =?us-ascii?Q?335LCeMDO54MAiR+Tho3a1BOUDwadu35nILCVN7V6WW/l6bCVdSnFQy2Vbjv?=
 =?us-ascii?Q?PuvCOlJo6B0xhNgGcqZW/cGinsUQimDTEEJ5BOgfurT9SeEKw2Shy4wbEjdr?=
 =?us-ascii?Q?7X6i6sKXGA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e468b9b-02ef-4b1b-152e-08df2ac929e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:32:39.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW6dV2zSR+HlGoGMnpdjh0scdAYyseMRDNDmQ4woeHS0ZQex3OBZ7NMZCVvg4F5crJptYfCYKJUhcaiCzt5eQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

On Thu, Oct 15, 2026 at 02:06:50PM +0900, Daehyeon Ko wrote:
> ipv6_create_tempaddr() holds a reference to the public ifaddr, publishes
> the new temporary address through ipv6_add_addr(), and only then stores
> the reference and final timestamps.
> 
> addrconf_ifdown() can remove the temporary address before ifpub is
> stored, leaking the public ifaddr reference. Publishing ifpub alone is
> insufficient: manage_tempaddrs() can then find the object before cstamp
> and tstamp are final, update its lifetimes, and have the constructor
> overwrite its timestamp with an older value.
> 
> This follow-on was found by source review and was not separately
> triggered at runtime.
> 
> Pass the public ifaddr and both timestamps in ifa6_config. Initialize all
> three fields before adding the temporary address to either the hash or
> per-device lists. On success the existing public-ifaddr reference
> transfers to the temporary object. On error it remains owned and released
> by ipv6_create_tempaddr().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://lore.kernel.org/r/179122559913.434549.12720841717630168470@kernel.org
> Link: https://lore.kernel.org/r/179161099665.434549.5858601179492551889@kernel.org
> Link: https://lore.kernel.org/r/20261007164548.GA1153540@shredder
> Link: https://lore.kernel.org/r/20261012145240.GA779501@shredder
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

FTR, I suggested a smaller diff [1] which you decided to change without
a comment. Tagging this one because it fixes the problem and because I
want to put this frustrating submission behind me.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[1] https://lore.kernel.org/netdev/20261007192032.GA1212364@shredder/
