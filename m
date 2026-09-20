Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4862486624;
	Sun, 20 Sep 2026 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944852; cv=none; b=q/BsNcjI+3e0aLXjcem+sICMFIIlzTFsyBF0LKSqLjYKAZhNcAaJCpAi1llAMXxDSaetUb20RIHWQJImjXTIY7JAcf9eg72uzReCDIzZIg4kfVKwztTQr3Wfe9m4at5A8jG0qkl7htVNoIK6oN8TqY65Y0DA1SRkvlIQ9cb/iPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944852; c=relaxed/simple;
	bh=nrsHFgrIKSrSUGQt3EIoKQIHaOhskGx7vx61kKq2kOs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tq50JJrDINv3a6YDnK6jqlZjDGWQgOKhdiw1iNtybDNz0ri45tTaVnAzx15H9gh9XEeKtUpQa+V4jhkaJoOSAZAPTe6AGQ3YHlXQqC27/TBBT1Q6k3+tEAxc8WwIDgtNEX0BP19+hnlGZUgcgBeYo6xTLpCNVjWOJ6hfHqLltwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7AEwFA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7AEwFA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A461F000FF;
	Sun, 20 Sep 2026 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944850;
	bh=68YQSzjk8ZjMFKcw6CYEHXRF7f/z34V5ymqXk5N17Ok=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D7AEwFA8+ig15oTnrttxE3gz6Fh4LeVnP3gGQR/u6u7ebmr8zKduTzvGtPx2gUb2k
	 zJa31NpCH6BQPkSgn+gO2xyseIRPKHYu9DS92ww3Kg67hEokHFdfl/0kZDSYqkQ3ZU
	 PEBdoNRZD5/O68cakQ28z6z3MqDMq7G7Gn54VIJyul9YCQVHgYtQapZOIDgOiYs4zd
	 IWLh3y/zD1zD930KO++mEAtITLncxjYUDP0SI7aUvEYhGMKBGzuC9utOxo5x+5N+eg
	 QSKwQ59BN+mf289GrDH7rjZMKIgvqgU/j4WTIR+1/kOfpUgZT/hF3SVFGpip3dLl8r
	 Iw68nvW07bGYQ==
Subject: Re: [PATCH] ppp: fix bsd_decompress() OOB read and
 ppp_decompress_frame() headroom check
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 22:54:09 +0000
Message-ID: <178994484954.2160803.7340548461955780287@kernel.org>
In-Reply-To: <20260919215233.3470411-1-benquike@gmail.com>
References: <20260919215233.3470411-1-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ppp_decompress_frame() (drivers/net/ppp/ppp_generic.c:2555-2557)
  now calls pskb_expand_head(skb, 2, 0, GFP_ATOMIC) unconditionally on…
- [Medium] The commit message states that the decompressed length 'is
  only checked for len < 0 before indexing ns->data[2..3] and calling…
- [Medium] The patch hardens only one of the three in-tree implementers
  of `struct compressor::decompress`.
- [Medium] The new pskb_expand_head(skb, 2, 0, GFP_ATOMIC) in
  ppp_decompress_frame() (drivers/net/ppp/ppp_generic.c:2556) creates…

--

ppp: fix bsd_decompress() OOB read and ppp_decompress_frame() headroom check

This adds an isize floor check to bsd_decompress(), makes
ppp_decompress_frame() call pskb_expand_head(skb, 2, 0, GFP_ATOMIC) to
guarantee two bytes of headroom, and tightens the decompressed length
check from len < 0 to len < PPP_HDRLEN.

No Link: tags were present in the commit header.

A few questions below.

> ppp: fix bsd_decompress() OOB read and ppp_decompress_frame() headroom check
>
> In ppp_decompress_frame(), skb->data - 2 is passed to the decompressor
> assuming at least 2 bytes of headroom exist for the PPP Address/Control
> fields, and the returned decompressed length is only checked for len < 0
> before indexing ns->data[2..3] and calling skb_pull_rcsum(skb, 2).

[Severity: Medium]
Does this describe the code being patched?  Neither an ns->data[2..3]
access nor a skb_pull_rcsum(skb, 2) exists in ppp_decompress_frame().
The post-decompress sequence there is:

	consume_skb(skb);
	skb = ns;
	skb_put(skb, len);
	skb_pull(skb, 2);	/* pull off the A/C bytes */

	/* Don't call __ppp_decompress_proto() here, but instead rely on
	 * corresponding algo (mppe/bsd/deflate) to decompress it.
	 */

The only skb_pull_rcsum(skb, 2) in the file lives in the caller,
ppp_receive_nonmp_frame().  The read that the new len < PPP_HDRLEN check
actually protects looks like the two-byte

	proto = PPP_PROTO(skb);

in ppp_receive_nonmp_frame() after skb->len has been reduced to 1 by
skb_put(3) + skb_pull(2), which the message does not mention.  Could the
message be updated to match the tree being patched, so that stable
backport decisions can be checked against it?

> diff --git a/drivers/net/ppp/bsd_comp.c b/drivers/net/ppp/bsd_comp.c
> index 63a6d251c746..03ee4ff4ec1b 100644
> --- a/drivers/net/ppp/bsd_comp.c
> +++ b/drivers/net/ppp/bsd_comp.c
> @@ -847,6 +847,8 @@ static int bsd_decompress (void *state, unsigned char *ibuf, int isize,
>      int extra;
>  
>      db       = (struct bsd_db *) state;
> +	if (isize < PPP_HDRLEN + BSD_OVHD)
> +		return DECOMP_ERROR;
>      max_ent  = db->max_ent;

[Severity: Medium]
Should this check instead live in the shared caller?  There are three
in-tree implementers of struct compressor::decompress, and they are all
reached from the single dispatch point in ppp_decompress_frame():

	len = ppp->rcomp->decompress(ppp->rc_state, skb->data - 2,
			skb->len + 2, ns->data, obuff_size);

z_decompress() already validates isize before touching ibuf, and this
patch adds the same for bsd_decompress(), but mppe_decompress() still
reads ibuf[4] in a variable initializer that runs before its own length
guard:

drivers/net/ppp/ppp_mppe.c:mppe_decompress() {
	int flushed = MPPE_BITS(ibuf) & MPPE_BIT_FLUSHED;

	if (isize <= PPP_HDRLEN + MPPE_OVHD) {
		...
		return DECOMP_ERROR;
	}

with

#define MPPE_BITS(p) ((p)[4] & 0xf0)

The receive path only guarantees skb->len >= 2 (ppp_decompress_proto()
does pskb_may_pull(skb, 2)), so a peer that has negotiated MPPE and sends
a 2-byte PPP_COMP frame gives isize == 4 and makes ibuf[4] read one byte
past the frame data.  Does a single minimum-isize test at the dispatch
point cover all three callbacks rather than leaving MPPE inconsistent?

Also, the indentation of the added lines uses tabs while the surrounding
function uses the file's older 4-space style.

> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 1a610a18893b..f7af328b7bf8 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -2552,7 +2552,8 @@ ppp_decompress_frame(struct ppp *ppp, struct sk_buff *skb)
>  	/* Until we fix all the decompressor's need to make sure
>  	 * data portion is linear.
>  	 */
> -	if (!pskb_may_pull(skb, skb->len))
> +	if (!pskb_may_pull(skb, skb->len) ||
> +	    pskb_expand_head(skb, 2, 0, GFP_ATOMIC))
>  		goto err;

[Severity: High]
Is the expansion meant to be unconditional?  pskb_expand_head() has no
"headroom is already sufficient" fast path:

net/core/skbuff.c:pskb_expand_head() {
	data = kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
	...
	memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head);
	...
		skb_free_head(skb);
	...
	skb->truesize += size - osize;
}

nhead is additional headroom, so every received frame now takes a
kmalloc + memcpy + free even though in-tree channels already reserve
headroom, for example:

drivers/net/ppp/ppp_async.c:ppp_async_input() {
			if (buf[0] != PPP_ALLSTATIONS)
				skb_reserve(skb, 2 + (buf[0] & 1));

That skb_reserve() also arranges 4-byte payload alignment, which the
unconditional reallocation discards.  The call also sits before the
proto == PPP_COMP test, so it runs for frames that never dereference
skb->data - 2 at all (the else branch only calls ->incomp() when
ppp->rcomp->incomp is non-NULL).

Separately, does a transient GFP_ATOMIC failure here have larger
consequences than dropping one frame?  The failure funnels into:

 err:
	ppp->rstate |= SC_DC_ERROR;
	ppp_receive_error(ppp);

and the caller only enters the decompressor while that bit is clear:

drivers/net/ppp/ppp_generic.c:ppp_receive_nonmp_frame() {
	if (ppp->rc_state && (ppp->rstate & SC_DECOMP_RUN) &&
	    (ppp->rstate & (SC_DC_FERROR | SC_DC_ERROR)) == 0)
		skb = ppp_decompress_frame(ppp, skb);

SC_DC_ERROR is only cleared from ppp_ccp_peek() via

				ppp->rstate &= ~SC_DC_ERROR;

so one momentary atomic allocation failure appears to disable receive
decompression for the whole link until a CCP Reset round trip.  Would
skb_cow_head(skb, 2), or an explicit

	if (skb_headroom(skb) < 2 && pskb_expand_head(skb, 2, 0, GFP_ATOMIC))

placed inside the branch that actually uses skb->data - 2, avoid both the
per-packet copy and the new sticky failure mode?

[Severity: Medium]
Are the two new headroom bytes ever initialised?  pskb_expand_head()
allocates with kmalloc_reserve() (no __GFP_ZERO) and copies the old head
to data + nhead, so data[0] and data[1] are never written.  Afterwards
skb->data == data + 2 + old_headroom, so when the incoming skb had less
than 2 bytes of headroom, skb->data - 2 points into that uninitialised
prefix, and that is exactly the case this change exists to handle.

Those bytes are then handed to the decompressor as the PPP
Address/Control octets:

		/* the decompressor still expects the A/C bytes in the hdr */
		len = ppp->rcomp->decompress(ppp->rc_state, skb->data - 2,
				skb->len + 2, ns->data, obuff_size);

and in the uncompressed branch to:

		if (ppp->rcomp->incomp)
			ppp->rcomp->incomp(ppp->rc_state, skb->data - 2,
					   skb->len + 2);

bsd_decompress() consumes them and copies them into the output header:

    adrs  = PPP_ADDRESS (ibuf);
    ctrl  = PPP_CONTROL (ibuf);

z_decompress() and mppe_decompress() do the same.  Headroom below 2 is
reachable on the tty path: ppp_async_input() skips skb_reserve() when the
frame starts with PPP_ALLSTATIONS, process_input_packet() pulls the two
A/C bytes leaving headroom 2, and then a PFC-compressed protocol field
consumes one more byte in __ppp_decompress_proto():

	if (ppp_skb_is_compressed_proto(skb))
		*(u8 *)skb_push(skb, 1) = 0x00;

Should the two bytes be filled with PPP_ALLSTATIONS/PPP_UI after the
expansion, so the decompressors read the header the comment says they
expect?

> @@ -2576,7 +2577,7 @@ ppp_decompress_frame(struct ppp *ppp, struct sk_buff *skb)
>  		/* the decompressor still expects the A/C bytes in the hdr */
>  		len = ppp->rcomp->decompress(ppp->rc_state, skb->data - 2,
>  				skb->len + 2, ns->data, obuff_size);
> -		if (len < 0) {
> +		if (len < PPP_HDRLEN) {
>  			/* Pass the compressed frame to pppd as an
>  			   error indication. */
>  			if (len == DECOMP_FATALERROR)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919215233.3470411-1-benquike%40gmail.com
