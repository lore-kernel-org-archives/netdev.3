Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB4413D62;
	Tue, 21 Jul 2026 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617376; cv=none; b=t0QUUdmeBE5la4HqNxKZuglSPMi7FM2MqvDB7Uhx1/yRZGhKHtE076A3cm+s+lNe4iCi/HG9K96djtiCbIg7yD70bWyYNvR7CiucJdDQJo2GPolqW5a7X09WpT2OV9QXngOue0GsALxPcXOGk4ZMZpz3Jvc5ob7IQVYPCsJE7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617376; c=relaxed/simple;
	bh=H4hK/ibIVE2pxwNdIC+xmJW91v3DH+/T7lNTkiQAUO8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=Yp0SQdmDPauBlTTKQcqL/V1sOXH3zP7gGSmYzp5niFV4peK8s/SI44Y9NvMoYlJ+PId/7WMkQtSqbhSciRwuS73ypFBLBg1xigYjsL2t6BF7DOcRNmhIYJ+SAuKagUXIuTNMB/fW6PN+muNNO2zvs00Q0vGCKuPzIt6shq912aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyLNqWZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyLNqWZd"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A15EE1F000E9;
	Tue, 21 Jul 2026 07:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784617375;
	bh=OBsF4MqETY56ssEgpu6SKhe35ZopnEYwy2uOFqShRcc=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=DyLNqWZdhVBsfe38MWOiQ7wvrNaacFN0VQKb45lMHeGqFyyjmOWiGCZWPejEzeWxS
	 y6gGoLWvI/ZwPHJPRBsTH3rJ5oq1Mv4js2JCxKoGNDKIb2ys1WaLHM9SHcwVYvzaVz
	 6KZPXfsV6sUyyh5Ix9A3lR5ihn9TU1mAF3qQZoA/lZatOuWkJCS4ClwUPGDH8FdFC5
	 qys7ZFF5IKLLmzY886x/T8AouATRw22Ye35FdeciKurzyu3AMj55oVRfFuoqHhNDV6
	 7aWl18jzA6txmaYEKuKhGX7fs2rz36AJhSXRgT5HHbAd4+gOJYX7dXCUgRd9dvmqwo
	 5imnmCyv9OTIQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=f646fa6642aebc0291ef5150c4b7b201441504be25ea95e6750cba8492ba;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 21 Jul 2026 09:02:50 +0200
Message-Id: <DK42262TYFG1.NZKF4VGZGSRM@kernel.org>
Subject: Re: [PATCH v5 3/7] mtd: spi-nor: sfdp: expose the SFDP as a
 read-only NVMEM device
From: "Michael Walle" <mwalle@kernel.org>
To: "Manikandan Muralidharan" <manikandan.m@microchip.com>,
 <pratyush@kernel.org>, <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <srini@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
 <arnd@arndb.de>, <linux-mtd@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20260721052859.171341-1-manikandan.m@microchip.com>
 <20260721052859.171341-4-manikandan.m@microchip.com>
In-Reply-To: <20260721052859.171341-4-manikandan.m@microchip.com>

--f646fa6642aebc0291ef5150c4b7b201441504be25ea95e6750cba8492ba
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 21, 2026 at 7:28 AM CEST, Manikandan Muralidharan wrote:
> The SPI NOR core already reads the SFDP tables during enumeration and
> caches them in nor->sfdp->dwords (see spi_nor_parse_sfdp()). Re-expose
> that cached data as a read-only NVMEM device, in on-flash byte order,
> rooted at the flash's SFDP child node (compatible "jedec,sfdp").
>
> This lets NVMEM cells reference any SFDP data: a fixed-layout for
> parameters at a known offset, or an nvmem-layout parser for vendor data
> whose location must be discovered at runtime.The device is only registere=
d
> when an "sfdp" node is present in the device tree.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c |  8 ++++
>  drivers/mtd/spi-nor/core.h |  1 +
>  drivers/mtd/spi-nor/sfdp.c | 86 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ccf4396cdcd0..b833d8ec2d65 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3204,6 +3204,14 @@ static int spi_nor_init_params(struct spi_nor *nor=
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
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index ba2d1a862c9d..0a6484298c5c 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -698,6 +698,7 @@ int spi_nor_controller_ops_write_reg(struct spi_nor *=
nor, u8 opcode,
> =20
>  int spi_nor_check_sfdp_signature(struct spi_nor *nor);
>  int spi_nor_parse_sfdp(struct spi_nor *nor);
> +int spi_nor_register_sfdp_nvmem(struct spi_nor *nor);

That's probably not needed if..

>  static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
>  {
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 4600983cb579..704799fe92ae 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -6,6 +6,8 @@
> =20
>  #include <linux/bitfield.h>
>  #include <linux/mtd/spi-nor.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/sort.h>
> =20
> @@ -1612,3 +1614,87 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
>  	kfree(param_headers);
>  	return err;
>  }
> +
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
> +static void spi_nor_sfdp_nvmem_put_np(void *data)
> +{
> +	of_node_put(data);
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
> +int spi_nor_register_sfdp_nvmem(struct spi_nor *nor)

.. you move all this into the core, as the sfdp.c is just for
parsing the tables.

> +{
> +	struct device *dev =3D nor->dev;
> +	struct nvmem_config config =3D { };
> +	struct nvmem_device *nvmem;
> +	struct device_node *np;
> +	int ret;
> +
> +	if (!nor->sfdp)
> +		return 0;
> +
> +	for_each_available_child_of_node(dev_of_node(dev), np)
> +		if (of_device_is_compatible(np, "jedec,sfdp"))
> +			break;

There is already of_get_compatible_child() doing exactly this.

> +	if (!np)
> +		return 0;
> +
> +	/*
> +	 * Register the put before devm_nvmem_register() so it runs last on
> +	 * detach, after the NVMEM device that uses the node is gone.
> +	 */
> +	ret =3D devm_add_action_or_reset(dev, spi_nor_sfdp_nvmem_put_np, np);
> +	if (ret)
> +		return ret;
> +
> +	config.dev =3D dev;
> +	config.of_node =3D np;
> +	config.name =3D "sfdp";
> +	config.id =3D NVMEM_DEVID_AUTO;

Or rather NVEMEM_DEVID_NONE? There will ever be just one SFDP nvmem
device.

How does the sysfs path looks like?

-michael

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

--f646fa6642aebc0291ef5150c4b7b201441504be25ea95e6750cba8492ba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCal8ZmxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jI+gGApwOnOpXUv7Zjj+U2mJCjeDL0lR5USIAD
0l7ybzzM7hifaHLRlC77ydazna1FpzDhAYCtE8Ybt4b1fhNt3fuTqkrImKBWU89W
wwSrwwJi/Sz4H5ZWP3Im1o+w6tW/n4epJHc=
=dC2d
-----END PGP SIGNATURE-----

--f646fa6642aebc0291ef5150c4b7b201441504be25ea95e6750cba8492ba--
