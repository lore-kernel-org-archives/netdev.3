Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC92F7EE7;
	Fri, 11 Sep 2026 03:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098689; cv=none; b=LFt66ogsuSGn3UiPntR7cVw1rZ0SLNx8uN/lr2jTAvhV7o32LrPZBrVbvO7+fORdmCPOpU2X5ZUW4CnfmgdHscBxW6uLmjYHsaT6kYluZzhGrNJxVtxQb3IGi0fmlQSUlOxTxfy85s1hmt5ahh5ysqoNmrrOx1+lnPbntyDYrUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098689; c=relaxed/simple;
	bh=jhaXMbEqFAGG1BYQ4hT83wZRdrqFjoRbXyE95aYGjHQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8Q2bBeORjJk4yNxfJez+xmsew0mBcnHc0HhiVYofDZnpwwUD/y2Ao9Y7kjp7Vn/l8BYb4whZTM2Up04WZz9aHSDIeSP4gF5ut31dO7yWF7egpYgrRabKmvT9afGNXwPm6MAcgYXSJvMcE0dEW5/4D8UkU0l+K8G02mV10/ird4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBDw4vXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBDw4vXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143E91F00893;
	Fri, 11 Sep 2026 03:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789098687;
	bh=4PIIPLikARhx+ISSplyjJ5hdNCv4TnEMaKWm21wWOGk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OBDw4vXKDOjy6fUzmiNlXIJhK1JGQ2zR7Hr3muhsla5AVKh47csbU99oOF+i1ovNc
	 aUBBJ/sEvEL6foglA1pIFU5erFy5oYFRE3FpHadKmgF4iQeHh0WVlgc+sYaQ6a8g9n
	 EN9x2el4CNoyjoJ1sY6tRzzAL4v6woMo8yyfcC57e/jem/U5AEIYaAJ0bj9P8XhIl1
	 jUjhyjK2GbGQVeQZLZ16nzF1/L/Ipl6hokfdvrarTYkbLo725llY8+EP6s1iJSKEUO
	 FXOjiSgMxtPc3jjI7jL7jHWKLMerPttgc/XOa6NfHvsGJVgL8f/M8gtrmZTtlIZxDe
	 RjTVs2mwrciVQ==
Subject:
 Re: [PATCH net v6 2/2] net: phy: restore the interrupt the bus gave a PHY
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 03:51:26 +0000
Message-ID: <178909868657.219967.11602145101392158508@kernel.org>
In-Reply-To: <20260908155025.4155289-3-f@lex.la>
References: <20260908155025.4155289-3-f@lex.la>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] phy_restore_probe_irq() bails out whenever
  phydev->phy_link_change is non-NULL and records no pending…
- [Medium] phy_restore_probe_irq() performs an unsynchronized check-then-
  act on state owned by the rtnl-side attach/detach paths.
- [Low] No Fixes: tag (and no target-tree indication) on a patch whose
  changelog describes a concrete, lasting user-visible defect.

--

net: phy: restore the interrupt the bus gave a PHY

phy_probe() demotes phydev->irq to PHY_POLL when the binding driver has no
interrupt support, and nothing restores it afterwards.  This patch adds a
helper that copies the number back out of mdiobus->irq[], and calls it from
phy_remove(), phy_probe()'s error exit and the phy_attach_direct() unwind.
The helper skips the restore while phydev->phy_link_change marks an attached
consumer.

>     A bus whose driver writes only phydev->irq and never the table is not
>     covered, because the table then holds PHY_POLL and there is nothing to
>     give back; lan78xx, smsc95xx and sxgbe are in that position today and
>     registering the interrupt with the bus is theirs to do.
>
>     This needs commit e0d1c55501d3 ("net: phy: fix
>     phy_uses_state_machine()") to be of any use: without it the mark this
>     skips on is never cleared once a consumer has attached, and the restore
>     never runs.
>
>     Assisted-by: LLM
>     Signed-off-by: Aleksei Sviridkin <f@lex.la>

[Severity: Low]
The changelog describes a lasting user-visible defect ("polls for the rest
of the uptime once the real driver takes over"), but the tag block carries
no Fixes: line and the subject has no net/net-next scoping.

The assignment being undone, in phy_probe():

	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;

is the natural blame target.  Could a Fixes: tag pointing at it (or an
explicit statement that this targets net-next as a behavioural change) be
added?

This matters more than usual given the stated dependency on e0d1c55501d3,
which is what clears phydev->phy_link_change in phy_detach().  On a tree
without that commit the new restore in phy_remove() is a silent no-op, so a
backport applies cleanly and changes nothing.  Should that boundary be
spelled out for stable?

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a3..b55402569300 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1734,6 +1734,19 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
>  	return phydrv->config_intr && phydrv->handle_interrupt;
>  }
>
> +/* Give back what phy_probe() took, from the bus that owns the number, but
> + * not while phy_link_change marks a consumer: it skipped
> + * phy_request_interrupt() on the value it saw, so phy_disconnect() would
> + * free an interrupt nobody requested.
> + */
> +static void phy_restore_probe_irq(struct phy_device *phydev)
> +{
> +	if (phydev->phy_link_change || phydev->irq != PHY_POLL)
> +		return;
> +
> +	phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
> +}

[Severity: Medium]
Can this check-then-act run concurrently with the attach/detach paths that
own phydev->phy_link_change and phydev->irq?

The helper reads phy_link_change and irq, then writes irq, running from
phy_probe()/phy_remove() under the mdio device lock only.  The writers of
that same state take neither the mdio device lock nor phydev->lock:

phy_attach_direct()
	phydev->phy_link_change = phy_link_change;
	...
	if (phydev->dev_flags & PHY_F_NO_IRQ)
		phydev->irq = PHY_POLL;

	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;

phy_detach()
	phydev->phy_link_change = NULL;

phy_driver_register() leaves suppress_bind_attrs unset, so a root sysfs
unbind can enter phy_remove() at any time, and __device_release_driver()
clears dev->driver only after ->remove() returns, so a concurrent
phy_attach_direct() still sees d->driver != NULL and proceeds.

One interleaving:

CPU0 phy_remove() -> phy_restore_probe_irq()
	reads phy_link_change == NULL, irq == PHY_POLL
	(preempted before the store)

CPU1 phy_attach_direct()
	phydev->phy_link_change = phy_link_change;
	phydev->irq = PHY_POLL;		/* no phy_request_interrupt() */

CPU0 resumes
	phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];

Does that leave a valid IRQ published for a consumer that requested
nothing, so that teardown hits:

phy_disconnect()
	if (phy_interrupt_is_valid(phydev))
		phy_free_interrupt(phydev);

and free_irq(phydev->irq, phydev) warns about freeing an already-free IRQ?
phy_polling_mode() is also false at that point, so link changes would be
neither polled nor interrupt driven, which is the situation the new comment
says it avoids.

The reverse order gives the opposite outcome: phy_remove() observes a still
non-NULL phy_link_change just before phy_detach() clears it, and the PHY is
left unbound with irq == PHY_POLL.

Would making the individual accesses atomic help here, or does the decision
plus the store need to be serialized against the whole attach/detach and
interrupt request/free sequence, for example by driving the restore from
phy_detach() under rtnl?

> @@ -3848,6 +3864,8 @@ static int phy_remove(struct device *dev)
>  	if (phydev->drv && phydev->drv->remove)
>  		phydev->drv->remove(phydev);
>
> +	phy_restore_probe_irq(phydev);
> +

[Severity: Medium]
When phy_restore_probe_irq() takes the phy_link_change early return here, is
the interrupt number ever restored later?

The changelog says restoring at the three bind-cycle exits means "a bind
that is undone by any path leaves the PHY as it was found", but nothing
records a pending restore for the skipped case.

A driver unbind while a consumer is still attached:

unbind_store()
	if (dev && dev->driver == drv) {
		device_driver_detach(dev);

reaches phy_remove() with phy_link_change still set by phy_attach_direct(),
so the helper returns early and phy_remove() then clears phydev->drv.

When the consumer disconnects afterwards, phy_detach() clears the marker but
its release is gated:

	phydev->phy_link_change = NULL;
	...
	if (phydev->is_genphy_driven) {
		device_release_driver(&phydev->mdio.dev);
		phydev->is_genphy_driven = 0;
	}

and for an already-unbound device device_release_driver() is a no-op, so
phy_remove() does not run again and no restore happens.  A later
interrupt-capable driver then sees phydev->irq == PHY_POLL in phy_probe(),
phy_interrupt_is_valid() is false, and polling continues.

The early return itself looks necessary, since restoring under an attached
consumer is what would make phy_disconnect() free an unrequested IRQ.  Could
the skipped restore instead be completed in phy_detach() right after
phy_link_change is cleared?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908155025.4155289-1-f%40lex.la
