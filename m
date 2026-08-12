Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15168386576
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520109; cv=none; b=GlsGGv1LcqtgJfuek0TYPsKmmJvgFZdmsZkcz78o/E+TknKJY1NHDJpKOakSHL+pUZ0AxRCXxExDYgRZj7qDtOJ03fxCwZ7lgJf7MJtuDdDLGzf7GtqWSLdfL17ZlB3+PdB6anC+3TVacXG01O3h5HLhOP0ifY9H6LUIEhSkDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520109; c=relaxed/simple;
	bh=aOawT6X28n8vcWBv1xANeTZjFAqJRU8c8iGH6l4NFPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlZlCwHRF0Ts9eGf659vmZupiVRrsBN4t8smiudmzQxtUdCJE87ut1OG2YlPFGGXQDmk4jl1yK47lBZ4zagL7j3YHBPv60nYg+76WUzOVAgREKS5Ewqogbr1TSWhBAdva/L49/Y3/XQPXx9a+t4bQuTIZscLWCUN1bkcNL0un3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD/JG9MM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD/JG9MM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7FF1F01558
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786520107;
	bh=QZtowjMlHYM3cvyZrn8M2V6bTZ5ZvhIgLzb9prhj6h4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FD/JG9MMT6ZaKy6XX95aWGUmtSM8IV7ZjCPAB/jTGXdX1liyHhPUgYJYOHK122fVG
	 iUaamM+OXAgp93w8AbbWza8sLyQk/eY9o2z1GhBXDJsEJMfehhzlkr4+TQHi3JNzQJ
	 UUiRjG/biwprPkUMT6Yi/RYJwo6QuEsGUEhw5pvI7CljxCvAJPqxAJAupdr0/RvJvU
	 7gRXcXZvkhMr1d/jM0On54G5Km4RkGWTLHSJY2i/PUrMWS44I2nVCrLEr74owcTDRS
	 Nj2gZ2+aNL2yd3ePXBqG/gjrPGMYivSwe4cFMvFJkZHprEvg7SqSft7P3cksjXqlWn
	 UPtofQXW6cqCw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b29599b81cso850313e87.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:35:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpLKxPXwg2ZNGAtvfATWYdO3eU+BTYCcEOqZ7w89M5MCUj3w9zTSp3LU/x52k+2d8zrX6RW6A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kXzIIaUvPaaCI7GRu45C4sD+5pZgi7KZv4RzqYgvwFQhZUQy
	m+ltKJFLI9l9XdFwgYjESpyuaZYXNhVCp0V1xMmF14f62n/7uPmxLHPvhED4Ls2duEk/e6ZA072
	4tpFr5KJToNM97+xhKrgMxT5/AW3RNdQ=
X-Received: by 2002:a05:6512:3e07:b0:5b3:420:884d with SMTP id
 2adb3069b0e04-5b44e0dd27amr394108e87.18.1786520106664; Wed, 12 Aug 2026
 00:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811113901.3114169-1-o.rempel@pengutronix.de> <20260811113901.3114169-3-o.rempel@pengutronix.de>
In-Reply-To: <20260811113901.3114169-3-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 12 Aug 2026 09:34:54 +0200
X-Gmail-Original-Message-ID: <CAD++jL=p3Y7-CmDqwB1-K6HGXg6AM=vkzP=9u-8FSG7t4AUFug@mail.gmail.com>
X-Gm-Features: AUfX_mz6X22zBD7OfWT6uGVjj7x6Myhrke3mZ7L_40UTJ4vDZ9d7O2lMo8q2zJ0
Message-ID: <CAD++jL=p3Y7-CmDqwB1-K6HGXg6AM=vkzP=9u-8FSG7t4AUFug@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 1:39=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:

> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>
> The power supplies powering the IC may not necessarily be enabled by the
> time the driver probes.  The binding describes the power rails, so enable
> them at probe with devm_regulator_bulk_get_enable(), before the reset lin=
e
> is requested and driven, so the chip is powered before its pins are drive=
n.
>
> Boards that do not describe these supplies fall back to dummy regulators
> (with a "supply not found" warning) and keep working as before.
>
> A board that describes supplies but no reset line still needs to wait for
> the chip to boot before the first register access, so apply the existing
> start delay in that case too.
>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Kudos for all the detailed explanations!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
