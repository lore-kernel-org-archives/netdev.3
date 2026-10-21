Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792579051;
	b=fgPdoLuzC6fYK4EZkxJKqrXAZ9+kvNBF1YjWrDcvIpJ7BHUk+uwRSOzzmZGnfbPzJHiC
	 F/iz1B2k5AEwlCC1QmB+FMDSDIRCv2YNPH5gp9Z9iqVgMdJ494+7MhXufJQCBzkTtYz+i
	 PbCwmfrkjXolfTxsJbp1o1pUAf+RLAHkc9OYp6pfy3Tv1Knbr226sISsjXchq8yfx35/E
	 s9ije+1vTGs26t+taYkvE2SWasS/eVdM6fbT+uf0mUvILm5TFikw/BVabxLRX5SGjhomc
	 HLWUj2Zdp0gqwjgv4N1NIC/OeB6qQa96yHQbutpwpE118tjAf2gGq6RE4EBOJra0GCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579051;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-ZohoMailClient;
	bh=QjzGdWbiEqzzV/MbYQG4TopYjAr0X/I+MiCAzcAGLpI=;
	b=wWZVyrgUj1qdhnEzEZYWIe7jZLplckC/mUiXUDkv1R7QqpmeQT7MgthJFEi3cLeIokgE
	 /xlD3Os3agvWoQRZtbscDX6b/0duj8Q1WvrdunXpjy23Mxy8QGASnY/VBHkH8n7rGUL56
	 y18ao31WZvsyJ66CYe/nqDAN29OcGjBoQMEK2qSg4d6/3Y766+f8C8hOk7hA+j5pJrr4u
	 FDVW0AgWeFw5oWAtzBqooqGa+E2wU5tgtXnZ8sRPNS6RkQGDC5j3G0Yz9SHek6kQUVE9I
	 Wfo2MAIlJDTHkbz09/UoegfAyyuo5nuJDXupxylOHyH3c6OMJKiuixecAvgicdwyYog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=kwBQM5Nb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E047A606A319;
	Wed, 21 Oct 2026 10:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E047A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=kwBQM5Nb
ARC-Seal: i=1; a=rsa-sha256; t=1792579004; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vg4ASxVe/gRrDD7T/H1HLXKpWWkQxEoEToUwf2gjVgQHhTYdsZF+0wcPe/aCT6kTTygdTn8+XsTD4KtGu2NKj4mneTRLu+o0VYhkjaQexiAmfxaPQXlcWkvJ8mu+as0fYuu1Z6VApa5hqNk6BEhCQW+lD4eLzEP2HGCw7Z54wTU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792579004; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QjzGdWbiEqzzV/MbYQG4TopYjAr0X/I+MiCAzcAGLpI=; 
	b=XcQSfehKD8VgFwklFZJegFzqLTSxt+T60vRuu/Y6MC3JjpjUtQNDXGycZu7OPrKJ/c3933kKqODgfJqZ/u94N6+w9cbvIoSw6xnfamF74sy/IM1OJvKgt6HY5wh8Ew7eOg21XWfIY6gwNQI+nlUupDgA0qMT0k+bvuRoeCygFlQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792579004;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=QjzGdWbiEqzzV/MbYQG4TopYjAr0X/I+MiCAzcAGLpI=;
	b=kwBQM5NbKMKpWskOQ/UK068FN2dUY6f3Tqfsgf0xMc4o9dWO9sF6V3kiGe08IUg7
	+naym6+93bNkSscqYsND5A/H5/jtiUtWzKFSSmAXBBabwt41p9RF3uJQantmcB+nqwR
	EgGGkjq59XEsOgSNwGVkJJUUh8lRFRFDV5IdN8ro=
Received: by smtp.zohomail.com with SMTPS id 1792579002564512.9314975124558;
	Wed, 21 Oct 2026 03:36:42 -0700 (PDT)
Message-ID: <b7d26b378e3cfdb54a113cca1d8d53293cad966c.camel@collabora.com>
Subject: Re: [PATCH net-next v3 5/9] net: stmmac: mediatek: add RX/TX delay
 stage divider in platform data
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Cochran	 <richardcochran@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Biao Huang
 <biao.huang@mediatek.com>, Maxime Coquelin	 <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,  Eric Dumazet
 <edumazet@kernel.org>
Cc: kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Date: Wed, 21 Oct 2026 12:36:37 +0200
In-Reply-To: <34608ab8-18f3-4680-8276-cd8611c05cb1@bootlin.com>
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
	 <20261016-dwmac-mediatek-mt8189-v3-5-25daf2bbcf35@collabora.com>
	 <34608ab8-18f3-4680-8276-cd8611c05cb1@bootlin.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Maxime,

On Fri, 2026-10-16 at 13:37 +0200, Maxime Chevallier wrote:
> Hi Louis-Alexis,
>=20
> On 10/16/26 12:31, Louis-Alexis Eyraud wrote:
> > In preparation of newer SoC support, that have like MT8189 SoC
> > different RX and TX internal delay stage steps than MT8188/MT8195,
> > add
> > the RX and TX delay stage divider values in the variant platform
> > data
> > and replace the hardcoded value uses in mt2712_set_delay and
> > mt8195_set_delay.
> >=20
> > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > Signed-off-by: Louis-Alexis Eyraud
> > <louisalexis.eyraud@collabora.com>
> > ---
> > =C2=A0.../net/ethernet/stmicro/stmmac/dwmac-mediatek.c=C2=A0=C2=A0 | 46
> > ++++++++++++++++++----
> > =C2=A01 file changed, 38 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > index 596411d4a5b2..cb5bda53edb9 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > @@ -108,6 +108,10 @@ struct mediatek_dwmac_variant {
> > =C2=A0
> > =C2=A0	u32 rx_delay_max;
> > =C2=A0	u32 tx_delay_max;
> > +	u16 rx_rmii_delay_stage_div;
> > +	u16 tx_rmii_delay_stage_div;
> > +	u16 rx_rgmii_delay_stage_div;
> > +	u16 tx_rgmii_delay_stage_div;
> > =C2=A0	u8 dma_bit_mask;
> > =C2=A0};
> > =C2=A0
> > @@ -146,14 +150,22 @@ static int mt2712_set_delay(struct
> > mediatek_dwmac_plat_data *plat)
> > =C2=A0	u32 fine_val =3D 0;
> > =C2=A0
> > =C2=A0	if (phy_interface_mode_is_rgmii(plat->phy_mode)) {
> > -		rx_delay_stage_div =3D
> > MT2712_RGMII_DLY_RXC_STAGE_DIV;
> > -		tx_delay_stage_div =3D
> > MT2712_RGMII_DLY_TXC_STAGE_DIV;
> > +		rx_delay_stage_div =3D plat->variant-
> > >rx_rgmii_delay_stage_div;
> > +		tx_delay_stage_div =3D plat->variant-
> > >tx_rgmii_delay_stage_div;
> > =C2=A0	} else {
> > -		rx_delay_stage_div =3D
> > MT2712_RMII_DLY_RXC_STAGE_DIV;
> > -		tx_delay_stage_div =3D
> > MT2712_RMII_DLY_TXC_STAGE_DIV;
> > +		rx_delay_stage_div =3D plat->variant-
> > >rx_rmii_delay_stage_div;
> > +		tx_delay_stage_div =3D plat->variant-
> > >tx_rmii_delay_stage_div;
>=20
> Looking closer at this, what's RMII delay ? There's no delays in
> RMII, and
> it's a single clock not a RX and TX clock like RGMII, there's no RMII
> TXC/RXC.
>=20
You are right, these structures field and define names are wrong for
RMII/MII cases.
The mediatek,tx-delay-ps and mediatek,rx-delay-ps vendor properties are
used by this driver to fine tune different clocks depending on the phy
mode:
 - RX_CLK/TX_CLK in MII
 - REF_CLK in RMII
 - TXC/RXC in RGMII

I'll fix the fields and define names in next series revision, along the
issues the Sashiko reviews found.

> I think it's the same as on allwinner, the delay handling has been
> mixed-up between
> RMII and RGMII in the glue, you should be able to simplify this even
> more by
> ditching the RMII case.
The register fields that the driver sets in RMII or MII mode to tune
the needed clock(s) are different than the ones set in RGMII.
So I cannot really ditch the case but I'll simplify the delay handling.
For instance I could use a single divider field per mode, since for all
compatibles the value is the same in both RX and TX.

Best regards,
Louis-Alexis
>=20
> Maxime
