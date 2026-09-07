Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95684D8D97;
	Mon,  7 Sep 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786080; cv=none; b=RvcP5L6HD/5sAw+aJH41peoAoNpbvN+8JFGYE6jrR9jKPYu0SF5ckkOWe0p8NlX5AeSyIc+6F9Sv9KSWWUS52RhJ4bZMKUiHySlvx8QIymCi47NG6mq9vwzDbCl6o3H7XhY0AgPzf59toVFqqLvnHENlZRVT4ue8DfAn9gI8UDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786080; c=relaxed/simple;
	bh=jG+DF0nd0wBkw7A7vMoguUP47Uwu6YTCNYtM17t+gIE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=l79sZrzS5j2NiuQEO31QdoipxUZCInXg/t3zr6M0EA71KAPpfEkafkcAchTCs95LB3rWidgn10zFE0/ZEQ7N/RaSeVfolCmt+Vfz1cf4npwRAsOPg8WQ0Eu0pOlO6LJrRNILjQBf1Fb+cLKH0RgsxlVdNBRxWy8ljw+NBlG0Ti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXXFAFrM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXXFAFrM"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 48E861F00A3E;
	Mon,  7 Sep 2026 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788786060;
	bh=F4VPyTZ54caW5/2FxinE0de1h566CHchl8PU7RTCzwc=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=lXXFAFrMyZ9iKDuZFZc+3TX/Lq9T58AIoBg9QtiliUStbSJuHnH3Yra7cawchxONc
	 O4kY5HVIfpMwr47rs4xxpDXqtpktWvgbvzG4EIsoU/GCNyr7J73CNyhrDtAV65us3e
	 6vnJLJoU64Q4Ig23QTnsF6BAXMStV4cs9FmR3Il80hrD0E5D6plOYUWP4HD3J3eW2V
	 6fl7sYBKhBdbOOavIU70LSIsaH1ublZBgOzdQ4JXqcVhooea+IZpPurqWGh/7o/xk6
	 lEeOONnJcPoDBjBzw8ZJJQN8Q3jHPuEhOyes4E8fnutATQMJIaQdC3MzBx56TKDb1Z
	 i3IYSINXbNXRw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=cfe8a98efb2086f550102e1210fdc67d01fd1cb7f4b563889cc6dc1396e2;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 07 Sep 2026 15:00:56 +0200
Message-Id: <DL93QHVC01B9.3U3K1G8NC0MZA@kernel.org>
Subject: Re: [PATCH v7 3/7] mtd: spi-nor: sfdp: expose the SFDP as a
 read-only NVMEM device
From: "Michael Walle" <mwalle@kernel.org>
To: "Manikandan Muralidharan" <manikandan.m@microchip.com>,
 <pratyush@kernel.org>, <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <srini@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <linux@armlinux.org.uk>, <richardcochran@gmail.com>, <arnd@arndb.de>,
 <linusw@kernel.org>, <gregkh@linuxfoundation.org>,
 <mathieu.dubois-briand@bootlin.com>, <linux-mtd@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20260812104955.485667-1-manikandan.m@microchip.com>
 <20260812104955.485667-4-manikandan.m@microchip.com>
In-Reply-To: <20260812104955.485667-4-manikandan.m@microchip.com>

--cfe8a98efb2086f550102e1210fdc67d01fd1cb7f4b563889cc6dc1396e2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Aug 12, 2026 at 12:49 PM CEST, Manikandan Muralidharan wrote:
> The SPI NOR core already reads the SFDP tables during enumeration and
> caches them in nor->sfdp->dwords (see spi_nor_parse_sfdp()). Re-expose
> that cached data as a read-only NVMEM device, in on-flash byte order,
> rooted at the flash's SFDP child node (compatible "jedec,sfdp").
>
> This lets NVMEM cells reference any SFDP data: a fixed-layout for
> parameters at a known offset, or an nvmem-layout parser for vendor data
> whose location must be discovered at runtime. The device is only register=
ed
> when an "sfdp" node is present in the device tree.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c | 78 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ccf4396cdcd0..0425af6e898f 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -17,6 +17,7 @@
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/spi-nor.h>
>  #include <linux/mutex.h>
> +#include <linux/nvmem-provider.h>
>  #include <linux/of.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/sched/task_stack.h>
> @@ -3001,6 +3002,75 @@ static void spi_nor_init_fixup_flags(struct spi_no=
r *nor)
>  		nor->flags |=3D SNOR_F_IO_MODE_EN_VOLATILE;
>  }
> =20
> +static int spi_nor_sfdp_reg_read(void *priv, unsigned int offset,
> +				 void *val, size_t bytes)
> +{
> +	struct spi_nor *nor =3D priv;
> +	struct sfdp *sfdp =3D nor->sfdp;
> +	size_t sfdp_size =3D sfdp->num_dwords * sizeof(*sfdp->dwords);
> +
> +	if (offset >=3D sfdp_size || bytes > sfdp_size - offset)
> +		return -EINVAL;
> +
> +	/* The cached SFDP is kept in on-flash (little-endian) byte order. */
> +	memcpy(val, (u8 *)sfdp->dwords + offset, bytes);
> +
> +	return 0;
> +}
> +
> +/**
> + * spi_nor_register_sfdp_nvmem() - expose the SFDP as a read-only NVMEM =
device
> + * @nor:	pointer to a 'struct spi_nor'
> + *
> + * Expose the whole SFDP, in on-flash byte order, as a read-only NVMEM d=
evice
> + * rooted at the flash's SFDP child node (compatible "jedec,sfdp"). This=
 lets
> + * generic (fixed-layout) or vendor (nvmem-layout) cells reference any S=
FDP
> + * data. The device is only registered when a child node with the "jedec=
,sfdp"
> + * compatible is described in the device tree.
> + *
> + * Return: 0 on success or if there is nothing to do, -errno otherwise.
> + */
> +static int spi_nor_register_sfdp_nvmem(struct spi_nor *nor)
> +{
> +	struct device *dev =3D nor->dev;
> +	struct nvmem_config config =3D { };
> +	struct nvmem_device *nvmem;
> +	struct device_node *np;
> +
> +	if (!nor->sfdp)
> +		return 0;
> +
> +	np =3D of_get_compatible_child(dev_of_node(dev), "jedec,sfdp");
> +	if (!np)
> +		return 0;

What if there is no jedec,sfdp node? Should this be added anyways?

> +
> +	config.dev =3D dev;
> +	config.of_node =3D np;

What about just:
	config.of_node =3D of_get_compatible_child(dev_of_node(dev), "jedec,sfdp")=
;

> +	config.name =3D "sfdp";
> +	config.id =3D NVMEM_DEVID_AUTO;
> +	config.owner =3D THIS_MODULE;
> +	config.read_only =3D true;
> +	config.word_size =3D 1;
> +	config.stride =3D 1;
> +	config.size =3D (int)(nor->sfdp->num_dwords * sizeof(*nor->sfdp->dwords=
));
> +	config.reg_read =3D spi_nor_sfdp_reg_read;
> +	config.priv =3D nor;
> +
> +	nvmem =3D devm_nvmem_register(dev, &config);
> +	of_node_put(np);

This now leaves the nvmem device with a dangling pointer. What I
meant in my previous reply, was that you'll add an of_node_get() to
the nvmem_register(), so the nvmem subsystem will have its own
tracking.

-michael

> +	if (IS_ERR(nvmem)) {
> +		/* NVMEM support is optional. */
> +		if (PTR_ERR(nvmem) =3D=3D -EOPNOTSUPP)
> +			return 0;
> +		return dev_err_probe(dev, PTR_ERR(nvmem),
> +				     "failed to register SFDP NVMEM device\n");
> +	}
> +
> +	dev_dbg(dev, "exposed %d-byte SFDP as an NVMEM device\n", config.size);
> +
> +	return 0;
> +}
> +
>  /**
>   * spi_nor_late_init_params() - Late initialization of default flash par=
ameters.
>   * @nor:	pointer to a 'struct spi_nor'
> @@ -3204,6 +3274,14 @@ static int spi_nor_init_params(struct spi_nor *nor=
)
>  		spi_nor_init_params_deprecated(nor);
>  	}
> =20
> +	/*
> +	 * Expose the SFDP table as an NVMEM device only when
> +	 * the flash actually provides one
> +	 */
> +	ret =3D spi_nor_register_sfdp_nvmem(nor);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D spi_nor_late_init_params(nor);
>  	if (ret)
>  		return ret;


--cfe8a98efb2086f550102e1210fdc67d01fd1cb7f4b563889cc6dc1396e2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCap61iBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/icDAF/VWHm4cvVi6eH69TujKUb5gNmCdX4yjPu
yiP2Tou8p7PZd9X/jzhrqIfV0NcAs73vAX4yR4pFZ09gnQn+PF04tW9ejbu3Ytxe
rKK0mE3hj2BhqFjwL4hmXUDfY7oWmgCUgvc=
=u9Aa
-----END PGP SIGNATURE-----

--cfe8a98efb2086f550102e1210fdc67d01fd1cb7f4b563889cc6dc1396e2--
