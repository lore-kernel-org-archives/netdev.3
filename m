Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259973EFD09
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698933; cv=none; b=UE1M4d8YHMgQ37oWBp1Tdju1i8hMkphaQOhlif1RkBVrbavJP/+Lf9uwFbdvRdRRc5gdPRUjGiHzPVadYPZa7B5cOTLYs7YzGtekJ1rFd/O7WtivXycuXI1fnw1Rr8VHfZu0e5nsGqLVFV9nTK3zKSoWL/P/NciZUxyOBWiBD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698933; c=relaxed/simple;
	bh=o70dPxTl+4RcCtOCfxAlNjILV6DQKkwHn+RnWJ00B08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3kxakGkhoAGpUaKq6ZV94JjVxeXJQeUDhM+T4n1zBU7lsKleqCuMbq4cyxTQHDh+Q64YOl2Mzp13luou34FkDPDNDyycIhRDhBIBV2sRBLrcTkYynohJ+c5ffL4B0bZTNmyjivnia2WCl9NVt1RcOsmMAP3Nw7d+H08XFce5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mekYatbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mekYatbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CF31F000E9;
	Wed, 17 Jun 2026 12:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781698931;
	bh=C91mNtrzgPeKSlnGkaTiPEalhjsVdXTjVYDja2SR5Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mekYatbMEmJXUGcnAbabV9Da4XDBoPIVNHMbvLbEZEObEgCdAZFY1rvPgkPQX+zH5
	 oM91aFVte4WoeFXSlkhiA5navSUy8hBkyw58JmK0GbzGZ5jinWH10hE0hrjGiUJpXr
	 57ioUT6ROSt1nR13Th/kOWC/oCBew+P/g/B7q8YUzuj7B2NfxIoJGEFCUWZJMEdb79
	 d6bZ8kmGCvaknWQ/F8xl7RpP9WEC3L02MMXuC4oRqM28UYJB4NRiI3tUFhI7NpHGjh
	 InGT4n7UTLi/rMJs2gyGGst7ze2e5jAE1X1dzsQ6wV2ZY3NHhv78/3cgBxKd96C3wD
	 PVLkXiadx0AHQ==
Date: Wed, 17 Jun 2026 13:22:07 +0100
From: Simon Horman <horms@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Clean up RX queues in airoha_dev_stop
Message-ID: <20260617122207.GD827683@horms.kernel.org>
References: <178160746585.2156302.190868309474762875@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178160746585.2156302.190868309474762875@gmail.com>

On Tue, Jun 16, 2026 at 06:50:48PM +0800, Wayen Yan wrote:
> When the last port is stopped, airoha_dev_stop() clears TX queues
> but neglects to clean up RX queues. This can lead to:
> - RX ring buffer descriptors remaining valid after device close
> - Potential DMA synchronization issues on device reopen
> - Risk of use-after-free if pages are freed while DMA is still active
> 
> Add cleanup loop for RX queues to mirror the TX queue cleanup,
> ensuring symmetric resource management.
> 
> Fixes: 20bf7d07c956 ("net: airoha: add QDMA support for Airoha EN7581 Ethernet")
> Signed-off-by: Wayen Yan <win847@gmail.com>

Hi Wayen Yan,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/

I asked AI to summarise these concerns, it came up with the
following. I would appreciate it if you could look over this feedback.

1. NAPI Synchronization:
   While the TX path is managed by the netdev layer during stop, the RX path
   relies on the NAPI subsystem. Since NAPI remains active during
   `airoha_dev_stop()`, the new cleanup loop could race with the poller
   (`airoha_qdma_rx_process`). It would be safer to call `napi_disable()`
   before draining the queues to ensure exclusive access to the descriptors.

2. RX Queue Refill:
   Unlike TX, the RX hardware requires descriptors to be pre-allocated and
   posted by the driver to receive data. Because this patch empties the rings,
   `airoha_dev_open()` needs a corresponding update to refill them (e.g.,
   via `airoha_qdma_fill_rx_queue()`). Without this, the interface will
   encounter an empty ring on restart, leading to an RX stall.

3. SKB Accumulation:
   The cleanup should also account for the `q->skb` pointer used for
   fragmented packets. If a partial packet is sitting in the queue when the
   interface is stopped, freeing it and resetting the pointer to NULL will
   prevent a memory leak and ensure the next session starts with a clean
   state.
