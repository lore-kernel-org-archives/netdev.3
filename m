Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891AD442FD4;
	Tue, 11 Aug 2026 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450751; cv=none; b=NXr6BwIU2++lBa/O5hOMJ6LD5T2D2eFTWw65UmiqNMUErZ05EVGOC0p5YAVI/1K2G166s56yCY8FUiAYsqWPnGFbqIex7T6teq1PeWoW7YE7NiSo81lxyIRd5Z89DoW6C47+SMC+M0qiXtPZUP2Jg7YUUF1dYi1ARhbrDqXLy8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450751; c=relaxed/simple;
	bh=RLEgXrH4xHJ6daXcALYh+WZHXmctkuyAzNXoL723OXA=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XY2mYsE3yrDbWqZUwTORBZ9r5SOQjxzgzKBQIrAmVfu3n+yhK+PkNInKBAe8+gBDkaPq7wQzshsata2dixF5+eS1wmQNJT5Z99+WHXkPl9t27wxPxWMa9CIT4UcQCip8Q6BmAs7Z+x2Hb2Lsi1JxFAZzVyUYf65YhU0bDB25rQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nF7y/OCM; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nF7y/OCM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786450749; x=1817986749;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLEgXrH4xHJ6daXcALYh+WZHXmctkuyAzNXoL723OXA=;
  b=nF7y/OCMBgq15Qty+oY//rKzJjhMG6yBtZxJt4oW4IzEtPXIC5UU8zUS
   UNYFNKC3+7YQDD3jI+lUR0bnlsZsFjN2Qjbrm3Mi+SmuXQTH09U/RchHT
   82JtHMhjf/5U4122U7actJIZVYDWq8mfdVvJdlYArbMzM1MS0GD8ZIWmI
   Rhhqxd6YComcmptklyv1j8Qg+Dp1xylh8nRgTgXZzJOVklo1ZC2q3G3/P
   C+vTh2yAeMtYGMbk07vIOoOTaIU0ACuRPET3Caw+n6izyKqlFA+DhNP3D
   cthqUR15pqTeglNUZZ4gQQIgTEXOz+WpVJfh1yF1f6RPDur/FtRfn2P6h
   A==;
X-CSE-ConnectionGUID: KnvL+GYFRX29jpRCffIpKQ==
X-CSE-MsgGUID: ck5Iq4o4SrqrmX3T61iPXw==
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="293333464"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2026 05:19:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 11 Aug 2026 05:19:02 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 11 Aug 2026 05:18:59 -0700
Message-ID: <60624adcceaede20875f10902b09e30f041af2fe.camel@microchip.com>
Subject: Re: [PATCH net-next v11 0/9] net: dsa: add DSA support for the
 LAN9645x switch chip family
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>, "Andrew
 Lunn" <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Russell
 King" <linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Tue, 11 Aug 2026 14:18:58 +0200
In-Reply-To: <16b71fd7-9911-429b-a5a0-577f6ba0e999@redhat.com>
References: <20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a@microchip.com>
	 <16b71fd7-9911-429b-a5a0-577f6ba0e999@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-11 at 12:35 +0200, Paolo Abeni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On 8/5/26 4:34 PM, Jens Emil Schulz =C3=98stergaard wrote:
> > This series provides the Microchip LAN9645X Switch driver.
> >=20
> > The LAN9645x is a family of chips with ethernet switch functionality an=
d
> > multiple peripheral functions. The switch delivers up to 9 ethernet
> > ports and 12 Gbps switching bandwidth.
> >=20
> > The switch chip has 5 integrated copper PHYs, support for 2x RGMII
> > interfaces, 2x SGMII and one QSGMII interface.
> >=20
> > The switch chip is from the same design architecture family as ocelot
> > and lan966x, and the driver reflects this similarity. However, LAN9645x
> > does not have an internal CPU in any package, and must be driven
> > externally. For register IO it supports interfaces such as SPI, I2C and
> > MDIO.
> >=20
> > The chip supports a variety of network features such as
> >=20
> > * Mactable for MDB/FDB functionality
> > * Bridge forwarding offload
> > * VLAN-aware bridging
> > * IGMP/MLD snooping
> > * Link aggregation
> > * PTP timestamping
> > * FRER (802.1CB)
> > * Media Redundancy Protocol
> > * Parallel Redundancy and High-Availability Seamless Redundancy
> >   (HSR/PRP) in DANH/DANP mode
> > * Per stream filtering and policing
> > * Shapers such as Credit Based Shaping and Time Aware Shaing
> > * Frame preemption
> > * A TCAM (VCAP) for line-rate frame processing
> >=20
> > The LAN9645x family consists of the following SKUs:
> >=20
> > LAN96455F
> > LAN96457F
> > LAN96459F
> > LAN96455S
> > LAN96457S
> > LAN96459S
> >=20
> > The difference between the SKUs is the number of supported ports (5, 7
> > or 9) and features supported. The F subfamily supports HSR/PRP and TSN,
> > while the S subfamily does not.
> >=20
> > The intended way to bind this driver is using a parent MFD driver,
> > responsible for the register IO protocol, and distributing regmaps to
> > child devices. The goal is to use the same approach as the MFD driver i=
n
> > drivers/mfd/ocelot-spi.c.
> >=20
> > This driver expects to request named regmaps from a parent device. This
> > approach is similar to the DSA driver
> >=20
> > drivers/net/dsa/ocelot/ocelot_ext.c
> >=20
> > which supports being driven by an external CPU via SPI with parent
> > device drivers/mfd/ocelot-spi.c.
> >=20
> > The MFD driver will come in a later series, because there are
> > requirements on the number of child devices before a driver qualifies a=
s
> > a MFD device.
> >=20
> > Development is done using the LAN966x as a host CPU, running the lan966=
x
> > swichdev driver, using the EVB-LAN9668 EDS2 board.
> >=20
> > The datasheet is available here:
> > https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductD=
ocuments/DataSheets/LAN9645xF-Data-Sheet-DS00006065.pdf
> >=20
> > This series will deliver the following features:
> >=20
> > * Standalone ports
> > * Bridge forwarding and FDB offloading
> > * VLAN-aware bridge
> > * Stats integration
> >=20
> > More support will be added at a later stage. Here is a tentative plan o=
f
> > future patches for this DSA driver:
> >=20
> > * Add LAG support.
> > * Add MDB support.
> > * Add TC matchall mirror support.
> > * Add TC matchall police support.
> > * Add DCB/qos support.
> > * Add simple TC support: mqprio, cbs, tbf, ebf.
> > * Add TC flower filter support.
> > * Add HSR/PRP offloading support.
> > * Add PTP support.
> > * Add TC taprio support.
> >=20
> > For completeness I include tentative plan of planned patches for
> > LAN9645x peripherals:
> >=20
> > * Extend pinctrl-ocelot for LAN9645x:
> >   https://lore.kernel.org/linux-gpio/20260119-pinctrl_ocelot_extend_sup=
port_for_lan9645x-v1-0-1228155ed0ee@microchip.com/
> > * Add driver for internal PHY:
> >   https://lore.kernel.org/netdev/20260123-phy_micrel_add_support_for_la=
n9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com/
> > * MFD driver for managing register IO protocol and child device
> >   initialization.
> > * Extend pinctrl-microchip-sgpio for LAN9645x support.
> > * Extend i2c_designware for LAN9645x support.
> > * Add driver for outbound interrupt controller.
> > * Add serdes driver for lan9645x.
> >=20
> > Signed-off-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzosterga=
ard@microchip.com>
> I forwarded the feedback from sashiko/nipa, but sashiko gemini has more
> comments:
>=20
> https://sashiko.dev/#/patchset/20260805-dsa_lan9645x_switch_driver_base-v=
11-0-007ebc983a0a%40microchip.com
>=20
> please have a look and also to net-next commit c82ff94592fb
>=20
> /P
>=20
I will go through the comments from the sashiko brothers.

Thanks
Emil
