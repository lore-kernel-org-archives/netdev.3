Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287374;
	b=MARhQGdFvju7agZS4dgh+5ApDwwuL3RqXew03hYYoRI/cbVszvzVTjsJHqafFqi9H0zq
	 G1sJJyy3O4JdO0tNV6VshwoXoPkYvAarzyBJHwatsBiewquCZ3S43TxKSnAkQTYzZgt3q
	 TC3WdjM8RlM6P94Lc4U5FAteUTwOjs7tRUdJxJYJC2FPt/YMgAIWWJfqzTZeLTlOK6E6p
	 6OpubkqUvNvBMT+LCjJ/6PhL+hANYTDR5ErabWSMzb/IhdhjS0xkypN+fWP17cghPJJW+
	 xF1WhUWnjarX+MS7/UgfwXxK5lXNppB7pdbaTKaZS5ANOQi8ImdQLgrDI9FLBAVEoyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287374;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=RCUDrEpIT2IvdnVVG1nY06CRd9IuL0zGxbHUihdyeIE=;
	b=DC4RuU+vOCHjEC28W2z6ODR/f3CY8QsaC3TGifNz/jzU1sCGj10Gqre7kVYEF0O2MLoL
	 HJ7s7sbn+0FNYPKKpLBLKHfJEitwnDJViFbuMTKKQzHQQif3l0ocOklxF2IisdJ6B8H9f
	 sUsvY46XLdHtYlbebJcrUDgnEXcJ7BJf/5pD8j3pdNaIyBmqqr6OhzXKNzpncBlUdm1ik
	 KZQ4isCpcXjiVGVnqa5YcNn6kWz6k/dd4xsFRtSW1OtP2bO6DkSZFtSt/nkQ0T9GFJU0O
	 sJwPJ8xWMqNOB0VpNA6QdrEhhlPXup2oh4kV+g37V5qfMYw9EoaSVt80DzZYSYY9jRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LV1soVb0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB98606A31C;
	Thu, 29 Oct 2026 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LV1soVb0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE971F01816;
	Thu, 29 Oct 2026 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793287373;
	bh=RCUDrEpIT2IvdnVVG1nY06CRd9IuL0zGxbHUihdyeIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LV1soVb0Hs2V6u7fdVNsnMxE10JaRyW3dhLIRjh0Y+S8S+pmk0X08ee7xlJT2LiDp
	 ai+M6gc3T3Zn6OBi8Si52kkYIZh/54CTHndMxWOW+u4m3n6oPPgEHuwYbfyKUOdkTU
	 C+MSZ18UGFO/JHSL9qwr8C46Yd/HTTgr3m3bdShailGdX4KFwiqeUEoXxnOnOHFl9M
	 LTnYqtzPmF3Y37p1RiMXd9Sp4S9TmdbGh77lilHFy4PwCd6Dk0g8YW6WLkZDrEzPQK
	 BPI5FQ8yIWmzupPZI9Qfmgrjlc8BqSasFQgSr6KV/S/xVhclUbyKeYsTGq3EmpcBx/
	 /Y266aJWHw+BQ==
Date: Thu, 29 Oct 2026 15:22:49 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: rosenp@gmail.com, netdev@vger.kernel.org, rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, nbd@openwrt.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: bgmac: fix oversized RX frame check
Message-ID: <20261029152249.GI257209@horms.kernel.org>
References: <20261028011035.49201-1-rosenp@gmail.com>
 <179323634946.3134.7111348485490827533@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179323634946.3134.7111348485490827533@kernel.org>

On Thu, Oct 29, 2026 at 01:12:29AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 2 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The fix only tightens the upper bound of the RX length check in
>   bgmac_dma_rx_read() (drivers/net/ethernet/broadcom/bgmac.c).
> - [High] bgmac_dma_rx_read() loses track of the RX descriptor ring when a
>   frame spans more than one descriptor, and a remote sender can then…
> - [Medium] The commit message rests on the premise that 'a valid frame is
>   at most BGMAC_RX_MAX_FRAME_SIZE bytes long' (1536 including FCS).
> 
> --
> 
> net: bgmac: fix oversized RX frame check
> 
> This patch changes the RX length sanity check in bgmac_dma_rx_read(). The
> length from the RX header is now compared against BGMAC_RX_MAX_FRAME_SIZE
> instead of BGMAC_RX_ALLOC_SIZE. The intent is to drop frames with a
> corrupted length instead of hitting skb_over_panic() in the following
> skb_put().
> 
> > diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> > index b3a92ae95de30..6873c7bb7a141 100644
> > --- a/drivers/net/ethernet/broadcom/bgmac.c
> > +++ b/drivers/net/ethernet/broadcom/bgmac.c
> > @@ -455,7 +455,7 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
> >  				break;
> >  			}
> >  
> > -			if (len > BGMAC_RX_ALLOC_SIZE) {
> > +			if (len > BGMAC_RX_MAX_FRAME_SIZE) {
> 
> [Severity: High]
> 
> Should this check also have a lower bound?
> 
> len is a u16 read directly from the RX header. A value of 0..3 passes both
> the 0xdead/0xbeef poison check and this upper-bound check. Further down in
> bgmac_dma_rx_read():
> 
> 	/* Omit CRC. */
> 	len -= ETH_FCS_LEN;
> 
> 	skb = build_skb(buf, BGMAC_RX_ALLOC_SIZE);
> 	...
> 	skb_put(skb, BGMAC_RX_FRAME_OFFSET +
> 		BGMAC_RX_BUF_OFFSET + len);
> 
> The subtraction wraps len to 65532..65535. skb_put() then asks for about
> 64KiB, but build_skb() only provided
> SKB_DATA_ALIGN(BGMAC_RX_BUF_SIZE + BGMAC_RX_BUF_OFFSET) bytes of linear
> space. skb->tail ends up past skb->end, and skb_over_panic() calls BUG().
> 
> Isn't this the same "corrupted length leads to skb_over_panic()" case that
> the commit message describes?
> 
> Lengths 4..17 also get through. They produce an skb shorter than an
> Ethernet header, and eth_type_trans() then reads the header from bytes past
> the end of the received data.
> 
> Would it work to also reject len < ETH_HLEN + ETH_FCS_LEN (or at least
> len < ETH_FCS_LEN) in the same rx_length_errors branch?

The problem above does seem legit to me.

> 
> [Severity: Medium]
> 
> The commit message says:
> 
>     so a valid frame is at most BGMAC_RX_MAX_FRAME_SIZE bytes long.
> 
> Does this match the limits the driver sets elsewhere?
> 
> bgmac_chip_init() programs the MAC with:
> 
> 	bgmac_umac_write(bgmac, UMAC_MAX_FRAME_LEN, 32 + ETHER_MAX_LEN);
> 
> That allows 1550 bytes. bgmac_change_mtu() writes 32 + mtu, which goes up
> to 1564. bgmac_enet_probe() also sets:
> 
> 	/* Omit FCS from max MTU size */
> 	net_dev->max_mtu = BGMAC_RX_MAX_FRAME_SIZE - ETH_FCS_LEN;
> 
> This leaves out ETH_HLEN and any VLAN/DSA tag, so a frame at MTU 1532 is at
> least 1550 bytes long.
> 
> With this patch, frames of 1537..1564 bytes that the MAC accepts are
> dropped here. They are logged as "Found oversized packet ... DMA issue!" and
> counted in rx_length_errors. Frames of 1537..1540 bytes, where only FCS bytes
> went past the buffer, used to be delivered intact.
> 
> bgmac_change_mtu() also never updates net_dev->mtu. The MTU the stack sees
> and the hardware limit can therefore drift apart.
> 
> Should UMAC_MAX_FRAME_LEN and max_mtu be derived from
> BGMAC_RX_MAX_FRAME_SIZE, so the MAC never accepts a frame larger than one RX
> buffer can hold?
> 
> [Severity: High]
> 
> Can a frame longer than one RX buffer put the ring out of sync here?
> 
> bgmac_dma_rx_setup_desc() sets up each descriptor with:
> 
> 	ctl1 |= BGMAC_RX_BUF_SIZE & BGMAC_DESC_CTL1_LEN;
> 
> That leaves room for 1536 frame bytes after the RX header. The MAC is
> programmed to accept up to 1550 bytes, or 1564 after bgmac_change_mtu().
> 
> b43 uses the same Broadcom DMA engine, and its dma_rx() handles this case
> explicitly:
> 
> 	if (unlikely(len + ring->frameoffset > ring->rx_buffersize)) {
> 		/* The data did not fit into one descriptor buffer
> 		 * and is split over multiple buffers.
> 
> b43 then recycles every slot the frame used, and brcmsmac chains
> continuation buffers in a similar way. Only the first descriptor carries the
> status header, and continuation data starts at offset 0 of the next buffer.
> This split-descriptor behavior is inferred from those sibling drivers, not
> from bgmac-specific documentation.
> 
> On the oversized path, bgmac_dma_rx_read() frees only the first buffer and
> advances ring->start by one. The next iteration reads the continuation
> descriptor as a new frame. Its rx->len and rx->flags are then frame bytes
> 1536..1539, which is payload the sender chooses.
> 
> If those bytes decode to a len of 0..3, len -= ETH_FCS_LEN wraps and
> skb_put() reaches skb_over_panic(). Other values produce frames built from
> stale buffer contents.
> 
> With the default UMAC_MAX_FRAME_LEN, can a single 1544..1550 byte frame
> from a LAN peer reach this panic?
> 
> For the fix to cover this, would it need to skip the continuation
> descriptors (as b43 does), keep UMAC_MAX_FRAME_LEN within the buffer
> capacity, and reject len < ETH_FCS_LEN?

But the one above seem speculative.

-- 
pw-bot: changes-requested
