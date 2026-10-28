Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195872;
	b=yIlfxUtBm1LMwxo9auOvITiuQZ89CYH1iV4DgCjHq4Db1OrHPAYLen3BY1V79mMjo3kH
	 lIWzdLRcLw3E61uSFotKHpIADkARJ9USplc+8pIWjuaH9Yy9y2r51vxRYNCTFA8DC3v3L
	 lhe4aVM9KLIqJ+CVazaoFLjf7DTht7RdB2LHJRxfjdJtidrXPqgDewWyfet6f0k+Dx6SH
	 5nfBV+nKfBQOOKtJLnh4ZNFP2F/DCqp4tr8LzWXMF5lNrsuvbL0EJB/QnuoI1IHJDEZqu
	 oMmFDk/gxEF0mz/sxQGUQaeXYqNGALUPeaA43vnB9U5Y7ds4hNh6EX0V5EQTtUV7f4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195872;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=lFYSuTNU9Aha5dVkLgHFVvkfK+0CVs2/tZ42CwPSaCY=;
	b=TJZCR9+MAQQGUi+OZnurhuSJxC3vxZmsB020kxSfMGMzfNt+ESDO+518JD15Os4z2r+S
	 0WbYi6pTVZ9sG6KQ+htySn4hhqEQFbIL0yWCTvYlYlXanHioJ//SVkW25/vVOOVwyKzg1
	 gHHsV5IuLbnttOYLerwvSZRzVJKRU6jHHewWvANS7BvoUJvZp3iuEhZ038T8LnJbtebVS
	 ciB85cE4WUDiSMdaw/T3sQfOyaPXmfOx1e1WsaIRylCdVWS7hPG4nvbW6rTnOf4MqOAXn
	 dKFptU83xX/IWshAUjRLklaBPcrkbdVOEJx/vP1xIJmYvOuCfvCuTfungcgPDVDv4tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29901606A320
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 13:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29901606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EA2C24383A;
	Wed, 28 Oct 2026 14:57:47 +0100 (CET)
Date: Wed, 28 Oct 2026 14:57:45 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: Haon KIM <akrn112@naver.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: vrf: Set L3MDEV OIF flag for outbound lookups
Message-ID: <auH8PdGEPaf2GI73@luna.proxmox.com>
References: <20261026164702.1415-1-akrn112@naver.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026164702.1415-1-akrn112@naver.com>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1793195866865

On 27.10.2026 01:47, Haon KIM wrote:
> The IPv4 and IPv6 outbound processing paths in the VRF driver
> set the L3 master device index in the flow structure before
> performing route lookups, but do not set
> FLOWI_FLAG_L3MDEV_OIF.
> 
> Both the IPv4 and IPv6 outbound processing paths contain
> the comment "needed to match OIF rule", indicating that
> the L3 master device index is needed to match OIF rules.
> However, FIB rule matching requires both
> FLOWI_FLAG_L3MDEV_OIF and a matching flowi_l3mdev index
> to match a rule specifying the VRF master as the output
> interface.
> 
> The matching logic introduced by commit 2d300ce0b783
> ("net: fib_rules: Fix iif / oif matching on L3 master device")
> requires FLOWI_FLAG_L3MDEV_OIF to be set for OIF rules to
> match the VRF master. The existing outbound processing paths
> set the L3 master device index directly, so
> l3mdev_update_flow() does not set this flag.
> 
> Consequently, OIF rules specifying the VRF master may fail
> to match these flows.
> 
> Set FLOWI_FLAG_L3MDEV_OIF in both outbound processing paths
> so that FIB rules can correctly match the VRF master as the
> output interface.
> 
> The issue was identified by code inspection. Runtime testing
> has not been performed.
> 
> Fixes: 2d300ce0b783 ("net: fib_rules: Fix iif / oif matching on L3 master device")

I think this should be:

Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")

> Signed-off-by: Haon KIM <akrn112@naver.com>
> ---
>  drivers/net/vrf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 79d433f49f80..f22ac91fefd4 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -432,6 +432,7 @@ static netdev_tx_t vrf_process_v6_outbound(struct sk_buff *skb,
>  	fl6.flowlabel = ip6_flowinfo(iph);
>  	fl6.flowi6_mark = skb->mark;
>  	fl6.flowi6_proto = iph->nexthdr;
> +	fl6.flowi6_flags = FLOWI_FLAG_L3MDEV_OIF;
>  
>  	dst = ip6_dst_lookup_flow(net, NULL, &fl6, NULL);
>  	if (IS_ERR(dst) || dst == dst_null)
> @@ -506,7 +507,7 @@ static netdev_tx_t vrf_process_v4_outbound(struct sk_buff *skb,
>  	fl4.flowi4_l3mdev = vrf_dev->ifindex;
>  	fl4.flowi4_iif = LOOPBACK_IFINDEX;
>  	fl4.flowi4_dscp = ip4h_dscp(ip4h);
> -	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC;
> +	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC | FLOWI_FLAG_L3MDEV_OIF;
>  	fl4.flowi4_proto = ip4h->protocol;
>  	fl4.daddr = ip4h->daddr;
>  	fl4.saddr = ip4h->saddr;

Also this is a breaking change, before the patch, this rule matched:

   ip rule add iif vrf0 table 100

After the patch, this one matches (and the iif rule above no longer does):

   ip rule add oif vrf0 table 100

A selftest would also be nice.

Thanks,
Gabriel

