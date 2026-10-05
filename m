Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4354825C8;
	Mon,  5 Oct 2026 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205312; cv=none; b=FfEom/iJve5m177OhnHLcyHUG5eLeCGE2UXyZ8Z2hGCEwxckKVzcf06KYHfQ1Ypi8qYuyoJPJKXiHL4n0MXK5WhrwJ2yP+UFG9t/d0F3nQLb+wI5p+6gcJgcPpRAkSwkNvBtTNktfQL4Fa8ZA66RphGfEgioKj+8UZjX5WHRHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205312; c=relaxed/simple;
	bh=13MCE6JnxDzhoCK6e0iDgRdYxGKNBVHlkNGg4iORfzk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TwJ4287jvacl/u8pXan/7F5e2RJOmtlEF8oZLaccipOQQuzhP8SS3vMpkcwIAn+TmYRwBX5qDKEOXG0YZCRcpOX6wHfKwPVFC0t287JsOsnb39rqU15biyzoalm2gjL5rlvPickJsy3pDOpB8lpoZAXtVRZuYiwycfiRJDcgqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6ALkgxG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6ALkgxG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5E91F00893;
	Mon,  5 Oct 2026 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791205300;
	bh=v1V07LY81AWzd9NcvQkV9+8dNiZ+NJR+HQ82xCJywYA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n6ALkgxGAHsr0FOcTCPODmSwdSqoYnKoBlvSUgfdtD/RNaJUwIdA+u9VR916KYFbx
	 qSRKPrgqvJ9BZJV0oTh+0dA9kNL7SnczK+7jkk550xBPOXsxKsa043ENUzqy/afEMO
	 jLh7bzI2WOwhxBSzt1J6usr46pB5VAP4XGzWKaGEV9HPGav5VNKHwFVf+oP0m42zUn
	 GYKUIXlraMj+24PUN5sjeCTilxSwVRAmWtX9VNtgXrMj9yaFMfiGZvw1q9w8JlITr5
	 5Mo9nJbJdYDkbLkkKr5WwZj/o82Lz8/gWZ7f3fLUxgOqFfsY+Nd0Kj0sjXCUWcG0sJ
	 3PzMxMV/OXHeA==
Subject: Re: [PATCH net-next v4 4/4] net: phy: make an unbind wait for the
 attached consumer to detach
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, woojung.huh@microchip.com, vladimir.oltean@nxp.com,
 maxime.chevallier@bootlin.com
Date: Mon, 05 Oct 2026 13:01:39 +0000
Message-ID: <179120529945.434549.1233446733190047739@kernel.org>
In-Reply-To: <20261001130120.104628-5-f@lex.la>
References: <20261001130120.104628-5-f@lex.la>
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

Critical: 0 · High: 2 · Medium: 0 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] phy_remove() in drivers/net/phy/phy_device.c (lines 3866-3871)
  now calls wait_var_event(&phydev->attached,…
- [High] net: phy: ABBA deadlock between rtnl_lock and device_lock
- [Low] phy_remove() reads phydev->attached with a plain load under
  bind_lock (line 3860: 'attached = phydev->attached &&…

Pre-existing issues:
- [Low] When an unbind is waiting in phy_remove(), it has already set
  phydev->bound = false (line 3859).

--

net: phy: make an unbind wait for the attached consumer to detach

This commit makes phy_remove() wait in wait_var_event() until
phy_detach() has run whenever the PHY is attached. The goal is to stop
the driver being removed from a PHY that a consumer is still using.
phy_device_remove() sets a new removing flag and wakes any waiter, so
mdiobus_unregister() does not hang.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 544b2da6a1d94..8a7cd53f9a144 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -3843,11 +3853,23 @@ static int phy_probe(struct device *dev)
>  static int phy_remove(struct device *dev)
>  {
>  	struct phy_device *phydev = to_phy_device(dev);
> +	bool attached;
>  
>  	mutex_lock(&phydev->bind_lock);
>  	phydev->bound = false;

[Severity: Low]
This isn't a bug introduced by this patch, but with the wait added
below, bound is cleared before the consumer detaches. As a result, the
detach that ends the wait skips the power-down in phy_detach_internal():

	mutex_lock(&phydev->bind_lock);
	if (phydev->bound)
		phy_suspend(phydev);
	mutex_unlock(&phydev->bind_lock);

At that point the driver is still present.

After the wait, phy_remove() only calls drv->remove() and
phy_device_reset(phydev, 1). mdio_device_reset() returns early when
there is no reset_gpio or reset_ctrl. A PHY that was attached but never
started, such as a DSA port that was never brought up, would keep the
power-up from phy_resume() in phy_attach_direct().

Before this series the unbind cleared phydev->drv first, and
phy_suspend() returned early on the NULL driver. So the PHY was not
powered down then either.

Could the detach still suspend the PHY in this state, since the driver
is now valid until the detach finishes?

> +	attached = phydev->attached && !phydev->removing;

[Severity: Low]
Can this plain read of phydev->attached race with the store in
phy_detach_internal()?

	store_release_wake_up(&phydev->attached, false);

That store runs after phy_detach_internal() has dropped bind_lock.
Holding bind_lock here does not serialise against it, so KCSAN would
probably report a plain read racing with a marked write.

phy_attach_direct() also writes attached = true with a plain store,
while the wait condition reads it with READ_ONCE().

A stale value does no harm at runtime, because wait_var_event()
re-checks the condition. Should the snapshot use READ_ONCE(), or should
the clear happen under bind_lock, so that the annotations match?

>  	mutex_unlock(&phydev->bind_lock);
>  
> +	/* The driver core cannot refuse an unbind, and the consumer keeps
> +	 * using phydev->drv until it detaches.
> +	 */
> +	if (attached) {
> +		phydev_warn(phydev, "unbind waits for the PHY to be detached\n");
> +		wait_var_event(&phydev->attached,
> +			       !READ_ONCE(phydev->attached) ||
> +			       READ_ONCE(phydev->removing));

[Severity: High]
Can this wake cause an ABBA deadlock between rtnl_lock() and the
PHY's device lock when the PHY is driven by genphy and has an SFP bus?

The unbinding task sleeps in phy_remove() with device_lock() of the
PHY held. The consumer usually detaches under rtnl_lock(), for example
ifdown through phy_disconnect(). This store wakes the unbinder, but
phy_detach_internal() then carries on to the genphy branch just below
and takes the same device lock:

CPU0 (sysfs unbind)              CPU1 (ifdown, rtnl_lock held)
device_lock(phydev)
phy_remove()
  wait_var_event()
                                 phy_detach_internal()
                                   store_release_wake_up()
  (woken)                          device_release_driver()
                                     device_lock(phydev)
  phy_sfp_release()
    sfp_bus_del_upstream()
      rtnl_lock()

CPU1 holds rtnl_lock() and waits for the device lock. CPU0 holds the
device lock and waits for rtnl_lock(). After that every rtnl user on
the system hangs as well. Unbinding needs root, but the result is a
wedged network stack rather than just a stuck sysfs write.

Before this patch phy_remove() never slept. The
device_release_driver() here only had to wait for a short remove, so
no rtnl dependency could form behind it.

Moving the store after device_release_driver() would not help either.
The detach would then block on a device lock held by a task that is
waiting for that very store. How should the genphy-driven case be
handled so that the device lock and rtnl_lock() cannot nest in
opposite orders here?

[Severity: High]
Could this leave the unbinding task in D state for an unbounded time,
with device_lock(phydev) held the whole time?

wait_var_event() sleeps in TASK_UNINTERRUPTIBLE and has no timeout.
phy_remove() is called with the device lock held:

unbind_store()
  device_driver_detach()
    device_release_driver_internal()    <- device_lock(phydev)
      __device_release_driver()
        device_remove()
          phy_remove()
            wait_var_event()

Only phy_detach_internal() and phy_device_remove() can end the wait,
and the unbinding task can trigger neither.

Some consumers connect at probe, such as DSA user ports or MACs that
call phy_connect() in probe. They detach only when their own driver is
torn down. dsa_switch_shutdown() does not disconnect the user port
PHYs.

While the wait lasts, device_shutdown() in drivers/base/core.c still
takes the lock of every device:

	if (parent)
		device_lock(parent);
	device_lock(dev);

The PHY is registered after its MAC or switch, so the backwards walk of
devices_kset reaches the PHY first. Would reboot, poweroff and kexec
then block forever on the PHY's device lock?

Suspend looks affected as well. The freezer cannot freeze the D-state
task, and device_prepare(), device_suspend() and device_resume() in
drivers/base/power/main.c also take device_lock(dev).

There may also be a deadlock through device links, although this case
is more speculative. device_links_unbind_consumers() unbinds consumers
one at a time:

	device_release_driver_internal(consumer, NULL,
				       consumer->parent);
	put_device(consumer);
	goto start;

Suppose the PHY and its MAC or switch are both managed consumers of the
same supplier, such as a GPIO or IRQ provider, and the loop reaches the
PHY first. phy_remove() would then wait for a detach that only happens
when the same loop later unbinds the MAC or switch.

__mdiobus_register() sets FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD on
bus->parent. That only suppresses links to bus->parent, not links to
other suppliers.

Before this patch the same unbind returned at once. The commit message
says:

    An unbind of a PHY in use
    now blocks until the consumer lets go

It does not say that the wait is uninterruptible, that device_lock
stays held during it, or that reboot and suspend are affected. Is this
the intended behaviour for these paths?

> +	}
> +
>  	cancel_delayed_work_sync(&phydev->state_queue);
>  
>  	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev))

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001130120.104628-1-f%40lex.la
