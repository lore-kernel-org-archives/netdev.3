Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88A3E0251;
	Wed,  1 Jul 2026 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895435; cv=none; b=JtJPuem2IhR+vWYtMzvmKDZuRzSCHvKgGBeRPAN4YS+hqJx/RgdQU4FBwpO6cgV+3HYW6Gh7ViJH3XYEXyfDBED7OEXJa1eUsvRZ3y+or+WGmSlzdYHCFujE8L7Vo/CvILf1Hx+vZr4RSbFyfSAIjIbqCBCWFywvJm9MoBndaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895435; c=relaxed/simple;
	bh=IruFylOlTxcJm5hyyL/eFNS0o3To89PaJ6QDaYNLHrE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=U1uxUj0pOBzpFR5x2gQfcVljOGhO2NJnNEMTKcy9cjPbSw0987Aq3Y4ij1FhfcBgkbGLJ7FcpFa9/D7b33LkDTU9Htyp1hQFRgJrBXTCwhN/xoMSWMkwLVloKHu/A4wFBEp4MGCg3VlLiLi3fYdTS7wUv88k2mrseMzcxhLZIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=h67gQjQB; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="h67gQjQB"
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 880D35B6;
	Wed,  1 Jul 2026 10:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1782894878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OV8gaPiQO40kpe0vnMtC2nXL8DrZwaWi9384uLF+/CY=;
	b=h67gQjQBVSxm1zGv4NOn57N9gJTCxMWWp3YcNhFmHdxQHNawukaOxBFeoTLd7xSSsUmHEb
	QHOO7Rdm6R9+IhDqEV//349b1hxptHCVf1Ld31NKjoCEVG3yZWiCutXBBQIV2AETWkCvG0
	2cvaUpJLCDQ65E9H4T7Bz3ZxH6x4FUP/Fk5LNDw6NweLNxPVKswcK05bPvhIWZ5hC03CGb
	zu9OuKTRqyoO5BGXK6QgIby1CRCo3dgJBzS+jDk1gA31fpjROSM1sYk8vN6mvqxzcilIxi
	5sg1p4WSH4Ikuhd3m7Ug/A13vn7+YhQwohIgElCdJhJ/Z95aXmB3+k3/Z3v1Aw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=7dc42cc06038756823fa21ce147a9856939103d1b021230f1b15a2a59c78;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 01 Jul 2026 10:34:35 +0200
Message-Id: <DJN3HIIAY4LE.3MXU9Q2YFSCJJ@walle.cc>
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP
 to be exposed via NVMEM
Cc: <pratyush@kernel.org>, <mwalle@kernel.org>,
 <takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
 <richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <srini@kernel.org>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <linux@armlinux.org.uk>,
 <richardcochran@gmail.com>, <arnd@arndb.de>,
 <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <netdev@vger.kernel.org>
From: "Michael Walle" <michael@walle.cc>
To: "Linus Walleij" <linusw@kernel.org>, "Manikandan Muralidharan"
 <manikandan.m@microchip.com>
X-Mailer: aerc 0.20.0
References: <20260630092406.150587-1-manikandan.m@microchip.com>
 <20260630092406.150587-2-manikandan.m@microchip.com>
 <CAD++jL=FkEfpz-LW0vmPpZ28fLfGFMWo5E479Mapz55YUxKNAQ@mail.gmail.com>
In-Reply-To: <CAD++jL=FkEfpz-LW0vmPpZ28fLfGFMWo5E479Mapz55YUxKNAQ@mail.gmail.com>

--7dc42cc06038756823fa21ce147a9856939103d1b021230f1b15a2a59c78
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

>> Add an optional "sfdp" child node (compatible "jedec,sfdp") that
>> describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so its
>> contents (e.g. a vendor EUI-48/EUI-64) can be read through NVMEM cells.
>>
>> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
>
> I would expect it to follow nvmem conventions like this, notice
> compatibles specific-to-general with sfdp first:


> sfdp {
>     /* NVMEM provided by SFDP */
>     compatible =3D "jedec,sfdp", "nvmem-cells";
>     label =3D "SFDP";

Isn't using label frowned upon? I wouldn't add that to the example.

>     read-only;
>     #address-cells =3D <1>;
>     #size-cells =3D <1>;
>
>     mac0: macaddr@0x00 {
>         reg =3D <0x00 0x06>;
>     };
>     mac1: macaddr@0x06 {
>         reg =3D <0x06 0x06>;
>     };
> };

If I'm correct, this is the old style, see commit bd912c991d2e
("dt-bindings: nvmem: layouts: add fixed-layout"). So it should
eventually look like:

sfdp {
     compatible =3D "jedec,sfdp";

     nvmem-layout {
	     compatible =3D "microchip,sst26vf-sfdp-eui";
     };
};

Which is what patch series will lead to.

Also I'm not sure if we really need to add the "nvmem-cells" here.
IIRC in MTD it was there to tell a driver to add an nvmem device to
an already existing compatible/node.

Apart from the MTD case, I've just found qcom,smem-part,yaml which
has compatible =3D "nvmem-cells".

-michael

> Your example should definitely be more elaborate like this,
> just an opaque sfdp node will not suffice. Maybe a separate
> example?
>
> Yours,
> Linus Walleij


--7dc42cc06038756823fa21ce147a9856939103d1b021230f1b15a2a59c78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCakTRGxEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+PesAYCvxlMrRPb3CpBzPYndulCo9xHSs8WFx8GM
YRvSkp3iZq/ziK9zzw8WIc8dB59hR7gBgJcgQcwu/qH+CFtJvfiWDEH4EWXU3HSR
2Jx1LkNCSYEaHycVFgiepmorZPwBghbBeA==
=IjRV
-----END PGP SIGNATURE-----

--7dc42cc06038756823fa21ce147a9856939103d1b021230f1b15a2a59c78--
