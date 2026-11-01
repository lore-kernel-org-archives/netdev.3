Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793522196;
	b=Rb7QbowH/4O7q5M8H1gKCYhaGpoGC5lJag4kAsaRCb2OOTFoOPwnvXvdwRGxkgKPDjl1
	 pMxcHzvJHukzY5OuNwxiJaMCV2om5SAvqifBiqmZkRN5kTKgz7LJneb4ufP8tsG4iL2C/
	 5hv92Qd/BS7gvq0We8h54XEXmwOLGGRTCzbN4xsurYaUkD5jmZSr4IZIOfj0WqM49dlJ6
	 FUnvKzlnvCfI654HdhlU7CkyQQ761Xk6tdD5uBOmMDvftix3n7hG1EYRi2yNoSA9p4A7p
	 LHTU1ATDZdhmXa/QrrrfizPxqQO++91RUUwTVrrDwd67Tj1X+8wdCgfb/h7b/VmngCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793522196;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xf3Loy4nSJ6nnacTtEx28Qg2Cgh08dxFhAwH21XrXA0=;
	b=1tKFsAeo6SHI4kZTsGKkBNVAVhO1LVnisHEOojJQmdgW7Jnm1GGyKej7VWSaAIFq5C7J
	 Tiypjqc71w3g0C9j0zaOUJxd6Gz3FDl9zs0CVvDAZa6lzCbxb1p5lJYtlCaOMnfT3/lkM
	 WWP4JOC+YscvCd/WHT7FaRBkXAF7f1BPDrDY9aHaMJh54OoP6FOdECfD7sYkiFg22WM70
	 iRmA0GH+gXFPFA517boyL2KjMsqczSObzfpEv9KPLx63EtG+iU9NKpBtf7OfOeOc18WVu
	 S0Ugl7iE1kLcVf2gYXjxNGsSW5g1ayox8TOLbiEzgsE0/ufJsfdMJwZNFrnOOQvRpyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJbN3uNg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE5D606A327;
	Sun,  1 Nov 2026 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJbN3uNg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D9E1F00919;
	Sun,  1 Nov 2026 08:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793522195;
	bh=xf3Loy4nSJ6nnacTtEx28Qg2Cgh08dxFhAwH21XrXA0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UJbN3uNg34jhUaqo46GU1/W6QcMdU+Aklhuk2gXDQ9MbyN6c5gPPVKKtsYqaKR5Hk
	 Ewc22Cm4GL7ErPiG55BCzLBRPV1MLQIYMnz3m1IC0wC83AKSWyfdvc21ts35n1QGVB
	 nr4vtFtSbLOoE0uj5g4wj9C+mDzPt+UfXXW5+tk5A4ArV59+KO547Z2A5OokPDdLQq
	 Hc7t7jwLTnpl3Lu8Gn038ojLVCmX0iMXa6jmjrct0iJ+L8mnd0FKHTFc+rq93e048G
	 jsfrjPZow7mmMvjeyR15RMC2sPUel+m5mBB7YlHBbDBEEJEeFEewelrZP1/XYZYzYq
	 jNQfwL1EHzyDw==
Subject: Re: [PATCH net v4 3/5] net: phy: balance a postponed PHY interrupt
 when the interrupt is freed
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
Date: Sun, 01 Nov 2026 08:36:34 +0000
Message-ID: <179352219428.3131.13487367987610996169@kernel.org>
In-Reply-To: <20261031-b4-phylib-mac-pm-irq-v3-v4-3-5ba23b3ff9a4@iav.lv>
References: <20261031-b4-phylib-mac-pm-irq-v3-v4-3-5ba23b3ff9a4@iav.lv>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: phy: SCHED_FIFO IRQ thread livelock in phy_free_interrupt()
- [Medium] phy_free_interrupt() (drivers/net/phy/phy.c) now calls
  enable_irq() before free_irq() whenever a postponed interrupt left the…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  mdio_bus_phy_suspend() (drivers/net/phy/phy_device.c) sets…

--

net: phy: balance a postponed PHY interrupt when the interrupt is freed

This patch makes phy_free_interrupt() preset irq_rerun. If a postponed
interrupt has already left the line disabled, phy_free_interrupt() now
re-enables it before free_irq(). A new irq_pm_lock serializes this against
the rerun after resume, and the suspend/resume IRQ handling moves into the
helpers mdio_bus_phy_suspend_irq() and mdio_bus_phy_resume_irq().

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index b47f0d3d99e55..49098b4813884 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c

[ ... ]

> @@ -1508,7 +1510,19 @@ EXPORT_SYMBOL(phy_request_interrupt);
>  void phy_free_interrupt(struct phy_device *phydev)
>  {
>  	phy_disable_interrupts(phydev);
> +
> +	/* Re-enable a line left disabled by a postponed interrupt while it
> +	 * is still ours, and keep later postponed interrupts from disabling it.
> +	 */
> +	mutex_lock(&phydev->irq_pm_lock);
> +	if (atomic_xchg(&phydev->irq_rerun, 1)) {
> +		/* Wait for the handler that set irq_rerun to disable the line */
> +		synchronize_irq(phydev->irq);
> +		enable_irq(phydev->irq);
> +	}
>  	free_irq(phydev->irq, phydev);

[Severity: High]
Can the re-enable here livelock the PHY's own irq thread before
free_irq() is reached?

phy_request_interrupt() requests the line with a NULL primary handler
and IRQF_ONESHOT | IRQF_SHARED, so phy_interrupt() runs in an irq
thread that irq_thread() switches to SCHED_FIFO. The callers named in
the commit message run as SCHED_NORMAL tasks: dev_close() from the
ravb and cpsw suspend callbacks, and stmmac_reset_subtask().

Suppose irq_suspended is still true here, and the level source was not
cleared by phy_disable_interrupts(). The commit message allows for
that. It can happen if the MDIO write fails, since the return value is
ignored here. It can also happen if config_intr() masks without acking
the latched status, or if another sharer asserts the line. Then:

phy_free_interrupt()
  atomic_xchg(&phydev->irq_rerun, 1)   <- returns 1, line disabled
  synchronize_irq(phydev->irq)
  enable_irq(phydev->irq)              <- line unmasked, fires
    phy_interrupt()                    <- irq thread, SCHED_FIFO
      irq_suspended is true: postponed path
      atomic_xchg() returns 1, no disable_irq_nosync()
      pm_system_wakeup() / pm_wakeup_dev_event()
      return IRQ_HANDLED
    irq_finalize_oneshot()             <- line unmasked again
    line fires, IRQTF_RUNTHREAD set before the thread can sleep
    irq_wait_for_interrupt() returns at once, loop repeats
  free_irq(phydev->irq, phydev)        <- starved

phy_interrupt() keeps returning IRQ_HANDLED, so threads_handled keeps
advancing and note_interrupt() never treats the storm as spurious.

The irq thread and the caller can share a CPU, for example on a
uniprocessor system or with overlapping affinity. In that case the
SCHED_FIFO thread preempts phy_free_interrupt(), and free_irq() only
runs in whatever time RT throttling or the fair server hands back, if
any. That hangs or badly stalls the close in the MAC suspend callback
or in the reset worker. Each pass through the postponed path also
raises a wakeup event, which aborts the sleep transition in progress.

The commit message says the interrupt then fires until free_irq(), in
the same call, removes the handler. That assumes the caller keeps
running. With irq_rerun preset to 1, the handler has no way left to
take the line down again by itself.

How is the source expected to be quiet by the time enable_irq() runs?
Should phy_free_interrupt() skip the re-enable when
phy_disable_interrupts() fails? Or should it make sure the latched
status is acked first? Or is there a different way to hand the depth
back without unmasking the line under a handler that cannot quiet it?

[Severity: Medium]
Can this enable_irq() leave a still-asserted level interrupt unmasked for
the other users of a shared line?

phy_request_interrupt() always requests the line with IRQF_ONESHOT |
IRQF_SHARED. The postponed branch of phy_interrupt() returns IRQ_HANDLED
without calling drv->handle_interrupt(), so nothing reads or acks the
latched PHY status.

phy_free_interrupt() ignores the return value of phy_disable_interrupts().
That call is the only step here that deasserts the PHY's INT output. For
example, marvell_config_intr() returns right after a failed IMASK write,
before it acks the event register:

drivers/net/phy/marvell.c:marvell_config_intr() {
    ...
	} else {
		err = phy_write(phydev, MII_M1011_IMASK,
				MII_M1011_IMASK_CLEAR);
		if (err)
			return err;

		err = marvell_ack_interrupt(phydev);
	}
    ...
}

In that case the sequence would be:

phy_free_interrupt()
  phy_disable_interrupts()       <- fails, INT stays asserted
  enable_irq(phydev->irq)        <- line unmasked
  free_irq(phydev->irq, phydev)  <- removes only the PHY's action

If other sharers remain, free_irq() leaves the line enabled, and their
handlers return IRQ_NONE. Could the spurious IRQ detector then disable the
line for every sharer ("irq N: nobody cared")?

__setup_irq() only clears IRQS_SPURIOUS_DISABLED when another shared
handler is requested. Resume would not end that outage.

Before this patch, a disabled shared line stayed masked until
mdio_bus_phy_resume(). On the suspended_by_mdio_bus path, phy_init_hw()
quiets the source over MDIO before that enable_irq() runs.

The commit message says:

  On a level-triggered line whose source phy_disable_interrupts() did not
  clear, the interrupt then fires until free_irq(), in the same call,
  removes the handler.

Does that hold only when the PHY is the only user of the line? The
free_irq() kerneldoc also says that for shared lines "the caller must
ensure the interrupt is disabled on the card it drives".

> +	atomic_set(&phydev->irq_rerun, 0);
> +	mutex_unlock(&phydev->irq_pm_lock);
>  }
>  EXPORT_SYMBOL(phy_free_interrupt);
>  
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index d5d0efc104187..ef5e1cd3a8319 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -339,14 +370,7 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
>  	if (phydev->mac_managed_pm)
>  		return 0;
>  
> -	/* Wakeup interrupts may occur during the system sleep transition when
> -	 * the PHY is inaccessible. Set flag to postpone handling until the PHY
> -	 * has resumed. Wait for concurrent interrupt handler to complete.
> -	 */
> -	if (phy_interrupt_is_valid(phydev)) {
> -		WRITE_ONCE(phydev->irq_suspended, true);
> -		synchronize_irq(phydev->irq);
> -	}
> +	mdio_bus_phy_suspend_irq(phydev);

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens to
irq_suspended if phy_suspend() fails at the end of mdio_bus_phy_suspend()?

drivers/net/phy/phy_device.c:mdio_bus_phy_suspend() {
    ...
	if (!mdio_bus_phy_may_suspend(phydev))
		return 0;

	phydev->suspended_by_mdio_bus = 1;

	return phy_suspend(phydev);
}

phy_suspend() can fail with -EBUSY when phydev->wol_enabled is set and the
driver lacks PHY_ALWAYS_CALL_SUSPEND. It can also return an error from the
driver's ->suspend(). In either case the PM core skips the resume callback
for this device, so nothing calls mdio_bus_phy_resume_irq() or
phy_start_machine().

Would every later PHY interrupt then take the postponed path in
phy_interrupt(), with the line disabled once and irq_rerun left at 1? And
would link handling stay stopped until a later suspend/resume cycle
succeeds?

This behaviour dates back to 1758bde2e4aa. A later patch in this series,
"net: phy: stop postponing PHY interrupts when a PHY PM callback fails",
adds the unwind. On a phy_suspend() failure it calls
mdio_bus_phy_resume_irq() and phy_start_machine(), and it sets
suspended_by_mdio_bus only on success.

>  
>  	/* We must stop the state machine manually, otherwise it stops out of
>  	 * control, possibly with the phydev->lock held. Upon resume, netdev

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4%40iav.lv
