Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CFE33122A
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146382; cv=none; b=Vx/Kas5KFzbAWw6FsPo7+6LNqX7xe4q/hZ/x1w1ByuwfT0eww2lfhkTGd5gs+LoTpqivgF7XZmhFubrSIMIb4n/ElfgQcrOSB5ysgQhh8StELJuq8DYMq0PDkeBAI0P5D+0vVXZ/6XBbqMByyiI61Vgr8y0BM7cW0Jf0msiX7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146382; c=relaxed/simple;
	bh=XIHiu0O5xbQNgDMVw+8qHBFtUFZeCNyYb1TeYSKO1ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbH+Mpe8324HprdJYIA4Shg2xeaAW8C4bYfJCxHasUwPWjpcg+shQwsKkZs71bwXcOs2PsfDLG8zB3/aAA0F026LdPnnwG+UR1JVYbRKTjaMbOs/h1xjdqjblme1/N7nw0i2XEDMXmyf6yXOU2kSPKUD8chMO0h4EuA9tG+eCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7u0TWl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7u0TWl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5871F000E9;
	Mon, 22 Jun 2026 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146381;
	bh=QUZD+emMQ2xlB4a05ZZK2Z1/2LYgrrwvQo0kKAM+qPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A7u0TWl4NdgWXkAMlDQhZA9OVkFj9CDXRLeJ0IQJ1e6symrrmYwzLrCZ9FCEQ1/0e
	 pTA9PwpEaO53WqkDwx1TwQCkOhWhjypPk7KItRuXW4LG/nQpwuXE3zY1WjjdtkNmte
	 vk2U6VFIx+0aF9JPW1LZNTfzxGNPaSSa2MLJM1jEr/5SaWO7bdszv48UNu4h1WKBTg
	 lm/JubDjaM+vFcSBV5BWvoVkKxTUDNEQOWgERHxVasD8jFOzzSqLytg8y39E3d0IQU
	 zxeEh7xUCvsNa92YKvqBSUCtnuS3OWhsBWxRuQ++Cvt8sZLR9XZtAQJZWXGMbtwpeM
	 ZVftYS3FjcX2Q==
Date: Mon, 22 Jun 2026 17:39:37 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] net: airoha: fix BQL underflow in shared QDMA TX
 ring
Message-ID: <20260622163937.GH827683@horms.kernel.org>
References: <20260620-airoha-bql-fixes-v3-1-76b95374e63e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620-airoha-bql-fixes-v3-1-76b95374e63e@kernel.org>

On Sat, Jun 20, 2026 at 05:04:51PM +0200, Lorenzo Bianconi wrote:
> When multiple netdevs share a QDMA TX ring and one device is stopped,
> netdev_tx_reset_subqueue() zeroes that device's BQL counters while its
> pending skbs remain in the shared HW TX ring. When NAPI later completes
> those skbs via netdev_tx_completed_queue(), the already-zeroed
> dql->num_queued counter underflows.
> 
> Fix the issue:
> - Remove netdev_tx_reset_subqueue() from airoha_dev_stop() so pending
>   skbs are completed naturally by NAPI with proper BQL accounting.
> - Rework airoha_qdma_tx_cleanup() to disable TX DMA, flush BQL
>   counters, DMA-unmap and free all pending skbs while skb->dev
>   references are still valid. Use a per-queue flushing flag checked
>   under q->lock in airoha_dev_xmit() to prevent races between teardown
>   and transmit. Call airoha_qdma_stop_napi() before
>   airoha_qdma_tx_cleanup() at the call sites.
> - Move DMA engine start into probe. Split DMA teardown so TX DMA is
>   disabled in airoha_qdma_tx_cleanup() and RX DMA in
>   airoha_qdma_cleanup().
> - Remove qdma->users counter since DMA lifetime is now tied to
>   probe/cleanup rather than per-netdev open/stop.
> 
> Fixes: a9c2ca61fec7 ("net: airoha: Support multiple net_devices for a single FE GDM port")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v3:
> - Remove airoha_qdma users counter.
> - Drop DEV_STATE_FLUSH bit and add per-queue flushing bool to avoid any
>   race between airoha_qdma_tx_flush() and airoha_dev_xmit().
> - Refactor airoha_qdma_cleanup_tx_queue().
> - Rename airoha_qdma_cleanup_tx_queue() in airoha_qdma_tx_cleanup().
> - Link to v2: https://lore.kernel.org/r/20260619-airoha-bql-fixes-v2-1-4351d6a24484@kernel.org
> 

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

