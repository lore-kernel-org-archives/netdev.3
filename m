Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2F30FC23
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857585; cv=none; b=DyxZ16Dma9dj3I3GqtAoSP5xCIIcVeIRkdRgYUGzFuqXjgn9tbLkvDiO1BsB3BwlfIQyzER12chS0x+LTdyE8Is4UQGyw1QTOlP15R0s7xAg4EkloqJ8zFdWX9aJ+vQ/LgZT4nzXX3sQyvs9cJRdrwl1YBBa2PVaZdNsiPdtdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857585; c=relaxed/simple;
	bh=a/lxtTDTDg9qHZ1XxJGp6GALUnxVcyilFnlyp8deNr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyWl+KCXt88aEw8tX/4C3H8l0gerGuAx0QHzPaV085EjGrQuLEz9VwV0rasvnhmvdXKaDFtp7DoxCxPJqxXBv7SwJVVbUUaW73P+6sFdhMe9Nt6D96IMpUHoI2b1SpXrC3UxOnEURCnshKkpPKDi1Ym7V2b0fZMwG4DVbl7eexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJgsHN6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJgsHN6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A4A1F00AC4
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782857583;
	bh=HM1j74yODPhJMYhAe8Gysw58b33HB8UlPnD7jYgM3wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PJgsHN6yFCy6uM8OzJ5er++rKVozMaAHvyDqrhtYfMPCCxrpB8AXLUA6uGg+5VklC
	 9duGS1uMgl4p3p5uoQL7TK9MhvxKTa2dKSCMTkS2w2VwjlYEbiWAkQa2L67HL5VVVd
	 9uvKdyQ3g4QVOBg20tia94Xcv+JC3R0uEMn+QJKcGoYACQdi1ovvRcZqMegBGiFT4p
	 hLtNn0IurWdCmVibLCpjZx2NvYHdoGJBdwYHxHXG+WkxypEPGGiZsPFfWJoND2Kal+
	 98zSH13AxZSGRmzDL3hBFy5vxpfe1HN4oOXaZk4ptIHXrsgqLoTMTFxyer7juhoAp7
	 7YulToC5Pm34w==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aea9d606f0so4354268e87.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:13:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpLhJVvKZbqkdWUQQJVQYOh78f4B7l277e7JII6pHR2QjBhmAWGZQkwJiWjongvjrvdEv5KW0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/ChWOZOiPWQFUjvtF49YwHwkmA7/1AokkJgwFspOlnYiPbeV
	6ABWA0JDCjNb/KU2kkHboEee/DV1Mibv3VgkHeXsg/O8anO9a1+TwQrTH8eP752Dc3XMmAFnr8p
	Epit3Asap/u46ZahftaMuiL9+V7eR4eE=
X-Received: by 2002:a05:6512:1248:b0:5ae:b2cf:8204 with SMTP id
 2adb3069b0e04-5aec10a3841mr657448e87.2.1782857582274; Tue, 30 Jun 2026
 15:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630092406.150587-1-manikandan.m@microchip.com> <20260630092406.150587-2-manikandan.m@microchip.com>
In-Reply-To: <20260630092406.150587-2-manikandan.m@microchip.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 1 Jul 2026 00:12:47 +0200
X-Gmail-Original-Message-ID: <CAD++jL=FkEfpz-LW0vmPpZ28fLfGFMWo5E479Mapz55YUxKNAQ@mail.gmail.com>
X-Gm-Features: AVVi8CcLJOfvOFl8jmVmAP_uzLY_UWoBigmB1_kTp6EN1gm7rCEox0bV8PbTeSw
Message-ID: <CAD++jL=FkEfpz-LW0vmPpZ28fLfGFMWo5E479Mapz55YUxKNAQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP to
 be exposed via NVMEM
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

On Tue, Jun 30, 2026 at 11:24=E2=80=AFAM Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:

> Add an optional "sfdp" child node (compatible "jedec,sfdp") that
> describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so its
> contents (e.g. a vendor EUI-48/EUI-64) can be read through NVMEM cells.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

I would expect it to follow nvmem conventions like this, notice
compatibles specific-to-general with sfdp first:

sfdp {
    /* NVMEM provided by SFDP */
    compatible =3D "jedec,sfdp", "nvmem-cells";
    label =3D "SFDP";
    read-only;
    #address-cells =3D <1>;
    #size-cells =3D <1>;

    mac0: macaddr@0x00 {
        reg =3D <0x00 0x06>;
    };
    mac1: macaddr@0x06 {
        reg =3D <0x06 0x06>;
    };
};

Your example should definitely be more elaborate like this,
just an opaque sfdp node will not suffice. Maybe a separate
example?

Yours,
Linus Walleij
