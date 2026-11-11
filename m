Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438648;
	b=hnSwzCQU9uL+oqTr7AQJZyuI63bycUN5yaYDpAWDSx+QNZbT+G5tD6WuHSFcLnDdLmZ2
	 ojrixH8IcQn2CgBCpamg6Eo3gmdx5hv+dd5J0kIWX7QsR1chhHzklDnqt/Cl8l20dvOtn
	 a2wist6HvLyzZYPxvu3RUCRaHGrmQW5jbBtxqAOzd5IGVmcKOAGNKZ4+jNtULpiluKNzv
	 ewtegt9Utgzef+QT+732ZmoOogHPeXXWlUqv6MFzhpMGxhRu45gXGC95coQ5Cn+dA/IWb
	 hhuMWQDOIR2vtMzX3J6gpu2oiFnC2xbDw7OXvMK84jF/oZVmR6J5fN1CPUb9mGaaYpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438648;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nXVAVXEeOEXUCWgwAE11ralgtxNKMX2xmFVCGFUKcZM=;
	b=lRp7/6dM7uC+JXpAF8y1Jjah/A/GhuJFiyidsZC6TQFpkpD7aInxBaxoce8O6dm9arqh
	 IbfSAytvKxPlJ30j8b+CVYHkmTTB8AJ/5FEgnOl/vggf8oj/+f//YfB+TDfg28sPleS9F
	 3AE13kK06BD3PMxLuqArEN3zt1gY1nrc9sekOJeRisUzXCDsV2bhDl97qBg3OQIq2nzog
	 uCxudmrP+PeP9tiX9ZgnbTZJgN2VDDTgioRi8ZRgREB6eAF2FQk8ACNQ3ZutFNxHnTzN9
	 syEQhIX9xH+GTleTH9Ee66Zno83PPesL9Rbl50/7Q43X6/diNZ+veKRDaJ9cpS1IHsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZAhQ3IM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1F606A336
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZAhQ3IM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6F51F00A08;
	Wed, 11 Nov 2026 23:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438648;
	bh=nXVAVXEeOEXUCWgwAE11ralgtxNKMX2xmFVCGFUKcZM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LZAhQ3IMuEh3k6vvAYwyWx73t0InCdJR5mSNW2G44iFh07KgTzZ2Iu3ZqpO058RkL
	 /L/CGyNf7hA4s89y9K+WVGmH0Wnb1lmjlxofXF5VNDQYtivZzO16MBwSNQg5I+Iaa6
	 DWhx2VkUAmIp2gxAJIcYz6eBRPXjBXBxp2TKlz5Tm12pxGYp0r9cxofub2imSIOjyT
	 ceoJbGsPyJR/k3sNrp8WLoC3ldxFUfaXeJ4joLhqzMSaATa8LBLFv5Txo9J3y1vHq8
	 S6v7g7PECOPeTRGDh4QCxIo71P0bSiMEg+PJELobd0un1dPRViBtfp24sGOn08WQFF
	 zckf8stuq9M4w==
Subject: Re: [PATCH net-next v7 04/18] net: ethernet: cortina: Normalize free
 queue pointers on rebuild
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Wed, 11 Nov 2026 23:10:47 +0000
Message-ID: <179443864741.2199510.15744316768063571616@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-4-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-4-9c32a1a46aec@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] geth_resize_freeq() now sets a minimum queue order from the
  hardware read pointer: `new_order = max_t(unsigned int, new_order,…

--

net: ethernet: cortina: Normalize free queue pointers on rebuild

This commit masks the software free queue page indices to the active
queue order. It also sets the software write pointer from the retained
hardware read pointer before a rebuilt ring is filled. Finally,
geth_resize_freeq() now raises the shared free queue order so the
replacement ring is big enough to hold the retained read pointer.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 5fdbe987dc975..fa51f2b54073f 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -1099,6 +1106,10 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	}
>  
>  	new_order = min(15, ilog2(new_size - 1) + 1);
> +	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
> +	if (rptr >= BIT(15))
> +		return -EIO;
> +	new_order = max_t(unsigned int, new_order, fls(rptr));

[Severity: Medium]

Can this floor push the shared free queue up to order 15 whatever ring
sizes were requested?

Any retained read pointer from 16384 to 32767 gives fls(rptr) == 15. At
order 15 the ring has 32768 descriptors. With 4K pages and 2K fragments,
geth_setup_freeq() then needs 16384 pages (about 64 MiB), allocated one
at a time:

geth_resize_freeq()
  geth_setup_freeq()
    for (pn = 0; pn < pages; pn++)
      geth_freeq_alloc_map_page()
        page = alloc_page(GFP_ATOMIC);

This runs in process context under RTNL, but GFP_ATOMIC cannot do direct
reclaim. Gemini boards usually have 32 to 128 MiB of RAM. A later patch
in this series, "Scale Gemini RX queues to system memory", seems to
address the memory pressure from these queues.

The pointer can be inherited from firmware, or carried over from an
earlier driver instance across rmmod/insmod. If the allocation then
fails, freeq_ring stays NULL. DMA is stopped, so the hardware read
pointer does not move.

Won't every later gmac_open() or ethtool -G compute the same floor and
fail again? gmac_open() treats any error other than -EBUSY as fatal:

	if (err && (err != -EBUSY)) {
		netdev_err(netdev, "could not resize freeq\n");
		goto err_stop_phy;
	}

Both ports share this queue. Would networking on both ports stay down
until the hardware pointer changes? In the same way, a retained pointer
of BIT(15) or more makes every open return -EIO.

The commit message says:

    A requested shrink may therefore retain a larger shared queue. A high
    pointer inherited from firmware can impose the same allocation floor.
    If allocation fails, leave the queue disabled and return the error;

It does not say that the floor can reach 64 MiB of GFP_ATOMIC page
allocations. It also does not say that the failure persists across
retries.

The design also assumes the read pointer cannot be reset. The commit
message itself says this is unverified. gemini_ethernet_init() already
writes the whole register:

	writel(0, geth->base + GLOBAL_SWFQ_RWPTR_REG);

If that write does reset the read pointer, is the floor still needed for
the firmware-inherited case? If it does not, does that write have any
effect on the read pointer half?

>  	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
>  		new_size, new_order);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec%40kernel.org
