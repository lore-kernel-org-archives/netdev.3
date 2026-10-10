Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D986030DD22;
	Sat, 10 Oct 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791659253; cv=none; b=LnaYbWJGyyCaizNY9n9xS3FnEJikxrRGwSfUKbBisRGvt9OS8vKXZtwNZ63OwNBMEH0BE9EIGjeYUg+dmTCdYY9RhVKGuIL+nu6atZ+w6J2T7ZHtR4KJHweEjZNlIzl/cb39Ci0afy6o75x+u71Mh02Bj06SNyKpOIK/WWDlTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791659253; c=relaxed/simple;
	bh=MkfaOB+HNsQ6PRGnLpf3rwGakN3w42IIMHKMeQojOh8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lm27wSS/EZwhKIyZIfjsMf6ymGHqoDcBEyTFrQUQ9KKMOL4BAgqVQmCKwqP2pM/NzZ7uj4cr2Px36YtVwB59etI4aXEqM6nZuQ3GlJX7T/48/+rEeJmuTOuttyQapmn/EONio6W/+tcfK70XPrxdtpTzId+QB5NHTqN34QDnvSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuqSgrP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuqSgrP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844EC1F000FF;
	Sat, 10 Oct 2026 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791659251;
	bh=oLV5y1NWd/GkDDfQ5x0zNqxU7r1TMAdmIJbGfZBHcPw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PuqSgrP2U/nbn9VxjkhIRDl2eOe80yccb1pnxPjV5MVGpvuwSAy3Hn82ukeR5zsTC
	 eceX6EBFGjwiydAIWbMkjr7M0f37X5ySek0FtgANlVSIdeRwV208WG2mFWS0pHcAIy
	 rBoZz/ZDDW/PU089BdR52R2iO3q1a1xnPjJX5ncj2O34IWrhfULkcgHRMCXxSrSbtB
	 Jhy+E9E3zUych+2HYaVjnKzVMBVKIOkgNQIT/bMDW83l76FjbF89Pve0TnyyKDdl7J
	 vnlhPrMD85rG9Apv51l/EtSh93fnmHvnjlILMS34KaT9SMzJ7dUvffsSQI84m7dpTl
	 7JPeJ28LRvfAA==
Subject:
 Re: [PATCH net-next v5 2/4] net: phy: put the driver module the attach took
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, woojung.huh@microchip.com, vladimir.oltean@nxp.com,
 maxime.chevallier@bootlin.com
Date: Sat, 10 Oct 2026 19:07:29 +0000
Message-ID: <179165924997.434549.9959775460791598020@kernel.org>
In-Reply-To: <20261009180551.1234107-3-f@lex.la>
References: <20261009180551.1234107-3-f@lex.la>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, `phydev->drv_owner` is read and written with
  no lock.
- [Low] The commit body does not say what this patch depends on.

Pre-existing issues:
- [Medium] In `phy_attach_direct()` (drivers/net/phy/phy_device.c),
  `d->driver` is tested at line 1825 (`if (!d->driver)`) and…

--

net: phy: put the driver module the attach took

This commit stores the PHY driver module pinned by phy_attach_direct() in
a new field, phydev->drv_owner. phy_detach_internal() and the attach error
path now release that stored module instead of reading d->driver again.
The goal is to stop skipping the put, or putting the wrong module, when
the PHY driver is unbound while the PHY is attached.

> Fixes: cafe8df8b9bc ("net: phy: Fix lack of reference count on PHY driver")

[Severity: Low]
Should the commit message say which other patches this one depends on?
Because of the Fixes: tag, stable tooling could pick up this patch by
itself. Its correctness seems to depend on two other patches in the
series:

  "net: phy: refuse a second attach before touching the PHY", which needs
  to be applied first.

  "net: phy: serialise attach and detach with PHY driver bind and
  unbind", which closes a leak this patch leaves open (see below).

The only place this is mentioned is the v5 changelog below the --- line:

  "On its own, this patch can still leak a reference when one consumer
  attaches while another detaches the same PHY. Patch 3 closes that."

That text is dropped when the patch is applied.

Without the first patch, the baseline phy_attach_direct() still reaches
the drv_owner store on a PHY that is already attached. Its
if (phydev->attached_dev) test only runs after try_module_get():

phy_attach_direct()      /* second attach, same PHY */
    try_module_get(A);
    phydev->drv_owner = A;
    if (phydev->attached_dev) goto error;
    phy_detach_internal()
        module_put(phydev->drv_owner);    /* puts A */
        phydev->drv_owner = NULL;

When the first consumer later calls phy_detach(), it does
module_put(NULL), so A is left with an extra reference that is never
dropped. The baseline also allows a second attach without a netdev
(DSA-style), and that overwrites the slot in the same way.

This patch's hunks don't overlap the first patch's hunks, so it applies
cleanly without it. Could the body name the companion commits, or could
the series be reordered or squashed?

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 6bc9cdb7fa699..68691c487eee5 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1728,8 +1728,8 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
>  	phydev->phy_link_change = NULL;
>  	phydev->phylink = NULL;
>  
> -	if (phydev->mdio.dev.driver)
> -		module_put(phydev->mdio.dev.driver->owner);
> +	module_put(phydev->drv_owner);
> +	phydev->drv_owner = NULL;

[Severity: Medium]
Can a concurrent attach lose its module reference here, or have it put on
the wrong module? At this commit, phydev->drv_owner is read and written
without any lock.

Setting phydev->phy_link_change = NULL opens the unlocked "already
attached" test in phy_attach_direct() before this module_put() runs:

phy_attach_direct() {
    ...
	if (phydev->phy_link_change) {
		phydev_err(phydev, "PHY already attached\n");
    ...
	phydev->drv_owner = drv_owner;
    ...
}

So a second consumer that attaches in that window can store its owner in
the slot this detach is about to read and clear:

CPU1 (detach #1)                    CPU2 (attach #2)
phy_detach_internal()
  phydev->phy_link_change = NULL;
                                    phy_attach_direct()
                                      phy_link_change test passes
                                      try_module_get(X);
                                      phydev->drv_owner = X;
  module_put(phydev->drv_owner);
  phydev->drv_owner = NULL;

If X is the same driver A, detach #1 puts A and then its NULL store wipes
out attach #2's record. Attach #2's later detach puts NULL, so A leaks a
reference.

Now suppose A was unbound and driver B bound while the PHY was attached.
Detach #1 then puts B, which it never pinned, and A leaks. Attach #2 is
using B but holds no reference on it. Could B be unloaded while attach #2
is still using it?

If attach #2 then fails through goto error, phy_detach_internal() may
read drv_owner == B again and put B a second time. The error_module_put
path also reads phydev->drv_owner instead of the local drv_owner.

This looks like the "put lands on a module that was never pinned" case
the commit message describes, and the v5 changelog mentions the gap.

Later in the series, "net: phy: serialise attach and detach with PHY
driver bind and unbind" appears to close it:

  phy_attach_direct() holds bind_lock from before the phy_link_change
  test until after the drv_owner store.

  phy_detach_internal() clears phy_link_change, saves and clears
  drv_owner, and clears attached in a single bind_lock section, then
  calls module_put() on the saved value.

[ ... ]

> @@ -1830,11 +1831,13 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  		phydev->is_genphy_driven = 1;
>  	}
>  
> -	if (!try_module_get(d->driver->owner)) {
> +	drv_owner = d->driver->owner;

[Severity: Medium]
This isn't a bug introduced by this patch, but can d->driver change
between the earlier if (!d->driver) test in phy_attach_direct() and this
dereference?

phy_attach_direct() doesn't hold device_lock(d), and at this commit
nothing else blocks a driver core unbind. A sysfs unbind, or
driver_unregister() at module exit, can run at the same time:

__device_release_driver()
    phy_remove()
    dev->driver = NULL;

Could that cause a NULL dereference of ->owner here? Could it instead
read ->owner from the driver struct of a module that is being freed?

The old try_module_get(d->driver->owner) had the same check-then-
dereference pattern, so the race predates this patch.

"net: phy: serialise attach and detach with PHY driver bind and unbind",
later in the series, appears to close it. It holds phydev->bind_lock from
before the d->driver test through try_module_get(), and returns -EAGAIN
when d->driver is set but phydev->bound is not.

> +	if (!try_module_get(drv_owner)) {
>  		phydev_err(phydev, "failed to get the device driver module\n");
>  		err = -EIO;
>  		goto error_put_device;
>  	}
> +	phydev->drv_owner = drv_owner;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009180551.1234107-1-f%40lex.la
