Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47F29C327
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858452; cv=none; b=IWCh2gqGFZyGgi293duKXtIvIX+Rbc1ZLx9cYZKVGVBpe+0EepHe/Ld5wEccOR8Y3DSM2jRMYA1kvhSzaj+3eAWLFb38X+1gVEmOhRYR6eyfZBh5XNW59qJlfypts+yWONo4YN0dKfyxxVrLLpnYBZ+DDiwbio5+zXa2GpTZuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858452; c=relaxed/simple;
	bh=TTcVu3N5A2qxImNE8jx0tO9sA0vxx21QZu6VSH0wmU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XL+Ga00LgMq/n1j65GGqimUD58Ek5u+CnHTPQT9B9PvyrsdQ4x2wze3tQwZH3wE5AslTkEIIXvyt5IZOPdLL+l+AJMMwZ1NlqY5YTgjWmBLtQVTx9BvNifCsxTFUuhQ5mgAJs/vMfWlNLP7ZFMzPOKRsoMQ1jhsgwd8X7ZWSm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3nZipE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3nZipE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A761F0155D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858450;
	bh=TTcVu3N5A2qxImNE8jx0tO9sA0vxx21QZu6VSH0wmU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a3nZipE5rJA5y3N4Pt43hJP+a36yVR5xrcMfyXU20kSXL/EMJ9K0p232l6Wre9wwp
	 XZGaTAaW+es9sgk2ARLIAXeZYTEfZEKo5NkLTX00wcwnR0btmfhuX2qmDgsgRcXS/Q
	 BaQDKyMcLqkohVenN5e9fDl+zIbBLwde996RnNIGz3h3eKEQE15LGapkSZsv9IMD0m
	 Iqoina2XyIvqZEumLIqhlDlgyvjWqtUVlH/1DwkhbLX9mv9yy2rvdW7YtvW9bGvLLU
	 x9VHYe8+Vd4Yjn/Rs6RW4nQMcWgQ6Jl5XlPCKLmcmP5L7dbjrZpWPH2Edj+0omjQhI
	 Ur0N2LFTC6dYA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39af87c4589so33491fa.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:27:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrwrzYGp4dBwtzgb97TbVcNzcpIVkIlCI9Qbp20Kbfk7JFv36ehsslM1pJ+vbqHfUTtfiVVoro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Su+OCyuUwD5FxKXXvqSKODQuZHeWlQN7xbcJeTzuRZNNOexf
	eASmFyW0yXFqhw/HmREygua/qL5GvdHR+QWysiuJNz9Bj1tj1S3SnVmfGfVi39neFt4bix1X4lD
	EdhMiTFua57c62Kxk6RupOgn1HVrVG0c=
X-Received: by 2002:ac2:4bd0:0:b0:5ae:a2b5:3ae3 with SMTP id
 2adb3069b0e04-5aebdbb32bdmr1526007e87.29.1782858449161; Tue, 30 Jun 2026
 15:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630092406.150587-1-manikandan.m@microchip.com> <20260630092406.150587-6-manikandan.m@microchip.com>
In-Reply-To: <20260630092406.150587-6-manikandan.m@microchip.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 1 Jul 2026 00:27:17 +0200
X-Gmail-Original-Message-ID: <CAD++jLmURCUfQNoTgLeTRtxfoWxgyPcmHv6rJpmB1gXWFL+NGA@mail.gmail.com>
X-Gm-Features: AVVi8CfX0Qclfl00TlhG9NPtI9hB9ExKc-14XAFH9ZzPrWiRzE1N9YyLdRCBq80
Message-ID: <CAD++jLmURCUfQNoTgLeTRtxfoWxgyPcmHv6rJpmB1gXWFL+NGA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] ARM: dts: microchip: sama5d27_wlsom1: use
 fixed-partitions for QSPI flash
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

On Tue, Jun 30, 2026 at 11:26=E2=80=AFAM Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:

> Move the QSPI flash partitions under a "partitions" node with the
> "fixed-partitions" compatible, as required by the current MTD partition
> binding, instead of declaring them as direct children of the flash node.
> No functional change.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
