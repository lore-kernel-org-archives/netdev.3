Received: from 0001.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB63CE4BE;
	Thu, 15 Oct 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055953; cv=none; b=KL5NjuEPOTddb8X/UFmo8M1/TlWIkHcj6ZeQMIeHlts5LNdf0eL+CTLndi5EPyaSLxkAtOSadDXVqzafx2+V2MD79b8h4IktvFA0Kg/eqQYaR69bnd2W+jy/iJ9nKYhUZgxjTfs9mxwCGZWQptfX0Rk/8+twJ251yaOElgLHISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055953; c=relaxed/simple;
	bh=MH3qGToe99bdMqkSjji66J5o0oFCK9Jd8FLC49APQhs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=Mk80EHU5+HmGoWkagY+aVpG7jG/dhyMfuGGIOKmDQ8bsK0c6Jx9Jq9FsNS6CvP7fY93TDVT+L/dMYjOYBUeOS/XkMPC52ueFSULDL1fa0Ayb2migZd7tkEdSijXpYrkseKmHFJb2qJbuLoSsdc817cE2Hr0NNf/A2m2XgZ/0sD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=h4mnp7OY; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="h4mnp7OY"
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id AD3E148D;
	Thu, 15 Oct 2026 11:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1792055551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Zj5znr2Nom4HHOQbTJi5RMAPGgKLlClPXVSJoArmYI=;
	b=h4mnp7OYGlPKxKPsqXtOpEz9t3l1xHMXynyVgwvBejzSs1PxHS4dV2PL3DhdFs/sQyatFZ
	pbKPj+jC+Q+bjYxpPbuK8uT/F2U9KA6Mxe/R5ZWlvVZe40PmaT04r+PA91UTvseqlpeaYa
	+OkG2bBVBzGB/nCZNFxDacrX7ZoPRuxuXiFZ13zA+aACh3ChUpxOi8jRX075PupfINHOBn
	bisuEkzn28Uzawb7qSk/yKNDN8lo4r50LF+yj642Q5DJToihOes11gvD5REA5iAtnvGRS0
	00K4T0R0S7Ie6PwrHimZd6OEkbAfbMcpXzFFvp3F3Ui/PzAv4AxoLMN2HmKJPg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1bcab1df772fb139f8336f2aa8b8f79a6917ec2951c5e78cac2480ad5a3f;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 15 Oct 2026 11:12:28 +0200
Message-Id: <DM5AO9LBE1OI.19L3SG4BQTNB0@walle.cc>
Subject: Re: [PATCH v8 3/8] nvmem: core: take a reference on dev.of_node in
 nvmem_register()
From: "Michael Walle" <michael@walle.cc>
To: "Manikandan Muralidharan" <manikandan.m@microchip.com>,
 <pratyush@kernel.org>, <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <srini@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
 <arnd@arndb.de>, <aaro.koskinen@iki.fi>, <gregkh@linuxfoundation.org>,
 <mathieu.dubois-briand@bootlin.com>, <linux-mtd@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <cover.1790847519.git.manikandan.m@microchip.com>
 <2e21cc4b871da8764e3a12d0ebdcf7cb799149ab.1790847519.git.manikandan.m@microchip.com>
In-Reply-To: <2e21cc4b871da8764e3a12d0ebdcf7cb799149ab.1790847519.git.manikandan.m@microchip.com>

--1bcab1df772fb139f8336f2aa8b8f79a6917ec2951c5e78cac2480ad5a3f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Oct 14, 2026 at 8:40 AM CEST, Manikandan Muralidharan wrote:
> nvmem_register() stores config->of_node (or config->dev->of_node)
> into nvmem->dev.of_node without taking its own reference. Callers
> that get the node via of_get_compatible_child() etc. and drop their
> reference right after registering leave nvmem->dev.of_node backed by
> no reference at all.
>
> Take an of_node_get() when assigning nvmem->dev.of_node and release
> it in nvmem_release(). Existing callers that hold their own get/put
> pair around the registration call need no changes, since get/put on
> a device_node is per-holder and independent of core now also holding
> one.
>
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Nice!

Did you check if any callers are also taking a reference, which
might not be needed anymore now.

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

> ---
>  drivers/nvmem/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 0556d140170a..98192597b935 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -541,6 +541,7 @@ static void nvmem_release(struct device *dev)
> =20
>  	ida_free(&nvmem_ida, nvmem->id);
>  	gpiod_put(nvmem->wp_gpio);
> +	of_node_put(nvmem->dev.of_node);
>  	kfree(nvmem->ops);
>  	kfree(nvmem);
>  }
> @@ -950,9 +951,9 @@ struct nvmem_device *nvmem_register(const struct nvme=
m_config *config)
>  	nvmem->keepout =3D config->keepout;
>  	nvmem->nkeepout =3D config->nkeepout;
>  	if (config->of_node)
> -		nvmem->dev.of_node =3D config->of_node;
> +		nvmem->dev.of_node =3D of_node_get(config->of_node);
>  	else
> -		nvmem->dev.of_node =3D config->dev->of_node;
> +		nvmem->dev.of_node =3D of_node_get(config->dev->of_node);
> =20
>  	switch (config->id) {
>  	case NVMEM_DEVID_NONE:


--1bcab1df772fb139f8336f2aa8b8f79a6917ec2951c5e78cac2480ad5a3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCatCY/BEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+GofAYD9mcyrw6Fsl+MSjbGeqfOmb4MGExC9nDTZ
ZOEr0wblbvSq2/743J69jXa4cWznv6UBgKoH3UHkbObCLUD2qJ/idZX/Ga9BD2Xc
Qa+nNJFPjUjx0YIViZ9j8C25yOcdXP47fw==
=lByw
-----END PGP SIGNATURE-----

--1bcab1df772fb139f8336f2aa8b8f79a6917ec2951c5e78cac2480ad5a3f--
