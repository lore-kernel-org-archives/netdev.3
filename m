Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8273F0A9F
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525157; cv=none; b=LSKiDQIJGj0ZwmOp17q2rNYvwFdU0tEcRGau83j/Lo/nxg0AGkbilsAW4pFspReJn8TQHXnHD7rZnVmsS6JGSEoH8Pvm1QQQt/jhnbg5PGCq0z4USdysIM+oCI3E1FrCcHOlvmql3lSxYpXcPw33t4lU1Yab/jQwPnQLVa3TCpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525157; c=relaxed/simple;
	bh=vANEtx02YGciCZihBKUYNtj/eBy+BpTaZ8ueDZBr8AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOPsoUSO3DZ6uLABoABnjT2M1t1rvpymAw0vG29a6yOt/mrdVGsf3pbVti8XOj7iLyh2fnyy1TeSOWuig1vi5RNf/tu8unmJfA+Hc/LLyDyGbO1HQNnq6lBXUpctr/XJWwASdHIy0Z3QY8fxR6ktePdtIzrM6LD5xp/4ANK4BEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8828138cc95so17802647b3.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 22:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791525155; x=1792129955;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHcCOJlfDk2kf/nYjNk1wm3um6Oe/oxI7EYgEHDQ21E=;
        b=Vjpnq1G7gEWCamNyAFNoqPgPKvkH7xdugismCVOXF7bbuCx6IzcRPX1VHxOFmf/t4d
         4P/J44WNGRsl8ZsuspbX9Vf1FhKUvJvFMTxX6uoQ/YihBkUWkjyBjdn3UeiwfsZoLbuu
         1UyZ2H2qtLpvkQTguV+5cYdFtNGT92e56M+xN9WBByrxiJbFkpurmO4v0uH2CN0GbUyf
         8Mfc6rMVrS1ypWf+EWMfrm53gZwqRoaYE0nIB7BNsmYUJ0gmKHCowuWrFtjIWCE2YkFF
         T3OWIvsfdHdhK0iO7jt3tchLgGTTp+xIzigZAMp2aZxt3CeOGYctik8r7yS8I/JqCsUD
         Ctyg==
X-Forwarded-Encrypted: i=1; AKwUvByFZTlSwfXt2F4VnnI1SkI6lb7bO1fpwxvTbjXaSyVe3M14MQoeglMoDx5EiCHCAen0AwC8v3w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPPJUerJtwYOhAgJDuPeVSSfxc1W/trTUGGPAfHi0in69lEqG9
	3ZVr9LPDJgaIQc+75OKCuxVDpyfTyxp5clMRNZ9Vkk/NQneBqpRu8BldHOBQa4fQ
X-Gm-Gg: AYBFou1GcxkTYGZWh4VRE26JpDnxKVg5bensHjUdQbb+YCUyXJFVTjUlvcZzbpZqM6I
	nnb9uNM+jUgd5Wuox1DQYbkYB7y/nchC9bRK83JvLeYlDdpCk4/VNjBUIysWBVN9UQgwi+CC0ly
	xUbXy9TulVSFewlpbzG3DwsivOvtM+d3gW4FCq4CIfP2itPm5tOi4RGYSMsyAnDS/vdo3chXALN
	QTvgjF/hDvkvScacnPhIy27nOplQtZ8ML5zuaR7WvY0HUPH1YiS9C1yEmCLfLfbp1+cEj39QxpM
	UM5tCw62p21Anfz1tZxN1/fIlXB5+6lNMqnC1QdcZqrTLr4I4VWhacUC3Hih6xj0HHRYL/IVV7M
	7vSxunH9FWeOP5pVfwn45eD6r5F7n0YKc9M1erA2rBdymyQ9TJJZBViokbiVu1sVK/GiJRVJGpT
	ax/fXBVKRLLHCdhr2mwG07HY+uEoKax9/7nsfCpOrenl1iVL+d00gLODcjePDMXWZ7hmtK8gGOD
	gShTFWEam38hqKdpCWaIhWJI2wp6W+6sqIyMOVxHyhPSA==
X-Received: by 2002:a05:690c:dd6:b0:8af:1191:a65f with SMTP id 00721157ae682-8b07ee2f438mr3077247b3.40.1791525154777;
        Thu, 08 Oct 2026 22:52:34 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1ed781sm3506587b3.25.2026.10.08.22.52.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 22:52:34 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8ab38a051aaso38505137b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 22:52:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxp4Ws9Wb1q3emgERbcOcxDSDT/6dsZLaXZ9h8l8vJou09GsNOnPCg3Iar5xbq3zj4OhHxMlZg=@vger.kernel.org
X-Received: by 2002:a05:690c:e:b0:88f:62ba:512b with SMTP id
 00721157ae682-8b07ee3297amr3678357b3.42.1791525154408; Thu, 08 Oct 2026
 22:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007082627.63807-1-tanure@linux.com> <20261007082627.63807-7-tanure@linux.com>
 <c1764303-9f18-4487-ba93-06173cd8a53f@lunn.ch>
In-Reply-To: <c1764303-9f18-4487-ba93-06173cd8a53f@lunn.ch>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Fri, 9 Oct 2026 06:52:22 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+1BZky6KUtqZKm7q8bDfWKV47xSZtK31qdYBWx_e3uwdQ@mail.gmail.com>
X-Gm-Features: AclHuK9uJycl8wPMvbL9js8yfzmf_wvwEi-NV4Dy7HnHzbbgfaJpxaRVEvgynGU
Message-ID: <CAJX_Q+1BZky6KUtqZKm7q8bDfWKV47xSZtK31qdYBWx_e3uwdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/7] arm64: dts: amlogic: t7: add the ethernet controller
To: Andrew Lunn <andrew@lunn.ch>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 2:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Oct 07, 2026 at 09:26:26AM +0100, Lucas Tanure wrote:
> > The SoC has a Synopsys gigabit MAC, a block of glue registers that
> > selects the interface type and trims the clock timing, and a
> > multiplexer that points the management bus at the on-chip 100M PHY
>
>
> > +                                     internal_ephy: ethernet-phy@8 {
> > +                                             compatible =3D "ethernet-=
phy-id0180.3301",
> > +                                                          "ethernet-ph=
y-ieee802.3-c22";
> > +                                             interrupts =3D <GIC_SPI 3=
40 IRQ_TYPE_LEVEL_HIGH>;
> > +                                             reg =3D <8>;
> > +                                             max-speed =3D <100>;
>
> It is a 100M PHY. What supported speeds does it report in its
> registers?
I cannot read them. On the VIM4 the MDIO mux points at the external
PHY and the internal one never probes, and no board in tree uses it.

The line was copied from meson-g12-common.dtsi, which has the same
max-speed =3D <100> on the same PHY ID. Dropped in v3.
>
> You should only need max-speed when the PHY is broken, says it can do
> more than it actually can do, or when a 1G PHY only has two of the
> four pairs connected to the outside world etc.
>
>         Andrew
