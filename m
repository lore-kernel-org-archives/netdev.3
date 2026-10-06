Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A44280035;
	Tue,  6 Oct 2026 04:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261522; cv=none; b=Ek4ytEmZ7460q25bjmIjn4fdpD/KkzVInBFDs4yad2WuRnABH7zCeVXEQvKBrFNt0Yq127kzg655aS/0ImXVnCUhQUlkcaVfviMjIGUObcf+QN91tZyvclnFbvk4LJaj0xIOrg2NwYAIYtb/ss/wY4Bzd4nKI01TrD1gjtcbDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261522; c=relaxed/simple;
	bh=EXcf4HrlEsiEZbYb8R9nfspNzXXtk4B/drwzPmE08Uc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+IzsvhAo2Y7AQcFWLyrggdUHhvqLChb6cByouoKhA90U8+CARVqmBCd2cFb3yig3nNoKu7iT27B+IhjOsCu/c2bJX3Olv5F4fM26cv6XZvFBLZCVVIgaxPaya3W1yI3uuxmcr7RiXXjBJY3gT+khv1r8d267PXMdq89Ev6CoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXRrQmJj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXRrQmJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4283A1F000FF;
	Tue,  6 Oct 2026 04:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791261520;
	bh=Al+ssZhorriri1m9xPdZFWdvFDdWVs5U0EFLX2WEmMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WXRrQmJjA9jYfCq7tQjX14o3mN5Z9LG0aBeMI/b6wmJJZSa/dMehdLphoSGgQsC+Y
	 66kkxMhpVe4lH3VsF6m6CppGFuaWJUdGOiSa+B/LudfQ/gG8l+kwm/U+E+ciqUd8gA
	 zkCx38VzVF14kT3uezC92Z/bLH1vqmRZT2OnF3L5KiEcZQWAMGykXc57WKoPxunOYe
	 wVodtF0yQuWtwcsTDoSyWoV+XBEc3FaQ5WZL3vJknksuzAHOlaERaEeKzteZpobkH6
	 ltiNpFHUnYxZkWsAd8UAYIDLmqY1D6y/JIZlpymBgQcJvqbOni/9NPk/pOoIbubd2f
	 rGGzVmrmH9oKg==
Subject: Re: [PATCH net] net: phy: postpone PHY interrupts during sleep with
 MAC-managed PM
From: netdev-bot+sashiko@kernel.org
To: iav@iav.lv
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 lukas@wunner.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 04:38:39 +0000
Message-ID: <179126151976.434549.14913657176913683654@kernel.org>
In-Reply-To: <20261002043548.1302145-1-iav@iav.lv>
References: <20261002043548.1302145-1-iav@iav.lv>
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

Critical: 0 · High: 1 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On a shared IRQ line, the new `phydev->irq_rerun = 0` in
  phy_free_interrupt() (drivers/net/phy/phy.c:1511) loses track of the…
- [Medium] phy_free_interrupt() clears phydev->irq_rerun (phy.c:1511)
  before free_irq() (phy.c:1512) has synchronized with the threaded…
- [Medium] irq_suspended and irq_rerun are 1-bit fields
  (include/linux/phy.h:705-706).

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but for non-MAC-
  managed PHYs, mdio_bus_phy_suspend() sets irq_suspended and stops the…

--

net: phy: postpone PHY interrupts during sleep with MAC-managed PM

This patch makes mdio_bus_phy_suspend() set irq_suspended for PHYs whose
PM is managed by the MAC driver. mdio_bus_phy_resume() then replays any
postponed interrupt. It also clears irq_rerun in phy_free_interrupt(), so
MAC drivers that close the interface during suspend don't replay an
interrupt for a freed handler.

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index fce9bc7be3304..cd189ecee55ea 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1507,6 +1507,8 @@ EXPORT_SYMBOL(phy_request_interrupt);
>  void phy_free_interrupt(struct phy_device *phydev)
>  {
>  	phy_disable_interrupts(phydev);
> +	/* A freed interrupt has nothing left to rerun on resume. */
> +	phydev->irq_rerun = 0;
>  	free_irq(phydev->irq, phydev);
>  }

[Severity: High]
Can this leave the IRQ line disabled for good when the line is shared?

When phy_interrupt() postpones an interrupt, it also raises the disable
depth:

drivers/net/phy/phy.c:phy_interrupt() {
    ...
		phydev->irq_rerun = 1;
		disable_irq_nosync(irq);
		return IRQ_HANDLED;
    ...
}

Clearing irq_rerun here drops the only record of that disable, and no
enable_irq() balances it. This relies on free_irq() and the later
re-request to reset desc->depth.

That reset only happens on an exclusive line. phy_request_interrupt()
always passes IRQF_SHARED. __free_irq() only shuts the line down when the
last action is removed:

kernel/irq/manage.c:__free_irq() {
    ...
	if (!desc->action) {
		irq_settings_clr_disable_unlazy(desc);
		/* Only shutdown. Deactivate after synchronize_hardirq() */
		irq_shutdown(desc);
	}
    ...
}

On re-request, __setup_irq() only calls irq_startup(), which sets the
depth back to 0, in its !shared branch.

With this patch, mac_managed_pm PHYs now get irq_suspended set. MAC
drivers such as ravb and sh_eth close the interface in suspend, so the
sequence could be:

mdio_bus_phy_suspend()
    phydev->irq_suspended = 1;
phy_interrupt()             /* fires before the MAC suspend callback */
    phydev->irq_rerun = 1;
    disable_irq_nosync(irq);     /* depth + 1 */
ravb_suspend()->ravb_close()->phy_disconnect()->phy_free_interrupt()
    phydev->irq_rerun = 0;
    free_irq()              /* another action remains, no irq_shutdown() */
ravb_resume()->...->phy_request_interrupt()
    __setup_irq()           /* shared path, depth unchanged */
mdio_bus_phy_resume()->mdio_bus_phy_resume_irq()
    irq_rerun == 0, so enable_irq() is skipped

If another PHY or device stays registered on the line across suspend,
does the line then stay masked for every user after resume?

Would it be better to balance the disable here instead? For example:
synchronize, then call enable_irq() if irq_rerun is set, all before
free_irq().

[Severity: Medium]
Is there a window where irq_rerun gets set again after this clear?

irq_rerun is cleared before free_irq() has synchronized with the
threaded handler. A phy_interrupt() thread may already be running, or
may have been woken by an interrupt that arrived before
phy_disable_interrupts(). That thread can still take the postponed
branch afterwards:

CPU1                                  CPU2 (IRQ thread)
phy_free_interrupt()
  phy_disable_interrupts()
  phydev->irq_rerun = 0;
                                      phy_interrupt()
                                        phydev->irq_rerun = 1;
                                        disable_irq_nosync(irq);
  free_irq()
    __synchronize_irq()

phy_free_interrupt() then returns with irq_rerun still set.

On a non-shared line, the MAC resume requests the IRQ again and
irq_startup() resets desc->depth to 0. mdio_bus_phy_resume_irq() then
sees the stale irq_rerun and calls enable_irq() at depth 0. That hits
the warning in __enable_irq():

		WARN(1, KERN_WARNING "Unbalanced enable for IRQ %d\n",

An unrequested irq_wake_thread() follows.

If the interface is not reopened, won't enable_irq() and
irq_wake_thread() run on a line that has no phylib action?

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a37..9488189648417 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -375,13 +376,33 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
>  	return phy_suspend(phydev);
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens if
phy_suspend() fails here for a PHY that is not MAC managed?

By this point, mdio_bus_phy_suspend() has already set irq_suspended and
stopped the state machine. Neither step is undone on error.

device_suspend() only sets dev->power.is_suspended on success.
device_resume() skips any device without it:

drivers/base/power/main.c:device_resume() {
    ...
	if (!dev->power.is_suspended)
		goto Complete;
    ...
}

So after an aborted system suspend, mdio_bus_phy_resume() never runs
for this PHY. Do its interrupts then stay postponed and disabled, with
the state machine stopped?

>  
> +static __maybe_unused void mdio_bus_phy_resume_irq(struct phy_device *phydev)
> +{
> +	if (!phy_interrupt_is_valid(phydev))
> +		return;
> +
> +	phydev->irq_suspended = 0;
> +	synchronize_irq(phydev->irq);

[Severity: Medium]
Can these unlocked bitfield writes lose updates now that the postpone
window also covers mac_managed_pm PHYs?

irq_suspended and irq_rerun are 1-bit fields in struct phy_device. They
share a storage unit with suspended, suspended_by_mdio_bus,
mac_managed_pm, wol_enabled, link, autoneg_complete, interrupts and
other bits.

phy_interrupt() writes phydev->irq_rerun = 1 without holding
phydev->lock. This patch adds another unlocked write,
phydev->irq_rerun = 0, in phy_free_interrupt().

Here, irq_suspended is cleared before synchronize_irq(). An IRQ thread
may still be doing its own read-modify-write of the same word at that
point.

For mac_managed_pm PHYs, irq_suspended now stays set across the MAC
driver's suspend and resume callbacks. Those callbacks run PHY code
that writes suspended, wol_enabled, link and autoneg_complete under
phydev->lock:

  phylink_suspend()/phy_stop()
  phylink_resume()/phy_resume()
  the state machine

The postponed branch of phy_interrupt() does not take phydev->lock.

If the irq_rerun = 1 update is lost, could the line stay disabled with
no replay?

If the irq_suspended = 0 update here is lost, would later interrupts be
postponed forever?

A lost suspended or link bit would also leave the PHY state flags wrong.

> +
> +	/* Rerun interrupts which were postponed by phy_interrupt()
> +	 * because they occurred during the system sleep transition.
> +	 */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002043548.1302145-1-iav%40iav.lv
