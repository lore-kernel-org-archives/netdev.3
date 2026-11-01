Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793522198;
	b=TBRYMAqWeMkULLhiuBeZPM2/v9A8ryM9snvSGM10/wUuQKlQeT29/WNAydUfvvEwbv52
	 EtZynCuix5UHnUU9K/MGw0fUI2+FxLQOyZHTabiUSgPQPWaWUuQwcbrk3GP/t60XDlco2
	 CZ0ITZ6ch/foKXaRhO+sRIJIoBYqbn36HdyAVXxpnIQtvq1tUPnkxwIh//wJPBlGCxCiD
	 mJ9PRGAceTFiySD3TLqmi700j0VO28oTsHc8X74LTsQUMiZFVhpn33V541NIamVZc/Eq9
	 dpnQxbBSUL2qBkspZb8c0ttNPWzJpqlhiEGS6fThzq7flwaXv29f5rTJxerH3pS2JuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793522198;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MT/gtzRgjYEkyY6o8rD+a9NlNn+Ql+jmRXlXyRDFw3c=;
	b=eXej2f+AIiXmpor6+43pIzvlCPeXHfKQX2mQLXBdCSVhM0lQN8Sx07NTrvepTGJDdEIf
	 QV02ikCfwd6Jt9DPxkDeJZUPCZV97hLmrwlz9Mu0/yDAj4HnKW+uWrlS8mzxwGaNTENo+
	 RlpL0uh0JrMuVvtQ1N+q8twhS6zoromD7PEpSCWWA8KrXGxQnE4xd9QPaHlbTsPQSycyP
	 EENJQShNYPkHUIl2PVmI5wXsHcoYeYqX9fkzcsr5wcE8GY9Q4ChfU5NQ4XdoI/MCAd8ge
	 6LxpZkr+W8D38pIE484NHDmD0UgyE4XcNfNW6frSD9M7yIIU+ZuNtvUYKw1KujRVb2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixL6rJwo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30B9606A332;
	Sun,  1 Nov 2026 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixL6rJwo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5BC1F000C1;
	Sun,  1 Nov 2026 08:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793522197;
	bh=MT/gtzRgjYEkyY6o8rD+a9NlNn+Ql+jmRXlXyRDFw3c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ixL6rJwoLi1sArTn5kZcpt3DMW9Lk+ki5C3O9dEAIRUQDZJxL0VxJSAusN+4bZ/sT
	 84j4GjZ3bKs6XQf54grlolngo8bNrjE8R3dpdDql6h6bDkVA9D5EJW5S4v5U3OVQyX
	 3ypGJIitutZ/YGDVUti9I3PkdlcaS3VZOg30PrG1DClSzUY0MC9Y2gmxyNlhtdQHoG
	 bEXGzQNcpcAUEglf1o3I8VhF2nPnRrpSGsZ2vaspNkyrO1QaeYGlH5fDu4nKjnkPk3
	 dCLGiFnT16+oRDxUK5cwuRpBRkJDN3AmwQCdJdIUSid5KZjR0D4XlliKQvl6rlhcO0
	 w+XW3eAV9HfLg==
Subject: Re: [PATCH net v4 4/5] net: phy: stop postponing PHY interrupts when
 a PHY PM callback fails
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
Date: Sun, 01 Nov 2026 08:36:36 +0000
Message-ID: <179352219604.3131.6703522094615416778@kernel.org>
In-Reply-To: <20261031-b4-phylib-mac-pm-irq-v3-v4-4-5ba23b3ff9a4@iav.lv>
References: <20261031-b4-phylib-mac-pm-irq-v3-v4-4-5ba23b3ff9a4@iav.lv>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Interrupt storm and WARN flood when a PHY PM callback fails
  because MDIO access is broken, which can then disable the shared IRQ…
- [Low] Comments that say interrupt handling is postponed 'until the PHY
  has resumed' are now wrong on the failure paths.

--

net: phy: stop postponing PHY interrupts when a PHY PM callback fails

This patch changes mdio_bus_phy_suspend() so that a failed phy_suspend()
undoes the interrupt postponement and restarts the state machine. It also
changes mdio_bus_phy_resume() so that a failed phy_init_hw() or
phy_resume() reruns the postponed PHY interrupt. Before this, the function
returned with the line still disabled.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index ef5e1cd3a8319..390069ec13cac 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -383,9 +384,20 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
>  	if (!mdio_bus_phy_may_suspend(phydev))
>  		return 0;
>  
> +	ret = phy_suspend(phydev);
> +	if (ret) {
> +		/* The PM core skips the resume callback of a device whose
> +		 * suspend callback failed.
> +		 */
> +		mdio_bus_phy_resume_irq(phydev);
> +		if (phy_uses_state_machine(phydev))
> +			phy_start_machine(phydev);
> +		return ret;
> +	}
> +
>  	phydev->suspended_by_mdio_bus = 1;
>  
> -	return phy_suspend(phydev);
> +	return 0;
>  }

[ ... ]

> @@ -411,11 +423,11 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
>  
>  	ret = phy_init_hw(phydev);
>  	if (ret < 0)
> -		return ret;
> +		goto err_resume_irq;
>  
>  	ret = phy_resume(phydev);
>  	if (ret < 0)
> -		return ret;
> +		goto err_resume_irq;
>  no_resume:
>  	mdio_bus_phy_resume_irq(phydev);
>  
> @@ -423,6 +435,10 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
>  		phy_start_machine(phydev);
>  
>  	return 0;
> +
> +err_resume_irq:
> +	mdio_bus_phy_resume_irq(phydev);
> +	return ret;

[Severity: Medium]
Can this cause an interrupt storm when phy_init_hw() or phy_resume() fails
because the PHY can't be reached over MDIO?

Suppose a postponed interrupt set irq_rerun during the sleep transition.
mdio_bus_phy_resume_irq() then re-enables the line and wakes the thread. It
does not check whether the PHY can be accessed:

drivers/net/phy/phy_device.c:mdio_bus_phy_resume_irq() {
    ...
	if (atomic_xchg(&phydev->irq_rerun, 0)) {
		enable_irq(phydev->irq);
		irq_wake_thread(phydev->irq, phydev);
	}
    ...
}

irq_suspended is now clear, so phy_interrupt() calls
drv->handle_interrupt(). If the MDIO read fails, a typical handler can't
acknowledge the source:

drivers/net/phy/micrel.c:kszphy_handle_interrupt() {
	irq_status = phy_read(phydev, MII_KSZPHY_INTCS);
	if (irq_status < 0) {
		phy_error(phydev);
		return IRQ_NONE;
	}
    ...
}

dp83848_handle_interrupt() does the same thing. phy_error() is an
unconditional WARN_ON(1) followed by phy_process_error(). That only sets
PHY_ERROR and triggers the state machine. It does not mask the interrupt in
the PHY and does not free the IRQ.

The line is requested with IRQF_ONESHOT | IRQF_SHARED. If the PHY is still
powered and keeps its level INT_N asserted, the line fires again as soon as
the thread finishes.

Would each pass then cost a failed MDIO transaction and a full WARN
backtrace? That would repeat until the spurious IRQ detector disables the
line for every sharer. With panic_on_warn set, the first rerun would panic.

The rollback in mdio_bus_phy_suspend() above takes the same path when
drv->suspend() fails on an MDIO error.

Before this patch, the line just stayed disabled in this case. The commit
message says:

    ... which gives the line back to the other users of a
    shared line. A handler that then cannot read the PHY reports it through
    phy_error(), as most PHY drivers do on any MDIO error.

Can other users of a shared line actually get it back if the PHY's own
interrupt source can't be acknowledged? Whether INT_N stays asserted while
MDIO fails depends on the hardware. Nothing on this path guards against it,
though.

[Severity: Low]
This isn't a bug, but several comments still say the postponed interrupt is
handled only once the PHY has resumed. On the new failure paths, the
postponement ends even though the PHY never resumed:

drivers/net/phy/phy.c:phy_interrupt():
	/* Wakeup interrupts may occur during a system sleep transition.
	 * Postpone handling until the PHY has resumed.
	 */

drivers/net/phy/phy_device.c, above mdio_bus_phy_suspend_irq():
/* Wakeup interrupts may occur during the system sleep transition when
 * the PHY is inaccessible. Set flag to postpone handling until the PHY
 * has resumed. Wait for concurrent interrupt handler to complete.
 */

include/linux/phy.h, struct phy_device kernel-doc:
 * @irq_suspended: Flag indicating PHY is suspended and therefore interrupt
 *                 handling shall be postponed until PHY has resumed

A later patch in the series, "net: phy: postpone PHY interrupts during
sleep with MAC-managed PM", changes the phy.h kernel-doc to "postponed
until mdio_bus_phy_resume()". The comments in phy.c and phy_device.c are
still unchanged at the end of the series.

Should those two comments be updated as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4%40iav.lv
