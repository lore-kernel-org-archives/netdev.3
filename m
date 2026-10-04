Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C2418346;
	Sun,  4 Oct 2026 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791104591; cv=none; b=XmNh2bt2jquADGrZLjCpwwyRAAKlEnJ3GcegniKizpFrHeF+pUOLYkb8KTg74/CMZ/c4hTO0xx8yoJLL08KutCSFD5rpYfLVPFgsGHYGV3X9qorUlFxB8vD3X+ND+lY0c65inF61fyhbGYt7qcxehFBLggORBmbY5Wf77UuiNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791104591; c=relaxed/simple;
	bh=+8GUFTAjAciR0Q/QLfTaVRVe8TBQFljEoI1Pp3Wb2yM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ET7iKqEvGGGXWCg53Oc52jOtV3qMZG5FihD46ZUvZjDXdQ+uI9YfU+WiUNFP9MPnw6+6a4AKZsWdfPHb3bKFYCcpkjd8DbEwIPEkre+0dg/VvSrFScyRrJNswujFEiJEz7sn2CE3DyUj5g/7AgJbMl+3RcvxLTrcoLXvqYq+LXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK7U+fEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK7U+fEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1564C1F00893;
	Sun,  4 Oct 2026 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791104589;
	bh=2rAaA5FVRIQlHu+rJ7W2001hRh3YbSqf2nsZRkjv4U0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DK7U+fEohTWIjJz5gzT7KDaQ1p3vpW3G7DGDscOHvCkhv12hj3eNiWgSEVxrYwQSB
	 Nk1sJA7B4Qu9Sq2r5WB1nBeFyn8w4j2Ol/fk26C7vCfQOALrC+Awk/SkHvncKSigKm
	 qkFZFiSMt0hHgDgRiIQS8SwVyNdOvP5f86txEnYUZjEjtkQEeWxpfV2w5wq59iw6ZO
	 +wMc5jQtgKzd5sW1GfxRL7dINs1xHZFY4/ZnLpsfnwAqtS0204yVKf7iN6Mf2xVZVs
	 yabJmjQqDJa3xUwl2f4XrHI5+LAWdtrbUOO3BJuNrtQdlxyaeDcE/oEFMELDia7REl
	 8Q1vMcNE3emwA==
Subject:
 Re: [PATCH net v3 6/7] net: ravb: release managed IRQs before freeing netdev
From: netdev-bot+sashiko@kernel.org
To: yaojiale02@163.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 shenjian15@huawei.com, shaojijie@huawei.com, niklas.soderlund@ragnatech.se,
 paul@pbarker.dev, bh74.an@samsung.com, linux@armlinux.org.uk,
 soren.brinkmann@xilinx.com, nicolas.ferre@microchip.com,
 fabio.estevam@freescale.com, arnd@arndb.de, dingtianhong@huawei.com,
 zhangfei.gao@linaro.org, xuejiancheng@hisilicon.com, lidongpo@hisilicon.com,
 s.shtylyov@omp.ru, claudiu.beznea.uj@bp.renesas.com, vipul.pandya@samsung.com,
 siva.kallam@samsung.com, ks.giri@samsung.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org
Date: Sun, 04 Oct 2026 09:03:07 +0000
Message-ID: <179110458762.434549.4656958920205004630@kernel.org>
In-Reply-To: <20261003085940.493951-7-yaojiale02@163.com>
References: <20261003085940.493951-7-yaojiale02@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says the probe error paths are fixed.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch.
- [Low] This problem wasn't introduced by this patch.

--

net: ravb: release managed IRQs before freeing netdev

This commit puts the IRQs requested by ravb_setup_irqs() into their own
devres group. ravb_remove() releases the group after unregister_netdev()
and before free_netdev(). The probe error paths also release it before
free_netdev(), so the IRQ handlers should no longer see a freed netdev.

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index ea1c7e536791..ab4703888778 100644
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
> +		goto out_release_irq_group;
> +
> +	devres_close_group(&pdev->dev, priv);
>  
>  	priv->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(priv->clk)) {
>  		error = PTR_ERR(priv->clk);
> -		goto out_reset_assert;
> +		goto out_release_irq_group;
>  	}

[Severity: High]

The commit message says:

  "Probe error paths have the same ordering problem."

Can ravb_interrupt() still crash on the probe error paths that fail early?

The netdev is no longer freed before free_irq(). However, the IRQs are
still requested before priv->addr, priv->lock and runtime PM are set up.

The single IRQ variants (ravb_gen2_hw_info and gbeth_hw_info) do not set
multi_irqs. For them, ravb_setup_irq() requests a shared IRQ and passes
ndev as dev_id:

	} else {
		irq_num = platform_get_irq(pdev, 0);
		flags = IRQF_SHARED;
	}

With CONFIG_DEBUG_SHIRQ, __free_irq() calls the handler once for
IRQF_SHARED actions, so releasing the group here runs it:

ravb_probe()
  devres_release_group()
    devm_irq_release()
      free_irq()
        __free_irq()
          ravb_interrupt(irq, ndev)

A real interrupt from another device on the shared line can also run the
handler at any point in this window.

The only guard in ravb_interrupt() is:

	if (unlikely(!pm_runtime_active(dev)))
		goto out_rpm_put;

	spin_lock(&priv->lock);
	/* Get interrupt status */
	iss = ravb_read(ndev, ISS);

pm_runtime_active() returns true whenever dev->power.disable_depth is
nonzero. That is the case both before pm_runtime_enable() and after
pm_runtime_disable().

The handler then calls spin_lock() on priv->lock before spin_lock_init()
has run. It also calls ravb_read() through an invalid priv->addr:

- The devm_clk_get() failures here (including -EPROBE_DEFER), the gptp
  and refclk clock failures, and a pm_runtime_resume_and_get() failure
  all leave priv->addr NULL.

- A devm_platform_get_and_ioremap_resource() failure leaves an ERR_PTR
  in priv->addr.

Before this patch, the same handler call ran from devres_release_all()
and hit freed memory. With this patch it reads MMIO through NULL or an
ERR_PTR.

The ordering where IRQs are requested before this state is initialised
came from 32f012b8c01c, the commit in the Fixes: tag.

Could the IRQs be requested only after priv->addr, priv->lock and
runtime PM are valid, while still releasing the group before
free_netdev()? Alternatively, could ravb_interrupt() return early until
probe has finished initialising?

[ ... ]

> @@ -3124,6 +3131,8 @@ static int ravb_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	clk_unprepare(priv->refclk);
> +out_release_irq_group:
> +	devres_release_group(&pdev->dev, priv);
>  out_reset_assert:
>  	reset_control_assert(rstc);
>  out_free_netdev:

[Severity: Low]

This is a pre-existing issue, not one introduced by this patch. The
out_rpm_put path just above this hunk does an async put and then
disables runtime PM straight away:

out_rpm_put:
	pm_runtime_put(&pdev->dev);
out_rpm_disable:
	pm_runtime_disable(&pdev->dev);

Autosuspend is enabled with a 100 ms delay. The barrier inside
pm_runtime_disable() cancels the queued idle/autosuspend request, so the
driver never suspends the device itself.

Would pm_runtime_put_sync() fit better here?

The effect on the hardware is mostly limited. After a failed probe,
device_unbind_cleanup() calls dev_pm_domain_detach() with
detach_power_off. Through the Renesas CPG detach callbacks this reaches
pm_clk_destroy(), which disables the module clock, and the genpd power
off gets queued.

The commit message also says the runtime PM error handling is left
unchanged on purpose.

> @@ -3144,6 +3153,7 @@ static void ravb_remove(struct platform_device *pdev)
>  		return;
>  
>  	unregister_netdev(ndev);
> +	devres_release_group(dev, priv);

[Severity: Medium]

This isn't a bug introduced by this patch. What happens when
pm_runtime_resume_and_get() fails at the top of ravb_remove()?

	error = pm_runtime_resume_and_get(dev);
	if (error < 0)
		return;

The early return skips all of the following:

- unregister_netdev()
- the new devres_release_group()
- netif_napi_del()
- ravb_mdio_release()
- dma_free_coherent() of desc_bat
- pm_runtime_disable()
- clk_unprepare()
- reset_control_assert()
- free_netdev()

Remove returns void, so the driver core unbinds anyway, and
devres_release_all() frees the IRQs and unmaps priv->addr.

Does this leak the netdev, the MDIO bus and the desc_bat coherent DMA
buffer? Does it also leave the netdev registered on hardware that is no
longer mapped?

The ndev is never freed on this path, so the patch does not turn this
into a use-after-free.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261003085940.493951-2-yaojiale02%40163.com
