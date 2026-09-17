Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C7A4FD26B;
	Thu, 17 Sep 2026 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680307; cv=none; b=bhrcnyn/RjIyBBCPe/etvSuC4uFuBScg4TrCzxRICZL8AfrR2JGcw41XV7SfCIgdMzJ0ey3DZpjka3mFsDIjAsr3s4jWDhaMP0lGzZ18HBFTPqqUIj/mMDaWuT5Zxqy1lTDs0nBllkS+2AHG03tErVzL1DBgz61+kCupJ9S33jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680307; c=relaxed/simple;
	bh=ROS23SvRoVv8gu9K2RSHS7jdg6lODRBfbf8f3ttCKVA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MO4P0mJcYATED/0p0zw0Ke6yg8LOM89ad/dsQ+/d1AK60WGqERWILNIW5EeShwGhXzA7ozGfTq9YXeGX47UEyWikthUJh4/ILAqXJDE6mY6ALoKEiISrF2e15q1U32GSO1gjXpd2QBSH70giHWKdzhAHXkAp9b4nDQnRk7C6mTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5cbvghN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5cbvghN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD8D1F00898;
	Thu, 17 Sep 2026 21:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680304;
	bh=RnN8zERFC8N6QZcmfGab3nNI19sQk5F/+G4lcfC6Ryw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S5cbvghNgJ42XB79SjvaYNGBdh016ZHW9LHfziPr2ILC2bxniumW3UfVIcQwfW89U
	 k8BOEcglXi4umRVkOewuAreG7WTd5okXqLIkBhTrHfFshj0jJX+LEwYYfVAziWeb7S
	 k0Tir+h+OSfdpw2K7RhYNS3uleYyoUf1LYPllkcv8dA2QS9maIEkvxXq9rWL+CGZEo
	 3M7d3knPMdr6MNSZ0rTKxz/PWVnl+TmBbdtIxD6H7QwfnTS+UiWFFLkTMKTH6R1uLn
	 rwmpFWrx4EJEbsHyydSYJbWkuhTniAYv5RCx56iF7JrLxLYDD84xcCatTEdUTMWlyX
	 p1SOYQXGEmA8g==
Subject: Re: [PATCH net-next v12 11/15] ax88179_178a: Add Suspend/resume
 support for AX88179A/772D/279
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:25:03 +0000
Message-ID: <178968030357.22033.18257401689515949008@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-11-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-11-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 4 · Low: 3

- [High] ax88179a_suspend() (drivers/net/usb/ax88179a_devices.c:170-172)
  calls usbnet_suspend(intf, message) but discards its return value and…
- [High] ax88179a_resume() (drivers/net/usb/ax88179a_devices.c:210-214)
  and ax88179a_suspend() (:138-142) call rtnl_lock() from inside the…
- [Medium] The new WoL programming in ax88179a_suspend()
  (drivers/net/usb/ax88179a_devices.c:146-152) performs a purely…
- [Medium] The new PM callbacks consume the results of ax88179_read_cmd()
  without checking the status, and for one-byte reads the destination is…
- [Medium] ax88179a_stop() (drivers/net/usb/ax88179a_devices.c:1163-1165)
  sets 'reg8 = 0;' and then calls ax88179_read_cmd(dev,…
- [Medium] The new ax88179a_resume() calls ax88179a_reset()
  (drivers/net/usb/ax88179a_devices.c:208), which unconditionally…
- [Low] The comment added in ax88179a_reset()
  (drivers/net/usb/ax88179a_devices.c:1140-1142) claims that when the…
- [Low] The comment added in ax88179a_resume()
  (drivers/net/usb/ax88179a_devices.c:201-203) says 'PHY-power is re-…
- [Low] The new PM callbacks issue a chain of vendor control transfers
  whose results are all discarded and then report success.

--

ax88179_178a: Add Suspend/resume support for AX88179A/772D/279

This adds suspend and resume handling for the AX88179A/772D/279 chips by
storing per-device suspend/resume function pointers in struct ax88179_data
and calling them from new wrapper functions registered in the single
usb_driver instance. A few questions on the new PM paths below.

> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index a2c596305f798..93031b9ee92bc 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c

[ ... ]

> @@ -1342,9 +1345,9 @@ static struct usb_driver ax88179_178a_driver = {
>  	.name =		"ax88179_178a",
>  	.id_table =	products,
>  	.probe =	usbnet_probe,
> -	.suspend =	ax88179_suspend,
> -	.resume =	ax88179_resume,
> -	.reset_resume =	ax88179_resume,
> +	.suspend =	ax88179_suspend_wrapper,
> +	.resume =	ax88179_resume_wrapper,
> +	.reset_resume =	ax88179_resume_wrapper,
>  	.disconnect =	ax88179_disconnect,
>  	.supports_autosuspend = 1,
>  	.disable_hub_initiated_lpm = 1,
> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> index 708b0b23f1363..3b498206c50d5 100644
> --- a/drivers/net/usb/ax88179_lib.c
> +++ b/drivers/net/usb/ax88179_lib.c
> @@ -455,3 +455,22 @@ int ax88179_set_mac_addr(struct net_device *net, void *p)
>  	return 0;
>  }
>  
> +int ax88179_suspend_wrapper(struct usb_interface *intf, pm_message_t message)
> +{
> +	struct usbnet *dev = usb_get_intfdata(intf);
> +	struct ax88179_data *priv;
> +
> +	priv = dev->driver_priv;
> +
> +	return priv->suspend(intf, message);
> +}
> +
> +int ax88179_resume_wrapper(struct usb_interface *intf)
> +{
> +	struct usbnet *dev = usb_get_intfdata(intf);
> +	struct ax88179_data *priv;
> +
> +	priv = dev->driver_priv;
> +	return priv->resume(intf);
> +}
> +
> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index e77450bc3299f..ff41d20c219d4 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c

[ ... ]

> @@ -123,6 +125,53 @@ static void ax88179a_status(struct usbnet *dev, struct urb *urb)
>  	phylink_mac_interrupt(data->phylink);
>  }
>  
> +static int ax88179a_suspend(struct usb_interface *intf, pm_message_t message)
> +{
> +	struct usbnet *dev = usb_get_intfdata(intf);
> +	struct ax88179_data *priv;
> +	u16 tmp16;
> +	u8 tmp8;
> +
> +	priv = dev->driver_priv;
> +	ax88179_set_pm_mode(dev, true);
> +
> +	if (netif_running(dev->net)) {
> +		rtnl_lock();
> +		phylink_suspend(priv->phylink, !!priv->wolopts);
> +		rtnl_unlock();
> +	}
> +
> +	/* Enable WoL */
> +	if (priv->wolopts) {
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, &tmp8);

[Severity: Medium]
tmp8 is declared without an initialiser and the read status is dropped
here.  For a one-byte access ax88179_read_cmd() hands the caller's variable
straight to __usbnet_read_cmd(), which only fills it in when the control
transfer returns a positive length:

drivers/net/usb/ax88179_lib.c:ax88179_read_cmd() {
	if (size == 2) {
		u16 buf = 0;
	...
	} else {
		ret = __ax88179_read_cmd(dev, cmd, value, index, size, data);
	}
}

If that read fails or comes back zero-length, is an indeterminate stack byte
then ORed with the WoL bits, written into the MAC monitor-mode register and
sent out on the control pipe to the device?

The same shape appears in ax88179a_resume() below, where the uninitialised
reg8 is tested immediately after an unchecked AX88179A_PHY_POWER read.
Would initialising both variables and checking the read status help here?

The legacy ax88179_suspend() has the same unchecked read-modify-write, but
these are new instances.

> +		if (priv->wolopts & WAKE_PHY)
> +			tmp8 |= AX_MONITOR_MODE_RWLC;
> +		if (priv->wolopts & WAKE_MAGIC)
> +			tmp8 |= AX_MONITOR_MODE_RWMP;
> +
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, &tmp8);

[Severity: Medium]
This read-modify-write only sets wake-source bits, it never clears the ones
that are already set.  ax88179a_reset() seeds that register with
magic-packet wake on every open and on every resume:

	if (ax179_data->chip_version < AX_VERSION_AX88179A)
		*tmp = AX_MONITOR_MODE_PMETYPE | AX_MONITOR_MODE_PMEPOL | AX_MONITOR_MODE_RWMP;
	else
		*tmp = AX_MONITOR_MODE_RWMP;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, tmp);

Does selecting WAKE_PHY alone therefore leave magic-packet wake still armed?

And with wolopts == 0 this branch is skipped entirely, so does RWMP stay
armed even though userspace asked for no WoL, while ax88179_get_wol()
reports 0?

> +
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);
> +		tmp16 |= AX_MEDIUM_RECEIVE_EN;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);
> +
> +		if (priv->chip_version == AX_VERSION_AX88279)
> +			ax88179_write_cmd(dev, AX88179A_WAKEUP_SETTING, 8,
> +					  EPHY_LOW_POWER_EN | S5_WOL_EN
> +					  | S5_WOL_LOW_POWER | 0x8000, 0, NULL);
> +		else
> +			ax88179_write_cmd(dev, AX88179A_WAKEUP_SETTING, 0,
> +					  EPHY_LOW_POWER_EN, 0, NULL);
> +
> +	} else if (priv->chip_version == AX_VERSION_AX88279) {
> +		ax88179_write_cmd(dev, AX88179A_WAKEUP_SETTING, 8, 0x8000, 0, NULL);
> +	}
> +
> +	usbnet_suspend(intf, message);
> +	ax88179_set_pm_mode(dev, false);
> +	return 0;
> +}

[Severity: High]
usbnet_suspend() can fail, and its result is discarded here:

drivers/net/usb/usbnet.c:usbnet_suspend() {
	if (!dev->suspend_count++) {
		spin_lock_irq(&dev->txq.lock);
		/* don't autosuspend while transmitting */
		if (dev->txq.qlen && PMSG_IS_AUTO(message)) {
			dev->suspend_count--;
			spin_unlock_irq(&dev->txq.lock);
			return -EBUSY;
	...
}

On that path no detach or URB teardown happens and suspend_count is put back
to 0, yet ax88179a_suspend() returns 0 and ax88179_suspend_wrapper() passes
that 0 to the USB core, so the interface is suspended anyway.

The following resume then runs usbnet_resume():

	if (!--dev->suspend_count) {

on a zero unsigned char, which wraps to 255, so the status URB restart, the
RX URB resubmission, the deferred TX anchor flush and the EVENT_DEV_ASLEEP
clearing are all skipped, and suspend_count stays off by one for the rest of
the binding.  Does the receive path stay dead until ifdown/ifup or a replug?

The driver keeps .supports_autosuspend = 1 and takes no PM usage reference,
and ax88179a_info sets FLAG_AVOID_UNLINK_URBS so usbnet_stop() does not call
usbnet_terminate_urbs(), which leaves txq.qlen non-zero when the autosuspend
timer fires, i.e. exactly the -EBUSY condition.

Should the error be propagated, and the WoL/phylink work above unwound on
that path?

>  
>  static int ax88179a_auto_detach(struct usbnet *dev)
>  {
>  	u16 tmp16;
> @@ -132,6 +181,43 @@ static int ax88179a_auto_detach(struct usbnet *dev)
>  	return 0;
>  }
>  
> +static int ax88179a_resume(struct usb_interface *intf)
> +{
> +	struct usbnet *dev = usb_get_intfdata(intf);
> +	struct ax88179_data *ax179_data;
> +	u8 reg8;
> +
> +	ax179_data = dev->driver_priv;
> +	ax88179_set_pm_mode(dev, true);
> +
> +	ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
> +	if (!(reg8 & AX_PHY_POWER)) {

[Severity: Medium]
This branch depends on the PHY power register, and ax88179a_stop() looks
like it meant to write that register but calls the read helper instead:

drivers/net/usb/ax88179a_devices.c:ax88179a_stop() {
	reg8 = 0;
	ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
}

ax88179a_unbind() does the power-down with a write:

	tmp8 = 0;
	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &tmp8);

Does the PHY stay powered after 'ip link set <dev> down', and does the new
resume code above then read a state that the stop path was supposed to have
cleared?  This came in with the earlier series patch adding the AX179A chip
support rather than with this patch, but this patch is the first code to
branch on that register's contents.

> +		reg8 = AX_PHY_POWER;
> +		ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
> +		msleep(250);
> +	}
> +	ax88179_write_cmd(dev, AX_FW_MODE, AX_FW_MODE_179A, 0, 0, NULL);
> +
> +	/* Now, that AX_FW_MODE_179A is enabled, the PHY needs a power-cycle.
> +	 * PHY-power is re-enabled in ax88179_reset()
> +	 */

[Severity: Low]
The call below is ax88179a_reset(), while the comment names ax88179_reset(),
which is a different file-static function in ax88179_178a.c and is not on
this path.  Should the comment say ax88179a_reset()?

> +	reg8 = 0;
> +	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
> +	msleep(250);
> +
> +	ax88179a_reset(dev);

[Severity: Medium]
ax88179a_reset() rewrites both the cached and the hardware receive mode with
cold-start defaults:

	ax179_data->rxctl = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_START |
			    AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
	...
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);

AX_RX_CTL_PRO is not part of that set, and nothing on the resume path calls
ndo_set_rx_mode/ax88179_set_multicast() again; usbnet_resume() does not
re-push the RX mode and ax88179a_mac_link_up() writes the same overwritten
ax179_data->rxctl cache.

Does a promiscuous interface, for example a bridge port or a running
capture, stop receiving foreign unicast frames after a suspend/resume cycle
while net->flags still has IFF_PROMISC?

> +
> +	if (netif_running(dev->net)) {
> +		rtnl_lock();

[Severity: High]
Can this take rtnl_mutex recursively?  The usb_driver .resume callback runs
synchronously in the caller's context:

__dev_open()			/* holds rtnl_mutex, sets __LINK_STATE_START */
  usbnet_open()
    usb_autopm_get_interface()
      pm_runtime_resume_and_get()
        usb_resume_interface()
          ax88179_resume_wrapper()
            ax88179a_resume()
              rtnl_lock()	<-- rtnl_mutex already held by this task

netif_running() is already true at that point because __dev_open() sets
__LINK_STATE_START before calling ndo_open, so bringing up a runtime
suspended adapter would hit this.

ax88179a_suspend() has the mirror exposure: a task holding RTNL blocks in
pm_runtime while the suspend callback waits for RTNL.

asix_devices.c documents this hazard for ax88772 and blocks autosuspend with
pm_runtime_get_noresume(&intf->dev) in ax88772_bind().  This driver keeps
.supports_autosuspend = 1 and there is no pm_runtime_*/usb_autopm_* call in
ax88179_178a.c, ax88179_lib.c or ax88179a_devices.c.  Should the same
approach be used here, or the phylink calls moved out of the PM callbacks?

> +		phylink_resume(ax179_data->phylink);
> +		rtnl_unlock();
> +	}
> +
> +	ax88179_set_pm_mode(dev, false);
> +
> +	return usbnet_resume(intf);
> +}

[Severity: Low]
None of the control transfers in this callback are checked, the
ax88179a_reset() return value is dropped, and usbnet_resume() always returns
0, so a failed firmware-mode or PHY power restore is reported to the USB
core as a successful resume, including on the .reset_resume path.

ax88179_write_cmd() does propagate -EPIPE/-EPROTO/-ESHUTDOWN from
usbnet_write_cmd(_nopm), and the msleep(250) delays do not confirm that the
transition happened.  The AX_MONITOR_MOD, AX_MEDIUM_STATUS_MODE and
AX88179A_WAKEUP_SETTING writes in ax88179a_suspend() are unchecked in the
same way while the callback claims WoL was armed.

Would checking these and returning the error be preferable?

>  
>  static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts, u8 speed, bool full_duplex)
>  {
>  	struct ax88179_data *ax179_data = dev->driver_priv;

[ ... ]

> @@ -1048,7 +1137,11 @@ static int ax88179a_reset(struct usbnet *dev)
>  			     1, 1, &tmp) > 0)
>  		ax179_data->wol_supported = WAKE_MAGIC | WAKE_PHY;
>  
> -	phylink_start(ax179_data->phylink);
> +	/* ax88179a_reset() may also be called from resume context, phylink
> +	 * is already started, then.
> +	 */

[Severity: Low]
Is phylink really already started when this runs from ax88179a_resume()?
ax88179a_suspend() passes mac_wol = !!priv->wolopts, and with WoL off
phylink_suspend() takes the else branch:

drivers/net/phy/phylink.c:phylink_suspend() {
	...
	} else {
		phylink_stop(pl);
	}
}

so phylink is stopped at this point and is only restarted by the
phylink_resume() call that follows the reset.  Would wording along the lines
of "phylink_resume() will start it" describe the guard more accurately?

> +	if (!ax179_data->in_pm)
> +		phylink_start(ax179_data->phylink);
>  
>  	usbnet_link_change(dev, 0, 0);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
