Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90515345CBD;
	Wed,  4 Mar 2026 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640642; cv=none; b=XXi7y7MHgHf9ML4ycA2S89bRQZr5QDzlUm/JtSgBnDPPyYEAuWea4PShOEUJZG6Kz8R9IbmLCTekrM1YQFYp25Fkt+DtzgQD8mdul0Cxbbxlwh+YTxY52z4r9zFx27pDfHzVKZ53dPRcRT8SEJIvOC4X6W0NUMWsoFxAW+WLGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640642; c=relaxed/simple;
	bh=Gz289QC+ZBgxZBTkRmrcya6ao07RsmxD53Tp0Xq2DMU=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CRrQsFznR7PZgDznuQS8QTyWVHyAH2x7gId3n3WDQPf5cso68DknicdP+y6+vdJEo0GYbZMF8CNjB+PQg8BsMYwEfvLx7oIpMo/3kyfKK2j5/NhBzqmMgaKSVxXIUtXv3Ef8R4iM7XqK3V2pO3z6cuXqY6E1sbqozRXJ6mYpN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HNONgHJJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HNONgHJJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772640641; x=1804176641;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Gz289QC+ZBgxZBTkRmrcya6ao07RsmxD53Tp0Xq2DMU=;
  b=HNONgHJJl+3Am0zW6CjIXt2ku1Fk2gr/wuIYPZWzF52g2g3RataggcWG
   BzoCEu3ln1bDBM2yHbTlPy8cnbxHy2o06JxmSznWSnlcjKnV+59OE/j60
   NaBKcPEw2moVL1jG/0Lu6euuj6rfyh8n2Gtue8pmAwdW6ecyt70gPQsVN
   pTflx21YeGjSOdSG5Cj0dShxY12kPvcPhUBtATKQSTZ67jBvDK1wRGRij
   qRESGsM30tsSD1CBZGPfaZTbevuSaE5oWVYxdLtS/qLEpJh3NlsNkJ4jn
   YC56/G+NNuaMD1S2+hss/w8ZSsq7jTY6mng2CKcW4I9FIv2ZnG28bysKb
   Q==;
X-CSE-ConnectionGUID: 4fes5EXKR6mT6OprZhn0Tg==
X-CSE-MsgGUID: aNj582jsSK6tqB68LIG+YQ==
X-IronPort-AV: E=Sophos;i="6.21,324,1763449200"; 
   d="scan'208";a="221487682"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2026 09:10:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 4 Mar 2026 09:10:15 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 4 Mar 2026 09:10:12 -0700
Message-ID: <65fd5f46f1f996dd5f4df2de2efb52c8fa3575b3.camel@microchip.com>
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Russell
 King" <linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Wed, 4 Mar 2026 17:10:11 +0100
In-Reply-To: <20260303-disperser-clone-512efa99f26c@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
	 <20260303-disperser-clone-512efa99f26c@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-03 at 18:56 +0000, Conor Dooley wrote:
> On Tue, Mar 03, 2026 at 01:22:28PM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > +examples:
> > +  - |
> > +    soc {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +      ethernet-switch@0 {
> > +        reg =3D <0>;
>=20
> Also, this is an odd example, why are you at address 0 on a "soc" bus,
> which usually means that this device on an AXI/AHB bus, and 0 is very
> unusual for that. Obviously the example doesn't have to match the real
> user, but this stands out.
> I may have some follow up questions I think depending on your answer.

The intended way to bind this driver is via a parent MFD driver which sets
up the SPI register protocol, initiates regmaps and distributes them to chi=
ld
devices (like this DSA driver).

Similar to mscc,vsc7512 in drivers/mfd/ocelot-spi.c.

This MFD would be the soc node. All child nodes perform register IO over
spi, using the regmaps requested from this parent so I think the addresses
on the bus are purely ornamental. Should I write the smallest register
address in all regions used by the DSA driver instead?
