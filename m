Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CBE3242B0;
	Thu,  5 Mar 2026 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701243; cv=pass; b=YA+rQ29gZJL/x5671zJ28fUyGbzfeg7fCd2Zuhhb1rCF2cfLnzpumJybthDYviHDjJB2bNRfY4gXZ0upUUBhu5KgxxNqz6Et8ch3zi7Dp1lUVacmIVJnNR3fqDAe82Aybyh11x9PX/OmEWAOqwElOXSauu7NjxwHe2a3DHXksSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701243; c=relaxed/simple;
	bh=pey75eEThoEnHQjSmZ+IVIhI1hTMvdMzabhpITD61Sw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=etOEwNX7sboCq9fbcvlKzgRXLv8YH3RC5Xhv0iJpFsNvLcqM9fjp0DaaDmKyE8WG4PW4h2icwv9eYJPq3MbHBLX5MqNaOnO/pPu9giQQrQIqiISTn4lDBh6dCWtWz/bR6iC/u5QNTeCWoxLZxD33nbrPjCiWjQRsF7N5O7PIyw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=e0UEYfXB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="e0UEYfXB"
ARC-Seal: i=1; a=rsa-sha256; t=1772701198; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lZfdoF0se+mb5+rKW3KIqtNlypck4va7ch7J6QBw6dUuT9PG7Mg2DtmmnmSOZcJBGJCQeujXNJMd9/j2iapWzg/H0MpTIrtOzXpbWBYZdiB10UQuZ22YyE/K9vgHdonXDaThW1s0jZcBfNhUa/WjYgVB/FLjYVYbdA/BHbtG8BE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772701198; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pey75eEThoEnHQjSmZ+IVIhI1hTMvdMzabhpITD61Sw=; 
	b=bWxyTbb1c9KT/sVbuLa54G5M3uZaF3ilAlI5btjv7vp3TFNx9U6g7NjWJR0micoyjac6ydlvSj/z6jzQrdzH5eWuICh3Jm/0C79xbpitClcnt676RAn0RVoY8ASkpCnSUwsDZ6RHYrdbcwl6eQGWwCiPZrccNzTEdNGCH+Zc/wE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772701198;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=pey75eEThoEnHQjSmZ+IVIhI1hTMvdMzabhpITD61Sw=;
	b=e0UEYfXBhyAFq0y9vrEVYrrtrDV+uEf53upMxDmuKue8e4yinFtsSbdw123xNaeg
	Lsuk0z/ghpooX4ZF8vY7jCIUDwf9AvIkwX67N6LwDGWZQMVmRJLuDZSgB3oTrUzZ3ti
	kpeJCU/HB3t4SxItxDjqa+Z6fpEDS/0AnHpj47k4=
Received: by mx.zohomail.com with SMTPS id 1772701196666782.1404033627674;
	Thu, 5 Mar 2026 00:59:56 -0800 (PST)
Message-ID: <cb788f76740e88418d55ce9345e54d482969ff5a.camel@collabora.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Add support for Airoha
 AN8801/R GbE PHY
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit	 <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com,
 matthias.bgg@gmail.com, 	kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Thu, 05 Mar 2026 09:59:50 +0100
In-Reply-To: <4a073736-9caf-4973-b7ad-a482d63bb672@bootlin.com>
References: 
	<20260304-add-airoha-an8801-support-v1-0-0ae4ee5a2f9d@collabora.com>
	 <20260304-add-airoha-an8801-support-v1-1-0ae4ee5a2f9d@collabora.com>
	 <4a073736-9caf-4973-b7ad-a482d63bb672@bootlin.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Maxime,

On Wed, 2026-03-04 at 11:14 +0100, Maxime Chevallier wrote:
> Hi Louis-Alexis,
>=20
> On 04/03/2026 10:35, Louis-Alexis Eyraud wrote:
> > From: AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com>
> >=20
> > Add a new binding to support the Airoha AN8801R Series Gigabit
> > Ethernet PHY.
> >=20
> > Signed-off-by: AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Louis-Alexis Eyraud
> > <louisalexis.eyraud@collabora.com>
> > ---
> > =C2=A0.../devicetree/bindings/net/airoha,an8801.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0 | 81
> > ++++++++++++++++++++++
> > =C2=A01 file changed, 81 insertions(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/net/airoha,an8801.yaml
> > b/Documentation/devicetree/bindings/net/airoha,an8801.yaml
> > new file mode 100644
> > index
> > 0000000000000000000000000000000000000000..f251c9d2fbbed3675c9fd7ff2
> > 2174049a13a7b5e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/airoha,an8801.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/airoha,an8801.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha AN8801R Series PHY
> > +
> > +maintainers:
> > +=C2=A0 - AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com>
> > +
> > +description:
> > +=C2=A0 The Airoha AN8801R is a low power single-port Ethernet PHY
> > Transceiver
> > +=C2=A0 with Single-port serdes interface for 1000Base-X/RGMII; this
> > chip is
> > +=C2=A0 compliant with 10Base-T, 100Base-TX and 1000Base-T IEEE
> > 802.3(u,ab)
> > +=C2=A0 and supports Energy Efficient Ethernet (802.3az), Full Duplex
> > Control
> > +=C2=A0 Flow (802.3x), auto-negotiation, crossover detect and
> > autocorrection,
> > +=C2=A0 Wake-on-LAN with Magic Packet, and Jumbo Frame up to 9
> > Kilobytes.
> > +=C2=A0 This PHY also supports up to three user-configurable LEDs, whic=
h
> > are
> > +=C2=A0 usually used for LAN Activity, 100M, 1000M indication.
> > +
> > +allOf:
> > +=C2=A0 - $ref: ethernet-phy.yaml#
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ethernet-phy-idc0ff.0421
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 leds: true
> > +
> > +required:
> > +=C2=A0 - reg
> > +=C2=A0 - leds
>=20
> Seems odd to me that leds are required. Any reason for that ?
>=20
> Maxime
I agree having the leds as required property is unneeded.
I'll change it in v2.

Regards,
Louis-Alexis
