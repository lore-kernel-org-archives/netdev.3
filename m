Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4A49B1EF;
	Mon, 28 Sep 2026 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591001; cv=none; b=qq9pKhcYK6u0KZ7Y/Yrcix+mzJIfFi0gynJYAfKrPzsiMVyh58j8QJC8lB/14yO+yuUUs5maeva7OyqF6RwU6eTiqgkSlUvgfSO4hj+1uNzOLmZmdId6OADQOukULD5cvtm9+8RGZk2cjb54jeZnhjBlWK503Xc2c1YFvh4rRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591001; c=relaxed/simple;
	bh=vbSu80ghWbPdiK10CKQKluUm32lnCYFMEbWE0ul/66U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twtpLZI0Es0RnUtTnxq9DXsU5q/DyrRfBPhalc/E+JDi3M93Oz7RSBOWh4owuRcKMzC+Sg+FlS+7flCbv+ypjl6Gh27Ws8w0PQlimnrqhIp6AP+rMvGYd89ZH81E6LanbMM5067WUweO6DOe2II6sqMLbGNRBQxZYyQ6a9sAy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0aKfkLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0aKfkLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6ADD1F000FF;
	Mon, 28 Sep 2026 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790590999;
	bh=HbrxqwlWMk7wkbkXjO/zgQgsJbR9yA4kZRKmILIPtQ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E0aKfkLZ44QttXO5f+zx+lC/CIfXsBDm6OCb190KpA/Za1QphskcYAVsRwpnu0SgE
	 /izb47RmUGIt0pj3pgZFNwIsfQfFnOFohlz40vt1PbRK4aLiiuLsaEdPTgwaqj+hKK
	 11/jlgHJlXyYXuboFLTurdciqBfc4eAxNuW1nF1vnt/ByEDM5fFcrxQHJtHBzEHmRN
	 ZsibRHnLxFjBb8eKiKQbR3xBW1vFribSh8mcpsZvlelTGcXu1plZDWzSowo/DDsCn5
	 cv8uS56vUJmoxc9uZWrus5UihUSNMDT31uczpS5TKn25NULlzzG9timQkdACLDz6jU
	 r54aVXa8y973g==
Subject: Re: [PATCH net-next v11 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 10:23:18 +0000
Message-ID: <179059099826.3145.7654211997843249181@kernel.org>
In-Reply-To: <20260924-wiznet-link-gpio-v11-3-42a332517b30@marmottus.net>
References: <20260924-wiznet-link-gpio-v11-3-42a332517b30@marmottus.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch quietly fixes a user-visible regression that commit
  dacf281771a9 ("w5100: remove unused gpio link detection") introduced.
- [Medium] In w5100_stop(), netif_stop_queue() runs before
  cancel_work_sync(&priv->restart_work).
- [Medium] w5100_open() now calls w5100_hw_reset() but ignores its return
  value.
- [Medium] w5100_suspend() now calls w5100_stop() (disable_irq(irq),
  disable_irq(link_irq), napi_disable()) but leaves __LINK_STATE_START…
- [Low] When all three PHYCFGR reads in w5500_get_phycfgr_lnk() fail,
  w5500_report_carrier_state() leaves carrier unchanged, and…

Pre-existing issues:
- [Low] Claim: making w5100_tx_timeout() always schedule restart_work
  removes the xmit exclusion that dev_watchdog() (tx_global_lock plus…

--

w5100: detect carrier state using link status bit and optional interrupt

This commit reads the w5500 PHYCFGR link status bit to detect carrier. It
adds an optional second interrupt, wired to the LINKLED pin, that triggers
carrier updates. It also reworks bring-up and teardown: register_netdev()
moves to the end of probe, the main irq is only enabled in open, and
suspend/resume now call w5100_stop()/w5100_open().

> On w5100/w5200, which lack this register, get_link() is not implemented
> and the carrier state is not reported (netif_carrier_(on|off) is not
> called).

[Severity: Medium]
Does this patch also fix a regression introduced by commit dacf281771a9
("w5100: remove unused gpio link detection")?

That commit removed the only netif_carrier_on() calls in the driver, in
w5100_open() and w5100_resume(). It kept netif_carrier_off() in
w5100_stop() and w5100_suspend(). At the baseline there is no
netif_carrier_on() anywhere in drivers/net/ethernet/wiznet/.

As a result, on every chip the first ifdown or suspend leaves
__LINK_STATE_NOCARRIER set. The interface then stays NO-CARRIER after the
next ifup or resume.

This patch makes the netif_carrier_off() calls in stop and suspend
conditional on link_irq > 0, which fixes that. However, the commit message
reads as though nothing changes for devices without a link irq, and there
is no Fixes: tag.

Could the commit message describe this as a fix and add:

Fixes: dacf281771a9 ("w5100: remove unused gpio link detection")

That way stable kernels that carry dacf281771a9 would pick it up.

> diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
> index 53d8dc642fbd..dff39ba8103c 100644
> --- a/drivers/net/ethernet/wiznet/w5100.c
> +++ b/drivers/net/ethernet/wiznet/w5100.c

[ ... ]

> @@ -345,6 +352,82 @@ static void w5500_memory_configure(struct w5100_priv *priv)

[ ... ]

> +static void w5500_report_carrier_state(struct net_device *ndev)
> +{
> +	struct w5100_priv *priv = netdev_priv(ndev);
> +	int state;
> +
> +	mutex_lock(&priv->link_lock);
> +
> +	state = w5500_get_phycfgr_lnk(ndev);
> +	if (state > 0) {
> +		netif_info(priv, link, ndev, "link is up\n");
> +		netif_carrier_on(ndev);
> +	} else if (state == 0) {
> +		netif_info(priv, link, ndev, "link is down\n");
> +		netif_carrier_off(ndev);
> +	}
> +
> +	mutex_unlock(&priv->link_lock);
> +}
> +
> +static irqreturn_t w5500_detect_link_interrupt(int irq, void *ndev_instance)
> +{
> +	struct net_device *ndev = ndev_instance;
> +
> +	if (netif_running(ndev))
> +		w5500_report_carrier_state(ndev);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Low]
What happens if all three PHYCFGR reads in w5500_get_phycfgr_lnk() fail on
the link-up edge?

In that case the carrier stays off, and w5500_detect_link_interrupt()
returns IRQ_HANDLED without scheduling a retry. A stable link produces no
further LINKLED edge, so the carrier can stay down even after SPI recovers.

w5500_get_link() might then report the link as up through ethtool, but it
doesn't update the carrier. dev_watchdog() also won't start the restart
path while the carrier is off. The only ways to recover seem to be a cable
replug or ifdown/ifup.

These errors can really happen: w5500_spi_read() passes on errors from
spi_write_then_read(), including -ENOMEM from its bounce buffer allocation.

Should a failed read schedule a later re-read of the link state?

[ ... ]

> @@ -448,12 +531,28 @@ static void w5100_restart(struct net_device *ndev)
>  {
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
> +	if (!netif_running(ndev) || !netif_device_present(ndev))
> +		return;
> +
> +	disable_irq(priv->irq);
> +	if (priv->link_irq > 0)
> +		disable_irq(priv->link_irq);
> +
>  	netif_stop_queue(ndev);
> +	w5100_hw_close(priv);
> +	flush_work(&priv->rx_work);
> +	flush_work(&priv->tx_work);
>  	w5100_hw_reset(priv);

[Severity: Low]
This isn't a bug introduced by this patch, but netif_stop_queue() doesn't
wait for an ndo_start_xmit that is already running. Can w5100_start_tx()
still queue tx_work after flush_work(&priv->tx_work) here?

w5100_start_tx() {
	...
	if (priv->ops->may_sleep) {
		WARN_ON(priv->tx_skb);
		priv->tx_skb = skb;
		queue_work(priv->xfer_wq, &priv->tx_work);
	...
}

If it can, tx_work could issue SPI transfers at the same time as
w5100_hw_reset() during tx timeout recovery. The baseline w5100_restart()
had no flush at all, so this patch narrows the window rather than opening
it.

Always scheduling restart_work in w5100_tx_timeout() doesn't change
behaviour for in-tree users. Every w5100_ops in w5100-spi.c already sets
may_sleep = true.

[ ... ]

> @@ -656,9 +753,17 @@ static int w5100_open(struct net_device *ndev)
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
>  	netif_info(priv, ifup, ndev, "enabling\n");
> +	w5100_hw_reset(priv);
> +	enable_irq(priv->irq);
>  	w5100_hw_start(priv);

[Severity: Medium]
Should the return value of w5100_hw_reset() be checked here?

w5100_hw_reset() returns -ENODEV when the RTR read-back doesn't match. This
is its only check that the chip came out of reset and is responding:

	if (w5100_read16(priv, rtr) != RTR_DEFAULT)
		return -ENODEV;

Even if the reset fails, w5100_open() does all of the following and still
returns 0:

- enables the level-low main irq
- calls w5100_hw_start(), which opens the socket and unmasks its interrupt
- enables the link irq and reports carrier from PHYCFGR

w5100_resume() now calls w5100_open() and also ignores its result. So a
failed reset after resume isn't reported either, and netif_device_attach()
still marks the interface as present.

[ ... ]

> @@ -667,13 +772,40 @@ static int w5100_stop(struct net_device *ndev)
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
>  	netif_info(priv, ifdown, ndev, "shutting down\n");
> -	w5100_hw_close(priv);
> -	netif_carrier_off(ndev);
> +
> +	disable_irq(priv->irq);
> +	if (priv->link_irq > 0)
> +		disable_irq(priv->link_irq);
> +
>  	netif_stop_queue(ndev);
>  	napi_disable(&priv->napi);
> +
> +	cancel_work_sync(&priv->restart_work);

[Severity: Medium]
Can a restart_work that is already running wake the queue again after the
netif_stop_queue() above?

w5100_restart() checks netif_running() and netif_device_present() only on
entry, and it always ends with netif_wake_queue(). w5100_tx_timeout()
schedules restart_work on system_percpu_wq, which isn't freezable:

w5100_suspend()
  netif_device_detach()
  w5100_stop()
    netif_stop_queue()
    cancel_work_sync(&priv->restart_work)   <- waits

w5100_restart() (already past its entry check)
  ...
  netif_wake_queue()                        <- clears XOFF

After suspend returns, the TX queue is awake on a detached device.

The suspend path doesn't deactivate the qdisc, and w5100_start_tx() doesn't
check netif_device_present(). A later transmit can therefore queue tx_work
on xfer_wq. xfer_wq isn't WQ_FREEZABLE, so this would issue SPI transfers
after the suspend callback has completed.

The commit message says w5100_stop() makes sure "there is no race condition
or unfinished work". Should the queue be stopped again after
cancel_work_sync() returns?

[ ... ]

> @@ -839,10 +1011,11 @@ static int w5100_suspend(struct device *dev)
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
>  	if (netif_running(ndev)) {
> -		netif_carrier_off(ndev);
> +		mutex_lock(&priv->link_lock);
>  		netif_device_detach(ndev);
> +		mutex_unlock(&priv->link_lock);
>  
> -		w5100_hw_close(priv);
> +		w5100_stop(ndev);
>  	}
>  	return 0;
>  }

[Severity: Medium]
What happens if the core calls ndo_stop between this suspend and the
matching resume?

Here w5100_stop() disables both irqs and calls napi_disable(). However,
__LINK_STATE_START stays set, and suspend takes neither rtnl nor the netdev
lock.

A kernel-initiated dev_close() can run during the suspend window, for
example from cleanup_net() on the non-freezable netns workqueue. In that
case w5100_stop() runs a second time:

__dev_close_many()
  w5100_stop()
    disable_irq(priv->irq)          <- disable depth now 2
    napi_disable(&priv->napi)
      napi_disable_locked()         <- SCHED/NPSVC still set from the
                                       first napi_disable()

napi_disable_locked() would then spin forever in usleep_range() while
holding rtnl.

After that, netif_running() is false, so w5100_resume() skips w5100_open().
The irq disable depth stays raised, and a later ifup leaves both irqs
disabled.

Before this patch, suspend only called w5100_hw_close(), which touched
neither NAPI nor the irq disable depth.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-wiznet-link-gpio-v11-0-42a332517b30%40marmottus.net
