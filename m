Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FB72ED84A;
	Mon,  5 Oct 2026 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187646; cv=none; b=C/XrRLLN4E6aytQ+fOe5/DNilesIBiMb9DlQ9F0SNuvQsoGzLkDHM3OtEyeoI/K3JPZ1UhTNZfCS0J2uRMLdalcWY5moHCY/3Tg39ciHscWGJViv4Wi36qSNnmBntuXntHCCBkGqw9HBrzL3Jh6aHqYJBOkVP5Du0k0WyFxGx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187646; c=relaxed/simple;
	bh=5MAFg4lualOQ4wF9YuSfq87SCufHgj7pToEhAngQk4M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eh7ShVgseQuOux6q6QD06w3BtpqvrfZdGTeThl3j5DQcNRdX2YqWrR8IuOzCt3hvjT9mSn+OiHbBW8gSGzxMiiN+ZpvieNMYglldvxsn3hbalagDtbI395MHiATfyA2YA+fiOS9AUa2VcXDF/SCBBHCi7DBb5gJBAop45Ccn52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHKVX4rQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHKVX4rQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E231F000FF;
	Mon,  5 Oct 2026 08:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791187645;
	bh=XXkyvNpPZqrM5P5UyeacA+TyFuP56hMHBlt411AUfhk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FHKVX4rQKpRY8RrCMtnTYucloQH8ReN38hlkAK1CA5qYPt8kQamrFV62rn9/Pf0b8
	 SYy8fhLnFufschUrdMxZlL4rkxwkLGq6jZ4BtVmBL+Rx1ydZQmh9D2EkBfAQc+EKco
	 9PekgerDeWSVRzRGOUMDwxU9fF860loJZvgejSh+aU0Jla7I5iSJHuutjjrKsIwnNH
	 +NiBMkVf7XBgVqIl0+E+bSh8J+dkzODQyb7FMav1auMNwIXYKb4MVRm/nWQgCGbBda
	 n2sAWr1z04Qsuu3zcrtIbOLmdgY9SZo//jwuIMxT0HEKKuUDt4qzah/iDBIhfcT1jR
	 UXMlF5+OQA9kQ==
Subject:
 Re: [PATCH net 2/2] net: phy: xilinx-gmii2rgmii: Restore PHY driver on remove
From: netdev-bot+sashiko@kernel.org
To: vineeth.karumanchi@amd.com
Cc: git@amd.com, netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 f.fainelli@gmail.com, harini.katakam@amd.com, appanad@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 08:07:23 +0000
Message-ID: <179118764380.434549.2031845358588611322@kernel.org>
In-Reply-To: <20261001074718.3944521-3-vineeth.karumanchi@amd.com>
References: <20261001074718.3944521-3-vineeth.karumanchi@amd.com>
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] xgmiitorgmii_remove()
  (drivers/net/phy/xilinx_gmii2rgmii.c:147-149) always writes the driver…
- [High] The fix relies on every reader of phydev->drv holding
  phydev->lock, and that is not true.

--

net: phy: xilinx-gmii2rgmii: Restore PHY driver on remove

This adds a remove callback to the GMII-to-RGMII converter. The callback
restores the attached PHY's original phydev->drv under phydev->lock, so
phydev->drv no longer points at the devres-freed conv_phy_drv copy after
the converter is unbound. It also drops the device reference taken by
of_phy_find_device().

> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index 61f71e977a574..b9aa5515577b5 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -128,10 +128,29 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)

[ ... ]

> +static void xgmiitorgmii_remove(struct mdio_device *mdiodev)
> +{
> +	struct gmii2rgmii *priv = mdiodev_get_drvdata(mdiodev);
> +
> +	/*
> +	 * The attached PHY is a separate, still-bound device whose state
> +	 * machine keeps running and dispatches ->read_status / ->set_loopback
> +	 * under phydev->lock. Restore its original driver under that lock so
> +	 * the swap cannot race an in-flight dispatch; the restored driver is
> +	 * the PHY's own static phy_driver, not the devres-freed conv_phy_drv.
> +	 */
> +	mutex_lock(&priv->phy_dev->lock);
> +	priv->phy_dev->drv = priv->phy_drv;

[Severity: High]
Is it safe to write priv->phy_drv back here without first checking that
phydev->drv still points at &priv->conv_phy_drv?

The only thing the converter holds is the device reference from
of_phy_find_device(). There is no device link and no module reference on
the PHY driver. That means the PHY can be unbound or rebound while the
converter stays bound, and in that case phylib has already changed
phydev->drv:

drivers/net/phy/phy_device.c:phy_remove() {
    ...
	phydev->drv = NULL;

	return 0;
}

A rebind does the same thing: phy_probe() installs a new driver with
phydev->drv = phydrv.

If the converter is unbound after that, xgmiitorgmii_remove() writes back
the stale pointer that xgmiitorgmii_probe() saved. Three outcomes look
possible.

First, an unbound PHY gets a non-NULL drv again. That passes the
"if (!phydev->drv)" guards in phy.c and phy_device.c. The old driver's
callbacks then run against a phydev->priv that devres already freed. If
the PHY driver module was unloaded, they run in freed module text.

Second, if the PHY was rebound to another driver (for example Generic
PHY), the old driver's ops get installed over the new binding. They then
see the new driver's phydev->priv.

Third, if the converter is probed again, it passes the
!priv->phy_dev->drv check in xgmiitorgmii_probe() and memcpy()s from the
stale driver struct.

The comment above assumes the PHY is still bound and that the restored
driver is the PHY's own phy_driver. Nothing seems to enforce either
assumption.

Would it be better to restore only when phydev->drv == &priv->conv_phy_drv,
and to tie the converter's lifetime to the PHY binding?

> +	mutex_unlock(&priv->phy_dev->lock);

[Severity: High]
Does taking phydev->lock here actually prevent the use-after-free on
conv_phy_drv? The commit message says:

    Restore the attached PHY's original driver while
    holding phydev->lock so that the update cannot race with an active PHY
    callback.

The lock only excludes readers that also hold phydev->lock, and not every
reader of phydev->drv does. Once xgmiitorgmii_remove() returns,
devres_release_all() frees priv, and conv_phy_drv along with it.

The state machine drops the lock before its suspend step:

drivers/net/phy/phy.c:phy_state_machine() {
    ...
	mutex_lock(&phydev->lock);
	state_work = _phy_state_machine(phydev);
	mutex_unlock(&phydev->lock);

	_phy_state_machine_post_work(phydev, state_work);
}

phy_stop() does the same. _phy_state_machine_post_work() then calls
phy_suspend(), which copies phydev->drv into a local and dereferences it
with no lock held:

drivers/net/phy/phy_device.c:phy_suspend() {
    ...
	const struct phy_driver *phydrv = phydev->drv;
    ...
	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
		return -EBUSY;

	if (!phydrv->suspend)
		return 0;

	ret = phydrv->suspend(phydev);
    ...
}

phy_ethtool_get_sset_count() also dereferences the driver before it takes
the mutex. It is reachable from the ethtool ioctl through
ethtool_get_phy_stats_phydev():

drivers/net/phy/phy.c:phy_ethtool_get_sset_count() {
    ...
	if (phydev->drv->get_sset_count &&
	    phydev->drv->get_strings &&
	    phydev->drv->get_stats) {
		mutex_lock(&phydev->lock);
    ...
}

Could this sequence happen?

CPU0                                  CPU1
phy_suspend()
  phydrv = &priv->conv_phy_drv
                                      xgmiitorgmii_remove()
                                        mutex_lock(&phydev->lock)
                                        phydev->drv = priv->phy_drv
                                        mutex_unlock(&phydev->lock)
                                      devres_release_all()
                                        kfree(priv)
  phydrv->flags / phydrv->suspend

If so, CPU0 would read freed memory and might call through it. That is the
same kind of use-after-free this patch is meant to fix.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001074718.3944521-1-vineeth.karumanchi%40amd.com
