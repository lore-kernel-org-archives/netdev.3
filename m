Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670022;
	b=HBoa31Pgu7FIH+WxOfWmR5aUU4aTyOEbGq/lVH+5D1YGhn10POP7D1XgmxUsFU9LqT8e
	 FZdamjLv+CwneLEGYDgUVUqLVrBdOlRK1vS2wJUwW+RlfVbQT/lU2OSjqNDqmr+Kmy4By
	 +v0eLSyK1uPE4YAH4C4NwBojj+4gckIV/2GOuCZkLvwCdOVL4azpS0e+cCpb4R5LrTOGD
	 1SVrzbOz6o47tkSYvVpvT3yKMcfvcAEqCNGod9IQj/BM6vLlwTEeZGnB919E9XckZpuTD
	 O/Rn4nSlfjE5I/Yqzgb85AQRzh07UivFa4djTdcjzprRSH2j6skmEOAlPrrmuHd2GVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670022;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Message-ID:
	 Subject:From:To:CC:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=upfwtUV8EbGVUbWxxpiKAfBnHEyn8vCFzWrktWT3e7Q=;
	b=FhsZVpHX3HDVacKSH4K/sJgfY8xLVC8WYB/wUCOaBRsUXGdhRZYpbTxBpcVs90guNuEi
	 kwwX59ZDNpq77RH7Vm2C8C/n2bc6PaGYlgcKzZqCMw4C5KzFFpJKRuIEQdVt+HB07fhCt
	 1/ldNsyakiXC4AmILMJDuLqIC4Acw/eIHcw95q8dvZ+J5ZjikdU78+x/UIgJViF1zMAv2
	 E+VeoWOkpoOQnKLpCYB1a/P3dAiZ2CPHShbbKUx0FnUWlaQz3z1Mi21SBHpLJqR9OoopI
	 icHvDZgfE+HuHMRbFe+nysJVU/FgNEHKBC3g94NFncWrmYffqm2UhP8vRucwMMQtbBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=WpM4Orvt;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B60606A319;
	Thu, 22 Oct 2026 11:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3B60606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=WpM4Orvt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792670022; x=1824206022;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GmV0QCXgHw916achcJk5p19Gm0if1pq+xAF7kR4jJCc=;
  b=WpM4OrvtaAv4aiRB22ys+K1nUswmf0ZshStasZx4aeaboAIVhdHIgpEN
   JJJPlRGeHzirBRRYsE8AlY+MlPqSFNzqOiaaadSC0NJtb2+aMrA2+/24/
   Jm3FqEwOxpTo8FisuBmgIehTLbNtF9D992Rp9YKR50lQDzptxLdRLWRkn
   kqCRReLU4YN/0rDzPFfCXKu2W7K4GeCFPh10IHC6GMhiHPEJOg7/C96Yz
   onCCmzHadZSueT3RvMAnIaZSyrgP6hBFciOR03JnuXvNyJltKM6Jl1Tsv
   zUsQLkrpAfvY3ngH9B6qfF7qG8gltA8xO1oz10zRqUtjfdxfLVh0cjv6z
   Q==;
X-CSE-ConnectionGUID: dxq2WxxfQpiG7F6Qp0kFlg==
X-CSE-MsgGUID: Ym6nutdVTqakjpbYD/eCpg==
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="65412134"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 04:53:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 22 Oct 2026 04:53:40 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 22 Oct 2026 04:53:36 -0700
Message-ID: <abd2fba0ee9e1cb736eb9443d0af11fbbc7068d4.camel@microchip.com>
Subject: Re: [PATCH net-next v15 4/9] net: dsa: lan9645x: add basic dsa
 driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<geert+renesas@glider.be>, <magnus.damm@gmail.com>, <edumazet@kernel.org>,
	<richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>
Date: Thu, 22 Oct 2026 13:53:35 +0200
In-Reply-To: <179240452564.3135.4025477777348146503@kernel.org>
References: <20261015-dsa_lan9645x_switch_driver_base-v15-4-562f316f78b9@microchip.com>
	 <179240452564.3135.4025477777348146503@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-10-19 at 10:08 +0000, netdev-bot+sashiko@kernel.org wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] Nothing in the tree can bind or exercise this driver.
>=20
> --
>=20
> net: dsa: lan9645x: add basic dsa driver for LAN9645X
>=20
> This adds a basic DSA driver for the Microchip LAN9645x switch. It covers
> switch initialization, NPI, CPU and front port setup, and phylink MAC
> configuration for the internal CuPHYs and the RGMII ports. All register
> access goes through named regmaps requested from a parent device, which
> is meant to be an MFD driver submitted in a later series.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > new file mode 100644
> > index 0000000000000..c7de3836e6967
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > @@ -0,0 +1,456 @@
>=20
> [ ... ]
>=20
> > +static int lan9645x_reset_switch(struct lan9645x *lan9645x)
> > +{
> > +     u32 val =3D 0;
> > +     int err;
> > +
> > +     /* The parent must reset the whole chip before instantiating its
> > +      * children, so the switch core is disabled when we get here. The
> > +      * sequence below must not run more than once: initializing the
> > +      * memories on a running core corrupts pointers inside the queue
> > +      * system, which eventually fills up and stops passing traffic. I=
f the
> > +      * core is already enabled the chip was not reset, so skip it.
> > +      */
> > +     if (SYS_RESET_CFG_CORE_ENA_GET(lan_rd(lan9645x, SYS_RESET_CFG)))
> > +             return 0;
>=20
> [ ... ]
>=20
> > +static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
> > +{
> > +     const char *resource_name;
> > +     struct regmap *tgt_map;
> > +
> > +     for (int i =3D 0; i < NUM_TARGETS; i++) {
> > +             resource_name =3D lan9645x_resource_names[i];
> > +             if (!resource_name)
> > +                     continue;
> > +
> > +             tgt_map =3D dev_get_regmap(lan9645x->dev->parent, resourc=
e_name);
> > +             if (IS_ERR_OR_NULL(tgt_map)) {
> > +                     dev_err(lan9645x->dev, "Failed to get regmap=3D%s=
\n",
> > +                             resource_name);
> > +                     return -ENODEV;
> > +             }
>=20
> [Severity: Medium]
> Does anything in the tree provide these regmaps?
>=20
> lan9645x_probe()->lan9645x_request_target_regmaps() asks the parent for 1=
7
> named regmaps: gcb, qs, chip_top, rew, sys, hsio, dev0..dev8, qsys and an=
a.
>=20
> A search of drivers/mfd/ for lan9645x or lan96455s finds nothing. That is
> still true at the end of the series, through "net: dsa: lan9645x: add por=
t
> statistics".
>=20
> The new microchip,lan96455s-switch binding requires reg and reg-names, bu=
t
> the driver never reads them. A DT node that follows the binding would
> therefore always fail probe with "Failed to get regmap=3Dgcb".
>=20
> dev_get_regmap() returns NULL, not -EPROBE_DEFER, so the probe is not
> retried if a parent appears later.
>=20
> lan9645x_reset_switch() above relies on the same missing parent. When
> CORE_ENA is already set, it skips the RAM init without logging anything.
> That precondition also can't be checked without the parent driver.
>=20
> The commit message says:
>=20
>     The MFD driver will come in a later series, because there are
>     requirements on the number of child devices before a driver qualifies=
 as
>     a MFD device.
>=20
> Until that series lands, the driver can't be bound or tested on any in-tr=
ee
> configuration. Could this be merged together with the parent driver, or i=
s
> there another way to bind it in the meantime?

Dismissed, intended.

the driver is meant to be instantiated by a parent MFD that owns the
register IO and registers the named regmaps before it adds its
children, similar to ocelot_ext. The parent is kept out of this series
on purpose, to avoid a series across the net and mfd trees.The MFD
support is planned as a follow-up.


>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip=
.com

