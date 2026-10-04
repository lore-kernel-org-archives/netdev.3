Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3598360EF0;
	Sun,  4 Oct 2026 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791104589; cv=none; b=GgdSuQDDHkoUvqb/yexLEyBE8eEEm27NrKiqIBOmWF7xLAgMFY/eyl9TLmf4VT20lrcxdJI9DHTvvhtqqexs8t30Q1pR3OnNbOYSqqHBNk3l6XGWCE+egrTZqpl3h7niPljg6l37QavyYsqm+PbNRcXnr8hmC0+vQEUuCyRZg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791104589; c=relaxed/simple;
	bh=dAyplgO00n0HEE4zcitkVirRbAzdiXQ9O/lh88MDHWE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ilrk/K/BIyYQyyL33i2rJPdK6NZf40FtbJrwE6bfYOs9ODYYKX2k5+xL4NP7YOHCFobfF8QLGO049wNd+SGPqo0DoMwvpxyD1CFoqQ+3GPWn+/gkExUSsftk11MiHoXZ5N89mf1rbrTw8VCjIL1YcA50BJj1eQ8OnaDZ20zyyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qorac9m/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qorac9m/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879211F000FF;
	Sun,  4 Oct 2026 09:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791104587;
	bh=Y8NJ7FC8c8jGtpz584cECOONAAKeTFL6PMZgV0gSdks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qorac9m/ftUJFq+xKEyHwMnY5sC5XRrwuHuiDvSOjQ6xI7D8Xk1w6wpeyNwY6u5zm
	 xdSgiKm54nxhmCkr0rs3fbEo+NZkula/HFZkJwdAJlWUvZ/KKdN7DsNLb8WrfKX4ND
	 qDi+bkT+5Sog3mLGqw/nCRyHtc0IPEFS82duSOuUnrUNsTtBJF926Eyc3RFQyY0mD+
	 0I5GucphIlOwcoNlMXopQ44vd7G5T2fkL52X8/u2l7+NeWCHgRyzTFkBs9qsPpJIvq
	 oF+sR0P2HLUj4JjB1Jyvrm30WMp7TwRjp7QYTakohmfrfh1lxWlf09GFqdWmFdh9o+
	 a3ZOQF914O7PQ==
Subject:
 Re: [PATCH net v3 2/7] net: fec: release IRQs before dependent resources
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
Date: Sun, 04 Oct 2026 09:03:05 +0000
Message-ID: <179110458503.434549.14613784745596683672@kernel.org>
In-Reply-To: <20261003085940.493951-3-yaojiale02@163.com>
References: <20261003085940.493951-3-yaojiale02@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves out the PPS/1588 timer IRQ, which is also devm-
  managed.
- [High] fec_drv_remove() still calls
  cancel_work_sync(&fep->tx_timeout_work) first.
- [Low] fec_drv_remove() bounds its new disable_irq() loop by calling
  fec_enet_get_irq_cnt(pdev) again, instead of using the number of IRQs…

--

net: fec: release IRQs before dependent resources

In fec_drv_remove(), this commit masks the FEC interrupt sources and calls
disable_irq() on the main FEC IRQs before unregister_netdev(). It adds the
same cleanup to the fec_probe() error path. It also switches to
devm_alloc_etherdev_mqs() so the netdev stays alive until the devm-managed
IRQs are released.

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 794ec427b0ee6..b0fc5b39c748d 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c

[ ... ]

> @@ -5502,7 +5501,15 @@ fec_drv_remove(struct platform_device *pdev)
>  	cancel_work_sync(&fep->tx_timeout_work);
>  	if (fep->bufdesc_ex)
>  		fec_ptp_stop(pdev);
> +	if (ret >= 0)
> +		fec_irqs_disable(ndev);
> +	irq_cnt = fec_enet_get_irq_cnt(pdev);

[Severity: Low]
Should this reuse the number of IRQs that probe actually requested, instead
of computing it again?

fec_enet_get_irq_cnt() maps any platform_irq_count() result <= 0 to 1. That
includes -EPROBE_DEFER:

	else if (irq_cnt <= 0)
		irq_cnt = 1;	/* At least 1 irq is needed */

Say a later interrupt's parent deferred at probe time while index 0
resolved. Then probe requests only fep->irq[0] and still succeeds. At remove
time the count can be larger, so the loop below would call disable_irq() on
fep->irq[1] and fep->irq[2]. Both are still 0.

On ARM32 with SPARSE_IRQ, that raises the depth of descriptor 0 and calls
synchronize_irq(0). On arm64 it does nothing.

> +	for (i = 0; i < irq_cnt; i++)
> +		disable_irq(fep->irq[i]);

[Severity: High]
The commit message says the patch will "disable each IRQ" before
unregistering the netdev. Does this loop also cover the PPS interrupt?

fec_ptp_init() requests a separate devm-managed IRQ, and its number is never
stored in fep->irq[]:

drivers/net/ethernet/freescale/fec_ptp.c:fec_ptp_init() {
    ...
	irq = platform_get_irq_byname_optional(pdev, "pps");
	if (irq < 0)
		irq = platform_get_irq_optional(pdev, irq_idx);
    ...
	if (irq >= 0) {
		ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
				       0, pdev->name, ndev);
    ...
}

So this IRQ stays enabled until devres runs after fec_drv_remove() returns.
Writing 0 to FEC_IMASK in fec_irqs_disable() does not gate it either. The
timer channel interrupt is armed by FEC_T_TIE in FEC_TCSR(pps_channel).

fec_ptp_stop() also runs before any IRQ is disabled here. It calls
ptp_clock_unregister() without synchronizing the PPS IRQ. Meanwhile,
fec_pps_interrupt() checks pps_enable without taking a lock:

	if (fep->pps_enable) {
		event.type = PTP_CLOCK_PPS;
		ptp_clock_event(fep->ptp_clock, &event);

Could a handler already running on another CPU use the ptp_clock after it
has been freed?

In PTP_CLK_REQ_PEROUT mode, pps_enable is 0. fec_ptp_stop() then only
cancels the hrtimer, and FEC_TCSR keeps TIE set in toggle mode. On
FEC_QUIRK_HAS_MULTI_QUEUES parts, fec_stop() also turns EN1588 back on.

Could fec_pps_interrupt() still readl()/writel() FEC_TCSR/FEC_TCCR after
fec_drv_remove() disables clk_ahb and clk_ipg further down?

The new probe unwind has the same gap:

failed_irq:
	fec_irqs_disable(ndev);
	while (i--)
		disable_irq(fep->irq[i]);
	fec_enet_deinit(ndev);
failed_init:
	if (fep->bufdesc_ex)
		fec_ptp_stop(pdev);

fec_ptp_init() runs before fec_enet_init(). The PPS IRQ is therefore still
live through fec_ptp_stop() and through the clock disables at
failed_regulator.

Would it make sense to store the PPS IRQ number and disable_irq() it before
fec_ptp_stop()? FEC_TCSR could also be cleared for the PEROUT case. Nothing
later in the series seems to touch fec.

>  	unregister_netdev(ndev);

[Severity: High]
cancel_work_sync(&fep->tx_timeout_work) has already run at this point. The
IRQs are now disabled while the netdev is still registered and running. Can
the TX watchdog queue tx_timeout_work again in this window?

With the IRQs disabled, fec_enet_interrupt() can no longer schedule NAPI, so
TX descriptors are not reclaimed. Under traffic, fec_enet_start_xmit()
eventually stops the queue.

Suppose unregister_netdev() waits for RTNL longer than watchdog_timeo
(TX_TIMEOUT). The chain would then be:

dev_watchdog()
  fec_timeout()
    schedule_work(&fep->tx_timeout_work);

Nothing cancels or flushes the work after this. Once unregister_netdev()
drops RTNL, fec_enet_timeout_work() runs:

	rtnl_lock();
	if (netif_device_present(ndev) || netif_running(ndev)) {
		napi_disable(&fep->napi);
		netif_tx_lock_bh(ndev);
		fec_restart(ndev);

netif_device_present() is still true after unregister. The work therefore
calls napi_disable() on a NAPI that fec_enet_close() has already disabled.

Would napi_disable_locked() then spin forever with RTNL held?

The work could also run later still. The netdev is now freed by devres
(devm_alloc_etherdev_mqs()), so it would then use fep after the netdev has
been freed.

Before this patch, this path needed a real TX hang. Now normal TX traffic
plus RTNL contention looks like enough. Should tx_timeout_work be cancelled
again after unregister_netdev()? Alternatively, the IRQs could be disabled
only after the device has been closed.

> +	/* fec_stop() enables the default interrupt mask. */
> +	if (ret >= 0)
> +		fec_irqs_disable(ndev);
>  	fec_enet_mii_remove(fep);
>  	if (fep->reg_phy)
>  		regulator_disable(fep->reg_phy);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261003085940.493951-2-yaojiale02%40163.com
