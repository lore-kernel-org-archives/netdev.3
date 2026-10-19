Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AB306779;
	Mon, 19 Oct 2026 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792372503; cv=none; b=CtOglvu9BrcnqI/KcQoLq8cVk8IXltnknPqs51Oar3pDSzk6AKuB7gRsiuazxwD/viprKgM+Yy6P0nyLTwitIYuONAs0v4dBpXbcHZERWwb/fS96H0bRwERhA+A0rhipULqamc4W0lFULk2vxexzE8IV8umeXYrc4Pohq0Xe4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792372503; c=relaxed/simple;
	bh=UztUbO2By+ISyXZ2injbZLT1l45VetfgYZZXX8Cmr+4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FslfSzMF89CXm69OdI2fqzmqScKkgMqs+kJsTcpRKlFH3GbCeLxbB90khS1+9/RtipdEJ7kmhADWMEhOcaf8/jPZsBCnPnlwHeJdqAhU96qQKzDRQS5x9c5BrLbDE0IsMeGIZIr0F1HwtT5JNy3D+dfC3RdQhMIrI+Dyrhe1EVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvxQRLpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvxQRLpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADD61F01805;
	Mon, 19 Oct 2026 01:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792372501;
	bh=VMrPYgQOnHoRCsJRMybAjl9VgrvC68NCuecjpo4tI/0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PvxQRLpwPW2b59Oixz3o4O2lwA1yYliuXII7Qn6XItBLKGwNSI57q0qrAtTi4lSvN
	 XWYgk8Yg+HHVfHn/uVwqc2Ez0TfE6WxktzuuhkBYMu65M0Cr1VNLlASYSFNa3RO15L
	 biBFTjc+KvcTbDFic/glOvduaELxGiX+wxErmo5a98DvdzVEB+zbT4N0Ecyzv7RsJF
	 lGhfvQRytV9XCWtw36Ka78sH5lcePm+DEy74eCzeW206cAfgaLUYwbGV9USbrXgvfc
	 6F/mkMeYBXhCS9GQ7sd+LRRViKkxMRjynmKxjl4kFkCDuZScrPOtoy5PXU4CWP93mp
	 efAgwobsvR09Q==
Subject: Re: [PATCH net-next] net: octeon: Fix dma_unmap_single() size
From: netdev-bot+sashiko@kernel.org
To: fourier.thomas@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, kory.maincent@bootlin.com,
 vadim.fedorenko@linux.dev, ddaney@caviumnetworks.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 01:15:00 +0000
Message-ID: <179237250044.3135.9983843486106038084@kernel.org>
In-Reply-To: <20261015131336.34801-1-fourier.thomas@gmail.com>
References: <20261015131336.34801-1-fourier.thomas@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fix the size mismatch it claims to fix.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  octeon_mgmt_stop()…
- [Medium] This problem wasn't introduced by this patch, but the RX
  descriptor `len` field is only 14 bits (max 16383), while the MTU can…

--

net: octeon: Fix dma_unmap_single() size

The commit changes the RX buffer unmap size in
octeon_mgmt_dequeue_rx_buffer() from ETH_FRAME_LEN +
OCTEON_MGMT_RX_HEADROOM to re.s.len. The goal is to match the size used
when the buffer was mapped in octeon_mgmt_rx_fill_ring().

> diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
> index 2cf3365b96364..1bb1316f4b919 100644
> --- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
> +++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
> @@ -380,9 +380,7 @@ static u64 octeon_mgmt_dequeue_rx_buffer(struct octeon_mgmt *p,
>  	p->rx_current_fill--;
>  	*pskb = __skb_dequeue(&p->rx_list);
>  
> -	dma_unmap_single(p->dev, re.s.addr,
> -			 ETH_FRAME_LEN + OCTEON_MGMT_RX_HEADROOM,
> -			 DMA_FROM_DEVICE);
> +	dma_unmap_single(p->dev, re.s.addr, re.s.len, DMA_FROM_DEVICE);

[Severity: High]
Does re.s.len still hold the mapped size here?

re.d64 is read from p->rx_ring[] after the MIX engine has written back
the completed descriptor. The caller treats len as the number of bytes
received:

octeon_mgmt_receive_one() {
    re.d64 = octeon_mgmt_dequeue_rx_buffer(p, &skb);
    if (likely(re.s.code == RING_ENTRY_CODE_DONE)) {
        /* A good packet, send it up. */
        skb_put(skb, re.s.len);
    ...
}

The RING_ENTRY_CODE_MORE path does the same with re2.s.len. The code
field also changes from 0 (written by the driver) to DONE, MORE or an
error value. That suggests the hardware rewrote the whole 64-bit entry.

The buffer was mapped in octeon_mgmt_rx_fill_ring() with:

    size = netdev->mtu + OCTEON_MGMT_RX_HEADROOM + 8 + NET_IP_ALIGN;
    ...
    re.s.len = size;
    re.s.addr = dma_map_single(p->dev, skb->data,
                               size,
                               DMA_FROM_DEVICE);

At MTU 1500 the mapping is 1532 bytes. For a minimum-size frame, this
would unmap only about 60 bytes of it. On error entries the size is
whatever the hardware reported.

With CONFIG_DMA_API_DEBUG, would check_unmap() report a size mismatch on
almost every received packet? And with swiotlb=force, would only len
bytes be bounced back?

The TX side's dma_unmap_single(..., re.s.len, DMA_TO_DEVICE) works
because TX entries keep the length the driver wrote. RX entries don't.

Recomputing the size from netdev->mtu at dequeue time wouldn't work
either. The RING_ENTRY_CODE_MORE comment says buffers sized for an older
MTU can stay in the ring after an MTU change.

The len field is also only 14 bits wide, so even the fill-time value is
truncated for MTUs of 16352 and above.

Could the mapped length be recorded per ring slot instead? For example,
octeon_mgmt_rx_fill_ring() could store it in a shadow array indexed by
ring position.

>  
>  	return re.d64;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but octeon_mgmt_stop() frees
the remaining RX and TX buffers without unmapping them:

drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:octeon_mgmt_stop() {
    ...
	/* dma_unmap is a nop on Octeon, so just free everything.  */
	skb_queue_purge(&p->tx_list);
	skb_queue_purge(&p->rx_list);
    ...
}

Are the DMA_FROM_DEVICE mappings from octeon_mgmt_rx_fill_ring() and
the DMA_TO_DEVICE mappings from octeon_mgmt_xmit() leaked on every
ifdown? The RX ring is normally kept full, so posted buffers are always
there at that point.

With the coherent dma-direct setup on Octeon, unmap is close to a no-op.
However, CONFIG_DMA_API_DEBUG would report the leaked mappings, and
swiotlb=force would leak bounce slots over repeated ifup/ifdown cycles.

[Severity: Medium]
This is also a pre-existing issue, not introduced by this patch. Can
size overflow the 14-bit len field in octeon_mgmt_rx_fill_ring()?

octeon_mgmt_probe() sets:

	netdev->max_mtu = 16383 - OCTEON_MGMT_RX_HEADROOM - VLAN_HLEN;

which is 16383 - 22 - 4 = 16357.

octeon_mgmt_rx_fill_ring() then computes:

	size = netdev->mtu + OCTEON_MGMT_RX_HEADROOM + 8 + NET_IP_ALIGN;

which is mtu + 32, or 16389 at max_mtu.

For MTUs from 16352 to 16357, re.s.len = size wraps modulo 16384 (to 5
at max_mtu). dma_map_single() still maps the full size.

Wouldn't the hardware then be told the buffer is only a few bytes long?
Large frames could be split across many MORE entries or dropped as
errors. The exact effect depends on how the MIX hardware uses the
length it is given.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015131336.34801-1-fourier.thomas%40gmail.com
