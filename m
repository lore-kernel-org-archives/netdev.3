Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FDA2F7F1F
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956572; cv=none; b=EQ6Vprimg0AkK/D3+QU8lCItsY44f6aCsUSvWfyYAlFDaChx1Mgaw4wE5UD0f3LD/J/Spc1eFDIWS7h81A2XSPc0HvOfDnr+mvKTGG6xvKtUHw3qrgg+iQj3ZHUCVIhB+ZT6Liuleee49CK1WiAXnYAz+60UrlSuVA1NsD6VF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956572; c=relaxed/simple;
	bh=DCA9EHCZ7M4HhRiDaLHSZwn9Z4v2xOIiETN3Ry8qSoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icye3zUPR+7djtd0V0zVHFpAzAODXUNdqCwm9o5Xpi2dTnOatkUTr8T1xrY3eo3s4UiU0CJ1Qq86cZnvwRP1SWZsr7S8AdubdNBdoCde/arbxBiYphp5VfF4uObUq3x93eG9AvxvP2Q7pL3fsow/YIvNZEPKXp2KMGIU1PVhG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cOjFQ5WP; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cOjFQ5WP"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DCA9EHCZ7M4HhRiDaLHSZwn9Z4v2xOIiETN3Ry8qSoM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789956568; v=1; x=1790561368;
 b=cOjFQ5WPZYLzog3ED7S3oWpPOxL+8zrUsFU7OdjUKQiENwMeef5RRkoADtC2aI62qt3p+aQC
 jFhWO2yq/MJL2mKXvRpIvzRJv67lUJjQNjgIKfp5x48yWk9EwdEWJhSHiKFiv/Z2K0fyNMOVwLW
 GEgxfHW+g3HHVh+H4OxGMlGA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cf2b9a97cce04a31;
	Mon, 21 Sep 2026 02:09:28 +0000
X-Mizu-Trace-ID: cf2b9a97cce04a31
X-Migadu-Flow: FLOW_OUT
Date: Mon, 21 Sep 2026 10:09:26 +0800
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: netdev-bot+sashiko@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, zhaochenguang@kylinos.cn,
	syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: phy: allow phy_detach() before netdev
 registration
Message-ID: <20260921020926.GB130870@pc>
References: <20260916021505.238990-1-chenguang.zhao@linux.dev>
 <178987157813.2160803.11863472342807892620@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178987157813.2160803.11863472342807892620@kernel.org>

On Sun, Sep 20, 2026 at 02:32:58AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Incomplete fix: phy_detach() still emits the identical
>   "suspicious rcu_dereference_protected() usage" splat for net_devices…
> 
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the `struct
>   hwtstamp_provider` object stored in `dev->hwprov` has no free on the…
> 
> --
> 
> net: phy: allow phy_detach() before netdev registration
> 
> This changes phy_detach() to use rcu_dereference_protected() on dev->hwprov
> with a condition that accepts either RTNL being held or the net_device still
> being in NETREG_UNINITIALIZED state.  The goal is to silence a syzbot
> lockdep report from a probe-time phylink_connect_phy() failure path.
> 
> Closes: https://syzkaller.appspot.com/bug?extid=694b49f41098a5df4fd7
> 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 94b2e85e00a37..acd8d658a29e1 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -1941,7 +1941,9 @@ void phy_detach(struct phy_device *phydev)
> >  		/* hwprov may technically be protected by ops lock but
> >  		 * not for devices with a phydev, see phy_link_topo_add_phy()
> >  		 */
> > -		hwprov = rtnl_dereference(dev->hwprov);
> > +		hwprov = rcu_dereference_protected(dev->hwprov,
> > +						   lockdep_rtnl_is_held() ||
> > +						   dev->reg_state == NETREG_UNINITIALIZED);
> 
> [Severity: Medium]
> Does this cover all of the states in which the net_device is not visible to
> users?  The predicate only whitelists NETREG_UNINITIALIZED, so
> NETREG_UNREGISTERED still makes both operands false and the same
> rcu_dereference_protected() splat is printed.
> 
> One path that seems to still hit it is usbnet teardown, where
> unregister_netdev() runs before the driver unbind callback:
> 
> drivers/net/usb/usbnet.c:usbnet_disconnect() {
> 	...
> 	net = dev->net;
> 	unregister_netdev(net);
> 	...
> 	if (dev->driver_info->unbind)
> 		dev->driver_info->unbind(dev, intf);
> 	...
> }
> 
> By the time unbind() runs, netdev_run_todo() has already done:
> 
> net/core/dev.c:netdev_run_todo() {
> 	...
> 	WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
> 	...
> }
> 
> and smsc95xx_unbind() then reaches phy_detach() with no rtnl_lock() held:
> 
> drivers/net/usb/smsc95xx.c:smsc95xx_unbind() {
> 	...
> 	phy_disconnect(dev->net->phydev);
> 	...
> }
> 
> phy_disconnect() -> phy_detach(), reg_state is NETREG_UNREGISTERED, RTNL is
> not held, so is the warning unchanged for this caller?
> 
> A second path looks similar: when register_netdevice() fails after
> netdev_register_kobject(), it leaves
> 
> net/core/dev.c:register_netdevice() {
> 	...
> 	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
> 	...
> }
> 
> and lan78xx_probe() then unwinds through its phy_uninit: label into
> lan78xx_phy_uninit() -> phylink_disconnect_phy() -> phy_detach() from probe
> context without RTNL.  That case also lands on NETREG_UNREGISTERED rather
> than NETREG_UNINITIALIZED.
> 
> Note that in the usbnet case dev->hwprov can be non-NULL, since it is
> installed while the device is registered by ethnl_set_tsconfig(), so
> execution continues into rcu_assign_pointer(dev->hwprov, NULL) and
> kfree_rcu() with neither RTNL nor the netdev ops lock annotated.
> 
> The kernel already expresses the "not user-visible" notion here:
> 
> include/net/netdev_lock.h:netdev_assert_locked_or_invisible() {
> 	if (dev->reg_state == NETREG_REGISTERED ||
> 	    dev->reg_state == NETREG_UNREGISTERING)
> 		netdev_assert_locked(dev);
> }
> 
> Would using that same notion, rather than a single state, close the whole
> warning class?
> 
> The commit message also says:
> 
>     hwprov cannot have been assigned before register_netdevice(). Relax the
>     RCU check for that state only; registered devices still require RTNL.
> 
> As written the code requires RTNL for unregistering and unregistered devices
> too, not just registered ones.  Should the wording be adjusted, or the
> condition widened to match?
> 
> >  		/* Disable timestamp if it is the one selected */
> >  		if (hwprov && hwprov->phydev == phydev) {
> >  			rcu_assign_pointer(dev->hwprov, NULL);
> 
> [Severity: Medium]
> This is a pre-existing issue and not introduced by this patch, but while
> looking at this block: is the struct hwtstamp_provider object ever freed on
> the net_device teardown path?
> 
> The only writers of dev->hwprov in the tree appear to be
> rcu_replace_pointer(dev->hwprov, hwprov, ...) in ethnl_set_tsconfig()
> (allocated by tsconfig_set_hwprov_from_desc() with hwprov = kzalloc_obj(*hwprov))
> and the rcu_assign_pointer(dev->hwprov, NULL) above.
> 
> net/core/dev.c has no reference to hwprov at all, so neither
> unregister_netdevice_many_notify() nor free_netdev() releases it.
> 
> Since the free in phy_detach() is conditional on hwprov->phydev == phydev, a
> provider with source HWTSTAMP_SOURCE_NETDEV (hwprov->phydev is NULL), or a
> HWTSTAMP_SOURCE_PHYLIB provider whose phydev is not the PHY being detached,
> never matches.  Does that leak the hwtstamp_provider allocation when the
> interface is destroyed after a tsconfig set?
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916021505.238990-1-chenguang.zhao%40linux.dev
This reply is based on v1. I have already sent v2. I can make further
changes to v1 if needed.

v2: https://lore.kernel.org/all/20260918022316.237646-1-chenguang.zhao@linux.dev/

pw-bot: cr
