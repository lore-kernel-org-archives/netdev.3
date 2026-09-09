Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A85D569F11;
	Wed,  9 Sep 2026 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982150; cv=none; b=OsK9kn9cQtuRpSlAmC83bsJy3YFKa8cyJgR28Znlddj72rYHxPktoonp1e4Cwv++SVzjyfACcopEX3UXUVqsXqkY/yUiK5N54+Fa+yDR9NMfPgQbbg2vjif/2/cIqavIR1DwiGGceG6wNOql86PO3pCHTs/Nm9qZtF/vaAQfw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982150; c=relaxed/simple;
	bh=u0C7UNcPm9Vs1Nhb8pf/Brf+J5IEED1yVMFPRSAcarI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t1LU4HesWXwOID8a9Lus3cHQH/h8zyCliRQu+vIrS5+WRanLb5z4rfB/FV6k0gFVgInJIzArCv73YcpMHo7fyWxw6MkQ8gkGccarDTNscavWvhnP2GNsYANZsGS9rpBTN19Dq+q+4aSyaasfZvYTPbRqdG0faTY9ZNlbCn1RRqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BDhaYE1p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BBW4B77D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BDhaYE1p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BBW4B77D"
Message-ID: <ab7e4eeed1b8296188355413cce1aa2b2aa5c670.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788982140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9law9+CgCfDsQ6flDKJswQTstAjtY8tODH32Z4bNGQM=;
	b=BDhaYE1pGmhk3Cm4cto9WTwk5b6VM9sENFMpKrfGMlXOZCag4k9V67DS7PSd/wlwzdFo4u
	eAPUoOIW4NyYRYdaHRKJ4kEfqjUzm4GMOHabQKrMVmyLVVqmD66GaqNZlpY4gE8FKMt8oP
	8wTH5r0MLlI7Y9ptY7j857BmvlQzCL+TVIuxuIgodU6snMkhnUtvxLB102xaBHM8u8Q432
	wMYoVqnYsp+XBayxlj17gCYGDWnvy+tD6WS3QSoauFapWMqVSIkAkvCKwSoweqvQOD5KoK
	qUh3xe/Hk0BX6xECWNS0DlN+0Nsbpdg7WZOpinCAg8gjyTv3oxDLV+Q2UfcM2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788982140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9law9+CgCfDsQ6flDKJswQTstAjtY8tODH32Z4bNGQM=;
	b=BBW4B77DQ3V2MvL1l2g1Dem5WdUOUTvAQlu8+VqHwscTGtrU9at8BqbnBQZU+o8+SQHTD5
	X1FrURFXZYvRlHDA==
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
Date: Wed, 09 Sep 2026 21:28:59 +0200
In-Reply-To: <5c955c96-7883-4e59-97ef-9fc3b63abf58@lunn.ch>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
	 <3c2c5b39-6a7d-4cb2-af1c-b5015b6bf1e8@lunn.ch>
	 <db26d5c9262069a11e5cbe00e176b81e40baebeb.camel@linutronix.de>
	 <5c955c96-7883-4e59-97ef-9fc3b63abf58@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-08 at 21:20 +0200, Andrew Lunn wrote:
> > > What is the MDIO master?
> >=20
> > It refers to the switch-integrated MDIO controller: one shared set of
> > MMIO transaction registers serving multiple selectable MDIO buses. The
> > switch documentation calls it an MDIO bridge. I will rename "master" to
> > "controller".
>=20
> In Linux, we have the concept of MDIO muxes. You have one true MDIO
> bus master, and then logic gates to connect it to many MDIO
> busses. Generally, the MDIO data line has a set of analogue switches
> to mux it to one of the many MDIO busses.
>=20
> Having only one true MDIO bus master means you cannot do transactions
> in parallel.

That's true. I had already considered using an MDIO mux for v2, but
decided to retain the existing implementation while addressing the other
feedback first.

> It seems like this is how this hardware works. The question is, should
> we model it this way. Take a look at mdio-mux-mmioreg.c. Maybe the
> MDIO bus driver can be placed into drivers/net/mdio, and a
> mdio-mux-mmioreg stacked on top of it to provide the per port MDIO
> busses. That will make the locking simpler, and remove a lot of code.
>=20

For the next revision, I will try to implement this model. The MDIO
controller will become a standalone driver under mdio and register a
single parent mii_bus. A generic mdio-mux-mmioreg instance will then
provide the per-port child buses. Something like this:

ethernet-switch@xy {
    /* ... */

    mdio_parent: mdio@204 {
        compatible =3D "soce,swip-mdio-23-02";
        reg =3D <0x204 0xc>, <0x200 0x4>;
        reg-names =3D "data", "control";
    };

    mdio-mux@200 {
        compatible =3D "mdio-mux-mmioreg", "mdio-mux";
        reg =3D <0x200 0x4>;
        mux-mask =3D <0x1f0000>;
        mdio-parent-bus =3D <&mdio_parent>;
        #address-cells =3D <1>;
        #size-cells =3D <0>;

        mdio@0 {
            reg =3D <0>;
            /* PHYs connected to port 0 */
        };

        mdio@10000 {
            reg =3D <0x10000>;
            /* PHYs connected to port 1 */
        };
    };

    /* ethernet-ports ... */
};

This requires a separate binding and compatible string for the MDIO
controller. I currently have soce,swip-mdio.yaml and the
register-layout-specific soce,swip-mdio-23-02 in mind, although I still
need to consider the naming.

> 	Andrew

Thanks,
Vasilij
