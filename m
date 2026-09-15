Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413E408031;
	Tue, 15 Sep 2026 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489003; cv=fail; b=dY/gfgnJCLfTheeo8oTr+qbPG4QuzLFsevHz6epdiCs7iTFYyn8VdO19hMvehkCJhwAF88TtH/2hJaHFl3KmlbazFw0yDPOyHyO0SadSjV5RJ6iDn8DYd6tQrzZUIX7OmxU30qvd0qShYdevEJXoaTvDVaugqtaNtwTFHRJrZNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489003; c=relaxed/simple;
	bh=q8BUDdNDVP8O59HltxQB3qzqsT4Hv2O4kHKQnRexZ78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jU98K7ZiNJIIXE+Cp0RKJpAUE9TrR5EnivBLBmFPrUEhwjzQkajLHOF2A9riTcUHpL7ebIYeY8arxdE5vqitRHNAAEk08VNq1zQXSeY++qPfmXChWg/QQSmq356obpiX6QmpItzYNzc4VRiRt48j3b9C/mUY1ZEVGV+TXHzeFrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jyDTluUk; arc=fail smtp.client-ip=40.107.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jyDTluUk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXY+yJPTwKDecYPndNzAVHwq7yCb8Dt5gs24zUNbznlM8YJS/BXr0+dGLb68QPTRbUm8w0N9a36dLVV6UWyGRWL+e8Ws4ACyr73skW/d4oQxT/v+WUKbTn22WAgdhhbsicRbg0t+7SMduaay1LBFYfCtfd3mYhaZxu3HE79bdRuEZehN1INFNj1EoH9veHS2PF1U6ibarJDwL3MQVOzbhNBr3HvjLGizISAEV0MiFpn1uuC4wdQWDgHYjKlPWPsVVBqcWthOjmM2TPG/VLe9MPDJeDw0AQWHu+Lea9Y28XIAQoUIrxNH2t6HDTUOl5XRFOpJmr0+Dxdyyp9Z2DoUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ugl3TSJZHnO1s2iaW9GfqZFgH5Htv9vXq2bQ/jXoEz4=;
 b=Uj3kDBhJwXcTI2WAmUMb+o93Bxvu8h3NS0wNKYlJZsiWuTFvNIH/EBv7IfkX91+DUM2sR7fBEarp2N32bc9DP0jH0ERbebyaGTu2Hg+DY0f263jNTzq2WWFhEf9l58ZNTQV3n6qzIzcTUhaf5INg8fTR3Q9SH4kcMCjsdIlQQjsEYDOqSkWz34xLW3w1Y1K7DNq8RzsQ8RezaJd/mbGx39ubsgXJqlbFenmlBywgJn8cWI7gkuBP0Tdm3OlsNKI9pilMRk+FENmhwUARr6KRhogfWo3Fy+1G7gStIzhIj8G13R+YEfUrupWxy25p8TZPeDPOvZmJm8SLe4SJMw+Abg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugl3TSJZHnO1s2iaW9GfqZFgH5Htv9vXq2bQ/jXoEz4=;
 b=jyDTluUkpKT0d70v4H2IuB1K1DS7DPnn+NNC6JM7HdjWnNwwoJ4q/vVnOjp0CEE4a6OvO5lHjyPut+nSWbHw20n1dOzLYiLGTVH0oYmzypTsmeE56eudoVXVwrMFh632+js4I5u4lvre9ogukTO94vVC+0bC0FmOWRHS/WmIH5oIZr8FAaN7bkBAW7Q9owEtIa3FMbN3TUU6d2QXFbEFcqL3HfWvPIvaGzE/p/ldcMhcXoX+qQSNY2ypf0viU0STJeoSZ8Vncmklf4WndUtOkSkPjpbLoWnKezOolZDGcpH1sVGrXGS0dHFFI4wBt7qrtVo+lS0rho31blzPTFK97g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 16:16:37 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 16:16:37 +0000
Date: Tue, 15 Sep 2026 19:16:26 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Slavin Liu <bolin.liu@seu.edu.cn>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net] icmp: skip IPv6 probe lookup when IPv6 is
 disabled
Message-ID: <20260915161626.GA765683@shredder>
References: <20260911060925.94441-1-bolin.liu@seu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911060925.94441-1-bolin.liu@seu.edu.cn>
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 0540856c-fca3-4904-dcfa-08df1344b7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|6133799003|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	TWWTfis9nenMmgDN24EDZEyVF8N4+atPaTLNBc3S7m+liz2OSISU0Eil0Z53EUT6GZevarStITiit6CTX6JvjfH6ybqUPI48uCTSw3uYriaXibXmiH9jZElxfkKu5lU0uqJKXigyoSgA0hVn/65id9u8B3OhNrGavlR8pWVoBhZxmmTl9CIoK4VW8FnhyHPc/vQYizrdd378LE/o4AmDXbaL6ceKzB8UX9Rs9jRB2LkvVykGfwW77DkkejxDJN1MkjzUzpR9rukycPennH5S7yqRdQiRTPtMA1qHO2uZRVe7I2qZc5I4EJx0MkGj/Ramg9P/1CPgGtlKJwKXST/oposhj1jI97b1oofRgond0PcgU/J1hS6bH1UV3nloTLIS+l79ZSGyRBAmmcTpiEf1y+0R0WqeNakxhFPgk0karr9opTeS5HdXmqeh2wSXtQ65WJOy2QFnDFaZL4C3H8wwAVuLzvvXDH7Uvp+amMIP2BnMSOJ3OUK6FQlktGzsd5piN0oPxg3OYgw3OoevtfDH3L+50TaYjNpa+TE4HiLH68Pq0pr9M9gL6KHU2s7melmm+IQnSjU9cVqJANcnnAzfTcJq85Y4bznwqckm9IavGFOVF6u47mjiu908awy3hYE2W4JSgxhMsRJgBJLbZRZpIdhbEVsn9E2zXyiWDUE4ZGw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?llsd4qOELd9FasHgOtK4fD0D42qoIwSXi+b0KLHq+eWk+OI4NDZ0zvtvxD09?=
 =?us-ascii?Q?OvVHfUDrbcghE2PDDdN7g7B/JHQS9Ron4PtAnkSg7NzZN1t43zX2Byr5CCFR?=
 =?us-ascii?Q?FVIipkjV+baMid4S6quMZZqfrSXD7K2qdwlUwQCfZnBG10VCHEeg8Ao4iwMn?=
 =?us-ascii?Q?i28MjI8BLLZ1LY2htZkUuBJ4bShb1IMcMsHrCVzeth3h5DXJcZgNL34UpyDj?=
 =?us-ascii?Q?C9NBBJ/rz2byinUrFtyQsfnDRdYmnwZ/0+uTRI8+LVrlo5vV20Avrtc4fUmQ?=
 =?us-ascii?Q?fgclqG1WOezrPo/h44cI9iabi0n4KITSd3qNpwi9uqNGmpK/RAxwCcMj/aJB?=
 =?us-ascii?Q?u7V83X06Ot1sGV00zNUQmJ6RlQFVg4xkKqVJE21BFINYZnKgGoBNHKOLxSiy?=
 =?us-ascii?Q?/comv5Ntaq+Ihhq1yLtl1owF6a1ISfwQBSzo5HlCbZqCH7uBGmyq/5JjrqsH?=
 =?us-ascii?Q?JrmqkUKqqRawdkbuzPTCZVRjtbin5uqvw9G7M3/mRCC39f5iHMsej89RtveA?=
 =?us-ascii?Q?IacoHE43iYFAYn3yOPSjZ95Z/0CNGqR03XNly75lbUxdh98AgScdTXuHAZ7c?=
 =?us-ascii?Q?dmjxx0RCBn1JQ9jtXNjE3vOFhWljrI/DrgdnMWdwXVaJi/az/QF5ANR7zfaw?=
 =?us-ascii?Q?ajp7bT8PaYSYgRg6XLR4TNUF/Kvew8a7frosOLiIP2p6JCuktKMODpZjrI75?=
 =?us-ascii?Q?Cz8YCirI2y3Sd63+jA+q0p6IDbI5jykaB4yHMaTIHGSjN8zhDWsRzaXwdyed?=
 =?us-ascii?Q?D+fdLffk6/PtqlWMz07RC+06y5r4u6nWnnOo8XUPTUrx98M2PD4BY9WA4i3C?=
 =?us-ascii?Q?+AikIRyBOTYzh5DnQWOnjWR/WpNhVsAO5LvuPZ+F0TANdgrLHd5aCrrYFEgd?=
 =?us-ascii?Q?MBaD9mpLU2GGwk/7hCEtLlJZCessimF1wK0pwJFFh2uBGFWJYduxC4u2IAme?=
 =?us-ascii?Q?lqbfcwOW+I+oDQ5w+RjqPZJYUDXi7vXkNM54Qp8DTpMNylm6BYxCWMcZW03J?=
 =?us-ascii?Q?jObxHOHA/tC5gbX6PcvHrludRzu5rpBjzyc9QXntDVnopauOlplRBwbfwnmH?=
 =?us-ascii?Q?yxjzVA+KJBeVVmVGa2R2281lWXYdMYwg/lIbVl6Jm7EGEeFRn8yGKbMlp6SY?=
 =?us-ascii?Q?Vvw5SRgGpIYOkiqtPOCeo2BWraNqJ+mQrMZIITOJHnf9vZ9AaFGFwEPOc/dE?=
 =?us-ascii?Q?+Q7fB8Pf56EwXyXgOb2K8QerVZmUkmnRY0ddgMZvWXJuq4ENUrIeIpyxNscG?=
 =?us-ascii?Q?FhpSDduSL9vSeLrlv/OtjWlGbSZB7aSUL3frBzrRvkuzI/+8/JvyKLZ5mm9a?=
 =?us-ascii?Q?OUUXQJ8YXurDOTAQX3qKCl5ULq/yKK3fewoNqGqEvHi+JJD05a4LCkNCiU6g?=
 =?us-ascii?Q?KLOWkbk3PhDqkJl/TgwuKTLOTQtZUWIRvfkALF33YrcXoOyhrUpgjQiMnODy?=
 =?us-ascii?Q?D+MSkvDeHqWEsQHnLIx5wjclk3hXspvc6z9d2E61SgXQf6QDFHiF0/7kxnL9?=
 =?us-ascii?Q?1NDvBTvnfB8WBTpsXRKzjoTIdeguQswr3WyFs7nFnuVBwEVV9aW4fquYgP0i?=
 =?us-ascii?Q?YWc/rKwrH8XKeE/BG0IU8e+NjsOOK9BvGrK5zn+6uEmS7btwFWf8UXldeHGs?=
 =?us-ascii?Q?sgJpxe7HVy5OmlExTQNLYVTX4uA8XtMk6+QJkvGQlcG4o78a+MhlGb7pg3Nt?=
 =?us-ascii?Q?Wo6O3/pAgqE4zq8NSQWEBYhnSlNfCnDpLzbafOIydXf6WtOh0R3LSqALOdWd?=
 =?us-ascii?Q?ZTncr+uBIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0540856c-fca3-4904-dcfa-08df1344b7f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:16:37.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sqNYF3Owofpje2QVnG0nW4e4Ga+eLwC/bAXBf+7VOfsKA0CZMAd3XYqn328xXH35oxPA9A78tOrYmOMu/EC/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

On Fri, Sep 11, 2026 at 02:09:25PM +0800, Slavin Liu wrote:
> With CONFIG_IPV6=y and ipv6.disable=1, inet6_init() skips address
> configuration, leaving inet6_addr_lst unallocated. An enabled IPv4
> extended-echo probe can still request an IPv6 address lookup.
> 
> Check ipv6_mod_enabled() before the lookup so the existing no-interface
> reply handles this case. This fixes the new lookup-internal NULL access;
> it is not a patch for the removed IPv6 stub ERR_PTR sink.

I don't understand what the last sentence means.

> 
> Detected by static analysis and reviewed with AI-assisted source auditing.
> 
> Fixes: d98adfbdd5c0 ("ipv4: drop ipv6_stub usage and use direct function calls")
> Assisted-by: LLM
> Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
> ---
>  net/ipv4/icmp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 0caedfc7ca92..d8683b0151b7 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -1360,6 +1360,8 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
>  		case ICMP_AFI_IP6:
>  			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
>  				goto send_mal_query;
> +			if (!ipv6_mod_enabled())

Moving this to ipv6_dev_find() would be consistent with other exported
functions that already have the check like ip6_fragment() and
ip6_dst_lookup_flow().

FTR, I wasn't aware that an IPv4 Extended Echo Request can identify a
probed interface by an IPv6 address, but RFC 8335 allows it:

"If the Interface Identification Object identifies the probed interface
by address, that address can be a member of any address family.  For
example, an ICMPv4 Extended Echo Request message can carry an Interface
Identification Object that identifies the probed interface by IPv4,
IPv6, or IEEE 802 address.  Likewise, an ICMPv6 Extended Echo Request
message can carry an Interface Identification Object that identifies the
probed interface by IPv4, IPv6, or IEEE 802 address."

> +				break;
>  			dev = ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
>  			dev_hold(dev);
>  			break;
