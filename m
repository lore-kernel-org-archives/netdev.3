Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB03BE162;
	Sun,  4 Oct 2026 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130166; cv=fail; b=VShT5/vZpQ/l2Qkhe0JUkRas6cqVqyd8mZRChLJGtqAdCJp1sMHgXYhQs2BhxPJW38usCsPGf8gEC467lmHN0M16GIFWT0VxiLYR8AW+Pv91wNmV35BrSyYtniNrwtbMbDq7FukaAiu4u47qBwNYuf+ZhbkChgxusZhd1HHgQQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130166; c=relaxed/simple;
	bh=dTA+7lGegVCqUJVAIiqSGgftaT5XUgMvgCDbSikjebQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dapEeaksXA3PuEUbDEBVwvwwdwR8z6wSvYj8ObSIfA7EBf09JL1t4IazyrjGEW7Rik1oyiyQgZPL0ycNjVi2N2GR1y/YvB+S8OCLEiQ6mh0SElR0OLZ8cdOp5rzTy9FPA/6ZM0rCOV0lH0cf3vATcHEGig6j9XYGqdjBm45lRI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LzrsbcRy; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LzrsbcRy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvL6TWwjrU8w6wi3SOUjQdGr9ceHnkJxkDibM9LbD3EAeiF1hEIQv8uQux1Oz0cgbZSBZwnMtVZSkcWwoBlLMR/WHeM8cBnKCBps5quv9PyGQNpx0nC04wdjI3a0y7N4HZ6WbX37A7t9/gvu32u1B+M/eTTOaE8fyWwhq6DG1uaxTTid/2GYR15ap8oZCtMbIXSH9xew3hrpp9nqTkgL0NkuBV2Qdd0CBM1wMKW4f4k5IHcU8Zbsr0rkF0oQ5/xjztwLqTr3tqTfLCzJk+n1hkWxIyn9K9vVNPtdZxJDv3aY8ke5VIk1JBmF7//od5N/FtkXyER+OIEubDJnZHtzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FCsoaZLQ8lk7cLTL/d/zZC6YkfsBAqpwX4P5iJZO/0=;
 b=jav0Nv/0RkzEeTFrfNJunudI0fQzQDhZraxx832UCHudkMOeH/wmkFDFtbF8pJlFDT5DT3rIZtHKMqUxbWXMfDt3xk3OhpnfWAWk3ZqkLY8YJv86xLnZNX7kqbKkDK24q5+73D0msSTtBR03nKsTS9135TSe2hLDjGzs1UGA13H8sevyR3zZPe7Jdgbdnv+OeV4O51l8TgivHJP3r+MYWkekr7fGEW1isr5Cvbj7ejWtUC0vdfU8hKYhjqsgp0+PKODkV7JT10yrq/wWb1l385HpvZp6lpW4vaX8skYpq+kXHQEHv7f1NFRUtuJPk+lMpPcLNE2GND73AaWPLOTmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FCsoaZLQ8lk7cLTL/d/zZC6YkfsBAqpwX4P5iJZO/0=;
 b=LzrsbcRy8wxmnxn3lNG9f1yhph2n4wYqe+vyhaWC7bd6X2SnDlbyNTmUjXYGosGOe8Vbzb0gWuUdtaf1gb1zw/0Opl7o6fGjw16lZrJikA7668T3ihhq6d072noZM4jndG6f+QCOuxli11bSts65DsjxGOF0EWa9o7OP5ivnOLfH+Fj9UaSvSMnWmoGKqjxr2ct8aSCrP+H2qQ8d4Gb0rh/5NAYFF7SHtcx+GPhDE6lGT1rPc6+/m6z8iY3LM5T2tNSKrrWJ2sKl1+SLAHJ93MLEdWU1UQnHzG/Qf/93Sp4BOo6K3pzP2HoJnMaEQfV4Fa28bVmB7v7MX7UTReIt+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 16:08:35 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Sun, 4 Oct 2026
 16:08:29 +0000
Date: Sun, 4 Oct 2026 19:08:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/14] ip_tunnel: add drop reasons to the
 transmit path
Message-ID: <20261004160820.GB334650@shredder>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
 <20260930183910.3151873-10-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930183910.3151873-10-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: FR0P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f1bc7e-6d18-43dc-57da-08df2231bad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	+5kH3/Sr2zabnnu57q1wakyPBIKSXhQZGXm3K/weh6+ED1NlQ0IshAPkamN8Cy2W6TKXc4nnud+vsar6x/GlkZXq0uLmBm9Y8m3wrhGpmEX35jfxKoN2J08Yl5bWlbZSmsKcvNqm+APhAgQAyMPW5PcFuXxG1tK9XiQ6IkJfHLWtJYx2HxPik2caPfm7DXy8ts590K0aviaQObZ2tWZhiJwEzLOb6X5blqa123UrTcCQHl+Fhbsg6Lcln5T9PPFDVykER4YlckA7qY+L3E3JEKd2IdZiSROiJLNUl9XV/S+nb4SlsifzhXZPkGmQJk+dWMvLz6nJzwiw9Xj/R1ZEHpHyY19eFvKAixBxe+1IJtWTTueSmtqYkdeOvUaF9D38L1eeIFVqcW6hEfb71be1OzInsTNsipphsdUvVXna5O3uuvLJSihS9Pf5fbNv7Tzv5SX58/ygQWfze+WYZf88ZL9BkOjgQ0D4ikYVfZ6+uQ1h1fXgYKYyWz5p3vPFy7o+86hIFna+9Bmq46GCzzJG8BEQ7u+VqCfNMRs5UgfangPzQCRGfNLvLANfLHkhF1XZI1bES+btLyilP5TD7B4UQNXH78AFhJtPru6lN5YWq7pSG4luQVXhHjEyX23xb8IriRJwUbTDh9PlIkNbfXaV1vBZ8K7UgA2bHnMs4V50FXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWB95y/z8tPrGRAX6/6TMtMsNCO8Zwu+jz3S6XYmbpwYFjTHZYjzmhkhgC3M?=
 =?us-ascii?Q?6uBJeRHfk4DinvBTxHDfleVAtMFGpjAZlxK4h2f0nL4w9j4JBFhxXWD2lmF4?=
 =?us-ascii?Q?nFQPdNjPOFH2E9gQTD3rN/WIsNSLKdY/E9mDo7No84+ZouX+CpSo5LK+fRJI?=
 =?us-ascii?Q?wgOdCAXe/IHvvyQlLFzM8wnHvuVRxRqWZIvdwIGI3AHoUv1shuNJSyiBsCaW?=
 =?us-ascii?Q?LYzLnxo+KrOP19Apvzt2PS8iU0eHLip1FjJR9BcEdMFcFVASrAjV2omzkPtj?=
 =?us-ascii?Q?fDT7VMxdgsK9XPgIh2B8pgS9z7xd4QYNPTKaItdmFDfpwewFIVjfvvXvBTAj?=
 =?us-ascii?Q?VXjL/pZWJ2OID022mtR9KOOCj016mpkyeLURr6hkr7sNPh2go7c3s3ZLxsI6?=
 =?us-ascii?Q?iSSae+xh004U9DbO9OReeXBFtcy/HoIZv1yUktUjm7Dn9OHjtQzAynBmkX7e?=
 =?us-ascii?Q?gpVzVpMf3xf5dp1aKAZFXZWMbh5Qn2KoGxuqF7JvDMJcJySpqallRIoDSIh9?=
 =?us-ascii?Q?qt7W4YPqJ3UBoPBXwVNFWORyVIi2a9HenXbp8Nyl23JeSpmJIy1zU956xSTY?=
 =?us-ascii?Q?3DtGmG9kw7+rYK2Y3STsjD7UfN0piqigWygGU+wLoDzGjVFguaDcTfEGgSXG?=
 =?us-ascii?Q?krMHvr3L0qp1LaErFr+zjDo/lnGyd3yTk0FHFEpPRFXvrPbh6ujtd2mwkYpE?=
 =?us-ascii?Q?l6RRrQ/zrrfdAsjcmIzIq9mo2jZfz5N0r9/2+VnxwdsBtI24UsruTkkMeMLT?=
 =?us-ascii?Q?8UpF+aqQi9z1w6mwDx80JD7/iAbKL3QE9KuvTKRhNhddKUD1RnIw+JWvss3x?=
 =?us-ascii?Q?bZM4tpAUwK05XW9+xW7R5EJRG4Tikjon6ryh6+CV+ZfgjarizKbkiKyJPAvY?=
 =?us-ascii?Q?gBceZa+3nPvmP9HTOIgzysLg3D597JPJ4t8pr7SVfI8VCMAxciqy8uiUHV5K?=
 =?us-ascii?Q?TCu1SBULM57mdPrkBRCI4xNWYlwHbOhVDmZB/zdvbON9zubmKzNJIBvu8HIr?=
 =?us-ascii?Q?5tfgLez8KF1IXPcxlrpl4wT8Ehr0ZiaaHNOBjKINkdlh8vAkUK3fy4LPT0MO?=
 =?us-ascii?Q?J7NwrEPQ1c+nom4Iwth0n+/87dfdb8kqfwMaATzWj6UnwKulWYNmaLTCP2t2?=
 =?us-ascii?Q?MwT0Ts+fhRcLW2x/SPzCQYFjIBVSNWv/O/gLFGEqg8IhTxmY2fX+meQDBDY0?=
 =?us-ascii?Q?DmnVU6sceBxCr6NBntYCvpWk7huF0iXKv4+tJ7tC7qpe5kjQuIQg8+5oJcbH?=
 =?us-ascii?Q?qc0RU2Zjz1mSfmIk3ObuSM0E4A1sg0wBbuoZkuYhf+YxuAZbMXuqVGX8234L?=
 =?us-ascii?Q?lJPiY5R/A6TA1WM1KTyUYdevOSKKgXwmqH8uCSMN/HdVg+D0gu04AcLhIY4i?=
 =?us-ascii?Q?8kfwFDhjmL6uzGIFO5/hV/cU3MIFEKkcyh31oPlm0oNt1Nnj4/GFB0x+6n9/?=
 =?us-ascii?Q?2oaD7Tyd6U20wDjV/iBFeiC4nQlriPwA/08mzvkrp3XBaKT7rYcCNsaQAGbO?=
 =?us-ascii?Q?1EWehrOXWtECs0ntHRD8Qg7lhsZwNpOIedp09XSZ1oEgh5FSmNmEskrtQq1f?=
 =?us-ascii?Q?XnmM4n3CfDiZ77g3r1i9ZJwntsqbhTykz6Sr/kT/yCNfwgA/LyGtjikHpLbA?=
 =?us-ascii?Q?jFoyQXKUKnCtTs08rGrFLiYGYzwuknXiAc2Uv9G3uw4iCP99+jIvkSNUPjpa?=
 =?us-ascii?Q?bYpv+XFUNRRN+wLecBOdmhrm/xI9SE38GqbQs/o9CG7u6sJg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f1bc7e-6d18-43dc-57da-08df2231bad5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 16:08:29.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqFtEIWGMjg7ADVHvvDM8ArKeYYxLuXjTXhfmQssets1ibwt1vofrXl2tcgOSDzKfKsN08jNQtPDhBrIHGMTqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573

On Wed, Sep 30, 2026 at 09:39:05PM +0300, Anton Danilov wrote:
> @@ -636,6 +641,12 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_TUNNEL_OLD_SEQ,
>  	/** @SKB_DROP_REASON_GRE_CSUM: GRE checksum error */
>  	SKB_DROP_REASON_GRE_CSUM,
> +	/**
> +	 * @SKB_DROP_REASON_TUNNEL_ENCAP: failed to build the encapsulation
> +	 * header of a tunnel, e.g. an unknown or unregistered encapsulation
> +	 * type.
> +	 */
> +	SKB_DROP_REASON_TUNNEL_ENCAP,
>  	/**
>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>  	 * shouldn't be used as a real 'reason' - only for tracing code gen

[...]

> @@ -620,8 +623,10 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  	if (!tunnel_hlen)
>  		tunnel_hlen = ip_encap_hlen(&tun_info->encap);
>  
> -	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
> +	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0) {
> +		reason = SKB_DROP_REASON_TUNNEL_ENCAP;

This will also cover the -ENOMEM from the callbacks, where
SKB_DROP_REASON_NOMEM is more appropriate. Better to change
ip_tunnel_encap() to return the appropriate drop reason like you did
with gre_parse_header().

>  		goto tx_error;
> +	}
>  
>  	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
>  	if (use_cache)
