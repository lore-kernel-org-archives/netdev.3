Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3EA3AE1A0
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181097; cv=none; b=LEU4pt5mIm+R6Tz1t/2kic/K5bMaD0pjVTkkbc17NFu4+O2cXLzqvFMaN7cHTHw0owKUTqLwAEAoGk2I9hGz3l4/XYGREoGG+g8ZHb4+IENlnrbk+RsGWjZ4GT4qd4Qz0fVVAEA5jk6qV2SdsKuX02QVMMaZ/0wVzQvLk6/jQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181097; c=relaxed/simple;
	bh=IVhcthKda7SU/zklZndzOtW3+wT3ay5MeJ16BBZ3sok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BD1eqXaoj7gphum/bsnco4bM9BcAlbrYueaK00u0rw1DKUAmtPANLnBqv8fHBHTYJZ1b4MiBzINdWrV81qhdxxlveUM9bcx4rslaUTBgEEqndMcejcvD2RLOqzjO04DKkN/dyCaWzuD48Jm0fD53T1g4lXqPPJsq9Dfrzbsc56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSgvVltj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSgvVltj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8280B1F000CD
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181096;
	bh=G7xowrf/i7RrujZtiMaFxHYMIzRcnvNt4ex7CLwxg2I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nSgvVltjdWQkbnOkcmUkieLUYbJl0M7mXW/zifoTTfevQEv8Lb6wWFOoR3o3f3yNW
	 73nBX6xoE+76uVwUuQIbOr8aJMpCKxybw7QKGJn7DgPRPLEi4F3+CAwXxGw00hwnEt
	 luFe6A1W6Og6a44jaClh3xl70ZKs91F6E9/W7Yx/FRzMFka0C16kT2YoNv0i3GsUKp
	 FJKULe6id0PuC/ZHVTara4HVafZIfXumP5hi/BbkAUkDPrs+t2FBgKDI84Iqu/zzrS
	 GmYY7+hRBR1DhMesSb/6whaZU50LV45fDtyOrcev58ObY7m259yzv9TqeYT/7JarR7
	 3v640BWbrivCA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so233199e87.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:04:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxWdtGQkd5F6UUAJPDtZpnoC0K9za+dGAgP3x/5YlT7crDmQZ4kHJ0tmB3jDXNVTsYgKqc5CuI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6zxTyBHIm0jCYxMktMfGto8pwU19ywV1EHW4u9j8vJ71lJobp
	XW0tiZuIWMIdtypzH84XpWTR6lf49a5eOGe5NxMxH/ImLx06c4zMJZyGHM2gbJGoep/9j/S5M7A
	541MMDU8jLnzyRfO3+fi5PblPJBIt35o=
X-Received: by 2002:a05:6512:10c9:b0:5b8:f3b2:429b with SMTP id
 2adb3069b0e04-5be50a96f8amr181074e87.52.1792181095126; Fri, 16 Oct 2026
 13:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com> <75829f0c-69d4-4c16-8300-142023f840d7@yahoo.com>
In-Reply-To: <75829f0c-69d4-4c16-8300-142023f840d7@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 22:04:41 +0200
X-Gmail-Original-Message-ID: <CAD++jLkZ8bFmcrhcp8==ZMj3aEZ-6K2aaoJs993NZ7np1ShUWQ@mail.gmail.com>
X-Gm-Features: AclHuK-cBlHtYBbehsG7Gq_rgQ4QY05l4qZ998RyVlZDH5gD_s3XxDuhZU2Zido
Message-ID: <CAD++jLkZ8bFmcrhcp8==ZMj3aEZ-6K2aaoJs993NZ7np1ShUWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/9] net: dsa: realtek: rtl8365mb: set speed
 for family D
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:03=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.c=
om> wrote:

> On family C hardware, forcing a 2.5 Gbps link speed requires relying
> strictly on the HSGMII SerDes configuration block, while forcing a dummy
> 1 Gbps value inside the standard digital interface register. Family D
> introduces a dedicated hardware link speed value (5) for 2500M. The speed
> bitfield width has been expanded to 3 bits, splitting the most significan=
t
> bit into a new separate register field (FORCE_SPEED2), which maps directl=
y
> to a distinct per-port digital interface force layout.
>
> On family D the forced-mode configuration (link, duplex, pause, speed)
> is written to a per-port register at 0x12c0 + port instead of the
> per-extint register. The bit positions of TXPAUSE, RXPAUSE, LINK, DUPLEX
> and the low two speed bits are the same as on family C; the upper speed
> bits go to bits 13:12 (FORCE_SPEED2), so FORCE_EN (bit 12 on family C)
> is not set. A second per-port register at 0x12c8 + port enables the
> forced mode: the vendor RTL8367D API writes 0xFFFF there when the MAC
> is forced and 0 otherwise. This driver always forces the MAC, as on
> family C, so it writes 0xFFFF on every call, including link down.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

It's pretty terse but I think I get it...

> -               if (speed =3D=3D SPEED_2500 || speed =3D=3D SPEED_1000) {
> +               if (speed =3D=3D SPEED_2500) {
> +                       if (is_d) {
> +                               r_speed =3D RTL8365MB_D_PORT_SPEED_2500M;
> +                       } else {
> +                               /* The speed field has no value for 2.5 G=
bps:
> +                                * the rate is determined by the HSGMII S=
erDes
> +                                * configuration, and the vendor driver p=
rograms
> +                                * the 1 Gbps value here.
> +                                */
> +                               r_speed =3D RTL8365MB_PORT_SPEED_1000M;
> +                       }

Well what else can we do.

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
