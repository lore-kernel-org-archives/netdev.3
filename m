Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7BA4854E6;
	Mon,  5 Oct 2026 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218953; cv=none; b=ewjUkpgahCuCutboa0VHdRgdtke8iY9S4oT/281aKNWN22QJVRW4OwPK8FfDuIZfQNpKaV+sK0O7DuoUzafqoF/FrZGy+F0OrCuIvpi1yoVXZPSVDVgrq29UmYndRNjGqnJdwxZcHrALJ+thH7PUqnd/xoZKwJQSFyieuNC/Pjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218953; c=relaxed/simple;
	bh=FMTv1Q/R2kOjxxldf0gY0DJDEIapCnGxxz0ndmaFjRs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E044Jo2L6L9LL7UNDvKT4o9ch3oZQJxezRQLoe6NerKQxiRgrnpc8EVtghURvyGeevpHEHqiw+JfxG/1IRBnPa1X0isDhbbkPCfqhlVKetiQlYTAeK2LC8TCiyCSQ0veTZ7AjJ5wYjQyg3Yn9688E4+jx9zgBd5ab4SRJ4HkQ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=MtCbVXI0; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=jOqgRpZU; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="MtCbVXI0";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="jOqgRpZU"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 695GmOoJ022878;
	Mon, 5 Oct 2026 18:48:30 +0200
Received: from lubuntu-18.04 (host-95-234-228-71.retail.telecomitalia.it [95.234.228.71])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 933C7122943;
	Mon,  5 Oct 2026 18:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1791218899; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu8MEkBjwYzL8WVaiUtt0SmHl6NH+oh+Ct7CLhX3FAE=;
	b=MtCbVXI0flVEFXM0n0rZ37l+jj9vaX37uhYeY6Vc2ghnpp2TD55HSYZByjzibko6kGK4I0
	00kjt323I+/GUVAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1791218899; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu8MEkBjwYzL8WVaiUtt0SmHl6NH+oh+Ct7CLhX3FAE=;
	b=jOqgRpZUXpIK+mZBNz5JTft3VSNsLdRtRQPsGnO46XpvwwM8f6VfW4U/Bz8ZyJ/6DSKje5
	DodxShDZGA8PujwD2XknrE6qHVMgC4k42dHSko8qLSQF85yQJOKFh+iC4V7IjkCJ06L/5T
	YdR10Rx+3FCZgZzDekgRNNEAFQGUyRO/PY5sObWVm9z5edu/HOe+uzyYyULgYvbtH49sjh
	Gt3UUmjphWxrBIV/8888zB3sArWNgb1T9g4x7WEZboASQEtHsSHORy3wkar6SfbrJIyHM8
	A67FH/EKPVsdot59hH8nubskg+qtjHMCyi9X0sWaOp10QPEV4MygAHm/Y2ym6w==
Date: Mon, 5 Oct 2026 18:48:19 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: benquike@gmail.com, davem@davemloft.net, dsahern@kernel.org,
        edumazet@kernel.org, horms@kernel.org, idosch@nvidia.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, sashiko-bot@kernel.org, stefano.salsano@uniroma2.it,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] ipv6: rpl: unclone the skb before modifying the
 packet
Message-Id: <20261005184819.80d7b6bfcce102437c9d21df@uniroma2.it>
In-Reply-To: <20261003193103.1178658-1-kuniyu@google.com>
References: <20261001182136.33-1-andrea.mayer@uniroma2.it>
	<20261003193103.1178658-1-kuniyu@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Sat,  3 Oct 2026 19:30:58 +0000
Kuniyuki Iwashima <kuniyu@google.com> wrote:

Hi Kuniyuki,

Thanks for the review and for the diff.

> [snip]
> 
> > +	if (skb_cloned(skb)) {
> > +		if (pskb_expand_head(skb, 0, 0, GFP_ATOMIC)) {
> 
> ipv6_rpl_srh_rcv() already has pskb_expand_head() call later
> and I think this can be merged there.
> 
> [snip]
> 
> >  	hdr->segments_left--;
> >  	i = n - hdr->segments_left;
> 
> This and the later swap(ipv6_hdr(skb)->daddr, ohdr->rpl_segaddr[i])
> only modify the header before the existing pskb_expand_head().

Agreed, the unclone can be merged with the existing pskb_expand_head()
once the writes are moved after it.

> Also this seems wrong because skb_postpull_rcsum() is applied to
> the modified header, which should corrupt checksum.

Yes, this is a separate bug. v1 was meant to cover only the clone for
now. I will fix it as well.

> I think we can merge the clone check and pskb_expand_head() with
> skb_cow() and tmp IPv6 buffer like this.
> 
> compiled only:
> 
> ---8<---
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 09a4552f7f08..af285edd4d16 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -485,6 +485,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  	struct net *net = dev_net(skb->dev);
>  	struct ipv6hdr *oldhdr;
>  	unsigned int chdr_len;
> +	struct in6_addr addr;
>  	unsigned char *buf;
>  	int accept_rpl_seg;
>  	int i, err;
> @@ -548,9 +549,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  		return -1;
>  	}
>  
> -	hdr->segments_left--;
> -	i = n - hdr->segments_left;
> -
>  	buf = kcalloc(struct_size(hdr, segments.addr, n + 2), 2, GFP_ATOMIC);
>  	if (unlikely(!buf)) {
>  		kfree_skb(skb);
> @@ -559,6 +557,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  
>  	ohdr = (struct ipv6_rpl_sr_hdr *)buf;
>  	ipv6_rpl_srh_decompress(ohdr, hdr, &ipv6_hdr(skb)->daddr, n);
> +	ohdr->segments_left--;
> +	i = n - ohdr->segments_left;
>  	chdr = (struct ipv6_rpl_sr_hdr *)(buf + ((ohdr->hdrlen + 1) << 3));
>  
>  	if (ipv6_addr_is_multicast(&ohdr->rpl_segaddr[i])) {
> @@ -575,28 +575,24 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  		return -1;
>  	}
>  
> -	swap(ipv6_hdr(skb)->daddr, ohdr->rpl_segaddr[i]);
> +	addr = ohdr->rpl_segaddr[i];
> +	ohdr->rpl_segaddr[i] = ipv6_hdr(skb)->daddr;
>  
> -	ipv6_rpl_srh_compress(chdr, ohdr, &ipv6_hdr(skb)->daddr, n);
> -
> -	oldhdr = ipv6_hdr(skb);
> +	ipv6_rpl_srh_compress(chdr, ohdr, &addr, n);
>  
>  	skb_pull(skb, ((hdr->hdrlen + 1) << 3));
> -	skb_postpull_rcsum(skb, oldhdr,
> +	skb_postpull_rcsum(skb, ipv6_hdr(skb),
>  			   sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
>  	chdr_len = sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3);
> -	if (unlikely(!hdr->segments_left ||
> -		     skb_headroom(skb) < chdr_len + skb->mac_len)) {
> -		if (pskb_expand_head(skb, chdr_len + skb->mac_len, 0,
> -				     GFP_ATOMIC)) {
> -			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
> -			kfree_skb(skb);
> -			kfree(buf);
> -			return -1;
> -		}
> -
> -		oldhdr = ipv6_hdr(skb);
> +	if (unlikely(skb_cow(skb, chdr_len + skb->mac_len))) {
> +		__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
> +		kfree(buf);
> +		return -1;
>  	}
> +
> +	oldhdr = ipv6_hdr(skb);
> +
>  	skb_push(skb, chdr_len);
>  	skb_reset_network_header(skb);
>  	skb_mac_header_rebuild(skb);
> @@ -605,6 +601,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  	memmove(ipv6_hdr(skb), oldhdr, sizeof(struct ipv6hdr));
>  	memcpy(skb_transport_header(skb), chdr, (chdr->hdrlen + 1) << 3);
>  
> +	ipv6_hdr(skb)->daddr = addr;
>  	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
>  	skb_postpush_rcsum(skb, ipv6_hdr(skb),
>  			   sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3));
> ---8<---

I will take your diff into account for v2.

Thanks,
Andrea

pw-bot: changes-requested
