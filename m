Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731121;
	b=0QOEVerMgPOjtDJoqsXtaQsTF1IcLDcIuAd+uwlK6sHnY7q4zCg6xEV4qWvk0in3f/VJ
	 7OoxwH1W82g05yOb7SEyC2FbH1afBWD1IVZmU/YoBFezRgVnR6TZQObRrgfIFZI/w38Xx
	 taz+Db6ngOohkoNcSqX/Cqm7e0ZysMVdWActxvY4V8yvRP5Xl66L4wdGoSXOQ8py3BDB8
	 JoCnG7S7UbCRBPXMMUHFF4w89h50Z+OMlNuBCFMMr6GRYEwWlfCSDiPjF4TRoeO7rfBWi
	 Q3B25wTSW5l1hhDNdTI1RXBlCAaUnYZX8EhnGqyzhFDOCNtTNqYqhhKXi8aI5ooApKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731121;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CsbqRFbRE+Tnrux6F3AjM6HXluABeMqzeEaYlLw6WYc=;
	b=glekfD8aDnet2POZGfhv1AtwwawjDfOrpfhDp9fM4lX5IzEgQWv+i07wOpX81EMTPGgq
	 H8iV7gAunO482gfB5xuiNU79hb8kttOX6yBbIKLVJcKueb1HHFSFUKc/JsLNLRfyDGPvh
	 UUf745vl9BQCEXKJ5qRtlWyScSzdUssIHauWFhnbUSZ7uLmlNg0BqCEHzV81MZlZLQjcb
	 5CVI0E+5tx9nocYS1GWHTu74yVyoDf1zAoEFh5gufvGFH3Z8AcJ5LePQW6rBY+bvPMaPN
	 T6qfWqs0PhNGoFA2fw2I25v/ArTeqSsRv2h2baoeOMoMzAyAquORQYJcinIPsvoUvCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3jfzhSq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FBF606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3jfzhSq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1BB1F01825;
	Fri, 23 Oct 2026 04:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792731121;
	bh=CsbqRFbRE+Tnrux6F3AjM6HXluABeMqzeEaYlLw6WYc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c3jfzhSqbD7sY+a+qNiZLDCDTwkahCRkVX3Bx9J17yBROTQfZ5guxDyoStV2azodH
	 jNzKVKGtL8ZctkD3SUsnCZBM07+Ahfw8OsR/7puEJ5KFVmOqyuv4Iixi/0q7ut/vxY
	 02rjvTwFPn0pfopaWIJtCXBRB28d6ANN0H+6tFLi9DcIGAK3Oir4z5mXv5roQYRhlW
	 b3AlCqQS7vBy00lEDbjkGWE/DpovU2idnTh53CoeiXOPshYz2uvzJPbVzqCTxOHwnb
	 yU1wahoK+n0SpSm4HHp24AP6vrHv3zYF4RdSWwwK0RKOW2r486ekwy4u92zqPN2Gtv
	 u1fT9+XDxfNGA==
Subject: Re: [PATCH net-next 03/15] net: skbuff: fail checksum validation when
 the skb can't be checksummed
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, jgross@suse.com,
 sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, fmancera@suse.de,
 almasrymina@google.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 23 Oct 2026 04:51:59 +0000
Message-ID: <179273111951.3134.3452028799437573017@kernel.org>
In-Reply-To:
 <20261019-b4-skbuff-bug-on-followups-v1-3-41dbef50b9f7@toxicpanda.com>
References:
 <20261019-b4-skbuff-bug-on-followups-v1-3-41dbef50b9f7@toxicpanda.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not hold when conntrack checks checksums first.
- [High] __skb_gro_checksum_complete() (net/core/gro.c:794-813) has the
  same false-accept defect this commit fixes in…
- [Medium] The Fixes: tag is incomplete for stable backporting.
- [Low] The block comment above __skb_checksum_complete()
  (net/core/skbuff.c:3891-3893) still says 'The new checksum is stored…

--

net: skbuff: fail checksum validation when the skb can't be checksummed

This commit switches __skb_checksum_complete() and
__skb_checksum_complete_head() to skb_checksum_full(). When the skb data
can't be checksummed, they now report a bad checksum. On that failure
path csum_valid is cleared, and skb->csum and ip_summed are left alone.

Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/

> Fixes: 20ddd0fd2fcd ("net: skbuff: don't BUG() on leftover length in skb_checksum() and friends")

[Severity: Medium]
Is this Fixes: tag complete for stable backports?

The likely remote trigger for __skb_checksum_complete() is unreadable
devmem frags. skb_checksum() has returned 0 for those since 65249feb6b3d
("net: add support for skbs with unreadable frags"):

    if (WARN_ON_ONCE(!skb_frags_readable(skb)))
        return 0;

The 20ddd0fd2fcd commit message also says skb_checksum() returns 0 "as
they already do for unreadable frags".

__skb_checksum_complete() checksums from offset 0 to skb->len. It can
only run past the end if the skb lengths are inconsistent.

With only Fixes: 20ddd0fd2fcd, stable trees from 6.12 onward that have
65249feb6b3d but not 20ddd0fd2fcd would not pick this up. Should
65249feb6b3d be listed as well?

This patch also depends on the previous patch in the series ("net:
skbuff: add skb_checksum_full() that reports failure"). Nothing in the
tags records that dependency.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 061c61422a38..40d2dd20d47d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -3886,10 +3894,17 @@ EXPORT_SYMBOL(__skb_checksum_complete_head);
>   */
>  __sum16 __skb_checksum_complete(struct sk_buff *skb)
>  {
> -	__wsum csum;
> +	__wsum csum = 0;
>  	__sum16 sum;
>  
> -	csum = skb_checksum(skb, 0, skb->len, 0);
> +	/* If the data can't be checksummed it can't be valid either.  Leave
> +	 * skb->csum alone, it's not a full packet checksum.
> +	 */

[Severity: Low]
The block comment above __skb_checksum_complete() still says:

    * zero. The new checksum is stored back into skb->csum unless the skb is
    * shared.

On the new failure path, skb->csum is not stored back even for unshared
skbs. That contradicts the new inline comment. skb_remcsum_process()
ignores the return value of __skb_checksum_complete() and then uses
skb->csum, so it relies on this post-condition.

The return-value comments for __skb_checksum_validate_complete() and
__skb_checksum_validate() in include/linux/skbuff.h also say:

    *   non-zero: value of invalid checksum

The new path returns the constant (__force __sum16)1 rather than a
computed value. Should both comments be updated?

> +	if (skb_checksum_full(skb, 0, skb->len, &csum)) {
> +		if (!skb_shared(skb))
> +			skb->csum_valid = 0;
> +		return (__force __sum16)1;
> +	}

[Severity: High]
Can leaving ip_summed set to CHECKSUM_COMPLETE here let a later validator
accept the packet anyway?

Callers have already replaced skb->csum with the pseudo-header sum before
calling this function. nf_ip_checksum() does this when the hardware
CHECKSUM_COMPLETE sum fails to validate:

net/netfilter/utils.c:nf_ip_checksum() {
    ...
	case CHECKSUM_NONE:
		...
			skb->csum = csum_tcpudp_nofold(iph->saddr, iph->daddr,
						       skb->len - dataoff,
						       protocol, 0);
		csum = __skb_checksum_complete(skb);
    ...
}

For an skb with unreadable frags, skb_checksum_full() fails. The skb
then leaves this function with ip_summed == CHECKSUM_COMPLETE and
skb->csum == psum.

Conntrack does not drop on a bad checksum:

nf_conntrack_in()
  nf_conntrack_tcp_packet()
    tcp_error()  -> true
    return -NF_ACCEPT
  ret = -ret;    -> NF_ACCEPT

The packet then reaches
tcp_v4_rcv()->skb_checksum_init()->__skb_checksum_validate_complete():

	if (skb->ip_summed == CHECKSUM_COMPLETE) {
		if (!csum_fold(csum_add(psum, skb->csum))) {
			skb->csum_valid = 1;
			return 0;

inet_compute_pseudo() produces the same psum, so this computes
csum_fold(psum + psum). That is 0 exactly when psum folds to 0xffff,
which is the condition the commit message says it closes. The sender
controls it through the packet length or source address. Conntrack
checksumming is on by default (nf_conntrack_checksum = 1).

The commit message says:

    report a packet that can't be checksummed as having a bad checksum,
    so callers drop it the way they drop any other bad checksum.

This caller doesn't drop it. Would it make sense to move ip_summed off
CHECKSUM_COMPLETE (for example to CHECKSUM_NONE) on this path when the
skb is not shared? That way later validators can't trust the stale
pseudo-header sum. The series leaves this code as it is.

>  
>  	sum = csum_fold(csum_add(skb->csum, csum));
>  	/* This check is inverted, because we already knew the hardware

[Severity: High]
Should __skb_gro_checksum_complete() in net/core/gro.c be converted too?
It has the same false-accept pattern, its comment points to the comments
in __skb_checksum_complete(), and the series doesn't change it:

net/core/gro.c:__skb_gro_checksum_complete() {
    ...
	wsum = skb_checksum(skb, skb_gro_offset(skb), skb_gro_len(skb), 0);

	/* NAPI_GRO_CB(skb)->csum holds pseudo checksum */
	sum = csum_fold(csum_add(NAPI_GRO_CB(skb)->csum, wsum));
    ...
	NAPI_GRO_CB(skb)->csum = wsum;
	NAPI_GRO_CB(skb)->csum_valid = 1;
    ...
}

For a devmem skb with unreadable frags, skb_checksum() fires
WARN_ON_ONCE(!skb_frags_readable(skb)) and returns 0. sum is then
csum_fold(psum), which is 0 when psum folds to 0xffff.

The path is:

tcp4_gro_receive()
  skb_gro_checksum_validate()
    __skb_gro_checksum_validate_complete()
      __skb_gro_checksum_complete()
    skb_gro_incr_csum_unnecessary()

For CHECKSUM_NONE skbs this ends in CHECKSUM_UNNECESSARY. For merged
CHECKSUM_COMPLETE skbs, tcp_gro_complete() sets CHECKSUM_PARTIAL. In both
cases TCP never validates the payload again, and GRO accepts the packet
before the helpers changed here ever run.

Every bad-checksum packet on such a queue also hits the WARN_ON_ONCE()
from softirq context, which a remote sender can trigger. The WARN itself
comes from 65249feb6b3d.

The previous patch, "net: skbuff: add skb_checksum_full() that reports
failure", says the following patches convert the core users. This
net/core user isn't converted anywhere in the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7%40toxicpanda.com
