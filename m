Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1613B5311;
	Wed, 16 Sep 2026 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541247; cv=none; b=NF6w6IXi5wvwmarwndXEkqnxDvM/z9ab/3+Hg+zPYc+5vfjRJgyNemtwpaG5wCUTmDIxgKjunFkYVOKSqvB0n0OS+Gr3QxawgDEWLOPhJYy3synEod43G+eNYsmglqyzMeUSY55m6B75lgk8W2mJMWrKZFVPKi7MvBfo+uQ/FuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541247; c=relaxed/simple;
	bh=mlF+i72OzpEtkzREIbY4bFMOqWf7D0Fp+0IMMxJoljQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y/dgJl9jP3VCkycUSMtFDzRYWDUhTXaYe9S2mF+s28+4TVZ+x7INjHKQvgqtZjt3kOE6nz0qbFsr8+ykPLN+NI/DQXqBj9S7vLBLOOhwnKJ1Kz2UOoHgBHQbD9YixYtnctaaT0jPVd1sPErJ/I2CIgQwsS62l+kztZ57QH+xwZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fye+/abV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fye+/abV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ADD1F00893;
	Wed, 16 Sep 2026 06:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541245;
	bh=RNPVe0hc4QhaA3yuixaVGIOZjonP8+xkZtAy84eN4RQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fye+/abVHLkEiTc5r6GfytCwj2Vqm/fl+90h6mCNdhRvTxNWXU6KRBx7ns97MJPqU
	 IcFAAJZbypErtYbjV987lKLXfABwbCnm91Jnonkg2uK2Q28KYtSRJRdhJiyHsMtp8t
	 aTObrIlDP7NeNMrqHYDCyg4TtFtaJvvTyOHYQoDXH+Fx2Ah7vvWmBXUs4OKG6yVQa0
	 nspfDQAN8qBT3PfdKYkuPAbwaeA8xb8xUmITTJA0XRPZxSEvcljoo04RmaK44lEzUJ
	 9rAuOmXg/rshrfjADNTAxp6Fa5L1aurFGw85GnSBzDHphj2CNJTZjuAPMI+4BqZUfV
	 j38pIQqkR9Dmg==
Subject: Re: [PATCH net-next v11 02/15] phylib: Add support for PHYs with
 broken forced mode
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:24 +0000
Message-ID: <178954124461.22033.3182310722300009473@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-2-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-2-5ea7a925ba6d@birger-koblitz.de>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] NULL pointer dereference of `phydev->drv` in
  `phy_ethtool_ksettings_set()` (drivers/net/phy/phy.c:1193-1195).
- [Medium] Incomplete gate: the PHY_BROKEN_FORCED rejection is placed
  only in `phy_ethtool_ksettings_set()`…
- [Low] At this commit, PHY_BROKEN_FORCED has no in-tree initializer: a
  tree-wide search at 0a4f5bfb finds it only in its definition…

--

phylib: Add support for PHYs with broken forced mode

This adds a new phy_driver flag, PHY_BROKEN_FORCED, for PHYs that only
support auto-negotiated speed modes, and makes
phy_ethtool_ksettings_set() reject AUTONEG_DISABLE for such PHYs with
-EOPNOTSUPP instead of letting config_aneg() fail inside the state
machine.

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

[Severity: High]

Can phydev->drv be NULL here?

This is the first and only dereference of phydev->drv in
phy_ethtool_ksettings_set(), and it happens before
mutex_lock(&phydev->lock) and without the !phydev->drv test that the
other drv consumers in this file use.  phy_remove() in phy_device.c
clears it while the phy_device stays alive and attached:

drivers/net/phy/phy_device.c:phy_remove() {
	...
	phydev->drv = NULL;
	...
}

The entry point does not filter that state either:

drivers/net/phy/phy.c:phy_ethtool_set_link_ksettings() {
	...
	if (!phydev)
		return -ENODEV;

	return phy_ethtool_ksettings_set(phydev, cmd);
}

So after unbinding the PHY driver through
/sys/bus/mdio_bus/drivers/<drv>/unbind, does
"ethtool -s <dev> autoneg off speed 100 duplex full" reach the new
phydev->drv->flags read with drv == NULL?  Before this patch the same
input was turned into -EIO further down the same call path:

drivers/net/phy/phy.c:_phy_start_aneg() {
	lockdep_assert_held(&phydev->lock);

	if (!phydev->drv)
		return -EIO;
	...
}

Would it make sense to add the same !phydev->drv check, or move the
test under phydev->lock?  Note the store in phy_remove() is done with
neither phydev->lock nor rtnl held, so a concurrent unbind can also
make this read observe a stale driver pointer.

[Severity: Medium]

Does this cover all the paths that latch forced mode?  The other core
phylib entry point still sets AUTONEG_DISABLE without consulting the
new flag:

drivers/net/phy/phy.c:phy_mii_ioctl() {
	...
			case MII_BMCR:
				if ((val & (BMCR_RESET | BMCR_ANENABLE)) == 0) {
					if (phydev->autoneg == AUTONEG_ENABLE)
						change_autoneg = true;
					phydev->autoneg = AUTONEG_DISABLE;
	...
}

The raw BMCR write with ANENABLE cleared goes through, phy_start_aneg()
returns the driver's -EOPNOTSUPP to the ioctl caller, but nothing rolls
back phydev->autoneg, speed or duplex.

A later transition to PHY_UP (for example "ip link set dev X down"
followed by "ip link set dev X up") then runs
_phy_state_machine() -> _phy_start_aneg() -> phy_config_aneg() with
autoneg still AUTONEG_DISABLE, gets -EOPNOTSUPP again, and ends in:

drivers/net/phy/phy.c:phy_error_precise() {
	WARN(1, "%pS: returned: %d\n", func, err);
	...
}

Is that not the same warning and stack trace within the state machine
that the commit message says is prevented?  Would placing the check at
a single choke point such as _phy_start_aneg() or phy_config_aneg(), or
rejecting the BMCR write, close both ABI paths?

For reference, the -EOPNOTSUPP producer added later in this series is
asix_ax88279_config_aneg() in drivers/net/phy/ax88796b.c:

	if (phydev->autoneg == AUTONEG_DISABLE) {
		phydev_warn(phydev, "Disabling autoneg is not supported\n");
		return -EOPNOTSUPP;
	}

That PHY is driven through phylink, where SIOCSMIIREG is handled by
phylink_mii_ioctl()/phylink_phy_write() rather than phy_mii_ioctl(), so
an end-to-end trigger with in-tree hardware was not demonstrated; MACs
using phylib directly (phy_do_ioctl*/phy_mii_ioctl) do reach it.

>  	mutex_lock(&phydev->lock);
>  	phydev->autoneg = autoneg;
>  
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

At this commit PHY_BROKEN_FORCED has no in-tree initializer, so
phydev->drv->flags & PHY_BROKEN_FORCED is always false and the new
early return is not reachable yet, while the commit message is worded
as a behavioural fix:

    This prevents a kernel warning and stack-trace within the
    phy_state_machine when PHYs return -EOPNOTSUPP from config_aneg()

The consumer arrives later in the same series, in "ax88796b: Add
support for AX88772D, AX88179A and AX88279", which sets
.flags = PHY_IS_INTERNAL | PHY_BROKEN_FORCED for the AX88279.  Could
the wording say that the flag takes effect with that later patch?

Separately, and not something introduced here: two existing PHYs that
also reject forced mode still signal it only by returning an error from
config_aneg() rather than through a flag:

drivers/net/phy/air_en8811h.c:en8811h_config_aneg() {
	if (phydev->autoneg == AUTONEG_DISABLE) {
		phydev_warn(phydev, "Disabling autoneg is not supported\n");
		return -EINVAL;
	}
	...
}

drivers/net/phy/bcm84881.c:bcm84881_config_aneg() {
	/* disabled autoneg doesn't seem to work with this PHY */
	if (phydev->autoneg == AUTONEG_DISABLE)
		return -EINVAL;
	...
}

Should these be converted to the new flag so there is one convention
for the same hardware property?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
