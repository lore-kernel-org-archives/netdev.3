Received: from mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F823189F43
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648796; cv=none; b=m18sjnDu9qGiiShmgxd5XiSlzn8TpoY7TCotck4ZJu5yqsRY7sACXVXnjgt3PrHFgiJlmwBXEI7J9yuNhj+oGhiPpajeGPntdoWp6/sZC1QTQ2x8ErGJDYiMSWyrADiWtkf2MtQC8HbNPjjlpYBXsUfyqDA1vCK7CncMOmfQinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648796; c=relaxed/simple;
	bh=7hcvDt/KF3PWmAvcB/zfAjgw/un2tvPo1JKcEB9J/h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8wK0okBGcsc/eQVpa1AoRGklCaC0Z/12i+qyYbT7FpVTfTsRqBmk+Ro3KBTXGywA1B3yvgDvGz27ObQM+Yi7lX+PFqO5IEuMEDdn4LTST7uFAqkQzEpNGL1CQItiQNrcbS1HvCUmTrp47zCCna5LV/1Ci7Jho/DYV9kugzYDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=csy5TJh1; arc=none smtp.client-ip=91.218.175.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="csy5TJh1"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7hcvDt/KF3PWmAvcB/zfAjgw/un2tvPo1JKcEB9J/h0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790648792; v=1; x=1791253592;
 b=csy5TJh1dHLhIE0my7TM9KdZHtn6hPfUSOYBRiLd9gjcpKy4tlC4SiN0RYde2CrdJXo3vKap
 0JAK+uWJ9aWxVkWmj/SpJVSwBw06Gt66IHkpldC02srOoKULlITyTXf3TqcFeHOJOOyn1KIHl14
 G30EHPhFSHrqdXRD/+MI2Jcc=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 3b4518477d6de36e;
	Tue, 29 Sep 2026 02:26:22 +0000
X-Mizu-Trace-ID: 3b4518477d6de36e
X-Migadu-Flow: FLOW_OUT
Date: Tue, 29 Sep 2026 10:26:15 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] seg6: reallocate the skb head on L2
 encapsulation only when needed
Message-ID: <arshx6IzKqhloiHJ@fedora>
References: <20260925-seg6-l2cow-v3-1-fc83821542a7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-seg6-l2cow-v3-1-fc83821542a7@gmail.com>

On Fri, Sep 25, 2026 at 11:49:53PM +0900, Yuya Kusakabe wrote:
> The L2 encapsulation modes of the seg6 lwtunnel reallocate the skb head
> on every packet, where the IPv6 encapsulation modes reallocate only when
> they have to.  Ask for the whole encapsulation up front instead, so that
> the reallocation happens at most once and only when the headroom really
> is too small:
> 
>   skb->mac_len + sizeof(struct ipv6hdr) + ipv6_optlen(tinfo->srh)
>   + dst_dev_overhead(cache_dst, skb)
> 
> __seg6_do_srh_encap() then finds the room it needs and its own
> skb_cow_head() becomes a no-op.
> 
> Drivers reserve more than that on the forwarding path, so the
> reallocation usually disappears altogether.  A single-segment policy
> on ixgbe needs
> 
>   14 (mac_len) + 40 (ipv6hdr) + 24 (SRH) + 16 (LL_RESERVED_SPACE) = 94
> 
> against the 206 bytes the driver leaves.  Where the headroom is
> smaller, as on a veth pair, pskb_expand_head() is called once per
> forwarded packet instead of twice.  Asking only for skb->mac_len would
> still take two whenever the skb is header-cloned, because the cow that
> unclones it does not also make room for the outer header.
> 
> The cost is amplified by CONFIG_INIT_ON_ALLOC_DEFAULT_ON, which many
> distributions enable: every new head is zeroed in full, and that memset
> alone accounts for 16% of the datapath profile.
> 
> Throughput at 0.5% packet loss, 64-byte frames forwarded through one
> 2.30 GHz core (Xeon E5-2650 v3, ixgbe 82599ES), offered by TRex and
> binary-searched over 10 runs of 10 s:
> 
>   Before: 654.6 kpps
>   After:  965.7 kpps
> 
> Assisted-by: LLM
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
> Changes in v3:
> - No code change.  Rebased onto net-next, which now has 87cd6b717e40
>   ("net: ipv6: keep room for the mac header in dst_dev_overhead()").
>   That fixes the headroom shortfall Sashiko reported on v2, which
>   predates this patch and affects every seg6, ioam6 and rpl
>   encapsulation.
> - Link to v2: https://patch.msgid.link/20260903-seg6-l2cow-v2-1-f37b3b35416f@gmail.com
> 
> Changes in v2:
> - Ask for the whole encapsulation headroom at once, so that a cloned
>   skb no longer takes a second reallocation inside
>   __seg6_do_srh_encap() [Eric]
> - Re-measure against unpatched net-next rather than an older base
> - Link to v1: https://lore.kernel.org/r/20260902-seg6-l2cow-v1-1-e823ce216454@gmail.com
> ---
>  net/ipv6/seg6_iptunnel.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 61c6a27bf202..ecd8146089ee 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -400,6 +400,7 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
>  	struct dst_entry *dst = skb_dst(skb);
>  	struct seg6_iptunnel_encap *tinfo;
>  	struct seg6_lwt *slwt;
> +	unsigned int headroom;
>  	int proto, err = 0;
>  
>  	slwt = seg6_lwt_lwtunnel(dst->lwtstate);
> @@ -446,8 +447,13 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
>  		if (!skb_mac_header_was_set(skb))
>  			return -EINVAL;
>  
> -		if (pskb_expand_head(skb, skb->mac_len, 0, GFP_ATOMIC) < 0)
> -			return -ENOMEM;
> +		headroom = skb->mac_len + sizeof(struct ipv6hdr) +
> +			   ipv6_optlen(tinfo->srh) +
> +			   dst_dev_overhead(cache_dst, skb);
> +
> +		err = skb_cow_head(skb, headroom);
> +		if (unlikely(err))
> +			return err;
>  
>  		skb_mac_header_rebuild(skb);
>  		skb_push(skb, skb->mac_len);
> 
> ---
> base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
> change-id: 20260902-seg6-l2cow-77dc3ba41232
> 
> Best regards,
> --  
> Yuya Kusakabe <yuya.kusakabe@gmail.com>
> 

LGTM

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
