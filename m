Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972D418A23;
	Mon,  3 Aug 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770992; cv=none; b=jv0+aUm2vAL1I5Vb0q5h7d9O//UIM4cVNJAeCPFfjrtvmSCL/pbpe8yQWLy1ITgiBXcPvSGN95ejqEGinJClfNYdYiKaBWt1gxcJ9VVZoc/Krevoeq0gLB+wxQY2hhEiQ3/6znDmhv4muVg9ix9M/TWU0ajwxpli5XaOW+fJATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770992; c=relaxed/simple;
	bh=ameqDFz0oeEL2INETp2pMBE7xFtfj4U7kxLLm+ljRNo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N1GCrl8q1+3eT4gxcKSpFualYX3qmPrN9C32yOXrBFwRMwN/PDM5nAeFhFTMfjWbxMWInQVzjalecjpXngF/eY2SN5I6EGs2bvenSOXfTGN+QTsN3AYC9zygZdR14sktMoJfEX8KXR6Rj29vf7h96aR5HUt24jZjiAdHOltcdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z48bHmSP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cODu3/p1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z48bHmSP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cODu3/p1"
Message-ID: <cc7b7a56557d30be86097640a26f455d7262ff4b.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785770988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yFtqeWfA3AVUM+Pjcekz30yuARfXNqik/WMvs8n/Peg=;
	b=Z48bHmSP6xHQe2DQ4XsI000sxEah1RFotNfyjlSHD+WlJcdqwz0ZMGS3hg3CLnlWhpJcxh
	2znf9IX9iHNlbXLGK+NebUwajL30ZRK1cc1uhPEl4sG364P6zj9Nnc+xG+lt/jOnnhb1n0
	xuIF2dcOQpSg0jZP9fho1M3apbuBPAiHamMckY558wCdPOh8hM+3+Hhdcc8KqWBhEPed1u
	uTVkSPoM4OqS0QRGzx9FIpSyHuDPE8bEhZe56DARP+nzhGko/lAVK+bxB8FQB1DMcBs+zW
	KthuXPNqEk3Pr80CjeZVSj8gpJ3FGJlRzdyKyMAA5RHNGsawWx/ir+TSYQNZpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785770988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yFtqeWfA3AVUM+Pjcekz30yuARfXNqik/WMvs8n/Peg=;
	b=cODu3/p1WB+B0SvAJ9Uw993TUcmPbzY7aM8bhROEbXDU1OjbXhcg7uGh8Yp+dhCWclKQSQ
	djrh2ZkhT0DpzKDQ==
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
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
Date: Mon, 03 Aug 2026 17:29:47 +0200
In-Reply-To: <879a1366-872d-4bad-8bec-fa8a7ee82dab@lunn.ch>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	 <879a1366-872d-4bad-8bec-fa8a7ee82dab@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-29 at 19:11 +0200, Andrew Lunn wrote:
> > +description: |
> > +  This node is the MDIO-bus device entry for the SoC-e DSA switch driv=
er.
> > +  It is a lightweight configuration node that lives on the MDIO bus of=
 the
> > +  SoC Ethernet controller acting as the DSA conduit (CPU port).
>=20
> Must it be the conduit interfaces MDIO bus? There are boards which
> exist using Marvell switches where the MDIO bus of the conduit
> interface is not a Linux MDIO bus, because it is an intel i210, and
> intel likes reinventing the wheel and does not use the Linux MDIO bus
> infrastructure. So the MDIO interface of the switch is connected to
> two GPIOs and a Linux bit bashing MDIO bus is used.
>=20
There are synthesis options for various management interfaces. MDIO and
MMIO are two of them. I only have one variant for the memory-mapped
version. For v2, I'll discard everything else and update the
documentation accordingly.

> > +  soce,num-ports:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Total number of switch ports (external/user ports plus the CPU u=
plink
> > +      port). Must be greater than zero and not exceed the selected IP =
variant.
>=20
> Why is this needed if we already have a description of the ports?

Not needed, I will change it in the next version.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0Andrew

Thanks,
Vasilij
