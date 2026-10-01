Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF273F3270;
	Thu,  1 Oct 2026 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790875520; cv=fail; b=J7nnSKVUUhnDafkaoYXU7kwYo6oVFnB42LrIEn/yqeTsSnjfoIIZR3bu9DHEiaX2SC6OuZeus+CidOl8kXI+ewVfgMjjlShtuRhgJ6ZWxiAUrHiDFYbLhv6ImoyYHZIqeiCnzC6KxKwMqEwAjys5zVAWxVhFm/flh+MV0dOfJB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790875520; c=relaxed/simple;
	bh=ADaooecVYIiUPPM8pKoGJiRH0aXuAq4wdWIrXgOK808=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R10VA27wpQSmsDDTLPNZ+R3Tu6dRj1tjwVUwGQycqvEx5zAFJOKal1LRCAf483zUTWbsjKSVSSsMm6ZQpDjv5lHma3WnTXAct5Wh8Q+voq/VcGQ8YqtsRVcRBT7s7gBArUjiUTHr6yq/KLKxTA5b3SlKq50gI9kVNh3KFVlNt6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CLeHbjXW; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CLeHbjXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsSvs9ALdvF2lxko9EYeOH0/AjpM+5FpQLENtGCn3cLtEaDBltjiYttcat9jaZzdBMAN2zbZrPIbf669ylV/lrZj0Pj4fmU4zjbDqffDE7tVTSPOu4aOZASqztQ5Hk366+9fn5M2qpZ+95BYFRtuS+wMJrptZACyyhcIdkKuh3OEx+ZGJqBLT+p70aR+tGDF7MQyBgobJcjRkcela/gdc8qnuHsGH4p5pD893pfs28cCy82BsikHA6kwhg+Q+4j4P/WpAAiY4qNr/gz3HmS9HF+Nm1VtMRpnGtZsnlYi5tMQVGxfm5nrixIsGKOzeYdjuw/5nIfOszkRiPDU/qAbcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we5aozBPnVxajddT4R7I8Jju1LpvW7HC8LN8roM8jv0=;
 b=YkCq6rQTvvy2WRnsUoRJG177LdkSQyrqUDL9jGb8IA2uu9yjxSIc1/oHlSmFaUAEEjUWwAxmMW7WCCWD4ypnjNpvfDq0CvKR1Ky/C7K0A//pkmekotmcMvhEZ/e2hJhBCf+rH0w16thK9K/LQy12E4/maeBr4M+WrynYffqCc3d+6FlDHgxSYptxdAObL4CFvBJEXvNdag7Ts5oiZUPGAQ4TbtzXmQuzpQKQJqB5Rd1ddi4mi0anvkQqiVpAFLQnikgcAzKk3gnOrOj38uXZGhRPL22EHyupfCZD9OFNVbpY3CRuresTLL6wZRML6waBhw4QFh0fJ5h5rizZek/nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we5aozBPnVxajddT4R7I8Jju1LpvW7HC8LN8roM8jv0=;
 b=CLeHbjXWejoKLf43MmDUiqEpq7Y5ORoI5/oHuezMtBdt+OyzwOQSy3WrEC9jSBx9gysI2HCvo7HAvDJm16dvvzjbNltxigkZGEq9t2Dg2ZbeM7a6I7Q9ZgqkqpfnY/1UzFg8gsv3n0xF2+FMsEk+ToXHHCh+Zcy+8podPh3lmp20HhIuroEkVPsnzsKMIcV7mQSNUeoYPeij1B+Cr80XXjLQAnB8d813td62nRAndybPv98M9VdZ7OULWFcaU0o6DxxNdMC7reGgpxu+hK/SkxC4nydrYvUH0YwrMrroyQv0pZgIt+ZegwsoUcgAWP5sIfcAClyppn+BlKttHTZAKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 17:25:10 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 17:25:10 +0000
Date: Thu, 1 Oct 2026 20:24:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tun: use pskb_may_pull_reason() and remove
 SKB_DROP_REASON_HDR_TRUNC
Message-ID: <20261001172459.GA1660921@shredder>
References: <20261001093925.3529772-1-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001093925.3529772-1-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: FR5P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::8) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: fd984925-775f-4bdf-5650-08df1fe0f23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+u/OGqMRG8C2vUSnvGVKFIvVt0E5llxnCUBjyqdUjqcTs45jShxS2hM2SXsKh21fyGj9E+Ah483gV6hBOG4sZSqavwproHV9sLwLFUerpS2PryFGzZqENSqIbTz0naDpa+PSk8lB3xPv4RmzLv/MYr58I5iQco/iFxQydt129TtW+iwBDJ+OoZCq9i7yJVzNG6A6auf0sUQCZuLGQthoW5c8XgJpFqEyrCCW2r9lgBwnWfeavsVgrKizmOytDMOPj6uTXRfa29rwInGUDF3j9ojNzGAIdSvMRZ9+OOkOWiFGx3rDzxuZvwhhetgsEKql76B2gDZFLwkNFk9dg07LsvBCLMIeGxQce9lo7QraKQrfnvC8NF68cFc8lJYNpw4XlfeeGq70y9wz8NSFjCPb5Lp8uOaj9chxDBZdiNS63G6dSn/RLxHGKKKMzK78JGjhaya08P9wnQ0Ky+A8PnQYN9WJgVBg0k22ZWag62nbqb7R8zduVwB7AR/LXMZjogBE+0XeRHcSFT/zqYGTAyu22Cdb9IEEBUL7mP5mFANfFzbGqHzU9x6R14SX7u+WhB9Ys0i55bzODSHtMVDKCoMC05SG6cIuph94AOFbXDZJ11AiRytL61GxODs8AVFGfUiT8bOdy7yYWJUYNHh1N25agyi6AR6tSo9jCsts77AzfWU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/i+4WTl1Sn2w1Lyd8371shCKajJmdtFB1jv+K3Kyd5eq9mB/f53ba3oKGcM?=
 =?us-ascii?Q?3lkqkCipmpNS1DfmU8IpDPkQEveI51OxrKpf4G0QbPBUEHG9jW3AErleVKQC?=
 =?us-ascii?Q?CYRN5mYtRGzb9gfxdfTrKC4J3xGpXW6lxzJ5X0ohU9Tvpf/qv/j75Zbh6AOz?=
 =?us-ascii?Q?bmtxBpsxWf0VQmGSu5Jt76HyqWnUYRlUB4tu5X986BakcqhMoMD/LwMKlpsM?=
 =?us-ascii?Q?k7TTcExWBF0JHQj6Lv7vysf/LHDTS/uW+1apYKq+504D85UGgtVyn4Imc/bS?=
 =?us-ascii?Q?WRtKAY1jpenoneZx+XSqAdsxFbubzMlqGNa/vsROwJD7x4b974JmNmGVFSLB?=
 =?us-ascii?Q?17V5AY1NiC46t50u1PhcWvaTGe3S12BQWA38OeR2kUIq1mF9dkPiuMKgUfnr?=
 =?us-ascii?Q?y92puM+Y0QP2ewzxbN5RVyCI5Av6HEWn84W6WbxiXA7TtIsgvn5r1Q3nmcxs?=
 =?us-ascii?Q?Lmck/AZYC8Z+Ep6ZRoY+QNzcXL6rTtWKO5X4R7ZcrWk3EeJgmA2sLS2XJNpI?=
 =?us-ascii?Q?7VCfhMt4tkuXtgX0WValeHdxq+OYZ3c1bUXuyGj2gFnmD836AQpircU1clcS?=
 =?us-ascii?Q?M+mxtTMzAKiSMqHJnJdGRM9yIrlV+/F+bVpH5qDcIzrk80a2Mqy67GBmQ/26?=
 =?us-ascii?Q?yAySgJ8zkpc4OVO2Z3no648yrI9XetkTp3vw3EqxWx9M/RqqRi0Fkmohw6oU?=
 =?us-ascii?Q?KDY+VBIPR/nn99FkkWtRN4Rm3nR40H/6HUmKQ2yGkVETgIhVkuUH5YIHJvVQ?=
 =?us-ascii?Q?BzEjy8i/F8uqhT4EPW2j632TEpwXV8j3OcWZVymYgPQME2Cr3EQxaa8L0uNz?=
 =?us-ascii?Q?+iOs8Z8N4vHb8O4MAhP3uRtsfheF3jsTxHxhgc0qZKWjIxiEnoQ/e5JBc7mj?=
 =?us-ascii?Q?fFmUqLn1utV+eSt262R4HUqFjBcsqebdBD1aj3FpMgwsOAOsXFqiQL2mYgYB?=
 =?us-ascii?Q?wJCP5Jck0juYwhf9UbiuhdwMV5kmkD6hUQopNVnHnWxPAZ32cslv8wKrvjST?=
 =?us-ascii?Q?tbtWcl2ni6UtBtMLGIMo1rp06c0cVvTZR6COhDsLp19JeNW5ihbb9UNxqiPE?=
 =?us-ascii?Q?9GUgOe99YDucDHyE1nXEQAz9SvX9hQvJ5BTK70JYLutaky3wLaCHXjGSg8PW?=
 =?us-ascii?Q?77f6TYi7g3+4tobjAUtRWIlyZHvUDbIqFGinU0KSr/efPlXSX4Keac1S+b4W?=
 =?us-ascii?Q?T5T5xaTneebbSWDb2HUO0CNrID81OJuQhwQDdOQn2g3Xo2y+NFxNntlEUcT4?=
 =?us-ascii?Q?8RjqlLgyAOqw6s0U/2zzunU7LjpZ7j0LvcyGGGDGFXfpIk4gL1i4KMUotDR3?=
 =?us-ascii?Q?d7fIiZmamQxKxKDsOSSRtfiagkTM0ZEkRuiLKX4MpsCewAWrehdZ97F7Gn2x?=
 =?us-ascii?Q?i7F8Q8WArMxc5clEejl4xaQFROv9kMefcA8XVPct8lrBiEHRWoCX8CwxEOh1?=
 =?us-ascii?Q?4SvBSJoAPu+NfWqdMXOvVgDxs5DGVi98/TptKvXqJLcdAyRz4zGTVoCSHxjc?=
 =?us-ascii?Q?TYgcBZuG+KjMBMFRMJ2wUCaYPzrkZG14cq5zyQgDvoB7c/QyzDHKrGoo5p1u?=
 =?us-ascii?Q?JSpSisqFE6G9uonetMQpJHPEYpLZ94InrHA+EbD+Sh7MZLizhA5uLiiTg8A9?=
 =?us-ascii?Q?foQrHSrKTPGE1AvlQR3DnkJ+IM5ChyM6yqfVXfbxHWpP+lOjWQwB3y2ygoGF?=
 =?us-ascii?Q?BF1Hg7IQP0+35tv7a2G8teaw/4DtgwW673mMi1CjBPxVvvyXClJYDKYzr6ru?=
 =?us-ascii?Q?Edvul/jr3w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd984925-775f-4bdf-5650-08df1fe0f23c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 17:25:10.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXo9gFPm+p6HrJZAF/ZmFIipJkme/6RWjGPe5fxbALnfuoaprWIBkqkhg+gq67D6LNngFPwn11wRQxb0YgF1ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080

On Thu, Oct 01, 2026 at 12:39:25PM +0300, Anton Danilov wrote:
> tun_get_user() is the only user of SKB_DROP_REASON_HDR_TRUNC. It sets
> it when pskb_may_pull() fails to pull the Ethernet header of a frame
> written to a TAP device.
> 
> pskb_may_pull_reason() reports why the pull failed: PKT_TOO_SMALL if
> the packet is shorter than requested, NOMEM if pulling the data into
> the linear area fails. Use it for the Ethernet header pull in
> tun_get_user() and remove the now unused SKB_DROP_REASON_HDR_TRUNC.
> 
> After a successful pull drop_reason is SKB_NOT_DROPPED_YET. The path
> that later finds the queue detached has no reason of its own and relied
> on the SKB_DROP_REASON_NOT_SPECIFIED initializer. Fall back to
> SKB_DROP_REASON_NOT_SPECIFIED at the free_skb label, as vxlan_rcv()
> does, so that this path, and any later one without a reason of its own,
> keeps reporting it.
> 
> The error returned to user space does not change.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20260923145931.GA2859441@shredder/
> Assisted-by: LLM
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

I will check the other series next week.
