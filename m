Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BA4A841D;
	Wed, 14 Oct 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967952; cv=none; b=qucIMRzQIbkjN8qfBFatCaIQEQx4WSj/2fDW6df+YK4gEg7PiLhu02uuETtzySDSBgLAarj0wnoryqyZRUUr3fa4wYNKBPl7EYBtgW1M7lPMVLZeWAwq+py4qoyzblWTfpiTUqViE+WC5k/wByt7mM/VsZeyu9lPCxWAkO5Z9Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967952; c=relaxed/simple;
	bh=uBgXEUhJEyTCvIva/iLkM0JNPDAeftjCSjsxPOdBnrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TZnSDTArhyOE27l5y+vKJzDaAKKQ/A/LWhx9mPOAUyd7a8E/8DEtDrYqeR0TgeW4GW1T4qqJXYTEeBt4iom8yoyzmg29dCDqmDDj6CwmmLPfwY8cKcPkDQ+oWtKjwm6l7Wv/oYmURel4LoX7GWIPEwPEtMZ0pOORc4NQ9AmLjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I39l4qPT; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I39l4qPT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1F8BFC63440;
	Wed, 14 Oct 2026 08:53:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3A2A560368;
	Wed, 14 Oct 2026 08:52:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAE79103286A7;
	Wed, 14 Oct 2026 10:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791967940; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=i48MIGwzBxi2do2WYXSYPbruC3HoFCZMxRU1UUDDuYs=;
	b=I39l4qPTZiayixscQ25oSYYL3NpbdUqY5vfY8WjlnawudFpyJfGrP7Qd2xXs+oY+HTA5L9
	HYG+p+V4eBlDcIkQ33/sT8qNfxC8TxPzOExPZE/a5dM+N52o+LuWWB8KjPTdbW+x9UMPeB
	Qhecxah11hmwDPZRaT9PiF59W4bRSzao28f6nvWfzVCtSEvWNU49ziJdfT9UvzUTpIujSw
	iU/fUi0oEKauswQ54YxEGuXjuFAKJNNr7aF6yW+3HO1ThHWX9cevyrzYYK6akFYkZC0gOW
	PhIc3r6BCCYQxX/ItYeHQdHgIF9KDMPtMIGn2ZmhijQyiPsPDfQXidzI/a9xkA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <robh@kernel.org>,  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,
  <srini@kernel.org>,  <nicolas.ferre@microchip.com>,
  <alexandre.belloni@bootlin.com>,  <claudiu.beznea@tuxon.dev>,
  <linux@armlinux.org.uk>,  <richardcochran@gmail.com>,
  <linusw@kernel.org>,  <arnd@arndb.de>,  <aaro.koskinen@iki.fi>,
  <gregkh@linuxfoundation.org>,  <mathieu.dubois-briand@bootlin.com>,
  <michael@walle.cc>,  <linux-mtd@lists.infradead.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 5/8] nvmem: layouts: add Microchip/SST SFDP EUI
 layout driver
In-Reply-To: <89aa4ac1eee01e3c425c12367f1e036354787ce8.1790847519.git.manikandan.m@microchip.com>
	(Manikandan Muralidharan's message of "Wed, 14 Oct 2026 12:10:09
	+0530")
References: <cover.1790847519.git.manikandan.m@microchip.com>
	<89aa4ac1eee01e3c425c12367f1e036354787ce8.1790847519.git.manikandan.m@microchip.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 14 Oct 2026 10:52:14 +0200
Message-ID: <87fqy8zmtd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 14/10/2026 at 12:10:09 +0530, Manikandan Muralidharan <manikandan.m@micr=
ochip.com> wrote:

> Add an NVMEM layout that exposes the factory-programmed EUI-48 identifier
> from the Microchip/SST vendor SFDP parameter table (e.g. SST26VF064BEUI)
> as a "mac-address" cell, for use as a network MAC address. The vendor
> table is located at runtime via the SFDP NVMEM device (no offset in DT),
> and a read_post_process callback reverses the LSB-first bytes into
> canonical MAC order. Binds to an "nvmem-layout" node with compatible
> "microchip,sst26vf-sfdp-eui".
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Mostly minor nits, see below.

> --- a/drivers/nvmem/layouts/Makefile
> +++ b/drivers/nvmem/layouts/Makefile
> @@ -6,4 +6,5 @@
>  obj-$(CONFIG_NVMEM_LAYOUTS) +=3D fixed-layout.o
>  obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) +=3D sl28vpd.o
>  obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) +=3D onie-tlv.o
> +obj-$(CONFIG_NVMEM_LAYOUT_SST26VF_SFDP_EUI) +=3D sst26vf-sfdp-eui.o
>  obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) +=3D u-boot-env.o

Not sure this is ordered alphabetically, so in general add it at the end.

> +/* SFDP header and parameter header, as laid out on the flash. */
> +struct sfdp_header {
> +	u8 signature[4];
> +	u8 minor;
> +	u8 major;
> +	u8 nph;
> +	u8 unused;
> +};
> +
> +struct sfdp_parameter_header {
> +	u8 id_lsb;
> +	u8 minor;
> +	u8 major;
> +	u8 length;
> +	u8 parameter_table_pointer[3];
> +	u8 id_msb;
> +};
> +
> +#define SFDP_SIGNATURE			0x50444653U
> +
> +#define SFDP_PARAM_HEADER_ID(h)		(((h)->id_msb << 8) | (h)->id_lsb)
> +#define SFDP_PARAM_HEADER_PTP(h)	get_unaligned_le24((h)->parameter_table=
_pointer)
> +
> +/* Microchip (vendor) parameter table identifier: id_msb << 8 | id_lsb. =
*/

This is not relevant, we saw it just above         ^^^^^^^^^^^^^^^^^^^^^^^

> +#define SFDP_MCHP_VENDOR_ID		0x01bf
> +
> +#define SFDP_MCHP_EUI48_MARKER_OFFSET	0x60
> +#define SFDP_MCHP_EUI48_MARKER		0x30
> +#define SFDP_MCHP_EUI48_OFFSET		0x61
> +
> +static int sfdp_eui_read_post_process(void *priv, const char *id, int in=
dex,
> +				      unsigned int offset, void *buf,
> +				      size_t bytes)
> +{
> +	u8 *data =3D buf;
> +	int i;
> +
I believe the if against the length is wrong and should be inverted and
placed here:

        if (bytes !=3D ETH_ALEN)
                return -EINVAL;

Since lenght does not change, prefer to bail out early.

> +	/* SFDP stores the address least-significant octet first; reverse it. */
> +	for (i =3D 0; i < bytes / 2; i++)
> +		swap(data[i], data[bytes - 1 - i]);
> +
> +	if (bytes =3D=3D ETH_ALEN && !is_valid_ether_addr(buf))

Is bytes !=3D ETH_ALEN a valid use case?

> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int sfdp_eui_find_vendor_table(struct nvmem_device *nvmem, u32 *p=
tp)
> +{
> +	struct sfdp_parameter_header ph;
> +	struct sfdp_header hdr;
> +	int nph, i, ret;
> +
> +	ret =3D nvmem_device_read(nvmem, 0, sizeof(hdr), &hdr);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (get_unaligned_le32(hdr.signature) !=3D SFDP_SIGNATURE)
> +		return -EINVAL;
> +
> +	/* The number of parameter headers (NPH) field is zero-based. */
> +	nph =3D hdr.nph;

nph =3D hdr.nph + 1 ?

> +
> +	for (i =3D 0; i <=3D nph; i++) {

and here the usual i < nph?

> +		ret =3D nvmem_device_read(nvmem, sizeof(hdr) + i * sizeof(ph),
> +					sizeof(ph), &ph);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (SFDP_PARAM_HEADER_ID(&ph) !=3D SFDP_MCHP_VENDOR_ID)
> +			continue;
> +
> +		*ptp =3D SFDP_PARAM_HEADER_PTP(&ph);
> +		return 0;
> +	}
> +
> +	return -ENOENT;
> +}

...

> +	info.name =3D "mac-address";
> +	info.offset =3D base + SFDP_MCHP_EUI48_OFFSET;
> +	info.bytes =3D ETH_ALEN;
> +	info.np =3D of_get_child_by_name(layout_np, "mac-address");
> +	info.read_post_process =3D sfdp_eui_read_post_process;
> +
> +	ret =3D nvmem_add_one_cell(nvmem, &info);
> +	if (ret)
> +		of_node_put(info.np);
> +	else
> +		dev_dbg(dev, "exposed EUI-48 at SFDP offset 0x%x\n", info.offset);

This one is not really useful anymore.

> +
> +	of_node_put(layout_np);
> +
> +	return ret;
> +}
> +

Thanks,
Miqu=C3=A8l
