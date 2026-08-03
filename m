Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109DB2F8E96;
	Mon,  3 Aug 2026 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772887; cv=none; b=Rfj1V7G5u0MAnoqMvkJdiY1ieuWhISQN6QtGpoWmBAR7lOBV2JYcOOtEQd3s7+fECkf16aCZxHdgnjtDotSTvGupomHMSaISTOIb8tzpM/W+heOtCtD1g2W7l0G6WByyj4dD8PUDGdxfbSyHmLqVs/glS8wL8gaXEfyKADmA9R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772887; c=relaxed/simple;
	bh=/6SC4853A0hdynqBxXGhnjTONP+X1lIr8xUj8gNWjXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZtgC+wc5GXmRcfiq2Y0hN33L7Zg2v3mxP3eRD/jyrHwPwXkfhgkhLDRH3ZhC82o1wbY5SOenmkMtJ9OX2uikIliDXL60/qY98knPn/ar4TVElXqPL5maSJDiKBuxMpqBZp8NG6slSuakEQ+bXOWTguqKeyt8wXQdRCunk/Tb4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=21NMZNiE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iWUI0C66; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="21NMZNiE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iWUI0C66"
Message-ID: <cee2e05d931a977d0db938ada0964d05885949a5.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785772884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySmtU3pkYZUuotVPA1jLe8VSFpas5QtatAndD2IpiDU=;
	b=21NMZNiElD9wKbgt/Gy4DZX3c0xFlDBub7zU2RKJCeG3SYW3RX0c3G5Tmg4k69ghowTxgH
	rJjGgpf32gYQBMJnHxoJpV9V9tYv1uKFSPv4rzLaGe0L1/E/KAT8IZdxghhLZm2FencYPE
	tB6F0/dhlYRvn0CkD1j1i6yBh9OBLr9hDtep/lt0aCz/Er7234m7ZcRA5avh9a+jVJnc98
	m3HL6LvNyavyj91kv/gxo6vru7jVLsEDA69xsLr8PcJuuemrQJuyslDvh79UrnIzEWGx6A
	hzVKBF9nnAktvqR26u/KsM8HXI40LtBA4nF5Trfl0DMLp+me9Bf0FaBUFeoEdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785772884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySmtU3pkYZUuotVPA1jLe8VSFpas5QtatAndD2IpiDU=;
	b=iWUI0C66q0rk9cyewpyxm4LPIVifQtphSECU7+yGRCJDZkWwZLezpiryUqJxcQP5emgL5C
	YCG0Z6sRK6NZt2CA==
Subject: Re: [PATCH 4/4] net: dsa: soce: Add initial driver support for MRS
 switches
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>
Date: Mon, 03 Aug 2026 18:01:23 +0200
In-Reply-To: <f17d3a62-456f-4580-90bd-c54a30dceddc@lunn.ch>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-4-be569dae1b20@linutronix.de>
	 <f17d3a62-456f-4580-90bd-c54a30dceddc@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-29 at 22:05 +0200, Andrew Lunn wrote:
> > +static u8 soce_map_stp_state(u8 state)
> > +{
> > +	switch (state) {
> > +	case BR_STATE_DISABLED:
> > +	case BR_STATE_BLOCKING:
> > +	case BR_STATE_LISTENING:
> > +		return 0;
> > +	case BR_STATE_LEARNING:
> > +		return 1;
> > +	case BR_STATE_FORWARDING:
> > +	default:
> > +		return 3;
>=20
> #defines for 0, 1 and 3.
>=20
> What does 2 mean?
>=20
> Since you don't implement bridge offload, i'm not sure having STP
> states makes any sense.

I tested bridge and STP and observed the callback calls with something like
this (reduced setup):
# ip link add name br0 type bridge
# ip link set dev port0 master br0
# ip link set dev port1 master br0
# brctl stp br0 on

That probably wasn't enough. I'll take a closer look at it and either fix i=
t
or remove it for the next version.

>=20
> > +static void soce_fast_age(struct dsa_switch *ds, int port,
> > +			  const struct soce_layout *layout)
> > +{
> > +	struct soce_priv *priv =3D ds->priv;
> > +	struct soce_dsa_local *local;
> > +	void __iomem *p_mes_ctrl;
> > +	u32 val;
>=20
> Does aging make any sense without bridge offload?

Same as above. I'll take a closer look at it and either fix it or remove it
for the next version.

>=20
> > +/* Bridge membership is handled by the switch forwarding model directl=
y. */
> > +int soce_port_bridge_join(struct dsa_switch *ds, int port,
> > +			  struct dsa_bridge bridge, bool *tx_fwd_offload,
> > +			  struct netlink_ext_ack *extack)
> > +{
> > +	return 0;
> > +}
> > +
> > +void soce_port_bridge_leave(struct dsa_switch *ds, int port,
> > +			    struct dsa_bridge bridge)
> > +{
> > +}
>=20
> If you don't support bridge offload, you should not need these.

Also here. I'll take a closer look at it and either fix it or remove it for
the next version.

>=20
> > +static void soce_phylink_get_caps(struct dsa_switch *ds, int port,
> > +				  struct phylink_config *config)
> > +{
> > +	if (dsa_is_cpu_port(ds, port)) {
> > +		__set_bit(PHY_INTERFACE_MODE_GMII,
>=20
> Is that really true? What is part of the IP core, and what is to do
> with integration of the core into the system as a whole? It seems like
> RGMII is also supported, so why cannot i instantiate a RGMII MII blob
> for the CPU port as well?

No it's wrong, I will adjust that.

>=20
> > +			  config->supported_interfaces);
> > +		config->mac_capabilities =3D MAC_10 | MAC_100 | MAC_1000 |
> > +					   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
> > +		return;
> > +	}
> > +
> > +	phy_interface_set_rgmii(config->supported_interfaces);
>=20
> And flipping that around, if the core supports GMII, could i
> instantiate a GMII user port?

Will also be fixed in the next version.

>=20
> > +static const struct dsa_switch_ops soce_switch_ops =3D {
> > +	.get_tag_protocol	=3D soce_get_tag_protocol,
> > +	.setup			=3D soce_setup,
> > +	.teardown		=3D soce_teardown,
> > +	.phylink_get_caps	=3D soce_phylink_get_caps,
> > +	.phy_read		=3D soce_phy_read,
> > +	.phy_write		=3D soce_phy_write,
>=20
> phy_read and phy_write are legacy. Instantiate a Linux MDIO bus and
> don't list anything here.

I will do it.

>=20
> > +static const struct soce_variant_desc *
> > +soce_match_variant(const char *compatible)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; soce_variants[i].compatible; i++) {
> > +		if (!strcmp(compatible, soce_variants[i].compatible))
> > +			return &soce_variants[i];
> > +	}
> > +
> > +	return NULL;
>=20
> This kind of looks like a reinvention of of_device_get_match_data()

I will update this in the next version.

>=20
> > +static int soce_sw_parse_port_mdio_config(struct soce_dsa_local *local=
,
> > +					  struct device *dev,
> > +					  struct device_node *port_node,
> > +					  u32 port)
> > +{
> > +	struct device_node *phy_node;
> > +	u32 val;
> > +	int ret;
> > +
> > +	if (of_find_property(port_node, "ethernet", NULL) ||
> > +	    of_find_property(port_node, "link", NULL)) {
> > +		if (of_find_property(port_node, "phy-handle", NULL)) {
> > +			dev_err(dev,
> > +				"phy-handle not allowed on CPU/DSA port %u\n",
> > +				port);
> > +			return -EINVAL;
> > +		}
> > +
> > +		return 0;
> > +	}
>=20
> Why is all of this parsing of DT needed? These should all be standard
> properties which the DSA core handles.

I will make greater adjustments to the driver here and in other places for
the next version.

>=20
> This currently has the feel of being a "vendor crap" driver. Please
> spend some time to clean this driver up, bring it up to Mainline
> standards.

This is actually already the cleaner version.
Thank you for the feedback. This will allow me to reorganize the project
accordingly and adapt the code more closely to already mainlined drivers.
It looks like Lantiq provides a good example.

>=20
> 	Andrew

Thanks,
Vasilij

