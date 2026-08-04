Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091403E49FE;
	Tue,  4 Aug 2026 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808124; cv=none; b=WPtHd1xlbwmc6P6Z6YSEs5Z7TbBImLdll1X8Psa6QbyHuySYvPjXMlNt1IYwOjtJe9xlZDUohMziObvPaAbcOE2lLebAdycvY0kWcF/rlml5mOaDj+ElIm/WcEPQqaIb4onSBoYYpVvVIyg3EQUXJOnGen41GRBGBeM+0DXqPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808124; c=relaxed/simple;
	bh=2R0GdeCveOI6ycPkaBvvXhhhbVKycxo+5eqIDVJr+9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQWGyTqsRy1nsYyDapXzk2amcAacbwkH2NRcEFUIGBw6Hba8aJtuTmDYgVEKYoHJ+2nek7yMgn+9kkDKWNDUDjkYh58Yze5C9n/gGRjGHUs6Tks9kLLjlbylLjPgi8NOAlneKl/ucWOwW76nQTuc+HW0wAA1XtI88fKm9gw875Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK+HN69D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK+HN69D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1EF1F000E9;
	Tue,  4 Aug 2026 01:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785808122;
	bh=o5/uLZyoO7BQy8ea5qK4bo3MMlgsiikC/QCBoEBBC6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gK+HN69DfaozHJWy+merVq2UzVmVk/cuj+RfYX8roDLlnCPE4sUO0y54JfptdoaGp
	 3bV0pY2TaDRmS9gwk40AXDK3riCfuxfwKbRUnrPKq9zgVFDWhl68FZYdKqAEsMIYp/
	 94upRIA6Xhq1z/ayz62v3zG9wgRz8wJJICl6e9CVHcBwYq0mX5NSqWoUNax/x47OVa
	 a6u4TKpqwN219Tn3hWUpRPMNcKWwty/me0IwVg21vwebUxLa7lFKlHOkoyPRh5lTbq
	 sEbODj+ubWlV2uob+UiLyZzIOJdxNT0uSYombiNunYLB/uu+DnU2vjCF77tNr6l53U
	 qo2B78D63wtXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: alexander.duyck@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mike.marciniszyn@gmail.com,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	jiawenwu@trustnetic.com,
	kees@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	mengyuanlou@net-swift.com,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com
Subject: Re: [net-next PATCH v4 2/4] net: pcs: xpcs: Allow for multiple addr in creation
Date: Mon,  3 Aug 2026 18:48:30 -0700
Message-ID: <20260804014830.2532522-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178536366014.250758.7525172425951669429.stgit@ahduyck-xeon-server.home.arpa>
References: <178536366014.250758.7525172425951669429.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [2]: [net-next PATCH v4 2/4] net: pcs: xpcs: Allow for multiple addr in creation ---
commit 659d2ab0068099d84cd67aa41fc9d8519508054c
Author: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>

net: pcs: xpcs: Allow for multiple addr in creation

This extends xpcs_create_data(), xpcs_create() and xpcs_free_data() to take
an array of mdio devices, adds a new exported xpcs_create_pcs_mdiodevs()
entry point, and switches fbnic over to registering two MDIO addresses.  A
new xpcs->channels field records how many mdio devices were provisioned.

A few questions below on the new multi-channel plumbing and the
kernel-doc/changelog wording.

The changelog says:

    Add xpcs_create_mdiodevs() and xpcs_create_pcs_mdiodevs calls so that a
    driver using the above part can tell xpcs the addr values in one call.

xpcs_create_mdiodevs() is added as static, with no EXPORT_SYMBOL_GPL and no
declaration in include/linux/pcs/pcs-xpcs.h, so a driver that needs the
struct dw_xpcs handle (the xpcs_create_mdiodev() users) still cannot pass
more than one address.  Should the changelog only mention
xpcs_create_pcs_mdiodevs() as the driver-facing addition?

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
> index 09c5225111be3..88fc78d55c7a5 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
> @@ -200,9 +200,11 @@ int fbnic_phylink_create(struct net_device *netdev)
>  	struct fbnic_dev *fbd = fbn->fbd;
>  	struct phylink_pcs *pcs;
>  	struct phylink *phylink;
> +	/* See fbnic_mdio.c addr usage */
> +	int addrs[] = { 0, 1 };
>  	int err;
>  
> -	pcs = xpcs_create_pcs_mdiodev(fbd->mdio_bus, 0);
> +	pcs = xpcs_create_pcs_mdiodevs(fbd->mdio_bus, addrs, ARRAY_SIZE(addrs));
>  	if (IS_ERR(pcs)) {
>  		err = PTR_ERR(pcs);
>  		dev_err(fbd->dev, "Failed to create PCS device: %d\n", err);

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 6a645df58f9b8..a6b993745f3be 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -214,9 +214,18 @@ int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg)
>  	return mdiodev_c45_read(xpcs->mdiodev[0], dev, reg);
>  }
>  
> +static int
> +xpcs_mdev_write_ch(struct dw_xpcs *xpcs, int ch, int dev, u32 reg, u16 val)
> +{
> +	if (ch >= xpcs->channels)
> +		return -ENXIO;
> +
> +	return mdiodev_c45_write(xpcs->mdiodev[ch], dev, reg, val);
> +}
> +
>  int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val)
>  {
> -	return mdiodev_c45_write(xpcs->mdiodev[0], dev, reg, val);
> +	return xpcs_mdev_write_ch(xpcs, 0, dev, reg, val);
>  }
>  
>  int xpcs_modify(struct dw_xpcs *xpcs, int dev, u32 reg, u16 mask, u16 set)

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5]
Only the write path becomes channel aware here.  xpcs_read(),
xpcs_modify(), xpcs_modify_changed() and the
phylink_mii_c45_pcs_get_state(xpcs->mdiodev[0], ...) call in
xpcs_get_state_c73() stay pinned to mdiodev[0], and no per-channel read or
read-modify-write helper appears later in the series either (checked at
7b16dc0f9f78, where xpcs_write_pcs_ch() and xpcs_mdev_write_ch() are the
only channel-aware accessors).

For fbnic, addr 1 is a distinct register page:

drivers/net/ethernet/meta/fbnic/fbnic_mdio.c maps addr 0/1 onto
FBNIC_PCS_PAGE(addr), described as allowing access to both halves of the
PCS for the 50R2 config.

So in the two-instance modes (PHY_INTERFACE_MODE_LAUI and
PHY_INTERFACE_MODE_100GBASEP, both with .channels = 2), instance 1 gets the
vendor writes from xpcs_config_rsfec_pma() later in the series, but:

xpcs_pre_config() -> xpcs_soft_reset() -> xpcs_modify() -> mdiodev[0]
xpcs_get_state_c73() -> xpcs_read(MDIO_STAT1/STAT2) -> mdiodev[0]

Does instance 1 need its own soft reset for those vendor writes to latch,
and should its fault/alignment status be folded into the state reported to
phylink?  As written, a faulted or unreset second half would not be visible.

> @@ -1507,16 +1516,21 @@ static int xpcs_identify(struct dw_xpcs *xpcs)

[ ... ]

> @@ -1610,25 +1627,24 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
>  	return ERR_PTR(ret);
>  }
>  
> -/**
> - * xpcs_create_mdiodev() - create a DW xPCS instance with the MDIO @addr
> - * @bus: pointer to the MDIO-bus descriptor for the device to be looked at
> - * @addr: device MDIO-bus ID
> - *
> - * Return: a pointer to the DW XPCS handle if successful, otherwise -ENODEV if
> - * the PCS device couldn't be found on the bus and other negative errno related
> - * to the data allocation and MDIO-bus communications.
> - */
> -struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr)
> +static struct dw_xpcs *
> +xpcs_create_mdiodevs(struct mii_bus *bus, const int *addrs, int channels)
>  {
> -	struct mdio_device *mdiodev;
> +	struct mdio_device *mdiodev[DW_XPCS_MAX_CHANNELS], *rval;
>  	struct dw_xpcs *xpcs;
> +	int i;
> +
> +	if (!addrs || channels <= 0 || channels > DW_XPCS_MAX_CHANNELS)
> +		return ERR_PTR(-EINVAL);

[ ... ]

> +/**
> + * xpcs_create_pcs_mdiodevs() - create a DW xPCS instance with multiple @addrs
> + * @bus: pointer to the embedded phylink PCS instance

[Severity: Low]
[Finding: main-1-4]
[Sources: opus-5]
Should @bus be described as the MDIO-bus descriptor, as the existing
xpcs_create_mdiodev() kernel-doc does?  It is a struct mii_bus * that gets
handed to mdio_device_create(bus, addrs[i]); the embedded phylink PCS is
what the function returns.

> + * @addrs: an array of int
> + * @channels: the number of addrs items or channels
> + *
> + * Return: a pointer to the phylink PCS if successful, otherwise -ENODEV if
> + * the PCS device couldn't be found on the bus and other negative errno related
> + * to the data allocation and MDIO-bus communications.
> + */

[Severity: Low]
[Finding: main-1-4]
[Sources: opus-5]
Could the Return: section also mention -EINVAL?  The new check in
xpcs_create_mdiodevs():

	if (!addrs || channels <= 0 || channels > DW_XPCS_MAX_CHANNELS)
		return ERR_PTR(-EINVAL);

is reachable through this exported wrapper, but only -ENODEV and
allocation/MDIO errors are listed.  Both wording issues are still present at
the end of the series (7b16dc0f9f78).

> +struct phylink_pcs *
> +xpcs_create_pcs_mdiodevs(struct mii_bus *bus, const int *addrs, int channels)
> +{
> +	struct dw_xpcs *xpcs;
> +
> +	xpcs = xpcs_create_mdiodevs(bus, addrs, channels);
> +	if (IS_ERR(xpcs))
> +		return ERR_CAST(xpcs);
> +
> +	return &xpcs->pcs;
> +}
> +EXPORT_SYMBOL_GPL(xpcs_create_pcs_mdiodevs);

[ ... ]

> diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
> index 5c804cfd47d3c..36f4906e689a8 100644
> --- a/drivers/net/pcs/pcs-xpcs.h
> +++ b/drivers/net/pcs/pcs-xpcs.h
> @@ -114,6 +114,7 @@ struct dw_xpcs {
>  	struct mdio_device *mdiodev[DW_XPCS_MAX_CHANNELS];
>  	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
>  	struct phylink_pcs pcs;
> +	int channels;

[Severity: Low]
[Finding: main-1-2]
[Sources: opus-5]
This isn't a bug, but the name channels now carries two different meanings
in this driver.  Here it counts the MDIO devices a driver provisioned, while
struct pma_pcs_values::channels in pcs-xpcs.c counts the PCS instances the
active link mode uses (.channels = 1 for 25GBASER/50GBASER, .channels = 2
for LAUI/100GBASEP).

fbnic_phylink_create() passes addrs[] = { 0, 1 } before any interface is
selected, so xpcs->channels is 2 even in the single-instance modes fbnic
also advertises.  The bound in xpcs_mdev_write_ch():

	if (ch >= xpcs->channels)
		return -ENXIO;

then checks against the provisioned count rather than the active mode's
count.  Would a name like n_mdiodevs or num_addrs make that invariant
clearer?

The fbnic side also repeats the fbnic_mdio.c address layout as bare numbers
tied to it only by the "/* See fbnic_mdio.c addr usage */" comment; could
those addresses come from a shared define?

>  	phy_interface_t interface;
>  	bool need_reset;
>  	u8 eee_mult_fact;
