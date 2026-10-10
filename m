Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC44B44BF;
	Sat, 10 Oct 2026 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791659256; cv=none; b=k/L4JTrq013SIxfVZ6BafqD6GlwmILVeMANJuemTsnoOF5sf8eLQJhKIabt/a1s7ZFbGggTEWOcFpIjMjLgUV2kUyNLG89e4ZQvzZ4eUpdIz50rorpNepTr+/aR9xvvGr0Ra/31h0r+3uDXG6dQqCrtn65Vhb77TuSu+LAExdgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791659256; c=relaxed/simple;
	bh=RX3HUGnJvfbNuOfh2YfO4unieZqsx+UEPgo3+7Gc+nw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pelE59j9mH1L4glJJ7AvIfp0RbE9KO3j/AusvfcLd3xodpYWym6t6cPXIfRE1sWHAqCMqOLQoywBJfH1PqVUmCWel8C/GP1TcPyMdMei3CJGSdcTK5O5CbzZPADaU0MvAKrL1oCqPDR9cg0IA7X/liw2ip7N9HNMWrm+H+YyyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq2V+YXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq2V+YXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9157E1F000FF;
	Sat, 10 Oct 2026 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791659254;
	bh=8GdtLgttCyKb4tZx9St8N2yZyVc+yX3u7FwIGjnKRQg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kq2V+YXd+S1I3XJFDTfGJcUm1jKBU17Y35kf7n/MC4vAHHy09F79XeiLXSYmeXMIP
	 vi9EkPMdrnNl9aQETMtPJ+fr8/aCC7he/WPwJWOilLUgyTh5yM4j3Vx+Mhc+InBHdA
	 G0x6hwmRF1hpPiy9dXWvtJBTw3KOLsa2QWg9Vm6P3PVmRXRS+Hy0l2/sIEIJvohH7W
	 3MB7k2PRVNreSZRPAHrJBk+Y+TjJT1VyJXlLQCZm1Fe7Kylb5DDgxCvdJGI3a8kCzY
	 Pq111Jeuze8Ov+DVHRwDGZJ/8UCtIYo5NxPdgyv35wRgDvrzb56tcIeQ0yTh1sVBSA
	 nQ6NTlH51xE/w==
Subject: Re: [PATCH net-next v5 4/4] net: phy: make an unbind wait for the
 attached consumer to detach
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, woojung.huh@microchip.com, vladimir.oltean@nxp.com,
 maxime.chevallier@bootlin.com
Date: Sat, 10 Oct 2026 19:07:33 +0000
Message-ID: <179165925312.434549.3215733785480960392@kernel.org>
In-Reply-To: <20261009180551.1234107-5-f@lex.la>
References: <20261009180551.1234107-5-f@lex.la>
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

Critical: 0 · High: 3 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] phy_remove() can wait forever on its own thread.
- [High] net: phy: driver state corruption due to attach/detach race
- [High] net: phy: deadlock in phy_detach_internal() waiting for unbind
- [Medium] The new wait_var_event() in phy_remove()
  (drivers/net/phy/phy_device.c, lines 3887-3892) has no upper bound and…

--

net: phy: make an unbind wait for the attached consumer to detach

With this patch, phy_remove() waits for phy_detach() to run before it
takes the driver away from a PHY that is still attached. Without the
wait, phylink and phylib keep using phydev->drv after the unbind. Removing
the device through phy_device_remove() sets a new removing flag, which
skips the wait and wakes any unbind that is already waiting.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 0ffaa456a308b..a271fe76c3f8e 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -3858,11 +3874,23 @@ static int phy_probe(struct device *dev)
>  static int phy_remove(struct device *dev)
>  {
>  	struct phy_device *phydev = to_phy_device(dev);
> +	bool attached;
>  
>  	mutex_lock(&phydev->bind_lock);
>  	phydev->bound = false;
> +	attached = READ_ONCE(phydev->attached) && !phydev->removing;
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
> +	}

[Severity: High]
Can the detach of a genphy-driven PHY end up waiting for a different
consumer? The commit message expects an attach to come right after
this section. For a PHY on the generic driver, though, the detach is
not finished at that point.

attached is cleared and bind_lock is dropped before
device_release_driver() runs. phy_remove() only samples attached when
it takes bind_lock again from inside the driver core. As far as I can
tell, __device_release_driver() calls driver_sysfs_remove() before
device_remove(), and dev->driver is cleared only afterwards, in
device_unbind_cleanup().

A phy_attach_direct() that lands in that window sees:

- phy_link_change == NULL
- d->driver still set
- phydev->bound still true
- is_genphy_driven still 1

It runs __phy_probe() again. device_bind_driver() now succeeds because
the driver sysfs links are already gone; driver_bound() only warns that
the device is already bound. The attach then completes and sets
attached to true.

The detaching thread then gets to phy_remove() and sees attached set
and removing clear. It sleeps in wait_var_event() with the PHY's device
lock held until the new consumer detaches.

The old consumer usually gets here through phylink_disconnect_phy() or
phy_disconnect() from ndo_stop with RTNL held. The ifdown then hangs
in D state behind an unrelated consumer. Suppose that consumer attached
without RTNL, for example from a probe path, but needs RTNL for its
own detach. Then the wait can never end.

Even when the wait does end, the new attach has re-run __phy_probe()
and device_bind_driver() on a device that was halfway through its
unbind.

Could phy_link_change stay set until device_release_driver() has
returned, with only attached cleared before it? An attach in this
window would then be refused with -EBUSY instead.

[Severity: High]
Does the genphy release at the end of phy_detach_internal() still race
with a new attach? The irq restore now comes ahead of the bind_lock
section so that a new attach cannot see it. However, is_genphy_driven
and d->driver are still used after bind_lock has been dropped.

Once phy_link_change is NULL, a concurrent phy_attach_direct() passes
its "already attached" test. At that point d->driver still points at
the genphy driver, phydev->bound is still true and is_genphy_driven is
still 1. The attach therefore takes the genphy path again and calls
__phy_probe() and device_bind_driver() on a device that is still bound.

If the driver sysfs links have not been removed yet, driver_sysfs_add()
fails with -EEXIST. The attach then unwinds through error_module_put,
which clears is_genphy_driven and sets d->driver to NULL.

The detaching thread then does one of two things:

- It sees is_genphy_driven == 0 and skips device_release_driver().

- It reaches __device_release_driver() after dev->driver was cleared
  and does nothing.

Either way the device stays on the genphy driver's klist with its
driver sysfs links in place, but with a NULL driver pointer. Since
phy_remove() never runs, phydev->bound stays true.

>From then on, every genphy attach fails the same way in
driver_sysfs_add(). When the device is later deleted,
bus_remove_device() finds no driver to release. As far as I can tell,
the knode_driver of a freed device is then left on the genphy driver's
list.

Would it work to keep phy_link_change set until
device_release_driver() has returned? Only attached would be cleared,
and the waiter woken, before it. A new attach would then get -EBUSY
for the whole genphy release. Or is there another way you would
prefer to keep phy_attach_direct() off a device whose genphy driver is
still being released?

[Severity: Medium]
This wait has no timeout and cannot be interrupted. It also runs while
the driver core holds the PHY's device lock. __wait_var_event() is:

include/linux/wait_bit.h:
#define __wait_var_event(var, condition)
	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, 0, 0,
			  schedule())

and phy_remove() is reached under the device lock (plus the parent lock,
when the bus needs it):

drivers/base/dd.c:device_release_driver_internal() {
    ...
	__device_driver_lock(dev, parent);

	if (!drv || drv == dev->driver)
		__device_release_driver(dev, parent);

	__device_driver_unlock(dev, parent);
    ...
}

Only phy_detach_internal() or phy_device_remove() can end the wait. For
a MAC that connects in ndo_open, that means an ifdown. For DSA, or a MAC
that connects at probe, it means tearing down the consumer driver. Until
then the unbinding task sits in D state and keeps holding dev->mutex.

The commit message covers the reboot hang in device_shutdown(). There
seem to be other effects as well:

- The freezer cannot freeze a task in TASK_UNINTERRUPTIBLE without
  TASK_FREEZABLE, so system suspend and hibernate would abort.

- The hung task detector would report the task every
  hung_task_timeout_secs, and with hung_task_panic=1 the machine would
  panic.

- Anything else that needs this device's lock would block too, such as
  a later bind, a driver_override write, or loading a driver that
  matches the device.

The dependency is a bool flag plus wait_var_event(), and dev->mutex uses
a lockdep novalidate class. As far as I can tell, lockdep cannot report
any of these hangs.

Was a different design considered? For example, a managed device link
from the consumer to the PHY would make the driver core unbind the
consumer before the PHY, so phy_remove() would not have to block under
the device lock.

[Severity: High]
Can this wait end up waiting on its own thread forever? The commit
message says:

  One case is known to wait for good and is untested: when the PHY and
  its MAC or switch are managed device-link consumers of one supplier,
  unbinding the supplier can unbind the PHY first, and phy_remove() then
  waits for a detach that only the same thread would run later.

When a supplier is unbound, device_links_unbind_consumers() unbinds each
active managed consumer synchronously, one at a time:

drivers/base/core.c:device_links_unbind_consumers() {
    ...
		if (status == DL_STATE_ACTIVE) {
			struct device *consumer = link->consumer;

			get_device(consumer);

			device_links_write_unlock();

			device_release_driver_internal(consumer, NULL,
						       consumer->parent);
			put_device(consumer);
			goto start;
		}
    ...
}

The PHY can be a consumer of a third-party supplier through fw_devlink,
for example via reset-gpios, interrupts, pinctrl or a clock. If its link
is processed before the link of the MAC or switch that holds it
attached, the call chain is:

device_release_driver_internal(supplier)
  __device_release_driver(supplier)
    device_links_unbind_consumers(supplier)
      device_release_driver_internal(phy)
        phy_remove()
          wait_var_event()

The phy_detach() that would wake the waiter runs only when the MAC or
switch consumer is unbound. That happens later in the same loop, on the
same thread, after phy_remove() returns. The thread then hangs for good
while holding both the supplier's and the PHY's device locks, and any
later reboot hangs in device_shutdown() as well.

The MAC-to-PHY link created in phy_attach_direct() does not help here:

	phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
					  DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);

Because it is stateless, device_links_unbind_consumers() ignores it and
does not unbind the MAC before the PHY.

This patch knowingly ships a hang that cannot be recovered. Could it be
avoided before merging, for example with a timeout, a managed link, or
by skipping the wait when the unbind comes from a supplier?

>  	cancel_delayed_work_sync(&phydev->state_queue);
>  
>  	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev))

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009180551.1234107-1-f%40lex.la
