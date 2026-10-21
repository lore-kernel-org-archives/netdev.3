Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792575885;
	b=kQyeMi4jRlfy09HCqUwVSPtE++TVkaAPHTRZEvU+lMpI18kpvRUs0RMVs0SnS0k7ZBNP
	 HNWlT6UEeB3CDeI1XoC0G0dW/ic+3WRICGQiFC65/PFrHoijoy0BnvHp7CFYwhfnEzd/7
	 5n699lkDL7h6kAisk4ac90BfcK4epPG0h0JbBSvLlePCnHA3AMs0VAsnj1r6YfEAG47Tv
	 g0PWGu7LF/je/5RolIrkZHq+QgodB90m+wbGk3/xpg+x9ckcjBpRxUPSCVb9//XmTnYyT
	 4Au0wMR4Qlp81zOSwHJ5a5wvFUYlZaLPFs+S/jubolJsMh45+wuYz033QG+1ztt74XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575885;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-ZohoMailClient;
	bh=mXCjInahUZzrvNbEdQD0UbF7xlxKuOskZ4KoinzfWZ0=;
	b=k16EhyORKXz9HglSnAtN9FRi26Ilu0DcesXR8yNGSBr7xsxxsNszb39U7g1BXPTV8bSt
	 /+shIaJMSt9hEJFTnDDA+9N5QmTYp32U6So756KhL7AbKXCwasdmnLmA2HOR2m6UlRhBY
	 cpJ9XS4cb2g7jAd6IHTJbCT8dp6Q9KNhzgZ4pGx6qdrBW8i4g905QIT55pOoZJa/u5XaW
	 SCukpMQlhVbMhP0D2MFHjtU4ibQfUDphJDRtyh0AnugRXibNWrzihqY+djMGUsVJWkNgb
	 xn5X21vVmWyFzUk1FMy1F5NsySCnUdNui39hD/Q9x7DfN8PMUMusJckoc5L0fdauVEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=SsxZ7Fbn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95835606A338;
	Wed, 21 Oct 2026 09:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95835606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=SsxZ7Fbn
ARC-Seal: i=1; a=rsa-sha256; t=1792575827; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RwqfJR0UKnXDM2nQGKfDxWc5W1Q8rzZpPDwwBbSN7y6k6cO14y0rK6TD4auVxwuN4Ye6IWvwYH3kqwP19SXzSDCc2qI5hBPGI6T1YHyE1MhTZvu6i0L+Uy2JI25qVRCRaGeu9Ic0LeCixfehl5fVC1E2ku3pK64aazZNJv+5vBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792575827; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mXCjInahUZzrvNbEdQD0UbF7xlxKuOskZ4KoinzfWZ0=; 
	b=Um008nR1oKe2GzJD3p7sHCnmYBrW4AZyl6i3v0k154SC6dYDX6zRounEamfKjE9E2FqeNdOfgctBEKgbwt3vwuJNGBeeWa7GtgXFWi3J86YchXVDjv6p8gYzf8s3DRZhvSWyFPFbK9NK1V+7mnbc9nF6xwm63QMrFuTfIbzCSPc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792575827;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=mXCjInahUZzrvNbEdQD0UbF7xlxKuOskZ4KoinzfWZ0=;
	b=SsxZ7FbnSZ0pL7jhMYiiKetb/evo3A+4EYArjjfyertsyWoNFPko6EvE8G4iNXli
	1T/VMwxzUwcHXUK4BhHB9ZUWPQNkQDHjXBAZCV15/Fp+giKx2rJENP3M5HrxP1NgQvO
	qpV2w8HEo/yWdtMKrlFVOt97nfo8MzR35ElOD5+o=
Received: by smtp.zohomail.com with SMTPS id 1792575825353726.5864194200229;
	Wed, 21 Oct 2026 02:43:45 -0700 (PDT)
Message-ID: <c53928fbb9da11b0f32a84592742e6a26e1aed32.camel@collabora.com>
Subject: Re: [PATCH net-next v3 2/9] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran	
 <richardcochran@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Biao
 Huang <biao.huang@mediatek.com>, Maxime Chevallier	
 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Eric Dumazet <edumazet@kernel.org>,
 kernel@collabora.com, 	netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Date: Wed, 21 Oct 2026 11:43:39 +0200
In-Reply-To: <b4950f82-0163-4482-9799-a5e3c6eb5964@lunn.ch>
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
	 <20261016-dwmac-mediatek-mt8189-v3-2-25daf2bbcf35@collabora.com>
	 <b4950f82-0163-4482-9799-a5e3c6eb5964@lunn.ch>
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

Hi Andrew,

On Fri, 2026-10-16 at 17:40 +0200, Andrew Lunn wrote:
> > Finally, update "mediatek,rx-delay-ps" and "mediatek,tx-delay-ps"
> > property
> > description to add MT8189 RX/TX delay stage divider values, as they
> > differ from existing supported SoC.
>=20
> These should be mark deprecated and the standard rx-internal-delay-ps
> and tx-internal-delay-ps used in there place for new devices.
>=20
I agree, it makes sense to use them to describe the RGMII internal
delay configurations rather than the two existing vendor properties
(mediatek,rx-delay-ps and mediatek,tx-delay-ps), and deprecate them, by
adding a deprecated flag and the comments you've suggested. It would
also need an additional patch for the driver to handle them (while
keeping backward compatibility).

But what is bothering me is these two vendor properties description
says they can be used in MII and RMII phy mode cases. The driver uses
them indeed also to fine tune the RX/TX_CLK (in MII) or the REF_CLK (in
RMII) configuration.
rx/tx-internal-delay-ps properties are limited to RGMII only ([1]).
So they can not substitute them as it and with their description it
would wrong to use them for MII/RMII.

At the moment, in the upstream devicetrees, there is no "mediatek,rx-
delay-ps" use and the "mediatek,tx-delay-ps" use are very few and only
for RGMII phy modes (either rgmii-rxid or rmgii-id), so no MII/RMII
real use cases.

So, how to proceed then to make these bindings right?
Use rx/tx-internal-delay-ps properties for RGMII and mediatek,rx/tx-
delay-ps for MII/RMII or do you see another solution ?

Best regards,
Louis-Alexis

[1]:
https://elixir.bootlin.com/linux/v7.3/source/Documentation/devicetree/bindi=
ngs/net/ethernet-controller.yaml#L251


> > @@ -86,8 +85,10 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or will round down. Range 0~31*170=
.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For MT2712 RMII/MII interface, All=
owed value need to be a
> > multiple of 550,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or will round down. Range 0~31*550=
.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For MT8188/MT8195 RGMII/RMII/MII interf=
ace, Allowed value
> > need to be a multiple of 290,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or will round down. Range 0~31*290.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For MT8188/MT8195 RGMII/RMII/MII interf=
ace, Allowed value
> > need to be a
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multiple of 290, or will round down. Ra=
nge 0~31*290.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For MT8189 RGMII/RMII/MII interface, Al=
lowed value need to
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be a multiple of 180, or will round dow=
n. Range 0~31*180.
>=20
> Please make this:
>=20
> For MT8189 RGMII/RMII/MII interface, this property is not used, the
> standard tx-internal-delay-ps should be used instead.
>=20
> > @@ -96,8 +97,10 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or will round down. Range 0~31*170=
.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For MT2712 RMII/MII interface, All=
owed value need to be a
> > multiple of 550,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or will round down. Range 0~31*550=
.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For MT8188/MT8195 RGMII/RMII/MII interf=
ace, Allowed value
> > need to be a multiple
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of 290, or will round down. Range 0~31*=
290.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For MT8188/MT8195 RGMII/RMII/MII interf=
ace, Allowed value
> > need to be a
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multiple of 290, or will round down. Ra=
nge 0~31*290.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For MT8189 RGMII/RMII/MII interface, Al=
lowed value need to
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be a multiple of 180, or will round dow=
n. Range 0~31*180.
>=20
> Same here.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Andrew
