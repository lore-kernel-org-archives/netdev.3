Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AE3B5307
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871589; cv=none; b=agGeBc14taKACHXEaWXxvN5gkg1LkmtKdsz1E7iro0yvKLSlv8WuiUkR0yrWv6RvbebK19KNOZVotcCS0H3YyDFS0ZqVwHt/a9Vab6WUmf9CtZrZ0kCZzyUHAwZCjOwGA+EjIgxqW8hpeXEUTkAq1HUkqOVEBUzfqK7fuQ4O2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871589; c=relaxed/simple;
	bh=IYG7uvr8PxIahe3JWUS/Nt0y03hy4sbuEEyiI2JXEbg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZhlmlflnbarjIdvLnHWbtbAqXz4L+YOhd/EP7NsA34n5D8qVm4VEjzy5zLIs00c+NUXQKqR3eOOpCJ2VsWdOXY4pC/iw6M2I3hEfO+o7vKShPQ1UIFquA8D1uh88srjPOO6D2sKGCJPyvzLAToG9+A9Os7T/c4Xg3QCpfk8748E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBnZGB8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBnZGB8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14CE1F000FF;
	Sun, 20 Sep 2026 02:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789871579;
	bh=7bsYqjwrdDCRzRApcHsmzIkYJWwVgVD+/JmCZef/3ig=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MBnZGB8HAWbwXbbCAN24SWUJW3Odc7fRoz6kGzjXqrf9DTF7mJT8WvjsEnIuJQWff
	 uWTTLS1ik+y3XHUP3rnaXDIe7DPN8qI6Q2MkmLJFRWS5Lh4m8l11Bvi39aoZkyH0fv
	 k5iI9Oj5a5JWDfOHzKcbGRUeZnfomeX1/0REojGeZO+YL5GZBzhOyesXyVrPvg8+94
	 NrfrOq3ZqxKNwzfR0/iSvYv7+IJF5Kl4OyTkatrU7oWzcuI54kN7rnDO6NhK3PLzGF
	 lQmuDsoec+SRNVFIIHbv/duiBldfQMpjnmo6BH0v6y0Opy8sMwgL5KRRSlk29IHqIF
	 PluqnyIozu0PA==
Subject:
 Re: [PATCH net] net: phy: allow phy_detach() before netdev registration
From: netdev-bot+sashiko@kernel.org
To: chenguang.zhao@linux.dev
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, zhaochenguang@kylinos.cn,
 syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Date: Sun, 20 Sep 2026 02:32:58 +0000
Message-ID: <178987157813.2160803.11863472342807892620@kernel.org>
In-Reply-To: <20260916021505.238990-1-chenguang.zhao@linux.dev>
References: <20260916021505.238990-1-chenguang.zhao@linux.dev>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete fix: phy_detach() still emits the identical
  "suspicious rcu_dereference_protected() usage" splat for net_devices…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the `struct
  hwtstamp_provider` object stored in `dev->hwprov` has no free on the…

--

net: phy: allow phy_detach() before netdev registration

This changes phy_detach() to use rcu_dereference_protected() on dev->hwprov
with a condition that accepts either RTNL being held or the net_device still
being in NETREG_UNINITIALIZED state.  The goal is to silence a syzbot
lockdep report from a probe-time phylink_connect_phy() failure path.

Closes: https://syzkaller.appspot.com/bug?extid=694b49f41098a5df4fd7

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a37..acd8d658a29e1 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1941,7 +1941,9 @@ void phy_detach(struct phy_device *phydev)
>  		/* hwprov may technically be protected by ops lock but
>  		 * not for devices with a phydev, see phy_link_topo_add_phy()
>  		 */
> -		hwprov = rtnl_dereference(dev->hwprov);
> +		hwprov = rcu_dereference_protected(dev->hwprov,
> +						   lockdep_rtnl_is_held() ||
> +						   dev->reg_state == NETREG_UNINITIALIZED);

[Severity: Medium]
Does this cover all of the states in which the net_device is not visible to
users?  The predicate only whitelists NETREG_UNINITIALIZED, so
NETREG_UNREGISTERED still makes both operands false and the same
rcu_dereference_protected() splat is printed.

One path that seems to still hit it is usbnet teardown, where
unregister_netdev() runs before the driver unbind callback:

drivers/net/usb/usbnet.c:usbnet_disconnect() {
	...
	net = dev->net;
	unregister_netdev(net);
	...
	if (dev->driver_info->unbind)
		dev->driver_info->unbind(dev, intf);
	...
}

By the time unbind() runs, netdev_run_todo() has already done:

net/core/dev.c:netdev_run_todo() {
	...
	WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
	...
}

and smsc95xx_unbind() then reaches phy_detach() with no rtnl_lock() held:

drivers/net/usb/smsc95xx.c:smsc95xx_unbind() {
	...
	phy_disconnect(dev->net->phydev);
	...
}

phy_disconnect() -> phy_detach(), reg_state is NETREG_UNREGISTERED, RTNL is
not held, so is the warning unchanged for this caller?

A second path looks similar: when register_netdevice() fails after
netdev_register_kobject(), it leaves

net/core/dev.c:register_netdevice() {
	...
	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
	...
}

and lan78xx_probe() then unwinds through its phy_uninit: label into
lan78xx_phy_uninit() -> phylink_disconnect_phy() -> phy_detach() from probe
context without RTNL.  That case also lands on NETREG_UNREGISTERED rather
than NETREG_UNINITIALIZED.

Note that in the usbnet case dev->hwprov can be non-NULL, since it is
installed while the device is registered by ethnl_set_tsconfig(), so
execution continues into rcu_assign_pointer(dev->hwprov, NULL) and
kfree_rcu() with neither RTNL nor the netdev ops lock annotated.

The kernel already expresses the "not user-visible" notion here:

include/net/netdev_lock.h:netdev_assert_locked_or_invisible() {
	if (dev->reg_state == NETREG_REGISTERED ||
	    dev->reg_state == NETREG_UNREGISTERING)
		netdev_assert_locked(dev);
}

Would using that same notion, rather than a single state, close the whole
warning class?

The commit message also says:

    hwprov cannot have been assigned before register_netdevice(). Relax the
    RCU check for that state only; registered devices still require RTNL.

As written the code requires RTNL for unregistering and unregistered devices
too, not just registered ones.  Should the wording be adjusted, or the
condition widened to match?

>  		/* Disable timestamp if it is the one selected */
>  		if (hwprov && hwprov->phydev == phydev) {
>  			rcu_assign_pointer(dev->hwprov, NULL);

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but while
looking at this block: is the struct hwtstamp_provider object ever freed on
the net_device teardown path?

The only writers of dev->hwprov in the tree appear to be
rcu_replace_pointer(dev->hwprov, hwprov, ...) in ethnl_set_tsconfig()
(allocated by tsconfig_set_hwprov_from_desc() with hwprov = kzalloc_obj(*hwprov))
and the rcu_assign_pointer(dev->hwprov, NULL) above.

net/core/dev.c has no reference to hwprov at all, so neither
unregister_netdevice_many_notify() nor free_netdev() releases it.

Since the free in phy_detach() is conditional on hwprov->phydev == phydev, a
provider with source HWTSTAMP_SOURCE_NETDEV (hwprov->phydev is NULL), or a
HWTSTAMP_SOURCE_PHYLIB provider whose phydev is not the PHY being detached,
never matches.  Does that leak the hwtstamp_provider allocation when the
interface is destroyed after a tsconfig set?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916021505.238990-1-chenguang.zhao%40linux.dev
