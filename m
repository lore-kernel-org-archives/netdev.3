Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0137754C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830741; cv=none; b=dHXVizmpL/Jwp6EmgsT1l2gvrauCb2UFBv+BlnFiIneEPon/Foc8l/UOCUxtaMy5WH3yHYwB7lJtaXdJICKafvP+efUzl8pYsmuf2vrx0x3BVsT6Z9nqxbwduq+/4fMm0j930MX89Ovu2NQ+t429az7pwMZB60ttvPshbR0TQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830741; c=relaxed/simple;
	bh=TBZqYx33HE3ih+WWK+uF+GxXbEdmKzLOnlyNfWJ4Jfw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUd40rUA5G7fW+ReqjOOwFV9TX5J0GYVjT7h5GUX3TVZKweg9J96XZj2SP3pimsVGApGDaEiDHxaq/2eA1rhQ1PPFM/xaEO4cdMqk1s3Xw2I/behI9gux8P8J20jO/RUgI4gznUh0Lf9F5jYRJcD8eQwW8qjBlCiVi3197SsGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXAjMLoi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXAjMLoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214251F008A3;
	Mon, 12 Oct 2026 18:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830737;
	bh=QD+LVVWBRcflMS7lbWq2ZwtMpYdHv2mT0wAAzbX2y6c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GXAjMLoi2q9cAfxTLyG5I17vy7Lnds+yrX8+7pSQ+4PKvo6yXUxs4+eZx2xcuzyyL
	 1li0omVBiQDGxM01wJ8ZCeixkuSguQLUBkebJjEWSpwOMxXr6IALIOHSzTltx9nqSN
	 OiTdaUhIpFQEnbWKHc0FTioMob8yrGvAgE/b40oKX0thFsRoPQb01cDD3EQOGQ0O9J
	 G5Hrear8QitO7s/0fKrw4T+0KTAphebhVrzg2OWylNwpgDiwwPHirG9KRpci3t9V5c
	 7OLGIGLn14cOYyF2HPSf6Xdq60E23xD+wR7jMPO9B4bqoKy4qSRxePnsTPCopxtMQD
	 t2mHPBoIh+6Zg==
Subject: Re: [PATCH net-next v4 11/15] net: ethernet: cortina: Validate RX
 fragment lengths
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:36 +0000
Message-ID: <179183073671.434549.15826123693290172054@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-11-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-11-4b1631b08f5d@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: gmac_rx() drops entire valid packet on zero-length EOF
  fragment
- [Low] The commit describes itself as a bug fix and has no Fixes: tag.
- [Low] The patch makes RX word0.bits.buffer_size a strict byte-length
  bound on every EOF descriptor.

--

net: ethernet: cortina: Validate RX fragment lengths

This patch adds bounds checks on RX descriptor lengths in gmac_rx(). It
rejects short initial fragments, frame length underflow and fragments that
extend past the DMA fragment or the page. Zero-length fragments are now
dropped instead of being appended to the skb.

> Reject a short initial fragment before applying NET_IP_ALIGN, reject frame
> length underflow and ranges extending beyond either the DMA fragment or the
> page, and drop zero-length fragments instead of adding them to the skb.

[Severity: Low]
Should this patch carry a Fixes: tag?

Three of the issues addressed here appear to date back to the original
driver:

  - the unchecked frag_len -= NET_IP_ALIGN
  - the unsigned underflow in frag_len = frame_len - skb->len
  - zero-length fragments that are logged but still appended

That would make the tag:

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

Other patches in the same series, such as "Keep shared free queue
parent-owned" and "Correct free queue DMA mappings", already carry this
tag.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 943c31c026743..d8bafcdf4d5f1 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -1811,6 +1812,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			if (!skb)
>  				goto err_drop;
>  
> +			if (frag_len < NET_IP_ALIGN)
> +				goto err_drop;
> +
>  			page_offs += NET_IP_ALIGN;
>  			frag_len -= NET_IP_ALIGN;
>  			frag_nr = 0;
> @@ -1819,15 +1823,28 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			goto err_drop;
>  		}
>  
> -		if (word3.bits32 & EOF_BIT)
> +		if (word3.bits32 & EOF_BIT) {
> +			if (frame_len < ETH_ZLEN ||
> +			    frame_len < skb->len ||
> +			    frame_len - skb->len > frag_len)
> +				goto err_drop;
>  			frag_len = frame_len - skb->len;
> +		}

[Severity: High]
Does this drop more than the commit message says it does?

The message says zero-length fragments are dropped instead of being
added to the skb. The goto err_drop does not skip just that fragment.
It calls napi_free_frags() on the whole skb assembled so far, puts the
page and increments rx_dropped.

Consider a multi-descriptor frame where the earlier descriptors
already carry all of the data. One example is a frame that exactly
fills the first free queue fragment after the NET_IP_ALIGN offset,
which is 2046 bytes with the default 2 KiB fragment.

If the hardware then closes the chain with an EOF descriptor that
carries no new data, frame_len equals skb->len. The new EOF checks
all pass and frag_len becomes frame_len - skb->len == 0. gmac_rx()
then lands in the !frag_len branch.

Before this patch that frame was handed to napi_gro_frags() with an
empty trailing fragment. After it, a complete and valid frame is
discarded and counted as rx_dropped. Nothing later in the series
seems to change this.

Can the Gemini DMA engine emit such a trailing descriptor at the end
of a chain?

If it can, the EOF case with nothing left to append could be handled
separately: put_page() the unused fragment and still pass the skb to
napi_gro_frags(). err_drop would then be kept for zero-length
descriptors in the middle of a chain. Note that the
frag_nr == MAX_SKB_FRAGS check runs first, so an empty EOF arriving
after a full frags array would also discard the frame unless that
case is handled before it.

[Severity: Low]
Before this patch, gmac_rx() never used word0.bits.buffer_size on an EOF
descriptor, because frag_len was always overwritten with
frame_len - skb->len. Now buffer_size on every EOF descriptor is a strict
byte bound on whether the frame gets delivered.

For a single-descriptor (SOF|EOF) frame, the NET_IP_ALIGN subtraction plus
this check now require:

    buffer_size >= frame_len + NET_IP_ALIGN

What guarantees that the hardware reports buffer_size this way? The driver
never writes buffer_size into free queue entries. geth_freeq_post_page()
and geth_setup_freeq() only set word2.buf_adr, so the hardware supplies the
value.

The only in-tree definition, in gemini.h, describes the field as a
descriptor count:

union gmac_rxdesc_0 {
	...
		/* bit 15:0 number of descriptors used for the current frame */
		unsigned int buffer_size:16;
		/* bit 21:16 number of descriptors used for the current frame */
		unsigned int desc_count:6;

That comment looks copied from desc_count. It doesn't say whether the value
includes the bytes inserted via rd_insert_bytes = NET_IP_ALIGN in
gmac_start_dma(). It also doesn't say how the field is filled on an EOF
descriptor that is not the SOF.

If buffer_size excluded the inserted bytes, wouldn't every
single-descriptor frame be dropped?

There is a second case with an MTU above 1530, where frames span multiple
descriptors. If buffer_size is filled differently on the last descriptor,
could good jumbo frames be silently counted as rx_dropped?

The DIR-685 testing at standard MTU suggests the SOF|EOF case works. The
commit message also says:

  "validated against the Gemini receive descriptor definitions"

The in-tree definitions don't seem to support that. Could the buffer_size
comment in gemini.h be corrected to describe the byte-length semantics this
patch now relies on, including whether the NET_IP_ALIGN bytes are counted?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
