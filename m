Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500909;
	b=W0Gp1bZRMfYxEf63/JAc/P0bUmvaT31+v8vFLVWGHIYj1d331l3yz/fqZUp0ITdUzesb
	 nJEAd1/jB/HHwf/O9UMIG1RwN8PfZ3XF0nuRJ5uH8SfmpcQxdOeciZUruMGC6+sxWoN1o
	 EqWwL2Tt7Tb+uFN8Slwedk5J/wn3TCFe3V2OY9ZBRzjyX6nLmVwf23dOhso+MqvckxeMD
	 KAFBKGByStuJPjE0/9tsb2VxP6lYOJvbVgIeCKyja8FVj3dVPIfFkMc3ccZsOU9/jpKIg
	 roLTjE/qzgFcx5DqZRyo4O8/RWGvaT/L9rY5dPZyqlFAJtX/sUb7Cy814Tn6rFcjBgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500909;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/rN1jszK6Prt0JXmM/VVC9bxR5gk6QbRi+899j8yGqQ=;
	b=LwlZEvPAZvfqluXJmKZ0EwoeMxD8IJCFWTrLX6r4T7RYfGn7izOp/OXXQY3+fXYGzROs
	 kvrMR4+plnr1133NXjmTNdWB7t6F10COW9nlBZeT28aB65gPohIN64XHyJbrftEVRyN7j
	 JJtg+Xn74CuXJTC+ptoUMDTVTkqqhEQ0p+1R6E625HrSGLepqkt76d76oQO++kWdC53+9
	 rilCIlEaOXqgAf5dbTfJGqatIsrwN6eEdo38lXYTl9Igq6oH6gL1y3ZpdutncEog1z5lU
	 1T2nEU8up3E71c0+SWaT/8oGHVZtXGkhhBEC/h+E7GEH9wodQmY6GCSwRU23atOSVUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnF9adIO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0CB606A31A;
	Tue, 20 Oct 2026 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnF9adIO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7AF1F000C4;
	Tue, 20 Oct 2026 12:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792500908;
	bh=/rN1jszK6Prt0JXmM/VVC9bxR5gk6QbRi+899j8yGqQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MnF9adIOkMF9DWYDi7EtSiELWq7mW60krPzrCYqF2bV62U7RMqSmrS5txVv/eYZad
	 roMPSmsF1VZDsv1ONvHy7bwBZ+LQZ3cA83ruxKNh1sKBiRLGJLheWKSFxOLxGmZzBF
	 OL0X0+4+m0fE69cphWLfHDeHjka/0Gmgjfb66rrBi9ZUok3QWMMf7b/jYGtXFgajo2
	 nnw27eq7Xpw1F7WHwHd4YmuEKWwKjndl1w59//pc15z+H6jqERASKMRGzKVyGBmBLc
	 oQRREJbNdtbhOOCsjFPz1KfveBTef39x5ozpCmidTGP74Dvab5bVfB/9ukiMeNwvoP
	 Xxjux1NBHTKAA==
Subject: Re: [PATCH net v2 1/2] net: bcmgenet: recover from a failed resume
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
 justin.chen@broadcom.com
Date: Tue, 20 Oct 2026 12:55:06 +0000
Message-ID: <179250090686.3135.17597197349680697960@kernel.org>
In-Reply-To: <20261019-nb-genet-fini-dma-net-v2-1-b85f6b92654a@tipi-net.de>
References: <20261019-nb-genet-fini-dma-net-v2-1-b85f6b92654a@tipi-net.de>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After a failed resume, the next Wake-on-LAN suspend can no
  longer wake on the user's configured wake filters.
- [Medium] When WoL is not in use, the new `!priv->tx_cbs` early return
  in bcmgenet_suspend() (bcmgenet.c:4358-4368) does nothing to the PHY.
- [Medium] On the new ringless WoL suspend path after a failed DMA
  rebuild, the receiver is enabled while UniMAC still has its reset-…

--

net: bcmgenet: recover from a failed resume

This patch changes what happens when a resume fails in bcmgenet_init_dma(),
so that close and suspend can still handle the device. NULL rx_cbs/tx_cbs
now means there is no datapath. The block stays clocked on failure, close
reattaches the device, bcmgenet_suspend() gets a new path for the no-rings
case, and the WoL resume path stops the PHY before it rebuilds.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index e8908916558b1..34acd3c47cc55 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -4288,6 +4302,9 @@ static int bcmgenet_resume(struct device *d)
>  		bcmgenet_rdma_disable(priv);
>  		bcmgenet_intr_disable(priv);
>  		bcmgenet_fini_dma(priv);
> +		if (phy_is_started(dev->phydev) ||
> +		    dev->phydev->state == PHY_ERROR)
> +			phy_stop(dev->phydev);
>  		enable_irq(priv->irq1);
>  	}
>  
> @@ -4310,8 +4327,9 @@ static int bcmgenet_resume(struct device *d)
>  	/* Reinitialize TDMA and RDMA and SW housekeeping */
>  	ret = bcmgenet_init_dma(priv, false);
>  	if (ret) {
> +		/* Leave the block clocked, close and suspend tear it down */
>  		netdev_err(dev, "failed to initialize DMA\n");
> -		goto out_clk_disable;
> +		return ret;
>  	}

[Severity: Medium]

Does this return leave UMAC_CMD at the reset-default 10 Mb/s speed when the
next WoL suspend runs?

Earlier in bcmgenet_resume(), init_umac()->reset_umac() writes only
CMD_SW_RESET to UMAC_CMD. That zeroes the speed field (CMD_SPEED_10 is 0)
and the duplex and pause bits.

On the WoL rebuild path, the new phy_stop() above also leads to
phy_link_down()->bcmgenet_mii_setup() with the link down, which clears
RGMII_LINK.

bcmgenet_mac_config() is the only code that restores the speed and duplex
bits and RGMII_LINK, and it runs only from the phylib adjust_link callback.
After this early return, bcmgenet_netif_start()/phy_start() never run, so
that callback never fires. Meanwhile phy_init_hw() and genphy_config_aneg()
have already restarted autonegotiation on the PHY, which is still powered.

On the next WoL suspend, the new !priv->tx_cbs branch in bcmgenet_suspend()
returns 0. Then bcmgenet_suspend_noirq()->bcmgenet_wol_power_down_cfg()
does this:

	/* Can't suspend with WoL if MAC is still in reset */
	if (reg & CMD_SW_RESET)
		reg &= ~CMD_SW_RESET;

	/* Receiver must be enabled for WOL MP detection */
	reg |= CMD_RX_EN;
	bcmgenet_umac_writel(priv, reg, UMAC_CMD);

None of this corrects the speed.

If the PHY links at 1000 or 100 Mb/s, can magic packet reception fail even
though WoL looks armed? Together with the HFB_CTRL write below, a failed
resume could leave GENET with no working wake source.

> @@ -4340,6 +4352,22 @@ static int bcmgenet_suspend(struct device *d)
>  	if (!netif_running(dev))
>  		return 0;
>  
> +	/* A failed resume has torn the datapath down already. Resume still
> +	 * enables irq1 on the WoL path, so it has to be disabled here.
> +	 */
> +	if (!priv->tx_cbs) {
> +		if (device_may_wakeup(d) && priv->wolopts) {
> +			/* No rings to receive into, so no filter wake */
> +			bcmgenet_hfb_reg_writel(priv, 0, HFB_CTRL);

[Severity: Medium]

Does writing 0 to HFB_CTRL here turn off WAKE_FILTER wake completely?

bcmgenet_wol_power_down_cfg() reads HFB_CTRL after this point. It unmasks
the filter wake interrupts only if RBUF_HFB_EN is still set:

	reg = UMAC_IRQ_MPD_R;
	if (hfb_ctrl_reg & RBUF_HFB_EN)
		reg |=  UMAC_IRQ_HFB_SM | UMAC_IRQ_HFB_MM;

MPD is enabled only for WAKE_MAGIC/WAKE_MAGICSECURE. With wolopts set to
WAKE_FILTER only, the system would suspend with device_may_wakeup() true
and no GENET wake source.

A few lines below, the normal WoL path keeps only the RX_CLS_FLOW_WAKE
filters armed:

		if (priv->wolopts & WAKE_FILTER)
			list_for_each_entry(rule, &priv->rxnfc_list, list)
				if (rule->fs.ring_cookie == RX_CLS_FLOW_WAKE &&
				    rule->state == BCMGENET_RXNFC_STATE_ENABLED)
					hfb_enable |= 1 << rule->fs.location;
		...
		if (!hfb_enable)
			reg &= ~RBUF_HFB_EN;

Could this path use the same selection? Because tx_cbs is NULL, the
following resume rebuilds the rings anyway. The device is detached here,
so the WoL setting can't be changed from ethtool (it returns -ENODEV).

The commit message says:

    leave the hardware as bcmgenet_resume_noirq() set it up so
    close and suspend finish the teardown once.

Is that accurate? In bcmgenet_resume(), init_umac(), phy_init_hw(),
genphy_config_aneg() and bcmgenet_hfb_restore() all run before
bcmgenet_init_dma() fails. bcmgenet_hfb_restore() has already re-armed
every rule that is not unused.

The commit message also doesn't mention that configured filter wake is lost
after a failed resume.

> +			bcmgenet_intrl2_0_writel(priv, 0xFFFFFFFF,
> +						 INTRL2_CPU_MASK_SET);
> +			bcmgenet_intrl2_0_writel(priv, 0xFFFFFFFF,
> +						 INTRL2_CPU_CLEAR);
> +			disable_irq(priv->irq1);
> +		}
> +		return 0;
> +	}

[Severity: Medium]

With WoL not in use, can this early return leave an external PHY powered
for the whole sleep?

The non-WoL path that this skips calls bcmgenet_netif_stop(dev, true). That
calls phy_stop(), which ends in phy_suspend() and powers the PHY down.

bcmgenet_mii_probe() sets phydev->mac_managed_pm = true, so MDIO bus PM
won't power the PHY down either. bcmgenet_suspend_noirq() handles only the
internal PHY.

In the failed resume, phy_init_hw() calls the PHY driver's soft_reset and
sets phydev->suspended = 0. With genphy_soft_reset, BMCR_RESET clears
BMCR_PDOWN. genphy_config_aneg() then restarts autonegotiation.

bcmgenet_init_dma() then fails before phy_resume()/phy_start() run. The
PHY is now powered and linking while phylib still has it as PHY_HALTED.

This doesn't show on the CM4's BCM54213PE, because its phy_driver entry has
no soft_reset. It looks reachable when wolopts is 0 and the external PHY's
driver has a real soft_reset (such as genphy_soft_reset).

Does this match the commit message's statement that suspend will "finish
the teardown once"?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-nb-genet-fini-dma-net-v2-0-b85f6b92654a%40tipi-net.de
