Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8423AB9D;
	Wed, 23 Sep 2026 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129794; cv=none; b=iCH32gKb0qP8Muw8CWSTVONqoXM1yQDrIruYTGApK42z/Ipdvqp/0J5bnfKXG2ETBWzucvYyllUfCmB37hEqTVJ3K3/xoVgg2iDyAAJS7k+LGycrfosJryxOTJLiv408ZH+CLX3rXitFMb3KZ4RE/3PL8Wm9MB5ATK1J0KR+kVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129794; c=relaxed/simple;
	bh=bYFquYxopHCgUru3+F6MCtUWTJUf2ScvOl5GSjt1fKo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXZLTqcZaqZP41+4vWp0xdH/3bB7v7b5gUKHP2ML41silZBI6969peSs09JuGxYwdbFGVbwiHC55DguhP6h+KUrnrwnWZ3AjAOUqvwT6BWTyHj6rc8bsZzpToJiPSDDAet8ig1SC3bCuBY2bZu9NM+I/c3FoCCD8uJnzq4A/cuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoIMwJUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoIMwJUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930291F000FF;
	Wed, 23 Sep 2026 02:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129792;
	bh=vxAJTp15YaWbpuNqzN1zd787nmpamoOv4xqv8H+gpMM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IoIMwJUIRB7fstQtCYdbRzY1TV9vVLIfKt40zsmSWrtNPtNLaSSShqLGfo+QjoIzA
	 yEHEqEhxiXRxrnxvL2U5dCQ24HFo6oBNV80OsrBNlMx8Po/ibkIfaxmIdIgr2eolrX
	 xoT16c+fIzVvnrTOY4KPPecy1jxQW90mG5KBVi3FVw/ru5XzoAmmtf0kh1AAFlGMsM
	 JUKvxjwRFyw9aNYq+pkLv5JIzKA53YyhRp28rs7hMw7oyuRhCYaZJmiJHjHFyc4AyL
	 UaYwHoRgiUrfwWT11jYVflaKgLaAb9CFo7P5SLOWGD7n/Af9mZjgXxUB1dyDd+8fMu
	 LvJHVZFS4wOfw==
Subject: Re: [PATCH net-next v2] net: phy: refuse to attach a PHY whose driver
 is being unbound
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com
Date: Wed, 23 Sep 2026 02:16:31 +0000
Message-ID: <179012979109.2160803.16093602424097111667@kernel.org>
In-Reply-To: <20260919015340.499675-1-f@lex.la>
References: <20260919015340.499675-1-f@lex.la>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new `else if (!phydev->drv)` guard in phy_attach_direct()
  (drivers/net/phy/phy_device.c:1821) is a single unsynchronized plain…
- [Low] The kernel-doc block above phy_attach_direct()
  (drivers/net/phy/phy_device.c:1781-1788) still states unconditionally…
- [Low] Submission metadata is incomplete and self-inconsistent for a
  crash fix: the commit fixes a reproducible NULL-pointer…

Pre-existing issues:
- [Medium] Module reference mispairing across unbind: phy_attach_direct()
  charges the reference with try_module_get(d->driver->owner)…

--

net: phy: refuse to attach a PHY whose driver is being unbound

phy_attach_direct() gains a new arm that refuses the attach with -EBUSY
when the mdio device still has a d->driver but phydev->drv has already
been cleared by phy_remove(). The intent is to avoid completing an attach
on a driverless PHY, where the NULL phydev->drv is later dereferenced.

A few questions below about the new check and its neighbourhood.

[Severity: Low]
The changelog says:

  "Tree and Fixes: tag follow Maxime Chevallier's reading of how reachable
  this is in practice"

but the commit carries only Assisted-by: and Signed-off-by: trailers, with
no Fixes: tag, no Cc: stable and no target tree in the subject prefix.

Documentation/process/maintainer-netdev.rst says:

   - for fixes the ``Fixes:`` tag is required, regardless of the tree

Since this is described as fixing a reproducible oops, could the Fixes: tag
(and a stable designation, if one is intended) be added, pointing at the
commit that introduced the phydev->drv = NULL ordering in phy_remove()?

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5b13a74e2fa9..dfc2b29cac8a 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1818,6 +1818,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  			d->driver = &genphy_driver.mdiodrv.driver;
>  
>  		phydev->is_genphy_driven = 1;
> +	} else if (!phydev->drv) {
> +		/* d->driver outlives phydev->drv on unbind, precedes it on bind */
> +		err = -EBUSY;
> +		goto error_put_device;
>  	}

[Severity: High]
Does this check actually close the window described in the commit message?
It is a single unlocked read of phydev->drv, and nothing keeps the observed
value valid for the rest of phy_attach_direct().

phy_remove() stores the NULL as its last statement, holding only the device
lock:

  drivers/net/phy/phy_device.c:phy_remove() {
	...
	phydev->drv = NULL;
  }

phy_attach_direct() runs under rtnl and takes neither device_lock(d) nor
phydev->lock around the new test, so the store can land at any point after
the test. After the test the attach does sleeping work
(device_bind_driver(), phy_link_topo_add_phy(), sysfs link creation) and
then re-reads the pointer:

  if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
	  phydev->irq = PHY_POLL;

with

  static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
  {
	  return phydrv->config_intr && phydrv->handle_interrupt;
  }

which dereferences the pointer unconditionally. Isn't that the same
instruction pair quoted in the commit message, the config_intr/handle_interrupt
loads at phy_attach_direct+0x150?

phy_init_hw(), called later in the same function, has the same shape: one
test on entry followed by several more dereferences and a call into driver
code:

  drivers/net/phy/phy_device.c:phy_init_hw() {
	if (!phydev->drv)
		return 0;

	if (phydev->drv->soft_reset) {
	...
	if (phydev->drv->config_init) {
		ret = phydev->drv->config_init(phydev);

There is also a variant that needs no NULL at all: once phy_remove() has
run phy_sfp_release() and drv->remove() but has not yet reached
phydev->drv = NULL, the new test passes and the attach goes on to call into
a driver instance whose remove() has already completed.

The commit message acknowledges this ("The mid-attach case needs
serialisation rather than a NULL test"), but the message also opens with
"Unbinding a PHY driver under an attached consumer crashes in real life"
and quotes the phy_drv_supports_irq() fault as the motivating oops. Would
it be better to serialise the read with its uses against phy_remove() (a
phylib-level mutex taken by both paths, holding a driver reference, or
having unbind refuse or wait while attached_dev is set) instead of adding
another entry-point test, so that the reported faulting site is actually
covered?

[Severity: Low]
Should the kernel-doc above phy_attach_direct() be updated too? It still
promises the opposite for this exact case:

  * Description: Called by drivers to attach to a particular PHY
  *     device. The phy_device is found, and properly hooked up
  *     to the phy_driver.  If no driver is attached, then a
  *     generic driver is used.

and there is no Return: section listing the new refusal.

Also, -EBUSY is now returned from two places in this function with
unrelated meanings. The existing one is permanent and prints something:

	if (phydev->attached_dev) {
		dev_err(&dev->dev, "PHY already attached\n");
		err = -EBUSY;
		goto error;
	}

The new one is a transient bind/unbind window and is silent, so a bare
EBUSY from SIOCSIFFLAGS with an empty dmesg is indistinguishable from "this
PHY belongs to another interface". The in-tree counterpart for a driverless
PHY does log:

  drivers/net/phy/phylink.c:phylink_sfp_connect_phy() {
	if (!phy->drv) {
		phylink_err(pl, "PHY %s (id 0x%.8lx) has no driver loaded\n",
			    phydev_name(phy), (unsigned long)phy->phy_id);
		...
		return -EINVAL;
	}

Would a phydev_err() here, and/or a distinct errno, make the two cases
tellable apart?

>  
>  	if (!try_module_get(d->driver->owner)) {

[Severity: Medium]
This isn't a bug introduced by this patch, and the changelog already flags
it as a "Separate defect, separate patch", but noting it here since the new
arm sits directly above the try_module_get(): the reference charged on
d->driver->owner at attach time is released by re-reading the field at
detach:

  drivers/net/phy/phy_device.c:phy_detach_internal() {
	...
	if (phydev->mdio.dev.driver)
		module_put(phydev->mdio.dev.driver->owner);

If the PHY driver is unbound while the consumer is still attached, the
driver core clears the field in device_unbind_cleanup():

  drivers/base/dd.c:device_unbind_cleanup() {
	...
	device_set_driver(dev, NULL);

so the later test is false, module_put() is skipped, and the charged
reference is leaked, leaving that PHY driver module permanently unloadable.
If a different driver was bound in between, the put goes to a module that
was never charged; module_put() uses atomic_dec_if_positive() with
WARN_ON(), so this warns rather than corrupting memory, but the target
module ends up below MODULE_REF_BASE and unusable for future
try_module_get() calls. Is recording the module the reference was taken on
(rather than re-reading d->driver) the direction you have in mind for that
follow-up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919015340.499675-1-f%40lex.la
