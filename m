Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE434D957F;
	Thu, 17 Sep 2026 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645404; cv=none; b=XtmXCwrVmUGy/ldCadUZTSRETwgkUuz+qtepSh+itoesx04yqIApn0jfIMowd9AE92vGQi3g+69GQphOIRrMBi1bfQhb6p1ywTX2FaKf2Yf2WSn6zsvFxhul1n3R5U19tDybjNR2amdziPpJzADEJPL5YB+D+k0pdIN3qKE2Koc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645404; c=relaxed/simple;
	bh=/RRMaZvdYXyjxKi28+jDlAuOmVYD4lujZJGTistu1V4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U1astRSNqqD1HCYHIbFoxsISccUoCUSVYKykuDIvZvohKlP7B9mwbXVKDWobMqTg94nAcFXs+kN/RjyVqyHQiI97lo1HAh2aBfic1Tw2Fna/HJtK1blKtQfleuoS2QKnMqjnqUjwFM4oAaZej8KS3NwK2fXAvhD1bHYSAx5Zdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpy6M+kW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpy6M+kW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7FC1F00893;
	Thu, 17 Sep 2026 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789645395;
	bh=oND2i0wmdeDmPpu5wQ4bCyCIBtaTeFPGekdA2ZtJIkI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cpy6M+kWPx7Ph0TALecXe1q/gnEj4PeACYpuh/e0L+I+6n9H2qjunF6sMccIpseCd
	 0MODjSJR77Rcvybh1rIDL2qn+E/YFYVfEV1DjRENV031/WgGK8CNNOhf77npEbAikP
	 WR5hGHmJRe6YvDcACZvdYxDYPri01Yz1cCSw6e1lKo3cvx2+1a30X/X82sfsW5awTT
	 A1rixweyl2MkF/571q8+pW9mDHosTTjAqQk9LS6ncUzYLYYRPOF2JJ5AE0IrFcjyCf
	 ccZsht2lZWOCq5Hnhra+8iQVm3BNR5t6518EEKqMyNYucZSCqXsZxJV5zjB8aETu9m
	 fRzKUKZC6ElbQ==
Subject:
 Re: [PATCH net] net: phy: reject attach while the PHY driver is in transition
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 11:43:14 +0000
Message-ID: <178964539462.22033.78864518608969481@kernel.org>
In-Reply-To: <20260914204200.2743251-1-f@lex.la>
References: <20260914204200.2743251-1-f@lex.la>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] Incomplete fix / residual TOCTOU: the new `else if
  (!phydev->drv)` test in phy_attach_direct()…
- [Medium] Module reference imbalance survives the residual unbind window
  that this patch claims to close.

--

net: phy: reject attach while the PHY driver is in transition

The patch adds an early -EBUSY return in phy_attach_direct() when
d->driver is still set but phydev->drv has already been cleared, which is
the window between phy_remove() and device_unbind_cleanup(). The intent is
to avoid dereferencing a NULL phydev->drv in phy_drv_supports_irq() and to
avoid leaking the PHY driver module reference.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a37..044cefd9840bb 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1781,6 +1781,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  			d->driver = &genphy_driver.mdiodrv.driver;
>  
>  		phydev->is_genphy_driven = 1;
> +	} else if (!phydev->drv) {
> +		/* d->driver outlives phydev->drv on unbind, precedes it on bind */
> +		err = -EBUSY;
> +		goto error_put_device;
>  	}

[Severity: High]
Is this check able to prevent the oops quoted in the changelog, given that
it samples phydev->drv once and the dereference happens much later in the
same function?

The commit message says the function holds no lock over phydev->drv, and
get_device(d) only pins the device object, so the unbind can land right
after the test:

CPU0 phy_attach_direct()
	} else if (!phydev->drv) {	/* passes, drv still set */

CPU1 phy_remove()
	phydev->drv = NULL;

CPU0 continues in phy_attach_direct()
	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))

and phy_drv_supports_irq() has no NULL test:

static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
{
	return phydrv->config_intr && phydrv->handle_interrupt;
}

That is the same faulting access described in the notes (offset 0x128 being
phy_driver::config_intr), and it is the dereference named by the Fixes: tag.
The changelog does acknowledge "an unbind starting mid-attach still races",
but with a Fixes: tag attached, would a stable backporter reasonably
conclude the crash signature is gone when it is still reachable?

Should the single unguarded use be made NULL-tolerant instead, the way
phy_init_hw() already is, rather than adding a sampled check far away from
it?

There is a second dereference in the same window. If
device_unbind_cleanup() also runs, dev->driver becomes NULL:

drivers/base/dd.c:device_unbind_cleanup() {
	...
	device_set_driver(dev, NULL);
	...
}

and the statement immediately after the new check re-reads it:

	if (!try_module_get(d->driver->owner)) {

Can that path fault too, since the new test looks at phydev->drv but this
line dereferences d->driver?

Finally, phylink_bringup_phy() dereferences phy->drv right after a
successful attach. If the unbind stores land just as phy_attach_direct()
returns 0, does that caller hit a NULL phy->drv as well?

[Severity: Medium]
The changelog gives the module reference leak as a reason to fail here:

  "a continued attach would already hold the driver module reference that
  phy_detach() drops only while d->driver is set, leaking it once the
  unbind completes"

Does that leak remain reachable in the window the patch leaves open?
phy_attach_direct() charges the reference keyed on the mutable field, right
after the new check:

	if (!try_module_get(d->driver->owner)) {

and phy_detach() re-reads the same field at release time instead of the
module that was charged:

	if (phydev->mdio.dev.driver)
		module_put(phydev->mdio.dev.driver->owner);

So for the sequence [new check passes] -> [try_module_get(A->owner)] ->
[phy_remove() clears phydev->drv, device_unbind_cleanup() clears
dev->driver] -> [attach fails later, for example on the phydev->attached_dev
"PHY already attached" path, phy_link_topo_add_phy() or phy_init_hw(), or
the netdev is brought down afterwards], phy_detach() sees a NULL
d->driver and skips the module_put(). Does module A then stay pinned
forever?

There is also a mismatched-module variant: if the mdio device is bound to a
different PHY driver B via sysfs before phy_detach() runs, phy_detach()
would call module_put(B->owner) for a reference it never took. Can that
underflow B's refcount and allow unloading a module still in use?

Would recording the module pinned at attach time, rather than sampling
d->driver twice, close both cases?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914204200.2743251-1-f%40lex.la
