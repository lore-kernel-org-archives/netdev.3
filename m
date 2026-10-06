Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878C2D5937;
	Tue,  6 Oct 2026 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291092; cv=fail; b=lisjjBO8x/3FQ/7T1WtBUrtqzpGrbErpW31NeeP+/Mm7qVJW4K3X7hyot2fXeXWTd4XVbGsNT8b3F6u8b7390B0x46xJRs9yoFjYKwb0Zi8O79i17xeVZuVcgkJO31cYf7J6tTgJ+u61RKqd11rpIEyLgngTNPiTZ3Tikhl8940=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291092; c=relaxed/simple;
	bh=EIWQL3zHfL9H6VsNhEYl91xdQIiIueWM2NxBJKqncXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NE9MS+B7BXPcleLNFMOdTi23p5JYNBsrn/cGub2qjqIAVgbuBjWHwxXzLWr+xVscDwt6hvlIYBU3EPq0eZzOeTYjWlckg7UNQOWt/vvhrpn07yMAOVtOrM3MfvcVexciBV/NVT4hyWkZqXfrgsFBOsqXSl5zuKWZnukhJCMVyr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K0Bo1110; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K0Bo1110"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRvY+raFYg5jhKvs5Itozr+vpqtwi5VDxkpZlsQRyFya6Yl1tui75ErxSTuNyF4ZArVj0NictX07ZDKX8frOCwT0WYZ8g+iIh/G/DEeYPmMKNPzcOpueQwa4/GCwor1D1G/20P7Vez3wUtf0UL0VfyxdfKOyAfgOYW2czZ3sMoW5oHJmYd9xk2nLCdk2jefLYp0grgefyW/WSRT7L4rFkt5hZiXXgCUwT3TGxEwwv7eHeDs33nCmW669CerISmJ/upjBQqqs9HP7CTfRVQwqvUZguidQQIQ9XTIBX9fodrn7hSVQotfK768fneEsHmyduddO+BDw/8m6lvWo89G4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIWQL3zHfL9H6VsNhEYl91xdQIiIueWM2NxBJKqncXQ=;
 b=IUUrNAwawTk6Mnh5+KwwXjQGAPnBohZ0KerwZPLrICn6IqlQWYllHGikvwcGcrGzyxfR1Xu8P4Z7w5ZNl+YfY7Q44l8OyXg/lJ5dgPAU43pUqEFcBnL+chUz1OQJbEl1qK+YBGP9viV2nHFzsgcCCgNFGoG3/qbky95oGAWkleSjCQYPHT9B05vfRhsTwZDLN8C4riTCre6Veb8Taq/zeBs2+iLqV1locLcFYzj1g3ygwoK8/YoeRhHbatk7+n4gi3GuXcVctz8n3OCgLreb8NCY1keFzmipa4jhpdVMN8CEP2Rs8gNhiPJf9+eA0bP6gZ4lMofTcNJ1xPC/cM8/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIWQL3zHfL9H6VsNhEYl91xdQIiIueWM2NxBJKqncXQ=;
 b=K0Bo1110oLuuyLPZIPn3f5HYUXKl3kqvX2ntW/4hj3jRtMTAvn0GEJB2SfFwnRx3O1ZZEm48V1z6SWAGWAjyfxUmLR2+7+LTt7EW+nhOrXo5ehNKyvniYv7VhZSao/1vrikpl7iSmMO2ahmLsciQXP/6IQVutuTqBwzoNsOGBbDySIp+Nl1DVJoxsTYXUJojpK+6KvR/TaAuJ3pIAjDe0Q4Kqq40Iy9n1/qvDExM+cAZMN81J+I5ewGvRb8YpK9OqlIAJlGVZ9EWJelkDLdaxmISC00OLDDglnENhCC2PCJ8QLcUBuMF7NK2smFeeWq/NYLzLTVaiuTC7Gnvdt2DOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 12:51:23 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Tue, 6 Oct 2026
 12:51:22 +0000
Date: Tue, 6 Oct 2026 15:51:13 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] vxlan: generalize and refine drop reasons
Message-ID: <20261006125113.GA754886@shredder>
References: <20261005201417.906344-1-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005201417.906344-1-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 8171bba3-6181-43c7-534e-08df23a8860b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	obt/F7YGYAJpXOBz1gbbqQfeJznKsblkaDuAThvWx7OIe0yT3+fRh2WcE59KDZiNgbIYpzuh7+IUceflIbqLz/I5jKNMhtMa//YIsZQY+i8/b82jBGi3nYzzRzrOgPVB30QjihEkhGfaf0INwVINDeidf1wOUH1FWx5x8AZWRpGpM9b1P8yudgUfBHBh5iJ7k/08MOgWAwB6yPOqY1ek/MwfRb4yNV5BoxKVZgguEAdsJK4ux5x7Qrt1fhiR2K7FTGxeDEyfTGK4eGQScgQTTGQiZ8heKVqMB5+unTOHDMm2u4t3fb//T/ep6l76Z+WsV/QJngz4tbyW8E63l7xPBPWkAMNWdZuZpICa5wrNave0JSMFRFmIVsEn0KfrKTJ/1faUCTkuMbit+qgKkt3v2tXa+NYQ8Rtn6Rig4G+rBQE2ETAlKshf5QLmNNJDaC7eayrOnYD9U2frZl9/D/Kku1z2QNbAtOEGV5JUFg5WOAe4tPEf4kxpNqiXi0yszYjUrTbymMLhSKAGmnQxuwIVl6sAbm0l7Rlmsb7KrWQwjeYa99ma6q7jZ01nnACUHpCwbvHwJLoPxzpmtu/vJAm181UNiz/0MAIv7fXElmlvWUM8zTYZeNLi0gjYQtHsBjg4Cbz/S9SzKFr6XxlgXc++XInBg9S6rXeNSXNZAytYrpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pQAv/8sn6ywBXWNf0Uq1J2l0oFv9VbTTCOQP3VONM59fl7e0MInsh6v05eyb?=
 =?us-ascii?Q?iXEw9CyeYkOEDhKc5x1vRg33QmzxG+uD0nRAjATE9cwipofYDLWrOX5ZciuA?=
 =?us-ascii?Q?9L1HBGRsyFZpmufEjfCDKGBVxcNz2OUzB77e/Ahojkou3jBbVgu5lVhZgv/s?=
 =?us-ascii?Q?suWLFiuncP0Q9+pBLgxsBptcIqBJhKyyTJT/Vc1249LvRDMGFLTaxG9cz79w?=
 =?us-ascii?Q?CXRQhnrL4puXDfKiKx262J82KRwKbjMjlkys2+7I5BYD3PaNUn83H1SJqzr+?=
 =?us-ascii?Q?6UU0ZYhslW+OdztgNfXkEnYHj4pzUg2JdIAws+YJiqzNvBlA0+HYJ8jYejMs?=
 =?us-ascii?Q?EPs1OVItu/FeLnt/J5EaPcdIudTjJGWj9dpsgaE4j8MdsC/6kxMoOUq/gLPR?=
 =?us-ascii?Q?RKnZjJuZXgNMwyqWcIvJy/fLmU5ywB+5oJrOVn1oc1PbNud1IDIesVL1VQ4H?=
 =?us-ascii?Q?j7k5j2CriUstLu22iG14j7AQaDest88S3mE794PJRGxyBWzpOxwdIR0JPneJ?=
 =?us-ascii?Q?CCDSCEV9DX+SBTtIImJXHGuSbu5hPoX/g6qSGCXVgHbvU6Cft7hmSUGTxcoV?=
 =?us-ascii?Q?FlOuj3L4X/9jty6nDL/86h6+Ak7H+vaZmMc9vDHJ91fi41rN7VQiIz61mQrE?=
 =?us-ascii?Q?FyDwJ12/9ER3DAKM7yYVtzAJYU7APexsRD9XkEm8bYjsCKaCryTPYQt2qpuN?=
 =?us-ascii?Q?o+YSV9EXNqngiYKSUSlx9Nl49g/eNzJxNJcFy7yR6gaQpvFosiAv1bD7Uo/2?=
 =?us-ascii?Q?6d6/vcp7cOwA4WRqws3jmfHvm8M4CYsF/6YMlr9SkkVtMQmAR955kB2ppdt7?=
 =?us-ascii?Q?28RRp6Zx1En3FyDYscbR7nyUTlCd2He3piRlhb0lob0mYzbRBT7/zKYvLBlf?=
 =?us-ascii?Q?p4L0u3+m3JZgTTyY2czMQM6Fv3BwMs4dmAWggljfYgrboM1SPDOc3/sisnBb?=
 =?us-ascii?Q?bnPhmH2YNHN1AqHBobANyDkZq96egnt+WNGQxdQNQDyRyOmvJ7TXhIXpxSAw?=
 =?us-ascii?Q?EUjUuGklzuzfuPlRnclvzWvLx2wALeb1q2eyuwrpjuwwfbjJ+75B3vOI0EYY?=
 =?us-ascii?Q?0juHuK+4XAA+T6UTQ4pfIOT47qyaMkBcLB+F0GBGepD+fQ+AdMGTdSaYwQYf?=
 =?us-ascii?Q?yFVmk/MH/z69J0alA3LiCc0sa/UASQehTn2fffjK+AJ5KAdZOo4L6r6YS1a5?=
 =?us-ascii?Q?nWVHEIevAZr7aJJOb/gf+ebzmQs/9abvOnVkaPec5AnarznDZwHCRQxGALsp?=
 =?us-ascii?Q?GWHFX5iDVN29XJQ4pqcmNorxF5dmFbmR4R2IvF3rkeJ7L1GN48F0tKU8V36q?=
 =?us-ascii?Q?pJHi0yvyM08STohhPcHjjKJduq312P93c7cNOmyLwIfm6nZs+gACitStBC5S?=
 =?us-ascii?Q?piVCzxZrOPKCNpRhPiisGFyX9lIGyLDCGCs4leQd5vgXZtsQTGioXvSBmsMK?=
 =?us-ascii?Q?vL4tI0nSYwae1CNWMoKvkxZmF4RVwxW4A4Sv+pQiI3r5+wEM8FbGsYmP5din?=
 =?us-ascii?Q?G1Ic0jEs9DuvCWg91IV9bJO94OS5m+xcEH3tiUG3L5PEEOWabYnDa06ZZt6a?=
 =?us-ascii?Q?UmAyWQlE3Qei4JCAb4XGeiv+CpIncotshkjQiiUCojCdcqI+DVJZUlQkPNCM?=
 =?us-ascii?Q?gVt3sJAoorgUCvv2gNtJy1KZE6DtH35m3MF1+iE1YITH+ySeWqPcnYwtUwGA?=
 =?us-ascii?Q?/X/EsW7XN0efB3pAnAva2KjPY9g3tQRwAyjnJH97xjxKGKsk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8171bba3-6181-43c7-534e-08df23a8860b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:51:22.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wGz9zIsIGJhyKAZXStSuepH8r3UAgpOdQ2p3E0oRwH8kMVdlvLnOcFm4oNqyWn3YmKwY3/t9064CXdmMAvFNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460

On Mon, Oct 05, 2026 at 11:14:13PM +0300, Anton Danilov wrote:
> This series makes two vxlan drop reasons generic, so that other tunnels
> can report the same conditions with them, and makes the reasons vxlan
> reports for two other failures more precise.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
