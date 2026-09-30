Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA9511E73;
	Wed, 30 Sep 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792106; cv=none; b=NMTgbGf4PrpJSMTczW8khCKuRknsRXcH5NNDXitbf5WRX1ZJYFQxAaQYNkg1ELScbyoNF7i1P1WgZgwOtLUTDcTjHLTaoUQP4plAtZOW/BJHk2oUPmfOs/3o0ZtwZxFOvx+CQApyYLpU4TkmOJ9FFx29tHVef6dcw0aiI8Sgo84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792106; c=relaxed/simple;
	bh=qtrjQkiyndvbZ3QLWDH+J2xwQVLy7OMtyFVFmh0jvF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RYHLkS4te0zXZ7hNr1UvA9baK5ssm35nB/kXjvDzhIZQnfmQKYGwTLbJbZXfSia0xrOkL2Gk8GFke54dfN4jc0LeNc2NSf8hKhug2n+/dpoIpngFijkaKEYd2ZXKu0s+1mGszonGn5mzRRfCZ4PobxZZjON3yGXDNIuCNGp3gHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=coR76llS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CwScFmkP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="coR76llS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CwScFmkP"
Message-ID: <4fe59faffa0bb322e68c9c4d43f0bc240a519eba.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790792102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p99YD+HRfuXW0y8PaQcViHjFbnUDNYVI5HOhKICBZWc=;
	b=coR76llSpxEJtaUisVgJKEpf9+lJ3x1SD9acw7TdOg3Bxg+4PnVozHA0uUqmu2ARgLH5yn
	rQeCL2jTZJG1m4nzAZJTczScdsQ+OymnnwYSlH62F77s5cdGEZSjOSGknZIX1165ENPOAY
	fcp5dcGzemARNVQYiY6BOSn7Md8zRy0xQaZ9aWoTUXkOaxpy3vXpnMKU3l0A+JkiUU2+n7
	P7zpL8KAaZ4GNm99uCSzwuMyGJ6e5ji20ZFM/wwKzcc0kHsj/WAryvEUAQJCirM77ML+7/
	lIgiRI6ec5Ii3IhzvzPWeHUPdjosW76EFBYRrEzyZirxLSzAoMpndpH3uFAWfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790792102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p99YD+HRfuXW0y8PaQcViHjFbnUDNYVI5HOhKICBZWc=;
	b=CwScFmkPLmcDXH7yl9EUub8QGqAo1L7zlVVzwoA5jWdRi+SDPS/aAURZjDYkQk1z8455/J
	IFdfv8GhKER23ABg==
Subject: Re: [PATCH net-next v3 6/8] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Wed, 30 Sep 2026 20:15:00 +0200
In-Reply-To: <716486ec-6253-41dd-83ac-b816c845fafe@lunn.ch>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>
	 <716486ec-6253-41dd-83ac-b816c845fafe@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-26 at 01:20 +0200, Andrew Lunn wrote:
> On Wed, Sep 23, 2026 at 12:39:33PM +0200, Vasilij Strassheim wrote:
> > Add a DSA driver for SoC-e FPGA-based Ethernet switch IP cores.
> >=20
> > Read the core version and synthesis-time feature registers during probe=
.
> > Require DSA support and between 3 and 31 implemented ports, without
> > exceeding the licensed port count. Derive each port's phylink
> > capabilities from its phy-mode.
> >=20
> > Enable "DSA custom rules" tagging for all frames during setup. This
> > directs ingress traffic from user ports to the CPU port while standalon=
e
> > ports remain isolated. Enable and disable port ingress and egress
> > through the DSA port callbacks, and disable tagging again during
> > teardown so that unbinding the driver does not leave its managed
> > configuration active.
> >=20
> > Populate the integrated MDIO controller and mux child devices used for
> > external PHY access.
> >=20
> > Tested with a SoC-e MRS 25.01 IP core on a Xilinx ZynqMP platform.
> >=20
> > Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> > ---
> >  drivers/net/dsa/Kconfig              |   2 +
> >  drivers/net/dsa/Makefile             |   1 +
> >  drivers/net/dsa/soce/Kconfig         |  14 ++
> >  drivers/net/dsa/soce/Makefile        |   4 +
> >  drivers/net/dsa/soce/soce_dsa.h      |  26 +++
> >  drivers/net/dsa/soce/soce_dsa_core.c | 343 +++++++++++++++++++++++++++=
++++++++
> >  6 files changed, 390 insertions(+)
> >=20
> > diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> > index fe8cd5338fda..879fbede83f0 100644
> > --- a/drivers/net/dsa/Kconfig
> > +++ b/drivers/net/dsa/Kconfig
> > @@ -94,6 +94,8 @@ source "drivers/net/dsa/ocelot/Kconfig"
> > =20
> >  source "drivers/net/dsa/qca/Kconfig"
> > =20
> > +source "drivers/net/dsa/soce/Kconfig"
> > +
> >  source "drivers/net/dsa/sja1105/Kconfig"
> > =20
> >  source "drivers/net/dsa/xrs700x/Kconfig"
> > diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
> > index 7e637d56b35c..97de3d181440 100644
> > --- a/drivers/net/dsa/Makefile
> > +++ b/drivers/net/dsa/Makefile
> > @@ -26,4 +26,5 @@ obj-y				+=3D ocelot/
> >  obj-y				+=3D qca/
> >  obj-y				+=3D realtek/
> >  obj-y				+=3D sja1105/
> > +obj-y				+=3D soce/
> >  obj-y				+=3D xrs700x/
> > diff --git a/drivers/net/dsa/soce/Kconfig b/drivers/net/dsa/soce/Kconfi=
g
> > new file mode 100644
> > index 000000000000..c31b7c5af695
> > --- /dev/null
> > +++ b/drivers/net/dsa/soce/Kconfig
> > @@ -0,0 +1,14 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +config NET_DSA_SOCE
> > +	tristate "SoC-e switches"
> > +	depends on NET_DSA
> > +	depends on OF
> > +	depends on HAS_IOMEM
> > +	select MDIO_BUS_MUX_MMIOREG
> > +	select MDIO_SOCE
> > +	select NET_DSA_TAG_SDSA
> > +	help
> > +	  This enables support for switches based on SoC-e IP cores.
> > +	  Frames are exchanged with the CPU port using the SDSA DSA tag proto=
col.
> > +	  The driver supports switch variants whose features and number of po=
rts
> > +	  are selected at synthesis time and detected at runtime.
> > diff --git a/drivers/net/dsa/soce/Makefile b/drivers/net/dsa/soce/Makef=
ile
> > new file mode 100644
> > index 000000000000..2a6d95ef663f
> > --- /dev/null
> > +++ b/drivers/net/dsa/soce/Makefile
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +obj-$(CONFIG_NET_DSA_SOCE) +=3D soce_dsa.o
> > +soce_dsa-objs :=3D soce_dsa_core.o
> > diff --git a/drivers/net/dsa/soce/soce_dsa.h b/drivers/net/dsa/soce/soc=
e_dsa.h
> > new file mode 100644
> > index 000000000000..2acd4dbaf958
> > --- /dev/null
> > +++ b/drivers/net/dsa/soce/soce_dsa.h
> > @@ -0,0 +1,26 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2020-2026 System on Chip engineering, S.L.
> > + * Copyright (c) 2026 Linutronix GmbH
> > + * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
> > + */
> > +
> > +#ifndef __SOCE_DSA_H
> > +#define __SOCE_DSA_H
> > +
> > +#include <linux/types.h>
> > +
> > +#include <net/dsa.h>
> > +
> > +#define SOCE_MAX_NUM_PORTS 31
> > +
> > +struct soce_dsa_local {
> > +	void __iomem *base_addr;
> > +};
> > +
> > +struct soce_priv {
> > +	struct soce_dsa_local local;
> > +	struct dsa_switch ds;
> > +};
> > +
> > +#endif /* __SOCE_DSA_H */
> > diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soc=
e/soce_dsa_core.c
> > new file mode 100644
> > index 000000000000..d391b11b94ad
> > --- /dev/null
> > +++ b/drivers/net/dsa/soce/soce_dsa_core.c
> > @@ -0,0 +1,343 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2020-2026 System on Chip engineering, S.L.
> > + * Copyright (c) 2026 Linutronix GmbH
> > + * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/of.h>
> > +#include <linux/of_net.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/phy.h>
> > +#include <linux/phylink.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <net/dsa.h>
> > +
> > +#include "soce_dsa.h"
> > +
> > +#define SOCE_MIN_NUM_PORTS			3
> > +
> > +#define SOCE_CORE_VERSION_OFFSET		0x0000
> > +#define SOCE_CORE_VERSION_VERSION_SHIFT		24
> > +#define SOCE_CORE_VERSION_SUBVERSION_SHIFT	16
> > +#define SOCE_MIN_CORE_VERSION			0x24
> > +#define SOCE_MIN_CORE_SUBVERSION		0x01
> > +
> > +#define SOCE_LIC_FEATURES_OFFSET		0x0004
> > +#define SOCE_LIC_FEATURES_NUM_PORTS_MASK	GENMASK(31, 27)
> > +
> > +#define SOCE_IMPL_FEATURES0_OFFSET		0x000c
> > +#define SOCE_IMPL_FEATURES0_NUM_PORTS_MASK	GENMASK(31, 27)
> > +#define SOCE_IMPL_FEATURES0_PORT_VLAN		BIT(9)
> > +#define SOCE_IMPL_FEATURES0_DSA			BIT(23)
> > +
> > +#define SOCE_DSA_REGS_BASE			0x1200
> > +#define SOCE_TAG_ALL_FRAMES_CTRL_OFFSET		(SOCE_DSA_REGS_BASE + 0x001c)
> > +#define SOCE_TAG_ALL_FRAMES_CTRL_ENABLE		BIT(0)
> > +#define SOCE_CUSTOM_RULES_TAGGING_OFFSET	(SOCE_DSA_REGS_BASE + 0x0020)
> > +#define SOCE_CUSTOM_RULES_TAGGING_ENABLE	BIT(0)
> > +
> > +#define SOCE_PORTS_REGS_BASE			0x3000
> > +#define SOCE_PORTS_SELECTOR_OFFSET		SOCE_PORTS_REGS_BASE
> > +#define SOCE_PORTS_SELECTOR_PORT_MASK		GENMASK(7, 0)
> > +#define SOCE_PORTS_CTRL_OFFSET			(SOCE_PORTS_REGS_BASE + 0x0004)
> > +#define SOCE_PORTS_CTRL_INGR_EN			BIT(0)
> > +#define SOCE_PORTS_CTRL_EGR_EN			BIT(1)
> > +
> > +static void soce_phylink_get_caps(struct dsa_switch *ds, int port,
> > +				  struct phylink_config *config)
> > +{
> > +	struct dsa_port *dp =3D dsa_to_port(ds, port);
> > +	phy_interface_t mode;
> > +	int ret;
> > +
> > +	ret =3D of_get_phy_mode(dp->dn, &mode);
> > +	if (ret)
> > +		return;
> > +
> > +	if (phy_interface_mode_is_rgmii(mode))
> > +		phy_interface_set_rgmii(config->supported_interfaces);
> > +	else
> > +		__set_bit(mode, config->supported_interfaces);
> > +
> > +	config->mac_capabilities =3D MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
> > +
> > +	switch (mode) {
> > +	case PHY_INTERFACE_MODE_MII:
> > +		config->mac_capabilities |=3D MAC_10 | MAC_100;
> > +		break;
> > +	case PHY_INTERFACE_MODE_GMII:
> > +		config->mac_capabilities |=3D MAC_10 | MAC_100 | MAC_1000;
> > +		break;
> > +	case PHY_INTERFACE_MODE_RMII:
> > +		config->mac_capabilities |=3D MAC_10FD | MAC_100FD;
> > +		break;
> > +	default:
> > +		if (phy_interface_mode_is_rgmii(mode))
> > +			config->mac_capabilities |=3D MAC_10FD | MAC_100FD |
> > +						    MAC_1000FD;
> > +		break;
> > +	}
> > +}
> > +
> > +static int soce_sw_validate_core_version(u8 version, u8 subversion)
> > +{
> > +	if (version < SOCE_MIN_CORE_VERSION ||
> > +	    (version =3D=3D SOCE_MIN_CORE_VERSION &&
> > +	     subversion < SOCE_MIN_CORE_SUBVERSION))
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
> > +
> > +static void soce_sw_read_core_version(struct soce_dsa_local *local,
> > +				      u8 *version, u8 *subversion,
> > +				      u16 *revision)
> > +{
> > +	u32 regval;
> > +
> > +	regval =3D readl(local->base_addr + SOCE_CORE_VERSION_OFFSET);
> > +	*version =3D (u8)(regval >> SOCE_CORE_VERSION_VERSION_SHIFT);
> > +	*subversion =3D (u8)(regval >> SOCE_CORE_VERSION_SUBVERSION_SHIFT);
> > +	*revision =3D (u16)regval;
> > +}
> > +
> > +static int soce_sw_detect_features(struct soce_dsa_local *local,
> > +				   u32 *numports)
> > +{
> > +	void __iomem *base =3D local->base_addr;
> > +	u32 implemented_numports;
> > +	u32 licensed_numports;
> > +	u32 regval;
> > +
> > +	regval =3D readl(base + SOCE_LIC_FEATURES_OFFSET);
> > +	licensed_numports =3D FIELD_GET(SOCE_LIC_FEATURES_NUM_PORTS_MASK, reg=
val);
> > +	if (!licensed_numports || licensed_numports > SOCE_MAX_NUM_PORTS)
> > +		return -EINVAL;
> > +
> > +	regval =3D readl(base + SOCE_IMPL_FEATURES0_OFFSET);
> > +	if (!(regval & SOCE_IMPL_FEATURES0_DSA))
> > +		return -ENODEV;
> > +
> > +	implemented_numports =3D
> > +		FIELD_GET(SOCE_IMPL_FEATURES0_NUM_PORTS_MASK, regval);
> > +	if (implemented_numports < SOCE_MIN_NUM_PORTS ||
> > +	    implemented_numports > licensed_numports)
> > +		return -EINVAL;
> > +
> > +	*numports =3D implemented_numports;
> > +
> > +	return 0;
> > +}
> > +
> > +static void soce_sw_enable_tagging(struct soce_dsa_local *local)
> > +{
> > +	void __iomem *base =3D local->base_addr;
> > +	u32 regval;
> > +
> > +	regval =3D readl(base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> > +	regval |=3D SOCE_TAG_ALL_FRAMES_CTRL_ENABLE;
> > +	writel(regval, base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> > +
> > +	regval =3D readl(base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
> > +	regval |=3D SOCE_CUSTOM_RULES_TAGGING_ENABLE;
> > +	writel(regval, base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
> > +}
> > +
> > +static void soce_sw_disable_tagging(struct soce_dsa_local *local)
> > +{
> > +	void __iomem *base =3D local->base_addr;
> > +	u32 regval;
> > +
> > +	regval =3D readl(base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> > +	regval &=3D ~SOCE_TAG_ALL_FRAMES_CTRL_ENABLE;
> > +	writel(regval, base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> > +
> > +	regval =3D readl(base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
> > +	regval &=3D ~SOCE_CUSTOM_RULES_TAGGING_ENABLE;
> > +	writel(regval, base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
> > +}
> > +
> > +static void soce_port_select(struct soce_dsa_local *local, int port)
> > +{
> > +	writel(FIELD_PREP(SOCE_PORTS_SELECTOR_PORT_MASK, port),
> > +	       local->base_addr + SOCE_PORTS_SELECTOR_OFFSET);
> > +}
> > +
> > +static void soce_port_set_enabled(struct soce_dsa_local *local, int po=
rt,
> > +				  bool enabled)
> > +{
> > +	void __iomem *base =3D local->base_addr;
> > +	u32 regval;
> > +
> > +	soce_port_select(local, port);
> > +
> > +	regval =3D readl(base + SOCE_PORTS_CTRL_OFFSET);
> > +	if (enabled)
> > +		regval |=3D SOCE_PORTS_CTRL_INGR_EN | SOCE_PORTS_CTRL_EGR_EN;
> > +	else
> > +		regval &=3D ~(SOCE_PORTS_CTRL_INGR_EN | SOCE_PORTS_CTRL_EGR_EN);
> > +	writel(regval, base + SOCE_PORTS_CTRL_OFFSET);
> > +}
> > +
> > +static int soce_port_enable(struct dsa_switch *ds, int port,
> > +			    struct phy_device *phy)
> > +{
> > +	struct soce_priv *priv =3D ds->priv;
> > +
> > +	soce_port_set_enabled(&priv->local, port, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static void soce_port_disable(struct dsa_switch *ds, int port)
> > +{
> > +	struct soce_priv *priv =3D ds->priv;
> > +
> > +	soce_port_set_enabled(&priv->local, port, false);
> > +}
> > +
> > +static int soce_setup(struct dsa_switch *ds)
> > +{
> > +	struct soce_priv *priv =3D ds->priv;
> > +
> > +	soce_sw_enable_tagging(&priv->local);
>=20
> Once all the setup is finished, what is the state of the switch?
>=20
> What we want is that the user ports are isolated from each other, and
> can only exchange frames with the CPU. That makes the hardware
> basically a port expander, and you do bridging in software. Later
> patches can then add offload of bridging, and whatever else the
> hardware can do, which Linux can also do in software.

That is exactly the state I want to achieve after the setup.

Although there are options to configure various filters, mirrors, and
special DSA tagging, none of them make sense for initial Linux driver.
Therefore, I only enable =E2=80=9CDSA tagging=E2=80=9D for all packets so t=
hat the ports
are separated and everything is forwarded to the CPU port.

I noticed some unusual behavior in two areas for which I have not found
an explanation in the documentation.
- If the VLAN port feature is disabled during synthesis, the VLAN tags
  are removed on ingress to the CPU port.
- If the STP offloading feature is enabled during synthesis, forwarding
  between ports does not work.

I therefore tried to address and document this during the setup so that
DSA would work correctly under Linux.

After setup, the output of "ip a" tool looks something like this:
1: end0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1508 qdisc mq state UP ...
2: PORT_0@end0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 ...
3: PORT_1@end0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 ...

Software bridging basically works this way, too. However, Sashiko
rightly pointed out that I broke bridging with the later patch for VLAN
offloading, when the feature isn't enabled.
But I'll address that separately there.

>=20
> 	Andrew

Thanks,
Vasilij

