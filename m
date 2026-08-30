Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E63BB10D
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104741; cv=fail; b=LGzfUZ5tJJjEKuObjnqWhktA2d7d2JLScLYYnUSEEKL1i98U/i9jTx4CuXDKcc90aYxZleyyWh+BZYPZ+tY3aPbGrfkB2++YX9unUIzJJlBgwmPDucojcs5yHULfhbdsKHqYOd/n84YNp8MezM4ZGW5HFROuK6dmgcRFrIwNmyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104741; c=relaxed/simple;
	bh=LFaWoFEeHvplYMrZT6QwqauUIchj6Hpq0mAnFqHN110=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vrrx3lVY7JvlhfB4rqkWpNtyin5CUTtFgQ2mMkbrAxu+nrdch4/F70tQ29rWb0C34PikxW5VLZJqCpBGMxX10dwfvUeEOMXOTsjfn7HQm7zCgvhF1jETL+Qt42Gy1uuRn95AXLXqM0Ko4HVZ4ELfXT7zC+Nn7/jurt0q3XDDAtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qRV71TiP; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qRV71TiP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oT4BvRAzOglXMWM6xzuKIrZpyOmKM+o62K4SXv26BFpzBKqRgtyoeq/dV3Viy/ZSo2pvn/zl5sJ0bNufrvHghDC4Ek5p35Ygvg1qH020eryRffI545cWWuCClQF8EfUyPZF4Iu5i5ZVCGUR3xBeERU5A1nKSoXnk8n2NqEixXMfHHW9U00W4H2lGqIrSBiHM+5wJgiWQHnUFQCJKkuxIuWUJOBXmqDnDM4IThNzqT6mnKHnyU6Cn+Dxy1f5MKESCCH5rQqLSMEraj7rRRuqiFddaW3V/GWcpS9YXbokxkcYKDxRVxgrPVyjKDoMyijoPFTsgVsIvwZcoC4mTOCEdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZoJQBxd/d61UyzDO2PtuJn/yYTk0Izt70hO/SFa0p4=;
 b=bo6eircDOJIIQKAYjDTffca8fz+kCDg+6+HnIhz4wYoNVnwQn87HOG+wFz58gU7zDD6/eRhnV2Itd1RS8ToeXoEyn2KcA1v+z/KhwHq08XzDJra5urzvCAzhs3Pd7A2eiHHRIA0oGeSkhpMtJ8NDzTiQArydie2IH4/gzY3nyg0ZRfDvpq/ow3ue5Qvo2g2g/8v0MWKXSSDJgF2sVRMYois31Aj0I0FL9FE/JoN3kl+AskkUXnKkZiPb/WhanaLEWkbwDyeuOUCV4awWIedOfw116b76JIgpyKQs+zqAJoCzgAxYdgXIIDRZdDDoODzldEFAr4o5RIliPSVgJE7IAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZoJQBxd/d61UyzDO2PtuJn/yYTk0Izt70hO/SFa0p4=;
 b=qRV71TiPPYYEApGlLXBqLJ+lZIZJ8JOlieIakO5/yUMI96/RQnBeZ44p3QQZd1PTrY8w0ym+QXK8V5dzV7bNNwXBk+OvexFBq8Ddm99+MvUu7C74Z0pWO05Ihweayq/+nO3yZY+DDISqDaD3PG7T4CYdvXrn4BCZAKF6lnl7dq33qeoeD3A98llk3MPfoGz/4d4t9aqyhAHIdN3q8s0s3SKb/mCs5LNSj9Xo2yuWPnQxixQjZMRhQYqk4KxV9fHKF6ztMtuigfZZ6pECRSpPCs1ZCT0Qxg0fuYlhg5or/ejB6sxfKek0CC5BN6/QIVbpanFNQXkuCwNY6Wdgvbki0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:45:37 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 15:45:37 +0000
Date: Sun, 30 Aug 2026 18:45:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net 5/5] ipv6: mcast: use jiffies_delta_to_clock_t()
 in igmp6_mc_seq_show()
Message-ID: <20260830154528.GE2974032@shredder>
References: <20260828084531.1826790-1-edumazet@google.com>
 <20260828084531.1826790-6-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828084531.1826790-6-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e13fa6-d8c1-47b6-856b-08df06adbcdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ooB6bOZh8zJJtqqjqYLVjO5upyyQM76cmue0pNL571kzpNUmZfe9OabZ1O0A6xTRzu29a5RA8Da7GXhO60lVzxn0w+Z+tkYSEBQk4EEYZjOvkyR5Akj2pTYl4mEJtK7+WPjwaCT0HeOwgngvlRsCp0TFfqh8qwxLuiwzNdX+ahOMwM3vg3jmAEAReghaqTfP4cCfH1Voqp4XIWNdsfp5d4NAltqyCPfsgzLtkDvk0BJOBPdCHLsSLyYuzk1Gc+3nsh8kO+KSiFxVrBJevxBnxD7VBPKFkcNiA42jH27wY3CFkBru5yXv33+ya6MwvGA1+ENqbx2DtXQk16FBy8yqkRkkxSihCOJOoiMgdPGnbwZqIcjCfszcReR4QzWKL19CdrV1USGSD6AM2T/a6zdyPidt71gbQEtUwfUgz6dN0/EX+SovddbNigoYeonZxqaI4wp73agc92V9I2CHS2dIB2I6B1ncmy6ersCUINVo1HH3apru5lHKgAaimNej+toSrcgtH64cxonL3ARZr6ajx/FCAhrfo9xTRE5vFL0JNE5qJM1swxQqJFtuJzDppd3LJb//b6oZ/9s285Dd7zEK2WVjQzVbpPxMJK8aqyLOYm+DSey5t+AbqUAzlBuxDoGvLzOjeTDm2DzwoghgIKrg7Huw5VZ8GmsGUehjRezsYA8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wDBsaKwxXp72GliE2/EZgFfewVhJs47I4tMjLtf7klKV0EE7CS5aa+/4CRus?=
 =?us-ascii?Q?9Sunt/f+rO3CXjs6lqDMkBU6Ab3PO8XDrKOGO3TKp1pAfG5tjmMuu95z73fe?=
 =?us-ascii?Q?wir8J+1gCje2zfiD0SHIXmFflh856z5W+Scp48g9XaS/4+MTTubgrf0AiN3k?=
 =?us-ascii?Q?KVQz3jSKjZKnd3cJF6vGcpciNm/iixxz9jNj+KwK+H2H7dETFxaK1HI66+Fa?=
 =?us-ascii?Q?e1vUW7kXAxU3E11mA0AZOSxFNETHQlXuasd1uS+ffyrE7zH86fIHB624ucis?=
 =?us-ascii?Q?cJbRwaYPHCUFmOjhQalC+wRu3pv1xCUi9Sxrmaxqf5Ko+Nbz7Z08+RTVxLPy?=
 =?us-ascii?Q?I9euPhert+0iJY9pM10xDPw/CmhyUmgKEukzNZAeJvm2p41JeDivqM5O/B/G?=
 =?us-ascii?Q?6RkgjMikg3nccqaWMAN46YT3csa2UeQInaZOoN4WuE5iZKlm3iCTW4KwwGOp?=
 =?us-ascii?Q?pvHwpD0chbqo2Yh+3fHZIbECvECgwAE4sTEDOKrrCFl5NgFqEbuPtwvS3qWT?=
 =?us-ascii?Q?1kVTUX3pjZKgnl+g/HFLc8e4IFYLcBIh5D0LrlSljlksAJ8R8BaqUnfUO4Aa?=
 =?us-ascii?Q?Sfx4pRo7/ioKH/wrszPSKQOj1aIEbHbuksaqlydD1+rpWu9xR1JaYe03/HBJ?=
 =?us-ascii?Q?4aVa5F6Bcafwq2/BcYhyWOMvgyp4GiojIfSaJ1+1oDfzI3ghmzkUsQA5bHzN?=
 =?us-ascii?Q?F/qTgDFusIiCZIVbwkYsllslVU9b4xAOQYmhiyjkvx24GHduLmOXMW7FdYbZ?=
 =?us-ascii?Q?UInjJTnMFzrbEElzKYDKb0CSJDQu37P+fP+2CSQDHgRlDclqpk335hFMMcIK?=
 =?us-ascii?Q?rAkTBcuU86osUhRBZFawJTDWNGh1BnvvVStJg55BM44x2O8V85iPCF9j97Yj?=
 =?us-ascii?Q?S2DrOrgT327+AuimAfAKJvh2loHGtX3Fqb2aK8JInn4rFjk6AsqNbgUtRPJs?=
 =?us-ascii?Q?W5uA7gzAH9BF6fm/k/W6YfpbsKnLme2k16woNJwV/VyC2bsWUHa5LmboxCzb?=
 =?us-ascii?Q?fbx9SHOulr4ojdoAJ67B2PXNz6jmmNf/8LqCG0jn7Fxue6oke+9lj36FRp1A?=
 =?us-ascii?Q?uF6eVxuOw9h59U5Etug63wh8eEpK1tZDGzE81d/BVHDd+TKdaX/IHF8pxq0y?=
 =?us-ascii?Q?RUW6W15UnH1uivnoyjaLctoxj3lKLN8MvGbgepoU2owZ6YFDyLgwn08ARwn1?=
 =?us-ascii?Q?zW16ZRGN9Np9LlJ/Pxz/swsO7ZruG5r+Gn9h+bABdBEifUhSfK/xE0bTtCHJ?=
 =?us-ascii?Q?uAW5D8BvkwHVbbGvKHQ/ahRxohMQ1ABTD/fFwrQOHbGKKTNkSMjjpJhjz9pi?=
 =?us-ascii?Q?vaQ/RSHSsvHmTy2k6NVrOEt2ulHhxDnuf1NfkL6noVO3SFtJQexBLFULDTKk?=
 =?us-ascii?Q?dL/EaupuzLh+DILrRf0hHespxrDTLd/8VfXMM03+NNZESK/KLBC/sm8p9cKx?=
 =?us-ascii?Q?PvrdZ8HwfN3fp6t92GII6mLM6UAZ+Zqw0hpiHILCWBGQRvLaKzB2a0ZA+xPs?=
 =?us-ascii?Q?yZgZkrKsvvwmiYqCuX3/nfsMUlkUHAdSUFIH2dNBIgWGIoQGQ2rXCUfh99yr?=
 =?us-ascii?Q?oiPHDdlRoRZUVTrEWC3gZLr362o7KKxkjRYxkwP96sn0xuJ0k/w3gYj5Yrzw?=
 =?us-ascii?Q?ePsISjt2ROIhOTs03fIQBxxvm+zCHqCzNsRgPGtT2H+fFOa0fji1H9CkZJ/Y?=
 =?us-ascii?Q?WMWFAX9wsw0G7jgX4aybYQES+mnl69huV6Yg1N1dQCb0S/vD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e13fa6-d8c1-47b6-856b-08df06adbcdc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:45:37.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5912vcsnNkuuX9rTC8G/80WD8XfO5hZEAY8PnC6XA59zgiviWraySFdnZ7nxjOcjpDxUy/4G26hJzbNOQfwNNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223

On Fri, Aug 28, 2026 at 08:45:31AM +0000, Eric Dumazet wrote:
> If a multicast group timer has expired but the delayed work has
> not yet run to clear MAF_TIMER_RUNNING, expires - jiffies produces
> a negative value.
> 
> Because unsigned arithmetic was used with jiffies_to_clock_t(),
> expires - jiffies underflows to a huge value and reports invalid
> timer durations in /proc/net/igmp6.
> 
> Use jiffies_delta_to_clock_t() with a signed long delta to properly
> cap expired deltas to 0, matching IPv4 igmp_mc_seq_show() and commit
> a399a8053164 ("time: jiffies_delta_to_clock_t() helper to the rescue").
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
