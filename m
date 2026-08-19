Received: from mta1.migadu.com (out-120.mta1.migadu.com [95.215.58.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F447F764
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152251; cv=none; b=o3qmA+EA5Ekw1z8PrUgEIW0PLWWKAxg9xbAmDt2CYKD7vkHPp4jx3HnxZxLX0cKrcW+Ipf10Rr/nJsJlkKGUJwHVsg+xoAi7h26hmAC707UzlZLguUHhv5aBw1BVVMIU5iyryC6Xbd4JfyJI+OpK52UvQd/36oklFm7CpFwqI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152251; c=relaxed/simple;
	bh=GspjZtFQhAFR7Oloo+MX2DOO8i0G/6TyDULbF0s6M8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qc+gPwtHyHU68qSJvZy/geGWgHQBsT1GV9SIg2/0YpZTvttE2NLdXKltkSWxbJdigacmA8+MxYqCESsew0ebwahKBDfdCEHnxCtMZ+9oDQtfu7jRabtDNexRvV2HMU7zATj7sk3ihLiCjzQac8LK8lz0Na8kh0LEqifBy6U4M5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WQjIiVgF; arc=none smtp.client-ip=95.215.58.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WQjIiVgF"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GspjZtFQhAFR7Oloo+MX2DOO8i0G/6TyDULbF0s6M8c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787152245; v=1; x=1787757045;
 b=WQjIiVgFE0wkALi54P42h+LwxIfq4cbubaqHx3RcEzt6zIoZjsuvaiXRe02JjY7Oe1W/7VoD
 KKpkkbcrjGKzlWYKmgCnKSz5/NGfTfaa6eLT6uNK9N05Sqf+Tvw3I/mPUGDgMwuTm/gCA6eLFU/
 4K6i6AN8vq3TN7LuEpx4D7O8=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2601:647:6300:a030:c8df:e66c:f17b:da8f] (2601:647:6300:a030:c8df:e66c:f17b:da8f)
	by smtp.migadu.com with ESMTPS id 4c90150a9e2a34a4;
	Wed, 19 Aug 2026 15:10:44 +0000
X-Mizu-Trace-ID: 4c90150a9e2a34a4
X-Migadu-Flow: FLOW_OUT
Message-ID: <d2681a6a-0fa3-43ec-a083-1e8e55dddafb@linux.dev>
Date: Wed, 19 Aug 2026 08:10:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] forcedeth: stop the tx_timeout register dump past
 the requested window
To: Marek Czernohous <mczernohous@gmail.com>, netdev@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Rain River <rain.1986.08.12@gmail.com>, Zhu Yanjun
 <zyjzyj2000@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tobias Diedrich <tobiasdiedrich@gmail.com>, linux-kernel@vger.kernel.org
References: <178682367884.3748309.5288746298966501007@gmail.com>
 <178682367886.3748309.6978554332066826294@gmail.com>
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <178682367886.3748309.6978554332066826294@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/15 12:54, Marek Czernohous 写道:
> From: Marek Czernohous <marek@czernohous.de>
>
> nv_tx_timeout() dumps the register window in rows of eight dwords:
>
> 	for (i = 0; i <= np->register_size; i += 32) {
> 		netdev_info(dev, "%3x: %08x ... %08x\n", i,
> 			    readl(base + i + 0), ..., readl(base + i + 28));
>
> The loop bound only checks the row's starting offset, so the final row
> reads a full 32 bytes from a position that is below the end of the window
> but too close to it. base is mapped with exactly that length:
>
> 	np->base = ioremap(addr, np->register_size);
>
> so the tail of that row is read from beyond the length the driver asked
> for. Per variant, the last iteration reads past register_size by:
>
> 	NV_PCI_REGSZ_VER1 (0x270): row 0x260 reads to 0x27f, 16 bytes over
> 	NV_PCI_REGSZ_VER2 (0x2d4): row 0x2c0 reads to 0x2df, 12 bytes over
> 	NV_PCI_REGSZ_VER3 (0x604): row 0x600 reads to 0x61f, 28 bytes over
>
> This happens on every supported device, not just one of them. Note that
> it is not a consequence of the sizes being odd: with i <= register_size
> the offending row is reached whatever the size, and a size that were a
> multiple of 32 would overrun by a full row rather than by a remainder.
>
> To be precise about the severity: the reads stay inside the BAR. Memory
> BAR sizes are powers of two, the driver only accepts a region with
> pci_resource_len() >= register_size (forcedeth.c:5757-5762), and the
> next power of two at or above each register_size already covers the
> offending row: 0x400 for 0x270 and 0x2d4, 0x800 for 0x604. ioremap()
> also rounds the mapped length up to page granularity, so the reads land
> inside the mapping the CPU has as well. What they leave is the window
> the driver asked for, not the BAR and not the mapping. That is still a
> driver reading registers it did not ask for, and it is trivial to
> avoid, but nobody should expect a fault from it.
>
> Changing <= to < is not enough: register_size is a length and every size
> above is larger than its last row start, so i still reaches the offending
> row. Check that the whole row fits instead.
>
> The trade-off is that a partial trailing row is no longer dumped: 16 bytes
> for VER1, 20 for VER2, 4 for VER3. That seemed preferable to reading
> outside the requested window, and to open-coding a second, narrower dump
> for the remainder in what is a debug-only path. Extending the dump to
> cover the tail can be done on top if anyone misses those registers.
>
> Only reachable with the debug_tx_timeout module parameter, which defaults
> to false. It has not been observed at runtime: forcing a genuine TX
> timeout on the reference machine is not something I can do safely, so this
> rests on the arithmetic above and on a build test, not on a reproduction.
> UBSAN does not catch it either, since these are MMIO reads rather than an
> array access. It was found by reading the function while fixing the
> saved_config_space off-by-one in nv_suspend() and nv_resume().
>
> The dump was introduced with a fixed 0x400 bound while ioremap() mapped
> only NV_PCI_REGSZ (0x270), so it read about 0x190 bytes too far from the
> start. Commit 86a0f04387bf ("[PATCH] forcedeth: fix initialization")
> later replaced 0x400 with np->register_size, which shrank the overrun to
> the remainder but did not remove it.
>
> Fixes: c2dba06dae7d ("[PATCH] forcedeth: rewritten tx irq handling")
> Signed-off-by: Marek Czernohous <marek@czernohous.de>

Thanks a lot.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> Assisted-by: Claude:claude-opus-5
> ---
>   drivers/net/ethernet/nvidia/forcedeth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
> index dc804e111564..f0218a0eab5c 100644
> --- a/drivers/net/ethernet/nvidia/forcedeth.c
> +++ b/drivers/net/ethernet/nvidia/forcedeth.c
> @@ -2740,7 +2740,7 @@ static void nv_tx_timeout(struct net_device *dev, unsigned int txqueue)
>   
>   		netdev_info(dev, "Ring at %lx\n", (unsigned long)np->ring_addr);
>   		netdev_info(dev, "Dumping tx registers\n");
> -		for (i = 0; i <= np->register_size; i += 32) {
> +		for (i = 0; i + 32 <= np->register_size; i += 32) {
>   			netdev_info(dev,
>   				    "%3x: %08x %08x %08x %08x "
>   				    "%08x %08x %08x %08x\n",

-- 
Best Regards,
Yanjun.Zhu

