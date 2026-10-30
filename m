Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395968;
	b=tzS9rt19V4YBOfHDTImy+WdZLKKknPhW02/4IrBpkSQekj7NdDzFGhCt5xeYffjT1iUc
	 8HysZpG4xI7dDLXPGPHZOIZkomXCvSZqy5ZAVlhe7qqfAzfowavCd9A8RyzWfnobWrDWk
	 b/X9YjGwI1zSMVF9Q68GUxUsyJtSMTtFOYoTFw6LP5fyHxgRFm9it0igNgryTSxDvrclh
	 D4O7Dj2TjkTssffvnaEgf4a5BdNcGDLx/cbQAq/v+z0b2D3FDmFs3ZeSdNHW8VflxPD4y
	 PbRMnSSYgcNY6cLztoG4mkGlIm4zBPvFjm2ieZIaJBGGh33Cje4cH2VJRptmU9w3FSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395968;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=b8ezmLcQFCSyrEAPrvhRD05fblaMPYsKIhBxCdtaPEA=;
	b=l2n7V6uw5fsV5RzT0VXEr1Ey+CLEE1QdQWVsRm0eEizs0Y4WoPJmFuSlQu76kcLAnsAj
	 WyP3KxJrKORhLG95xx/BGffweByLNxtYgN68Ow4Jj0Dq0Pk8EZFP02VivhnCVUbWT4qwK
	 obVeDTS+PXpzAWay9j9Fkcs6R7tHVZFO7xDqLAjWXtV/DbMks2kMYopfkgDUly5g9PDk3
	 0lB7aXvcOz+RbiZhfXIbo0Xyc6dYrENwvAHLK+LwgSe5n3bp7oOGl2Eq22DCUGy0jRzTY
	 4Yh0KpNUhgwUXlQUz0p+JSz5iLNQJepT8IT97nMUEsS+CP3gn0vFaHRRw52D4EpmLjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIi9higG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020F606A31A;
	Fri, 30 Oct 2026 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIi9higG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8347C1F0093A;
	Fri, 30 Oct 2026 21:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793395967;
	bh=b8ezmLcQFCSyrEAPrvhRD05fblaMPYsKIhBxCdtaPEA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gIi9higGn7Obc28FcZBnNZllRcPWZ+aWoeXoecHBWMHeNesFWG8DjcD6F3z0THdEO
	 FigLKJa6E5h8i+o3Kta+Z/AnVCywyKMavwGo5MKakjsPvh3zS60fMbIoZYj4d24v3j
	 N6A9ejPLB6H88HQmRmMEOq2fxVC2a0HlDHEDCzHCqCLF2LgfVv+V2fHbqPkOhXZsoi
	 zetQ28J3Jy82IUs6wuBjI7xjHbgzGUxTmevqQJmSE8p3vzs4FN3ODCeCIubSPqlGEY
	 40dAt+W/P2gcmvr0A3naekMFmiVIclr7MEMCp6cvO5jvswSuuo34gQ5cqBJnYZrFoL
	 Is29O03SDxj9A==
Subject: Re: [PATCH net] ppp: remove SC_MUST_COMP
From: netdev-bot+sashiko@kernel.org
To: qingfang.deng@linux.dev
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, leitao@debian.org, norbert@doyensec.com,
 hataegu0826@gmail.com, paulus@ozlabs.org, Brice.Goglin@ens-lyon.org,
 akpm@osdl.org, Matt_Domsch@dell.com, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 21:32:46 +0000
Message-ID: <179339596607.3131.10030375792154782283@kernel.org>
In-Reply-To: <20261029074935.40509-1-qingfang.deng@linux.dev>
References: <20261029074935.40509-1-qingfang.deng@linux.dev>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch deletes the exported `#define SC_MUST_COMP
  0x00400000` from include/uapi/linux/ppp-ioctl.h.

Pre-existing issues:
- [Medium] With SC_COMP_RUN set and SC_CCP_UP clear, a successfully
  compressed DEFLATE/BSD packet (len > 0) falls into the error branch of…

--

ppp: remove SC_MUST_COMP

This patch removes SC_MUST_COMP from the UAPI header, SC_MASK and
SC_FLAG_BITS. SC_MUST_COMP has the same value as SC_DC_ERROR, so a
read-modify-write through PPPIOCGFLAGS/PPPIOCSFLAGS can latch it by
accident. The transmit and receive drop checks for the flag in
ppp_generic.c are removed as well.

> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 29847dc4bb454..f7b59060450fe 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c

[ ... ]

> @@ -1863,13 +1862,6 @@ ppp_prepare_tx_skb(struct ppp *ppp, struct sk_buff **pskb)
>  	/* try to do packet compression */
>  	if ((ppp->xstate & SC_COMP_RUN) && ppp->xc_state &&
>  	    proto != PPP_LCP && proto != PPP_CCP) {
> -		if (!(ppp->flags & SC_CCP_UP) && (ppp->flags & SC_MUST_COMP)) {
> -			if (net_ratelimit())
> -				netdev_err(dev,
> -					   "ppp: compression required but "
> -					   "down - pkt dropped.\n");
> -			goto drop;
> -		}
>  		new_skb = pad_compress_skb(ppp, skb);
>  		if (!new_skb)
>  			goto drop;

[Severity: Medium]
This is a pre-existing issue and wasn't introduced by this patch. While
looking at this path: can pad_compress_skb() drop packets that were
compressed successfully?

drivers/net/ppp/ppp_generic.c:pad_compress_skb() {
    ...
	if (len > 0 && (ppp->flags & SC_CCP_UP)) {
		...
	} else if (len == 0) {
		...
	} else {
		...
		consume_skb(new_skb);
		new_skb = NULL;
	}
    ...
}

Say SC_COMP_RUN is set but SC_CCP_UP is still clear. A DEFLATE or BSD
compressor that returns len > 0 then lands in the else branch. The
packet is dropped just as if the compressor had rejected it.

That state looks reachable. ppp_ccp_peek() handles an outbound
CCP_CONFACK only while SC_CCP_OPEN is set and SC_CCP_UP is clear, and
that is where it sets SC_COMP_RUN:

	case CCP_CONFACK:
		if ((ppp->flags & (SC_CCP_OPEN | SC_CCP_UP)) != SC_CCP_OPEN)
			break;
		...
			if (ppp->xcomp->comp_init(ppp->xc_state, dp, len,
						  ppp->file.index, 0,
						  READ_ONCE(ppp->debug)))
				ppp->xstate |= SC_COMP_RUN;

pppd sets SC_CCP_UP only once CCP reaches Opened.

When the drop happens, z_compress() has already updated its history and
advanced its sequence number:

	put_unaligned_be16(state->seqno, wptr);
	...
	++state->seqno;

After SC_CCP_UP is set, would the next compressed frame carry a sequence
number ahead of what the peer's z_decompress() expects?

	if (seq != (state->seqno & 0xffff)) {
		...
		return DECOMP_ERROR;
	}

If so, data sent in that window is lost, and recovery needs a CCP
Reset-Request/Reset-Ack cycle. The else branch dates from b3f9b92a6ec1,
and this patch leaves it unchanged.

[ ... ]

> diff --git a/include/uapi/linux/ppp-ioctl.h b/include/uapi/linux/ppp-ioctl.h
> index 1cc5ce0ae062e..672f7ac11a0b8 100644
> --- a/include/uapi/linux/ppp-ioctl.h
> +++ b/include/uapi/linux/ppp-ioctl.h
> @@ -39,8 +39,7 @@
>  #define SC_LOG_RAWIN	0x00080000	/* log all chars received */
>  #define SC_LOG_FLUSH	0x00100000	/* log all chars flushed */
>  #define	SC_SYNC		0x00200000	/* synchronous serial mode */
> -#define	SC_MUST_COMP    0x00400000	/* no uncompressed packets may be sent or received */

[Severity: Medium]
Does the fix need the define to be removed from the UAPI header?

PPPIOCSFLAGS already masks the user value with the kernel-internal
SC_FLAG_BITS:

drivers/net/ppp/ppp_generic.c:ppp_ioctl() {
    ...
		ppp->flags = val & SC_FLAG_BITS;
    ...
}

Removing the bit from SC_FLAG_BITS (and SC_MASK), together with the two
checks, looks like enough to stop SC_DC_ERROR from being stored as a
config flag.

Deleting the define is a separate change at the source level. Userspace
that includes <linux/ppp-ioctl.h>, directly or through <linux/if_ppp.h>,
and refers to SC_MUST_COMP would no longer build.

The commit message calls the flag unused, but the evidence is that one
pppd integration from 2005 never landed upstream. That does not rule out
out-of-tree pppd MPPE forks or other daemons that use the name.

With the Fixes: tag pointing at a 2005 commit, this header change will
likely be backported to the stable kernel-headers as well.

Would it work to keep the define, with a comment that the kernel ignores
it and that it aliases SC_DC_ERROR, while still dropping it from
SC_FLAG_BITS and SC_MASK and removing the checks?

> -#define	SC_MASK		0x0f600fff	/* bits that user can change */
> +#define	SC_MASK		0x0f200fff	/* bits that user can change */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029074935.40509-1-qingfang.deng%40linux.dev
