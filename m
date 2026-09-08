Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2A4C9007
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859100; cv=none; b=NSHd4NA5ZJ6nmoiKKWdx04B6+UxzoVmCFe47OfJIUvvBZwpHdGyVi52lfNY02TN+bxtrBKP1v11nPz+2iAUkmtbwzifHJPssTXj4wBQgR4BoZ33o4G8oTp0N7SQM9Mw4ezMzIDswQWEbQnW3fc1XA8Mf/SclHonBeV+CC0UIMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859100; c=relaxed/simple;
	bh=fq0xQsDyb2ik3dZe4uP1ij79Em4qxOoaPFTBW2VxLV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBgW7MbP7jFJtHi/wWHXzuRgYkfPpitIBOZ9aF8FSqoXxpiNNsy6l2VKayMcYZfiqpd4Q4/iV/xYF1WD3+Lty5h/dll7J8MhSRiCLn5GzWUwwsMktIupvEKcYFpYeoRf6pHnT4TljIgVPz/5lXNgsiYaRoD+I2WRFBN4c9ObijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCRjce4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCRjce4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D7E1F00A3E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859098;
	bh=ttt1EYKDcxlNEmsAsGYU9COirmzbKQtOH4t63nPbYsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dCRjce4K/qpUUwl0zmWUc3Lqr8F5GhutwT1mQnx2I7zsAEA2sQ2jqMJelccOSQdM6
	 UIR167vfchlZuexwIHcT2LClE/QU+xtpbn/EOwKLSH254DHWmqeojvbJQCnI44zHcu
	 bUOUQKwckvFxHevy03g13cbct+HMxJ4JqLH9wUICCSzOClqr7Z5XDHlKFlNHCoN2fb
	 B11aKA3EMFs8ES8p53axbBpIEMgXUSvIJrLY25cIZKndqlc2X8dyThwm32HqjtuXKP
	 cnfRaqnHrrIlh1Nil+t89WcPgtyI4eesPORHkiZ+F8KRo477+8XbizqEM1d5Y5OW/B
	 tBZsP5orz61dQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b4af4be667so4263030e87.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:18:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzFoRyQ/aOqYrRFLs164JLMXkz8+QalwIcYeOCZDaiDEKwWHbz88Ve3xiKXiBVpRwCdX22r5U4=@vger.kernel.org
X-Gm-Message-State: AFuF++nKJe3Qm+700o9qjPhm4pDmD86ADTnIGIstLlbA7ySZ5RUdCCJ8
	T+GsnYGVDmqrOV9LYinSx9saAnKwlxfy3JJg+e8mmJxauwmGcS8i9CYgu1Zq8UrgYu2JGrytboU
	ibcSs1ij3tItS/DMXvCPqwESCtZs6ABg=
X-Received: by 2002:a05:6512:3503:b0:5b6:4ae:8c02 with SMTP id
 2adb3069b0e04-5b61705c1a5mr4219196e87.29.1788859094494; Tue, 08 Sep 2026
 02:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906-ks8995-to-ksz8-v9-4-8d8815a91bd8@kernel.org> <178883938748.219967.12302213755391446012@kernel.org>
In-Reply-To: <178883938748.219967.12302213755391446012@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 11:18:00 +0200
X-Gmail-Original-Message-ID: <CAD++jLmv7-hkXDffi=Z4zYpjcArLjUEnB+YAVbd3Mgqu2s-MmA@mail.gmail.com>
X-Gm-Features: AcwNN1XPvHC8mn8i7RF-KwxIUTvQeolrZeAaU7htbGYDUzfJd6lLIOKyWMxF3gg
Message-ID: <CAD++jLmv7-hkXDffi=Z4zYpjcArLjUEnB+YAVbd3Mgqu2s-MmA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/4] net: dsa: ks8995: Delete surplus driver
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi netdev-Sashiko,

On Tue, Sep 8, 2026 at 5:49=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:

> [Severity: Medium]
> After this deletion, is the ambiguous "micrel,ks8995" compatible handled
> only as a KSZ8995XA?  In ksz_spi.c the ksz_dt_ids table has:
(...)
> Does that mean MA silicon now gets programmed on the XA path?
(...)
> Two in-tree device trees instantiate exactly this compatible:
>
>         arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts
>         arch/arm/boot/dts/intel/ixp/intel-ixp42x-actiontec-mi424wr.dtsi
>
>                         compatible =3D "micrel,ks8995";
>
> so both boards move to the XA path and to a different tagger.

As mentioned before, both of these boards use the XA variant.

I guess I'll just add this information to the cover letter so there
is context about this.

I will look into resolving the other comments.

Yours,
Linus Walleij
