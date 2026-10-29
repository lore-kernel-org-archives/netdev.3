Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283330;
	b=BP7zThh4CGgDBZoi13adEO/G/vNYRzagBrbOGOaVg1+3aGaJHBG9L6TBkXdHs1+MBG90
	 3UsA1G3KPwUwS9Z6ACi2fJB+bq9ElJPtrwDK+Va/m8RrTwNhrC7WNTQUdv0Xhrv+8YK/G
	 qDWpW05YBQ4muGxNgrxCwHcSm5pYvAv8SocFvWgnkZ2xOgz7be8fALb/q9YqOrWT9Vvlw
	 dha1foeqq5ZIFCUaONX5nbwE68orx07uzTFdRsb2hU0/bUGuqzAj7YNaYSAPOlj9cXFqJ
	 qRJTOpzEe0Mhfl8QL9mNXWfGDUAUNDeWbi6RYgswHUUWKEiV6dLflN0+VdJFE+19S0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283330;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dhmmahh06myYXbW5ESqbKUXDQqYYU0zo1kDmgyI/HsQ=;
	b=Tfk1+Y+XmX0J5Ks4dDvajLuECxd1YOVnBbucejOwe9Rn57cnZJ+9n6T3o3foYrH+MNQx
	 1xC3ASdKHHXt//XUZbOwbg95iA8PhlN1GK2byji57X1OGMqjuE6JsxCGD9tvFUXRsRm0K
	 8ejo5tZfwMItQ2mVD0T4dRVlKw4/ZsJh2/YNB0CHL5wf9GtvfojPT6v6mF6wqTsdvFyrs
	 BsHHyND3jrJE5PS7ctXIgcMFB3qYmDhU4VGPjGxMsxWhT3aDVkjHDeRC/mCUaUncU7aPt
	 mkh5Y67wtAsuQgTt+KsFB6WIr6lUYiyTc9vo1pot6Z32JipKOx37FxK33Rkheg21Glw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmuL9FVe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BE606A324
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmuL9FVe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68DC1F01828;
	Thu, 29 Oct 2026 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793283330;
	bh=dhmmahh06myYXbW5ESqbKUXDQqYYU0zo1kDmgyI/HsQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cmuL9FVel4ozzNYyyOWXqvkBhzS3MggsZj4Kg8ebX+7Ot8+XMp5hQMyWRf2c8zY8i
	 P8+3QcUlJbL9LCbuxcwladbUQ7aFcMR9gIuKaIECb7vHhvqnatpviSPvj38nfIl3P8
	 tNpqrbRx/XSFMq8QBW5GxAYNUuSn7tNbbNNRCv5C2OoRFCsrOMfBZNxlDNTXzuEDBJ
	 i9OBY9ShpXGyRfE59R02gi1nofIBljWuOdOLmQ7yg83A6D46pctGeEwLX2yRmz0zAW
	 BHUhuafyMB0VYHpevZkBJKWrPUpH9iLXyQ2jkG1GN5TteyZng+bc8KcRmfkYN9J9Ak
	 s0jFARrTBm9gw==
Subject: Re: [PATCH net 2/2] net: gro: invalidate frag0 after a pull
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, steffen.klassert@secunet.com,
 AutonomousCodeSecurity@microsoft.com, netdev@vger.kernel.org,
 tsgatesv@gmail.com, cenzhang@linux.microsoft.com
Date: Thu, 29 Oct 2026 14:15:29 +0000
Message-ID: <179328332931.3134.13112846034720235073@kernel.org>
In-Reply-To: <20261028141325.2103814-3-edumazet@kernel.org>
References: <20261028141325.2103814-3-edumazet@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] skb_gro_header_slow() (include/net/gro.h:172-180) calls
  skb_gro_frag0_invalidate() only after pskb_may_pull() succeeds.

--

net: gro: invalidate frag0 after a pull

The commit adds skb_gro_frag0_invalidate(), which clears
NAPI_GRO_CB(skb)->frag0_len. It is called after the pulls in
skb_gro_header_slow(), skb_gro_receive_list(), udp_gro_receive_segment(),
esp4_gro_receive() and esp6_gro_receive(). The goal is to stop later
skb_gro_header() and skb_gro_network_header() calls from using a frag0
that points into a released page fragment or a freed skb->head.

> diff --git a/include/net/gro.h b/include/net/gro.h
> index b560e866683b0..78373e9caf68b 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -160,12 +160,22 @@ static inline bool skb_gro_may_pull(const struct sk_buff *skb,
>  	return likely(hlen <= NAPI_GRO_CB(skb)->frag0_len);
>  }
>  
> +/* A pull can release the page fragment frag0 points to, or reallocate
> + * skb->head. Make sure later skb_gro_header() and skb_gro_network_header()
> + * calls no longer use frag0.
> + */
> +static inline void skb_gro_frag0_invalidate(struct sk_buff *skb)
> +{
> +	NAPI_GRO_CB(skb)->frag0_len = 0;
> +}
> +
>  static inline void *skb_gro_header_slow(struct sk_buff *skb, unsigned int hlen,
>  					unsigned int offset)
>  {
>  	if (!pskb_may_pull(skb, hlen))
>  		return NULL;
>  
> +	skb_gro_frag0_invalidate(skb);

[Severity: High]
Should frag0 also be invalidated when pskb_may_pull() fails?

pskb_may_pull() can fail after it has already reallocated skb->head. In
__pskb_pull_tail(), pskb_expand_head() runs first, and the frag_list
handling after it can still return NULL:

net/core/skbuff.c:__pskb_pull_tail() {
    ...
	if (eat > 0 || skb_cloned(skb)) {
		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
				     GFP_ATOMIC))
			return NULL;
	}
    ...
				if (skb_shared(list)) {
					/* Sucks! We need to fork list. :-( */
					clone = skb_clone(list, GFP_ATOMIC);
					if (!clone)
						return NULL;
    ...
				if (!pskb_pull(list, eat)) {
					kfree_skb(clone);
					return NULL;
				}
    ...
}

The kerneldoc for that function says the skb does not change on failure.
That doesn't hold once pskb_expand_head() has freed the old head.

If that happens, the early return NULL here skips
skb_gro_frag0_invalidate(). NAPI_GRO_CB(skb)->frag0 then still points
into the freed head, and frag0_len keeps the old headlen.

The outer handlers keep running after the inner pull fails. With VXLAN
RCO and VXLAN_F_REMCSUM_NOPARTIAL, for example:

vxlan_gro_receive()
  skb_gro_remcsum_process()      /* frag0 fast path, sets grc->delta */
  eth_gro_receive() / inet_gro_receive() / udp_gro_receive_segment()
    skb_gro_header_slow()
      pskb_may_pull()            /* fails after pskb_expand_head() */
  skb_gro_flush_final_remcsum()
    skb_gro_remcsum_cleanup()

include/net/gro.h:skb_gro_remcsum_cleanup() {
    ...
	size_t plen = grc->offset + sizeof(u16);
    ...
	ptr = skb_gro_header(skb, plen, grc->offset);
	if (!ptr)
		return;

	remcsum_unadjust((__sum16 *)ptr, grc->delta);
}

plen falls inside the range that the remcsum fast path already checked,
so it is no larger than the stale frag0_len. Would skb_gro_header() then
return the stale frag0, so that remcsum_unadjust() writes 2 bytes into
the freed head? gue_gro_receive() in net/ipv4/fou_core.c also calls
this cleanup helper after its inner handlers.

The new calls in skb_gro_receive_list() and udp_gro_receive_segment()
have the same order, invalidating only when pskb_may_pull() succeeds.
udp_gro_receive_segment() can run as the inner UDP handler under VXLAN.

The helper before bd56a29c7a4e also invalidated only on success. Still,
the commit message describes exactly this case: a stale frag0 after
pskb_expand_head(), followed by the 2-byte write in
skb_gro_remcsum_cleanup().

Could these sites invalidate frag0 before calling pskb_may_pull(), or on
both outcomes?

>  	return skb->data + offset;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028141325.2103814-1-edumazet%40kernel.org
