Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C6248E0F5;
	Tue, 15 Sep 2026 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471422; cv=none; b=r9RfRQCFqhMoITxOCpo1A0jwEDOBtxwVDE6vez0BelbeHpMjj7HFlGYWT/IR9LZWQmxrP/BC4Ro2z+stc5WoT0qLCo/RPOD8CHRtTRdyWp6e5Zi8Eq3kyQRF1Qw2HWTjPKqw3bl8ZO+FeAhHqdUOdoV0yRWG9NXhvgEdMfBS3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471422; c=relaxed/simple;
	bh=ljskRcMdf2XYphYJmHCVJgisZOIL+BdrJ5ob2W9wZ6U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tPah0GglblAY136hPpeqTWOc7milaMAWX6I4wOraOv5WTpZiJ9cSppJLd4jYAxWfVeU/ppUc70Xy6U4EXQbYRPlqi49nKhnh8OUo3q1+AlHr8+B6hdW7s8keotuNvUQeGOQXzz/N1H8Fna3Sc9AKsAI78I/HwK05UdJMWtby5lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sW5W091j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0K9y0T3s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sW5W091j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0K9y0T3s"
Message-ID: <c863e105257ae512d32e94b56ac081c41c4284f6.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789471413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5YjS13qvbadUK35UlDy89MYgOvcwR+tWSGlVIQ/VWc=;
	b=sW5W091j3UDBScCJhLbxbxDHgvyZTgpww7h/o5pW0b30/ZhQTx9Y+zffkBSE+WffXB8Gkx
	zuDCyTSUjzsoZHneWFQCxq7vPWfQhurt4o0jOZOJCUWPNr/3PXxhoIJyC33Ko7Pq7W441l
	SvyhTRGKwqtdPSQFk7oAXgHt+rOW1rbUzLX2KBqLLEg3la88Q8bC/P7XY1849QkQuKvT+W
	pPaOI8rio+VtlliHY+n+/lLdIr7MzhQz2Lpz2xyPOEZL7QDJBYVFCRacXbm/9wDquSARog
	pGMgQ2vrc4Y+9eqTSZx8n4MGQf2CzMtV9B/rZ5NSRU3NZP2sh+7PKsjj9sv0fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789471413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5YjS13qvbadUK35UlDy89MYgOvcwR+tWSGlVIQ/VWc=;
	b=0K9y0T3soY9wKIec21PHBPzbPVB2NK6VeAw5DLPr7SUUE5RJEPHvwqfF+gHg6nL0HyGCF3
	WBlCJOdcf3RrOECQ==
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch,  olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org,  pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 martin.kaistra@linutronix.de, b.spranger@linutronix.de
Date: Tue, 15 Sep 2026 13:23:32 +0200
In-Reply-To: <178895594761.219967.4769482322073838475@kernel.org>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
	 <178895594761.219967.4769482322073838475@kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-09 at 12:12 +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 1
>=20
> - [Medium] The MDIO master transaction sequence never verifies that the
>   shared controller is idle before programming PARAMS/WRITE and kicking=
=E2=80=A6
> - [Medium] soce_setup() arms the switch's "tag all frames" and "DSA
>   custom rules tagging" bits, but the driver provides no .teardown=E2=80=
=A6
> - [Low] The compatible string and its binding description declare a
>   register layout with "the core version register at offset 0x00 and=E2=
=80=A6
>=20
> --
>=20
> [ ... ]
>=20
> > +struct soce_probe_desc {
> > +	u32 core_version_offset;
> > +	u32 licensed_features_offset;
> > +	u32 implemented_features0_offset;
> > +	u32 mdio_master_offset;
> > +};
> > +
> > +static const struct soce_probe_desc soce_probe_desc_swip_00_04_0c_10 =
=3D {
> > +	.core_version_offset		=3D 0x0000,
> > +	.licensed_features_offset	=3D 0x0004,
> > +	.implemented_features0_offset	=3D 0x000c,
> > +	.mdio_master_offset		=3D 0x0200,
> > +};
>=20
> [Severity: Low]
> The compatible name soce,swip-00-04-0c-10 and the binding text describe a
> register layout with "the core version register at offset 0x00 and featur=
e
> identification registers at offsets 0x04, 0x0c, and 0x10", but this
> descriptor only models 0x00, 0x04 and 0x0c.
>=20
> Is the 0x10 register meant to be read somewhere?  soce_sw_detect_features=
()
> reads only licensed_features_offset and implemented_features0_offset:
>=20
> 	regval =3D readl(local->base_addr + probe_desc->licensed_features_offset=
);
> 	...
> 	regval =3D readl(local->base_addr +
> 		       probe_desc->implemented_features0_offset);
>=20
> The "features0" suffix also suggests a features1 register at 0x10 that is
> currently ignored.
>=20
> Going the other way, mdio_master_offset =3D 0x0200 is a register block th=
e
> driver depends on for every MDIO transaction, but the binding does not
> mention it at all.  Should the binding describe that block too, or should
> the offset list in the compatible description match what the driver
> actually models?

I will remove this abstraction since only one switch register layout is
currently supported. The MDIO master offset will be removed as well,
because the MDIO controller will be represented by separate child
devices with their own compatibles.

The offsets encoded in soce,swip-00-04-0c-10 describe the complete
switch identification register layout. The current minimal DSA driver
only reads the registers and feature fields it needs, so it does not
access the implemented-features register at 0x10 yet. I would prefer to
retain this information for future compatible driver extensions that
may need that register.

>=20
> [ ... ]
>=20
> > +static void soce_sw_enable_tagging(struct soce_dsa_local *local)
> > +{
> > +	u32 regval;
> > +
> > +	regval =3D readl(local->base_addr + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> > +	regval |=3D SOCE_TAG_ALL_FRAMES_ENABLE;
> > +	writel(regval, local->base_addr + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> > +
> > +	regval =3D readl(local->base_addr + SOCE_CUSTOM_RULES_TAGGING_OFFSET)=
;
> > +	regval |=3D SOCE_CUSTOM_RULES_TAGGING_ENABLE;
> > +	writel(regval, local->base_addr + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
> > +}
> > +
> > +static int soce_setup(struct dsa_switch *ds)
> > +{
> > +	struct soce_priv *priv =3D ds->priv;
> > +
> > +	soce_sw_enable_tagging(&priv->local);
> > +
> > +	return 0;
> > +}
>=20
> [ ... ]
>=20
> > +static const struct dsa_switch_ops soce_switch_ops =3D {
> > +	.get_tag_protocol	=3D soce_get_tag_protocol,
> > +	.setup			=3D soce_setup,
> > +	.phylink_get_caps	=3D soce_phylink_get_caps,
> > +};
>=20
> [Severity: Medium]
> Should there be a .teardown counterpart that clears what soce_setup()
> armed?
>=20
> soce_sw_enable_tagging() sets SOCE_TAG_ALL_FRAMES_ENABLE and
> SOCE_CUSTOM_RULES_TAGGING_ENABLE, and nothing in the driver ever clears
> them again.  There is no .teardown in soce_switch_ops, and the platform
> callbacks only unregister:
>=20
> soce_sw_remove()
> 	dsa_unregister_switch(priv->ds);
>=20
> soce_sw_shutdown()
> 	dsa_switch_shutdown(priv->ds);
>=20
> After an unbind or rmmod, does the core keep inserting SDSA source-port
> tags into every frame delivered to the CPU port, with the tagger that
> would strip them gone?  As described in the commit message, the same bits
> also keep the user ports in CPU-directed operation:
>=20
>     "Enabling this tagging feature of the switch, places all user ports
>     into CPU-directed operation"
>=20
> so the switch would also stay locked out of normal port-to-port
> forwarding after the driver is removed.

Yes, I had not considered this use case. The tagging state currently
remains enabled after unbind or shutdown. In v3, I will add a .teardown
callback that clears both SOCE_TAG_ALL_FRAMES_ENABLE and
SOCE_CUSTOM_RULES_TAGGING_ENABLE, returning the switch to an unmanaged
state.

>=20
> > +static void soce_sw_remove(struct platform_device *pdev)
> > +{
> > +	struct soce_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +	if (!priv)
> > +		return;
> > +
> > +	dsa_unregister_switch(priv->ds);
> > +	platform_set_drvdata(pdev, NULL);
> > +}
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/soce/soce_mdio.c b/drivers/net/dsa/soce/so=
ce_mdio.c
> > new file mode 100644
> > index 0000000000000..692dcbe57d1a6
> > --- /dev/null
> > +++ b/drivers/net/dsa/soce/soce_mdio.c
>=20
> [ ... ]
>=20
> > +static int soce_mdio_read(struct mii_bus *bus, int addr, int reg)
> > +{
>=20
> [ ... ]
>=20
> > +	mutex_lock(&local->mdio_lock);
> > +	ret =3D local->mdio_ops->phy_read(state->ds, state->mdio_output, addr=
,
> > +					reg);
> > +	mutex_unlock(&local->mdio_lock);
> > +
> > +	return ret;
> > +}
>=20
> [ ... ]
>=20
> > +static int soce_mdio_23_02_wait_for_idle(struct dsa_switch *ds)
> > +{
> > +	struct soce_priv *priv =3D ds->priv;
> > +	struct soce_dsa_local *local;
> > +	void __iomem *ctrl;
> > +	u32 val;
> > +
> > +	local =3D &priv->local;
> > +	ctrl =3D local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
> > +
> > +	return readl_poll_timeout(ctrl, val,
> > +		!(val & (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET)), 10,
> > +		SOCE_MDIO_TIMEOUT * 1000);
> > +}
>=20
> [Severity: Medium]
> What happens to the hardware state when this poll times out?
>=20
> On -ETIMEDOUT the OPSTATUS bit is still set, meaning the operation is
> still in flight, and the callers just propagate the error without abortin=
g
> or resetting the master:
>=20
> 	ret =3D soce_mdio_23_02_wait_for_idle(ds);
> 	if (ret)
> 		return ret;
>=20
> The bus wrappers soce_mdio_read(), soce_mdio_write(), soce_mdio_read_c45(=
)
> and soce_mdio_write_c45() then drop mdio_lock unconditionally, so the
> software lock protecting the shared master is released while the hardware
> is still busy.
>=20
> None of the transaction helpers check for idle before programming the
> registers either.  In soce_mdio_23_02_read_c22():
>=20
> 	regvalue =3D (regnum << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
> 		   (phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
> 	writel(regvalue, params);
>=20
> 	regvalue =3D ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) + ...
>=20
> Can the next transaction, possibly issued through a different logical bus
> sharing the same master, reprogram PARAMS/WRITE and kick CTRL underneath
> a still-running operation?
>=20

Good point. The current implementation releases the software lock after
a timeout, allowing a subsequent transaction to overwrite the parameter
registers while the controller may still be busy.

The hardware documentation exposes no abort or reset mechanism. In v3, I
will therefore check that the controller is idle before programming any
transaction register. If OPSTATUS remains set, subsequent accesses will
time out without modifying the controller state or starting another
transaction.

> > +int soce_mdio_23_02_read_c45(struct dsa_switch *ds, int mdio_output,
> > +			     int phy_addr, int devad, int regnum)
> > +{
>=20
> [ ... ]
>=20
> > +	regvalue =3D (devad << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
> > +		   (phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
> > +	writel(regvalue, params);
> > +
> > +	writel(regnum, write_reg);
> > +
> > +	/* address cycle */
> > +	regvalue =3D ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
> > +		    (0x0 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +
> > +		    (0x1 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +
> > +		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));
> > +	writel(regvalue, ctrl);
> > +
> > +	ret =3D soce_mdio_23_02_wait_for_idle(ds);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* read cycle */
>=20
> [Severity: Medium]
> For Clause 45 the address cycle and the data cycle are separate hardware
> operations.  If the address cycle times out here and is never aborted, ca=
n
> a later data cycle land on a stale address, and can the following
>=20
> 	return readl(read_reg) & 0xffff;
>=20
> hand the previous transaction's result back to phylib as a valid register
> value?
>=20
> Would it make sense to poll for idle before programming PARAMS/WRITE, and
> to clear or reset the master on the timeout path before releasing
> mdio_lock?  The same applies to soce_mdio_23_02_write_c22() and
> soce_mdio_23_02_write_c45(), where a corrupted transaction would write to
> an unintended PHY register.
>=20

Yes, this will be addressed in v3. All transaction paths will poll for
idle before modifying PARAMS or WRITE. A failed Clause 45 address cycle
will return immediately, without starting the data cycle or returning
stale read data. Subsequent accesses will leave the controller untouched
while OPSTATUS remains set. The hardware documentation does not describe
an abort or reset mechanism, so recovery is not available.

> [ ... ]
>=20

