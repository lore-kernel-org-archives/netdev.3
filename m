Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295126;
	b=rBt7s2q5KUbgdRlTT5qMNl70xMA6u/WjulKVgHjh1JpPeRIhQippFi5kA02xNQQvpDrq
	 +7p3A9nMnPR5jS3mfO/KJuC+7fGShQo8+sRITupfB8m9awT+jMkyuaVRQt+LpsceAWsSz
	 2U5mQASHuSU63+ude2TBRdmaa8g02ReJnx2pcI8zFERAxA/cGfrU272PTEoaTpGo0kSvL
	 7m37IuaWdwRZ8UW43cnh4ihseZcNfjo6gFBqV+wL+/v8yeEqVmhj4mTByAuivB0SBkrk0
	 XiVIoodBCJ0HyZ+i86ySxbZK9BDB70CNjBGMC6tIzTETMhjfI0/ZtQk95/EwBqY1fcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sJUAf6MVr1LbNiZAzeVxjzmF9d4A7eRpwOmFm8HYo3Q=;
	b=JSu+XVaRmPbbObg2yAT+WUyUecFAhAxdufF8PENfqLjJKKpV8LSgldqkbu2wca+cANO7
	 IFQb77jPy7R9Z8HiKNCgveLF9ks/3BPek4FnRT/+KdTRk3ukiHk7J1tUG6o0oepKbroMv
	 EdRerxlrJujj/QuISSuZFi/ZCRec6ZhOOdD3btg8HJErltwuYIXFYT2mArrhVzanmx7vv
	 9/AEzjU8IB4DrUzPjWcdloKIDK2uZ/1MYi/wlC3jhBJJAfxKntJoUSdoCmZhzImdYd5tA
	 GK9UYj2kdQJxhEVoJwa/qJ7OdxTVGhaPSa9OshouCc55a3sr6PWjrO8Y+CefUD/jPfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIfl5Mng;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34EB606A31F
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A34EB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIfl5Mng
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso505966a91.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793295125; x=1793899925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJUAf6MVr1LbNiZAzeVxjzmF9d4A7eRpwOmFm8HYo3Q=;
        b=bIfl5Mng4gxdWhKRNbpO9PWQD5tYmo4ekW5FpajJY6vrOLHsttzxE2pBRa5VTCnNZZ
         Wy+pdzF9/Je31rbXglJaxsH8GFfZDEwven5S0gX4EhfrdXEhcE4JGauA8uJj8/cIE2f9
         buCJIKayt5qZwaf0UPsEYF/q6rgFiajroXsDlpgq/pKu3+mdsZW8A8Ev0GHGd4WTxfou
         Sl7oV2AhZ31umOlPAECE59aVzLNr5d4n/hsocEmVa/TjwuYr65xVw0c3wEEsV6baKgpu
         CLYU3FObwKvjUO36KlquZv1ukqpTnwdJnylqnvGdDwi88Amn1JBjhQnDXd51ckhSfdQh
         6LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295125; x=1793899925;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJUAf6MVr1LbNiZAzeVxjzmF9d4A7eRpwOmFm8HYo3Q=;
        b=Ox5cMc6Qy6W/EVFk2qL/vfHPQzu2K3ZiZUfaMyOON2xr+bFE8GjJbUUCetz5+oMoIq
         gRnLvUN7DeX88rmP2u7L7dLdS9FZj7ZeeyhnNVOLx4xiAgIa5uC0CsIHIAJO0MNkPD4I
         7CJ5RrOI+SgyQL8pWwDLwcCeDbBDDUQTyoDmMghWdFD06bMAMlAWX+MGjPyDKKxLTdkN
         jRTEvnyVLSfMB6PHiEvhNA3a4tR3ISx5+sZ2iQhEXtUXX67ZoPeIQADg+T6cTDL90IzC
         gQMtkFaEIp16+Vgw7Tusk1MjSaem7BOHIX7GOO/rw/fYCGqA3MFPYcxsQmHt1htFyPhF
         RbiA==
X-Gm-Message-State: AFq9FYIrEURpYX6VaNs+PAFn9lMrsBMmF21bhmWNIyhJsh0LIJkkQ++N
	FGhWeRXBxLODBkYttQUvVqpfi7i2OlTBUfK0+PS7S62az9KuK25OJD46
X-Gm-Gg: AYBFou0bEP0UbhrVMysr75OiOV+CWsG3YNFrjM+jzK+m9hCI8kVhKbtY/y4axzlzwSI
	JB1vk40nCqBQJStw+KiiccuX5uldE/iYhegypUCizJxQrgXmIRfZBkofNk9NeQfeqlxyoMu7J4B
	AIUWVIW17tlD7FH/uIZDy9wDqpNU1+y5h6vWJ55EgLSto7rwjlwFNAQDKn7fYuEt84HjDYYhFmp
	i+KRWsBVQxheIha9BmGa6/J95MimPepNmF4ydGHpuUQi18JS/qSgzlYjH0RPqOvyTGmnYDHJHva
	2vG0LNFfMAuguR0TN5xEBNJqAKviYV9HIPxLQyTKTB8DBi45P5FpiPdQV5Y8U2x40VOYNzNmKoE
	klIq82mT8dNkS5zD1gjwEK7beTnjsbF39ARPc1Xt+rXMi+XLSxjvYL8UZpkTn4c+/M3smIx6tUs
	94/CQFDSB4uRgPMXiEE1EMZwxxHWzl44D1ueHdw9SxXdd3RwZ1LEeIV10Ko+2NkqAt4pPw3KZKu
	DLIMhd/B54qCuzAy/mi2iVgzzC+LKWVqJBliaoPKrH8gQB6TTBn9CZkuErgnS7hzlKfoUTIO8UK
	XzNgHFy5HrXc3D0gxWm2DR6fT9qgkXsH7nYiV95YczaqwgwV+0dJZXsP
X-Received: by 2002:a17:90b:2e41:b0:3ac:aa8d:19f2 with SMTP id 98e67ed59e1d1-3ae582eff88mr4604989a91.62.1793295124834;
        Thu, 29 Oct 2026 10:32:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8441a5ecsm539049a91.2.2026.10.29.10.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 10:32:03 -0700 (PDT)
Message-ID: <e244d83b-6342-407d-9714-3c9140760d7f@gmail.com>
Date: Thu, 29 Oct 2026 10:32:00 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 05/11] net: au1000: serialize TX completion with
 packet submission
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, shaojijie@huawei.com,
 horms@kernel.org, runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org,
 jeff@garzik.org, danny.kukawka@bisect.de, mugunthanvnm@ti.com,
 sebastian.hesselbarth@gmail.com, linux-kernel@vger.kernel.org,
 manuel.lauss@gmail.com
References: <20261027223140.3774570-6-f.fainelli@gmail.com>
 <179329051390.3134.18192194876316281231@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <179329051390.3134.18192194876316281231@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/26 09:15, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 (1) · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] au1000_tx() in drivers/net/ethernet/amd/au1000_eth.c now frees
>    the skb with hardware IRQs disabled.
> - [Medium] After this patch, au1000_tx()'s inline reclaim path leaves
>    aup->tx_tail permanently out of step with the hardware.
> 
> Pre-existing issues:
> - [Critical] This problem wasn't introduced by this patch, but
>    au1000_tx() copies skb->len bytes into a fixed MAX_BUF_SIZE…
> 
> --
> 
> net: au1000: serialize TX completion with packet submission
> 
> This commit takes the existing IRQ-safe aup->lock in both au1000_tx_ack()
> and au1000_tx(). The goal is to serialize TX descriptor reclamation in hard
> IRQ context with packet submission in ndo_start_xmit. It also closes a
> missed-wakeup window between netif_stop_queue() and setting tx_full.
> 
>> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
>> index a507a524370fd..90887dac26bc9 100644
>> --- a/drivers/net/ethernet/amd/au1000_eth.c
>> +++ b/drivers/net/ethernet/amd/au1000_eth.c
> 
> [ ... ]
> 
>> @@ -973,17 +977,20 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb, struct net_device *dev)
>>   	u32 buff_stat;
>>   	struct db_dest *pDB;
>>   	int i;
>> +	unsigned long flags;
>>   
>>   	netif_dbg(aup, tx_queued, dev, "tx: aup %x len=%d, data=%p, head %d\n",
>>   				(unsigned)aup, skb->len,
>>   				skb->data, aup->tx_head);
>>   
>> +	spin_lock_irqsave(&aup->lock, flags);
>>   	ptxd = aup->tx_dma_ring[aup->tx_head];
>>   	buff_stat = ptxd->buff_stat;
>>   	if (buff_stat & TX_DMA_ENABLE) {
>>   		/* We've wrapped around and the transmitter is still busy */
>>   		netif_stop_queue(dev);
>>   		aup->tx_full = 1;
>> +		spin_unlock_irqrestore(&aup->lock, flags);
>>   		return NETDEV_TX_BUSY;
>>   	} else if (buff_stat & TX_T_DONE) {
>>   		au1000_update_tx_stats(dev, ptxd->status);
> 
> [Severity: Medium]
> 
> Now that the lock is held here, can this inline reclaim leave aup->tx_tail
> permanently out of step with the hardware?
> 
> If desc[tx_head] has TX_T_DONE set at this point, the ring is full
> (tx_head == tx_tail) and the oldest buffer has just completed. This branch
> updates stats and zeroes len. Later in au1000_tx() the code re-arms the
> descriptor, which clears the done bit, and advances tx_head:
> 
> 	ptxd->buff_stat = lower_32_bits(pDB->dma_addr) | TX_DMA_ENABLE;
> 	...
> 	aup->tx_head = (aup->tx_head + 1) & (NUM_TX_DMA - 1);
> 
> tx_tail is never advanced on this path.
> 
> Before this patch, on the uniprocessor Au1x00, the pending MAC DMA
> interrupt could run au1000_tx_ack() before the re-arm and move tx_tail
> forward. Now the ISR is held off until spin_unlock_irqrestore(). At that
> point au1000_tx_ack() finds desc[tx_tail] re-armed with no done bit:
> 
> 	while (ptxd->buff_stat & TX_T_DONE) {
> 
> So it returns without moving tx_tail, which now points at the newest
> submitted descriptor.
> 
> au1000_init() sets tx_head from the hardware's own buffer index, so the
> hardware completes descriptors in index order and that newest descriptor
> completes last. Wouldn't that leave the TX_T_DONE bits of older completed
> descriptors unacknowledged until then?
> 
> It would also delay netif_wake_queue() in au1000_tx_ack() until the whole
> 4-entry ring drains, rather than after one completion. The offset would
> then persist until au1000_init() resets head and tail.
> 
> The same thing can happen when au1000_tx() is called with IRQs already
> disabled, for example from netpoll.
> 
> The MAC DMA interrupt is IRQ_TYPE_LEVEL_HIGH, and au1000_interrupt() always
> returns IRQ_RETVAL(1). If unacknowledged done bits keep the line asserted,
> could this become an interrupt storm? That part depends on hardware
> behaviour that has not been confirmed.
> 
> [ ... ]
> 
> [Severity: Critical]
> 
> This is a pre-existing issue, not one introduced by this patch.
> au1000_tx() copies skb->len bytes into a fixed MAX_BUF_SIZE (2048 byte)
> bounce buffer without checking the length:
> 
> 	pDB = aup->tx_db_inuse[aup->tx_head];
> 	skb_copy_from_linear_data(skb, (void *)pDB->vaddr, skb->len);
> 
> Can skb->len be larger than 2048 here? When po->vnet_hdr_sz is nonzero,
> tpacket_snd() in net/packet/af_packet.c skips both MTU checks:
> 
> 	if ((size_max > dev->mtu + reserve + VLAN_HLEN) && !vnet_hdr_sz)
> 		size_max = dev->mtu + reserve + VLAN_HLEN;
> 	...
> 		if (likely(tp_len >= 0) &&
> 		    tp_len > dev->mtu + reserve &&
> 		    !vnet_hdr_sz &&
> 		    !packet_extra_vlan_len_allowed(dev, skb))
> 
> An all-zero virtio_net_hdr (GSO_NONE, no NEEDS_CSUM) is accepted without
> making the skb GSO. validate_xmit_skb() then only linearizes it, because
> au1000 does not advertise NETIF_F_SG, and applies no MTU check.
> 
> With CAP_NET_RAW, this path could deliver a multi-kilobyte skb to
> au1000_tx():
> 
> socket(AF_PACKET, SOCK_RAW)
>    setsockopt(PACKET_VNET_HDR)
>    setsockopt(PACKET_TX_RING) with tp_frame_size > 2048
>    tpacket_snd()
>      packet_xmit()
>        validate_xmit_skb()
>          au1000_tx()
>            skb_copy_from_linear_data(..., skb->len)
> 
> au1000_probe() allocates a single 16 KiB region with dma_alloc_coherent().
> The TX buffers are at offsets 0-8K and the RX buffers at 8-16K. Would an
> oversized frame overwrite the neighbouring TX/RX DMA buffers? Beyond about
> 10 KiB, would it write past the end of the coherent allocation?
> 
> Should au1000_tx() drop frames larger than MAX_BUF_SIZE?
> 
>> @@ -1012,6 +1019,7 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb, struct net_device *dev)
>>   	wmb(); /* drain writebuffer */
>>   	dev_kfree_skb(skb);
>>   	aup->tx_head = (aup->tx_head + 1) & (NUM_TX_DMA - 1);
>> +	spin_unlock_irqrestore(&aup->lock, flags);
>>   	return NETDEV_TX_OK;
>>   }
> 
> [Severity: Medium]
> 
> With the new spin_lock_irqsave() in au1000_tx(), dev_kfree_skb(skb) now
> runs with hard IRQs disabled. dev_kfree_skb() is just consume_skb():
> 
> include/linux/skbuff.h:
> #define dev_kfree_skb(a)	consume_skb(a)
> 
> include/linux/netdevice.h says:
> 
>   * It is not allowed to call kfree_skb() or consume_skb() from hardware
>   * interrupt context or with hardware interrupts being disabled.
>   * (in_hardirq() || irqs_disabled())
> 
> Does this mean every transmitted packet now runs its skb destructors with
> IRQs off? That includes sock_wfree()/tcp_wfree(), zerocopy ubuf callbacks,
> and dst and conntrack puts.
> 
> If any of those reach local_bh_enable(), lockdep_assert_irqs_enabled()
> would fire. With CONFIG_TRACE_IRQFLAGS, __local_bh_enable_ip() could also
> turn IRQs back on inside the aup->lock section, which would reopen the
> race this patch is closing.
> 
> The data has already been copied into pDB->vaddr. Could the free move
> after spin_unlock_irqrestore(), or use dev_consume_skb_any() instead?
> 

Agreed on both medium findings. I’ll advance tx_tail during inline 
reclaim and move SKB consumption after unlocking, using 
dev_consume_skb_any() for callers entering with IRQs disabled.

I’ll also add a separate fix rejecting oversized frames before the 
bounce-buffer copy. The possible interrupt storm remains unconfirmed.

pw-bot: cr
-- 
Florian
