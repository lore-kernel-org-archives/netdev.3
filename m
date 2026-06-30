Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461721CC51
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858335; cv=none; b=s0psYGtq033tNur79oMYphHmx5JP8lfmhetsbh2D66JXIvYY/bd02wbEj86pz8x6u33XQgPeLo4s7RiimwI3IatDKZwXzAUgo7sGNzOT4Nb08EsNwT/ntQyujsUrUgVNROPo31aX0CSLGCbDlghulmMxFg1Fu77F51rt7PPLXqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858335; c=relaxed/simple;
	bh=vLhbE10te/VPBBt6ZQDRVIhxWYhikKNLXZOkJFDsW+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTM5iBNvbnoNNdvqbe4V6Q2eVlFR7yamsDiq3YCCsmAHEiZzIdXd5yovchFAo37SQzLhGgPlp8UBy1vPrH1WwgFPlA0/yJUrzV2XXMNJwiTt0M/YuTWO9rsMUjMPp3IvVQbVX8TzcrqNNCNmbYQPMVUeDm5aAdS+7+AZbfU5pT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO7G2t1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO7G2t1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43C01F00ADE
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858332;
	bh=lJSNchfWEyMduAfk7UjM53bR+D02Dxe2C6sVldFvt8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VO7G2t1Fop7D33uO3A+qYFU4/l49qMz4/fv7261otOP5CpUOFZac93RTf5iLSqCqr
	 e/eln6tInnaYZvtLwA6lA74onbV4Oa9fKZcxZQOG1AAbpxy2m+OeDcfmDH+nJLq4QI
	 zQFyjZP5nygLQQ1ZNMPk/DMTusm4KdUWG7lIlzdhcurKcO8og80hyqQmTMGfPHBVZr
	 oSTiTUDs2eM5DEo8XzJu8uMABRjNNbKy5dMR3QVfzqHZt1q6Y70ZDSezEsGF31qIqS
	 /f8aNeCj5iiqzEcKMWD7AplC9VBa7hffu7TKGV3vZd6IFM+ligf7Hy0CkmkWcMpRzE
	 iAcMdmOt3tK0Q==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso2726933e87.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:25:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RomrmFsrxx1yCFLKB3qUxImODc513nzO+AyPnL3wsjBZ0D4C4TI7K3PJmpTJl5oNXEMlJ1RuYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZAuTO+MtaBg3+33ZDisSoabW/cbVMukGCoFqAEnddY576/8Y
	U+QQB7l8xfJGgh9rT3u8c0F5pfakaHRg75gmI8+HwUUz98x7v+JZyynCWJXbQAOHToxVLmT3bnP
	YIa1DsQ9WNvw0YdBIpEtLTwGo5xEq2qU=
X-Received: by 2002:ac2:4bca:0:b0:5ae:bce4:b696 with SMTP id
 2adb3069b0e04-5aebdb8913amr1285650e87.15.1782858331615; Tue, 30 Jun 2026
 15:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630092406.150587-1-manikandan.m@microchip.com> <20260630092406.150587-4-manikandan.m@microchip.com>
In-Reply-To: <20260630092406.150587-4-manikandan.m@microchip.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 1 Jul 2026 00:25:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLk9Vw6tv+S0jno80g1cQNOJ8UH=E_XKEnXdbdKB6QMWJg@mail.gmail.com>
X-Gm-Features: AVVi8CeKBUAk9hYd7-xedVdQUq3OtUOkiZl_3QiYFyIqzcOrLBrHLUbSYsRIb2A
Message-ID: <CAD++jLk9Vw6tv+S0jno80g1cQNOJ8UH=E_XKEnXdbdKB6QMWJg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] mtd: spi-nor: sfdp: expose the SFDP as a read-only
 NVMEM device
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, srini@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux@armlinux.org.uk, richardcochran@gmail.com, 
	arnd@arndb.de, michael@walle.cc, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manikandan,

thanks for your patch!

On Tue, Jun 30, 2026 at 11:25=E2=80=AFAM Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:

> Register the cached SFDP as a read-only NVMEM device rooted at the
> flash's "sfdp" child node, exposing it in on-flash byte order. This lets
> NVMEM cells reference any SFDP data: a fixed-layout for parameters at a
> known offset, or an nvmem-layout parser for vendor data whose location
> must be discovered at runtime. The device is only registered when an
> "sfdp" node is present in the device tree.

It seems the existing serial NOR driver core already reads out the SFDP
and stores it in  nor->sfdp->dwords, right?

This should be mentioned in the commit so we know when the stuff
is actually read in from the flash memory.

>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
(...)

> @@ -3204,6 +3204,11 @@ static int spi_nor_init_params(struct spi_nor *nor=
)
>                 spi_nor_init_params_deprecated(nor);
>         }
>
> +       /* Expose the SFDP as an NVMEM device. */

Add "if and only if the flash has an SFDP"

> +static int spi_nor_sfdp_nvmem_read(void *priv, unsigned int offset,
> +                                  void *val, size_t bytes)

Name it _reg_read() to mirror the nvmem prototype.

> +/**
> + * spi_nor_register_sfdp_nvmem() - expose the SFDP as a read-only NVMEM =
device
> + * @nor:       pointer to a 'struct spi_nor'
> + *
> + * Expose the whole SFDP, in on-flash byte order, as a read-only NVMEM d=
evice
> + * rooted at the flash's "sfdp" child node. This lets generic (fixed-lay=
out) or
> + * vendor (nvmem-layout) cells reference any SFDP data. The device is on=
ly
> + * registered when an "sfdp" node is described in the device tree.
> + *
> + * Return: 0 on success or if there is nothing to do, -errno otherwise.
> + */
> +int spi_nor_register_sfdp_nvmem(struct spi_nor *nor)
> +{
> +       struct device *dev =3D nor->dev;
> +       struct nvmem_config config =3D { };
> +       struct nvmem_device *nvmem;
> +       struct device_node *np;
> +       int ret;
> +
> +       if (!nor->sfdp)
> +               return 0;
> +
> +       np =3D of_get_child_by_name(dev_of_node(dev), "sfdp");
> +       if (!np)
> +               return 0;

If this node name is required to be named like that it has to be
enforced in the schema.

I would instead check all the nodes (for_each_available_child)
for the right compatible "jedec,sfdp".

Yours,
Linus Walleij
