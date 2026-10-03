Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B475C3264C8;
	Sat,  3 Oct 2026 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034567; cv=none; b=FITXrK51ddIyEm4A0S/IFWXaBZYao5LDwZxp+MXu9gw0J3mcx6yMHis78LSKkuUJ0GvtvLoieSS0I+FIK2BsO+hVdpTHx1zszeAU8EXyUFVSoWYFs6CyWPnr3YlsgqlvSIrWUw6vnXzXiN6iSzUofHPi2nuAY1CDoD17hmfDk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034567; c=relaxed/simple;
	bh=JBPPMuSFY1AeHOz1oZWMnNV8GnVSWMgsofPQ0hB2fls=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D6u7mjJZDBsianWrA5njf4/TaFLykJjmIzNM3fLrrwlZEl/qGBbDP6hnRR3aK8EK0IygyudxBh8Hs8IDGdj4gdUaJpp5/xoZ80KzMVI0sFAS2ZY+krhR6vVqIOF3/8qDQrO+qbX0g80u48Jd8dzGjng9ktX/JWDCwJzKh7TQ+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlu42dZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlu42dZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EAA1F0089B;
	Sat,  3 Oct 2026 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791034565;
	bh=eLi9Q1exXHxiieKQ9YkEJtTbCCx6tGeM4MsyNWyLbmc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wlu42dZEaC8Nj9e2lDRn/3LsOY+A+qk4YoG0oW0MIpNVPMoIhlnJR4q6oq0x33Dx4
	 NBXQwIJu3VbrHvOuMX5qbBp0IWNSTZWUDiPf/iglcQ/TTBcNaQ5llMLv80ZKlM4SMe
	 mCEK2RVackaTpTj0fSqVGuNK1jCeESuK2ySib2HWd4FHTRk5/DsB4Gud9zG8f92KCF
	 SnSLpDLkSBZbblgYOcTFQZMD/ziPygIN+/xAUkTBaiwOD5ZH0EKCwSarbyOuJ0j/GS
	 VXryd0rN3weYSHdzqgDT9whztd+nBqHaAFJpFC89ga1GB1FUjXUKhv/f85JlWYszuU
	 ByHBimKzwi3dA==
Subject: Re: [PATCH net-next v4 3/4] microchip: lan865x: enable PHY interrupt
 via virtual IRQ
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Sat, 03 Oct 2026 13:36:04 +0000
Message-ID: <179103456432.434549.13449502518598571771@kernel.org>
In-Reply-To: <20260929125928.611784-4-parthiban.veerasooran@microchip.com>
References: <20260929125928.611784-4-parthiban.veerasooran@microchip.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch sets OA_TC6_PHY_INT for LAN865X, which moves the
  internal PHY from phylib polling to interrupt mode.

--

microchip: lan865x: enable PHY interrupt via virtual IRQ

This patch passes the OA_TC6_PHY_INT quirk flag to oa_tc6_init() from
lan865x_probe(). The internal LAN865X PHY then runs phylib in interrupt
mode through the oa_tc6 virtual IRQ, so CDEN follows PLCA transitions via
lan86xx_handle_interrupt() and no longer depends on the polling fallback.

> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> index 127afb9e9f141..d47560f9847d5 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c

[ ... ]

> @@ -346,7 +347,8 @@ static int lan865x_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, priv);
>  	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
>  
> -	priv->tc6 = oa_tc6_init(spi, netdev, NULL);
> +	tc6_quirks.quirk_flags = OA_TC6_PHY_INT;
> +	priv->tc6 = oa_tc6_init(spi, netdev, &tc6_quirks);

[Severity: Medium]
Can one failed SPI transfer permanently stop CDEN tracking for LAN865X
once this flag is set?

With OA_TC6_PHY_INT, oa_tc6_mdiobus_register() puts tc6->phy_virq into
mii_bus->irq[]. phy_polling_mode() then returns false, and
_phy_state_machine() stops requeueing every PHY_STATE_TIME.

That means lan86xx_read_status()->lan86xx_update_cden() no longer runs
periodically. That periodic resync is the self-healing fallback added by
"net: phy: microchip_t1s: fix collision detection on PLCA status change".

In interrupt mode, oa_tc6_process_extended_status() masks PHYINT in
hardware before it schedules the worker:

drivers/net/ethernet/oa_tc6.c:oa_tc6_process_extended_status() {
    ...
	if (tc6->phy_virq && FIELD_GET(OA_TC6_STATUS0_PHY_INT, value)) {
		ret = oa_tc6_phy_irq_mask_hw(tc6);
		...
		else
			schedule_work(&tc6->phy_irq_work);
	}
    ...
}

The worker then tries to unmask it, but it only logs a failure:

drivers/net/ethernet/oa_tc6.c:oa_tc6_phy_irq_work() {
    ...
	handle_nested_irq(tc6->phy_virq);

	ret = oa_tc6_phy_irq_unmask_hw(tc6);
	if (ret)
		dev_err(&tc6->spi->dev, "Failed to unmask PHY interrupt: %d\n",
			ret);
}

Suppose the INT_MASK0 read or write in oa_tc6_phy_irq_unmask_hw() returns
an error. INT_MASK0.PHYINT then stays set in hardware, while
tc6->phy_irq_masked is still false.

After that, later PLCA status changes never raise EXST, so
lan86xx_handle_interrupt() stops running. Nothing retries or reschedules
the work, and polling is off.

The normal ifdown/ifup path (phy_stop()/phy_start()) does not go through
disable_irq()/enable_irq(), so oa_tc6_phy_irq_bus_sync_unlock() is never
called to restore the mask. Only suspend/resume or unbinding and
re-probing the driver seems to recover it.

Before this patch, the 1 second poll would have fixed CDEN shortly after
such an error. Would it make sense to retry or reschedule the unmask on
failure, or to keep some periodic CDEN resync for this case?

>  	if (IS_ERR(priv->tc6)) {
>  		ret = PTR_ERR(priv->tc6);
>  		goto free_netdev;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929125928.611784-1-parthiban.veerasooran%40microchip.com
