Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793522200;
	b=21OSitH5C+GwGUBzWftrfFXU8t2i0BSlP2m52xUDNfod/CA+h8+lmLDcX4T2zTQik/zs
	 3pYCyBhXVls1mLkTfhKS2w6z72pz1onfCutp//JxkCnP/sg0D+dEfXcGj+jvHEaqnmr7P
	 5in+FrbqRQkaUpGbHd5GjIiPFaVrjGnxcNHmAWmMK3ssKQvkGrRmbZ85cLTrNVsIY5AL4
	 4slFOsw9EXOuO8JxfLdTdyQ46DqjHHzFMsB5taHhIzAJu6meHnOx0ieQA86SRFd1eRRD/
	 DN8YzKhl1xFZk7LclUab3jtSKDPicvb943KrVmQkAdd5MRgcEblX8Sh2OCt6jFCM3Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793522200;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LXCicZxC3YM8+qlDZ22L2zoCpC7gbAYtbkXJ6Bwzeew=;
	b=eeRJw89iTkKcUxYQT0cZnQXFoGTGHoDlRr73NuuXkS6kGjjF7VIM5c40k0Q7UlMM9eS9
	 /AvJDsYJBIUtu2WApibkCxfPVJb7TtV1UzeqtDeNCpvVb75gJyxRZ/52djKbSyQcUi96I
	 uM7VndQJpRm/3OAj+fIxSOchDQ8k1b7CJPPl8+uR4pP5vWDz9O5uPDsGFkuDgM01j7g5m
	 0A9k4BlPYbNZ5T8tgZuBI88n6WDn/Gaaka2jhs50X05aBQRYWcQDbL5/CIv/VRVbD2pSM
	 kSnMNtiAvYyD/jQF4h/Moy0Odpvv5B1OChaHN750Gv7jUEluPZLIpC0F5n74cKmWQGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tes5Dti/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474A606A326;
	Sun,  1 Nov 2026 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tes5Dti/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420441F00A15;
	Sun,  1 Nov 2026 08:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793522199;
	bh=LXCicZxC3YM8+qlDZ22L2zoCpC7gbAYtbkXJ6Bwzeew=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tes5Dti/hG/1AhQHhdTiEkH62QiB64z9bqwJPK6OFBMM83BHIUFcSNzY2CLX3rIcR
	 lLJ3dOUnndz38pX+F1FM9UoKEFTavddL+vK9Q/P1dEkaEqisVrPF4REyRh00JXn2if
	 LdTJshZ7prnDXXN17DS+ts6H0YTM8XU5uduc2p0DbfdxZBzNMpFy1TDxLM2gUsAEM1
	 LFF13ZS7cQc+xCyfWj8tG1PMxuFuci9QUebs+hwwQ80sKlfGhGtFTeL5xgepnok/r+
	 dupu7dyO6IRLe5VZW2roR1iFRwrPZIJRS0QlHyZUm1Bfyppl/vC1tXLo4ho4fy9Ysf
	 XeT1UuCyoTEIA==
Subject: Re: [PATCH net v4 5/5] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
From: netdev-bot+sashiko@kernel.org
To: iav@iav.lv
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, lukas@wunner.de, rafael.j.wysocki@intel.com,
 wei.fang@nxp.com, niklas.soderlund@ragnatech.se, paul@pbarker.dev,
 florian.fainelli@broadcom.com, opendmb@gmail.com, Thangaraj.S@microchip.com,
 shenwei.wang@nxp.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Sun, 01 Nov 2026 08:36:37 +0000
Message-ID: <179352219781.3131.16504721138901563596@kernel.org>
In-Reply-To: <20261031-b4-phylib-mac-pm-irq-v3-v4-5-5ba23b3ff9a4@iav.lv>
References: <20261031-b4-phylib-mac-pm-irq-v3-v4-5-5ba23b3ff9a4@iav.lv>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: phy: false wakeup in phy_interrupt() during mac_managed_pm
  suspend

--

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -332,16 +332,55 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
>  	return !phydev->suspended;
>  }
>  
> +static __maybe_unused enum phy_irq_wake
> +phy_irq_wake_source(struct phy_device *phydev)
> +{
> +	struct net_device *netdev = phydev->attached_dev;
> +	bool phy_wol;
> +
> +	if (!netdev)
> +		return PHY_IRQ_WAKE_NONE;
> +
> +	/* phy_suspend() cached the answer of a suspended PHY, which may
> +	 * not be reachable over MDIO.
> +	 */
> +	if (phydev->suspended && !phy_can_wakeup(phydev))
> +		phy_wol = phydev->wol_enabled;
> +	else
> +		phy_wol = phy_may_wakeup(phydev);
> +
> +	if (netdev->ethtool->wol_enabled || phy_wol)
> +		return PHY_IRQ_WAKE_SYSTEM;
> +
> +	/* A MAC that manages PHY PM stops the PHY itself: the link
> +	 * interrupt that follows is not a wakeup.
> +	 */
> +	if (phydev->mac_managed_pm)
> +		return PHY_IRQ_WAKE_NONE;
> +
> +	if (device_may_wakeup(&netdev->dev))
> +		return PHY_IRQ_WAKE_NETDEV;
> +
> +	if (netdev->dev.parent && device_may_wakeup(netdev->dev.parent))
> +		return PHY_IRQ_WAKE_PARENT;
> +
> +	return PHY_IRQ_WAKE_NONE;
> +}
> +
>  /* Wakeup interrupts may occur during the system sleep transition when
>   * the PHY is inaccessible. Set flag to postpone handling until the PHY
>   * has resumed. Wait for concurrent interrupt handler to complete.
> + * Decide which wakeup event a postponed interrupt reports now, while
> + * the PHY can still be read.
>   */
>  static __maybe_unused void mdio_bus_phy_suspend_irq(struct phy_device *phydev)
>  {
>  	if (!phy_interrupt_is_valid(phydev))
>  		return;
>  
> -	WRITE_ONCE(phydev->irq_suspended, true);
> +	phydev->irq_wake = phy_irq_wake_source(phydev);
> +	/* Pairs with smp_load_acquire() in phy_interrupt() */
> +	smp_store_release(&phydev->irq_suspended, true);
>  	synchronize_irq(phydev->irq);
>  }
>  

[Severity: High]
phy_irq_wake_source() runs from mdio_bus_phy_suspend(), before the
MAC's suspend callback. For a mac_managed_pm PHY, that callback still
changes the link afterwards. The mac_managed_pm check below only
covers the case without Wake-on-LAN. With Wake-on-LAN enabled we
return PHY_IRQ_WAKE_SYSTEM, so any link interrupt the MAC causes
itself makes phy_interrupt() call pm_system_wakeup() and abort the
suspend.

I can see two ways to get there.

WoL in the PHY on stmmac: stmmac_suspend() calls phylink_suspend(),
which goes through phylink_stop() -> phy_stop() -> phy_suspend(). With
wol_enabled set and no PHY_ALWAYS_CALL_SUSPEND, phy_suspend() returns
-EBUSY without calling the driver's suspend, so the link interrupt
stays unmasked. phylink_suspend() then calls phylink_speed_down(),
since stmmac sets wol_phy_speed_ctrl, and phy_speed_down() restarts
autonegotiation to drop to 10Mbps. The link goes down while
irq_suspended is set and irq_wake is PHY_IRQ_WAKE_SYSTEM.

WoL in the MAC only, fec for example: netdev->ethtool->wol_enabled is
set while phy_wol is false, and fec_suspend() calls phy_stop() and
gates its clocks. phy_suspend() again leaves the link interrupt of the
PHY enabled. rtl8211f_suspend(), for one, neither calls
genphy_suspend() nor masks the link status interrupt when wol_enabled
is set without driver-model wakeup. So the link-down interrupt is
reported as a system wakeup, although the PHY interrupt is not a
wakeup source here at all; the MAC is.

Before this patch these PHYs did not have irq_suspended set during the
MAC's suspend callback, so neither case could abort suspend. This
looks like a regression for anyone using WoL behind a MAC that manages
PHY PM. Did the Helios64 Wake-on-LAN test go through the speed
downshift in phylink_suspend()?

I'm not sure what the right fix is, so two questions. Should the
mac_managed_pm case count only phy_wol, and not the ethtool flag that
may describe MAC WoL? And for PHY WoL, can the wakeup be armed only
after the MAC has finished suspending, for example from a later
suspend phase, so that link changes the MAC makes itself are not
reported?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4%40iav.lv
