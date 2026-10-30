Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348167;
	b=Vrxvujxz3W3YsibuJie3ANqLQL7RycXh64TSI2QobVaq0QdZZgItzMwjbvF/C1s1/3i0
	 E39XhygRlc899kXCW9lRF3lCHkp82I+5Bzu/dySFcFX3+s7uYgx2SCvab2VG4mxxXk1C7
	 dLlVR4mtngeXfiJh2hLJ5JXwVdmoWAOr3Wdh5/OWo82zRFZW4QBgc3vO3MnmFQq2Aawck
	 dxhAcIP39afJDC1PubnJZ4H6SGl27YXB1rlsHb+QQOT+futqvML70vIOMse8xM8FWUtZB
	 9s+wDaq+13jIt/mzWfoVWL4LnpMTS5VPTqbOImrHy14qkVex/VgYPnFtyIviE/O3RMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348167;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=/PaVSjeSQRSK2qgEu4XO4uQDUi946Ffm/D8x8LA2dic=;
	b=D9NlhAdy7/qfYbp5Rp1GpUHnJMXb2nmV7mwX8MW/VPk/jhw2n4KhpjtjaKyHs3wODofp
	 f+9cc4r9q8Rfkx+kfi49yvLsvzNteC8jW8N73Ugi48FCrD04I1N2xzCzAwQY5jPD/mtdU
	 Sm0FOV198baLdCkcYRNM3fdoO5X/9L7yrPfrEWfEsxuBn6MMaLfJsYkysVKRXEXnMSInT
	 /Pa2/nurRQQMJLmCOPyDQnFAoDjmB0KiHdjHC80ffplYL8j0P+t1Iec+oXR/ZsoLYbtYK
	 Phq8+5uP4zdxZbChr2FFh40+hWm/H175iQV/RGKvc5uh5YAU+BsahXb4d2Ydxqqkwdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUmXPU79;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9206B606A31A;
	Fri, 30 Oct 2026 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUmXPU79
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D971F000C1;
	Fri, 30 Oct 2026 08:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793348167;
	bh=/PaVSjeSQRSK2qgEu4XO4uQDUi946Ffm/D8x8LA2dic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QUmXPU79RLk/XiMnnRQIkP3hzrS9cTnPxiDzgjuOmfSfJtXBX7Z9ZV1rKTfSl7ySn
	 8Vape0TX2kWK8OLgZs+Of9x92XsS1SgpnCniJGBwuEvy1cJWXcGhRtKGTRFl3jgzg/
	 ByPiIKjtnGU139ByoZp3Gr7vA/LR8EzwK5zjfaNsRGy5BCPA8CM8M9UFfxu2l65Sdx
	 hQHVrznbtIjGibMo/anVARvobmEYj3UO5uNOjer0ZXrlBoMAVrjQaroQMYU+SR7rFt
	 djEFXck+ECUxSOwtyI44lD72Frj3tTP6dcdeMUJ6PuqYVSH+zyXAQhh7eAFx3546fX
	 OfMRTFl1FO31w==
Date: Fri, 30 Oct 2026 08:16:02 +0000
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev-bot+sashiko@kernel.org, rosenp@gmail.com, netdev@vger.kernel.org,
	rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, nbd@openwrt.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: bgmac: fix oversized RX frame check
Message-ID: <20261030081602.GL257209@horms.kernel.org>
References: <20261028011035.49201-1-rosenp@gmail.com>
 <179323634946.3134.7111348485490827533@kernel.org>
 <20261029152249.GI257209@horms.kernel.org>
 <7e73f5e5-b09d-4fbd-ae72-417115f1d4f2@broadcom.com>
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
In-Reply-To: <7e73f5e5-b09d-4fbd-ae72-417115f1d4f2@broadcom.com>

On Thu, Oct 29, 2026 at 09:19:53AM -0700, Florian Fainelli wrote:
> On 10/29/26 08:22, 'Simon Horman' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> > On Thu, Oct 29, 2026 at 01:12:29AM +0000, netdev-bot+sashiko@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 3 potential
> > > issue(s) to consider.
> > > 
> > > Critical: 0 · High: 2 · Medium: 1 · Low: 0
> > > 
> > > If you believe none of the issues are legitimate, please reply to each
> > > issue of Medium severity or higher and explain why the AI is wrong.
> > > If any of them are legitimate and you plan to respin, please let patchwork
> > > know by including "pw-bot: cr" as a separate line at the end of your reply
> > > (one such reply per series is enough).
> > > 
> > > - [High] The fix only tightens the upper bound of the RX length check in
> > >    bgmac_dma_rx_read() (drivers/net/ethernet/broadcom/bgmac.c).
> > > - [High] bgmac_dma_rx_read() loses track of the RX descriptor ring when a
> > >    frame spans more than one descriptor, and a remote sender can then…
> > > - [Medium] The commit message rests on the premise that 'a valid frame is
> > >    at most BGMAC_RX_MAX_FRAME_SIZE bytes long' (1536 including FCS).
> > > 
> > > --
> > > 
> > > net: bgmac: fix oversized RX frame check
> > > 
> > > This patch changes the RX length sanity check in bgmac_dma_rx_read(). The
> > > length from the RX header is now compared against BGMAC_RX_MAX_FRAME_SIZE
> > > instead of BGMAC_RX_ALLOC_SIZE. The intent is to drop frames with a
> > > corrupted length instead of hitting skb_over_panic() in the following
> > > skb_put().
> > > 
> > > > diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> > > > index b3a92ae95de30..6873c7bb7a141 100644
> > > > --- a/drivers/net/ethernet/broadcom/bgmac.c
> > > > +++ b/drivers/net/ethernet/broadcom/bgmac.c
> > > > @@ -455,7 +455,7 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
> > > >   				break;
> > > >   			}
> > > > -			if (len > BGMAC_RX_ALLOC_SIZE) {
> > > > +			if (len > BGMAC_RX_MAX_FRAME_SIZE) {
> > > 
> > > [Severity: High]
> > > 
> > > Should this check also have a lower bound?
> > > 
> > > len is a u16 read directly from the RX header. A value of 0..3 passes both
> > > the 0xdead/0xbeef poison check and this upper-bound check. Further down in
> > > bgmac_dma_rx_read():
> > > 
> > > 	/* Omit CRC. */
> > > 	len -= ETH_FCS_LEN;
> > > 
> > > 	skb = build_skb(buf, BGMAC_RX_ALLOC_SIZE);
> > > 	...
> > > 	skb_put(skb, BGMAC_RX_FRAME_OFFSET +
> > > 		BGMAC_RX_BUF_OFFSET + len);
> > > 
> > > The subtraction wraps len to 65532..65535. skb_put() then asks for about
> > > 64KiB, but build_skb() only provided
> > > SKB_DATA_ALIGN(BGMAC_RX_BUF_SIZE + BGMAC_RX_BUF_OFFSET) bytes of linear
> > > space. skb->tail ends up past skb->end, and skb_over_panic() calls BUG().
> > > 
> > > Isn't this the same "corrupted length leads to skb_over_panic()" case that
> > > the commit message describes?
> > > 
> > > Lengths 4..17 also get through. They produce an skb shorter than an
> > > Ethernet header, and eth_type_trans() then reads the header from bytes past
> > > the end of the received data.
> > > 
> > > Would it work to also reject len < ETH_HLEN + ETH_FCS_LEN (or at least
> > > len < ETH_FCS_LEN) in the same rx_length_errors branch?
> > 
> > The problem above does seem legit to me.
> 
> Yes it is legitimate, the absolute minimal size should be ETH_FCS_LEN, but
> that's basically a zero-sized Ethernet frame after stripping the FCS, not
> very useful. I suppose ETH_HLEN + ETH_FCS_LEN would be more reasonable here.

Yes, agreed.

...
