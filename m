Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA535F5FB;
	Wed,  2 Sep 2026 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327404; cv=none; b=JmhJ7JP2LGMbb+OFvk/jdr1pBkUSKl6JIJFz3X+mUiUtL0im9SqGITzMoBSbnlkw5bPL/dV8ndbmyHEGawuenAfAS3VXjqKTCHeFUXhMhqryNtpB2w85E/G6UFKS5BFnU7UPYE1cxNDw1uTJgzoozfHwXCxzCoxaDAs+yQAbISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327404; c=relaxed/simple;
	bh=8HMjlCwMh0CXk4cvo4FTOIJWTPqfFE2XtgDlQbB/n18=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xdyg9+lHlneO+SfnwQw2XNzJ9yRtXu658ghAcOBzLTJc6CJVdjewjwhm3a9Vf5PgcYx3cEIoLF7edsSCicNs7rD5JJrfBWFR5swdw7lEn5t/Q4b1M5AztYnIrgitE0lEX4GY5POZ0Z9uIOARqEizv/H2aEBCcl0vvPt5UigBACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVMyKz3a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVMyKz3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0D31F00A3D;
	Wed,  2 Sep 2026 05:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327403;
	bh=8B+Qlo+5HvyZp5h5CwqzpayXgYXYCXg873b4jyDPfkQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fVMyKz3aON6NuiDcMOsQEGR9dYSazv/S3woHI5L5V64Q/WHSiYuBqqKSr471XuhGF
	 CPCmn9vmqDlsmcRNBAsC5AVFcDpEIx7ZXhU3gnhuRaKRPSyKBbBdvMJtbn40F7OndN
	 9EKfdVy/0bYvKyfgW6kYCwXJ9iAaVaoTCH1uOZnam8h/Kw0qWwqZmNK2PDz+zfc1gw
	 k66W3e/Z1wdhN4Msx29WQ6GHwBsUmgO64YuzrYVnV1i/NQXVN3HAi4G0gDjJrYmgPM
	 Rl0oMtVwPeFjvLTXh4VVd12isxwJI0gjOEISnARJWUC69GO2HoeiPSta6lHGgsQJyM
	 OhxL5xb/K5wRw==
Subject:
 Re: [net-next,v15,08/13] net: mdio: realtek-rtl9300: Add page tracking
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 05:36:41 +0000
Message-ID: <178832740195.3394541.12369181015153129157@kernel.org>
In-Reply-To: <20260831143439.2404484-9-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-9-markus.stockhausen@gmx.de>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 3

- [Low] The commit fixes a pre-existing, user-visible malfunction (before
  this patch all C22 commands used RAW_PAGE, i.e. the page write and the…
- [Low] The new C22 attachment gate treats the single encoded vendor
  value 0x001cc800 as covering every Realtek PHY:…
- [Low] The new register-31 interception and its page-range validation
  are keyed on an exact equality test (`regnum == RTL_PAGE_SELECT`)…

--

net: mdio: realtek-rtl9300: Add page tracking

This intercepts Clause 22 accesses to PHY register 31 in the rtl9300 MDIO
driver, caches the selected page per port in priv->page[], and folds that
page into the MAIN_PAGE field of every hardware C22 command. It also resets
the cached page on attach/detach and rejects non-Realtek PHYs on a C22 bus.

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index a925640290cb0..d6027062e452f 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c

Before the diff, one question about the changelog:

>     This makes access to PHYs a gamble.

[Severity: Low]
Should this carry a Fixes: tag?

Prior to this patch all four C22 command builders used
FIELD_PREP(..._MAIN_PAGE, RAW_PAGE(priv)), so a page write and the
following register access were separate unpaged transactions that the
hardware poller can interleave. That is the user-visible malfunction the
changelog describes, and it is present in released code.

The core of the fix, the register 31 interception in otto_emdio_read_c22()
and otto_emdio_write_c22() plus passing priv->page[port] into the command,
does not depend on the notify_phy_attach()/notify_phy_detach()
infrastructure added earlier in this series; only the page reset and the
vendor gate do. Another patch in the same series ("net: mdio:
realtek-rtl9300: suppress sysfs bind/unbind attributes") does carry
Fixes: 24e31e4747698, so could the changelog state whether a stable
backport is intended here, or why it is not possible?

> @@ -179,6 +179,9 @@
>  #define PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
>  #define PHY_CTRL_MMD_REG			GENMASK(15, 0)
>  
> +#define RTL_VENDOR_ID				0x001cc800
> +#define RTL_PAGE_SELECT				31
> +
>  #define MAP_ADDRS_PER_REG			6
>  #define MAP_BITS_PER_ADDR			5
>  #define MAP_BITS_PER_BUS			2
> @@ -204,6 +207,7 @@ struct otto_emdio_priv {
>  	struct regmap *regmap;
>  	struct mutex lock; /* protect HW access */
>  	DECLARE_BITMAP(valid_ports, MAX_PORTS);
> +	u16 page[MAX_PORTS];
>  	u8 smi_bus[MAX_PORTS];
>  	u8 smi_addr[MAX_PORTS];
>  	bool smi_bus_is_c45[MAX_SMI_BUSSES];

[ ... ]

> @@ -369,7 +373,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *bus, int port, int regnum,
>  	struct otto_emdio_cmd_regs cmd_data = {
>  		.c22_data	= FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
>  				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
> -				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
> +				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
>  		.io_data	= FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
>  		.port_mask_low	= BIT(port),
>  	};

[ ... ]

> @@ -473,8 +477,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
>  	if (port < 0)
>  		return port;
>  
> -	scoped_guard(mutex, &priv->lock)
> +	scoped_guard(mutex, &priv->lock) {
> +		if (regnum == RTL_PAGE_SELECT)
> +			return priv->page[port];
> +
>  		ret = priv->info->read_c22(bus, port, regnum, &value);
> +	}
>  
>  	return ret ? ret : value;
>  }
> @@ -495,8 +503,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, int phy_id, int regnum,
>  	if (port < 0)
>  		return port;
>  
> -	scoped_guard(mutex, &priv->lock)
> +	scoped_guard(mutex, &priv->lock) {
> +		if (regnum == RTL_PAGE_SELECT) {
> +			if (value >= RAW_PAGE(priv))
> +				return -EINVAL;
> +
> +			priv->page[port] = value;
> +			return 0;
> +		}
> +
>  		ret = priv->info->write_c22(bus, port, regnum, value);
> +	}
>  
>  	return ret;
>  }

[Severity: Low]
Can a regnum whose low five bits are 31 slip past this interception and
reach the real hardware register 31?

The tests in otto_emdio_read_c22() and otto_emdio_write_c22() are exact
equality checks, and neither function bounds-checks regnum against the
5-bit C22 register space. The command builders then truncate it, for
example in otto_emdio_9300_write_c22():

	.c22_data = FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR /* GENMASK(24,20) */, regnum) | ...

__FIELD_PREP() in include/linux/bitfield.h masks the shifted value at
runtime; the BUILD_BUG_ON range check only fires for compile-time
constants. So regnum 63, 95, ... 0xffff become an access to register 31
while skipping both the interception and the value >= RAW_PAGE(priv)
guard.

Register numbers arrive unfiltered from userspace:

  phy_mii_ioctl()            /* SIOCSMIIREG, raw __u16 mii_data->reg_num */
    mdiobus_write()
      __mdiobus_write()      /* only checks addr >= PHY_MAX_ADDR */
        otto_emdio_write_c22()
          otto_emdio_9300_write_c22()

With regnum = 63 the -EINVAL guard that deliberately forbids selecting the
raw page (4095/8191) no longer applies, and the PHY can be parked on the
raw page that the changelog describes as making access "a gamble". The same
equality-only pattern applies to the MII_MMD_CTRL/MII_MMD_DATA rejection
added by "net: mdio: realtek-rtl9300: deny C45 over C22 access", where
regnum 45/46 alias to 13/14. Would rejecting regnum > 0x1f before
dispatching be preferable?

> @@ -607,8 +624,9 @@ static int otto_emdio_9310_setup_controller(struct otto_emdio_priv *priv)
>  
>  static int otto_emdio_notify_phy_attach(struct phy_device *phydev)
>  {
> -	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(phydev->mdio.bus);
>  	int port = otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr);
> +	struct otto_emdio_chan *chan = phydev->mdio.bus->priv;
> +	struct otto_emdio_priv *priv = chan->priv;
>  
>  	if (port < 0) {
>  		/* All subsequent bus operations will fail */
> @@ -616,6 +634,16 @@ static int otto_emdio_notify_phy_attach(struct phy_device *phydev)
>  		return port;
>  	}
>  
> +	/* "sync" page in case of previously failed attachment */
> +	scoped_guard(mutex, &priv->lock)
> +		priv->page[port] = 0;
> +
> +	if (!priv->smi_bus_is_c45[chan->mdio_bus] &&
> +	    !phy_id_compare_vendor(phydev->phy_id, RTL_VENDOR_ID)) {
> +		phydev_err(phydev, "Only Realtek PHYs allowed on C22 bus\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	return otto_emdio_set_port_polling(priv, port, true);
>  }

[Severity: Low]
Does this gate reject some Realtek PHYs?

phy_id_compare_vendor() in include/linux/phy.h compares bits 31:10:

	#define PHY_ID_MATCH_VENDOR_MASK GENMASK(31, 10)
	...
	static inline bool phy_id_compare_vendor(u32 id, u32 vendor_mask)
	{
		return phy_id_compare(id, vendor_mask, PHY_ID_MATCH_VENDOR_MASK);
	}

Realtek parts using the legacy, non-OUI ID encoding do not match
0x001cc800. realtek_drvs[] in drivers/net/phy/realtek/realtek_main.c has:

		PHY_ID_MATCH_EXACT(0x00008201),
		.name		= "RTL8201CP Ethernet",
		.read_page	= rtl821x_read_page,
		.write_page	= rtl821x_write_page,

0x00008201 masked with GENMASK(31, 10) is 0x00008000, so the comparison
fails and attachment aborts with -EOPNOTSUPP, leaving the port unusable,
even though that PHY uses register 31 as page select and therefore fits the
emulation added here.

No in-tree DT currently puts such a PHY on one of these SMI buses, so this
looks unlikely to be hit in practice, but should the check also accept the
legacy Realtek ID range so it matches the intent in its own error message?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831143439.2404484-1-markus.stockhausen%40gmx.de
