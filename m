Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549088;
	b=s5plYs/kmZ204ZUcVV5ggnmbodXt3HiFJn6UxvaCXVf3+bQ9qSLOlcmTtUHca7vgkN+z
	 KuWVvQeGhZ5Oa7v0Fv/r9T49CuHcEMKir+19l22+O1M8vgrL3LamNQyIqc2VspOJgcCgA
	 z3crZijD5w5WBwTk/oHrymaWCcnirn07JfyWuBSV3bYLtAysV8lVdddUhl+mXmOcWNCwC
	 S4crQU67988SJWjaygCVRwfqsHXT0tahkh4UO556SJWOkCCLK72lVJr7Kl/XOqcyX3e9U
	 Nk6UP+SbGw0MgrHJNEzHLe7UmEuOcrQ/8pRAUbbitIVMb0neg/bgESuE2SZX+7/ivKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549088;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Kbug0i2azHhZSrQxD3FTjyQMkcwVwvLBJeQgIdTmpKw=;
	b=oXKxCQNh26jDO1Noy8ez1L/U7lO6fGpMOSmsuLJnR56W9h6hpU+RVpUzQuKCkr15G8hs
	 0NZ1ESzzC61ku99mTGHYqpUEqN8244zTkGDGrhqe2dsiIeE/QR+ZZdn/WvR4mTzimFpbe
	 iY6ttB/6VLpsY1DGT+wvVENy+1vBIs6dDlC5O3eTz6KZLUL4O/v+qF8z3Qgzv9qfiRmu4
	 UFvtF7yJm5dm03Gqeo7fhNWZyUZx3Dk2ZqUX4n8zF3ndFkM+57MejiUSzz7qWWXReBm5X
	 41Kgxo56ER9g/ZA05nqavRtyp62nqrRtpdglcQCs6lzC8VjWhNz8VbEXWdLocsN1urQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fozEA5AF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B360A2607;
	Fri, 13 Nov 2026 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fozEA5AF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EE91F000C8;
	Fri, 13 Nov 2026 05:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549088;
	bh=Kbug0i2azHhZSrQxD3FTjyQMkcwVwvLBJeQgIdTmpKw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fozEA5AFMJwnW4bzEl7G8aFE83bWmL1l9ouF7n83SfLJXUr3Sla0V0KDPASsKeypu
	 mWaXBOaQFDm+7NDnoFOtp1k6VEXP51IUm62/jS1efCKtka5cdKA7mT2O0ekzk0qNTV
	 EOIrTgZwJTTjb3OFM8VyHFrb5Z0ZCCr1ST5wmtvn6WHFSTpZu6gE+NSF9FLq6Cd1yi
	 r9KLIVO7qrNoLnge/NUk3kU3Wnk+LluO1FsMjhv+Gm6oMGwrQocHFsrGnTEeml2q24
	 L8wBH24y8PKZoPlT98mHDkdyEi4Mx49tD8sNyN90Nmm9vvN11dl12/OOPjcwqFKIVm
	 ZAfUVGHUL11sQ==
Subject: Re: [PATCH net v5 2/4] net: phy: keep the line of a postponed PHY
 interrupt balanced
From: netdev-bot+sashiko@kernel.org
To: iav@iav.lv
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, lukas@wunner.de, rafael.j.wysocki@intel.com,
 wei.fang@nxp.com, niklas.soderlund@ragnatech.se, paul@pbarker.dev,
 florian.fainelli@broadcom.com, opendmb@gmail.com, Thangaraj.S@microchip.com,
 shenwei.wang@nxp.com, Haoning.CHENG@cn.bosch.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 05:51:26 +0000
Message-ID: <179454908644.2199510.9163619774771791131@kernel.org>
In-Reply-To: <20261111-b4-phylib-mac-pm-irq-v3-v5-2-bbfdb5afb7d3@iav.lv>
References: <20261111-b4-phylib-mac-pm-irq-v3-v5-2-bbfdb5afb7d3@iav.lv>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] phy_free_interrupt() (drivers/net/phy/phy.c) can re-enable a
  shared line that the PHY may still be asserting.
- [Medium] phy_free_interrupt() gives back the depth that the postponed
  disable_irq_nosync() took.
- [Low] In phy_free_interrupt() (drivers/net/phy/phy.c), the check
  irq_has_action(phydev->irq) and the following enable_irq(phydev->irq)…

--

net: phy: keep the line of a postponed PHY interrupt balanced

This patch makes only the phy_interrupt() run that sets irq_rerun disable
the line. phy_free_interrupt() now consumes irq_rerun after free_irq() and
calls enable_irq() when other actions remain on the line. It also adds
irq_pm_lock to serialize phy_free_interrupt() against the rerun in
mdio_bus_phy_resume_irq().

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 9af303d60bd6b..ea22ebb14a832 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c

[ ... ]

> @@ -1507,7 +1510,18 @@ EXPORT_SYMBOL(phy_request_interrupt);
>  void phy_free_interrupt(struct phy_device *phydev)
>  {
>  	phy_disable_interrupts(phydev);
> +
> +	mutex_lock(&phydev->irq_pm_lock);
>  	free_irq(phydev->irq, phydev);
> +	/* Give the depth a postponed interrupt took back to the other users of
> +	 * a shared line; requesting a line we were alone on resets its depth.
> +	 */
> +	if (phydev->irq_rerun) {
> +		phydev->irq_rerun = false;
> +		if (irq_has_action(phydev->irq))
> +			enable_irq(phydev->irq);

[Severity: Medium]
Can this unmask a shared line while the PHY is still asserting it?

phy_free_interrupt() ignores the return value of phy_disable_interrupts().
Also, a postponed interrupt never acknowledged the PHY status: the
postponed path in phy_interrupt() returns IRQ_HANDLED without calling the
driver's handle_interrupt().

If the MDIO write in phy_disable_interrupts() fails, the PHY interrupt
mask and latched status stay set. On a level-triggered shared line,
enable_irq() then unmasks the line with no PHY handler installed.

If none of the remaining handlers claims the interrupt, would
note_interrupt() eventually disable the line with IRQS_SPURIOUS_DISABLED
for every remaining user?

That failure looks reachable with cpsw_new once the later patch "net: phy:
postpone PHY interrupts during sleep with MAC-managed PM" is applied. The
davinci_mdio controller is a child created by devm_of_platform_populate(),
so it suspends first, and davinci_mdio_suspend() calls
pm_runtime_force_suspend(). Then:

cpsw_suspend()
  cpsw_ndo_stop()
    phy_disconnect()
      phy_free_interrupt()
        phy_disable_interrupts()
          davinci_mdio_write()
            pm_runtime_resume_and_get()  <- fails, runtime PM disabled

Before this patch, the line stayed disabled until mdio_bus_phy_resume(),
which runs after the MAC reopens and installs the PHY handler again. With
this patch, the line is unmasked from the close until
suspend_device_irqs(). It is unmasked again from resume_device_irqs()
until the MAC reopens. Nothing clears the source in either window.

The commit message says:

    Re-enabling after free_irq(), not
    before, leaves no PHY handler to run again on a source that
    phy_disable_interrupts() did not clear.

That covers the PHY handler, but what about the other sharers on the
line? Should the enable_irq() be skipped when phy_disable_interrupts()
fails?

[Severity: Medium]
Is this enable_irq() still balanced if phy_free_interrupt() runs inside
the noirq window on a wake-armed line?

The commit message names stmmac_reset_subtask(), whose workqueue does not
freeze, as a path into phy_free_interrupt() during the sleep transition.
stmmac_suspend() does not set STMMAC_DOWN, so the subtask can run.

bcm_phy_set_wol() calls enable_irq_wake(phydev->irq). Several irqchips set
IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND: gpio-mxc, gpio-vf610, pinctrl-msm,
qcom-pdc, pinctrl-amd and pinctrl-starfive-jhb100.

Consider this sequence, with another action still on the line:

phy_interrupt()
  disable_irq_nosync()           depth 0 -> 1

suspend_device_irq()
  __enable_irq()                 depth 1 -> 0
  irqd_set(irqd, IRQD_IRQ_ENABLED_ON_SUSPEND)

phy_free_interrupt()
  irq_has_action() is true
  enable_irq()
    __enable_irq() case 0        WARN "Unbalanced enable for IRQ"

resume_irq()
  __disable_irq()                depth 0 -> 1

The line is not IRQS_SUSPENDED, so nothing enables it again on resume.
irq_rerun has already been consumed, so mdio_bus_phy_resume_irq() does
nothing either. A shared re-request from dev_open() does not touch the
depth.

Would the line then stay disabled after resume for every user, including
the reopened PHY? Before this patch, irq_rerun stayed set until
mdio_bus_phy_resume(), which ran after resume_irq() had restored depth 1.

[Severity: Low]
Can the irq_has_action() check race with another driver requesting the
same line?

By this point free_irq() has already dropped desc->request_mutex.
irq_has_action() only returns a snapshot. irq_pm_lock is per-phydev, so
other drivers don't take it.

Suppose the PHY was the last user and a postponed interrupt left depth
at 1:

free_irq()
  irq_shutdown()                 depth 1 -> 2

                                 other driver: request_irq()
                                   __setup_irq()
                                     irq_startup()   depth = 0

irq_has_action() returns true
enable_irq()
  __enable_irq() case 0          WARN "Unbalanced enable for IRQ"

If the new requester used IRQ_NOAUTOEN, irq_startup() resets the depth to
1 instead. This enable_irq() would then start a line that driver asked to
keep disabled.

> +	}
> +	mutex_unlock(&phydev->irq_pm_lock);
>  }
>  EXPORT_SYMBOL(phy_free_interrupt);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3%40iav.lv
