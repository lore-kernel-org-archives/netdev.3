Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312499;
	b=zAREVpHkv9y/bcZ8B6+UxEn3Zi1ZJZzs91jfgzh7Im3WtFCQEqnP+s9ARm+/TzmzJSPV
	 HKje7TGybeBpuehYJBtRojWVQkx74iTkMlEdmba+s5W6HCmP3ULnauXtIUZ5sDopElUio
	 nQxTIUGmm2AV9Wfdt9ERY43LnTW/9F7pAk+bdUIjVUhOx+R6/kv0n8QXxDM2Zc0FEJiC1
	 2gDhyAHs+bN+9l3/mKcqFNOtRDa3q7QnXKm31I2Fm/gRCuUoY+ZG0pucDXvlXKvOeoypL
	 T5oufRKjhCtu95uZViYvkZ9kojlfb9juWAZW7zwg7+qBxoBErz5LveH4i9kmvEalYUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312499;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VQRdk6SHySBLAJGnophDMBUI53s97lQO9il1DqzVxmo=;
	b=JqL0vkABOcvOyOpzFyu+nJ8vJhFNzXpb7ZGVCpf17kGSJjuY16aTqLgAKCgky5S5P35B
	 eludKKDInKkQngi/HB7qv0k90waOlL8fzzzH1l6eS+PrFTTvnfYouadOhoKSiFRKvWJsE
	 P3n3abcKdMCI0Wcf6NbutJjQVqZ9Xj+39NW9UuN26Z1FJ0pZUwQV9eAris0ltXSi4govC
	 PB3pjJVK+4ZddmtQlx/yRw/x/5CA8WKCAOhoq2idTz4C3g9TkBkRyIbbhaBNrfkadhf7b
	 84ML8yo5tUuuC8vVMyzjK4hVxpsoO1ChAvpHrzhmRVWKy22w8mPgPaiXXLLmKAX4+BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cWQ5lw/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487E60A380B;
	Tue, 10 Nov 2026 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWQ5lw/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB35C1F0089F;
	Tue, 10 Nov 2026 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312498;
	bh=VQRdk6SHySBLAJGnophDMBUI53s97lQO9il1DqzVxmo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cWQ5lw/Gbt5uDkya7QFZNTAgO7BaJ7HXJ6W8O3kv76px+MRPLHSyy+JAvL6FyYgf7
	 4Zi86tq1dO15AKIoSnRT1TAzSsknSU7hJHRYLRdpl+3gA27Im64CzRcZP/JMpnY0+K
	 W2zEphFmOi4dv/PwOQbR2Uj9an+QqcNg1OuQEmd89su8FcDbSK5sUidnTSjh9zl6XE
	 Mu/NgU8N0cPnKw7kl7eulMhzw4m9vojwdKRvOa0l9wK5kDv8/thXhGf3LVEOrfHrLg
	 GvhGRlkJEfDLO/h3EUpppGZlt9fNB936LroJbUt9+tT765POdaxHnsDrwR02+6ivvp
	 djlzxnx4PNE6w==
Subject: Re: [PATCH net-next v6 RESEND 3/4] net: stmmac: release descriptor
 resources through priv->dma_conf on open failure
From: netdev-bot+sashiko@kernel.org
To: dinghui1111@163.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Date: Tue, 10 Nov 2026 12:08:17 +0000
Message-ID: <179431249745.994134.2549811936240601029@kernel.org>
In-Reply-To: <20261106090507.1020751-4-dinghui1111@163.com>
References: <20261106090507.1020751-4-dinghui1111@163.com>
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

- [Low] This commit fixes a bug but has no Fixes: tag and no Cc: stable.
- [Low] The commit message says stmmac_open() stops jumping into the
  err_serdes chain after __stmmac_open() fails because that chain 'would…
- [Low] The patch changes the ownership contract of __stmmac_open().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a failed
  internal reopen leaves the netdev IFF_UP/netif_running() while the…

--

net: stmmac: release descriptor resources through priv->dma_conf on open failure

After __stmmac_open() copies the temporary dma_conf, it now releases the
descriptor resources through priv->dma_conf when it fails, so callers
only kfree() the container. When __stmmac_open() fails, stmmac_open()
now cleans up inline instead of jumping into the err_serdes label chain.
stmmac_change_mtu() no longer calls free_dma_desc_resources() itself.

> stmmac_open() no longer jumps to the serdes label chain after
> __stmmac_open() fails, as that chain would double-release the
> descriptor resources and double-put the runtime PM reference, so the
> cleanup is done inline instead.

[Severity: Low]
Is the runtime PM part of this description accurate?

After this patch __stmmac_open() makes no pm_runtime_* calls. Its error
labels only stop the DMA engines and the MAC, release PTP and free the
descriptors.

The old chain err_serdes -> err_disconnect_phy -> err_runtime_pm ->
err_dma_resources calls pm_runtime_put(priv->device) once. The new
inline block also calls it once.

The only real problem with reusing the chain seems to be the second
free_dma_desc_resources(priv, dma_conf) on the stale temporary copy.
Could the labels be rearranged, for example with one just before the
kfree(dma_conf), so the cleanup sequence isn't duplicated inline?

> Signed-off-by: Ding Hui <dinghui@lixiang.com>

[Severity: Low]
Should this have a Fixes: tag and Cc: stable?

The caller-side free through the temporary dma_conf appears to come from
commit 30134b7c47bd ("net: ethernet: stmicro: stmmac: fix possible
memory leak in __stmmac_open"). That commit removed
free_dma_desc_resources(priv, &priv->dma_conf) from __stmmac_open() and
moved the free into stmmac_open() and stmmac_change_mtu().

That commit carries Cc: stable@vger.kernel.org, so stable trees have the
same caller-side free.

Backporters would also need "net: stmmac: guard against NULL pointers
when freeing TX/RX buffers" from this series. The later
free_dma_desc_resources(priv, &priv->dma_conf) in __stmmac_release() is
only safe when the free helpers NULL their pointers.

Could the commit message also describe what the user sees? It only
mentions "stale pointers". It doesn't say that freed coherent ring
memory can still be read without locking, for example by the debugfs
reader stmmac_rings_status_show(), while IFF_UP stays set after a failed
MTU change reopen.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b02371ed2d062..cd4631efe47ab 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -4290,6 +4290,8 @@ static int __stmmac_open(struct net_device *dev,
>  	stmmac_stop_all_dma(priv);
>  	stmmac_mac_set(priv, priv->ioaddr, false);
>  
> +init_error:
> +	free_dma_desc_resources(priv, &priv->dma_conf);
>  	return ret;
>  }

[Severity: Low]
With this change, __stmmac_open() takes ownership of the descriptor
resources passed in through @dma_conf and releases them on any failure.
Both callers now only kfree() the container.

The kernel-doc above __stmmac_open() still only says:

 *  @dma_conf :  structure to take the dma data

The same phrase is used on many other helpers in this file, so it says
nothing about ownership.

Could the kernel-doc state that the callee releases the descriptor
resources on failure, so a future caller does not free them a second
time?

[ ... ]

> @@ -6384,7 +6389,6 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
>  
>  		ret = __stmmac_open(dev, dma_conf);
>  		if (ret) {
> -			free_dma_desc_resources(priv, dma_conf);
>  			kfree(dma_conf);
>  			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
>  			return ret;

[Severity: High]
This isn't a bug introduced by this patch, but what state is the device
left in when this reopen fails?

Before the reopen, __stmmac_release() has already run
stmmac_disable_all_queues(), which calls napi_disable() on every
rx/tx/rxtx NAPI. It has also freed the IRQs and the rings.

__stmmac_open() can then fail, for example on a DMA reset timeout in
stmmac_init_dma_engine(), on stmmac_rxp_config(), on PTP or EST setup,
or on stmmac_request_irq(). Every one of its error labels returns before
stmmac_enable_all_queues().

stmmac_change_mtu() then returns without clearing IFF_UP, so
netif_running() stays true.

On the next ifdown or unregister_netdev():

stmmac_release()
  __stmmac_release()
    stmmac_disable_all_queues()
      __stmmac_disable_all_queues()
        napi_disable(&ch->rx_napi)

This calls napi_disable() a second time on a NAPI that is already
disabled. napi_disable_locked() in net/core/dev.c loops:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

Those bits are still set from the first disable. Can this spin forever
with RTNL held?

stmmac_suspend() also trusts netif_running() and reaches the same
napi_disable() while holding priv->lock, so system suspend looks like it
would hang too.

stmmac_reinit_ringparam() and stmmac_reinit_queues() release the device
and then call stmmac_open() the same way. If that stmmac_open() fails,
its error path has already dropped the runtime PM reference and
disconnected the PHY. A later stmmac_release() would do both again.

The hang hides some other problems. The memcpy() in __stmmac_open()
overwrites priv->dma_conf.tx_queue[].txtimer with the kzalloc'ed zeros.
On a stmmac_hw_setup(), PTP or EST failure, stmmac_init_coalesce()
never sets the timer up again, so the hrtimer_cancel() in
__stmmac_release() would act on an uninitialized hrtimer.

stmmac_free_irq(REQ_IRQ_ERR_ALL) would also run on IRQs that were never
requested.

This patch makes the repeated free_dma_desc_resources(priv,
&priv->dma_conf) safe because the free helpers NULL the pointers. The
last patch in the series only guards the debugfs reader. Nothing in the
series seems to handle a device that still reports running after it has
been torn down.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106090507.1020751-1-dinghui1111%40163.com
