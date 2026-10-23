Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731120;
	b=bRuJd2Ig7w2Snzc+8f6mXagKerwU1Ejk60eknM81f6+htMVVoHxZiTPpHoAPlN/iajON
	 ptOFRkmPqfWKqMQQtgybwXEe6xNjQdAf+veQdTl0xKf+Pymq8bAEMjdLgZpod6btdTBMf
	 SatRQrlW15AIGMNrIpyqahKQo75fvJtsiVVQt9ryMB8fipRgSqru8Cbi3dJJ2EIP0bU8F
	 R1zvibWOGLGJCrOVYgp0UoGeDlChzF4kPIAYEZUmIN78HlR1fXwJFkUpevwv7gLiHpydl
	 FhzHXO+IjAoxcrt+OzuD9PWWyILd4Q4gvz/xA9xWIsz2eJ0xMr4sSj6+DJz98uLMRdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731120;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tCmxTkBjLaIflZ6vc/WgmRL/W84MvLgumRnoI+JCkrM=;
	b=1VhaywTptknHuEPO2Jr0Ejup/D5vgbMgKotYxXvYlhcD4nrzoGuS52cQAzHFddIbXJIw
	 ahMDf3mchbY7Aje12yuSh4X8Kb6h94M/1HcxjA6M80/4BnwzNdRdDSqJU1DahIAfflTAY
	 63hEdXHnLOeUUdFkjJXKiUgiB2R1n4hflPAUwjrMpymekE1hlnw/r5jg4T7YF+C5uge5H
	 Zguovt9UyCKbHq7KQpiQ+Me0Vz5KOTryszESJVytm29gE3mH9G9utaDzlKcuTL712gA0g
	 GdMaSL11f4wHZrvIlKU0YsjdRSk7NLoIJhHBbKL0AOPgLLJVNk9fM9Tifwk4n78HUOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MyIzM/Th";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4189606A31F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyIzM/Th
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956E51F01828;
	Fri, 23 Oct 2026 04:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792731119;
	bh=tCmxTkBjLaIflZ6vc/WgmRL/W84MvLgumRnoI+JCkrM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MyIzM/ThgfrEK0Tv/sB4VPSWUI8xCV5TBTMDrtUBNDSPFCoCaOC6dEJHOPtxJOVLf
	 hPNa0L2Ezix2vvWGnP0u3T2/3ECMTvYm+enl+QExJ5Ek2PipD0e9MNu4D47tv9DsM3
	 shL/DSZmrOvTfzG69ud2CCLksfL9j5uBXg7sgsO2ZAyvbOBcey5+YdVea9Czs85uBD
	 Hn71yae9pBxNA51ARczpsKByetm4SF4YMpOSkYPGqtcaF08uVz6lnpIOqme6ZuFetY
	 kJMyBGyym/gDqIuep5PFtNCvXxm0OqiE9FK2lEGxq/1OvTaf8Vkgq9cwUbOfPpBVNG
	 MBgowJLkBDbEw==
Subject: Re: [PATCH net-next 02/15] net: skbuff: add skb_checksum_full() that
 reports failure
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, jgross@suse.com,
 sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, fmancera@suse.de,
 almasrymina@google.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 23 Oct 2026 04:51:58 +0000
Message-ID: <179273111819.3134.1366212706664836361@kernel.org>
In-Reply-To:
 <20261019-b4-skbuff-bug-on-followups-v1-2-41dbef50b9f7@toxicpanda.com>
References:
 <20261019-b4-skbuff-bug-on-followups-v1-2-41dbef50b9f7@toxicpanda.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the skb_checksum() wrapper
  (net/core/skbuff.c, lines 3657-3664) "behaves as before for the…
- [Low] The new kernel-doc for skb_checksum_full() (net/core/skbuff.c,
  lines 3555-3557) says it returns -EFAULT if "@skb has unreadable frags…

--

net: skbuff: add skb_checksum_full() that reports failure

This adds skb_checksum_full(). It returns -EFAULT for unreadable frags or a
range past the end of the skb, and -EINVAL for a negative length, instead
of returning a 0 checksum. skb_checksum() becomes a wrapper around it and
keeps the old return-0-on-failure behaviour for callers that have not been
converted yet.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a2b52a5a61a9..061c61422a38 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3545,12 +3545,31 @@ int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len)
>  EXPORT_SYMBOL(skb_store_bits);
>  
>  /* Checksum skb data. */
> -__wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
> +/**
> + *	skb_checksum_full - checksum a range of an skb
> + *	@skb: buffer to checksum
> + *	@offset: offset in @skb to start at
> + *	@len: number of bytes to checksum
> + *	@csump: the sum to add to; on success the range's sum is added to it
> + *
> + *	Return: 0 on success, -EINVAL if @len is negative, or -EFAULT if @skb
> + *	has unreadable frags in the range or runs out before @len does.  On
> + *	failure *@csump is not changed.
> + */

[ ... ]

> @@ -3558,13 +3577,13 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
>  			copy = len;
>  		csum = csum_partial(skb->data + offset, copy, csum);
>  		if ((len -= copy) == 0)
> -			return csum;
> +			goto out;
>  		offset += copy;
>  		pos	= copy;
>  	}
>  
> -	if (WARN_ON_ONCE(!skb_frags_readable(skb)))
> -		return 0;
> +	if (!skb_frags_readable(skb))
> +		return -EFAULT;

[Severity: Low]
This isn't a bug, but does the new kernel-doc match this check? The doc
says -EFAULT is returned when @skb "has unreadable frags in the range".
skb_frags_readable() only tests the skb-wide skb->unreadable bit, though,
and this check runs before working out which frags or frag_list members
the range touches.

That leads to two cases:

- On an unreadable skb, a zero-length range at offset >= skb_headlen()
  returns -EFAULT even though no bytes were requested.

- A range that lies entirely in readable frag_list members, past the head's
  own unreadable frags, is rejected without those members being visited.

The old skb_checksum() behaved the same way here. None of the callers
converted later in the series seem to pass such ranges.

Should the kernel-doc describe the skb-wide check? Or should the check move
so it only applies when a page frag is actually in the range?

[ ... ]

> @@ -3606,14 +3625,17 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
>  
>  		end = start + frag_iter->len;
>  		if ((copy = end - offset) > 0) {
> -			__wsum csum2;
> +			__wsum csum2 = 0;
> +
>  			if (copy > len)
>  				copy = len;
> -			csum2 = skb_checksum(frag_iter, offset - start, copy,
> -					     0);
> +			err = skb_checksum_full(frag_iter, offset - start, copy,
> +						&csum2);
> +			if (err)
> +				return err;

[ ... ]

> @@ -3621,9 +3643,23 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)

[ ... ]

> +/* skb_checksum() has no way to report failure, so it returns 0, which is a
> + * valid checksum.  Use skb_checksum_full() in new code.
> + */
> +__wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
> +{
> +	if (unlikely(skb_checksum_full(skb, offset, len, &csum))) {
> +		WARN_ON_ONCE(!skb_frags_readable(skb));
> +		return 0;
> +	}

[Severity: Medium]
The commit message says the wrapper "behaves as before for the callers
that haven't been converted: it returns 0 on failure and warns once if
that was because of unreadable frags". Does that hold when the unreadable
frags are in a frag_list member and not in the top-level skb?

Before this patch, the frag_list loop recursed through skb_checksum(). An
unreadable member hit the WARN_ON_ONCE() and returned 0. The parent then
folded that 0 in with csum_block_add() and returned the partial sum of the
readable parts.

Now the member returns -EFAULT from skb_checksum_full() without a warning.
The frag_list loop passes it straight up, and the wrapper only checks the
outer skb:

    WARN_ON_ONCE(!skb_frags_readable(skb));

If the head is readable and only a member is unreadable, the warning is
lost. Unconverted callers also get 0 for the whole range instead of the
old partial sum.

At this revision __skb_checksum_complete() still does:

    csum = skb_checksum(skb, 0, skb->len, 0);

    sum = csum_fold(csum_add(skb->csum, csum));

Could this pass validation whenever the pseudo-header sum folds to 0xffff,
and then set skb->csum to 0 and csum_valid to 1?

The later patch "net: skbuff: fail checksum validation when the skb can't
be checksummed" converts that function. Other skb_checksum() callers stay
unconverted at the end of the series and still see the changed value, for
example net/netfilter/utils.c, nf_nat_proto.c, ipvs, icmp.c, ipmr.c,
udp.c, mptcp and some drivers. The wrapper itself also never starts
warning for nested failures.

Separately, if the top-level skb is unreadable and the failure is the new
-EINVAL for a negative @len, won't this WARN_ON_ONCE() blame unreadable
frags for it?

This mixed layout looks structurally possible. skb_gro_receive() links
skbs onto frag_list without comparing their unreadable flags, and
tcp_gro_receive() doesn't compare them either. It hasn't been shown to
happen in practice.

Should the wrapper warn on nested -EFAULT as well, or should the commit
message be adjusted to describe the new behaviour?

>  	return csum;
>  }
>  EXPORT_SYMBOL(skb_checksum);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7%40toxicpanda.com
