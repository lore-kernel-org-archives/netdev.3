Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21453644A0;
	Wed, 30 Sep 2026 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790740145; cv=none; b=NRBiDFgQkU0qK4qJj6JtH53VD2yCrSFGtrxLJVvRUgoC7bcqW1PVPKa8mljcK/W27yafgFFhz33EAzPXCGcE/gpoU6fwha/VkC4ROFqkGJe1/jzno82boCYBp4N5nuk0x0BHLxpeeT9gZqg+83AUq/YCSeIWdXec8rTY7IZXrjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790740145; c=relaxed/simple;
	bh=9Le2KxT+VYexq+vQhvruVkYFfqFerokDRKFjRMsICW4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRfk+VVDMZlfzU65bXnN0lZ4lMUQ89KYYuZfXVmqm7pHGO30kyyC3iWBF3OjmPJ3hHMRBrWknZS9MbpoJABOOvBZyJTvOj2ygDo7LIVSFg6/yUgXy4ecQnPJH08jqlANDhdQsbpaCrMUbPh2ab2pYEcEQzd3d0Bkz7ju9svLuMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHBKfITo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHBKfITo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982191F000FF;
	Wed, 30 Sep 2026 03:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790740142;
	bh=uwYxOlYaRy0JawN8t68wZ184dVX51q25nN0Cl6SVY2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XHBKfITo+bdKjw9RhxtbA/bqwGrKYv146YYiipyaXNssGbLVEb+GLwHxuZsewz3HH
	 P8iLIbsI9zz8yc655fk0UmXog3pbgctG9/RdZ4kS2Q287DeuRKD0Rk8hFbDqNK3aUe
	 zlpyrL27Qp/1nNs3JSKm9XjUZsAqMVy6lMbGmY5RhzF84f8gut0H1NbYpPT73Ldb6j
	 3x+EHhyWUQ77Ukt28cYopj1DL4aO1WuGNHcZ0EffD4N9g2Scxfy5wOTfJj7pzJP+/N
	 1ePozIC+N6ZTYcCc4Jb8S6L1Fcjgx3Rxfvv++K2CdqlRk2ybplPRR42GB2T/O2bPP5
	 X2QWV3K4Upuxg==
Subject: Re: [PATCH v2 6/7] net: ravb: fix resource teardown ordering
From: netdev-bot+sashiko@kernel.org
To: yaojiale02@163.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 shenjian15@huawei.com, shaojijie@huawei.com, niklas.soderlund@ragnatech.se,
 paul@pbarker.dev, bh74.an@samsung.com, linux@armlinux.org.uk,
 nicolas.ferre@microchip.com, soren.brinkmann@xilinx.com,
 fabio.estevam@freescale.com, arnd@arndb.de, zhangfei.gao@linaro.org,
 dingtianhong@huawei.com, xuejiancheng@hisilicon.com, lidongpo@hisilicon.com,
 mitsuhiro.kimura.kc@renesas.com, sergei.shtylyov@cogentembedded.com,
 s.shtylyov@omp.ru, claudiu.beznea.uj@bp.renesas.com, vipul.pandya@samsung.com,
 ks.giri@samsung.com, siva.kallam@samsung.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org
Date: Wed, 30 Sep 2026 03:49:00 +0000
Message-ID: <179074014016.434549.12083516734545192816@kernel.org>
In-Reply-To: <20260927144741.1320558-7-yaojiale02@163.com>
References: <20260927144741.1320558-7-yaojiale02@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 (3) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch rests on the commit-message claim that "A running
  interface already holds a runtime PM reference ... A resume failure…
- [Medium] The commit says it fixes the probe error paths, but in the
  early ones the IRQ handler can still make an invalid access.
- [Medium] When pm_runtime_resume_and_get() fails in ravb_remove(), the
  patched code now carries on to ravb_mdio_release() (line 3161) instead…
- [Low] The first Fixes: tag is wrong.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but ravb_close()
  returns early when ravb_set_opmode(ndev, CCC_OPC_RESET) fails (lines…
- [Medium] This problem wasn't introduced by this patch, but if
  ravb_set_opmode(ndev, CCC_OPC_CONFIG) fails in ravb_probe() (lines…
- [Medium] This problem wasn't introduced by this patch, but
  ravb_interrupt() (and the other ravb handlers) call…
- [Low] This problem wasn't introduced by this patch, but the
  ravb_probe() error path calls pm_runtime_put(&pdev->dev) (async, line…

--

net: ravb: fix resource teardown ordering

This patch puts the ravb IRQs in a dedicated devres group. The group is
released before free_netdev() in ravb_remove() and in the ravb_probe()
error paths. ravb_remove() also keeps tearing down when
pm_runtime_resume_and_get() fails, and skips only the matching runtime
PM put.

> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")

[Severity: Low]
Is c156633f1353 the right commit for the first Fixes: tag?

In c156633f1353 the open path took the IRQ with request_irq(), and the
close path released it with free_irq(ndev->irq, ndev). So
unregister_netdev() had already freed it before free_netdev() ran.

The window comes from the devm-managed IRQ that uses ndev as dev_id, in
ravb_setup_irq():

    error = devm_request_irq(dev, irq_num, handler, flags, devname, ndev);

git blame points at 32f012b8c01c ("net: ravb: Move getting/requesting
IRQs in the probe() method"). Should the tag be this instead?

Fixes: 32f012b8c01c ("net: ravb: Move getting/requesting IRQs in the probe() method")

The current tag selects stable trees back to v4.2. Those trees have no
ravb_setup_irqs() and free the IRQs in ndo_stop. The second tag,
48f894ab07c4, looks right for the early return in ravb_remove().

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index ea1c7e536791e..a25f5ac7062fc 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2963,28 +2963,35 @@ static int ravb_probe(struct platform_device *pdev)
>  		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
>  	}
>  
> +	if (!devres_open_group(&pdev->dev, priv, GFP_KERNEL)) {
> +		error = -ENOMEM;
> +		goto out_reset_assert;
> +	}
> +
>  	error = ravb_setup_irqs(priv);
>  	if (error)
> -		goto out_reset_assert;
> +		goto out_release_irqs;
> +
> +	devres_close_group(&pdev->dev, priv);
>  
>  	priv->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(priv->clk)) {
>  		error = PTR_ERR(priv->clk);
> -		goto out_reset_assert;
> +		goto out_release_irqs;
>  	}

[Severity: Medium]
Can the IRQ handler still make an invalid access when this path reaches
out_release_irqs?

The IRQs are live once devres_close_group() returns. ravb_probe() maps
priv->addr and initialises priv->lock only later:

    priv->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
    ...
    spin_lock_init(&priv->lock);

These failures reach devres_release_group() while priv->addr is still
NULL:

- the clock lookup failures here, including -EPROBE_DEFER
- the pm_runtime_resume_and_get() failure

The ioremap failure also reaches it, with an ERR_PTR in priv->addr.

On single-IRQ variants, ravb_setup_irq() requests the line with
IRQF_SHARED. Under CONFIG_DEBUG_SHIRQ, __free_irq() calls the handler of
a shared action:

kernel/irq/manage.c:__free_irq() {
    ...
	if (action->flags & IRQF_SHARED) {
		local_irq_save(flags);
		action->handler(irq, dev_id);
		local_irq_restore(flags);
	}
    ...
}

A real interrupt from another device on the same line would do the
same.

ravb_interrupt() only checks pm_runtime_active(). That returns true when
runtime PM is not enabled yet, and also after out_rpm_disable has
disabled it:

ravb_interrupt() {
    ...
	pm_runtime_get_noresume(dev);

	if (unlikely(!pm_runtime_active(dev)))
		goto out_rpm_put;

	spin_lock(&priv->lock);
	/* Get interrupt status */
	iss = ravb_read(ndev, ISS);
    ...
}

The handler then takes an uninitialised spinlock and does ioread32()
through a NULL or ERR_PTR base. Before this patch the same call hit a
freed ndev.

Would it be better to request the IRQs after the MMIO mapping and
spin_lock_init()?

[ ... ]

> @@ -3124,6 +3131,8 @@ static int ravb_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);

[Severity: Low]
This isn't a bug introduced by this patch, but the out_rpm_put label just
above calls the async put and then disables runtime PM right away:

out_rpm_put:
	pm_runtime_put(&pdev->dev);
out_rpm_disable:
	pm_runtime_disable(&pdev->dev);

Can __pm_runtime_barrier() in pm_runtime_disable() cancel the queued
idle request? If so, ravb_runtime_suspend() and the genpd callbacks
never run before probe fails.

ravb_remove() already uses pm_runtime_put_sync_suspend() here. Should the
probe error path use a synchronous put too?

[Severity: Medium]
This is a pre-existing issue, but does ravb_probe() leak priv->desc_bat
when ravb_set_opmode(ndev, CCC_OPC_CONFIG) fails?

	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
	if (error)
		goto out_rpm_put;

In the error path, the only dma_free_coherent() of desc_bat is under
out_reset_mode, which comes before out_rpm_put:

out_reset_mode:
	ravb_set_opmode(ndev, CCC_OPC_RESET);
	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
			  priv->desc_bat_dma);
out_rpm_put:

The allocation is not devres-managed and is not in the new IRQ group.

>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	clk_unprepare(priv->refclk);
> +out_release_irqs:
> +	devres_release_group(&pdev->dev, priv);
>  out_reset_assert:
>  	reset_control_assert(rstc);
>  out_free_netdev:
> @@ -3141,9 +3150,10 @@ static void ravb_remove(struct platform_device *pdev)
>  
>  	error = pm_runtime_resume_and_get(dev);
>  	if (error < 0)
> -		return;
> +		dev_warn(dev, "failed to resume device: %d\n", error);
>  
>  	unregister_netdev(ndev);

[Severity: High]
Can unregister_netdev() call ravb_close() a second time when the resume
above fails?

The commit message says:

  A running interface already holds a runtime PM reference, so the extra
  get cannot invoke a failing resume. A resume failure therefore occurs
  while the interface is down and ndo_stop() will not be called.

A failed system resume seems to break that assumption. With WoL
disabled, ravb_suspend() closes the interface directly and leaves
IFF_UP set:

ravb_suspend()
    netif_device_detach(ndev);
    ravb_close(ndev);
        napi_disable(&priv->napi[RAVB_BE]);
        pm_runtime_put_autosuspend(dev);
    pm_runtime_force_suspend(&priv->pdev->dev);
    reset_control_assert(priv->rstc);

If ravb_resume() then fails in reset_control_deassert(), it returns
before pm_runtime_force_resume() and ravb_open():

	ret = reset_control_deassert(priv->rstc);
	if (ret)
		return ret;

That leaves runtime PM disabled with RPM_SUSPENDED status. The
interface is still IFF_UP but closed, NAPI is disabled, and no PM
reference is held. A pm_runtime_force_resume() failure leaves a similar
state.

On a later unbind, pm_runtime_resume_and_get() here returns -EACCES
every time. Before this patch ravb_remove() returned at that point. It
now continues into unregister_netdev().

__dev_close_many() calls ndo_stop for any IFF_UP device, even after
netif_device_detach().

The second ravb_close() then does the following on an IP that is
clock-gated and held in reset:

- writes RIC0/RIC2/TIC/ECSIPR
- runs ravb_ptp_stop() and ravb_stop_dma()

It then calls napi_disable() on a NAPI instance that was never
re-enabled, and napi_disable_locked() loops forever:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

Wouldn't that hang removal with RTNL and the netdev instance lock held?

Past that point, ravb_ring_free() would call page_pool_destroy() again
on the stale priv->rx_pool[q]. pm_runtime_put_autosuspend() would also
underflow the usage count.

Also, with runtime PM disabled, pm_runtime_active() returns true. The
shared-IRQ handlers are then no longer kept off the unpowered hardware
until devres_release_group() runs.

A similar double close could already happen when the resume here
succeeds after a failed system resume. The failing-resume path is new
with this patch. The if (error >= 0) check covers only ravb_remove()'s
own put, not these other states.

> +	devres_release_group(dev, priv);

[Severity: Medium]
This isn't a bug introduced by this patch, but is the runtime PM check in
the ravb IRQ handlers safe against a concurrent runtime suspend?

ravb_interrupt() and the other ravb handlers do this without holding
dev->power.lock:

	pm_runtime_get_noresume(dev);

	if (unlikely(!pm_runtime_active(dev)))
		goto out_rpm_put;

rpm_suspend() checks usage_count and sets RPM_SUSPENDING within one
dev->power.lock critical section. The handler's increment and status
read can both fall in the window between those two steps.

The handler then reads ISS and other registers while
ravb_runtime_suspend() calls clk_disable(priv->refclk) and genpd gates
the clocks.

ravb_runtime_suspend() also has no synchronize_irq(), even though the
main IRQ is IRQF_SHARED.

Would using pm_runtime_get_if_active() in the handlers and adding
synchronize_irq() to ravb_runtime_suspend() close this?

>  	if (info->nc_queues)
>  		netif_napi_del(&priv->napi[RAVB_NC]);
>  	netif_napi_del(&priv->napi[RAVB_BE]);

[Severity: Medium]
When pm_runtime_resume_and_get() has failed, what happens to the MDIO
accesses in the ravb_mdio_release() call that follows?

ravb_mdio_release() calls mdiobus_unregister(), and PHY teardown issues
MDIO transactions:

ravb_mdio_release()
  mdiobus_unregister()
    phy_remove()
      phy_leds_unregister()
        led_classdev_unregister()
          led_set_brightness(led_cdev, LED_OFF)
      phydev->drv->remove(phydev)

On ravb, MDIO is bit-banged through the AVB PIR register:

ravb_mdio_ctrl()
	ravb_modify(priv->ndev, PIR, mask, set ? mask : 0);

ravb_get_mdio_data()
	return (ravb_read(priv->ndev, PIR) & PIR_MDI) != 0;

Because the resume failed, the module clock/refclk is still gated. After
a failed system resume the reset may also still be asserted.

In that state, writes to PIR would be lost. Reads would return garbage
that mdio-bitbang treats as valid. On SoCs that fault on access to a
stopped module, this could raise a bus error.

The commit message only argues that ndo_stop() will not be called.
Should this path skip or otherwise handle the register accesses made by
MDIO teardown?

> @@ -3153,7 +3163,8 @@ static void ravb_remove(struct platform_device *pdev)
>  	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
>  			  priv->desc_bat_dma);
>  
> -	pm_runtime_put_sync_suspend(&pdev->dev);
> +	if (error >= 0)
> +		pm_runtime_put_sync_suspend(&pdev->dev);

[Severity: Medium]
This is a pre-existing issue, but ravb_close() returns early when the
switch to reset opmode fails:

	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
	if (error)
		return error;

	pm_runtime_put_autosuspend(dev);

Does that leak the runtime PM reference taken by
pm_runtime_resume_and_get() in ravb_open()?

The core ignores the return value of ndo_stop. The interface goes down
while the device stays RPM_ACTIVE.

The get/put pair here in ravb_remove() only balances its own reference.
The device would then never be runtime-suspended before
pm_runtime_disable().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927144741.1320558-1-yaojiale02%40163.com
