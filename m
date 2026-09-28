Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C343B813D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579068; cv=pass; b=cFyO++qMi4Ov2jjqMglqjjlXbnnRGDhRw5atWxU1U508ZlDA7GLA7OasWn5i+cDjzIhhW4jU8z+ZlfbVEPI5cDsuTAXzOde4kss616zokn3i1XrAzlf1agMK4D9JFtml3T3VO+rEG8Bgd8mbm1ff0RXclV/cMtk+O9T9qkfxX0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579068; c=relaxed/simple;
	bh=gpZb4HIT9lQgl71Mws1ZUbxCVnXNihqgKuERH+ysVlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+4zrPxHIUCNyTqv/uLEoLTQMHK3IIJgQ5w/8/2zvfGUZ4zjIrfDD/sAbVTs9E+ODwBc81mHj4OElc/JapzAf3BQrCixTdOgydIm+xcPRv4fGuZ+i/AaSNhG/Hmd2vyaeWkF8gxrBUysxtfU0ckMscw9E5JNtzskjhzfBO2QkQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlmF54x2; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlmF54x2"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a6502af787so18692531fa.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 00:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790579063; cv=none;
        d=google.com; s=arc-20260327;
        b=pWv65P10eqs3TZAX97fsI19EgDvAFsBxr7eO7Uo9DQ/ttpK9mY77MUKjHLjwQR9Hpi
         zAg6krVjuacFKYWy6CclPgh0NlLbuGqyka+FA4nLdG2BuPZvZ4UxXetTXOF0B/9WGKEn
         iNh/ty1ZlctLgGwdFmLtehnwA2omC3fFIdz2QCsqPlFkWs7KPPvBeawRgOsEHIQTTitP
         xdFMK+xe8NgoFR4rRxeeWHAdtECombYy+zhgcmD1X7u4Rd0khWhUlbhOI9xzNxYHdB4z
         wEHsPjdyUvaHR+F0PrOJLqQO1Y71lsZhv7Tgym0gTSpUsmK8hyl8f38cRPIQZWE9V+2q
         idlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8fmUSDAgYoEUGpnG4dyr2raLElAF9zIG7tCsXwnwAGw=;
        fh=wkMsneBvIm/+1FAKQ+DaoNc3GqVlWa/b+DnABvZ3NMg=;
        b=fycQ2LkW0CTNqpapuOU5/GWsQiGaszaSlK/3WG9v6P/68+uhfD8pf+W8lgLt7N/F9F
         stvJtgacLheKCRrJMp8el57HzT82kO0pbUt2b/dsHOOHIwOGkBoYXXRD5fqX0oxy7HjK
         Q8XUEICv/YXAAhxtsc6DGXFMAW2kr5lELAmrtBrr3+h3wHFymT6vJVLQrleFFmviAD4E
         Wt5auHZ+aQmFJhwSMTZEZczEiwJZQYkopMWaQVYjXj7IhFB207PWLGqzUpHIEB4TNIem
         NTflXdefYpUQqQroH/yJY5dU2q3FqHC+w3tZVBYargKwtfZCOqDiII/GKbpXJmAfbJJv
         z06Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790579063; x=1791183863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8fmUSDAgYoEUGpnG4dyr2raLElAF9zIG7tCsXwnwAGw=;
        b=MlmF54x2Kig/8jfHKe88EK0h81APiUWcYZP/z8V/l93PA5K76PPlP8wPYjmp9YAOTS
         xPd4vk0FgwLQI8hCpFqs2aUJWNV0j956jXMwnp24bAxj5nKMhdW5sHCNfupvJELRCb0e
         dXNODSI4FLP+6aAwhadHnnuWI+0Crr4nFwbyHPQglLTKZ0mPXkHB+5MEBskHRqdReMvq
         4/hyIX+NZKkReo3nKUj2+E5512zKavqz/SCNl69H87kkG1fETh0WgK338wpHmD4CIOQ9
         qiSoV6FCKz/tMw4EvGQT3xR8VPGocY1suIU4FwAMgE3qKZfOocQkzfAhIz7hgpjYMBLT
         RR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790579063; x=1791183863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fmUSDAgYoEUGpnG4dyr2raLElAF9zIG7tCsXwnwAGw=;
        b=mHf/EkMeGWPESTMWkuUf0KqKAI+LMV/jNAvycVVd5/byFqrXCEnjTMQis0rOVvGy/P
         oFX6xnft4Yx5CHqzFFKJNSDO6cupv3V/LnYhBY6ZaD0e64IDNaW4X9l9rjeQI9MnlZkv
         JlCrePxmwIw9WrV70Yt8s3Dy2MqszBzNoFFywKJyAS3+gOhgQY/7GBswMrwu2/DnQZfA
         z4E1ZLdRD4CXnm1o9x27As65lj1g280Lhb6xm+zksFfivnfdi4m8vJJhFzdUBu5E6WzT
         t3OAQ7xldb8ObIae0GI9sfpYqcd8HBL7X2KSgkvY+Vn1BWUOERpVUhS1VLBMqNDw5+eP
         pt1A==
X-Gm-Message-State: AFq9FYIzNzHWkFHIDuCcq6i06u7OeBzdEeK9ZT7gA1OAI+gSUgD6lpFg
	vsofwFXsdfUWNwMNV039mHxPt5VUgToTz+1aLlPkGvJxB/IWw0ZLbMyeb2Aoc4a/XcYaTWHuCy4
	H5Usqd6ZlPEcwICUdEfzYbV9at+L8Q84=
X-Gm-Gg: AYBFou1Sx4g8b5D0KWFeLpgnYHwwwqleL7YSzLgb/lexOskwxSWEk9/RqJXxZpvCqXs
	gX2LZ5I5MN4qbSMQGI9rJQkjn7iaGMFEA2hpPI4dmfT89XJkzAUZE3WKfDgPtd6PfhUXbWlggZS
	AxaTuDyRDWiP85pz86zklGptDBB3KV3XLgdL3r6/1xR65lzvrfZXtVJVy3Tqxz5mH+aLjMoh0YI
	OoVhNz0/G3Amtu9h7TgxsaXMLezu8HNb++El1fPcVa3lE4V55MtKFk8a2jlBTXtVYY1h6YLd2Q5
	GdvSZ6SV0Mdsu8sa9vIIY/yCpTsHEOzeTGk0NzOrVqqcR3BX11F0hQ==
X-Received: by 2002:a05:651c:1990:b0:3a6:16aa:23c4 with SMTP id
 38308e7fff4ca-3a63c435595mr33846191fa.26.1790579063267; Mon, 28 Sep 2026
 00:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927073843.346910-1-maimon.sagi@gmail.com>
 <20260927073843.346910-2-maimon.sagi@gmail.com> <6ab4896c-c4d0-499b-befe-045cafa8e470@lunn.ch>
In-Reply-To: <6ab4896c-c4d0-499b-befe-045cafa8e470@lunn.ch>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Mon, 28 Sep 2026 10:03:57 +0300
X-Gm-Features: AclHuK_wqe69CS137GKI_RXY7GDJiYuGuITU57U4UyfMY3zuTBaG8dDbNTOU8AA
Message-ID: <CAMuE1bEvTE5-MyXyP8Y_qekXEk8Uf0QUUFJ6DfFpc89TdYd4rA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: axienet: use device_property and fwnode
 APIs for probe-time config
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com, michal.simek@amd.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@armlinux.org.uk, 
	vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 8:55=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > -     lp->switch_x_sgmii =3D of_property_read_bool(pdev->dev.of_node,
> > -                                                "xlnx,switch-x-sgmii")=
;
> > +     lp->switch_x_sgmii =3D device_property_read_bool(&pdev->dev,
> > +                                                    "xlnx,switch-x-sgm=
ii");
>
> What version of the core is being used:
>
> 6c8f06bb2e5147b2c25bdd726365df8416c13987
> Author: Robert Hancock <robert.hancock@calian.com>
> Date:   Fri Feb 12 18:23:56 2021 -0600
>
>     net: axienet: Support dynamic switching between 1000BaseX and SGMII
>
>     Newer versions of the Xilinx AXI Ethernet core (specifically version =
7.2 or
>     later) allow the core to be configured with a PHY interface mode of "=
Both",
>     allowing either 1000BaseX or SGMII modes to be selected at runtime. A=
dd
>     support for this in the driver to allow better support for applicatio=
ns
>     which can use both fiber and copper SFP modules.
>
> If this property is not needed, please leave it as OF only.
>

It is not needed here.  The X2's MAC is wired to the FPGA fabric over a
fixed link in "internal" mode, so there is no SGMII/1000BASE-X switching
to do.

> >
> >       /* Start with the proprietary, and broken phy_type */
> > -     ret =3D of_property_read_u32(pdev->dev.of_node, "xlnx,phy-type", =
&value);
> > +     ret =3D device_property_read_u32(&pdev->dev, "xlnx,phy-type", &va=
lue);
>
>   xlnx,phy-type:
>     description:
>       Do not use, but still accepted in preference to phy-mode.
>     deprecated: true
>
> This property is deprecated. So it should remain an OF property and
> not get expanded in scope.
>
Agreed.  v2 converts only what the software node provides: xlnx,rxmem,
phy-mode, the MAC address and the PHY connection, for the fixed-link.
xlnx,switch-x-sgmii and xlnx,phy-type stay OF only, and so do
xlnx,txcsum, xlnx,rxcsum and the "dmas" test, which the X2 does not use
either.

Thanks,
Sagi

>         Andrew
