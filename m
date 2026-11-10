Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274722;
	b=cMxavjSSZmKqCF+1QXce77rD+JhSR8tLzXY0IEzTtHe/RJGA+THp+UZTexBbtUq80AVs
	 GiCj+x6Jmj+tGsZywIEISYrFez2z3fHljg8+Z9MrKYTpiwMb2ET/USfgLxqALbtPTCxOk
	 iD4CEVpQkAK96aVMoKfE1qkq1VBGdi4FTliHZQzIDED1shNxpcH6PtAT5kfwxy2syIrR7
	 KIsHmBgtApCokjtd0JEAwTFlALHs7fG+6+eyJswynp7RvbI/cpgGDTm1hDbO19XU0s7fy
	 h1ORiNHwY4a8+rDH9lCj8xIjZnQwT80X+lVHsL5SVumDS70NQkyZ67WmYCyNs4ONc7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274722;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kyMu+c9WPiMfR1J/e9fy8+94zlLB1ydhIf2rwAsAFio=;
	b=amaOg55JYATnqWLoPpn6jlURvujI+RM1iEQaiADceKzD+MTgEvZ3d5G72cxN3kvZZGhK
	 QFW3Nji7cyWfIM+EEdxUf3YGA8igJG2ikySh4hVdkMSHFgvX+tZacGgGsuLck7zNEll1f
	 AYOA+KiJ1cA6usKWbYSexTvzUwb8Bqe0lw3c/aPLEEw8fLn/bLZ6TZAblSmTy7NI/PNF3
	 clOOx0iqbBrxVFs/MQl/3ZrT4zSdfeobwLWqYSSAdr5c03QrzPL26yp02o1AneELS+BZD
	 B3KqnhdcybFwiW5XfhoyWGtFN9AbhcdiAsbALzkm4agM4r73joc6dNCzJQi9JKtMVIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mx+vMoIn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8D60718A8;
	Tue, 10 Nov 2026 01:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mx+vMoIn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835181F00902;
	Tue, 10 Nov 2026 01:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274721;
	bh=kyMu+c9WPiMfR1J/e9fy8+94zlLB1ydhIf2rwAsAFio=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mx+vMoInE3WWH3V1gwwrzuhsAIHwBtBzyN4H0bLNzYVQFusoRTJ3SVl78gjePSCxJ
	 ASwye4TwzA+djXl2dNopc2bfHXN5B5JnJkN7WeaCuculFcm1YMPi/jFU1fo6CWTaYb
	 Ur//ZW7j/4filF/8RseKU1S9x7sg1hXpygFieXzqZ+WXiENE1fmmnZ7avIw2hUyDtr
	 8G5yMgUBX3KQ6hnKBgHoAKVCF3PzD+tovazHiga6zhQb/ZYZP9NNiwPAymhiultu4V
	 WQbYnVjfjsqQOOEgEoCigfCQQTO7auHr0yMXJpYLn4Yn400cCvpWTWrlaL81dPbk1r
	 zww9f4DCjyF8Q==
Subject: Re: [PATCH net-next v20 09/13] ax88179_178a: Add Suspend/resume
 support for AX88179A/772D/279
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:40 +0000
Message-ID: <179427472012.994134.9257520567051014453@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-9-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-9-37b5a1189983@birger-koblitz.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In ax88179a_reset(), the new `if (!ax179_data->in_pm)` guard
  (ax88179a_devices.c:1172-1175) skips the whole ax88179_get_mac_addr()…
- [Medium] On resume, ax88179a_reset() re-enables the hardware VLAN
  filter (AX_VLAN_CONTROL_VFE written to AX88179A_VLAN_ID_CONTROL,…
- [Medium] The series is not bisectable.
- [Medium] ax88179a_resume() calls ax88179a_reset() whether or not the
  interface is running (ax88179a_devices.c:207-224).
- [Medium] On every resume, ax88179a_resume() power-cycles the PHY
  through AX88179A_PHY_POWER: it writes 0 at line 221, sleeps 250 ms,…
- [Low] The patch turns off USB runtime PM (autosuspend) for every
  AX88179A/AX88772D/AX88279 device and the commit message does not say…
- [Low] In ax88179a_resume(), if the first control read of
  AX88179A_PHY_POWER fails (lines 207-209), the code jumps to err_out.
- [Low] ax88179a_reset() always arms magic-packet wake (AX_MONITOR_MOD =
  AX_MONITOR_MODE_RWMP, lines 1213-1217).
- [Low] In the WoL branch of ax88179a_suspend() (lines 168-170), the
  return value of ax88179_read_cmd(dev, AX_ACCESS_MAC,…

--

ax88179_178a: Add Suspend/resume support for AX88179A/772D/279

This patch adds per-chip suspend/resume function pointers to struct
ax88179_data and sends the usb_driver suspend/resume/reset_resume
callbacks through new wrappers in ax88179_lib.c. It implements
ax88179a_suspend() and ax88179a_resume() for the AX179A family. When
called from resume, ax88179a_reset() now skips the MAC address read and
phylink_start().

> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index f78ad344c1c4f..b077b7153f0c0 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c

[ ... ]

> @@ -1362,9 +1365,9 @@ static struct usb_driver ax88179_178a_driver = {
>  	.name =		"ax88179_178a",
>  	.id_table =	products,
>  	.probe =	usbnet_probe,
> -	.suspend =	ax88179_suspend,
> -	.resume =	ax88179_resume,
> -	.reset_resume =	ax88179_resume,
> +	.suspend =	ax88179_suspend_wrapper,
> +	.resume =	ax88179_resume_wrapper,
> +	.reset_resume =	ax88179_resume_wrapper,

[Severity: Medium]
Is the series bisectable at this point? From "ax88179_178a: Add HW support
for AX179A-based chips" through "ax88179_178a: Add AX179A/AX279 multicast
configuration", the AX179A-family products entries are bound to this
usb_driver. In those commits .suspend/.resume/.reset_resume still point
at the classic ax88179_suspend()/ax88179_resume().

In those intermediate commits, a system resume runs:

ax88179_resume()
  ax88179_reset()
    mii_nway_restart(&dev->mii)
      mii->mdio_read(...)

ax88179a_bind() never sets dev->mii.mdio_read. Wouldn't the first resume
of an AX88179A/772D/279 device then call a NULL function pointer?

This patch fixes that by sending AX179A devices to ax88179a_resume(), but
the commit message presents the patch only as a new feature. Could the
patches be reordered or merged so that no intermediate commit registers
these callbacks for the new chips? Could the changelog also mention the
fix?

>  	.disconnect =	ax88179_disconnect,
>  	.supports_autosuspend = 1,

[ ... ]

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index a6b0a3f47118c..01d6a35f68b2c 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c

[ ... ]

> @@ -126,6 +128,63 @@ static void ax88179a_status(struct usbnet *dev, struct urb *urb)
>  	phylink_mac_interrupt(data->phylink);
>  }
>  
> +static int ax88179a_suspend(struct usb_interface *intf, pm_message_t message)
> +{

[ ... ]

> +	/* Enable WoL */
> +	if (priv->wolopts) {
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, &tmp8);
> +		tmp8 &= ~(AX_MONITOR_MODE_RWLC | AX_MONITOR_MODE_RWMP);
> +		if (priv->wolopts & WAKE_PHY)
> +			tmp8 |= AX_MONITOR_MODE_RWLC;
> +		if (priv->wolopts & WAKE_MAGIC)
> +			tmp8 |= AX_MONITOR_MODE_RWMP;
> +
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, &tmp8);
> +
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);
> +		tmp16 |= AX_MEDIUM_RECEIVE_EN;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);

[Severity: Low]
What happens if this AX_MEDIUM_STATUS_MODE read fails? For size 2,
ax88179_read_cmd() starts with u16 buf = 0 and copies buf into *data even
on error, so tmp16 ends up as just AX_MEDIUM_RECEIVE_EN.

Writing that value back clears AX_MEDIUM_GIGAMODE, AX_MEDIUM_FULL_DUPLEX,
the flow control enables and AX_MEDIUM_JUMBO_EN. Meanwhile the PHY keeps
its link up for WoL.

Could the MAC medium mode then disagree with the link, so that wake frames
are not received? Should the return value be checked here?

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

[Severity: Low]
Is magic packet wake really turned off when WoL is disabled?
ax88179a_reset() always arms it:

	if (ax179_data->chip_version < AX_VERSION_AX88179A)
		*tmp = AX_MONITOR_MODE_PMETYPE | AX_MONITOR_MODE_PMEPOL | AX_MONITOR_MODE_RWMP;
	else
		*tmp = AX_MONITOR_MODE_RWMP;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, tmp);

AX_MONITOR_MOD is only rewritten here, inside if (priv->wolopts). The
chip therefore suspends with RWMP still set, even when ethtool reports
WoL as off.

For AX88179A/AX88772D, a WoL suspend also writes AX88179A_WAKEUP_SETTING
with EPHY_LOW_POWER_EN. The else branch only covers AX88279, and nothing
on resume clears the register.

For a running interface, phy_suspend() powers the PHY down, which hides
this. The PHY can still have link during a WoL-off suspend, for example
in the down-interface resume case below. If USB wakeup is enabled in
sysfs in that case, could a magic packet wake the host?

> +
> +	ax88179_set_pm_mode(dev, false);
> +	return 0;
> +}

[ ... ]

> @@ -135,6 +194,47 @@ static int ax88179a_auto_detach(struct usbnet *dev)
>  	return 0;
>  }
>  
> +static int ax88179a_resume(struct usb_interface *intf)
> +{
> +	struct usbnet *dev = usb_get_intfdata(intf);
> +	struct ax88179_data *ax179_data;
> +	u8 reg8 = 0;
> +	int ret;
> +
> +	ax179_data = dev->driver_priv;
> +	ax88179_set_pm_mode(dev, true);
> +
> +	ret = ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
> +	if (ret < 0)
> +		goto err_out;

[Severity: Low]
If this first read fails, the goto skips the AX_FW_MODE_179A write, the
PHY power cycle and all of ax88179a_reset(). err_out still calls
phylink_resume(), which in the non-WoL case starts phylink on hardware
that was never re-initialised. It then does:

	return usbnet_resume(intf);

usbnet_resume() always returns 0, so ret is lost. Would the interface then
look resumed but pass no traffic until it is brought down and up again?
Should the error be propagated here?

> +
> +	if (!(reg8 & AX_PHY_POWER)) {
> +		reg8 = AX_PHY_POWER;
> +		ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
> +		msleep(250);
> +	}
> +	ax88179_write_cmd(dev, AX_FW_MODE, AX_FW_MODE_179A, 0, 0, NULL);
> +
> +	/* Now, that AX_FW_MODE_179A is enabled, the PHY needs a power-cycle.
> +	 * PHY-power is re-enabled in ax88179a_reset()
> +	 */
> +	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, 0);
> +	msleep(250);

[Severity: Medium]
Does this unconditional power cycle lose the PHY configuration when WoL is
enabled? The comment suggests it resets the PHY registers to their
defaults: BMCR, MII_ADVERTISE (including AX_ADVERTISE_2500 on AX88279) and
the EEE advertisement.

With wolopts set, ax88179a_suspend() calls phylink_suspend(pl, true). That
takes the MAC WoL branch, which sets PHYLINK_DISABLE_MAC_WOL and does not
call phylink_stop(). On resume, phylink_resume() then only does:

		phylink_mac_initial_config(pl, true);
		phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_MAC_WOL);

It never reaches phylink_start()/phy_start(). ax88179a_init_phy() sets
phydev->mac_managed_pm, so MDIO bus PM does not call phy_init_hw() either.

Would the PHY then negotiate using its power-on defaults, while
phydev->advertising and the phylink EEE state still reflect what was set
with ethtool?

> +
> +	ax88179a_reset(dev);

[Severity: Medium]
Should this also be gated on netif_running()? Only phylink_resume() below
checks it. ax88179a_reset() powers the PHY, writes AX_RX_CTL_START, sets
AX_MEDIUM_RECEIVE_EN and arms AX_MONITOR_MODE_RWMP whether or not the
interface is up.

If the interface was down at suspend, ax88179a_stop() had left the
hardware like this:

	phylink_stop(ax179_data->phylink);
	...
	reg16 &= ~AX_MEDIUM_RECEIVE_EN;
	...
	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 0);

	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, 0);

After resume, the PHY is powered and can bring up a link with the peer,
and MAC RX is enabled, but phylink is not started. The new comment in
ax88179a_reset(), "phylink_resume() will start phylink, then", does not
hold for down interfaces.

A later suspend of the still-down interface does not power the PHY off
again. With USB wakeup enabled, could RWMP then wake the host while WoL
is off?

[Severity: Medium]
Is the VLAN filter table restored on this path? ax88179a_reset() turns
VFE back on whenever the feature is set:

	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
		*tmp |= AX_VLAN_CONTROL_VFE;

The per-VID bitmap, though, is only written by
ax88179a_vlan_rx_add_vid() and ax88179a_vlan_rx_kill_vid(), and the
driver keeps no software copy of it. ax88179a_set_features() also clears
all 256 entries when it enables the filter, which suggests the table
contents can't be relied on.

The chip can lose its registers across suspend, for example on
reset_resume or when VBUS is cut in S3. Would the hardware filter then
drop frames on the configured VLANs until the VIDs are added again?

> +
> +err_out:
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

[ ... ]

> @@ -802,6 +905,13 @@ static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
>  	if (ret)
>  		goto initphy_err;
>  
> +	/* Keep this interface runtime-PM active by taking a usage ref.
> +	 * Prevents runtime suspend while bound and avoids resume paths
> +	 * that could deadlock (autoresume under RTNL while USB PM lock
> +	 * is held, phylink/MDIO wants RTNL).
> +	 */
> +	pm_runtime_get_noresume(&intf->dev);

[Severity: Low]
This turns off USB autosuspend for every AX88179A/772D/279 device while it
is bound. The usage count only drops when ax88179a_unbind() calls
pm_runtime_put_noidle().

As the comment says, the new ax88179a_suspend()/ax88179a_resume() take
rtnl_lock() around the phylink calls. An autoresume under RTNL, such as
usbnet_open() -> usb_autopm_get_interface(), would therefore deadlock, so
the new callbacks only work for system sleep.

The commit message only talks about adding the suspend/resume wrappers.
Could it mention that runtime PM is disabled for the AX179A family, and
why? The shared ax88179_178a_driver also still sets
.supports_autosuspend = 1 without any note about this exception.

> +
>  	return 0;

[ ... ]

> @@ -1055,9 +1166,13 @@ static int ax88179a_reset(struct usbnet *dev)
>  	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_SWP_CTRL, 1, 0);
>  	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_TX_HDR_CKSUM, 1, 0);
>  
> -	/* Read MAC address from DTB or asix chip */
> -	ax88179_get_mac_addr(dev);
> -	memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
> +	/* Read MAC address from DTB or asix chip, except when called
> +	 * from resume context.
> +	 */
> +	if (!ax179_data->in_pm) {
> +		ax88179_get_mac_addr(dev);
> +		memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
> +	}

[Severity: Medium]
Does skipping ax88179_get_mac_addr() on resume also skip programming the
unicast address into the chip? ax88179_get_mac_addr() ends with:

	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN, ETH_ALEN,
			  dev->net->dev_addr);

That is the only AX_NODE_ID write on the reset path.

ax88179a_resume() rewrites AX_FW_MODE_179A and power-cycles the PHY, so
the driver seems to expect chip state to be lost, for example on
.reset_resume. In that case AX_NODE_ID would go back to the efuse
default. dev_addr, however, still holds a user-set address (from
ax88179_set_mac_addr()), a DT-provided address or the random fallback.

RX_CTL is programmed with AX_RX_CTL_AP and without AX_RX_CTL_PRO. Would
unicast frames to the interface's own MAC then be filtered out after
resume?

Could the AX_NODE_ID write of dev_addr be kept for the in_pm case, with
only the read/selection step skipped?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de
