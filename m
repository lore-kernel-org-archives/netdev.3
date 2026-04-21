Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D062383C97;
	Tue, 21 Apr 2026 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777121; cv=none; b=g+46tOoygg5qOIAFeFTKVsuTNMhoaylZGmkK0+b4zm3fNvSCEHmFyTaF1AHu0U+wyLOmDtr6S9eglMIwmo7H/kLsBh2Uab9TtYcj7NCrxLs8tfxSY5JclWFFyHIupq2ZLXtcmW1Av4O3tqofRmu1kHPBZFtPctnV9do+HMmfoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777121; c=relaxed/simple;
	bh=fzJrMdhUtGZxURl37TdbFbELOczQ4Y6UZPEb8yZJLwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQHWI2qkYchK17kCcUDJZgO46gi7Ri60fKdgo4j3zsgujkFu5Xhb+vkRQupsABiTBlaDBAn5lZshCs0t1Ju9IIe7VT2HJAIrvaPQm5ER7CPK0H7gGM65CAkM1nugv0gZ6Vbq9kdrJjwP7D/Co++g4k4DAwFgN5QtCz1E7kZ7JLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sAi8N5GE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sAi8N5GE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4DAC2BCB0;
	Tue, 21 Apr 2026 13:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776777120;
	bh=fzJrMdhUtGZxURl37TdbFbELOczQ4Y6UZPEb8yZJLwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sAi8N5GEcL9kqMgEOAR/e7rMfpK23QxdJHs6CjGFQ6u06a7HXXibyC001vlwt/DQ8
	 Y5H/ACQQlfd1RvJmfy/vfZhJrA5NrauZ/bDpNotqd49t3J1TfZBskADEHduFOCI1Dd
	 bQnt9DrowuM1B7pyQEFVgg3zAa7PI6DVlNkpjxrU=
Date: Tue, 21 Apr 2026 15:11:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH net v2] ipv6: rpl: reserve mac_len headroom when
 recompressed SRH grows
Message-ID: <2026042142-vanquish-unhealthy-7a85@gregkh>
References: <2026042158-sediment-elliptic-a954@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042158-sediment-elliptic-a954@gregkh>

On Tue, Apr 21, 2026 at 02:32:59PM +0200, Greg Kroah-Hartman wrote:
> ipv6_rpl_srh_rcv() decompresses an RFC 6554 Source Routing Header, swaps
> the next segment into ipv6_hdr->daddr, recompresses, then pulls the old
> header and pushes the new one plus the IPv6 header back.  The
> recompressed header can be larger than the received one when the swap
> reduces the common-prefix length the segments share with daddr (CmprI=0,
> CmprE>0, seg[0][0] != daddr[0] gives the maximum +8 bytes).
> 
> pskb_expand_head() was gated on segments_left == 0, so on earlier
> segments the push consumed unchecked headroom.  Once skb_push() leaves
> fewer than skb->mac_len bytes in front of data,
> skb_mac_header_rebuild()'s call to:
> 
> 	skb_set_mac_header(skb, -skb->mac_len);
> 
> will store (data - head) - mac_len into the u16 mac_header field, which
> wraps to ~65530, and the following memmove() writes mac_len bytes ~64KiB
> past skb->head.
> 
> A single AF_INET6/SOCK_RAW/IPV6_HDRINCL packet over lo with a two
> segment type-3 SRH (CmprI=0, CmprE=15) reaches headroom 8 after one
> pass; KASAN reports a 14-byte OOB write in ipv6_rthdr_rcv.
> 
> Fix this by expanding the head whenever the remaining room is less than
> the push size plus mac_len, and request that much extra so the rebuilt
> MAC header fits afterwards.
> 
> Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: stable <stable@kernel.org>
> Reported-by: Anthropic
> Assisted-by: gkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: - fixed up if statement to actually work properly, and test it against
>       a working poc (poc will be sent separately)
>       Reworded the changelog and the subject to make more sense
>       Link to v1: https://lore.kernel.org/r/2026042024-cabbie-gills-9371@gregkh
> 
>  net/ipv6/exthdrs.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 95558fd6f447..b86a638d51e4 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -491,6 +491,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>  	struct net *net = dev_net(skb->dev);
>  	struct inet6_dev *idev;
>  	struct ipv6hdr *oldhdr;
> +	unsigned int chdr_len;
>  	unsigned char *buf;
>  	int accept_rpl_seg;
>  	int i, err;
> @@ -590,11 +591,11 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>  	oldhdr = ipv6_hdr(skb);
>  
>  	skb_pull(skb, ((hdr->hdrlen + 1) << 3));
> -	skb_postpull_rcsum(skb, oldhdr,
> -			   sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
> -	if (unlikely(!hdr->segments_left)) {
> -		if (pskb_expand_head(skb, sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3), 0,
> -				     GFP_ATOMIC)) {
> +	chdr_len = sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3);
> +	skb_postpull_rcsum(skb, oldhdr, chdr_len);

Crap, nope, this is wrong, let me go fix this...

