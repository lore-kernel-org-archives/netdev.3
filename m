Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0146D558
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925601; cv=pass; b=Ky66RD5nA9ImLDNEF0+ctJnc3C3uWtVDmIP7UkJcwjtV6ygqDCv5Esrtkx7YOtXJDFQ2cXzUA3JA4f1kxjGoge+LqB6e/sgzC8xjhwqXcvOV4KwhznMkbC7lC22TR5EkXpHbKBQIOhH7HDjnpjVD5ze9brgBxEof/DWqmiWEAuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925601; c=relaxed/simple;
	bh=PLDkatDMFuj3LfTf/LIfXkKvgu8bZZ7TEdRf9Z+1JP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvtnE1T/PL1CVReFykiaDS2YTU+D68MCTKy+NqEQJiWR1k+sMYo0B7YuBEO5rcuM7sOJbeCMwVL2tHalPMpVQM1uEX+ikJtEoyEerYMyfKnlLx513lrkGoGR01OMnEmfooAARP1sQRt2MsVaEqldGL3P5Z6Nu+278SbGvkkZr54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtnER0Bx; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtnER0Bx"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so1139928a12.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 06:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787925597; cv=none;
        d=google.com; s=arc-20260327;
        b=VarDjnr47hkYDSbcct8xBpSWtl6ZNekKqD9TrSI9rqARzDVxVXNj54WBpOmjVEYnLQ
         S7RKMBeRetsBEXuoohz0U1RQ3An2TiTQAEctn4RgvEEgjJGtQl7Vx1KQYvvC/lmrJcp8
         oDaUvm3Mn6L9w0MbyutZuwKUx6Tr9A1PABYHEpv/gOeMaGmU608hgbCJhVtntVy49HJE
         a/Mg2YgM2I+pQhNAyCG15ZegnJTkuRsTWV8Xyxtb/UJCoIy6ZR/KEwUoEGT1HUAD+c0K
         Wldrxth1whRZ5ywZrqHAHwcJyQeYkcsEawnIZEYHk7yALVdrrBrbWtEq5H6pgMcfwTIw
         4rPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2GfMRvhyksSuSYcJwpV/kMHEmDv12BqauazUIu9BuUA=;
        fh=J1OTgqub8q+HBtjJXz7P2Sd+MLrs37u4BfZZFCtuEfA=;
        b=bJMYOo3E+5gi5XCD1KOgr3/Yn7yvcUoE9IO/1sWLIz6GRvMLAqM20qu4FQ/7ioxL5J
         WRgP8V+QJ5412WwYgkwiecFQ49UmFMgQcnLe4TwK5mabbx4U4trsT+gtANNAjEpE4Vpg
         +6U5bgtHAvCzOtEa8OdDRk50SVBgEeBPcxB/SetwVQF9hWKKz/9qwlQr2CwgCxpPoOTp
         datLRsR0y5Kraca3cQED+WKTx2JQMwmo4jQyIK+m/c8rZA1p9UrA73Szw0g/Bfv1XI3r
         jWd9ClpTr/9TtorAcajF31FcW9n5Z3kHdW2YIRZR9zjLqoNMD69G2LDNi+Q4sx7L+VEj
         W/mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787925597; x=1788530397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2GfMRvhyksSuSYcJwpV/kMHEmDv12BqauazUIu9BuUA=;
        b=AtnER0Bxly1hJYGTtR8GyEKYZH6vPsORM/+OpfltLCq8OBF+4n0jmIPUVGtw15zRwV
         iILX+zxOOiN7uxMcBuhcqkS36vjc5YGnZABQ6bMjl4zVJxncaUhypXJhlcWx3z15LOPn
         YUo1x+pAQqtNRmOJoi+4c5yplNvJY1iwAfpO+rffoWgapXS0J+QeWI9vLys5RMqODo/n
         bC3F4DN2e+EOn7TeZXIEirFh7HV1H4+F4AiBj2Sfto9L82dEbsJpYUSCnQ7pRe9GGi2Z
         8b73nHVkgfXKpxZCmPJvO17yMwukwHY+u9OtcXasKCp4HyQOZRNCv5Jy2P6mlRzVOTZM
         sWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925597; x=1788530397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2GfMRvhyksSuSYcJwpV/kMHEmDv12BqauazUIu9BuUA=;
        b=cLsnpnhkbbNHwWvX9W51Jyo3vErp/tnOadHCaeHMTgESeV104B0BaCZWVjEFbOaX7a
         FaLp6wxpKiBVdfnIBFMRaEgD3U0/K5jFedkBDBjijUKPTBVxVW2P5DLGFRsDcsw0lbqE
         EANVM3/7SdwKTBv5rf4ajUplYYgi3DaQa+iIhxdPhvIZZsrfkdJ5Ir91AtMJM0j16ER/
         WE7U27ynpU3s+JeMkRe4DGZVgj240lgIiA0jvGM7BMdRP2c8tZHDvEbOCL0c3wvMAxL7
         jzhXAYA6DSlw9heN1dmVnY/s2De7cd8lrZPBg+8LUUjtsKwrRsY71KrBTprnNMwFoeAq
         Xsiw==
X-Gm-Message-State: AFuF++lQFAe29rc/Hnj0csbmg7D/77B/cJJE5bfjzLWq0KKwqO2jsfzl
	amXhz5MISzwatxQq1IRghF6Q2Dh64Uv7LdmFBkDMmfp0PIDsvdrMQyHSekrgO5fnDvBZrfFJXjo
	2sjZ2BokaNBoc44pzbFq6oPMu2AFa1yU=
X-Gm-Gg: AR+sD13qz5pXTA2UHXoEEv5CK8zEZLTu9GU6L/AJ4cEOl9vjIW91cE7vtk07geIcM41
	AWlBIPQncOBaXykQZTj/K80IpwRUbC7KfrfWt4fLP67ne310BoC7tWHVA50ojHgf/BGlXSXKIGB
	2Tx3I05v/4KR9wTulcPAV6tHqvNz9aC8H3xVjJq2JqvBHMxFEJMlkRtyTYcI6cWl7CcsNWyBUui
	SMlnyG0VFr0aL2nbLO40Humt4czaPOdROtaSAAxZXBcFB/Mce+B8iRpNhg8oreU5UQNaVa0OCDO
	VnFtSc2UyKWJbAxBITquIyRWpeTZpnKl62plfmYi2bjUno8=
X-Received: by 2002:a17:90b:2f8d:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-396d0a3f016mr16289039a91.0.1787925597040; Fri, 28 Aug 2026
 06:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828032922.469449-1-xuziyougm@gmail.com> <0db183d7-3881-4f81-9e04-cd2c13d1dcee@lunn.ch>
In-Reply-To: <0db183d7-3881-4f81-9e04-cd2c13d1dcee@lunn.ch>
From: Ziyou Xu <xuziyougm@gmail.com>
Date: Fri, 28 Aug 2026 21:59:45 +0800
X-Gm-Features: AcwNN1WIz7kiRjyaUFUv6xWV9lPHFkUCwWjJHmG3pD7abaxNcROmy-pxsGrQvww
Message-ID: <CAF2gcSUVmn57iSo_Vf08+QWHxAoDRbpuone5MOnMd=4c_GhfGA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phy: air_en8811h: restore AN8811HB LED GPIO
 after MCU restart
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bjorn@mork.no, ericwouds@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Right, I'll fold that into v3.

Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2026=E5=B9=B48=E6=9C=8828=E6=97=A5=E5=
=91=A8=E4=BA=94 21:09=E5=86=99=E9=81=93=EF=BC=9A
>
> > @@ -1265,10 +1258,19 @@ static int an8811hb_config_init(struct phy_devi=
ce *phydev)
> >
> >       ret =3D air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
> >                           AIR_LED_MODE_USER_DEFINE);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> >               phydev_err(phydev, "Failed to initialize leds: %d\n", ret=
);
> > +             return ret;
> > +     }
> >
> > -     return ret;
> > +     /* Restore LED GPIO output enables after MCU initialization. */
> > +     ret =3D air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> > +                                       AN8811HB_GPIO_OUTPUT_345,
> > +                                       AN8811HB_GPIO_OUTPUT_345);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
>
> That can be squashed down to:
>
>         return ret;
>
>     Andrew
>
> ---
> pw-bot: cr
