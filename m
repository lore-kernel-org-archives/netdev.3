Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268F36E49B;
	Sun, 11 Oct 2026 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698773; cv=none; b=b+AXQCrTTaJDmM0yjG3U2OHIKxstELxbrY+tzWftWrGfyBk1B7Dr869wnU5/Qdxl7Yv/+2XLbZbUqpMhKo9ywdXIDG9ZLnjTzprsBNr3tmy0D0+yl0NiThlCP8ismr0QD369wPLl19a629/1bQhOwk0/qij5EI9xtB4wuRs5OmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698773; c=relaxed/simple;
	bh=whuH7ypRBSdmEHTbUjWjCsumvXTRYw2g8iLoOHdt/Tk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KVG5U5t72p51L4xS7and+KAWK4YYKx80NHTeOVgPTho4g5mD8n0ZRpv2gfPzNBF4OwfjlfLfUyWhonYcmZDTrLZaXoLDlsl8mQpRkuN6JGzlWGAAItX1aDxjWgqXnZgaW5Hbpw2F2kq4KFYE2hv0HdAGeaT2haGO1QxGmbm0TMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QT/hC4UH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QT/hC4UH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB6B1F0089C;
	Sun, 11 Oct 2026 06:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791698767;
	bh=dD8XlzYdCcb3VRqwDRWYJMmiLCPXkS8vljvQpLXS3GA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QT/hC4UHTQ0N0MlDWZSoFWyop4Sn3JlaFga/lUjf4AkYlDby834ncWXTga21G4e/1
	 ztA1D0WMCHfktQ9DAOtjmS+TctxsfNgmfx+1UJkaQCCHFJbjmUzqJjbBQ0iOh/Gpz4
	 0s3n6ekzpZCQFdKL20hEYffbuYoiIQY8xiMpF42yLLewIHHgXbsIUPXhc34fHz8kWa
	 pT53uoqqQSK4qnf9zzhgC/dyd3dTE3AJUVvRHC9ZudlWCxsK/iOw4PGmKnl8CKUwFc
	 tI/+yFSJQFGfU5NhPFC9c0hpYRuKZQRSPlY9h7ELyDq/klQMbrq//bZS8W4Kzvyz+T
	 91WToWXxZSMrg==
Subject: Re: [PATCH net v2 2/2] net: phy: xilinx-gmii2rgmii: Restore PHY
 driver on remove
From: netdev-bot+sashiko@kernel.org
To: vineeth.karumanchi@amd.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, harini.katakam@xilinx.com, f.fainelli@gmail.com,
 appanad@xilinx.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com
Date: Sun, 11 Oct 2026 06:06:06 +0000
Message-ID: <179169876622.434549.16193722149328213300@kernel.org>
In-Reply-To: <20261007054844.529363-3-vineeth.karumanchi@amd.com>
References: <20261007054844.529363-3-vineeth.karumanchi@amd.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix only serializes against code that holds phydev->lock, so
  the use-after-free it targets is still reachable.
- [High] phy: data race modifying phydev->drv without lock in probe
- [High] net: phy: missing phydev->lock in xgmiitorgmii_probe allows data
  race
- [Medium] The check-then-restore in xgmiitorgmii_remove() runs under
  phydev->lock, but phy_remove()…

Pre-existing issues:
- [Medium] xgmiitorgmii_probe() memcpy()s the PHY driver into
  priv->conv_phy_drv and then publishes `priv->phy_dev->drv =…

--

net: phy: xilinx-gmii2rgmii: Restore PHY driver on remove

This adds a remove callback to the GMII-to-RGMII converter driver. The
callback restores the attached PHY's original phydev->drv under
phydev->lock, but only if the converter's embedded copy is still
installed. It also drops the device reference that of_phy_find_device()
took in probe.

> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index 61f71e977a574..9dcdb91cd441f 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -128,10 +128,27 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
>  	priv->conv_phy_drv.read_status = xgmiitorgmii_read_status;
>  	priv->conv_phy_drv.set_loopback = xgmiitorgmii_set_loopback;
>  	priv->phy_dev->drv = &priv->conv_phy_drv;

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
xgmiitorgmii_probe() memcpy()s the PHY driver into priv->conv_phy_drv.
It then publishes the pointer with a plain store. It doesn't hold
phydev->lock and has no release barrier (smp_store_release() or
rcu_assign_pointer()). The new restore in xgmiitorgmii_remove() does
take the lock.

Probe only requires phydev->drv to be non-NULL, so the PHY may already
be attached with its state machine running.

On a weakly ordered CPU such as arm64 Zynq MPSoC, could a reader see the
new phydev->drv before the copied contents of conv_phy_drv? Could it
then call through an uninitialized function pointer?

Nobody has shown this ordering problem in practice, and the patch
doesn't change this sequence.

> +	mdiodev_set_drvdata(mdiodev, priv);
>  
>  	return 0;
>  }
>  
> +static void xgmiitorgmii_remove(struct mdio_device *mdiodev)
> +{
> +	struct gmii2rgmii *priv = mdiodev_get_drvdata(mdiodev);
> +
> +	/*
> +	 * Restore the original driver only if the converter's copy is still
> +	 * installed. Serialize against PHY callbacks that hold phydev->lock.
> +	 */
> +	mutex_lock(&priv->phy_dev->lock);
> +	if (priv->phy_dev->drv == &priv->conv_phy_drv)
> +		priv->phy_dev->drv = priv->phy_drv;

[Severity: High]
Separately from mutual exclusion, the unlocked store in
xgmiitorgmii_probe() leaves nothing ordering the construction of the
copy against its publication. Probe memcpy()s the PHY driver into
priv->conv_phy_drv, overrides read_status and set_loopback, and then
assigns &priv->conv_phy_drv to phydev->drv with a plain store. There
is no smp_store_release(), and no mutex_unlock() that would give the
store release semantics.

priv comes from devm_kzalloc(), so conv_phy_drv starts out zeroed. On
a weakly ordered CPU, such as the arm64 Zynq MPSoC parts this IP is
used with, a reader holding phydev->lock on another CPU, for example
phy_read_status() from phy_check_link_status(), could observe the new
phydev->drv before all of the copied fields are visible. It would then
see zeroed or partially copied callbacks and flags for that call,
silently falling back to genphy behaviour, skipping the PHY driver's
hooks, or bypassing xgmiitorgmii_read_status() altogether.

With this patch the realistic trigger is rebinding the converter while
the PHY is attached and running, since remove now makes that sequence
work. Taking phydev->lock across the read of phydev->drv, the memcpy()
and the store in probe would give lock-holding readers the ordering
they need, mirroring what remove does. Readers that load phydev->drv
without the lock would still need something stronger. Is there a
reason probe was left unlocked in v2?

[Severity: High]
The new xgmiitorgmii_remove() takes phydev->lock so that restoring
phydev->drv is serialized against PHY callbacks that hold that mutex.
xgmiitorgmii_probe() writes the same field in the other direction,
replacing priv->phy_dev->drv with &priv->conv_phy_drv, but it does so
without taking the lock.

Before this patch, unbinding the converter left phydev->drv dangling,
so a later rebind wasn't something that could work anyway. Now that
remove puts the original driver back, unbind followed by bind through
sysfs becomes a sequence people will actually use. There is no device
link tying the converter's probe to the PHY's attach state, so on
rebind the PHY can already be attached to an interface that is up,
with phy_state_machine() running on another CPU.

In that case probe changes phydev->drv while phy_check_link_status()
holds phydev->lock and is inside phy_read_status(), which loads
phydev->drv more than once. A single locked call can then test the
callback on one driver and invoke it through another, which is the
kind of mid-call switch the locking in remove exists to prevent.

Should xgmiitorgmii_probe() hold phydev->lock around reading
phydev->drv, the memcpy() into conv_phy_drv and the store, so that both
directions follow the rule described in the new comment in remove?

[Severity: Medium]
Can this check-then-restore race with phy_remove() on the external PHY?
phy_remove() writes phydev->drv without taking phydev->lock:

drivers/net/phy/phy_device.c:phy_remove() {
    ...
	if (phydev->drv && phydev->drv->remove)
		phydev->drv->remove(phydev);
    ...
	phydev->drv = NULL;
    ...
}

The converter and the external PHY are separate mdio_devices.
mdio_bus_type does not set need_parent_lock, so the driver core holds
only each device's own device_lock. Sysfs unbinds of the two devices can
therefore run at the same time.

Consider this interleaving:

converter                             PHY
xgmiitorgmii_remove()
  drv == &priv->conv_phy_drv (true)
                                      phy_remove()
                                        phydev->drv = NULL;
  phydev->drv = priv->phy_drv;

The PHY is now unbound, but phydev->drv still points at its old driver.
That pointer dangles once the driver's module is unloaded, and later
if (!phydev->drv) checks in phylib would follow it.

The reverse order has a problem too. phy_remove() can be calling through
the converter copy via phydev->drv->remove while xgmiitorgmii_remove()
restores the pointer and returns, and devres then frees priv. Is that
also a use-after-free?

> +	mutex_unlock(&priv->phy_dev->lock);
> +
> +	put_device(&priv->phy_dev->mdio.dev);
> +}

[Severity: High]
Does this fully close the use-after-free described in the commit
message? The restore only serializes against code that holds
phydev->lock.

After xgmiitorgmii_remove() returns,
device_unbind_cleanup()->devres_release_all() frees priv, and the
embedded conv_phy_drv goes with it. Nothing waits for phylib code that
loaded phydev->drv without the lock, and there is no RCU or refcount
protecting it.

One example is ip link set dev X down, which goes through phy_stop():

drivers/net/phy/phy.c:phy_stop() {
    ...
	state_work = _phy_state_machine(phydev);
	mutex_unlock(&phydev->lock);

	_phy_state_machine_post_work(phydev, state_work);
    ...
}

For PHY_HALTED this returns PHY_STATE_WORK_SUSPEND, so phy_suspend()
runs after the lock has been dropped:

drivers/net/phy/phy_device.c:phy_suspend() {
	const struct phy_driver *phydrv = phydev->drv;
    ...
	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
		return -EBUSY;
    ...
	ret = phydrv->suspend(phydev);
    ...
}

Suppose the converter is unbound after phy_suspend() loads phydev->drv
but before it uses phydrv. Wouldn't phy_suspend() then read freed slab
memory and make an indirect call through it? phy_detach()->phy_suspend()
has the same window.

Other functions that read phydev->drv without the lock look similar:

  - phy_ethtool_get_sset_count() checks get_sset_count, get_strings and
    get_stats through phydev->drv before taking phydev->lock
  - phy_ethtool_get_wol() reads drv->get_wol before taking the mutex
  - phy_init_hw() dereferences drv->soft_reset, config_init and
    config_intr without the lock. It is reachable from
    phy_attach_direct(), from resume, and from the SIOCSMIIREG
    BMCR_RESET path in phy_mii_ioctl()
  - phy_remove() reads drv->remove without the lock

RTNL doesn't help here either, because unbinding the converter never
takes it.

With this patch, the long-lived dangling pointer becomes a narrow race
window, but it is still there. Would a full fix need to keep the copy
alive for as long as phylib can use it? Or would every phydev->drv
reader need to synchronize with the converter's removal?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007054844.529363-1-vineeth.karumanchi%40amd.com
