Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549089;
	b=sH9VOJGj0Z7dt3MenTXfukH3x1X/ir6bJ14tbUCGlmMhWfEF1hLzQN8UnH/vlLqPMjyU
	 /Nxm6kvpQ07JbLlAOQcbzb08FVkhdWglG0DyMf0XkN3kiZek3HqYP5FdxKVQGEPMzQXpD
	 6iFSMYNDeENVjxa36H3967iQyNwXfp5KU91sQW6eIRLjgyV6SSkCz7p0tqc4gDTfM3rNq
	 qQGPrSS8Zwg6VqmVuje+HNVltrN44lTNq1mopxfy7dPAyrFL6VUokpIwMfJx87NzKIL9+
	 vAuFvFgufJ1GqmewyOCxBxX8ardruvwI6Z+790p+3X1GEo0qCZuiOqZFylciOdG3XcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549089;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kIZ22OefzW2mHncUHbyDBewc8tS01xJKiXvT3NOowLQ=;
	b=vjoEIMQWWZpQA6GFvahcyEwxwIlH8z7ZwKVZvtW5m8yit+c3nDimypp9c1natJ/zLqsY
	 Nh6Z8barXxQzOu4IKYGEUTv0InpRMd7kz8HvNe+I+zNJ/Jh0OMzYKoi84m3q8qv95sxQ/
	 dRwR0pDUDdXbwyR+Isz/cXjGORE9F6OcUl0BKJWzKZ0v/u5MJYThjF0S5Kcsd1bllzIPf
	 bC3XJUOWYrpVmChfaxRhyHPrwaI4cEmYkBF5aMLxMo8IIKAMYDVipogVE9NJXHwfoJMpe
	 VzrvFj49E82cCslwOah6ROXSws/PNdRWl+A+x5ng0/VuaBybNTocPCBiW86OnwF3OiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GSj6d/+3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30760A2622;
	Fri, 13 Nov 2026 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSj6d/+3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4D41F000C5;
	Fri, 13 Nov 2026 05:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549089;
	bh=kIZ22OefzW2mHncUHbyDBewc8tS01xJKiXvT3NOowLQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GSj6d/+3mPcDnKUnkLVCxuYBzZKAi+1n88G9VLS7aSUvWOZqtzpT2RqNRSpKEwWW7
	 cv9Ld8urLBSPObXZu9pfC3Uq1AYEs+crkPeGkjoJO8yhuwz4mjcOx3MlgvdkhR8PRX
	 efFpdLrc/A/Fjte22QdyUOa5qiJ+Pxcz433Irwgy7uJXGEtHg8BlAYzaALFkLPHK7O
	 lLMuE63CrP2yl68UnmyRXLSnv057lM2ZLbkP2kHgu+UOyNU5ScNVbzDjsQvuxcoJre
	 Fd2or5FIDJAkYaZiaG3ryrUUztbiHr8yn1GRFO1SpzwgypU0qEvLWqhwO2wMw/aAjc
	 ZLbvt8i8ibvPw==
Subject: Re: [PATCH net v5 3/4] net: phy: stop postponing PHY interrupts when
 a PHY PM callback fails
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
Date: Fri, 13 Nov 2026 05:51:28 +0000
Message-ID: <179454908812.2199510.10507965119613979569@kernel.org>
In-Reply-To: <20261111-b4-phylib-mac-pm-irq-v3-v5-3-bbfdb5afb7d3@iav.lv>
References: <20261111-b4-phylib-mac-pm-irq-v3-v5-3-bbfdb5afb7d3@iav.lv>
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

- [Medium] In mdio_bus_phy_resume() (drivers/net/phy/phy_device.c), the
  new err: path runs WRITE_ONCE(phydev->irq_suspended, false) after…
- [Medium] The commit message says a line that the new err path leaves
  disabled 'comes back on the next successful resume'.
- [Low] The patch moves 'phydev->suspended_by_mdio_bus = 1' in
  mdio_bus_phy_suspend() (drivers/net/phy/phy_device.c) from before…

--

net: phy: stop postponing PHY interrupts when a PHY PM callback fails

This patch changes mdio_bus_phy_suspend() so that a failed phy_suspend()
undoes the interrupt postponing and restarts the state machine. It also
moves the suspended_by_mdio_bus assignment so it happens only after
phy_suspend() succeeds. In mdio_bus_phy_resume(), a phy_init_hw() or
phy_resume() failure now clears irq_suspended, but a line that a postponed
interrupt disabled stays off.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index d3815ee21541a..110c9dfcbd916 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -384,9 +385,20 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
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

[Severity: Low]

This isn't a bug, but moving the suspended_by_mdio_bus assignment after
phy_suspend() also changes resume behaviour. The commit message doesn't
mention this.

Before, the flag stayed set when phy_suspend() failed. The resume callback
is skipped in that case, so nothing cleared it.

On a later cycle where mdio_bus_phy_may_suspend() returns false (WoL now
enabled, or the PHY already suspended by phy_detach()), the stale flag was
still set. mdio_bus_phy_resume() would then run phy_init_hw() and
phy_resume() on a PHY the MDIO bus did not suspend.

Could the commit message describe this change as well, so reviewers and
stable backporters can see it?

>  
> -	return phy_suspend(phydev);
> +	return 0;
>  }

[ ... ]

> @@ -424,6 +436,13 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
>  		phy_start_machine(phydev);
>  
>  	return 0;
> +
> +err:
> +	/* Stop postponing, but leave a line that a postponed interrupt
> +	 * disabled off: its handler may not reach a PHY that did not resume.
> +	 */
> +	WRITE_ONCE(phydev->irq_suspended, false);

[Severity: Medium]

What happens here if no interrupt was postponed during the transition?
In that case irq_rerun is false and the line is still enabled at the
irqchip.

Before this patch, irq_suspended stayed set after a failed resume. The
first assertion would then take the postpone branch in phy_interrupt(),
disable the line once and return IRQ_HANDLED without any MDIO access.

Now that irq_suspended is cleared here, the next assertion skips that
branch and goes straight to:

drivers/net/phy/phy.c:phy_interrupt() {
    ...
	mutex_lock(&phydev->lock);
	ret = phydev->drv->handle_interrupt(phydev);
	mutex_unlock(&phydev->lock);
    ...
}

That handler runs on a PHY whose phy_init_hw() or phy_resume() failed.
The comment above keeps a disabled line off because "its handler may not
reach a PHY that did not resume". Doesn't the same reasoning apply to a
line that is still enabled?

phy_init_hw() calls config_intr() before disable_autonomous_eee() and
before phy_resume(), and both of those can still fail. The PHY can
therefore have its interrupt sources armed even though resume returned an
error.

If the PHY is unreachable, a handler such as rtl8211f_handle_interrupt()
fails the status read, calls phy_error() (which does WARN_ON(1)) and
returns IRQ_NONE. The source is never cleared, so the
IRQF_ONESHOT | IRQF_SHARED threaded line can re-assert after each unmask.

Could this cause a stream of WARN splats until the spurious IRQ detector
disables the line for all of its users? On a shared line where another
device acks its own interrupt, the detector may never trip, and the WARN
would repeat on every interrupt.

If the PHY is reachable, the handler calls phy_trigger_machine() or
phy_process_error(). Either one restarts the state machine that this
error path deliberately left stopped.

Would phylib then be driving a PHY whose config_init, config_intr,
disable_autonomous_eee or drv->resume never finished?

[Severity: Medium]

The commit message says:

  The line comes back on the next successful resume; ...

Does that next resume actually re-initialise the PHY?
mdio_bus_phy_resume() clears suspended_by_mdio_bus before phy_init_hw()
and phy_resume() run:

drivers/net/phy/phy_device.c:mdio_bus_phy_resume() {
    ...
	if (!phydev->suspended_by_mdio_bus)
		goto no_resume;

	phydev->suspended_by_mdio_bus = 0;
    ...
}

phydev->suspended is cleared in only two places: in phy_init_hw() after a
successful soft_reset, and in __phy_resume() on success. So it stays true
in these cases:

  - soft_reset fails
  - the driver has no soft_reset, and config_init, config_intr,
    disable_autonomous_eee or drv->resume fails

On the next sleep cycle, mdio_bus_phy_may_suspend() ends with:

	return !phydev->suspended;

so mdio_bus_phy_suspend() returns 0 without calling phy_suspend() or
setting suspended_by_mdio_bus. The next mdio_bus_phy_resume() then jumps
to no_resume. There, mdio_bus_phy_resume_irq() does this because
irq_rerun is still set:

	if (phydev->irq_rerun) {
		phydev->irq_rerun = false;
		enable_irq(phydev->irq);
		irq_wake_thread(phydev->irq, phydev);
	}

and phy_start_machine() runs after it.

Doesn't this rerun handle_interrupt() on the same PHY that never resumed?
That is the case this error path is meant to prevent.

Clearing suspended_by_mdio_bus early is older than this patch. However,
the safety argument in the commit message relies on this recovery path.

> +	return ret;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3%40iav.lv
