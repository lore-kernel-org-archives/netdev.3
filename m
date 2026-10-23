Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731131;
	b=R/9KJ5W4sAHJ30PGgc1SPSoDNdkEntBjWUPZjBwafBMU5sHINUrVn+3nYK5CqQdT4P56
	 J0N8slke021zM5TWoMahzt5dNAAbROZpny48Hpcjol+qwK/arFnrf1N+ut5Qg1wYEzjcg
	 1dB0qdP6UGmFR74zi4zJZFng0t9uj1Qs0OkrtvhwY7vop1qAhg0lJSYyP9iWM1RXomuWn
	 j3/4VySOh+KqmoUVlgEzCabk6gWGGtVucrpWgMSifdXKP82w4VLiRgMr83W+ZvY4BKxr+
	 TeLHj27jv+lBHLdhEVIdu9BdYiNym8yPK5a3rrJYyrLz6niXa5JPNcZs3iITSE2S7Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731131;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=297sVdh7jI9/YZVUTISisNh0xfIn+ptDdAeK7+MG+j4=;
	b=dCA4X19rhXMYo3FJM/kwUwP6SI4Y0eXm88xjdaWzbMyfPtQjLpmifG1se1cQTp6FVCvE
	 iEAZJZ2GUq9s6QrYcAe61BISGSHAxL96KSaOssWJoRy9ifs9nEW1nE+MAsSeV9F6DaSop
	 DFabG888iQuOuTHvBUZnp8/LvpsX8LeHs+Sq+Zha4PgvI0SlASNWN9CYOJXKiCGjx2uij
	 TiaTcF16ne/QIihC+3VbPtClYHpdGyAoPWQQq1MAdlB8Bvp90g6fZqdzwUWwhnVswsTJa
	 rcKOhbjj5MEBTsFOY2bHvzLGYwFC7KoyoIXxjjK4WnNPpk/kgQytPKt3UeK4uwxcROg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsVDi42x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C5606A325
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsVDi42x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2301F01829;
	Fri, 23 Oct 2026 04:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792731131;
	bh=297sVdh7jI9/YZVUTISisNh0xfIn+ptDdAeK7+MG+j4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RsVDi42x5d11Xzqr5TY5CMbXLnmsax0HywsBl/ckkPOsiwTAtg2HKqp1I0Gt0pNe5
	 o562TlDRdFBbd72heCdiENUI2gRkwkQmu4284CHf1aXb58ZwQNdM3kLzrxp+szYioX
	 Xm8klKt3tLKcfAH4v2z2hprDFbJvqndr6XjUHJ6uWq/nqZHFS6/nvS8yHj0XwF2Ay8
	 pGjfemmlrmCJjlLw8g5JbeNJH5uuzLIcQAsA3I7UnSfPR90oeUcWLYsW52hkPI1u0K
	 Vc3k0AafsJCnffpPlgHDfZHENet5iR2IKZSCJ7oV+Vp4IUC9qKYyDNn7y8LStW+QJx
	 5/p2ncCTH6e3Q==
Subject: Re: [PATCH net-next 10/15] net: skbuff: reject a negative length in
 skb_copy_and_csum_bits()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, jgross@suse.com,
 sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, fmancera@suse.de,
 almasrymina@google.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 23 Oct 2026 04:52:09 +0000
Message-ID: <179273112973.3134.5343458615205155491@kernel.org>
In-Reply-To:
 <20261019-b4-skbuff-bug-on-followups-v1-10-41dbef50b9f7@toxicpanda.com>
References:
 <20261019-b4-skbuff-bug-on-followups-v1-10-41dbef50b9f7@toxicpanda.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message's reason for dropping the `if (len > 0)` guard
  on the final zero-fill in skb_copy_and_csum_bits() (net/core/skbuff.c)…
- [Low] The patch narrows the zero-fill promise in
  skb_copy_and_csum_bits()'s kernel-doc: "on -EFAULT the part of @to…

--

net: skbuff: reject a negative length in skb_copy_and_csum_bits()

This commit makes skb_copy_and_csum_bits() return -EINVAL, with a
DEBUG_NET_WARN_ON_ONCE(), when it is given a negative len. It also drops
the len > 0 guard on the final zero-fill. The kernel-doc now promises the
zero-fill only for -EFAULT.

Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/

> Commit 417261779eab ("net: skbuff: don't BUG() on leftover length in
> skb_copy_and_csum_bits()") guards its zero-fill against a negative @len
> from a broken caller, but such a @len never gets that far.  The head,
> frag and frag_list copies all clamp their length to @len, so a negative
> one has already turned into a huge copy, or an endless frag walk, by
> then.

[Severity: Low]
Is this an accurate description of the old code? The head, frag and
frag_list copies clamp to len only when they run. All three are skipped
when offset is at or past the end of the skb's data.

Take a linear skb with no frags, offset == skb->len and len == -1:

    copy = start - offset;                            /* 0, no head copy */
    for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)   /* no frags */
    skb_walk_frags(skb, frag_iter)                    /* empty */

In the parent commit, the negative len then reaches the final block
unchanged:

net/core/skbuff.c:skb_copy_and_csum_bits() {
    ...
	if (unlikely(len)) {
		DEBUG_NET_WARN_ON_ONCE(1);
		/* Don't hand the caller a buffer with stale bytes in it. */
		if (len > 0)
			memset(to, 0, len);
		return -EFAULT;
	}
    ...
}

There, the len > 0 check is what prevents a memset of close to SIZE_MAX
bytes.

The code change itself looks right, because the new check on entry keeps
len non-negative for the rest of the function. The Fixes: tag relies on
this description of what 417261779eab guarded, though. Could the commit
message say that the guard only covered the final zero-fill and not the
clamped copies?

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 782a6bacd568..56cec58bccb7 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3678,9 +3678,10 @@ EXPORT_SYMBOL(skb_checksum);
>   *	@len: number of bytes to copy
>   *	@csump: where to store the checksum of the copied bytes
>   *
> - *	Return: 0 on success, or -EFAULT if @skb has unreadable frags or runs
> - *	out before @len does.  On failure *@csump is not set and the part of
> - *	@to that couldn't be filled is zeroed.
> + *	Return: 0 on success, -EINVAL if @len is negative, or -EFAULT if @skb
> + *	has unreadable frags or runs out before @len does.  On failure *@csump
> + *	is not set, and on -EFAULT the part of @to that couldn't be filled is
> + *	zeroed.
>   */
>  int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
>  			   u8 *to, int len, __wsum *csump)
> @@ -3692,6 +3693,14 @@ int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
>  	__wsum csum = 0;
>  	int err;
>  
> +	/* Everything below clamps copies to @len, so a negative one would
> +	 * turn into a huge copy.
> +	 */
> +	if (unlikely(len < 0)) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}

[Severity: Low]
This early return leaves to untouched, and the kernel-doc above now
promises the zero-fill only for -EFAULT. Does skb_copy_and_csum_dev() need
an update as well? Its comment still says that any failure zeroes the
buffer:

net/core/skbuff.c:skb_copy_and_csum_dev() {
    ...
	csum = 0;
	/* On failure the rest of @to is zeroed; leave the checksum alone so
	 * the frame goes out with a bad one.
	 */
	if (csstart != skb->len &&
	    skb_copy_and_csum_bits(skb, csstart, to + csstart,
				   skb->len - csstart, &csum))
		return;
    ...
}

The drivers that call it (8139too, via-rhine, sc92031, ep93xx, ec_bhf,
ksz884x) transmit to after it returns. The csstart checks keep
skb->len - csstart non-negative as an unsigned value, but they don't keep
it within INT_MAX. A corrupt skb with more than INT_MAX bytes past csstart
would get -EINVAL here, and the bytes after csstart would go out stale.

That also goes against the first patch in the series ("net: skbuff: make
skb_copy_and_csum_bits() report unreadable frags"), which says "The
zero-fill stays, so a caller that does send the buffer still doesn't leak
anything."

The drivers' own size limits keep valid skbs from getting here. Before
this patch, the same corrupt input caused a huge copy instead. The comment
in skb_copy_and_csum_dev() is still unchanged at the end of the series,
including after "net: update comments that still describe the skb
BUG_ON()s".

Could that comment be updated? Alternatively, skb_copy_and_csum_dev()
could zero the rest of to itself when the helper fails.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7%40toxicpanda.com
