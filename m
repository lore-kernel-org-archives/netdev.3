Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C0D48EC78;
	Thu, 10 Sep 2026 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045322; cv=none; b=ktXlM7D64g4vS36VUjjK4Bk/RQXg71pNUBPZruzMSn7v+GVo2fwyiTCK423b5EZ7PkLiMVoCIC1rZB8uvL6OzErr3/rgVF7w6MlWgDcit2TiT6p1XHk9I05JPOYKuGlS8hv2lg5ZSoJmBU3LBDCkmhfNKM08TFO9Rw2Fdg3+rAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045322; c=relaxed/simple;
	bh=w3J3CjUdEMJmwbL8nhv1N28ATD5r0tVdOG1+5Zh8Jiw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ONLFVHQbQE4mRSgKrXT3GCZOhk/Y913uygGNYGDqgvTDytiIIfkBTNX0zw5Bd93W+CXF2HkHdwwCxUQXGPzgbNZ3HK8gyvFaiRjcuNayCXv48z43D5ZQLrX8K8/hxi1IcZWZ2AktDglKKNbpreVxaxnY8w2XpXonAja0ABgNN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZAsLwyfD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8VgGFuVG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZAsLwyfD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8VgGFuVG"
Message-ID: <42efedd837c1631b38849693e1d66bd2b1fb1529.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789045316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vxv+Uy/DASPOjdkVkNeCTuPdgi+aKluwbwRc7T2vD2Y=;
	b=ZAsLwyfD4h/CwZNOGDyHkldyLgr6IBirsJz7kJNvCEait3+uE2fGAVsEKi/hx2kOtr5zIX
	omuY8reNMXYUsOCOzMscI7sXwSeDTwV05Pz+8EoA1bXQV9U6R9zhg14FchQ/xd/TETOijY
	yxGKvXM9KztGaHwR+rVp1w/yGGZM8hrFX3/g7apJAGdbTByiPfcC1Xydbfuu+Pu7Tnk/OW
	tgoq7Zcmjsol8qBOYA+PjBll6w/pf0CmGC3u/cDHpxWJVzytnWfmuVELc2QAJPnU17EoYe
	ToYIlwnRDIYXaoCEr8y03y6L+BA0viaTZgg7Y/flO89b5gImo6n3vgmApPqGVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789045316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vxv+Uy/DASPOjdkVkNeCTuPdgi+aKluwbwRc7T2vD2Y=;
	b=8VgGFuVGGFV8JKtLf3bgQlbDK78Fc19ozvw7gvA+UJOZDhsOiyurw3JEe/KIl1ndQDdQ0J
	4VNqEOFjmkBHq2Cg==
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Thu, 10 Sep 2026 15:01:54 +0200
In-Reply-To: <371fe855-e21f-4d53-a13f-4486494c8ae1@lunn.ch>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
	 <371fe855-e21f-4d53-a13f-4486494c8ae1@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-08 at 02:37 +0200, Andrew Lunn wrote:
> > +#define SOCE_CORE_VERSION_SHIFT			24
> > +#define SOCE_CORE_SUBVERSION_SHIFT		16
> > +#define SOCE_LICENSED_NUM_PORTS_MASK		GENMASK(31, 27)
> > +#define SOCE_IMPLEMENTED_NUM_PORTS_MASK		GENMASK(31, 27)
> > +#define SOCE_IMPLEMENTED_DSA			BIT(23)
> > +#define SOCE_DSA_REGS_BASE			0x1200
> > +#define SOCE_TAG_ALL_FRAMES_CTRL_OFFSET		(SOCE_DSA_REGS_BASE + 0x001c)
> > +#define SOCE_TAG_ALL_FRAMES_ENABLE		BIT(0)
> > +#define SOCE_CUSTOM_RULES_TAGGING_OFFSET	(SOCE_DSA_REGS_BASE + 0x0020)
> > +#define SOCE_CUSTOM_RULES_TAGGING_ENABLE	BIT(0)
> > +#define SOCE_MIN_CORE_VERSION			0x24
> > +#define SOCE_MIN_CORE_SUBVERSION		0x01
>=20
> Could you fully describe the feature registers, so we have an idea
> what is actually there.
>=20

Unfortunately, I cannot share the complete vendor documentation, but I
can provide an overview of the feature register fields and bits used by
the driver, as well as the surrounding registers and bits. This should
help to get an idea.
Each synthesized optional feature has its own register block. The
additional description focuses on the MDIO, and DSA blocks which are
relevant to this driver.

---
Global register block at 0x0000 (three registers currently used)
	0x00 Core Version - Major and minor revision number (RO)
	0x04 Licensed Features (RO)
	0x08 Reserved
	0x0C GUI Configuration - Implemented Features 0 (RO)
	0x10 GUI Configuration - Implemented Features 1 (RO)
	0x14 Reserved
	0x18 Node Address - MAC Address (31-0)
	0x1C Node Address - MAC Address (47-32)
	0x20 Node Address - IPv4 Address
	0x24 Node Address - IPv6 Address (31-0)
	0x28 Node Address - IPv6 Address (63-32)
	0x2C Node Address - IPv6 Address (95-64)
	0x30 Node Address - IPv6 Address (127-96)
	0x34 Switch Configuration - Maximum Frame Length
	0x38 Reserved
	0x3C Switch Configuration - Input Timestamp Addition
	0x40 Reserved
	0x44 Switch Configuration - Input Timestamp Removal
	0x48 Reserved
	0x4C Switch Configuration - Architecture Selection

	Core Version (RO)
	[31:24] - Major version number
	[23:16] - Minor version number
	[15:8] - Major revision number
	[7:0] - Minor revision number

	Licensed Features Register (RO) (Bits specify if the given
	feature is enabled by license):
	[31:27] - Maximum Number of Ports: These bits specify the maximum
	number of ports licensed
	[26:15] - Reserved
	- ACL: Access Control List (ACL) feature
	- LLDP: LLDP feature
	- IEEE 802.1X
	- IEEE 802.1AX-2008 - Link Aggregation
	- IEEE 802.3br/IEEE 802.1Qbu - Preemption
	- IEC 61158-4-2 - DLR
	- IEC 62439-2 - MRP
	- IGMP Snooping
	- Port mirroring
	- IEEE 802.1s - MSTP
	- IEEE 802.1w - RSTP
	- IEEE 1588 - Transparent Clock
	- Switch mode: managed or unmanaged
	- Secure Chip
	- Time Limitation

	Implemented Features 0 Register (RO, Default value from GUI,
	Bits specify if the given feature is synthesized):
	[31:27] - Number of Ports: These bits specify the number of
	ports implemented.
	- IEEE 802.1X
	- IEEE 802.1AX-2008 - Link Aggregation
	- IEEE 802.3br/IEEE 802.1Qbu - Preemption
	[23] - DSA: This bit specifies if the DSA functionality is
	implemented.
	- Port Mirroring:
	- IEEE 802.1s - MSTP
	- IEEE 802.1w - RSTP
	- MAC Level Ingress Frame Filtering
	- Egress Frame Rate Limiting
	- Egress Throughput Rate Limiting
	- MAC Ingress Frame Rate Limiting
	- Ingress Throughput Rate Limiting
	- IGMP Snooping
	- Multicast Filtering
	- MAC Table Type: (SVL/IVL/SVL+IVL)
	- Static Filtering Database
	- Port-based VLAN
	- IEEE 1588 - Transparent Clock Layer 3
	- IEEE 1588 - Transparent Clock P2P calculation
	- IEEE 1588 - Transparent Clock
	- Jumbo Frame
	- QoS - Priorities
	- Statistic Counters

	Implemented Features 1 Register (RO, Default value from GUI,
	Bits specify if the given feature is synthesized):
	- Redundancy Protocol (PRP/HSR/HSR+PRP)
	- IEC 61158-4-2 - DLR
	- IEC 62439-2 - MRP
	- ACL: Access Control List
	- LLDP

---
MDIO Bridge Registers, base address 0x0200
	0x00 MDIO - Control
	0x04 MDIO - Address / Device Type
	0x08 MDIO - Register Address / Write Data
	0x0C MDIO - Read Data

	MDIO - Control
	[26:16] - Bus selection: These bits specify the port number over
	which MDIO operation is performed.
	[4:3] - Transaction Type: These bits specify the type of MDIO
	transaction to be performed.
		0x0 - MDIO address operation (only valid when Clause 45
		is selected).
		0x1 - MDIO write operation.
		0x3 - MDIO read operation.
	[1] - MDIO Clause: If '0', Clause 22, if '1', Clause 45
	[0] - Operation Status: 0: Ready / 1: Operation in progress. Set
	to '1' to start a new operation.

	MDIO - Address / Device Type
	[12:8] - Register Address (if Clause 22)/Device Type (if Clause45)
	[4:0] - PHY Address: These bits specify the PHY address

	MDIO - Register Address / Write Data
	[15:0] - Register Address / Write Data: Depending on Clause 22/45
	and transaction type.

	MDIO - Read Data
	[15:0] - Read Data: Data sampled after a MDIO read transaction.

---
DSA Frame Tagging Registers, base address 0x1200 (Mostly R/W access if
the feature is available. Default values 0 or from synthesis GUI.)
	0x00 CPU Ports (RO)
	0x04 DSA Predefined Rules - Control
	0x08 DSA Predefined Rules - Index
	0x0C DSA Predefined Rules - CPU Port List
	0x10-0x18 Reserved
	0x1C DSA Tag All - Control ([0] - If '1', all frames
	transmitted to the CPU port(s) will be DSA tagged. If '0', only
	those frames identified as DSA will be tagged.)
	0x20 DSA Custom Rules - Enable ([0] - Globally enable or
	disable the Custom DSA Tagging functionality)
	0x24 DSA Custom Rules - Control
	0x28 DSA Custom Rules - Index
	0x2C DSA Custom Rules - Destination MAC Address LO
	0x30 DSA Custom Rules - Destination MAC Address HI
	0x34 DSA Custom Rules - Ethertype
	0x38 DSA Custom Rules - Parameter Mask
	0x3C DSA Custom Rules - CPU Port List
	0x40 DSA Custom Rules - Trap/Mirror

While preparing this description I found a mismatch with MDIO Bus
selection Bits 26:16 in code. I will fix this for next version.


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
> How fixed/variable are these? I'm just thinking there may be too much
> abstraction here. To some extent, we leave abstractions out until they
> are needed. If you know there are other devices out there which have
> these at other addresses, then O.K. But if not, i would keep it KISS.
>=20

Right. I introduced the descriptor to make potential future
register-layout variants easier to support, but there is currently no
concrete variant that requires it.
Will fix this.

> > +static int soce_sw_detect_features(struct soce_dsa_local *local,
> > +				   const struct soce_probe_desc *probe_desc,
> > +				   u32 *numports)
> > +{
> > +	u32 implemented_numports;
> > +	u32 licensed_numports;
> > +	u32 regval;
> > +
> > +	regval =3D readl(local->base_addr + probe_desc->licensed_features_off=
set);
> > +	licensed_numports =3D FIELD_GET(SOCE_LICENSED_NUM_PORTS_MASK, regval)=
;
> > +	if (!licensed_numports || licensed_numports > SOCE_MAX_NUM_PORTS)
> > +		return -EINVAL;
> > +
> > +	regval =3D readl(local->base_addr +
> > +		       probe_desc->implemented_features0_offset);
> > +	if (!(regval & SOCE_IMPLEMENTED_DSA))
> > +		return -ENODEV;
>=20
> I find it useful to have macros like SOCE_IMPLEMENTED_DSA indicate
> they apply to features0. It makes it easier to spot dumb typos when
> you apply it to features1, not features0.
>=20

Agreed. I will do it for the next version.

> I also wounder at the name. Does the data sheet really call it DSA?
>=20

Yes, there is even a chapter describing Distributed Switch Architecture
(DSA) as "a subsystem that was primarily designed to support specific
vendor switches using Linux, ..." followed by information about "custom
DSA tagging".

> > +
> > +	implemented_numports =3D FIELD_GET(SOCE_IMPLEMENTED_NUM_PORTS_MASK,
> > +					 regval);
> > +	if (!implemented_numports ||
> > +	    implemented_numports > licensed_numports)
> > +		return -EINVAL;
> > +
> > +	*numports =3D implemented_numports;
>=20
> How is this going to scale when you need to look at more bits in these
> registers? It seems like at some point you are going to need to pass a
> structure to be filled in.
>=20

Yes, I agree that a feature structure will be needed once more fields
are used. I would prefer to keep the current interface for now and
introduce struct soce_features when another detected feature needs to be
retained. At the moment, it would contain only a single member.

> > +static int soce_register_mdio_bus(struct soce_priv *priv, struct devic=
e *dev,
> > +				  struct device_node *mdio_np,
> > +				  u32 mdio_output)
> > +{
> > +	struct soce_mdio_bus *state;
> > +	struct mii_bus *bus;
> > +
> > +	bus =3D devm_mdiobus_alloc(dev);
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	state =3D devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
> > +	if (!state)
> > +		return -ENOMEM;
> > +
> > +	state->ds =3D priv->ds;
> > +	state->mdio_output =3D mdio_output;
> > +
> > +	bus->priv =3D state;
> > +	bus->name =3D "soce mdio";
> > +	bus->read =3D soce_mdio_read;
> > +	bus->write =3D soce_mdio_write;
> > +	bus->read_c45 =3D soce_mdio_read_c45;
> > +	bus->write_c45 =3D soce_mdio_write_c45;
> > +	/* ds->dst can be NULL during probe, before dsa_register_switch() */
> > +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mdio-%u", dev_name(dev),
> > +		 mdio_output);
>=20
> Why the comment. How is it relevant?

I missed to update or remove comments here and on other places while
rewriting the code. I will fix all of them for next version.

>=20
> > +static int soce_mdio_23_02_read_c22(struct dsa_switch *ds, int mdio_ou=
tput,
> > +				    int phy_addr, int regnum)
> > +{
> > +	void __iomem *ctrl, *params, *read_reg;
> > +	struct soce_priv *priv =3D ds->priv;
> > +	struct soce_dsa_local *local;
> > +	u32 regvalue;
> > +	int ret;
> > +
> > +	local =3D &priv->local;
> > +	ctrl =3D local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
> > +	params =3D local->mdio_master_addr + SOCE_MDIO_23_02_PARAMS_OFFSET;
> > +	read_reg =3D local->mdio_master_addr + SOCE_MDIO_23_02_READ_OFFSET;
> > +
> > +	regvalue =3D (regnum << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
> > +		   (phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
> > +	writel(regvalue, params);
> > +
> > +	regvalue =3D ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
> > +		    (0x3 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +
>=20
> 0x3 means read?
>=20
> > +		    (0x0 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +
>=20
> 0x0 means C22
>=20
> > +		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));
>=20
> What does 0x1 mean? Please add some #defines for theses to act as
> documentation.

This code will be replaced as part of mentioned MDIO controller and mux
rework. I will address this there by adding descriptive definitions.

>=20
> 	Andrew

Thanks,
Vasilij
