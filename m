Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312501;
	b=TZIu+zr550OF/fN6Lkl7MoJvh1F7Z+FmYOnrt6YZgWCuGrpMB6PUgLbJ9gXIgG3CPXEr
	 jnDU94lKVizmhIW2TFb8ixccKB5BazmIq3+5t0fMln+MbDMjDyEiqOZIfVX0TNDKrPiey
	 AmAGoWn3UBJVgRLuBK0fxhvqVGinzVRvp2pSS75Hb06agcLkNti0rPsBzXSBUoMvcmjZe
	 weJcZ2Ambfu5sTJhjHDsCtwsUZ11iE4wWVMmZHtfRBAEJNvqwUkKKvp8HNK6Td8UQdySH
	 87iEx6N1xU6UmbrWHUAAi3TP1G58KLZMrcRRFIjNXeUX/TJkE2PMCRSTqE7XOMUaotw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312501;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mvvPC3+ird2JdQYl0sF3n5jlmtsAooRx8KFT06CTW34=;
	b=hz7pGEw83EWiq4dLuDgZfJYHvqkKLMnVVGnNgAHcbhut8vSpRI2lDfLK0Yacyk/bSY28
	 UsEe3bJ1yEhbjXLoM/YmUcio9POEe91LWYVapJsj+TpXDlhBtbrS2kVRI+5JpRZmSuqh/
	 zu46ml1boW2IO+Q5cSQ1ojfermmqG+NM0lfdxYlRahaJQDStYO6Agu2pZxa9HnLtI1qjE
	 uzqmWj0WvHr/umkKX3ZRzC+vecAdvoywHI9fLmcpPRgS7u3sxsHWW+W3soNdo33edUC5F
	 fDKN21PKzVfmkqlvsHjcL//DoiRzsc2Z29U3zHlu9ZXYy8ELpu7fJjWSL3vyskoAAww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+G1a8qa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B160A2606;
	Tue, 10 Nov 2026 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+G1a8qa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1571F008A2;
	Tue, 10 Nov 2026 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312500;
	bh=mvvPC3+ird2JdQYl0sF3n5jlmtsAooRx8KFT06CTW34=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j+G1a8qaRKmHtc0tyGyBhCVBNpLlwbaGuKfie9D9F5mh/d6EF9kq6ikn+pbZE0DQQ
	 Dj/DRcqpTk1kDHRfdx26w10ANGn44UeeiCAJHQazDIujfDhRStVhLF9/GZgroPheYa
	 XoUTK/JMV+AuYDTgYrPl2Hf6TssF7Ud4/NERc0Hrur+ybT0XwrasVCfm3A49mFTY3d
	 bE8GkpRs0m7h3FfUbw10lz9yIjlTzsGPt+ubXAZJLgnHATD+KVSZ5KnIhIpLVlKEDa
	 yfWPMnx+OD1DZMFkskA7carVW8VSiWY5Nu8Dsb7TJ98cIsVQiVlUMWcimD+6BYwzcz
	 N2dYgJ3J5o3yA==
Subject: Re: [PATCH net-next v6 RESEND 4/4] net: stmmac: hold RTNL when
 reading descriptor rings in descriptors_status
From: netdev-bot+sashiko@kernel.org
To: dinghui1111@163.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Date: Tue, 10 Nov 2026 12:08:18 +0000
Message-ID: <179431249895.994134.1654344406959828487@kernel.org>
In-Reply-To: <20261106090507.1020751-5-dinghui1111@163.com>
References: <20261106090507.1020751-5-dinghui1111@163.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a NULL pointer dereference that a user can
  trigger, but its message has no Fixes: tag (and no Cc: stable).
- [Low] stmmac_rings_status_show() reads its loop bounds before taking
  RTNL.

--

net: stmmac: hold RTNL when reading descriptor rings in descriptors_status

This commit takes RTNL around the descriptors_status debugfs reader so it
is serialized against the control-plane paths that free the descriptor
rings. It also skips queues whose rings are NULL, which happens when the
interface stays IFF_UP after a failed internal reopen.

> Skip such queues with a hint instead of dereferencing a NULL pointer
> in stmmac_rings_status_show().
>
> Signed-off-by: Ding Hui <dinghui@lixiang.com>

[Severity: Low]
This fixes a NULL pointer dereference that can be triggered from debugfs,
but the commit has no Fixes: tag and no Cc: stable. Should they be added so
the affected stable trees pick this up?

The state described above comes from stmmac_change_mtu() when the reopen
fails:

stmmac_change_mtu()
    __stmmac_release(dev);
    ret = __stmmac_open(dev, dma_conf);
        init_error:
            free_dma_desc_resources(priv, &priv->dma_conf);

free_dma_desc_resources() frees the rings and sets dma_rx/dma_erx and
dma_tx/dma_etx to NULL. IFF_UP stays set.

Before this patch, stmmac_rings_status_show() checked only IFF_UP. It then
passed the NULL ring to sysfs_display_ring(), which dereferences p->des0. A
reader that raced with ndo_stop, an MTU change, an XDP change or an XSK
change could also read DMA memory while it was being freed.

There are two candidate targets. One is the commit that added the
unsynchronized descriptors_status reader. The other is the commit that
added the MTU-change reopen path:

Fixes: 347007968744 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index cd4631efe47ab..10d33a43db947 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6748,8 +6748,10 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
>  	u8 tx_count = priv->plat->tx_queues_to_use;
>  	u8 queue;
>  
> +	rtnl_lock();
> +

[Severity: Low]
Are the loop bounds still read outside the lock? rx_count and tx_count are
set in the declarations, before rtnl_lock() is taken:

    u8 rx_count = priv->plat->rx_queues_to_use;
    u8 tx_count = priv->plat->tx_queues_to_use;

stmmac_reinit_queues() (ethtool -L) runs under RTNL. It releases the rings
and then updates both fields:

stmmac_reinit_queues()
    stmmac_release(dev);
    ...
    priv->plat->rx_queues_to_use = rx_cnt;
    priv->plat->tx_queues_to_use = tx_cnt;
    ...
    ret = stmmac_open(dev);

Suppose the reader loads the counts and then blocks in rtnl_lock() while
set_channels runs. The loops then use stale bounds.

If the count shrank, the reader prints "Descriptor ring not allocated" for
queues that no longer exist. If it grew, live queues are skipped without
any message. This is also a data race that KCSAN could report, since the
fields are written under RTNL.

The rx_queue[] and tx_queue[] arrays are sized by MTL_MAX_*_QUEUES, so the
accesses stay in bounds. Only the debugfs output is affected.

The commit message says RTNL now synchronizes this reader with the control
plane. Would it make sense to read rx_queues_to_use and tx_queues_to_use
after rtnl_lock() as well?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106090507.1020751-1-dinghui1111%40163.com
