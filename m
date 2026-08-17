Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD523741
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948989; cv=fail; b=qjowCMt/CaCnkT9fYwuPPjojFt4/9aju2YKj7ATTAIvSDCjJL85se1Mthdj7UEv3lruq1k++Gp0XfwkxFUa92BUT/NyM2Gv4u8o8TwS6dpoDbKbsqon9d14pZRMmnDqqPZzS0r0SVJGC0CSowVxTgV/xEV6sgX+hklOJBBZGsm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948989; c=relaxed/simple;
	bh=dtVe3NbwVEYXHowKYFP3bgrYV61qH8+vjGPu0PLGo+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WW8bSq1skI0wTwbTTXhap3DclWeh3wcf4+ssqqKxv6T5wSbOPduvptYnI26ZHW+ayGmYCxqrtQRUumWOyH9lp/2+nyotrdB2isCm8v4BjZ0WDQ+G2o+ds2PfXz7fsxsdLv9atSreubVwvObqQrzJnwZSRnQ+iFkl3rVQ3/hkxYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NBWa8hrm; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NBWa8hrm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8LQVal4+u8ZaQY5VFm39UFvHitxRWHmhDQzzsHJ56PZMsHv8xqAckgOcHHhNcdD7Qe4t/8ejWL5tcVZ1etGatGoZkGW+qQyU3fUIdyB56qjx9aalOzlO/LQjin4opPenjhSi3UHdbApfNoDk9vCzcuK1RjCcCvD2EckOFE5GzFpYv1l5Vn93pWa/J1XEuYlb754w44C9EFuz3CFGu6ZuNugFshOKK489Tl0j2R8vS00sa77lCDZGjeemvt93PD1p9I7mCzKwZMKFHZiFiCRAnpGxRyrFrFNm1F1BeqDTwrfZPsbW8XuytnMDJUMq3sznQcfVncLOcX9v38A52rIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On094++C/yjw1gQXNDDxz3GTHYbcC3wRsvRqGpnXhj4=;
 b=YfAWs3EgFXYfKYGmfSUtVp0orFefCUea0YrP/RH+Ww/OHZGxTRR/PEJ/N7GwjoKHXEWqc8QKO4ttQ7d/OlsB3/G2FFGxIuRIBrhf3a6K4er7yVuSC+yYUeoKA6kZ31HJ5cOVSeFgGOvmlvgcn6P+iBE50BiXxtQcpXenixaprtPWnhLOxawiUwmAEZb3P1H5mq6QzkGqT8QS005m0MI9ZX3FTlpBLvXeP8GAq/p8Dz3/hEMmeYcbP47svjDEJ1Ta6VlsVj+v/iODRT37LGV446RldLFq+GUO4TtRkGPDKAdKQJdFIxVli8sP75uhGERP/u3KODm8q82NtSWOthkp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On094++C/yjw1gQXNDDxz3GTHYbcC3wRsvRqGpnXhj4=;
 b=NBWa8hrmn+6aaq/3g8JKW4jcIityzsEsMC96K6S8tSoggGMB/A9l42ZpR3yGCd5eDNyASVyEk8XpwXmlZ1utxlvzBWD1TOY+BhKsWYHYrSty695xfJdQ6VnbJMLY9vQcnmsw7mJ/CDPOjyqiKTiLuKQqHJNActfO7qvv717hoZBFPmsXn0GmEiAXgU8OkY+hErwDeAH5Ocef7H/9vZ7ANGCqe1cE+NaVy+ozffwawqUhd6zQKeb0WrkxGb3l+9z8ALF/J27ehQs4iPhjHlPr5pGdeSXWSUoQeDYysolNXvOVfzQOwyNLpqhVt2X52sRg3vbyBc/B9aWNevwYE66nDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:42:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:42:59 +0000
Date: Mon, 17 Aug 2026 09:42:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, atenart@kernel.org, yuehaibing@huawei.com,
	kuniyu@google.com, kees@kernel.org, kylebot@openai.com,
	thorsten.blum@linux.dev, maoyixie.tju@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v4 1/2] ip6_gre: fix hardware header length for NBMA
 tunnels
Message-ID: <20260817064250.GA196908@shredder>
References: <cover.1786542637.git.zhilinz@nebusec.ai>
 <64b46542bbe1701f07702aaa50273e2a87903db5.1786542637.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b46542bbe1701f07702aaa50273e2a87903db5.1786542637.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 254de064-448e-4ea9-ac28-08defc2ac732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	PyKSpwrToZv/mBtqdibBGycpE+paahwrmcS4lLmnQAwTpt1yfmdOTbJ2I+HMgx4uBUpWR+uc6qX9rxa9JFqC4oYvWM6/dniu28rqA28i5PZGK4hs3IXPnQExl1xV67hR6G6miGkJhtaC45sLn0H/jSXkKT0tCAGXjHjLLxA7kAsedDo28ltQ0DXXW73YGabG5NJY5nmZ0ucBCl4bpQiiD/SfkK1jBHypuA6WdikktW2DXKmNskz66yJoSxjSE4PQBMGK5L711d0Vc9ljin5HshzK+/MSHAbQhYSwxJzrTWc9UMdW89DQy52aqqFAci8wmppJHkLHsxYZ/qDxNU800/gPdW8GiNCK2AAJG9rDlDwz0ogiHnlVHYsK5xqhJ9GDwn7KzMOHxqnrxvhA+CJB8dEppAy7us9/sT8pWXLFs7PIP95ZzXl38tYwQewRiCPowwCnamS1RUGAPIV/zWryPtP4WqB9Hv7wsPf8fookbWqRmSoC2kWTtKTYn7wPkpBmodK9+G72RwduGWFB1OHLZGa7Qq1I+wy/VI74qQf1XAHNYo86KXtzklRyoHQVdZAJRyXTrCqaGXD7TWwPcS7BZFOhklKOLSvXF/a+HFsntOynWpJUMUyhExHKiionfFHkARcNRB9V7ZPECoO05waK/iMyfpSsw2NIKr+bukx25sU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ONuyYGndSR6ziVkIIJBZCUWocA278F2HoNGgq4KMd8/++T04ApSMN0DMGoO6?=
 =?us-ascii?Q?V35FSwHjFZk0afuHmSETDCGq7DGLnDNG6M0nY76ift05q+3sidJRS2uM0zYp?=
 =?us-ascii?Q?QUPOwEDUzkxUf35lCVONaqKWCTlXIMM3fOFYjw/aTyiVh8z9AZ4UcGte788R?=
 =?us-ascii?Q?bVWlrLvvXiYvn54BB9FjQWDAYVi9h4RqK5g1L/7Wl83vMmocn4CmtcfurRNb?=
 =?us-ascii?Q?lwe9biy4TS1S2edlkxye8mu/U0jHfGy6b30PKXh8IgsAOQbv9wXPelYI1fBw?=
 =?us-ascii?Q?R7qcCKmv0IEjZtFc+1F1Ffxc+gHovOA3QmNDJ3C7grknSfIWGTFGRyhpjbfm?=
 =?us-ascii?Q?emdZkF4/4r9VWsy35zmY3nAgyfa17vYTrn8vkI1xG9w+xr6KK/Stw0kAxz68?=
 =?us-ascii?Q?PkfhU7mPNGe33Rr1NB3luZHS4VU3652yaZLfeqlrZ/5fJ7crTBXqeSyxl1cn?=
 =?us-ascii?Q?wNE5fw9QD4e/TJ8zIyT25rDcu6PMg4CXEWp9cHffFt/HRhvo+6SImbcVuFaw?=
 =?us-ascii?Q?x8E2uXllrXKdLfTHQWIhhYsioyAo+2RsMPUkipWPGmtVY1fKYoUqrWg7y+1c?=
 =?us-ascii?Q?QICJmMRzY3UUIqHIU/Xa421QC8VZnMNWNHEK4StIP4pTweJXOAiJkGdaHRy6?=
 =?us-ascii?Q?t5ZWEOC+SZc9HFj6knN6sg5L3Ho7Nf+PNNqczmGGZaebpfyPpntzFcRE+Be4?=
 =?us-ascii?Q?981zKi9W/kayM5KboyaHnseTV3TmVcK5LIWQyHHVkKu/nmxV51vpwpwS4uD1?=
 =?us-ascii?Q?w08yZ6ZnlhN8DYV0Xb7H4ZtBjswUAQz6yuzH0cu0oj9lXHDWb+aX8aVFw1T+?=
 =?us-ascii?Q?35sle3EhL2gTw36wTQ8oTQljwgO5+78eOAeUWpXAhlgfOLDkzDsJ0pnzE3fB?=
 =?us-ascii?Q?0epXkkH5bTRWIUALB+qcoKdY98J2LFfqq97o0OBmnxaRGadwNQFGIjz80iAQ?=
 =?us-ascii?Q?/1jl1EZTemRyaUsBZofV+cSb+O+SYes/G+cK9JCyRdOvAs7sF/Pa93fPo1eo?=
 =?us-ascii?Q?jFyB7kQjf3Un4+bIVXX4lASioM9i8O4w0YYEmFNngIyCpLfOLpVqjfPwhf5C?=
 =?us-ascii?Q?vop5aZbgIu9qQadNe6V/iKwYbbn2uCTwOrfZzBAwRHbX+Kwd6Jc3bAzC6OK6?=
 =?us-ascii?Q?Mmar77I3eGZ4KybZmc0XTYDZG5nioDweRqjju9A/L274I5BtgLWmjsvuPVbW?=
 =?us-ascii?Q?UBOGS55/5gMGqqG0VkKd/nwZPJyJbmoVbfwnsSkRjw920cnJkimhtaVnZ1Zj?=
 =?us-ascii?Q?gdZ28i7C4a/HfBJivoRavd9ZxwyYzlpC7J9xV7Nws5VYsnZhXkXEqxoM2eOM?=
 =?us-ascii?Q?qORa4x+TuE3ClNeUIAVA6xaKFTE/+v/qZ/y599ZTO00IpYgOT4qCtn45y+1o?=
 =?us-ascii?Q?+mnTwgnbaIGiZx5xZ158vYng0SaFyUvjErmRKCtHocHRdckRaRiMXZUbPnY5?=
 =?us-ascii?Q?d8xHgLZiI0lfwvp++MKniKIKQEF66g21Ermn1hMzLk4RystTLO3sY7akGmf5?=
 =?us-ascii?Q?kdY7Nnl8qBCJLiipXeKZ4YA25S/siWtvHyOHjLemPJ0hbiAlfKdUxKQSXzlg?=
 =?us-ascii?Q?l7k59Lld5AeqofLyjjojEbxGnulMJWw47atk8Qgeq6UYOyP7BWHJXB+7Ix7v?=
 =?us-ascii?Q?88buodZW4E/DDm/qiaXVPHiZn95lgLihTQ9rH1wRjXVzQWRmSAzkI666RAZ0?=
 =?us-ascii?Q?gH22RG6zlg6q9saVWdJ8BGi+w9KLDHREo6TAi1w1vCRAOhhw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254de064-448e-4ea9-ac28-08defc2ac732
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:42:59.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+iAuLV8DLyK2VuFpcVrjgM9AJI8R2VP288dEWl+EChZi+K5V0w3fEiBWYh8VX51WzZTNOyfLn5khPhknnh78A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323

On Thu, Aug 13, 2026 at 12:22:34AM +0800, Zhiling Zou wrote:
> ip6gre_tnl_link_config_route() accumulates the lower device's hardware
> header length into dev->hard_header_len whenever header_ops is set. This
> is incorrect for both users of header_ops.
> 
> ip6gretap and ip6erspan have a fixed Ethernet hardware header length.
> For an NBMA ip6gre tunnel, ip6gre_header() creates only the GRE header,
> the optional FOU or GUE header, and the outer IPv6 header. The lower
> device header is headroom needed later, not part of the tunnel device's
> hardware header.
> 
> Keep the lower device header in needed_headroom. Set hard_header_len to
> the tunnel header length only for ARPHRD_IP6GRE devices with header_ops,
> and leave the fixed Ethernet header length unchanged for tap and erspan
> devices.
> 
> Fixes: 832ba596494b ("net: ip6_gre: set dev->hard_header_len when using header_ops")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>

It wasn't reported by Vega.

> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

You are expected to reply to AI feedback.

"
Patch authors are expected to proactively look into the AI-generated
reviews and handle such feedback as any other kind of review: either
debate it or address it. In both cases a reply on the mailing list is
expected.
"

https://docs.kernel.org/next/process/maintainer-netdev.html#review-timelines

> ---
>  net/ipv6/ip6_gre.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index b843116e9b703..70c1710910203 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -1137,13 +1137,8 @@ static void ip6gre_tnl_link_config_route(struct ip6_tnl *t, int set_mtu,
>  			return;
>  
>  		if (rt->dst.dev) {
> -			unsigned short dst_len = rt->dst.dev->hard_header_len +
> -						 t_hlen;
> -
> -			if (t->dev->header_ops)
> -				dev->hard_header_len = dst_len;
> -			else
> -				dev->needed_headroom = dst_len;
> +			dev->needed_headroom = rt->dst.dev->hard_header_len +
> +					       t_hlen;

"
Since dev->hard_header_len was already set to t_hlen in ip6gre_calc_hlen()
for NBMA tunnels, doesn't adding t_hlen here double-count the tunnel header
length?
"

No. ip6gre_tnl_link_config_route() is a NOP for NBMA tunnels since they
don't have IP6_TNL_F_CAP_XMIT set.

>  
>  			if (set_mtu) {
>  				int mtu = rt->dst.dev->mtu - t_hlen;
> @@ -1171,8 +1166,8 @@ static int ip6gre_calc_hlen(struct ip6_tnl *tunnel)
>  
>  	t_hlen = tunnel->hlen + sizeof(struct ipv6hdr);
>  
> -	if (tunnel->dev->header_ops)
> -		tunnel->dev->hard_header_len = LL_MAX_HEADER + t_hlen;
> +	if (tunnel->dev->header_ops && tunnel->dev->type == ARPHRD_IP6GRE)
> +		tunnel->dev->hard_header_len = t_hlen;
>  	else
>  		tunnel->dev->needed_headroom = LL_MAX_HEADER + t_hlen;

"
By removing the LL_MAX_HEADER fallback for NBMA ip6gre tunnels, what happens
if rt6_lookup() fails in ip6gre_tnl_link_config_route() (which is expected
for NBMA tunnels with an ANY remote address)?
"

ip6gre_tnl_link_config_route() is not executed for NBMA tunnels.

"
Without the fallback, dev->needed_headroom would remain 0, and the total
allocated headroom would just be t_hlen. When transmitted, the packet will
require t_hlen + physical_dev->hard_header_len bytes, which would miss the
physical device's headroom and force a reallocation and copy via
pskb_expand_head() on every transmitted packet.
"

dev->needed_headroom was 0 even before the patch, but it's irrelevant
since NBMA tunnels seem to be completely broken. See below.

"
This isn't a bug introduced by this patch, but I noticed NBMA IPv6 GRE 
tunnels might be double-encapsulating packets and corrupting headers.

In net/ipv6/ip6_gre.c:__gre6_xmit(), the code relies on the dummy header
pushed by ip6gre_header() to read the destination address:

    if (dev->header_ops && dev->type == ARPHRD_IP6GRE)
        fl6->daddr = ((struct ipv6hdr *)skb->data)->daddr;

However, the dummy header is not pulled before pushing the real outer GRE
and IPv6 headers. Doesn't this leave the dummy headers in the payload,
causing double-encapsulation ([Real IPv6] [Real GRE] [Dummy IPv6]
[Dummy GRE] [Payload])?
"

This does look buggy, but NBMA tunnels are completely broken.
ip6gre_tunnel_xmit() is passing the wrong addresses to
ip6_tnl_xmit_ctl(), so it is always returning 0 and ip6gre_tunnel_xmit()
is dropping the packets. ip6gre_tunnel_xmit() is deriving the addresses
from the tunnel configuration (ANY) instead of from the packet, as
should be done with an NBMA tunnel.

And:

"
This is also a pre-existing issue, but looking at 
net/ipv6/ip6_gre.c:ip6gre_header():

    ipv6h = skb_push(skb, needed);
    ...
    p = (__be16 *)(ipv6h + 1);
    p[0] = ip_tunnel_flags_to_be16(t->parms.o_flags);
    p[1] = htons(type);

This function allocates the full header length via skb_push() and 
initializes the IPv6 header and the first 4 bytes of the GRE header.

Since the remaining bytes of t->hlen (up to 24 bytes for GRE keys, 
checksums, and sequence) are not initialized, and __gre6_xmit() fails 
to pull this dummy header, does this leak uninitialized kernel heap memory 
to the network in every packet?
"

Again, these packets don't even reach __gre6_xmit(), so they don't end
up on the wire.

"
This isn't a bug introduced by this patch, but now that hard_header_len is
set to exactly t_hlen, does it make the disagreement with ip6gre_header()
explicit?
"

Yes, it's returning the wrong value (needs to return 'needed'), but it's
pre-existing and NBMA tunnels wouldn't work even if this is fixed.
