Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88A416872;
	Mon,  5 Oct 2026 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205299; cv=none; b=jVTbUBgw4puzEF7u6udQSAbS+y3ZxhXHW9cSmlRFoGYlorHrnkGXoXRoOZAvEVQV0ToQX934vK2bL+ZomOikTbBKnENZEM5VU3/IKgjZpvi8fJixgoUQAlJpPttKo6npJ1R8x9VnFlfeIxsWUgdGu8WAr1HHthZZ52Dpy2+HKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205299; c=relaxed/simple;
	bh=IPXB97V7tdTxmTmfIXotJ9rAqgVyJYaAFjENyONcXPw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dsycvs+8+MgVjuZOcqIp3H2yoGRhaGcDk+obSRYLW0X0oLQf46TGRkYhlZYyjV4m3lofoIpUY/xiFzCUQtLQ1ItDgejmvxlbTbEtgFZ0Ad5xPTdd3Hfwfumgp0eLfIE5iIe7QKTQ7yKu8tE+5wMjT8jI52n+WuvJsCNnJmVDeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV6Y4eQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV6Y4eQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C51E1F00893;
	Mon,  5 Oct 2026 13:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791205297;
	bh=0qOu31ZdeV7SP3zgGHp8/XQRKuct8TsEPu3dVARqOE0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bV6Y4eQuqpqEyCicA1n18HOJ8hmsfVvVVkwcUTSTnkDL+yMF1q7rGnqMN4it0BAyr
	 quE3HVyAgMaUfgRkCH5uZsHDDnSom/Zd39OgbCpEp6TfmaIMYMk8vaCIvmMFXbquud
	 osCV0A+FoPY4sGbelqxaQHJ4BYFpaKHXGQHl49kxyFTaPJv7XBAN7NGTqjzR9LLX6Y
	 3J1zFYoEoLFk9XoAuT5hO0/7LVxCLwI5rA4iwxSBYQzXUGDa/cFKejo7C5Jee6biEl
	 nPxTRGJLekhsiPloaa9aXi6wkDJj1nrQfuQJTb3s/0l8fY72hdLP8XYwCP/ATIhIVm
	 9EpzbU5Cdt79A==
Subject:
 Re: [PATCH net-next v4 2/4] net: phy: put the driver module the attach took
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, woojung.huh@microchip.com, vladimir.oltean@nxp.com,
 maxime.chevallier@bootlin.com
Date: Mon, 05 Oct 2026 13:01:36 +0000
Message-ID: <179120529682.434549.14716397298418819879@kernel.org>
In-Reply-To: <20261001130120.104628-3-f@lex.la>
References: <20261001130120.104628-3-f@lex.la>
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

- [Medium] In phy_attach_direct() (drivers/net/phy/phy_device.c), this
  patch adds `phydev->drv_owner = d->driver->owner;` at line 1834, right…

--

net: phy: put the driver module the attach took

This commit adds a drv_owner field to struct phy_device. The field
records which PHY driver module phy_attach_direct() pinned. On detach,
phy_detach_internal() and the attach error path now release that
recorded module instead of reading phydev->mdio.dev.driver again.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 0bdd2dc84d81a..b5074599c988f 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1831,6 +1831,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  		err = -EIO;
>  		goto error_put_device;
>  	}
> +	phydev->drv_owner = d->driver->owner;

[Severity: Medium]
Can this record a different module than the one just pinned? The
reference is taken from one load of d->driver, and the owner is saved
from a second, separate load:

	if (!try_module_get(d->driver->owner)) {
		phydev_err(phydev, "failed to get the device driver module\n");
		err = -EIO;
		goto error_put_device;
	}
	phydev->drv_owner = d->driver->owner;

At this commit, nothing in phy_attach_direct() blocks a driver core
unbind. A sysfs unbind or a module removal runs phy_remove() and then
device_unbind_cleanup(), which calls device_set_driver(dev, NULL).

Suppose that happens between the two loads:

CPU0 (attach, under RTNL)          CPU1 (unbind_store())
try_module_get(d->driver->owner)
                                   phy_remove()
                                   device_unbind_cleanup()
                                     device_set_driver(dev, NULL)
phydev->drv_owner = d->driver->owner

Would the second load then dereference a NULL d->driver? Before this
patch, the non-genphy path did not read d->driver a second time here,
and the read on the detach side checked for NULL.

Now suppose a different driver binds in that window instead. Then
drv_owner names a module that was never pinned. phy_detach_internal()
would call module_put() on that module, and the reference on the
original module would leak. That is the same mismatch this patch is
meant to remove.

The later patch in the series, "net: phy: serialise attach and detach
with PHY driver bind and unbind", closes the unbind window. It holds
phydev->bind_lock across both loads.

The genphy path still has a gap. When d->driver started out NULL, a
concurrent really_probe() does not take bind_lock, so it could still
change d->driver between the two loads.

Would it be simpler to load the owner once into a local variable? Then
the recorded module would always be the one that was pinned:

	struct module *owner = d->driver->owner;

	if (!try_module_get(owner)) {
		...
	}
	phydev->drv_owner = owner;

>  
>  	if (phydev->is_genphy_driven) {
>  		err = d->driver->probe(d);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001130120.104628-1-f%40lex.la
