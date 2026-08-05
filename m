Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213141B8C7
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930040; cv=fail; b=iyAm6mAC1yOA72HuYWKhhB3CnxVoUeqkkWjbdpmBnneNePjdVBvFNDEXEIqfHP9TrepVR3OYfyoA/Wev8ijIpckUqzPnEQoD1Hc90gjasNxiXT200YQtmvd9vJ+BX3cENF4X/IP0vgolehGfIc9R1yNlwKUL25Be7uCqH/NBwbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930040; c=relaxed/simple;
	bh=Be7G4HmMaGDTWLsz7gKVcpJagVh7Gho7PWNqsVojaFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N3+IuHuqdsH3d7Jje9xfyHqpMf8tyOGziwu8K9hT5pdHltuitW+xukXQ3uA3F1s+RhsesN5GVtXHV0t/4dm2TxmTCdUsvoH4cJXQcxiuI2eCOVoDBK5Z2ZDtQ07fD0mcHt6AxRWhwZCAV57W+ExyVPuDl6j15Ba31XvqxQTQ4Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOFtL8uK; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOFtL8uK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HM3Hec3FCyuyWrlbKQ97gj+PkZQAwOi+IVtKgC2s7GyK6eHhLYtm9zU3Dupb/nFwYEFmTrb6sWJTwfOE77ZAn5qBv3pTXT0pyYZ3khza/AG4lu/VroFV/lCrH2suhYns9+iN0cQ5g7/C18SDVxJH4zFAEurXBkul0sSvmqBmFeqE2/RTHN4rdv709E5o535up5RqF1mnOEkQGmZ7+po6p1N8rls0htDdce8VOiATa+vhG8LeLc2I/jEYmnUjL6aEHPdqw9dozOVA/NxTK0u+7B2UqwO0ARk5rK34LumstjPGoKkeeicWGt3LN9VnTW5ewxZtqQPxKk71VtXeY7LAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAfkSaLhlpLJDQ+9iw6k5MRhos0T9JaP+2yXQ4+dKEQ=;
 b=zCuSaNaNGxJInymMQRDBYikvshCMlGruU0wzQCUbZNQC3/CEd2OtJZiASUDebCtFrV76KwEUnpSwK/ew6lppbsy/dm7qZ+EjhzVDlRgnqb0avdeVItDm2OEGAyzv2TqdKarIEypMP8epHekphj5FmRHdY5CUiysQw68zJeHTSh7OkpmKw+AfaM77GdF9FONrvNB0TJu8Oh0jokZOiFRPwRXGMY1yXnl0xaQAdIEO1lvp5b4CxdvcN1hrE9wuWDKvXTMgAG2lNXIVwzyjuuN8dAYsjSCPAnUzJGU9waqbWxruBdjC+JlL0JkdOiBMjMgzVKmF9uIb7fEBQm29w4OJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAfkSaLhlpLJDQ+9iw6k5MRhos0T9JaP+2yXQ4+dKEQ=;
 b=FOFtL8uKLnqZ/YpXYB0bvGp90C1+1fa113rOQ6ncBDZVYnNfYldLei81dAoF8G5oOGCX7aGWhUQHP5ncNeUoDl4l9gCoM0LyzTjuhMgOoUTbtByoI/oEvlvMOMZiRl6sGg6pQqEEydcQUOir6W7GEHghrVDGMM3E/y823u+kWg/kXks9lCyx05F9s6P33nUjvZFtgtYlGinnN4S5khPwe458S9p9aUN34HNLxcw193XMIYwuLUQgRR5fjzo5SuxXpFtdofrfdXfWqDlbaMiRI2V1uWzJxb4cH6O47KWqwBP9fgOHWI8HAQqFbtnBfXDbQs0fdjwjn2BoSvNdCvyioA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 11:40:33 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 11:40:33 +0000
Date: Wed, 5 Aug 2026 14:40:25 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, ast@kernel.org, kafai@fb.com, joe@wand.net.nz,
	vega@nebusec.ai
Subject: Re: [PATCH net 1/1] ipv6: orphan prefetched skb before ip6_mr_input
Message-ID: <20260805114025.GA1433339@shredder>
References: <cover.1785724784.git.zhilinz@nebusec.ai>
 <02db4590d0161e31a789dcdfa8d1be1a3212ec2e.1785724784.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02db4590d0161e31a789dcdfa8d1be1a3212ec2e.1785724784.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 29416ce2-a43d-456f-7c44-08def2e65bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|11063799006|56012099006|22082099003|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	eVyGUh4F3rhr5kL6FaOpTv+csbnfLzjZbVBF5Yn4BC9oXdpOppw66Mxzr9D0DGOJ9W4YKp3Y7pn+/+72DsxI1DHYE/zcfp8Jn8VjJkXfthomrIXhEJfjq4QU8MYL8+MLGLq7BAY5OYDaD+4Tg/GDttKarI25r2QlqwaxRomUb45SrYGWczF5FjI9Lq3tOymLgz7PROkt0Zz4nITZ4EVq2GpjXRCX8mWNeKPWjH9tleK2gjFk/2gMQt7SH9LJrNBjRTzzuiSU2MmNJHnBV4OZ/yv4ektE1zQElmfigcoAy4u1w+gesj917tK/dOkcHSnLQZMh5ieM9onBsA7TyGnwvtj0vtpb1WQSg1zvspseJIehWOKhNn5VjcidP8+cyi6tsMU4gIRcQRIufA55cxVQrvNoFnIZUzLMxJFxLCAhR3RZKWpHekBLRyGCrKBcAdn4swaUiyJw3YbRqVRJd6UjWelwi6yjSV2g/qAyilamDlX3V26FPRz+D+9iuibR1XCsq986fil696Gdq6LDmCuEjUB9EQ+sQXCu+EkbaJp20FYyWFQullIuOqNB1BwwaMSM4SvtBLe37SEOsmAkmPnQ0n8zbd83pPij2PtbhSkP7JDxpi+H3zpTN8RU5LLp4pRoLjcyu7zw+xyRC/VsCT0N28ftrtEEmrzF21aEc6sl6co=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zv1+tpnDFQ0YchL5gPmll7qYmErHRRkosRkjpCfAMRhF8E6mGWUzsiT7gz4b?=
 =?us-ascii?Q?8J45E4xV/ud+7+Yb8dsFxY64/3HBjbWbumAMijg42kzBQ+4wV7KYIU+fi6gM?=
 =?us-ascii?Q?Qnvj2EKGC7Y2k0Y8BFV+ioQdXvy/S4y6z7ruHX+nORm3R0qthNvbJkcxzrYq?=
 =?us-ascii?Q?rGOjhozyhIc1bVnZoIB6rIe3vwSFS9Gsr+cyGhemmdZDJTzssBxqjgTFj0qx?=
 =?us-ascii?Q?CA/lVxJw+cViAMYatwS/sVo4ZJ4OzQPOcNkSYSkBYZHYOocD7HfRbJrNRkGH?=
 =?us-ascii?Q?Cnj9lrqUZMcHKA7NiEM1zSoGUcASBvzYiy9qBnDwwkEGNz0x930mZ9D26NBg?=
 =?us-ascii?Q?LK8T2ebW7DDawKruMlDprfD87LaSmq95QsOF2RDPbHbu0oXfC+hbeT1E20gI?=
 =?us-ascii?Q?uhI4NTq1TSiqRseraXq2v697Sg1ui8OwmQ5hDMQb0a64iIv/pRl5czsNYq2J?=
 =?us-ascii?Q?7FgpF6KAQhBgbXd4sjMBOrMtZVZ8RBA9zLk4dfhfLBEyfS+MW0UJaqfW3W/6?=
 =?us-ascii?Q?z0KhYVMkZwHMTva7P6TpTVRq+H6cLmDEtLd526odGn4AaLGVtghasyM6UeuB?=
 =?us-ascii?Q?0YkKZ33qlAkm6P+5RrtdExTMhnuAn7fgdVhOyxDIXTpbb5XvY/s1oVgdUVV6?=
 =?us-ascii?Q?aE6behpBZuMJf/PvcGXYuNtf4NUrOMVwku6m7ZPt2jOTNcTFsarvNBMyEiWa?=
 =?us-ascii?Q?nl+4mtbl+mwENy+LpdHOm1GnP0XNrxaUMyBn7tAK4T03adb2OQ+itk0ubTau?=
 =?us-ascii?Q?ql7ASxgUQXgJ2LnSuSYxINg3957KCpUTW6806m79UHmRsRz5qvgWqVz9aVNF?=
 =?us-ascii?Q?SiY/ddG0S+xEFb6Z3nwkNcXQj9LjlTN3DGMWZNYXxR6rdNJhgDN34OzeUgza?=
 =?us-ascii?Q?2sjU0G9dsbP2REE5+koIvged2UL9iewSlN1RSKiVe9l5uuehUYDe/eAG8zs8?=
 =?us-ascii?Q?bk7aZsPs/jL12f6SwPx9uyHqGvFHhHS/PH2bPXDu/x+mKi5L0gA3fKWbL1fM?=
 =?us-ascii?Q?0Eubw4LVfAeszicJS4ImvXHAv29rLmMIo+nOF1Kug75Gl4e1eGoZQlo3QK3V?=
 =?us-ascii?Q?meEEcG4dgCB8kRAgdGYhlrj1NFfF4PrguIEhD8alEUcMrbfH5knQPeP6Jz84?=
 =?us-ascii?Q?FwxKT7nrTYjhQrPIRe20kpvtdgReV+D4iwpNwJMKk+LV9JmLPS0dee7WOtjM?=
 =?us-ascii?Q?p6kbGPz7yj3VbhDUFF3DNc6d+AelXWtXHQ4g+ZHfMInxXzBmpdks8GVJdC7r?=
 =?us-ascii?Q?vH//9U08Jrbphs22H3XVAB1es4vOT7z+XFHpeJPIQOb0wBQrjvmzDXnmbypX?=
 =?us-ascii?Q?jzd6nKJ9DEfbs65FTrrx10Fv+EigNKDhSoSe10fnhfYUAsZVy3Gb5+pu3ekh?=
 =?us-ascii?Q?s3GO1ekGR6SnZ+RtLXHODqUSAC5s00TPojlH2J8N3R3bWKoTfNscRR786ls7?=
 =?us-ascii?Q?ySypQkHdQulFKw0q7m6CHTPU17mVe5PR15knSl9MqNM0asWnwfrV34V9DccJ?=
 =?us-ascii?Q?uF3tSxz3ZmI7uI/1ELzk6h24OZdlTrEqUqt8Qcdc72YeidDiGqHRSkjlnDkQ?=
 =?us-ascii?Q?p3UWY1rkRu7jJn7X5OdZ3PphoizvAJOT+FWS/yC947CbYQrNjIf1IerAjdg7?=
 =?us-ascii?Q?Q/6amHaEnbHNLF86eU7maMntR7XoNuyqUkHqJtDmE+CCo+SOgijTyvPEqb1x?=
 =?us-ascii?Q?j1cfcqKtNE/Bvey/wynbZl/Go0e7BppftUfRcwxlYbgaILnoR5DPu5BVI1w3?=
 =?us-ascii?Q?MRmKO/e69g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29416ce2-a43d-456f-7c44-08def2e65bab
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 11:40:33.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQt3V8wjWrlpbKTNt+a9786ocUl5B2UetDlRn5dg34TqWPEZVA2sAHjmFLU8WGCu+TAxp4sVPm4lkUTNNIi6Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274

On Mon, Aug 03, 2026 at 10:47:10AM +0800, Zhiling Zou wrote:
> ip6_rcv_core() keeps skb->sk alive when it was installed by early
> demux with sock_pfree so later receive-side code can use the prefetched
> socket under RCU. ip6_mc_input() breaks that assumption in the
> deliver == false path by handing the original skb to ip6_mr_input(),
> which can queue or forward it after the receive-side RCU section ends.

I don't understand the part about ip6_rcv_core(). Early demux happens
only later, in ip6_rcv_finish_core().

> 
> A UDPv6 early-demuxed multicast packet that is not locally deliverable
> but still enters multicast forwarding can therefore carry a dangling
> socket pointer into unresolved mroute cleanup and later hit
> sock_pfree() after the matched socket has already been destroyed.

It's unclear how an IP multicast packet gets into UDP early demux which
checks for PACKET_HOST. The commit message should mention that the
reproducer sends a packet with a unicast destination MAC and a multicast
IP:

rx_mac = get_hwaddr(IF_RX)
tx_mac = get_hwaddr(IF_TX)
[...]
src_ip = ipaddress.IPv6Address(SRC_ADDR).packed
group_ip = ipaddress.IPv6Address(GROUP).packed
[...]
ipv6_hdr = struct.pack("!IHBB16s16s", (6 << 28), udp_len, socket.IPPROTO_UDP, 64, src_ip, group_ip)
eth_hdr = rx_mac + tx_mac + struct.pack("!H", 0x86DD)
frame = eth_hdr + ipv6_hdr + udp_hdr + payload

> 
> Orphan the original skb before giving it to ip6_mr_input() when there
> is no local delivery. The deliver == true path already uses
> skb_clone(), which clears skb->sk and the destructor state.
> 
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")

The reproducer doesn't use BPF at all. I think it only triggers the
problem after commit 08842c43d016 ("udp: no longer touch sk->sk_refcnt
in early demux"). So, blame both, but mention that the problem can also
be triggered in the bpf_sk_assign() path.

> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

More feedback from Sashiko:

https://sashiko.dev/#/patchset/02db4590d0161e31a789dcdfa8d1be1a3212ec2e.1785724784.git.zhilinz%40nebusec.ai
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/02db4590d0161e31a789dcdfa8d1be1a3212ec2e.1785724784.git.zhilinz%40nebusec.ai

I couldn't get myself to read all of it, but it does seem like IPv4
suffers from the same problem.
