Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188329;
	b=aMp17AwEZsUhfpHtbZVjOHhswdlwx3Ovfilr9aZ1A+2HBcSr4LagZXIFpLoH+AYW0gXX
	 rlu9azkBtYRohVyjUrW+IpgfvHIKUfK1Yw4wtfEER1STU5tuSPhSAsYtk6TEDIYbk1j7K
	 YOpj5FC0Xg76YY5d3Ai4QmSwINf1rwPBiDKApWqCmAc68G0q297bYxOHdUi9nnylCl9fZ
	 4z+U/ZVG5I1YJmEc+PtkaPtfx/9cySdoZAg45Kave18QwPYebCvSLR0aeWyF0oPS8NBjv
	 ZoWOWLXcZjPlDoY0bV3/5jmIFZVhey4LgJAKm4iLkoCbhChh3I8N/rMc28NbY9bXnpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188329;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jgJQfbD85DE2uxnUN7b8QIZUT8lwjyaqkF8TDj03zC4=;
	b=sWAC3cVU4DEDMmdAsN79IbsXfdpC/LMdXAIAlGkhjrC+l8yaguM/BMx8c7YtZKdK6YtR
	 A0f78NZaS33E3/T4QWeDVEjULKGKygMCAqoM757A7VjQnneJI9xghg7O48dYJaaPXpSpU
	 0cWYIdnDqaiKX3WqHkv+dweJdmHcsJKRD6fIyAoLvCpptg1CjsSXDKVHxtR2PH91hnafd
	 7RmPagW/ogUcBmyV+nKporvhrFr4UxHdMYiL4cmi0mOsJb1u1UOX3Q8HpLWUGl9Lpp//a
	 NmZjOhq2Zw987wbZr3cGjZXwviYRIqjjIUX9eE5LqMADarTACOvP6Mc9bmV52IVavTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjTPy2yz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D625A606A320;
	Mon,  9 Nov 2026 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjTPy2yz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748BC1F0089F;
	Mon,  9 Nov 2026 01:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794188328;
	bh=jgJQfbD85DE2uxnUN7b8QIZUT8lwjyaqkF8TDj03zC4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DjTPy2yztsF3Tw1bDXzsfQy3yCKNQuLLExDeMe3KMc+9tR31wqrUtF2Kc1Z3PHYIj
	 c0B4nD/15J65wnauqLKeCeBZBNwRg8/gd0fmEaP9wx1i7ex7f+zt9wEBG9r1HmBKDT
	 EGJn2CcgV35vWxd0u722U4Lom/OFTUcdn1NR75AU+hCU1Tjxq1aEWl9TnCTChkQ7jJ
	 79qGiMQ6SAiRByFEVlCYYtSXjnJc1sgMODXXnLtQSSC/g5fTtBp6UUwSKwn6HJjMuu
	 MaVOeO3qddBGVCvv+OmgGIFbabu8QdS1wznPGSS4OFDSFG+dL1xuu+2+9my5F6Vc4N
	 nqnW6JHGlgEwA==
Subject: Re: [PATCH net-next v4 2/2] net: prevent mixing frags from different
 memory providers or bindings
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 kaiyuanz@google.com, linux-kernel@vger.kernel.org, ncardwell@google.com,
 kuniyu@google.com, bobbyeshleman@meta.com, asml.silence@gmail.com,
 sdf@fomichev.me, daniel@iogearbox.net
Date: Mon, 09 Nov 2026 01:38:46 +0000
Message-ID: <179418832697.994134.11198338213560511850@kernel.org>
In-Reply-To: <20261108013838.1454450-3-almasrymina@google.com>
References: <20261108013838.1454450-3-almasrymina@google.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the whole change is "theoretical", but
  one of the bundled fixes closes a bug that any devmem TX socket can…
- [Medium] skb_has_net_iovs() returns `skb->unreadable &&
  skb_shinfo(skb)->nr_frags`.

--

net: prevent mixing frags from different memory providers or bindings

The patch adds skb_has_net_iovs(), skb_net_iov_provider(),
skb_mem_provider_compat(), skb_frags_can_coalesce() and
net_devmem_skb_binding(). These are used in the coalesce, shift, GRO,
TCP collapse and devmem TX paths so that frags from different memory
providers or devmem bindings are never mixed in one skb. It also
propagates skb->unreadable and compares netmems when merging frags in
tcp_clone_payload().

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6787fcf6ac3e4..e6f63450a193a 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1882,6 +1882,17 @@ static inline bool skb_frags_readable(const struct sk_buff *skb)
>  	return !skb->unreadable;
>  }
>  
> +/* Return true if frags in this skb are backed by net_iovs.
> + * Assumes skb->unreadable and net_iov-backed frags are equivalent for now;
> + * the two can be decoupled in the future if readable net_iovs in skbs are
> + * introduced. Also check nr_frags because not all frag-removal paths clear
> + * skb->unreadable when nr_frags drops to 0.
> + */
> +static inline bool skb_has_net_iovs(const struct sk_buff *skb)
> +{
> +	return skb->unreadable && skb_shinfo(skb)->nr_frags;
> +}

[Severity: Medium]

Does the nr_frags gate make the checks this patch replaces weaker, for
exactly the state the comment above describes?

An skb with unreadable=1 and nr_frags==0 is now classified like a
page-backed skb. So skb_mem_provider_compat() and skb_frags_can_coalesce()
report it as compatible with a readable skb. The checks being replaced
rejected that case:

skb_try_coalesce():
	if (skb_frags_readable(from) != skb_frags_readable(to))
		return false;

tcp_skb_can_collapse():
	skb_frags_readable(to) == skb_frags_readable(from)

tcp_sendmsg_locked():
	unlikely(skb_frags_readable(skb) != !binding)

Take skb_try_coalesce() with to stale-unreadable with 0 frags, and from
readable with only page frags and headlen 0. It skips the copy path and
passes skb_frags_can_coalesce(). It also misses the new readability check,
because that check only runs when skb_headlen(from) != 0. The page frags
are then copied into to, and to->unreadable stays set.

skb_shift() behaves the same way and only clears the source skb's
unreadable bit. In tcp_sendmsg_locked(), net_devmem_skb_binding(skb)
returns NULL for such a tail. With binding == NULL, page data is appended
to the tail instead of starting a new segment.

The resulting skb is flagged unreadable but holds struct page frags.
net_devmem_skb_binding() returns NULL for it, so would
validate_xmit_unreadable_skb() drop it on every transmit and retransmit?

	if (!binding || binding->direction != DMA_TO_DEVICE ||
	    READ_ONCE(binding->dev) != dev)
		goto out_free;

On RX, the dmabuf recvmsg path would reject the non-niov frags.

The stale state can be produced. __pskb_trim_head() in tcp_output.c
removes frags without clearing unreadable, and it is reached through
__tcp_retransmit_skb()->tcp_trim_head() for a FIN skb whose data has been
acked.

I could not find a live path where such an skb later becomes the target
of a coalesce, shift or sendmsg append, because that FIN skb is the last
one in its queue. So this may only weaken the old checks rather than
cause a reachable failure.

Would it make sense to keep rejecting a readable/unreadable mismatch in
these paths as well?

[ ... ]

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index cf3ddc055d48d..b8a5c3556243b 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2692,8 +2692,9 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
>  				     probe_size - len);
>  			len += todo;
>  			skb_shinfo(to)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> +			to->unreadable |= skb->unreadable;
>  			if (lastfrag &&
> -			    skb_frag_page(fragfrom) == skb_frag_page(lastfrag) &&
> +			    skb_frag_netmem(fragfrom) == skb_frag_netmem(lastfrag) &&
>  			    skb_frag_off(fragfrom) == skb_frag_off(lastfrag) +
>  						      skb_frag_size(lastfrag)) {
>  				skb_frag_size_add(lastfrag, todo);

[Severity: Medium]

The commit message says:

  This issue is theoretical and was found by manual code inspection and
  LLM review; it was not triggered in production.

Is that accurate for this tcp_clone_payload() change? It looks like it
fixes a reachable data corruption bug that any devmem TX socket can hit
when MTU probing is enabled.

Before this patch, the path was:

tcp_write_xmit()
  tcp_mtu_probe()
    tcp_can_coalesce_send_queue_head()
      tcp_skb_can_collapse()   <- only required equal readability
    tcp_clone_payload()

The probe nskb comes from tcp_stream_alloc_skb() with unreadable=0.
Nothing set the flag when net_iov frags were copied into it. So
validate_xmit_unreadable_skb() returned early without checking the
binding's direction or device. Readers gated only by skb_frags_readable(),
such as skb_copy_bits() for packet taps, could treat the net_iovs as
struct pages.

There is a second problem in the old merge test. skb_frag_page() returns
NULL for every net_iov frag, so the test was NULL == NULL. The frag
offset comes from the user iovec address in net_devmem_get_niov_at():

	*off = virt_addr % PAGE_SIZE;

Consider an iovec at dmabuf offset 0 with length 100 (niov 0, off 0),
followed by one at offset 2*PAGE_SIZE+100 (niov 2, off 100). The two
frags have contiguous offsets but sit on different niovs. They would be
merged into one 200 byte frag on niov 0. Bytes 100..199 of the probe
would then be sent from the wrong dmabuf page as valid TCP payload.

Since this puts wrong data on the wire, could the commit message describe
it accurately? Could this fix also be split into its own patch, so it is
easier to spot for stable backports?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108013838.1454450-1-almasrymina%40google.com
