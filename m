Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2A448BA8;
	Mon, 28 Sep 2026 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577980; cv=fail; b=BojIYwF54E7G7tBmXp9hyrt7Ha7fdFvi2tAnhr2rd6vsX/QyjtVMkQYhARIuyneAGbiDsm4BbN7Sko+j7ygwMAeFhmzvv5hwRph09wrSFndJVjox5YLo3gpc/4I8MHpkeJr68ewLvovleoWHwcNuLM18zoL9d9DwPzjgu80wT/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577980; c=relaxed/simple;
	bh=PXHLHhYAL22d22ctwd1JZBLwd2olZYeBNazbaRwZyA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vux9s8NJ4hEPOwbU+Xqwew+RYYt97+Au3GAxl9n01p7LJDScDJPpX6BX9S7eywFxQRDgamTyRcpszqOFpZQmZnSOzxZjWn7cSTf0w3/wcXg0i8+BSEhRxKCroEQ+AGrW0TXn6b7pb097ca7Ziwqvh7S29dj/JAOCFAv8P5X6M9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ta+M3EJe; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ta+M3EJe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT3Hupa/eZUJ4BIi54n8L5U7ZM+PoK4E/fj/LyX+wC9UTNKZvZmHBppG2+YdD01pAXT8Ybny/IFv3Z2FwnG/xhmnxCAG0uCKKwSp21/PkcEK3qJ/Pr0d97uFIlV+zhAlC9nPt5RJuBM018m+FmQjezXgMKjFDkMQUOCchJLUiMoKVnQNkWfI0aJL8UyXxof02qWX1pJpETxuZnqh7kZvpOnRrQHpxai9JEnEG+NuETYOMYBGdjoKuBqMYbq/Z2veglfOdtJXHYvS3CUJj/alSIULPzqjredsSh7I7LvMkMH5p+IycKy4oBQifLBHCPRsP6iF8Ed8ea49VSuWeZlVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfCkPGzadXXR+3wM10sf+oqUsD/MJRT9c5ZCoawOSV4=;
 b=HQ4ldcIAaZX1J1K/4AzR96eemrLrOevDviMJwbm8iJCA+wBmMY5pSSoOj41S11auqP4UhA/uztnpPApZc1OwQUp312bCfUfouS5e0qSEnEW3ULY/O4mak4UxIccBgxptiJczjLm0frlZY9cOE/pwPkBG3QZj8U6ogAJEBFqcoSasvxO8R8S6g6QCR0MyTE3c5cib2qnJRXpBsmNjgh83dkGb7F0ac3Z3pi8qkRjJcgzwhQl6bv897lF6FDkEV9SHtx4/oE9pkS0WYY+KngYBOw6rf5jj2gCNR8Zt+hypmY7ERJ3xkDLJZ97j3CwKi0qtUssExLeflBwCmVNGeWFhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfCkPGzadXXR+3wM10sf+oqUsD/MJRT9c5ZCoawOSV4=;
 b=ta+M3EJeXZADTPAAMnrbHaFrcUNPjoXCzeaBoiNF0fTjdLk1Q6oVXjKiv3EVQbfMvcsGkKWJ3z/jFkTdlHVw/ufTtHbXoJediUlAQw7WlnFb02uz6BQOXNcntCAFQ+BEJwA4UCSLF0mk8QC25g9r7J82zH+OR0o1ujRf2xQJ3ZBC4y0KCGEx7hhwDT4JENnWm2u3fr9ZZYHok6YVELkb968uf0Zv6u9iheemyRrC4GOO/uZwBVaMudQZc0Zaict60NFZPoZVfDKvi5n67HWXpG60ezpynrr6yA5fy2zvdkirLqPI3GFo5lxkV6SdT/6x7U9ZM8P9YzxJ7E7VzCMqig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:46:15 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:46:15 +0000
Date: Mon, 28 Sep 2026 09:46:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 04/10] ip_tunnel: add
 __iptunnel_pull_header_reason()
Message-ID: <20260928064606.GA277873@shredder>
References: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
 <20260922221507.3268127-5-littlesmilingcloud@gmail.com>
 <20260923154114.GA2880695@shredder>
 <20260925231216.542209-1-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925231216.542209-1-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: d977e9d3-d3e0-470e-ff37-08df1d2c30ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ml9i5ok++KxBQWdxSSJK8BWOgwusuWFcV3g250fqvX6o0SFZvS2snQx/fyQh7A5NeUNR/1V78rfEaw58hI44TWNi1uMjGyHRVs2AJ4g1AqRcqdbQn9RM5UxQj3BDizL0pwzgRP+7dxYJl4lytjduGnYZGhMkNvfxvkVG/zSG3UunlqKc4IVkbNfAO9JVOcj+r2LmlJIo3BE7CiKxpr+dq88DcDO+UfUFjstJjc0tGx6cE5ocZWXvZaMCkThluvxUWcNXVWQWmwnhQ+AEUwcyq+U2Fy3ce2QcmggfwImTsxtB70/+Z42yONsgTXSlbYGQAewU7iDxMA+a/PHsOdTy5KmdEAEXlRzewl7QxAw1xlhBxxvWa07wOkrK2r4psqBAf/dLKq+K7u+QVYXBLGwl3TSXC665NBEQo3xDsghxWoFr3mGAPYX8h4IPmMd9SO1y3MPW8DNZniC8fUiv91QR9UaxF5rAr8v7wNdy+TBXWx0X7Bdgr07ZkRhZdCC0JCvMIlaa8BWNmZ6sYbxAIBpJg61ODvmKTTAGw6W4e+985o5XZpFIT+nZHkL1JGv4aqXPbXJoagLO+jjvlfhHt2KDdlY1SFPvOYRzZANS7WfXhcotQ+remBH+RQwwd137CB0nZcSoB+bZ3IBsljwDiyymOS5qZDK7M1i2tqEQxIHRlRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KhmxxHtc+c6oxb5TlOenis7TGCR3nZHmJlNKgxxhd8dyKk9toAHtp4bx+2vi?=
 =?us-ascii?Q?HvIn63EMfKNWxvX5qS91MAKhysg0TVJW+YErefcW1W1rVG4YeheqJIJ8neXh?=
 =?us-ascii?Q?RLh/04bQvtEdo5Xj8FE1uSVZcsob5NajRzkZQxiE/CdmVyETsfXtm31T+7H4?=
 =?us-ascii?Q?SyHa58goqCm/ZXLN1VyRAnipBfBOPG3cAUXGs55XmqU0Le8NwIkEXnSc8MGQ?=
 =?us-ascii?Q?VbteYa6KPyuwkWy7rbpHrb4ipm2OXKZWVOp5Gsx4/JljpeWTb899yv9V1pFG?=
 =?us-ascii?Q?+31o4o/MPtrij+FQS0MC9G6tbgMtqNhoukEwgQASLyPM4GwiZngrUyiKc/eN?=
 =?us-ascii?Q?yK9jCqKKa2azCmvobu5quwJBKtzov6FbGs/WL3XUsuNpUumTuZBk0wmakOau?=
 =?us-ascii?Q?GkiVL2rYVycGWAzDYphoq94ZqxL8OMFIF90kk/3zYT4DmDvOa4fuHWkPSQsx?=
 =?us-ascii?Q?56Ob0XmFUjBEGxBdP95Ir9BYSHuYJ3QgiY1BUEfPWKtaNKRsN9lrJXYH5O6l?=
 =?us-ascii?Q?zW30ZGE3VS+KecJrLaOs3mkyWhQS/Y6qdvP2+ysssRAdiQ/hi6FW1k6nW+dQ?=
 =?us-ascii?Q?6k1w2aZReTtLglRLMcB3TCbdk/ZoqZS2iXPxedI973JpG84bZHLFOPRWvjhZ?=
 =?us-ascii?Q?aYlVz0Xg3ujLsFyarVLZb0qbKJfgnkzjVnoFJdh7I3YuvuKPrLtz9Yvg4frR?=
 =?us-ascii?Q?Rg08wTrNiOpX0uPFpXH4m0BOUsxhAE750Zik2Ato7TPkIlD1T1QyGMAnHQGr?=
 =?us-ascii?Q?v/MFHFz+N/OrGkScwPLwQAE2SzFyBQiJPZ0m3o8cnkDiTRKzrON/v9qqZQOC?=
 =?us-ascii?Q?JyyTVDY/ATAPwle59fJjwnQO+zj5gkZ9HUXaSB1foc32PN3zmIIcuN59Gjzw?=
 =?us-ascii?Q?YfKVhnslPPAWexxCjJge6QNnzWVYFUFBuK7z7A7HfeV4iZKg7gkR53TMaiWf?=
 =?us-ascii?Q?GdVjPABcQU4Ymnj5RC5f55yNej+YYNiDt9XYzm2hi1SPSr94RtpXtXuYdPnc?=
 =?us-ascii?Q?E8uUm8+CRc4yVAK2f6TOXZ3Pqm50xyUlyY9pf1M0kjo9YlSdZO3GEqIeI8/n?=
 =?us-ascii?Q?K34fpAYjkQSQRwNqRHx73Ch9+CJ2Yk/ns56aod0HdWAFJQo5/wg1NSABCcNV?=
 =?us-ascii?Q?yOoRX/XCFLbzbWTTyxN/SSfVbellkEtKSKyUOgChzZZXgG8NPsa0rhh1DNpA?=
 =?us-ascii?Q?o0VUk+kx0iPo7U+NnDg7nhBCcfaDrooKeBrgVxOBBd3JYIGuGE2ecALoQY2j?=
 =?us-ascii?Q?YJz12Vlwubc6R4obE5NPoTE5BpBSLvwxwNSC8Tw/N9DrRTlxzT54BB+/etpR?=
 =?us-ascii?Q?Blz2xk/lwNojewgyMGRLS6mKQt/dopPmFCaOgj69KgTm9bNb7sL7bCkyP4bK?=
 =?us-ascii?Q?vS7f1t74nNPaVafiSR2b4Xp5RI0eNyV4LTWo+uPhKKCL/1pQV2niOB7ekLzh?=
 =?us-ascii?Q?R2/USmACV0Uq6qmeAbfd89C3bYjtd8t2Hx21gJFGNdXPrLZryPTRpT3a+5pa?=
 =?us-ascii?Q?E1wKjPOHbpOjX0u2NF84S6kFLpM9eVnyKu71EYsaGYEan+cQNV9SVbRniaDN?=
 =?us-ascii?Q?BzgGJvofeEtifTEouAi1ha/kzXUMTYCHqDB2icJge9iXtVo3WnkKoVAWiSHf?=
 =?us-ascii?Q?uNZpAqTF74Bk7j2SR5NTrLXEB1mNrThpcUkGOa0GOa29eB3De3w8R2YPm7UX?=
 =?us-ascii?Q?BbVwCG+JpbixdvR7rPRU22+z6GS3DSr3jO+qZl7Ac+6ga0CC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d977e9d3-d3e0-470e-ff37-08df1d2c30ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:46:14.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4xzsfQrIAkU2cr6cvS/F/RjKDicCPcOXwx08zB9ZxVJvsfR3ccfKuUb82LsKFFIxwnGbgyvvleZ5zGP1aykDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672

On Sat, Sep 26, 2026 at 02:12:15AM +0300, Anton Danilov wrote:
> On Wed, Sep 23, 2026 at 06:41:14PM +0300, Ido Schimmel wrote:
> > Either append patches to this series or as a follow-up, after this
> > series the only caller of __iptunnel_pull_header() other than
> > iptunnel_pull_header() is the VXLAN driver and it should be converted to
> > report the actual drop reason instead of NOMEM:
> 
> ...
> 
> > Then remove __iptunnel_pull_header():
> 
> ...
> 
> > +static inline bool iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
> > +					__be16 inner_proto, bool xnet)
> 
> ...
> 
> Thanks, I will add both changes to v5.
> 
> One question before I send it: is there a reason to prefer bool here?
> All the callers only test the result for failure, so bool works for
> them, but coding-style.rst (section 16) says that a function whose name
> is an action should return an error-code integer. I can keep the int
> return, as it is in net-next now, or go with bool as in your diff,
> whichever you prefer.

Looking at it again, why do we even need
__iptunnel_pull_header_reason()?

All the callers of __iptunnel_pull_header() and iptunnel_pull_header()
treat the return value as a boolean. Can't you just change their return
type to 'enum skb_drop_reason'?
