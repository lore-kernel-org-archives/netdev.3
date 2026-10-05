Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B741686D;
	Mon,  5 Oct 2026 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236718; cv=none; b=nVpKg1OGPvBTKX7DMJOl0LU0/AXFQHyk3V15a7hBQZoHVj9W3NTgQF0EnaUR+em5lmFpoGeYR4s6IFdnw1efYj+boD+B4RkB7RJ7wgFslm1XdQCVhWhixCDmlQL3UaF3cjCXekQvkGiyBr4Z/Y6cEM2CC78j0md81tbPBNa5SQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236718; c=relaxed/simple;
	bh=8gEcWkv+0Q7gcS4pOQBwpbM4WCLOFCMgyYlbAQ1+Wp0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DM8k2cLEkUc2cU8XMiO6DpWpz48Idd0svJupN28DDbuCxw+Ruh1469iAwUJVFSO0rQ1hv4Ijk2oNq35LyYQV95LPKAeFi02irT6BF4vZMtaBqXbnAr3q9o7GqDY0GTn00lrOnMqImm6p5mC/syAkDe+Wx7RUQxkfX7T+ygPLTh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=lPFTpgI0; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="lPFTpgI0"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EC35A012B;
	Mon,  5 Oct 2026 23:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791236708; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=emNPbPPayPuD+OV6laaDKtkWv1u5znFoQHkOwV7vhGk=;
	b=lPFTpgI0Z6Oo0//Fbj5JBZFS9YM/ukHID4kldCSUiJBfb5mfPVitwDVfAAWlWPoKm2gUD9
	WRh8O/DNH5q8ixoeEOVQ895dOP9USiWDpIg8zRYTFdEnhRuQiSvUmaGy8ELzqFHLUFI/c4
	oVUewGZEAo/ii5SRNYhfcjWQc0QNHRHQ/lXz+nOUX6xINkQS04gOFK56zXXOrHHUT4VDLy
	d0yLSexxQ1Fi5wDUhhZOHXKhczZFWCWKAdF7p/6Q/SYDLDR/8JCgypPn9NH0DNYsXiY8VA
	DB2xeEkYlAQw0jIRUbpKE8Yxm8kLf+OZ26e5FlfEkU6+JsDucc536zdrUcEXlQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 23:45:05 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com
Subject: Re: [PATCH net-next 7/7] net: bcmgenet: reassemble jumbo frames from
 status block fragments
In-Reply-To: <179121268743.434549.11864751276782263505@kernel.org>
References: <20261002-nb-genet-mtu-nn-v2-v1-7-96dc6d54cbee@tipi-net.de>
 <179121268743.434549.11864751276782263505@kernel.org>
Message-ID: <e742656e267211a0d51f18308211116c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 5.10.2026 17:04, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let 
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your 
> reply
> (one such reply per series is enough).
> 
> - [High] bcmgenet: skb_trim() panics on non-linear jumbo frame SKBs
> - [Medium] This patch adds a TX checksum fallback in bcmgenet_xmit().
> - [Medium] The patch raises dev->max_mtu from the old ENET_MAX_MTU 
> (3564
>   on 4K pages, 3820 otherwise) to ENET_MAX_JUMBO_MTU = GENMASK(13,0) -…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but
>   bcmgenet_timeout() updates ring->stats64 without holding ring->lock.
> 
> --
> 
> net: bcmgenet: reassemble jumbo frames from status block fragments
> 
> This commit strips the per-descriptor status blocks from RX frames 
> longer
> than the packet ready threshold and reassembles them into one skb. It 
> also
> adds a software checksum fallback in bcmgenet_xmit() for 
> CHECKSUM_PARTIAL
> frames longer than tx_thld_len, and raises max_mtu to 
> ENET_MAX_JUMBO_MTU
> (16347).
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index 0cd56ec1c5ccf..62edbe51fe076 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> 
> [ ... ]
> 
>> @@ -2176,6 +2173,19 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>  		goto out;
>>  	}
>> 
>> +	/* The MAC holds a frame to insert its checksum, but only as much as
>> +	 * its FIFO takes. Longer frames are dropped silently.
>> +	 */
>> +	if (unlikely(skb->len > priv->tx_thld_len) &&
>> +	    skb->ip_summed == CHECKSUM_PARTIAL) {
>> +		if (skb_checksum_help(skb)) {
>> +			BCMGENET_STATS64_INC((&ring->stats64), dropped);
>> +			dev_kfree_skb_any(skb);
>> +			ret = NETDEV_TX_OK;
>> +			goto out;
>> +		}
>> +	}
>> +
> 
> [Severity: Medium]
> The new comment says the MAC silently drops CHECKSUM_PARTIAL frames 
> longer
> than tx_thld_len. Can that already happen before this patch?
> 
> An earlier patch in this series, "net: bcmgenet: pad transmit frames 
> out
> of the packet ready window", added bcmgenet_tx_pkt_rdy_thld():
> 
> 	while (thld > ENET_THLD_DEFAULT &&
> 	       ENET_MAX_FRAME_LEN(mtu) - ETH_FCS_LEN > thld * ENET_THLD_UNIT 
> &&
> 	       thld * ENET_THLD_UNIT + ENET_TX_SAFE_MARGIN > mtu + ETH_HLEN)
> 		thld -= ENET_THLD_BURST / ENET_THLD_UNIT;
> 
> On 16K and 64K page kernels ENET_THLD_MAX_LEN is 3840, which makes the 
> old
> ENET_MAX_MTU 3820. For MTUs from 3809 to 3820:
> 
>     mtu + 32 > 3840
>     3840 + 64 > mtu + 14
> 
> So the loop lowers the threshold to 0xe0 and tx_thld_len becomes 3584.
> Untagged frames can still be up to mtu + 14 bytes long.
> 
> In that earlier commit, CHECKSUM_PARTIAL frames longer than 3584 bytes 
> go
> out with DMA_TX_DO_CSUM and have no software fallback. Going by the 
> comment
> above, the MAC loses them.
> 
> Could this fallback move into, or ahead of, the patch that first lets
> tx_thld_len drop below the largest frame? Bisects and backports that 
> stop
> at that patch would then not see silent TX loss on large-page kernels.
> 
> The commit message only mentions the fallback in passing:
> 
>     The MAC only checksums a frame it holds in full, so anything longer 
> than
>     the threshold falls back to software.
> 
> Could it also say that this fixes TX for the earlier patch?
> 
>>  	/* Keep the frame out of the window just past the threshold */
>>  	if (unlikely(skb->len > priv->tx_thld_len &&
>>  		     skb->len < priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {
> 
> [ ... ]
> 
>> @@ -4272,7 +4358,7 @@ static int bcmgenet_probe(struct platform_device 
>> *pdev)
>>  	/* v1 cannot program the thresholds, so it stays at the default MTU 
>> */
>>  	priv->rx_buf_len = bcmgenet_rx_buf_len(dev->mtu);
>>  	if (!GENET_IS_V1(priv))
>> -		dev->max_mtu = ENET_MAX_MTU;
>> +		dev->max_mtu = ENET_MAX_JUMBO_MTU;
> 
> [Severity: Medium]
> Now that max_mtu is 16347, can the TX side describe frames this large?
> This patch leaves bcmgenet_xmit() unchanged. It still puts each skb 
> head or
> frag in one descriptor and shifts the size in without a mask:
> 
> 	len_stat = (size << DMA_BUFLENGTH_SHIFT) |
> 		   (priv->hw_params->qtag_mask << DMA_TX_QTAG_SHIFT);
> 
> The header defines that field as 12 bits:
> 
> /* Tx/Rx Dma Descriptor common bits*/
> #define DMA_BUFLENGTH_MASK		0x0fff
> #define DMA_BUFLENGTH_SHIFT		16
> 
> Buffers over 4095 bytes are common at jumbo MTUs. Near MTU 9000, a UDP 
> or
> ICMP datagram gets a single linear head from __ip_append_data(). A frag
> from an order-3 page_frag page in TCP or soft-GSO can be almost as 
> large as
> the MSS.
> 
> For a 9014 byte head the field would hold 822, and the upper bits would
> spill above the field.
> 
> If the hardware field really is 12 bits, would these frames go out
> truncated or corrupt while BQL and bytes_sent count the full length?

It is not 12 bits. On a CM4 at MTU 9000 I sent raw single descriptor 
frames
of 1498 to 8998 bytes (20 each). All frames arrived at full length with 
every
payload byte intact. With a 12 bit field 4098 would have gone out as 2 
bytes.

DMA_BUFLENGTH_MASK masks the length out of the RX status word, it is not 
the
hardware field width, so max_mtu needs no cap.

> [...]
