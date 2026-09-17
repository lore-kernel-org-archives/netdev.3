Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225F483BF8
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679724; cv=none; b=qaLfljaZ13Ij8Te3Mqa6hkBGEPLOD92OLS5hESnjTIXIZiZ3+6Dlb2EbQ+Q6QBcx2M3IuDHdtV/p5VWK2SAWWcE2ADd0eibnJym5FY6Ed0IwSiA7zLye7hVJLJzJdICc1p8NCg125zZMbNmkZLSzRugYcJEVWjBmzdSOIfLQ/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679724; c=relaxed/simple;
	bh=ojkgX1nspCMPdymsx+evHfxf1O3aHgw+gXlsdj87X6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHbZN7kEFeYpQDMoA2cNkOixg7lMiUnM1K8bJ1HJIRtniabu1D0k3U9xyltnnmoDMuzQGdo/Y4dVt/5dRbapzMaV/q+1g61wk9ZE5EOIkDvFMG6EAUD15TGGzJqXEzF9ngaWysRJE3E13661l5qJtstpha+4goOHZOAavRXqtBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ+1NesM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ+1NesM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A7F1F00898
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679723;
	bh=K90pTk13k05ePY/n1kZ8tY0YMwNaVlZEhLkDT7Q1q2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VZ+1NesMej6r2LCg9BBVBSc8avCCOnwAZsb4TxhoXvMPVMTTyUPuQaWzFKtsH/UZj
	 7FwYW9uuaiR6+v3t46LgsXi3QGIQ7JpxBJZZj5Ag1dBhlvfAUajEpezllITmMOfa9R
	 ytDzal12HKJbVHR1Cltar/KEUy/GAjVvDFcpPXaqAhJRm54xJ+K85OR5JCXpDWSoBp
	 p/r6kBp72+aHVHy83cR9kdy/1n5ITAm/onawJ6Wy5Ubih0wUfRA5gmfyCz9JGA1flh
	 nhdP1iZxAyOd3RtDMhR07mlk0fmpSirzEni9u+XGCKGjjAlhm2JUsrg8uxOPxOJeDo
	 XBO5dMnZedJfg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b88dc3bc02so55663e87.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 14:15:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw4gfwMLaAeI9IzrC0Dp7xWBnPti/QzLTZ5rofWMIjIiMNPJO3RIQUhTblsE+K1uxmQMfI9ixw=@vger.kernel.org
X-Gm-Message-State: AFuF++kE86eC7TVAQfnjSUAO9Zdgb3CL3sBrMUGWhv1e9u4mpRHemBEt
	8aUH1JkDAZXSr5s43zo2xub9cDpX/hXNnnw/w3y6taiPGYrgPXpdhjHKlHXnZNbBm3lmEcjRGG/
	MqBZSKuKmBmMBl4qIDTbkbfiiVEgL6RY=
X-Received: by 2002:a05:6512:31c2:b0:5ae:b91d:b2ec with SMTP id
 2adb3069b0e04-5b8c18137ebmr53644e87.3.1789679722005; Thu, 17 Sep 2026
 14:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916-ks8995-to-ksz8-v15-1-8825ff5fd4be@kernel.org> <178965134577.22033.16045801715665480170@kernel.org>
In-Reply-To: <178965134577.22033.16045801715665480170@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 17 Sep 2026 23:15:08 +0200
X-Gmail-Original-Message-ID: <CAD++jLn+Ap3E18C_N0cmn4W+-gyNMh2qioijS8EBcyzYsP=W-w@mail.gmail.com>
X-Gm-Features: AcwNN1UzTAYPKQLw7ECwF_lD00TrsbMLJtzSjQJXu2i_h7_bzAZUxDUmLcoOJY0
Message-ID: <CAD++jLn+Ap3E18C_N0cmn4W+-gyNMh2qioijS8EBcyzYsP=W-w@mail.gmail.com>
Subject: Re: [PATCH net-next v15 1/4] dt-bindings: net: dsa: microchip: Add KSZ8995XA
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 3:22=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> - [Low] Concern (validated as a FALSE POSITIVE, retained only because
>   requires_validation=3Dtrue): the new compatible `microchip,ksz8995xa`=
=E2=80=A6

OK so a non-issue, that's an OK then I guess.

Yours,
Linus Walleij
