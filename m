Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B53C3C1D62;
	Wed,  7 Oct 2026 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366927; cv=none; b=Ms1JZhL/G7pLW9SwCcWxegMlbEczGmTrUiXSORYBfN8/UEV5lfxpvobcSd2rf5bMO8y9jjs3FvDEe2NBbiWzoJxoJ3UIijHyvxt54CY3EOXJhS34zc6yf5hRCWAdGdeENTTUP65R8pVYbUfJV9zzDKWagxubhSOfZ1S11Y8r1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366927; c=relaxed/simple;
	bh=6Z54gR4Vs7K3/sPGdCeJVc/bLbWmMs3doP1QFbjdeqw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YR2xo/Y0sKZiBQp9/2zorNOZ4p8BD6XzyFKBxa4wQpgQUE+02Iw+kIieqBcCSRMHTS0t7lQJOcFISXH1bPaW6dgQD6VhG661GpVFvkv6UoSN3UwuTlREw1nI469bH2JsNbxdihHxGR8zQdjWqln1YwAPQYkFBE70nhZJvwbqFD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xvdaI8L2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mZj7gzX5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xvdaI8L2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mZj7gzX5"
Message-ID: <19974942b90b571d66268bf7a06bb08c7bce7a33.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791366915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0DpmbX3LtX1M1aNoBAwyQom+mHTqG/75PmBvRPaA3uw=;
	b=xvdaI8L2idMC/MdifEvdQEs0EcYe1Z6kPBlOXrP22n+i1ksF9zDV+uj7Fx2613T4faKQUK
	LpRA6Atu9yl1FNHmf9O2I6zXTVIKwi7yROgnOf7+1MgSA5vtPjTeB4x2iZaMKV9+DY1+Or
	EU3bY5fXnnSI373ihj1A3X7rKRCmnFU9M2zXVQ1prUqOE4Er783ycitSa3ZMJY4Li/aWxk
	lhtu22L2GgmWRGHK8Wir+wt7wxPI0hx5iQHovALXQ47RvtHiiZNxWWAdyvsSeO3/xmeZHM
	vhm7WCtr+QCjMqd/TFBE7Q7ZsIa74HWnax/5MJfOOpyeKhussXI7SeKL75i+YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791366915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0DpmbX3LtX1M1aNoBAwyQom+mHTqG/75PmBvRPaA3uw=;
	b=mZj7gzX518ViNmxGrkwS+EX5uury7pFbftSwxyMA3K7rBi3b1Q4fAfHTvORCXxA1F5x9fU
	TyMP8nxKsLeHy2BA==
Subject: Re: [PATCH net-next v3 6/8] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch,  olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org,  pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, andrew+netdev@lunn.ch,  hkallweit1@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, martin.kaistra@linutronix.de,
 b.spranger@linutronix.de
Date: Wed, 07 Oct 2026 11:55:14 +0200
In-Reply-To: <179051211083.2160803.7671691444003694031@kernel.org>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>
	 <179051211083.2160803.7671691444003694031@kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-09-27 at 12:28 +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [High] In soce_sw_probe() (drivers/net/dsa/soce/soce_dsa_core.c), child
>   platform devices are created with devm_of_platform_populate() at line=
=E2=80=A6
> - [Medium] soce_setup() never puts the per-port INGR_EN/EGR_EN bits into
>   a known state for user ports, and probe does not reset the core.
>=20
> --
>=20
> net: dsa: soce: Add basic support for SoC-e switch IP cores
>=20
> This adds a DSA driver for SoC-e FPGA-based Ethernet switch IP cores. It
> reads the core version and feature registers at probe and enables DSA
> custom rules tagging during setup. The DSA port callbacks control port
> ingress and egress, and probe populates the MDIO controller and mux child
> devices.
>=20
> > diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soc=
e/soce_dsa_core.c
> > new file mode 100644
> > index 0000000000000..d391b11b94ad6
> > --- /dev/null
> > +++ b/drivers/net/dsa/soce/soce_dsa_core.c
>=20
> [ ... ]
>=20
> > +static int soce_setup(struct dsa_switch *ds)
> > +{
> > +	struct soce_priv *priv =3D ds->priv;
> > +
> > +	soce_sw_enable_tagging(&priv->local);
> > +
> > +	return 0;
> > +}
>=20
> [Severity: Medium]
> Is there anything that sets SOCE_PORTS_CTRL_INGR_EN and
> SOCE_PORTS_CTRL_EGR_EN to a known state on user ports before tagging is
> enabled here?
>=20
> Probe does not reset the core. At setup time the DSA core calls
> port_disable only for unused ports:
>=20
> net/dsa/dsa.c:dsa_port_setup() {
>     ...
> 	case DSA_PORT_TYPE_UNUSED:
> 		dsa_port_disable(dp);
> 		break;
>     ...
> }
>=20
> User ports get no port_enable or port_disable call until their netdev is
> opened or closed.
>=20
> Suppose the IP comes out of reset with ports enabled, or a bootloader lef=
t
> them enabled. Once soce_setup() turns on tag all frames and custom rules
> tagging, could a user port that is administratively down still receive
> frames and forward them tagged to the CPU port?
>=20
> At the end of the series, soce_setup() resets VLAN, disables STP and
> enables tagging. It still doesn't seem to change the per-port enable bits=
.
> Would it make sense to clear them for all user ports here?
>=20

Sure, it is better to have a defined state. I will deactivate all user
ports during setup.

> [ ... ]
>=20
> > +	ds->ops =3D &soce_switch_ops;
> > +	ds->num_ports =3D hw_numports;
> > +	ret =3D devm_of_platform_populate(dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to populate child devices\n");
> > +
> > +	dev_set_drvdata(dev, priv);
> > +
> > +	ret =3D dsa_register_switch(ds);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to register DSA switch\n");
>=20
> [Severity: High]
> Can this probe loop without end when dsa_register_switch() returns
> -EPROBE_DEFER?
>=20
> devm_of_platform_populate() creates the child devices before
> dsa_register_switch() runs. dsa_register_switch() can defer in fairly
> common situations. One is a conduit netdev that isn't registered yet:
>=20
> net/dsa/dsa.c:dsa_port_parse_of() {
>     ...
> 		conduit =3D of_find_net_device_by_node(ethernet);
> 		of_node_put(ethernet);
> 		if (!conduit) {
> 			rtnl_unlock();
> 			return -EPROBE_DEFER;
>     ...
> }
>=20
> It can also defer when dev_find_class() fails, or when the tagger lookup
> in dsa_switch_setup_tag_protocol() fails:
>=20
> 		if (PTR_ERR(tag_ops) =3D=3D -ENOPROTOOPT)
> 			return -EPROBE_DEFER;
>=20
> Documentation/driver-api/driver-model/driver.rst says:
>=20
>   -EPROBE_DEFER must not be returned if probe() has already created child
>   devices ... it may result in an infinite loop of .probe() calls
>=20
> The sequence looks like this:
>=20
> soce_sw_probe()
>   devm_of_platform_populate()
>     mdio-soce, mdio-mux-mmioreg and the PHY devices bind
>       driver_bound()->driver_deferred_probe_trigger()
>         deferred_trigger_count++
>   dsa_register_switch()
>     returns -EPROBE_DEFER
> really_probe()
>   sees the trigger count changed and triggers deferred probing again
> devres removes the child devices
> soce_sw_probe() runs again and creates them again
>=20
> The children bind synchronously because MODULE_SOFTDEP loads their driver=
s
> first. The DSA ethernet phandle is not a fw_devlink supplier property, so
> nothing makes the switch probe wait for the conduit.
>=20
> If the conduit never appears, for example because its driver is missing
> or fails, would a kworker keep creating and removing the MDIO bus and PHY
> devices indefinitely?
>=20
> This still appears to be present at the end of the series.
>=20

Good point. The MFD rework will address this by moving child device
creation out of the DSA driver's probe, so deferred probing will no
longer remove and recreate the MDIO and mux devices.

