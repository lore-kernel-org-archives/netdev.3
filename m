Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE37386441;
	Wed, 22 Jul 2026 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708268; cv=none; b=T/NyXCzrYoT9cmL7ikb4BHb/WEqdjYArU4LNJthiGO2p4fC0tWqdIadMUkmFmj+Ox5uyCYTUK1MIsVUedmVH/I6hosNYHORcuS3NonjO/rB6r/qQ5nlBG7pQSXWkBmnkehCmIHX1Ughn+4cC38TPAEXsKlAbcH+YO2Fg7avlk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708268; c=relaxed/simple;
	bh=oPunUo4NuERE6JB7Xnp0b6B9e1YqemM0s1+ddG2KFXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqXmEAa/GoPgU+xKm0KqS/VdZesb/OmGhdtU4PAdF9rcgc03hdbMELgJVge0lkBwNCidhhSMNRONeTvRa9usyMYzlJvII1dmIorH+7jUXTYtOKyCocZI/uKS/aMT0rwKSKue0cukwFb+mfzO47uR17c0QNZ8ZON5zwtYvvJC/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi3uxyFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi3uxyFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11471F000E9;
	Wed, 22 Jul 2026 08:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784708266;
	bh=QaRcpLEUdF6IoGbFgJIRkWkgaVhzZCRkbBhXpj4gKLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zi3uxyFuFk1JS+9CA2TDVFJ8FSsPVn4G9xnAj31FoaUTCqyrTO9NWUYWyKo4jeYx5
	 dTEN3jFNGR1qstghZrZxhkPmKwsea283HCJe//Zz5GDFLQN25YDSpIvp/oIE+mT18R
	 Ony7bnRVFfIrWl1CI88b+WM9mQLd8z2TqV6P0QBq8lwDiKMZxIbABKZMTiIBFYibN5
	 uHa+zZpv0erx8bAHUfyXRLsMZ95H3HQDY95uy5K/3KfbHAP5PxGkYUtwDKJikdwbmS
	 W3QiKzpkhnzpHCavN9fFp+67kZVigjPVd3HXJ3iE/hl53jDlviMABhqHpNYJK3jmJo
	 MVwvvBOrikW6A==
Date: Wed, 22 Jul 2026 10:17:43 +0200
From: Antoine Tenart <atenart@kernel.org>
To: zhaoping.shu@mediatek.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, willemb@google.com, 
	alice@isovalent.com, sd@queasysnail.net, eilaimemedsnaimel@gmail.com, 
	imv4bel@gmail.com, hw.he@mediatek.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, haijun.liu@mediatek.com, xiayu.zhang@mediatek.com, 
	lambert.wang@mediatek.com
Subject: Re: [PATCH net v1] net: gro: avoid nesting GSO skbs in
 skb_gro_receive_list()
Message-ID: <amB7wb1A2Oo2dv5d@kwain>
References: <20260722024214.24845-1-zhaoping.shu@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722024214.24845-1-zhaoping.shu@mediatek.com>

On Wed, Jul 22, 2026 at 10:42:14AM +0800, zhaoping.shu@mediatek.com wrote:
> From: HW He <hw.he@mediatek.com>
> 
> On devices that support both NETIF_F_GRO_HW and NETIF_F_GRO_FRAGLIST,
> the hardware or driver may deliver packets that have already been
> aggregated into a GSO skb, either with frags[] or frag_list. GRO may
> then
> aggregate the skb again in skb_gro_receive_list().
> 
> This can create a nested GSO skb, which is not handled correctly by the
> later GSO segmentation paths. When the skb is segmented by
> skb_segment_list(), it not be fully restored to the original packets.
> 
> If the skb is marked with SKB_GSO_DODGY before segmentation, for example
> after a protocol change from IPv6 to IPv4, the nested GSO skb is
> segmented
> by skb_segment(), which may hit a NULL pointer dereference when the skb
> contains a nested frag_list.
> 
> Avoid this by setting NAPI_GRO_CB(skb)->flush for GSO skbs before
> aggregation and by checking the flush flag in skb_gro_receive_list(),
> following the existing logic in skb_gro_receive().
> 
> Signed-off-by: HW He <hw.he@mediatek.com>
> Signed-off-by: Zhaoping Shu <zhaoping.shu@mediatek.com>
> ---
>  net/core/gro.c         | 2 +-
>  net/ipv4/tcp_offload.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 35f2f708f010..27c9813495f3 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -229,7 +229,7 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  
>  int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>  {
> -	if (unlikely(p->len + skb->len >= 65536))
> +	if (unlikely(p->len + skb->len >= 65536 || NAPI_GRO_CB(skb)->flush))
>  		return -E2BIG;

This was already fixed in e751256486d0 ("net: gro: fix double
aggregation of flush-marked skbs").
>  
>  	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 3b1fdcd3cb29..c363434a5646 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -332,6 +332,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  		flush |= skb->ip_summed != p->ip_summed;
>  		flush |= skb->csum_level != p->csum_level;
>  		flush |= NAPI_GRO_CB(p)->count >= 64;
> +		NAPI_GRO_CB(skb)->flush |= skb_is_gso(skb);
>  		skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
>  
>  		if (flush || skb_gro_receive_list(p, skb))

I haven't looked closely but this looks like a second issue and would
need its own patch with a proper description.

Thanks,
Antoine
