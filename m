Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C306334C39
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789342376; cv=none; b=ZNezu6tFUcPc5HCpE/RJLQet6jOFqWendnIxXCY63gmAZlyBfo2rm8cW8K+axAz9KQmyesKQcSTYf1poEtXXEk+MjJbUZto7Yx9Xh8zSpNDmXXhRyBJi2QFQHLO5gCpuhW6OuBCaEcOptWZOLbpSyQBVGUOTLgd1NEpqfZr0HxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789342376; c=relaxed/simple;
	bh=+RhrkwA9SvjlL/qkgM54FFpL3XaKOfHyLAPjmc6RTG0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OkWSm8ZR/rBez7bgbKHB6xrcPYwzxB7cqxYTIdrr+tmAsaE6WH70uKI93MXZ6S7Iis2f0VaYwjGdd4/pv6rJU0UwhR9PQIgO13pvxdPOjcS+zIyJNvoZIbkwO01VUr+68WUtUeunpdEokkCgqcA8yVF2k6lpKE73kzqx8XpC1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PB9MhBJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PB9MhBJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00581F000FF;
	Sun, 13 Sep 2026 23:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789342375;
	bh=hrMHvaHbz/HvkHKSKgRBpKKMUD0lMaEjny6uZVNAA9Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PB9MhBJ6tT4fWcCjSf7mTHYxec2ZuWuVaTHmNsup4tvmB3dNUUzNAtJfNc4w2yWEf
	 ZpbP/FJJYAfX5TBD69w+ScXIvVqdJooOiJM9uFsWdf15CPQdt67dCAemoIxND59+a6
	 nUWW/zlS0a7C3TPYGMTxZfzqw7gTzVnNovT+UauQnXsLlAmyZlhCpGTor3uLVfRbzB
	 azLRyICPeHkz4Cp/aX9xbxodyWgse6ryeJoZ2deJMp3K7LDXTSMvxxf/iHg+HaFaez
	 DkUcCcVeSUoJe/ctAAegrzqkqGBsOoaHX1RN5a2aNbGK4M/sARDsvrCftKldjwBzCH
	 a7XeWsgajIfUA==
Subject:
 Re: [PATCH v2 net] pppoatm: ensure a writable skb header and linear data
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, mitch@sfgoth.com,
 3chas3@gmail.com, qingfang.deng@linux.dev
Date: Sun, 13 Sep 2026 23:32:54 +0000
Message-ID: <178934237420.22033.12474248772012953233@kernel.org>
In-Reply-To: <20260912233048.3977192-1-edumazet@google.com>
References: <20260912233048.3977192-1-edumazet@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

- [High] pppoatm_send() does not make the frame linear, although the
  commit subject claims to "ensure a writable skb header and linear…

Pre-existing issues:
- [Low] net/atm/pppoatm.c never initialises pvcc->chan.hdrlen although
  the channel requires LLC_LEN (4) bytes of headroom for e_llc…

--

pppoatm: ensure a writable skb header and linear data

pppoatm_send() now uses skb_cow_head() to get a writable header with room
for the LLC header, adds a pskb_may_pull(skb, 1) before looking at
skb->data[0], and defers the SC_COMP_PROT pull plus the LLC push until
after pppoatm_may_send() has succeeded, dropping the old "undo" heuristic.

A couple of questions about the linearity claim and about the channel
headroom hint.

> diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
> index 6da52d12df68e..5214786e61d11 100644
> --- a/net/atm/pppoatm.c
> +++ b/net/atm/pppoatm.c
> @@ -292,10 +292,13 @@ static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
>  	struct atm_vcc *vcc;
>  	int ret;
>  
> +	if (!pskb_may_pull(skb, 1)) {
> +		kfree_skb(skb);
> +		return DROP_PACKET;
> +	}
> +

[Severity: High]
The subject says "linear data" and the changelog says this pull is there
"to prevent out-of-bounds reads on zero-length or non-linear frames
(e.g. from bridging)", but does this pull actually make the frame linear?
pskb_may_pull(skb, 1) only guarantees the single byte read as
skb->data[0]; skb_cow_head() -> __skb_cow() -> pskb_expand_head()
unshares and grows the head but leaves the paged fragments in place.

So a frame with skb->len > skb_headlen(skb) still reaches the device
send op further down this function:

	ret = ATM_SKB(skb)->vcc->send(ATM_SKB(skb)->vcc, skb)
	    ? DROP_PACKET : 1;

vcc->send is the device op (net/atm/raw.c does
vcc->send = vcc->dev->ops->send), and nothing under drivers/atm/
references nr_frags, skb_headlen or skb_linearize. For example
solos-pci psend() takes pktlen = skb->len and fpga_tx() then does:

	memcpy_toio(TX_BUF(card, port), skb->data, skb->len);

or, in the DMA case:

	dma_map_single(..., data, skb->len, DMA_TO_DEVICE);

For a paged skb, can this read past the end of the linear head buffer
and put unrelated heap bytes on the wire (and map a length larger than
the mapped object)?

The bridging path the changelog cites is the one that can deliver such a
frame: ppp_input() calls ppp_channel_bridge_input() before any
normalization, and the bridge hands the received skb to the peer channel
verbatim:

drivers/net/ppp/ppp_generic.c:ppp_channel_bridge_input() {
	...
	skb_scrub_packet(skb, !net_eq(pch->chan_net, pchb->chan_net));
	if (!pchb->chan->ops->start_xmit(pchb->chan, skb))
	...
}

The source channels do not linearize either (pppoe_rcv() only does
pskb_may_pull(skb, sizeof(struct pppoe_hdr)) before ppp_input(), and
l2tp_ppp.c is similar), while the normal ppp_start_xmit() path is linear
because the ppp netdev has no SG offload. Would skb_linearize() (or
pskb_may_pull(skb, skb->len)) here be the intended fix, or should the
subject and changelog be reworded so that backporters do not conclude
non-linear bridged frames are now handled?

> @@ -317,23 +320,13 @@ static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
>  
>  	switch (pvcc->encaps) {		/* LLC encapsulation needed */
>  	case e_llc:
> -		if (skb_headroom(skb) < LLC_LEN) {
> -			struct sk_buff *n;
> -			n = skb_realloc_headroom(skb, LLC_LEN);
> -			if (n != NULL &&
> -			    !pppoatm_may_send(pvcc, n->truesize)) {
> -				kfree_skb(n);
> -				goto nospace;
> -			}
> -			consume_skb(skb);
> -			skb = n;
> -			if (skb == NULL) {
> -				bh_unlock_sock(sk_atm(vcc));
> -				return DROP_PACKET;
> -			}
> -		} else if (!pppoatm_may_send(pvcc, skb->truesize))
> +		if (skb_cow_head(skb, LLC_LEN)) {
> +			bh_unlock_sock(sk_atm(vcc));
> +			kfree_skb(skb);
> +			return DROP_PACKET;
> +		}
> +		if (!pppoatm_may_send(pvcc, skb->truesize))
>  			goto nospace;
> -		memcpy(skb_push(skb, LLC_LEN), pppllc, LLC_LEN);
>  		break;

[Severity: Low]
This isn't a bug introduced by this patch, since the previous code did the
same reallocation via skb_realloc_headroom() and dropped on failure, but
would it be worth setting pvcc->chan.hdrlen while touching this?

pppoatm_assign_vcc() sets chan.private, chan.ops and chan.mtu, and even
subtracts LLC_LEN from the MTU, but leaves chan.hdrlen at 0 (pvcc is
kzalloc'ed):

	pvcc->chan.private = pvcc;
	pvcc->chan.ops = &pppoatm_ops;
	pvcc->chan.mtu = atmvcc->qos.txtp.max_sdu - PPP_HDRLEN -
	    (be.encaps == e_vc ? 0 : LLC_LEN);

include/linux/ppp_channel.h documents the field as:

	int		hdrlen;		/* amount of headroom channel needs */

and ppp_generic honours it, e.g. in ppp_write():

	skb = alloc_skb(count + pf->hdrlen, GFP_KERNEL);
	if (!skb)
		goto out;
	skb_reserve(skb, pf->hdrlen);

With hdrlen left at 0, frames written directly to the channel fd and
multilink fragments arrive with no headroom, so the new
skb_cow_head(skb, LLC_LEN) has to run a full pskb_expand_head() with
GFP_ATOMIC inside the bh_lock_sock() section for every such frame, and
drops the packet if that allocation fails. Setting
pvcc->chan.hdrlen = LLC_LEN for the non-e_vc encapsulations would make
the common case a no-op.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912233048.3977192-1-edumazet%40google.com
