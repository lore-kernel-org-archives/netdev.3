Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A223E0C66
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651123; cv=none; b=O0uFCPXfL3CyhcuOzy6skIMcZ25PGwlPPGclUtLb/Qg8IOohf/Nw3vFJlL2PNIby7gDcx7U+YhrondIP163DjKyetB1cRsuC7F8MfIkGVEVM5/VysuXfCRYmoqwuCzBffq2Ggbx8sZanwPRIbq09onPWFixpumt/FgH/+vbJclM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651123; c=relaxed/simple;
	bh=2mV2hgecMuOB9d9EKn+9htCFjAreW0YsD1K4eAScb9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWQzzf7QdB7muAYArsnj371pcDTe28jpP/U19WqRWmObSqH83q26JEM7I7S9erQGiOpSpkZa+a3NcBrKixdHsfuc9bVzgCQJyJ7dPzqzlQXBulBDmxp6AIteOkXsO3kL4M16XIh5/+qn41us3sRp8ExetJw/4L4o1ggQCBHvqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dve9HpeF; arc=none smtp.client-ip=91.218.175.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dve9HpeF"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2mV2hgecMuOB9d9EKn+9htCFjAreW0YsD1K4eAScb9c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790651114; v=1; x=1791255914;
 b=Dve9HpeFBfDc2JiGF5yebT3+RjKbKB8PDXu7XrsGbWEA9KncdUfzrwk/x85hXCNu28atmHww
 XtiQllzxrvfUGSyBCnkwRWs1lDVxsBYDyuIeEizZ1lKbLi5j4pD8K0aMBWECanLJ+qTHlOeNk0r
 S6MP0B/B84lbjXpsD/FGhND4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ee85fcfe31a1df00;
	Tue, 29 Sep 2026 03:05:11 +0000
X-Mizu-Trace-ID: ee85fcfe31a1df00
X-Migadu-Flow: FLOW_OUT
Date: Tue, 29 Sep 2026 11:05:02 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lebrun <david.lebrun@uclouvain.be>,
	Stefano Salsano <stefano.salsano@uniroma2.it>
Subject: Re: [PATCH net] seg6: ensure packet data is writable before
 modifying SRH and IPv6 DA
Message-ID: <arsqomcYCLJqtWSC@fedora>
References: <20260925133807.32-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925133807.32-1-andrea.mayer@uniroma2.it>

Hi Andrea,
On Fri, Sep 25, 2026 at 03:38:07PM +0200, Andrea Mayer wrote:
> advance_nextseg() modifies the SRH Segments Left field and the IPv6
> destination address without ensuring the packet data is writable.
> seg6_next_csid_advance_arg() has the same problem when it advances the
> NEXT-C-SID argument in the destination address.
> 
> The skb may be cloned, for example by an AF_PACKET socket receiving on
> the ingress device. advance_nextseg() and seg6_next_csid_advance_arg()
> then write into the packet data shared with the clone. A read from that
> socket can return the modified packet instead of the received one. The
> simplified path below shows this for advance_nextseg():
> 
> __netif_receive_skb_one_core
>   __netif_receive_skb_core
>     deliver_skb               [orig: users=2, cloned=0]
>       packet_rcv
>         skb_clone             clone queued to the AF_PACKET socket
>         consume_skb(orig)     [orig: users=1, cloned=1]
>   ipv6_rcv
>     ip6_rcv_core              skb_share_check: no-op [orig: users=1]
>     [...]
>       input_action_end_core
>         advance_nextseg       writes into the data shared with the clone
> 
> Call skb_ensure_writable() in advance_nextseg() and in
> seg6_next_csid_advance_arg() before they modify the packet data.
> skb_ensure_writable() may reallocate skb->head, which invalidates the
> pointers into the packet data taken before the call.
> advance_nextseg() now returns a valid SRH pointer, or NULL if
> skb_ensure_writable() fails.
> seg6_next_csid_advance_arg() takes the pointer to the destination
> address from the skb after skb_ensure_writable().
> On failure, the callers drop the packet with SKB_DROP_REASON_NOMEM.
> 
> Fixes: 140f04c33bbc ("ipv6: sr: implement several seg6local actions")
> Fixes: 848f3c0d4769 ("seg6: add NEXT-C-SID support for SRv6 End behavior")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/seg6_local.c | 140 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 117 insertions(+), 23 deletions(-)

[...]

>  
>  static int input_action_end_finish(struct sk_buff *skb,
> @@ -408,31 +454,42 @@ static int input_action_end_finish(struct sk_buff *skb,
>  static int input_action_end_core(struct sk_buff *skb,
>  				 struct seg6_local_lwt *slwt)
>  {
> +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	struct ipv6_sr_hdr *srh;
> +	int err = -EINVAL;
>  
>  	srh = get_and_validate_srh(skb);
>  	if (!srh)
>  		goto drop;
>  
> -	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
> +	srh = advance_nextseg(skb, srh, &reason);
> +	if (!srh) {
> +		err = -ENOMEM;
> +		goto drop;
> +	}

The srh is not used in the later function, maybe just

	if (!advance_nextseg(skb, srh, &reason)) {
		err = -ENOMEM;
		goto drop;
	}

>  
>  	return input_action_end_finish(skb, slwt);
>  
>  drop:
> -	kfree_skb(skb);
> -	return -EINVAL;
> +	kfree_skb_reason(skb, reason);
> +	return err;
>  }
>  
>  static int end_next_csid_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
>  {
>  	const struct seg6_flavors_info *finfo = &slwt->flv_info;
>  	struct in6_addr *daddr = &ipv6_hdr(skb)->daddr;
> +	enum skb_drop_reason reason;
>  
>  	if (seg6_next_csid_is_arg_zero(daddr, finfo))
>  		return input_action_end_core(skb, slwt);
>  
>  	/* update DA */
> -	seg6_next_csid_advance_arg(daddr, finfo);
> +	reason = seg6_next_csid_advance_arg(skb, finfo);
> +	if (reason) {
> +		kfree_skb_reason(skb, reason);
> +		return -ENOMEM;
> +	}
>  
>  	return input_action_end_finish(skb, slwt);
>  }
> @@ -448,19 +505,25 @@ static int input_action_end_x_finish(struct sk_buff *skb,
>  static int input_action_end_x_core(struct sk_buff *skb,
>  				   struct seg6_local_lwt *slwt)
>  {
> +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	struct ipv6_sr_hdr *srh;
> +	int err = -EINVAL;
>  
>  	srh = get_and_validate_srh(skb);
>  	if (!srh)
>  		goto drop;
>  
> -	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
> +	srh = advance_nextseg(skb, srh, &reason);
> +	if (!srh) {
> +		err = -ENOMEM;
> +		goto drop;
> +	}

Same here and all later similar functions.

>  
>  	return input_action_end_x_finish(skb, slwt);
>  
>  drop:
> -	kfree_skb(skb);
> -	return -EINVAL;
> +	kfree_skb_reason(skb, reason);
> +	return err;
>  }
>  

[...]

>  
> @@ -1434,6 +1523,7 @@ static int input_action_end_bpf(struct sk_buff *skb,
>  				struct seg6_local_lwt *slwt)
>  {
>  	struct seg6_bpf_srh_state *srh_state;
> +	enum skb_drop_reason reason;
>  	struct ipv6_sr_hdr *srh;
>  	int ret;
>  
> @@ -1442,7 +1532,11 @@ static int input_action_end_bpf(struct sk_buff *skb,
>  		kfree_skb(skb);
>  		return -EINVAL;
>  	}
> -	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
> +	srh = advance_nextseg(skb, srh, &reason);
> +	if (!srh) {
> +		kfree_skb_reason(skb, reason);
> +		return -ENOMEM;
> +	}

The srh here is still needed by later srh_state->srh = srh; so we can keep it.

Thanks
Hangbin
