Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB7D3D9DAC;
	Tue,  9 Jun 2026 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988900; cv=none; b=QT0ngWeLwpE5jSKyh5SD74kIMFppnsVDJlFuOgV1WKkOebRQY4Vkznvzko9/lhu1XNkIX3pU7rR/LoS+IAhUEHs/hjZ6lBQhpRicq/XldIM1Qf/i4w+LSpIZVUReTetoBSPkZJmTsRjxvZaPJ/cULjCFCFPYfkqYzjNazET+3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988900; c=relaxed/simple;
	bh=bSXm0ozdYzUpty8xJzGSdVF2x1B6U+KwGok9c9C0ICI=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E70MD7l3wz/wXnrOUKWMfmpLJxh5ks3yuJyLrmIOv1PEGCSLbeKdDTix/hkU1RU4jMDXhpy/8TG10fosM8VLtwOPAc1vaocpK76Bp4eSwdevurjB6RvOLMDv3k4pM0xBZJyFm95/vLWcYOy4gB3VWam5gV/n1X/z2p+0CERAP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uRpi2WRs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uRpi2WRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780988900; x=1812524900;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bSXm0ozdYzUpty8xJzGSdVF2x1B6U+KwGok9c9C0ICI=;
  b=uRpi2WRsCx2mpPDzsW8GSFUGK9ia/EYDA3LnSC1ymLZflg2C9fYpLPl0
   wUDMCmEhD0wh3/DGzimBnEOucljhCFqkpBJ36+8J5nMw+KYs7hNCHHWyN
   FwHHwzAhjP5kHSHGyu9DqGO82gdiDlOVM+pxq0viPBQLX7IpMpEEZ7TlG
   bRi+HJfAvxD7M/PHLE3gDMeB0jtqSjB095/xHrDqbRlIylqCujR2y95/V
   NxpDBx3THQoBFMCMVIiQbMYBNihEbLeFIJDGwfIP517lrEdxQlJonmFys
   ELWftTsQcOdQH+WyMtnTqFNhkRXvZlB+xwzc4i96PqoC4RI+pC74O8hJg
   w==;
X-CSE-ConnectionGUID: izW42HxjT1afFW1YFfqUoA==
X-CSE-MsgGUID: qaRcAMdNSDejHtAuDuej6Q==
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="58812603"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:08:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 9 Jun 2026 00:08:17 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 9 Jun 2026 00:08:14 -0700
Message-ID: <a9ab4d129f2e3158c1a7b01d0a975fac00a05893.camel@microchip.com>
Subject: Re: [PATCH net-next v7 4/9] net: dsa: lan9645x: add basic dsa
 driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung
 Huh <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Tue, 9 Jun 2026 09:08:13 +0200
In-Reply-To: <9ee993d0-9a71-48ff-b368-fcebe1ee9e48@lunn.ch>
References: <20260603-dsa_lan9645x_switch_driver_base-v7-0-b2f90e676707@microchip.com>
	 <20260603-dsa_lan9645x_switch_driver_base-v7-4-b2f90e676707@microchip.com>
	 <9ee993d0-9a71-48ff-b368-fcebe1ee9e48@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-08 at 20:00 +0200, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > +     dsa_switch_for_each_user_port(dp, ds) {
> > +             if (dp->cpu_dp->ds !=3D ds) {
> > +                     dev_err(ds->dev,
> > +                             "NPI port on a remote switch is not suppo=
rted\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (first_cpu_dp && dp->cpu_dp !=3D first_cpu_dp) {
> > +                     dev_err(ds->dev, "Multiple NPI ports not supporte=
d\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             first_cpu_dp =3D dp->cpu_dp;
>=20
> The reason i asked about NPI ports is because this is looping over
> user ports. Yet you say one of these user ports is a CPU port. That
> cannot be correct.
>=20
> The first port returned by dsa_tree_for_each_cpu_port() would be
> first_cpu_dp.
>=20
>         Andrew


I tried to mimic the approach in drivers/net/dsa/ocelot/felix.c:

static int felix_tag_npi_setup(struct dsa_switch *ds)
{
	struct dsa_port *dp, *first_cpu_dp =3D NULL;
	struct ocelot *ocelot =3D ds->priv;

	dsa_switch_for_each_user_port(dp, ds) {
		if (first_cpu_dp && dp->cpu_dp !=3D first_cpu_dp) {
			dev_err(ds->dev, "Multiple NPI ports not supported\n");
			return -EINVAL;
		}

		first_cpu_dp =3D dp->cpu_dp;
	}

	if (!first_cpu_dp)
		return -EINVAL;

	felix_npi_port_init(ocelot, first_cpu_dp->index);

	return 0;
}

Perhaps I misunderstand you, but there could be confusion about
terminology. The chip designers have a concept of CPU port, which is
used liberally in the datasheet, and in this driver code.

However, the concept is different from the DSA concept of a CPU port.
Let us call the first switch CPU port, and the second DSA CPU port.

The port we want to use as a DSA CPU port, i.e. the port with the
'ethernet =3D <&host_port>;' property in the device tree, will be
configured to be an NPI port for injection/extraction for the switch CPU
port (which is not a physical port on the device).

Therefore, this NPI port is not iterated by
dsa_switch_for_each_user_port. The switch CPU port (index 9) is also not
iterated by it. It is a chip internal construct with no representation
in the device tree, and no struct dsa_port.


Thanks,
Emil

