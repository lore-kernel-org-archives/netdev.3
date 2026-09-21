Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBEE4A68BC;
	Mon, 21 Sep 2026 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003522; cv=fail; b=JExmADxIvKfo4LxWXJq52uQKaSkq9JkaEiOztKXspNTYWdWbpmpwdB27ZAzK6qjxBkfETFuduHg615zo1L0pcfuOLj1C5DufBFWMxCg5tsBnHoVfqkg1B+Ii5FiPgvZVZdHbWDcgtNweHdjEUOYXgc/JaVk9rAw32KKHK5/ZOqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003522; c=relaxed/simple;
	bh=F2Rv1QLU9avI80WV8sRDdIloorRy+K1RtpchafvVhDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NmuU6yAxlmgiUGCW6aLmcDe2H3Smn4P+k5xGviDu23PFFSE1XdCmejnsAP4aHcJV5faGJNga9h0PbuFZGcG+iY41n/gcwgWBEODqqeGHGUBk65/Vh/NTohcImWd+KYJbM3kFp2oFOm+p6fZeRnbQ0MVD8D1LaIUUtteTbZt6stE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jpuxnw/v; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jpuxnw/v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pls7CTeAlTvWMNi3gH0myZnuOH/QG5kc4Yyb86R0R1ZImTloP5XV0PKVlGsU6lFsEIgphipZ+fn/UxmtJgei9iFNLfVhqwCC8bbkvJQ70pJRm3EVurYrmTnUShYDwwNdSg4C9H30QksewXm7Qar8Vcn2Uui737/Xmazl1rVU9cQs+aIjN9ZAxHq5i8t/MhV8gpBJkRhoe55KOkFYPRrXy9ayKFWDlpzmqgi/Iod7XvFQnGseOczL6M+9NYoTXFVhXZXgtI0omwSDX55p/+nrPi1C1WkzLXAnAOpyvDTDE/Jsmtv7Auo3X1kT5bELJ+xbPyZ14pcdKNe+IaZ/ENTHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXM4Wr//KG3M6zL9CImc62gsFn/OE6YT/x+NhwsEW48=;
 b=t80X5LbEXb3kNKFXf1x/10Vslk4s/A0I7CutouZyW/BgMERwuHhhtNSPYvAuzaTeiuHgDrZH2rTj/IV4zXeC6bzntctyNlvTPW8uYkBOf9x7F1mDWP/wHQ3hFEx7JOCsp1NAa7mDha/GiRwiOKZfVUOGcdHU627OlqtuvKfO3gFi1+3EYuGX2t3+8USLKeC+kiPa5RvguKezgOVQdQVAqedcPSLEcAwXMMLkZ1SxXBjQDY7QAMuGTJoXm8nI4NNjKmmQjXTbUE9EEWAX48eIF2VQ5o4/btLuEJu7vebQegzN9UKG7ScR8qGJtWfHoZNJe3q4c/y0P3zaTTrAdb0eAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXM4Wr//KG3M6zL9CImc62gsFn/OE6YT/x+NhwsEW48=;
 b=Jpuxnw/vRWvUESdDOjBt/tThIPe5CnbBr3oH2wX8mNUswCWJJnaylSKHtRD3ka0ExchwXqjKRsXUmCQkcN96ZrE5pbYHps42xrroa555pW2FksKKoW+PelWN/daNhoP+RbaOtidwDlmdhOAwuOZSZ0mBuYiQFEozON3/wu9ppOw8pRfYoHVAJfwjXnsiW0Ec+Qjzka7b5Q8lPnhqAKRA1cPs65LpDSNRQ+eNYCIcUPEvhmxZYUBiGXe0zSq8KBL/QyqBUs7YlAAPNHhzLaSlE23c1tGFVeNskRRq/w1n+qBFpTUeF2cVUDsJjEdP/qKtW1U/5avAwwexAmnheQEn1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:11:31 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:11:31 +0000
Date: Mon, 21 Sep 2026 18:11:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@cumulusnetworks.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ipv4: fib: treat an unbuildable encapsulation as
 a nexthop mismatch
Message-ID: <20260921151120.GA2269691@shredder>
References: <20260921130736.210845-1-g.goller@proxmox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921130736.210845-1-g.goller@proxmox.com>
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb3df39-1eae-450b-020b-08df17f29dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	C6ZRFyfX7zcyKM8f4porz+D7hH+KOafzAnYt9C5FX/OIUodzpiyi61AWESceUgbvoGNgeUjzmOEpeNdiA8Nj5DlXSicC1T1ELsyJBU5lNfytxy88QkNGNFG3IHvH6v5pWSA4Yf77m086qRtvPlC3kXxpuHZMAzOLjOF/z5QFuUa6/0E5qDPuFSPgCb3Psew7Bn/eTUJhMqU58o8XV0RQDkGmJp+xh2ufkHUSY2mydazfndk67FvIhIvMqwy3FErjpfWceCIUgQnz0oC2W3Kp8HhEAIWaiDM1SN4o42AjUbCRMBgBYtwZ5U13n84oLxxM1IfkOvtIhNl/kz+e/YlCzsSDrDnA69a/Db4ULYD+UB0YmpWIaqtDI9rj5IPk+IyeDUsLNCcBhrqlgVBHpGlt0tc+219qkj57xSgMq++UyemUTlRstfwfp60j67fp08WNDH5xKFwOTnkBANUy2x9GYkOvCy15vp2H26gPXJ2YV8WG8Dp/nhNB/QkNvhhQsO5DArI/tIJhqdFEzJS9jQFMJ7E6LFi1BiwwUhoYTkEI27O3e1EApsGKEfrMs8QlNNAegn0RWhmMau1FPJDkOU/HjCoOIioG7aH5ZGUFXOcqXNgg1iELtGbdX1xcjsDuTsOHqx57JCZD7JJKN/lYTLs/wdWRMAYRqk4QkiTmU7VUny0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aeqkfQhTNhTRYx3JazFPqUbSIm8PqDpIo0ZmkbyEfYrLYRvIJ9Zz60N6j1YU?=
 =?us-ascii?Q?ojoNH3Gxw4iFKPaIrxN11f0CAcZWVrVNYUyYzAp8KbBDov5PS3kpeK9I7Txs?=
 =?us-ascii?Q?ul5vvl0dbKW7tjXWwz27W/U4WUh59eAZ5hQIRs6OpG2gR4RvY1VkyVAoLWPK?=
 =?us-ascii?Q?kz1rvFj5XpmVIgxZEn5ND0A5bKuGeE80cZWivnL+/sSKUvKYf4ODxH8BClse?=
 =?us-ascii?Q?gE/SC384Pv4S6TfuG5U/sM0LGatWZrrd+4wuEWeTLCMRHzYnjqMUN2OXPDVD?=
 =?us-ascii?Q?/dWYWh1vkQMzL3Qz2yqTnuF/z0SNzO5CSeko7yY9sGZXYft/jRu5DZziZvdU?=
 =?us-ascii?Q?6Ozl6OQcgEudXz7KOxsoMzAt3rZGpb93CJefdC+N4i6tKs5qtsJTE+wyA1XI?=
 =?us-ascii?Q?XYJgigaD+cRI3VTkYSqxJ4smkJB3pCMpSJbGjPtU/pMJqWPY3AGYYaie1Ai3?=
 =?us-ascii?Q?9sGS8Og1gwQvejRtGy7JeSju2O1dPWEPcEBQhMQaeYoD5rVOjM6gmm98xnkX?=
 =?us-ascii?Q?OVzRqvL4XQiPSWkl5NH6NjMOIjybxM1bHKGb0tUD5n+sdq8wy17b0B98+WgQ?=
 =?us-ascii?Q?A1mH6MGSkSSYdPyQw0dMCSzkmDXgwXCJ7CnPvJbXygO6kdGCfIn1U512QKGj?=
 =?us-ascii?Q?x01LDfO6CDMejT6cb15122wonbWb/cBP4ry7eXt83crP16EEVlSuxliRCYMy?=
 =?us-ascii?Q?Dxam1IU+eMDifKv0nzzN30yFTdpHkMy0XCNB9/gxgNdl1pLI1YXlqoUzewB9?=
 =?us-ascii?Q?HrqTOY9i8hZEKGkAjSNYq9ZnU/XHeGE7f78J+J/EvSh1y8ZdDnMfCPZf9YUZ?=
 =?us-ascii?Q?tA3AOWQ8bCrmCjhMorKFIydpxf4NVrTGag1SlziVgRaN/1k/zz2GTmZiLcf5?=
 =?us-ascii?Q?f/wsmUsXOcVvuEWqhzD6h+lklMqucVZ0+tkHh70MKxPt7djTGXm/cV2s9pdK?=
 =?us-ascii?Q?HumQO3uUmGyn93otgCjK/9GU3hdHedyLHsCFw4b12+5IVLY7A+CHwkQ/d6DO?=
 =?us-ascii?Q?tT4kjrjLm3xIAfWFdEDOLG2WrFrd+itSH2VxTH46h9yQfWkW+ql71iGqm1mH?=
 =?us-ascii?Q?9qAtHg0N1odAVtuzZntORVwxx2TPBV3QQxXjVz5Iw4VGH9/7yPmf7e942NJk?=
 =?us-ascii?Q?wIzOtbQnjTJwmglt+DzrnlhGp//3TY7iM+IeorGohKsGszwQeWbVOiyYCOeE?=
 =?us-ascii?Q?UF1HVKHVjbzyzC4l6ycAtjyH13yqTfYHiGX1dxtowMw7a5BOOtpDrmmvmXLF?=
 =?us-ascii?Q?PJe5j8tBtErL1WMu1UZRz1DiROS55FI5MLltsguAf1TLyJbAAHuXP1QW/Rxz?=
 =?us-ascii?Q?JTGOMOB7ItBtbianDZtE7KCXVCJuLFyTyoDQPkFTu2Igzs6P4Ubasy9IkzlC?=
 =?us-ascii?Q?d1OHWShlBFtZ3mZdgpXloZIn99ZA9EhhT3roKdYU8/OoUwe1ZdduXYsgcjLu?=
 =?us-ascii?Q?8K/NfVrG6NyGa3RL8+Y45lsyYaH+8bRtIF38PtvL0aAQZG5cpOYdzbMmxAIb?=
 =?us-ascii?Q?d+r2NiZ/Hva/gkeE/vMb8TVfYWpFwyTbgAlaaP/sCbLpEfYiHhcKGI11XX+4?=
 =?us-ascii?Q?aHs1Z/OmGSM9P9C7xW2ZeHgypL7a2L1A6nOeF73SvfLVAh6KKtcszI/HgpPh?=
 =?us-ascii?Q?RRKbMb3nN0RG4TD2Ol1E4iIYEAWlOYqbRSYufWMVIedSLITDCa7kn6+TOunw?=
 =?us-ascii?Q?x0eMR1nZep2ZV9d5FC+A+3MA42Ng4BTDDPlcca7hajESYVbdlfo4GeJo494i?=
 =?us-ascii?Q?VYC5nAKSWA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb3df39-1eae-450b-020b-08df17f29dcb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:11:30.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8TZZqHBI2Tny1Qa0tdI7ykbAcUmJQDUuWCGk3sBTCM805ZT97bfMUowL7p3uzr/wHEWHrj2HWt5ZPSy5D42Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331

On Mon, Sep 21, 2026 at 03:07:30PM +0200, Gabriel Goller wrote:
> fib_encap_match() builds the requested lwtunnel state and compares it
> against the nexthop of a candidate route. When lwtunnel_build_state()
> failed it left result at 0, which is interpreted as "the nexthop
> matches", so fib_nh_match() continues to compare only oif and gateway.
> 
> So if there comes along a RTM_DELROUTE which carries an encapsulation
> the kernel rejects, it could delete a different route with a different
> encapsulation.
> 
> Report a mismatch instead. This also covers LWTUNNEL_ENCAP_NONE, which
> lwtunnel_build_state() rejects with -EINVAL, so the separate check for
> it can go away. It used to claim a match for an encapsulation type the
> kernel refuses to build.
> 
> Fixes: 571e722676fe ("ipv4: support for fib route lwtunnel encap attributes")
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>

I asked Claude to check if this can result in routes that are no longer
deleted and it came up with the following scenario which I verified:

Before:

# ip link add name dummy1 up type dummy
# ip route add 192.0.2.0/24 encap bpf xmit obj ./lwt_ok.o sec xmit dev dummy1
# ip route flush dev dummy1
# ip route show

After:

# ip link add name dummy1 up type dummy
# ip route add 192.0.2.0/24 encap bpf xmit obj ./lwt_ok.o sec xmit dev dummy1
# ip route flush dev dummy1
Failed to send flush request: No such process
# ip route show
192.0.2.0/24  encap bpf xmit lwt_ok.o:[xmit] dev dummy1 scope link

The flush is dump followed by delete and bpf_fill_encap_info() doesn't
fill enough information for bpf_build_state() to reconstruct the state
and it returns an error.

I don't know if anyone is relying on this behavior, but AFAIK nobody
complained about the issue that this patch is fixing for 11 years and
according to [1] you didn't hit it either. Given the above and the fact
that the modern alternative (nexthop objects) avoids this issue, I'm
tempted to keep the code as-is.

[1] https://lore.kernel.org/netdev/arEQHeBlqKWCu3l5@luna.proxmox.com/
