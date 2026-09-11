Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E211A3160;
	Fri, 11 Sep 2026 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133985; cv=none; b=PKKa4EtFLJ/OyWowJL29KDLlluR5ifajCFcXarma0IbT4v+HmmnJmQaXIF8RGbp6qyUpUtTrLy9gLxeG8qtyLHCIgI2KK2PUB+fgc2z6JzCHas0PmMPvTXi18as0JCZtHZBnFyYvPIRDgy+xdwJoM9wnJc+9LImIUJ6Ofy80OwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133985; c=relaxed/simple;
	bh=PNYXgyMDUY5bMW1ZSxLuNPSzkeTTQt9eT//zOuecSYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rHAkC2UfG+Hzvd+OG3vh9JC5KjPlJK99cKusETTKEV8TC0f0SpoPXDs7/6uQcH/jYjKbecsaVnN46IQGlQ7O3bu533vd54BorKFeO1caVCF0R+Ss1JYqOewu1AYFlM3aXTcGwK9gMrZmo4qCSsSpcjPHMT3GWPJ2FOT81Z5axSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTARfYGq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VvHVfYsp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTARfYGq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VvHVfYsp"
Message-ID: <64630356f2313d95c2d4a249d52c97d90e1504ef.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789133979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBI8A7N63tfooEoifK+8mpYyVON44PxmUCXA3J1l9dA=;
	b=bTARfYGq5GqxZQUDcFmz55jKi+oj8Ru3ObVKKtPEv2qrjj+JFx8RMG6xeNQynrIQmYL1tg
	njVUsJsHqmuZxzHlOmk5T7zL4mKxVdvOlBROGtWMLVKbz1bYtJJJZs6edPjg5hlGSEvrmU
	eJsd+rfWmKXVpxloAK3ayOQIcn0oRwFh9SB9tAumiyPPL2eN7OkoDrdmeuu9au9Jv31Siq
	nuMxL5OVHt7E7ZBESKjrKOEg+dj21DkIiNrtXRRduQfrOjVIVgHKnR4nE8Y51wYBIyaKO3
	Zbp8dbvqfMuM9nqaJNfaSgsusQ6qzTFd8MeZS7vSFzbmqkpc16QdynBLkjttbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789133979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBI8A7N63tfooEoifK+8mpYyVON44PxmUCXA3J1l9dA=;
	b=VvHVfYspSGx1Z1w/qkMjiQeJywotKUsXn2p++5W3GcunBUQm9fP9F8aXxPycVU4IJ+Ndku
	4P6ijX+wQn2gD2DQ==
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
Date: Fri, 11 Sep 2026 15:39:34 +0200
In-Reply-To: <5bc95ef2-4e23-4c80-af17-07aa3643bebf@lunn.ch>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
	 <371fe855-e21f-4d53-a13f-4486494c8ae1@lunn.ch>
	 <42efedd837c1631b38849693e1d66bd2b1fb1529.camel@linutronix.de>
	 <5bc95ef2-4e23-4c80-af17-07aa3643bebf@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-10 at 17:07 +0200, Andrew Lunn wrote:
> Thanks for this list.
>=20
> > ---
> > Global register block at 0x0000 (three registers currently used)
> > 	0x00 Core Version - Major and minor revision number (RO)
> > 	0x04 Licensed Features (RO)
> > 	0x08 Reserved
> > 	0x0C GUI Configuration - Implemented Features 0 (RO)
> > 	0x10 GUI Configuration - Implemented Features 1 (RO)
>=20
> GUI? I assume this is not Graphical User Interface, but something
> else?
>=20

It actually stands for Graphical User Interface. This refers to
configuration in a graphical IDE, where the bitstream is customised and
synthesized.
"Implemented Features" can be enabled/disabled and configured there by
clicking on the respective checkboxes or options within the graphical
interface.

> > 	Licensed Features Register (RO) (Bits specify if the given
> > 	feature is enabled by license):
> > 	[31:27] - Maximum Number of Ports: These bits specify the maximum
> > 	number of ports licensed
> > 	[26:15] - Reserved
> > 	- ACL: Access Control List (ACL) feature
> > 	- LLDP: LLDP feature
> > 	- IEEE 802.1X
> > 	- IEEE 802.1AX-2008 - Link Aggregation
> > 	- IEEE 802.3br/IEEE 802.1Qbu - Preemption
> > 	- IEC 61158-4-2 - DLR
> > 	- IEC 62439-2 - MRP
> > 	- IGMP Snooping
> > 	- Port mirroring
> > 	- IEEE 802.1s - MSTP
> > 	- IEEE 802.1w - RSTP
> > 	- IEEE 1588 - Transparent Clock
> > 	- Switch mode: managed or unmanaged
>=20
> This is probably something which should be tested in the probe
> method. No point loading the driver if it cannot be managed.
>=20

"DSA" functionality is already tested and according to the
documentation, this excludes unmanaged variants. Therefore, I wouldn't
add an additional test for this.

> > 	- Secure Chip
> > 	- Time Limitation
>=20
> What do these two mean?
>=20

Took me some time to find this info. These are license-protection
features. "Security Chip" authenticates the IP license using an external
1-Wire security device, while "Time Limitation" restricts evaluation
licenses to a configured operating period. Neither is relevant to the
driver.

> > 	MDIO - Control
> > 	[26:16] - Bus selection: These bits specify the port number over
> > 	which MDIO operation is performed.
>=20
> 10 bits, which allows more MDIO busses than ports!

Actually 11 bits. However, too much. This may be a documentation error,
since the original driver also used only bits 20:16. I will clarify
this and if it's true, somehow address it as part of the MDIO/mux
rework.

>=20
> > > I also wounder at the name. Does the data sheet really call it DSA?
> > >=20
> >=20
> > Yes, there is even a chapter describing Distributed Switch Architecture
> > (DSA) as "a subsystem that was primarily designed to support specific
> > vendor switches using Linux, ..." followed by information about "custom
> > DSA tagging".
>=20
> Does the switch support the D in DSA?
>=20

Not as far as I understand. The hardware provides custom frame tagging
between the CPU and a single switch. I found no indication that it
supports cascaded switch trees or encodes a target switch identity in
the tag.

>=20
Thanks,
Vasilij


