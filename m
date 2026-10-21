Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596104;
	b=AdQxL/fc/AnPMr3FtM/vDbkK3caS0V8zl/3+Wv12dkR8F5QQsdzv84iNmJvePNyHOBwS
	 YeC1jY7VbJRe7s92a70PT6oKdQUHwPj7gB+uXssFnB64ZcFzKdG+rKLOE8kklnjBIl90g
	 tIEh2s4CmFlqhq3Re+zmw/e1B4J0sH1yh/2dNZ0QtooaQJwbrZZGkjYf5+kMKSj3bWTZj
	 c99ZSZ8EvriXlOqwLyNGzuApxjdqVas7la1+j1rh/EDnKbaAF7HZaeT6hb9ExOi1uqQN1
	 TezVibOKe8+CWqyaxGLkYccNL3cI/NCHDBO+ZDCgrP0Nz2mEsyGO3jMAP+SB9CLIWKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596104;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2iBwQfxq9ufIIJWj3GlzaQbSS31o40TGynEbnrUKik0=;
	b=wV1N4mldb+aqHOi6QG7WZDBmXZeRVtU716h0eddZ/LOR7gWbr4m9DiaUqSrLdHaQnWw3
	 +BHOpTOzyolxlPlV40W3PwJln1+rvIoiomCeURR6Dfx6stl21De35Dl3ZM+0yowXlOeOT
	 t9WijygtRd5lH8TVVqb6fTjiIWumbw2HF7y9xV3BFrk2QbYy7mQ2oqQhMzsrNAwedK8Wr
	 +YT4RdVdceeYk5qh0aNJtYtfTjiw50PrukPCbZ5Jwx5X70ZzS7epajl5FtanMjAu//J1z
	 KYyY3NacYLmpfeDVaaOwhUZMopjTsS5LwU/wQmPGAaC6ud/ktako5Taw5q0H2j355Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hn5aRe9H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D25606A31F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hn5aRe9H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6636F1F000C1;
	Wed, 21 Oct 2026 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596103;
	bh=2iBwQfxq9ufIIJWj3GlzaQbSS31o40TGynEbnrUKik0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hn5aRe9Hg8F1HFNtMEz0C2xCO5sMxc+i5ZEfl+PcUGhW2WqIcm60RghA5zOwdveAE
	 dF1PqUj7NX6d4kCRYGzoHHGlJfavPE/jPtbH8ZKy9E5yM9JYTwh5DPW8Ybp4wFDn9m
	 88NjWjc6i7qWZdhJklk+f9Iv5R4Maoa7OorxNGEvNNP71hx7aZ4WGIMSFhJT34hGOF
	 q5J2yoc/WATL+Xv9eCIGmFlihKUdWrnX3El3cLYSQ2xTGSAjWrv3Ys0Xl+BZysu6Ko
	 dROce1bfv0qz9JwUzAiu2JHetFnPLc1xKiCye6+lFqq3dWz7XniT+e3VIWHSTGLv+W
	 TEhoQNWsARZlg==
Subject:
 Re: [PATCH net] net: shrink the payload-only part of skb dataref to one bit
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, Stephan@adalogics.com
Date: Wed, 21 Oct 2026 15:21:42 +0000
Message-ID: <179259610296.3135.5083998587535514838@kernel.org>
In-Reply-To: <20261020151954.22953-1-edumazet@kernel.org>
References: <20261020151954.22953-1-edumazet@kernel.org>
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

- [Medium] The patch raises the wrap point of the shared-head reference
  count from 2^16 to 2^30, but it adds no bound or saturation.
- [Low] After the patch, the 'DOC: dataref and headerless skbs' block in
  include/linux/skbuff.h contradicts itself.

--

net: shrink the payload-only part of skb dataref to one bit

This commit moves SKB_DATAREF_SHIFT from 16 to 30. The overall reference
count in skb_shinfo(skb)->dataref now gets 30 bits, and the payload-only
(nohdr) part becomes a single bit. The aim is to close a use-after-free:
with 65,537 clones of one head, skb_cloned() reported the head as private
and pskb_expand_head() freed it.

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index af1cbc2799b77..432ba994d4ab0 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -639,9 +639,9 @@ struct skb_shared_info {
>   *
>   * Transport layers send out clones of payload skbs they hold for
>   * retransmissions. To allow lower layers of the stack to prepend their headers
> - * we split &skb_shared_info.dataref into two halves.
> - * The lower 16 bits count the overall number of references.
> - * The higher 16 bits indicate how many of the references are payload-only.
> + * we split &skb_shared_info.dataref into two parts.
> + * The lower 30 bits count the overall number of references.
> + * Bit 30 indicates whether one of the references is payload-only.

[Severity: Low]
This isn't a bug, but does the rest of this DOC block still match the new
encoding? A few lines further down, this text is unchanged:

 * doing the right thing. In practice there's usually only one payload-only skb.

The payload-only part is now a single bit, so more than one payload-only
reference can't be represented at all, and "usually" looks stale. This
block is also pulled into Documentation/networking/skbuff.rst through the
"dataref and headerless skbs" doc directive.

Also, skb_header_cloned() reads more than bit 30:

	dataref = (dataref & SKB_DATAREF_MASK) - (dataref >> SKB_DATAREF_SHIFT);

The shift on a signed int covers bits 30 and 31. A second payload-only
reference would therefore land in the sign bit.

Would it make sense to state here that the flag may only be set with
atomic_set() on an skb that owns its head, as __skb_header_release() does
today?

>   * skb_header_cloned() checks if skb is allowed to add / write the headers.
>   *
>   * The creator of the skb (e.g. TCP) marks its skb as &sk_buff.nohdr
> @@ -661,7 +661,7 @@ struct skb_shared_info {
>   * Having multiple payload-only skbs with different lengths of hdr_len is not
>   * possible. The payload-only skbs should never leave their owner.
>   */
> -#define SKB_DATAREF_SHIFT 16
> +#define SKB_DATAREF_SHIFT 30
>  #define SKB_DATAREF_MASK ((1 << SKB_DATAREF_SHIFT) - 1)

[Severity: Medium]
This moves the wrap point much higher, but is the count still unbounded?

__skb_clone() still increments it without any check:

net/core/skbuff.c:__skb_clone() {
    ...
	atomic_inc(&(skb_shinfo(skb)->dataref));
	skb->cloned = 1;
    ...
}

skb_cloned() still checks only the masked field:

	return skb->cloned &&
	       (atomic_read(&skb_shinfo(skb)->dataref) & SKB_DATAREF_MASK) != 1;

With (1 << 30) + 1 live references to one head, the masked value reads 1
again. pskb_expand_head(), skb_unclone(), skb_cow() and similar helpers
would then treat the shared head as private. That is the same
use-after-free this patch fixes.

The carry past 2^30 - 1 would also set bit 30, the nohdr flag. That would
break skb_header_cloned() and the (1 << SKB_DATAREF_SHIFT) + 1 bias in
skb_data_unref().

The commit message says:

    Wrapping it would need 2^30 live clones of
    a single skb, which socket buffer limits and memory make unreachable.

Do socket buffer limits actually cap this? They apply per socket. They
don't bound the total number of clones of one head across many sockets,
for example the AF_PACKET fan-out in packet_rcv(). __skb_clone() also
sets n->sk and n->destructor to NULL, so the clone itself is not charged
to any socket.

That leaves memory as the real limit. 2^30 sk_buff objects from
skbuff_head_cache come to roughly 256 GiB, which some large servers have.

I couldn't build a concrete path to 2^30 live clones of one head, so this
may well be out of reach in practice. Would it be worth adding a
DEBUG_NET_WARN_ON_ONCE(), or falling back to a copy when the count nears
SKB_DATAREF_MASK? Alternatively, could the commit message describe the
wrap as impractical rather than unreachable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020151954.22953-1-edumazet%40kernel.org
