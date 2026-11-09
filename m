Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228649;
	b=XQkWN+AlUTgwZOSExttGbMi/fYpY32+ab6j7uEts1I22sLXFu3ahxxNqXVAH1vp2nqNc
	 Tm3lzxIJZrYV+3baFHPJNjitwt/OeIfXw1XoD4u+6aF6rcuAMeQGyI+nKwhqdfkJFIb5H
	 ugYvdiEJANv0+gWoE6ThkaiZdXZVLSQhgetel7u/KanFAkZqY2N/OXJ2P8k/1nY9OOfZz
	 ZwIDR/7A4SMO6JwIG5Vku89M9/S88n0XRIDAcP6630J8q8x3UnQRZKHOXPVPMoOQZUH7D
	 OnrGBjo6qeLVaH8H/pdYQcPXOeLLuAu8fGTUtGGMlNw9Q+82PjixDjlmYikFGWPhawQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228649;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JjNSwO4mZ69wgWNuljj9jgcvdRQfwcVoIjX8RvCsKvM=;
	b=yj9JA2eGqcKrllWdXRwsET4KApHoRgEjakvBNDPNZXt+D3bREB844XnAJzG19TxjDWnp
	 u3LODZVjyavZugVECIyW355PXQubOFSUotfcqXdkbtk90uoM+8GzNEDxAoR2IWduNFzks
	 R1IQNH35B6JfJgFx2+MJWweBip9kdXnr/5BriT1QNxY09pjPDDaC21XvNTyx+f+DfJmKg
	 td1eiL9SnY4Kt+i35jJD/tP4RgFxYNbosCFLjNBsK835RbLH+M1BnRQTcCjWWixA9QZFv
	 mGb9ecj8oPTDJaLcmX7dY8ccpMQr/ZJq9owfCcrTYxZ/dAnuTPRCwmTJB1Zc87can0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMcdWkPh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EC606A322;
	Mon,  9 Nov 2026 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMcdWkPh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF081F0089F;
	Mon,  9 Nov 2026 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228649;
	bh=JjNSwO4mZ69wgWNuljj9jgcvdRQfwcVoIjX8RvCsKvM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AMcdWkPhAWKw4Kty4An/ZtOYneJtvpJDr03C4k9f4tW0Mo6sgerdBVpzfABUh/Izz
	 RkYVqnfH+aQq6TxHIcOTPO9nHVxllQqqI5DJZKjTmZy/zYILGN0a0xlyY4h0Dr8/aa
	 5EmkN/gp8IT7gS80cbk7N/hnq86JwIN+KeT5TLtD/1Pp8NgR8gNeuWqLWiOxlArV98
	 lf9ViQfLIxjFbx23pEDq01GJDwvSkGChDztuhHnw56pwxwZMe40GVH5SoxrMhAFFpy
	 ZdM2Q1b4RIxcK6EUM6ZOYnd80/6fgCvOEJUEB5mFrxshCiSW9wYfunJjU88fCRa7cI
	 Cw5wlVwLKqaug==
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
From: netdev-bot+sashiko@kernel.org
To: alitariq45892@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, dlan@kernel.org,
 troy.mitchell@linux.spacemit.com, wangruikang@iscas.ac.cn, amadeus@jmu.edu.cn,
 s-vadapalli@ti.com, tmshlvck@gmail.com, meatuni001@gmail.com,
 vadim.fedorenko@linux.dev, maxime.chevallier@bootlin.com,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 12:50:47 +0000
Message-ID: <179422864754.994134.12281861683384047552@kernel.org>
In-Reply-To: <20261105123441.2524171-1-alitariq45892@gmail.com>
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Possible ABBA deadlock between rtnl_mutex and the TX-timeout
  work, added to the suspend path.
- [Medium] The new RTNL section does not cover the netif_running() check
  that decides whether to call emac_stop()/emac_open().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is High
  severity and involves the same work/RTNL pair.
- [High] This problem wasn't introduced by this patch, but it is High
  severity and sits in the function the patch modifies.

--

net: spacemit: Hold RTNL lock in emac_resume() and emac_suspend()

This patch takes rtnl_lock() around the emac_open() call in emac_resume()
and around the emac_stop() call in emac_suspend(). The aim is to silence
a lockdep "suspicious RCU usage" warning from phy_disconnect(), which
reads a pointer with rtnl_dereference().

> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
> index 71a80838bffd0..aca25a9e1e9ef 100644
> --- a/drivers/net/ethernet/spacemit/k1_emac.c
> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
> @@ -2033,7 +2033,10 @@ static int emac_resume(struct device *dev)
>  	if (!netif_running(ndev))
>  		return 0;
>  
> +	rtnl_lock();
>  	ret = emac_open(ndev);
> +	rtnl_unlock();
> +
>  	if (ret) {
>  		clk_disable_unprepare(priv->bus_clk);
>  		return ret;

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. It sits
in the function being changed, though. What state is the device left
in when emac_open() fails here?

By this point the unwind in emac_open() has freed the TX/RX rings. One
of two things has also happened:

- emac_up() failed, and its error path called phy_disconnect() and
  pm_runtime_put_sync().
- emac_phy_connect() failed, and ndev->phydev is still NULL from the
  previous suspend.

The IRQ is not requested and NAPI is disabled. emac_resume() then gates
bus_clk and returns, but __LINK_STATE_START and IFF_UP are still set.

The next "ip link set down", unregister, or emac_suspend() (which sees
netif_running() as true) would then run:

emac_stop()
  emac_down()
    phy_disconnect(ndev->phydev)   <- phydev is NULL
      phy_is_started(phydev)       <- dereferences phydev->state

Can this oops?

Past that point, emac_down() would:

- write MAC registers with the bus clock gated
- call free_irq() on an IRQ that is not requested
- call napi_disable() on a NAPI that is already disabled
- underflow the runtime PM usage count

Also, emac_clean_rx_desc_ring() would index the NULL rx_desc_buf, and
emac_suspend() would call clk_disable_unprepare(priv->bus_clk) a second
time.

Separately, emac_alloc_tx_resources() and emac_alloc_rx_resources()
kfree() the buffer array when dma_alloc_coherent() fails, but they do
not set the pointer to NULL:

	if (!tx_ring->desc_addr) {
		kfree(tx_ring->tx_desc_buf);
		return -ENOMEM;
	}

Could a later teardown free tx_desc_buf (or rx_desc_buf) a second time
through that stale pointer?

> @@ -2056,7 +2059,9 @@ static int emac_suspend(struct device *dev)
>  		return 0;
>  	}
>  
> +	rtnl_lock();
>  	emac_stop(ndev);
> +	rtnl_unlock();

[Severity: Medium]
emac_suspend() checks netif_running() to decide whether to call
emac_stop(). That check runs before rtnl_lock() and is not repeated
under the lock:

	if (!ndev || !netif_running(ndev)) {
		clk_disable_unprepare(priv->bus_clk);
		return 0;
	}

	rtnl_lock();
	emac_stop(ndev);

Can another RTNL holder close the device in between?

Here is one example. The netdev is moved into a netns, and that netns
is torn down as system sleep starts. cleanup_net runs on netns_wq,
which is not freezable. It holds RTNL and calls dev_close(), which
calls emac_stop().

Meanwhile emac_suspend() has already seen netif_running() as true. It
blocks in rtnl_lock(), then runs emac_stop() a second time. There,
emac_down() calls phy_disconnect(ndev->phydev) with phydev already
NULL, and phy_is_started() dereferences it.

emac_resume() has the mirror case. It also tests netif_running() before
rtnl_lock(), so it could call emac_open() on a device that was just
closed. That would leak the rings, the IRQ and the PHY attach.

Would it make sense to take rtnl_lock() before the netif_running()
test, with netif_device_detach() / netif_device_attach() inside the
same locked section?

[Severity: Medium]
Does holding RTNL here invert the lock order with tx_timeout_task?
emac_stop()->emac_down() does:

	cancel_work_sync(&priv->tx_timeout_task);

and the work handler takes RTNL first:

emac_tx_timeout_task() {
	...
	rtnl_lock();
	...
}

emac_tx_timeout() queues the work with schedule_work(). That uses the
system workqueue, which is not freezable, so the work can run during
system suspend:

CPU1 (worker)                      CPU2 (suspend)
emac_tx_timeout_task()
                                   emac_suspend()
                                     rtnl_lock()
  rtnl_lock()  <- blocks
                                     emac_stop()
                                       emac_down()
                                         cancel_work_sync()
                                           <- waits for CPU1

cancel_work_sync() goes through __flush_work()->start_flush_work().
That finds the executing worker with find_worker_executing_work() and
waits on a barrier queued behind it.

Can this hang suspend? Lockdep may also report a circular dependency
between rtnl_mutex and the work's lockdep_map, which would swap one
splat for another.

The ndo_stop path (dev_close() under RTNL, then emac_stop()) already
has this pattern. This patch adds it to the system sleep path too.

Could the synchronous cancel be kept out of any RTNL-held section?
Options include cancelling the work before taking RTNL, using
rtnl_trylock() and requeueing in the work, or a disable_work() based
scheme.

[Severity: High]
This isn't a bug introduced by this patch, but it involves the same
work and RTNL pair. Can emac_tx_timeout_task() wait on itself?

emac_tx_timeout_task()          <- running as priv->tx_timeout_task
  rtnl_lock()
  dev_close(ndev)
    __dev_close_many()
      emac_stop()               <- ndo_stop
        emac_down()
          cancel_work_sync(&priv->tx_timeout_task)

At this point the work is executing, not queued. start_flush_work()
finds the calling worker itself through find_worker_executing_work().
It then inserts a barrier that can only run after the current work
returns, so wait_for_completion() in __flush_work() never returns.

Would every TX timeout recovery leave the worker stuck while holding
rtnl_mutex? That would block every RTNL user. With this patch, the next
emac_suspend() would also block forever in its new rtnl_lock().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105123441.2524171-1-alitariq45892%40gmail.com
