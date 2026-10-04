Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7FC3C552B;
	Sun,  4 Oct 2026 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132494; cv=fail; b=W86orlywcerMt8SRM8FFD1ANlESqSDU4VIROs9lejx3ojw2BEbS9uLdbmySg5YqqCSzjPjjVSoDzzkbQLJNaaJgwwBh2HxYJ2GZMQ+Lm/X83JCMOBMMAoMf4hRUkVQIcrrbAGyndXK3k8gZLErqo+QGOdUQ8cXfVoZajgLQAMAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132494; c=relaxed/simple;
	bh=lwVSzxcCyguMBmRhhRIFuZJ8k24jQTltFlcT18VNgT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K/qXsac60cg5EQUMIJnMQy5nD76nbw/sudWFVUwxVvYFiDYo8Qi/6QG8pZaBa3VmIxfE6cl2OiVhGn3bq90YYTMEek9btpg4J6BuXVmeScs9S7hqBG0PMCHYGkZFAdXm6bMOHLFxO1/BOHaIYVY6MYmypSagxAYBtqgfywYWRko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ridfokoq; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ridfokoq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD1+cF8qNG/QjvN23lx+2P8p3zC1NN8tonqhYZtXkDgX4dL5BKCucgOYZ+9duDs+nbyvD1VmYOprHj6JxbTFi6WSzeulPDCIB9wzd7iqjSXQaPUuIP8r+EDSeJpDgoWhsg9N+8CKzaUj3JGsd9Lf9rxDN06B25z5zN3n/70YzsgpLZ9kp+zI2S8KsR+aEJkTNDbSjRvL6uLgFSeKGAsRXSwupSLhJZktXp59UK0HeZ3U9OzabDuOS3oHEt60+RFg6uKfb2WeQPPU4512w2H7B5gciPZWAoNWJ10Nh4aRzDi0ZcBXR0FPhAWzvkEcrprW1ls4SYva5eboQRNb1ZiwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwVSzxcCyguMBmRhhRIFuZJ8k24jQTltFlcT18VNgT8=;
 b=Yt/rd9MId44CR8Hds8X9KuWAcHZvD5+3muD6BAONlQxKvVzId0OYCG1qq6ObgxDciqlJb+FB/y4keclwUwN5KZ1UcGA3qQt5eLxIuwuWla2QdaB86OrkxoJI2jAUYPJxtpyBQIwekDFjwE2X55VxADGB01iaE2YZRktsODWeSb+DHGemF5L6g+YlqHKkjSMhMTloMemR7sJZGBL42yGQOLGSaF4u5BBVQz7DyR8hE5rEdNAHG9iSH5vseaAioB0ZIHbJ3FBsGZzWVJZiFMK+XSDw8wTcrliBPwYIPjNdGIYWm24dUSN1dRA8jvWCn7ftsgDSNdwp63GzWQKorUXpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwVSzxcCyguMBmRhhRIFuZJ8k24jQTltFlcT18VNgT8=;
 b=RidfokoqOhK+20f2XXkfUmYskqbPQRbrvH8+/kEX+zq3RCPUhYKPuVL07UT+d76nfR3U//tIXhxcq6c8DhqXsrrCWEPg4xX91jpCj8vo3dX1pXTw7Ih7B9rmpuLoXJvnF3oz9MVsYafHyShTWqh3Kt8YbGqZxkNf0OxkC5J6xTQZPPnAI59xZ4ylFBteN0+hvPOV7QrCQE7ohfv9lZLc1Kdwj4QMcOT3AzLqRUj/5IhG1bt+V2un74yPlcvbQ3Vh4yRjvJ8J+/Gcq5B/VNmnu32zujIUpiFB6kyXuLfV1K4AqpE4o6IKXt0fxHvnVAmY/OhCEkEMU5FQydsMNvW7fA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sun, 4 Oct
 2026 16:48:08 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Sun, 4 Oct 2026
 16:48:07 +0000
Date: Sun, 4 Oct 2026 19:47:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/14] ip6_tunnel: add drop reasons to the
 receive path
Message-ID: <20261004164759.GA355212@shredder>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
 <20260930183910.3151873-6-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930183910.3151873-6-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c1ed33-e119-4f1d-c195-08df2237446d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|4143699003|56012099006|10067099003|11063799006|10063799003;
X-Microsoft-Antispam-Message-Info:
	jRch7QRpU3QHtwvPqBukV0PoD+SqP+siapJJFEW/O/y/oUaEVIHpTuCklEXb1QOWi3RQw9fUdqqu4e/Kz56L7xbGZQJVYZsGnHGxJW3bb1HCjzKQWLSHRcXV2qSnnVg2vyGaN0dql1T+YIaa9jzuqMDCtQ8rOChGzuS5PMofA1iq2usHnYjHa9QxYiLJnigcCoBKWkV3m2MGqmBC/gmlv4AiT9MA/o5mB0yle52Y5Nvq9bfX2D6jeUgQUe16r70ifiSDT9UOL6GpfgAsUvw2TlZP3Wq18hfKDZteSF+/JTP0NGtJFdJwZzKcRpmH9fMyimBcPcjgLOgJzYDfu9L/9QbzOQsyq6XvjCJBv63IT25b34UsPE2p8IxReZhwSZ0jf1zrTYXNKcDp1oj7zxlQI0ZQ/w6PquQfCmDO49+6Y18mVanHtG0fWll3y0QqHbowdvUOt0J7n3ebOAV+bgiK3DPDKnRM8AGnf6EyklLJ6y6UETH4KaxzhzsVEmLqJp2EIcW+4sNwUdto+0wHv+H4i6ws4SRQnQ2oI7rmhM3zzbcxeYMRFpCaE+yfmFAU0NG/+5l9a06fAlquCULxzoGx4km6kDWinrvWz8t2aF1/CEBdrRenwzs0hBgM3EC10NeFv0p9rzBLaeEQ5OFbOphT6G3iMQeBRn9fVIVjaAeQa+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003)(11063799006)(10063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mF986pz/6bw6Q5yMklJqXNxlZRySe/R7imUsrPsH6qV27fQhdib733osSbT5?=
 =?us-ascii?Q?YP1qKt5wZqvafHbuITNhyOMGAceJ69UzAzT/QbXluqh+CBv7vZ1zoOBV2J/A?=
 =?us-ascii?Q?yGPmWOLc3gTvyZxeJm9phd1WIB2qb3cIxK4BkC/5yxw9zjLH2cNv+5a4N++Q?=
 =?us-ascii?Q?XFWzsKQg8BD+3mveKLnm22el2PU15IYwrZJNOau/xUyOiL+RTJl38Yi3tmOr?=
 =?us-ascii?Q?zZvx6XlKklq4VbUz97lznuSUauxbx5TZBHKkpgHpfOk//gJ4tox/ASCh7SXp?=
 =?us-ascii?Q?V+s/1szleia091gU0E9fcixlJ83aHzDL8GQ+ApQW+v8HJViS11N8QRcLcX9D?=
 =?us-ascii?Q?PUFxlHLFKyaxzMTI/jDPxcudI7C4fyyuPMkHKVf9Gnhbev6OsAhncYSndVQg?=
 =?us-ascii?Q?ChXI7IhlNMkOhecwuchrEoYfKIGthhCJlCNk018PWaGfvxtcR2QqmRbh0zqk?=
 =?us-ascii?Q?SKi2/rHIGjJfL8mIseJYzEouIO+PgHSvm8toJ9ejeH2aeG6GOawraq6Qds7v?=
 =?us-ascii?Q?ui6kSostkeo5RmaPbi9bpfHappK3lzOzX3YPbAnFmYIpFuCbjozy9vqBWwZd?=
 =?us-ascii?Q?3diH9x5zGQjlQF2osmRZgUw0cdvp3oExzcGsxjxSFWJ1sdlMdxBS5rWCtUOZ?=
 =?us-ascii?Q?aS3dvJcmS5EfU+MoQtC1U7uVUxdQ+kE031V2/h3s/okXr4gOH1YrwoYdEMoo?=
 =?us-ascii?Q?/nGFbWSz29PCZnBMbqvxbRdIS5mWW1DWl4o+tMo2X3L2BQXaCjjc89mHZBYt?=
 =?us-ascii?Q?XA7Z7q2w7knlGWsu9hI2ag/o9MBYCFNwz9Z6b8mYnDBsV5X+pAaycR+uJzHU?=
 =?us-ascii?Q?DWucSNOgvSLfreMCWwlvZm4iDPdjusZ5AHR9sljkmKLSrOZkmeNTrBp3OcCJ?=
 =?us-ascii?Q?sRACPjN47bMLsC2ZMr2GtM0Day89Qzi9z3uiN/ELrtiXeeWm3tCsIcDOnw2K?=
 =?us-ascii?Q?Eo5m+rUem2s0/S0SoOe0QT8TCDff76Z59SWHRzpt/vuAKtFt0RNYJdfYWj9f?=
 =?us-ascii?Q?f+zg9TsQ5Du5VdLtC9QL+IvES+4LuQeK0n1pkk0tjn5i5O5iCsHbxVIkJob3?=
 =?us-ascii?Q?buIpaMed1QcSywqbvj4EsYD+QfO1O1c/fCdm8ze+b3z4vCC7KVs5XL3swzYU?=
 =?us-ascii?Q?RZZsBghRTi3lc5P0rGz7+8g12N16DWytSS0VmecEYIekDJ/SN+psfEfB/5sJ?=
 =?us-ascii?Q?acI1Kkd/LqY22CGhRJ4rp55Oa2UUU7/o8Sxgd1rxvwN8EtUJ5zPP9qYPuBP3?=
 =?us-ascii?Q?N+dITZPs4txrTfGC0pvODgSlysWd3q6Hrul7Lq3glSh5u+2VSG4o+e+Km/Uk?=
 =?us-ascii?Q?DcwszhIvx5kzrGa1xZBfefabIopXuZQ0bja9gANg7p9tOaUhknVj1vEB3vOw?=
 =?us-ascii?Q?Xvg3Q5MZc80OGqOuLa/dkLZ94FpEYomZXfWGAbP7gh+g1ixyqCJSq4p1bmoo?=
 =?us-ascii?Q?1hL8IHyTK/AlUUHSv6kUDCQAwxdvp5MfOrHxMjRj2/9Qh7A7RcsT2g9KKa8o?=
 =?us-ascii?Q?PXbiKPbXjrzY6mhcxnmyCT8gyv6PAazeNLR7DTsy3/wuYMLm8uGMiOAdu5ST?=
 =?us-ascii?Q?or8QwPp6oRRojTosqythKjYWMRggrGHha8qLu0ICyH/NxsYg6zNcMDhdoPIx?=
 =?us-ascii?Q?JqPD/CtXe8aJ0ZWVyRuy+VUa6Qu2uDFCBe5xfcs+MXQkkBa/esLRrBiU+Mxh?=
 =?us-ascii?Q?PKSe/w4xGUiROE2jUH9NQCejO2H7QS1BD4OLsxhddchFmfPL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c1ed33-e119-4f1d-c195-08df2237446d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 16:48:07.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+Q3PLSpk0jyj/SNnbqmQu0E5kk1iWg/zkYAT+1aYdwmDKBsDYndU4hoShw7YHAhzxJ8SXWz0Q7XWppCLwfaBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

On Wed, Sep 30, 2026 at 09:39:01PM +0300, Anton Danilov wrote:

[...]

> ip6_tnl_rcv_ctl() refuses when the outer destination is not a usable
> local address, such as a tentative one, when the outer source belongs
> to this host, and when the tunnel cannot receive with the addresses of
> the packet. It returns only 0 or 1, so DEV_READY stands for all three,
> as it does for ip6_tnl_xmit_ctl() on the transmit side later in the
> series, although it describes only the first. Telling them apart needs
> both helpers to return a reason, which is left for a follow-up.

DEV_READY doesn't seem appropriate here. If you plan to annotate
ip6_tnl_rcv_ctl() and ip6_tnl_xmit_ctl() later, then keep their drops as
NOT_SPECIFIED for now.
