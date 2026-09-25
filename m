Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426C222126C;
	Fri, 25 Sep 2026 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790299341; cv=none; b=ju9itEfzu6NC9mT428AebjlB4NTEDSvNrxCQXu4+KPBmHUMEW+J22z3sY8hLUNP+eX3OSGYfgDgnUvv40pLPIqpl3PD4by0QslMw8W0qpnjTSfSl47duczglgig8G7SqyfXZYqrlvhTahd8RBQ7U1gm3eWiDcUaMLzn4XPGuLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790299341; c=relaxed/simple;
	bh=IHOG16fhnpeS2lbMtLrMD9Kcx6EOoKekV4HrKJuApSQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xtb/frxobldgwRTMaCNYwCtdHqZwZOarKn2muIKpW9LjW7pQGHo+sj6YzO1WkdXrp5LJDT36zdWkdCUpuTYjOeoKRwBKY1X84NyjwVGIS2MLjXBWumPCtqY6cdLQYWMX4Wu0qk9l3zn4eDPqSVIub7m0FZGEwEAdeqSwpZPFziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9PY1Qfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9PY1Qfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1197C1F000FF;
	Fri, 25 Sep 2026 01:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790299339;
	bh=ZjNiNhTLnTtx74UjD4snFKIjvztkIw+w9+n/Iof6W6k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P9PY1Qfp1Nos6m4zLJl1lF/xYaRR5gAPZ0LPl2cMoeU04tL0Gwte3z0EMSgrwvhGk
	 2aHS2iPAKjSz0Nho5osceBpZ8VK1HsnxOP72b2hREiqkrTzWhs7fEIJAZPTAqSi2wi
	 l+4W+aB7JkouI2/9mEzN5uP10H5n1/XegdKnl6BIXe5FsZj7GHIyKyaL7yHEv/QzdI
	 Er+Qd0NMhQ1fycBxdRZGZIMbaxKiQn6TzCvX+ad4IlIP6JcxysdZzQqX+E2Y900bZO
	 exF4/gQ0dox5rKa4vX32Gdxnu50PIoc+n/1n/oky2cxUEXlFCIJWlmd4+ob2F2tt04
	 VTsz/9VaonV6g==
Subject: Re: [PATCH net v10 3/4] net: phy: take the interrupt back from the
 bus on detach
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 01:22:18 +0000
Message-ID: <179029933858.2160803.12630945851451903090@kernel.org>
In-Reply-To: <20260922131955.4175785-4-f@lex.la>
References: <20260922131955.4175785-4-f@lex.la>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The restore added to phy_detach()
  (drivers/net/phy/phy_device.c:1967-1971) is keyed on…
- [Low] Concern as filed: the new store in phy_detach()
  (phy_device.c:1967-1971) is gated only by phydev->is_genphy_driven…

--

net: phy: take the interrupt back from the bus on detach

phy_probe() overwrites phydev->irq with PHY_POLL when the bound driver has
no interrupt support, and nothing restored it, so a PHY that first gets the
generic driver keeps polling after its real driver binds. The patch restores
phydev->irq from mdiobus->irq[] in phy_detach(), before
device_release_driver(), gated on phydev->is_genphy_driven.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a37..a9c71a2861186 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1965,6 +1965,8 @@ void phy_detach(struct phy_device *phydev)
>  	 * real driver could be loaded
>  	 */
>  	if (phydev->is_genphy_driven) {
> +		/* The release below lets phy_probe() write this field. */
> +		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];

[Severity: Medium]
Is the restore complete if it is placed here rather than next to the write
it undoes?

The store being undone is in phy_probe() and does not look at
is_genphy_driven at all:

drivers/net/phy/phy_device.c:phy_probe() {
	/* Disable the interrupt if the PHY doesn't support it
	 * but the interrupt is still a valid one
	 */
	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;
	...
}

So it runs for whatever driver the driver core binds, including a real PHY
driver without interrupt support. The matching unbind goes
device_release_driver() -> phy_remove(), and phy_remove() contains no
phydev->irq write:

drivers/net/phy/phy_device.c:phy_remove() {
	...
	if (phydev->drv && phydev->drv->remove)
		phydev->drv->remove(phydev);

	/* Assert the reset signal */
	phy_device_reset(phydev, 1);

	phydev->drv = NULL;

	return 0;
}

Two paths then still end with PHY_POLL and no restore site:

- genphy_driver is registered without suppress_bind_attrs, so a bind through
  /sys/bus/mdio_bus/drivers/Generic PHY/bind leaves is_genphy_driven at 0,
  and the unbind reaches phy_remove() only;
- rmmod of an interrupt-less PHY driver, after which a later driver that does
  support interrupts inherits PHY_POLL while mdiobus->irq[addr] still holds
  the number.

Would saving the pre-substitution value in phy_probe() and restoring it in
phy_remove() cover those as well as the path this patch covers?

For the record, the sibling gap on the error_module_put label in
phy_attach_direct() is closed by the later patch in this series, "net: phy:
restore the interrupt when the generic bind cycle fails", which adds the same
store there. The phy_remove() and sysfs-unbind paths above are still
uncovered at the end of the series.

[Severity: Low]
Can is_genphy_driven be stale at this point?

There are only three writes of that flag, one set in phy_attach_direct() and
two clears, one on the error_module_put label and the one added just below
this store. phy_remove() does not clear it. After a sysfs unbind of "Generic
PHY" on an attached phydev the flag stays 1 while phydev->mdio.dev.driver is
NULL, so a subsequent bind of a real driver followed by phy_detach() takes
this branch and writes mdiobus->irq[addr] over the PHY_POLL that phy_probe()
wrote on purpose for a driver without interrupt support.

The effect looks limited: both phy_request_interrupt() call sites,
phy_connect_direct() and phylink_bringup_phy(), run right after
phy_attach_direct(), which re-applies the same substitution against the
driver bound at that moment:

drivers/net/phy/phy_device.c:phy_attach_direct() {
	...
	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;
	...
}

so the wrong value only lives in the detached window. Would it still be
worth clearing is_genphy_driven from phy_remove() so the flag tracks the
binding it names?

The commit message says of the placement before device_release_driver():

    That is ordering, not exclusion: nothing on this side holds the device
    lock.

With a stale flag, is phy_probe() on another CPU also a writer of this field
before device_release_driver() is reached, rather than only after it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922131955.4175785-1-f%40lex.la
