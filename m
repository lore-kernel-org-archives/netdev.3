Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F03EBF04;
	Wed, 16 Sep 2026 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541258; cv=none; b=SArhGdY+JnBsYlpAOK8onZUenHUrWCGEBScbwJo3wc+p3bGMV/kpo8i1QFwiypj55oRmFJMb7husWglbs+73AG7RiErmrldp4GY8Dwy5MIh++KAT8pRVv+vcXVKfQD+7rZvSAQYjrsIgh5VqSNuUeUNxBA4W3qvaBwNkF5GS+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541258; c=relaxed/simple;
	bh=pMSIG8UTDHXq7vuR/YFPmfLM/lqrk9f3+599ohxlbVc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kVzQDKoJP4Osll3bvE/robZRdUtOgtCB2BFQOajJCtlxpBfvUs4maiWC03paAYshZJk3Jg4TdxWtDKaXWAnbYmflWaG3Nioy3+wQMWVkMM9XZtONT/ELwr+IsUn9Hdtx1wWksT/zXMzW8F0PRIoY8+rdj6ZdOHlur2Bzr+T6rUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+AIPepJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+AIPepJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7321F0089B;
	Wed, 16 Sep 2026 06:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541256;
	bh=csEhZdl9izyyvJloiNO7o5XUTdKFCAbKGmv8ou/AG7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g+AIPepJjFokjgy/Zz0ucZJb1BvxZN74jib0m2yxZPk1yX0CfC6NDaX/dhkq3wk88
	 jiMzd8txjALeb1mJYMeEqKXJtcONQ6DdfFZsL5B9aBVwCGmmGqI6xJ5NcCMR1li/Pg
	 IVDKTSP1anJLasRTw+httpg6Gyb7J8DPbAOqPi4jTi4xM7axANBJReRvgYtdJ235rY
	 tD6YkdquQ/X14Wz0SUNAwnDpwV+icc2/RLUuWPP+/Kcm0GpSiukSph+TL3QqjjWWkO
	 lAdD2xromyrWi7WF1BsEQPAHDbpsJQETrQxQUJPPYAcwDnhfyzVyO2kGKY1ZDuqO+3
	 NDEgh992f0A9Q==
Subject: Re: [PATCH net-next v11 11/15] ax88179_178a: Add Suspend/resume
 support for AX88179A/772D/279
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:34 +0000
Message-ID: <178954125490.22033.7873815642633569155@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-11-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-11-5ea7a925ba6d@birger-koblitz.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 5 · Low: 2

- [High] Recursive rtnl_lock() deadlock: ax88179a_resume()
  (drivers/net/usb/ax88179a_devices.c:210-214) takes rtnl_lock() from…
- [Medium] ax88179a_suspend()
  (drivers/net/usb/ax88179a_devices.c:170-172) discards the return value…
- [Medium] The new PM callbacks read one-byte registers into
  uninitialized stack variables and ignore the transfer status.
- [Medium] The PHY is deliberately power-cycled in ax88179a_resume()
  (AX88179A_PHY_POWER written 0 at line 205, re-enabled inside…
- [Medium] ax88179a_resume() calls ax88179a_reset(), which
  unconditionally reprograms AX_RX_CTL to the reset default…
- [Medium] ax88179_resume_wrapper() is installed as .reset_resume
  (ax88179_178a.c:1350), so after a device reset that clears chip state,…
- [Low] ax88179a_resume() unconditionally powers the internal PHY and
  calls ax88179a_reset(), which re-enables the full receive datapath…
- [Low] Both comments added by this patch describe behaviour the code
  does not have.

--

ax88179_178a: Add Suspend/resume support for AX88179A/772D/279

The patch adds suspend/resume callbacks for the AX88179A/772D/279 family
by storing per-device function pointers in struct ax88179_data and
dispatching through new wrapper functions registered in the single
usb_driver instance.

> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 33be9ef73e73d..44a768c5808ac 100644
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

[Severity: Medium]
With ax88179_resume_wrapper() also installed as .reset_resume, what
restores the VLAN filter table after a device reset?

ax88179a_vlan_rx_add_vid() writes the VID bitmap straight into the chip:

drivers/net/usb/ax88179a_devices.c:ax88179a_vlan_rx_add_vid() {
	reg8 = (vid / 16);
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_ADDRESS, 1, 1, &reg8);
	...
}

There is no software shadow of that table, and ax88179a_reset() only
re-enables filtering from the netdev features:

	*tmp = 0;
	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
		*tmp |= AX_VLAN_CONTROL_VFE;
	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_RX)
		*tmp |= AX_VLAN_CONTROL_VSO;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, tmp);

After a reset_resume (hub power loss and various system suspend paths),
does this leave VLAN filtering enabled with an empty VID table, so all
tagged frames are dropped while the kernel still lists the VIDs as
configured?

[Severity: High]
Keeping .supports_autosuspend = 1 while ax88179a_resume() takes
rtnl_lock(): can this deadlock on the first "ip link set up" after a
runtime suspend?

The driver never holds a PM usage reference (no usb_autopm_* or
pm_runtime_get_noresume() in ax88179_178a.c, ax88179_lib.c or
ax88179a_devices.c), so the interface can be runtime-suspended while the
netdev is down. Then:

net/core/dev.c:__dev_open()          /* rtnl_mutex held */
    set_bit(__LINK_STATE_START, &dev->state);
    ops->ndo_open()
        drivers/net/usb/usbnet.c:usbnet_open()
            usb_autopm_get_interface(dev->intf)   /* synchronous resume */
                usb_resume_interface()
                    ax88179_resume_wrapper()
                        ax88179a_resume()
                            rtnl_lock();          /* already held */

The sibling driver documents exactly this hazard and blocks it by
holding a PM usage reference in ax88772_bind()
(drivers/net/usb/asix_devices.c). Should the same mitigation be applied
here?

On the same path, usbnet_open() calls info->reset after the resume
completes, so ax88179a_reset() then runs with in_pm == false and calls
phylink_start() on a phylink that phylink_resume() already started,
which trips the WARN in phy_start(). Is that intended?

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

[ ... ]

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 24accbc22092a..27836c72ec14a 100644
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
> +		if (priv->wolopts & WAKE_PHY)
> +			tmp8 |= AX_MONITOR_MODE_RWLC;
> +		if (priv->wolopts & WAKE_MAGIC)
> +			tmp8 |= AX_MONITOR_MODE_RWMP;
> +
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, &tmp8);

[Severity: Medium]
tmp8 is declared uninitialized and the status of the 1-byte read is not
checked. For size 1, ax88179_read_cmd() passes the caller's pointer
straight through:

drivers/net/usb/ax88179_lib.c:ax88179_read_cmd() {
	if (size == 2) {
		u16 buf = 0;
	...
	} else {
		ret = __ax88179_read_cmd(dev, cmd, value, index, size, data);
	}
}

and __usbnet_read_cmd() only copies on a positive length:

drivers/net/usb/usbnet.c:__usbnet_read_cmd() {
	if (err > 0 && err <= size) {
		if (data)
			memcpy(data, buf, err);
}

If the vendor read fails or returns zero bytes, does this write an
uninitialized stack byte back to the device in AX_MONITOR_MOD, possibly
arming unintended bits? The driver's own ax88179a_stop() does
reg8 = 0; before the same 1-byte read.

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

[Severity: Medium]
Should this propagate the usbnet_suspend() return value, as
asix_suspend() does with return usbnet_suspend(intf, message)?

usbnet_suspend() refuses an autosuspend with queued TX and undoes its
own accounting:

drivers/net/usb/usbnet.c:usbnet_suspend() {
	if (!dev->suspend_count++) {
		...
		if (dev->txq.qlen && PMSG_IS_AUTO(message)) {
			dev->suspend_count--;
			spin_unlock_irq(&dev->txq.lock);
			return -EBUSY;
}

Returning 0 there tells the USB core the interface is suspended even
though usbnet never detached the netdev or terminated URBs. The paired
resume then reaches:

drivers/net/usb/usbnet.c:usbnet_resume() {
	if (!--dev->suspend_count) {

with suspend_count still 0, so the unsigned char wraps to 255 and the
URB resubmission, deferred-TX flush, EVENT_DEV_ASLEEP clearing and TX
wake are skipped from then on. Can that happen here?

Related: the phylink_suspend() call and all the WoL/low-power register
programming above happen before usbnet_suspend(), so on a refused
suspend the hardware is left in WoL/low-power state with no rollback.
Should the ordering be inverted, or the programming undone on error?

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
Same pattern here: reg8 is uninitialized and the read status is
discarded, yet the value gates powering the PHY and the 250 ms settle
time before the AX_FW_MODE_179A write. If the 1-byte read fails (STALL
or short response, plausible right after a bus reset), can the
AX_FW_MODE_179A write be issued against an unpowered PHY?

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
This isn't a bug, but the comment names ax88179_reset() while the code
below calls ax88179a_reset(). ax88179_reset() is a separate static
function in ax88179_178a.c that is not reached for AX88179A/772D/279.

> +	reg8 = 0;
> +	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
> +	msleep(250);

[Severity: Medium]
After this deliberate PHY power-cycle, what re-applies the PHY
configuration?

ax88179a_init_phy() sets phydev->mac_managed_pm = true, which removes
phylib's mdio_bus_phy_resume() (the remaining caller of phy_init_hw() on
resume). With WoL enabled, phylink_suspend(pl, true) takes the MAC-WoL
branch and does not stop phylink, so on resume:

drivers/net/phy/phylink.c:phylink_resume() {
	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
		...
		phylink_mac_initial_config(pl, true);
		phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_MAC_WOL);
	} else {
		phylink_start(pl);
	}
}

The WoL branch touches only the MAC side, so phy_start() and the
PHY_UP -> _phy_start_aneg() path that reprograms MII_ADVERTISE never
run. Does the PHY then come back with reset-default advertisement and
EEE settings while phylib's cached state still claims the configured
values? For AX88279 the vendor 2.5G advertisement bit programmed by
asix_ax88279_config_aneg() in drivers/net/phy/ax88796b.c would be lost,
capping the link at 1G.

> +
> +	ax88179a_reset(dev);

[Severity: Medium]
ax88179a_reset() unconditionally rewrites AX_RX_CTL to the reset
default:

	ax179_data->rxctl = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_START |
			    AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;

That drops AX_RX_CTL_PRO and does not re-apply the multicast hash table
programmed by ax88179_set_multicast(). Neither ax88179a_resume() nor
usbnet_resume() re-invokes ndo_set_rx_mode.

Does a promiscuous interface (bridge port, macvlan, packet capture) stop
receiving foreign-destination frames after every resume, while
dev->flags still reports promiscuity? Should the resume path replay
ax88179_set_multicast()?

[Severity: Low]
Should the reset be skipped, or the receiver left off, when the netdev
is down? ax88179a_stop() clears AX_MEDIUM_RECEIVE_EN, writes
AX_RX_CTL = 0 and calls phylink_stop(), but a resume with the interface
down re-arms AX_RX_CTL_START and AX_MEDIUM_RECEIVE_EN here while
usbnet_resume() does not resubmit RX URBs because EVENT_DEV_OPEN is
clear. Does that leave the MAC receiving into its bulk-in FIFO with no
host consumer and no software owner?

> +
> +	if (netif_running(dev->net)) {
> +		rtnl_lock();
> +		phylink_resume(ax179_data->phylink);
> +		rtnl_unlock();
> +	}
> +
> +	ax88179_set_pm_mode(dev, false);
> +
> +	return usbnet_resume(intf);
> +}
> +

[ ... ]

> @@ -1040,7 +1129,11 @@ static int ax88179a_reset(struct usbnet *dev)
>  			     1, 1, &tmp) > 0)
>  		ax179_data->wol_supported = WAKE_MAGIC | WAKE_PHY;
>  
> -	phylink_start(ax179_data->phylink);
> +	/* ax88179a_reset() may also be called from resume context, phylink
> +	 * is already started, then.
> +	 */

[Severity: Low]
This isn't a bug, but does the comment match the code? When the netdev
is down, phylink is not started in resume context either, because
ax88179a_resume() only calls phylink_resume() under
if (netif_running(dev->net)). The gate itself behaves correctly in both
cases, but the stated rationale would mislead a later reader into
removing it.

Worth noting too that the gate reuses in_pm, whose only prior meaning
(ax88179_in_pm() in ax88179_lib.c) is selecting the *_nopm transfer
variants.

> +	if (!ax179_data->in_pm)
> +		phylink_start(ax179_data->phylink);
>  
>  	usbnet_link_change(dev, 0, 0);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
