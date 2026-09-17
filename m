Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44B43E094;
	Thu, 17 Sep 2026 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680294; cv=none; b=J3MOFeWLkYp3MMUhbv7J+RuwmFyarlWFo7QbLpvlx2PQGVj6cA/5QpIunwnrz9cczQ76VHA3wuHqltzpleJCtTZNBnPiibxChaPN+1oWWDCWaot+dXKYrYh60pPGB2xV1/n3JpxiyR/EEGZbuKJ9V9Wvj5jCg2A3QSa60sOeICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680294; c=relaxed/simple;
	bh=3BkZUvKbXo3gseQ3NiLk+TqrBhHyFg4iU2spdpXGSwM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lb3Khejkv+26uew2z2Fs/Y//WomNqdTlEoVXj+KLldg1ZQM1QqpanuE3Z6gSQ6rvNShGNcX1TuCsiSbTfx/EaQC+m2eelBLmsImmSH38EBNce7TbmSl4Upubuz8nCHeEklj8QL66Itt+twHGrn5btiBLKZWqvR5ValL6iJnHX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5e05E2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5e05E2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD011F00899;
	Thu, 17 Sep 2026 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680292;
	bh=xQN5Zi22qEu3fThZpOR9EXRBKcIQEi0pZoe7hDYvdxY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d5e05E2Tz7CcymC6kmo+2uxH5DkICyaOyEUQxSun4IWb6U6PAI/oEMKhtAqm2QN45
	 U3Vfqc6MxIo5/yIoqhg3BCZYg/34oTI72cN/Z9GzFqkQXhvtm5RXcYSJBwH/6bfMWX
	 o4ljI+alE+mqSd3lqMRfyUy7yFIXWPW5Dlc37E3xquWXvpK4/UnWlcQBfcQYOVJmCu
	 9u5Qau6nHERFmLFCaW4kuGxu5DA4MUuwz2pUJIcGqqwu3XAHRNu33YwAuo21u+LQY6
	 D2EinmAgba0pI570xFRjd6NtJruEI9xSBnyj/+SiiXFVM72GbeJDnj0iiqOCXZ5rRC
	 ouGPUvEjciBJw==
Subject: Re: [PATCH net-next v12 02/15] phylib: Add support for PHYs with
 broken forced mode
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:24:51 +0000
Message-ID: <178968029151.22033.7401061944066839860@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-2-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-2-60c04c9924a2@birger-koblitz.de>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0 (1)

- [High] NULL pointer dereference of `phydev->drv` in
  phy_ethtool_ksettings_set() (drivers/net/phy/phy.c:1193-1195).
- [Medium] Incomplete gating of PHY_BROKEN_FORCED: the new flag is
  consulted only in phy_ethtool_ksettings_set()…

Pre-existing issues:
- [Low] Concern that PHY_BROKEN_FORCED has no in-tree user, making the
  patch behaviorally inert (dead branch in phy_ethtool_ksettings_set())…

--

phylib: Add support for PHYs with broken forced mode

Adds a PHY_BROKEN_FORCED driver flag and makes
phy_ethtool_ksettings_set() reject AUTONEG_DISABLE requests with
-EOPNOTSUPP for drivers that set it.  The stated goal is to avoid the
WARN and stack trace in the PHY state machine when config_aneg()
returns -EOPNOTSUPP for forced modes.

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index fce9bc7be3304..b83f938fe7c3b 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1190,6 +1190,10 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
>  	      duplex != DUPLEX_FULL)))
>  		return -EINVAL;
>  
> +	if (autoneg == AUTONEG_DISABLE &&
> +	    (phydev->drv->flags & PHY_BROKEN_FORCED))
> +		return -EOPNOTSUPP;
> +

[Severity: High]
Can phydev->drv be NULL here?

The rest of phylib treats a NULL drv as a reachable state while the
phy_device is still attached to a netdev.  phy_remove() in
phy_device.c ends with:

	phydev->drv = NULL;

without detaching the PHY from the netdev, so ndev->phydev and
phydev->attached_dev stay set after a driver unbind through
/sys/bus/mdio_bus/drivers/<drv>/unbind.

The callee a few lines below in this same function guards for exactly
that:

drivers/net/phy/phy.c:_phy_start_aneg() {
	lockdep_assert_held(&phydev->lock);

	if (!phydev->drv)
		return -EIO;
	...
}

and so do phy_config_inband() and phy_ethtool_nway_reset().  The entry
point does not:

drivers/net/phy/phy.c:phy_ethtool_set_link_ksettings() {
	if (!phydev)
		return -ENODEV;

	return phy_ethtool_ksettings_set(phydev, cmd);
}

So for "ethtool -s <dev> autoneg off speed 100 duplex full" after a PHY
driver unbind, does this new test dereference a NULL phydev->drv and turn
the previous -EIO return into an oops?

There is a second aspect: the read is also outside mutex_lock(&phydev->lock),
and phy_remove() clears the pointer without holding phydev->lock or rtnl, so
moving the test under the mutex would not close the window either.  Would an
explicit check be preferable, e.g.

	if (autoneg == AUTONEG_DISABLE && phydev->drv &&
	    (phydev->drv->flags & PHY_BROKEN_FORCED))
		return -EOPNOTSUPP;

or an early "if (!phydev->drv) return -EIO;" matching the convention used
elsewhere in this file?

[Severity: Medium]
Is phy_ethtool_ksettings_set() the only path that commits AUTONEG_DISABLE?

The SIOCSMIIREG handler in phy_mii_ioctl() also writes forced mode with no
PHY_BROKEN_FORCED test:

drivers/net/phy/phy.c:phy_mii_ioctl() {
	...
		case MII_BMCR:
			if ((val & (BMCR_RESET | BMCR_ANENABLE)) == 0) {
				if (phydev->autoneg == AUTONEG_ENABLE)
					change_autoneg = true;
				phydev->autoneg = AUTONEG_DISABLE;
	...
		mdiobus_write(phydev->mdio.bus, prtad, devad, val);
	...
		if (change_autoneg)
			return phy_start_aneg(phydev);
}

For a PHY flagged PHY_BROKEN_FORCED whose config_aneg() returns
-EOPNOTSUPP (asix_ax88279_config_aneg(), added later in this series),
phy_start_aneg() -> _phy_start_aneg() -> phy_config_aneg() fails and the
error reaches the ioctl caller, but neither the BMCR write nor
phydev->autoneg = AUTONEG_DISABLE is rolled back.

On the next transition to PHY_UP (ifdown/ifup, link flap, cable test exit),
does the state machine then hit the same WARN this patch aims to remove?

drivers/net/phy/phy.c:_phy_state_machine() {
	if (state_work == PHY_STATE_WORK_ANEG) {
		err = _phy_start_aneg(phydev);
		func = &_phy_start_aneg;
	}
	...
	if (err < 0)
		phy_error_precise(phydev, func, err);
}

phy_mii_ioctl() is exported and wired as ndo_eth_ioctl by a number of MAC
drivers, directly or via phy_do_ioctl_running().  For the device in this
series the MAC routes ndo_eth_ioctl to phylink_mii_ioctl(), whose
SIOCSMIIREG case uses phylink_phy_write() and does not touch
phydev->autoneg, so that particular combination does not reach the WARN
today.  Would placing the gate where autoneg is actually committed, in
_phy_start_aneg() or phy_config_aneg(), cover both entry points?

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 5f8d65868e0ff..d5f8e527ce8df 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -64,6 +64,7 @@ extern const int phy_basic_ports_array[3];
>  #define PHY_RST_AFTER_CLK_EN	0x00000002
>  #define PHY_POLL_CABLE_TEST	0x00000004
>  #define PHY_ALWAYS_CALL_SUSPEND	0x00000008
> +#define PHY_BROKEN_FORCED	0x00000010

[Severity: Low]
This isn't a bug introduced by this patch, but a note on flag adoption.

The value 0x10 does not collide with any existing PHY_* flag, and there is
an in-tree user by the end of the series: drivers/net/phy/ax88796b.c sets

	.flags		= PHY_IS_INTERNAL | PHY_BROKEN_FORCED,

on the AX88279 entry, whose asix_ax88279_config_aneg() returns -EOPNOTSUPP
for AUTONEG_DISABLE, so the new branch is not dead code.

Two existing drivers already reject forced mode in their config_aneg()
without setting the new flag, bcm84881_config_aneg() and
en8811h_config_aneg().  That is pre-existing behaviour and not changed
here; would converting them be a reasonable follow-up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
