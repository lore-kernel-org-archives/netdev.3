Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6EF395240
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876961; cv=pass; b=nPIF1+hoTlwn4ZnBYo/htejipmFXFiuw4uO/ULdH6c0Qj8PC/W91xRLDV/UkrkGjBpBYWma6k1zhCEV5mfG3hN6LHYpoFiyVJiqJhrCjFBzkUVNbbaLRiMX60GMYeqyN5Uc/dsqUNbgJy++HUyFLsgLjJb/whv193+/BT9U3hkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876961; c=relaxed/simple;
	bh=fAMHUezArC58uR8fNC39WSTbF4zOBRtTgF43Gr+3CQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qx6vev4PZgourA4qxtZWwmZc1ydfu5ktlfdtCCNHRvzr9fGZq5LtqtheihCI+qrtpziw5VcleakxkCdIGlp4FD5bry+xvkQNOWda4lkk5TG3jRdieqUq7gVtmfyhlgiTxHBFIgWc7MLTIMJD2S8T8jDclhEDH8Ll99NsU7r5y2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inekosyC; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inekosyC"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so119797a12.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 13:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785876958; cv=none;
        d=google.com; s=arc-20260327;
        b=ia5oTECZiP0uNf47DuRgotFg1POU8rJ/di4jMnM5xkiKB/0Vp6GUziaecHxAfwBLXX
         7o4lyDhTID1rpB+bsjQDhEddS+rLAH7mJJ4nhrjZ22rWeib8wezZCEssD8fgIJwn2gLg
         DWpiadwS/638uVh2/qEB0yROXhNfZXc5b8ARaZCrvyPF15Fh29oMCD8FSWIfOeCd7wt2
         cjIoRjr/Q7ekIm20AXYmGG4swzxaWLqs5iIjorKxwjk6ABP2II6M17lKK76j6fDkWwim
         3d3stOy2BVGLYdrdB1p+fi9aFP4p54O6XojTiRwa1Jp2kUEQ0skF2caIpGfxeuSRaDdT
         WEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zR+++P/pLGGw10TF/az160wsfRUmUXR3IWxGzjH9rU4=;
        fh=cGX2glNlNf9t/mPQEDepmXuuHXA81GnXfLkKXFRIUG8=;
        b=qFKodWXEwSqpU+BS08yhAdIs+wvWpZDMmLGcSf/hIiGiHC57p6XeA396QK5XEUEPsP
         lIAhEcY6rSJ5rrrSyE9bgvgpNAfa6zxOsk4vQV1alJA272Med6Xt6YAKiuaR1pRm9u4I
         ItfdpCuH/NHEluMF/WzGvDZBowm+VwgMV98ezvGt21RJ5M/bg8oyZ2qaQ3qJQAMa4Ur4
         KVNRfMuGLBi3oou+dYllAzbdYON0JVzA6vkbgIP0+dNhVOOK8z7o3X7TPFIjputZC5fk
         AdFVHK+PwO35fHCF644Kfv4xdGGKJUxyD+n26safaEvXWvL06LEIzdeBHKeu8YGPxodu
         XdCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876958; x=1786481758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zR+++P/pLGGw10TF/az160wsfRUmUXR3IWxGzjH9rU4=;
        b=inekosyCIKHqbALzw7EyMMTpSC4K8RCfnQDav//wwUwjWiMCHyIDNSRzn7OzzHzJEq
         5uRYefjPFM1hB5pdb5S6K7cYH+s4ZeYAgo4wl1sqnIDJOYhweA56nedvGMOOQx2fOpRG
         1wGlZiolYRDem48nTbUsPH37GnHdqiQnSSBguuIG4iz6lmudbopmd3xh0SCAPHkxQ6aU
         9/vP9zq4Jh46lefJK19Qetyt1a/ksgOkib5OwE8mFzaKc3MW9ZNg5SC18yQW/yjO7PFd
         SIz4K2wAxM89g+iZXDSBpHIzUO8IV3rxiPv2VimeEYJsJJMPOk9cxRhFAWKA+ExgZ7/G
         2Leg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876958; x=1786481758;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zR+++P/pLGGw10TF/az160wsfRUmUXR3IWxGzjH9rU4=;
        b=TA1c8zZahdEzzSiPkA1yS0/QBWucXjP5B+W2aHU/Jw3xh4fp5k4+pVQBH3W8oczOae
         80Ir7e6xu/JpSVW3YJuM8uocQgWUzKmavNG56p3LSyooUGTq8+Eh5kfOumVY5tzTxyQg
         vTXb6kbQ+/jfnDD/Xq8aHC+PqcrfEFTMvLx5W5DgD+122Y3cbvnxiX03g//q1ZB36N/n
         +BSNNFl+pwZJH9AO7tW6Y/o63Oqa1zA1dADj6Ahz3FLnecAP3cJ8qkTUV/isQ1+zdfec
         q3YbBLyC/vXzdIDBglJsiAlYpir4km6PueionYTtJZ3FNAKoBnGGaq+9k1kM6KjhcZGJ
         xcYg==
X-Gm-Message-State: AOJu0YzD3QLVv3EG6vn1Cb81Gus2IJyKcVDos62u6+9xHmxLLyZAdMPR
	nVuWvMhbJEPqka8uWCSfB9f2fagoYFBsMEJhyz2bsUmcovBSQ5Vue/aClPDzKudbZ2F2GEmifcB
	FnMbndk21tgQhyywNj3renN6tUJpmyqc=
X-Gm-Gg: AR+sD11yGrbkrYg+BjcTi07tfup1HK6EBvVheYgCbq2wBNFAVBFn51lKGZhZwPTUrwg
	Gv7owUbaTRmJ949nabFVSCAoTyJvG75Wie0KBXzQKYxtpB5fOOjL+cMU1RiSNg3sFwgZR/yiii3
	ojEIZ7O/Z28uq9eCUldYnoZ/51h0xF8Y8VsdePPfYjIEGs5rBWbn16c7AIJVL/VGqimDLX8+UaY
	OzfUkYDsZtACMWRwBlfU2X41sm0zK5dK9zIspaSn9KxopC8SoF+rQVmvylE5eSz45+2429qN+t7
	jT5K3Vy0wczFGZxoZMi8gyHLr7BbrkowoyvJuC0isK0nV54ozAHG/xw/gseQTuir8bwvHjWeXtt
	pmj4vdh0zcSbOFBM9vcsEsqQlTyytwqlA8c/64UU2eQlk8bLAtKYMkOsIvsm8R7dgv2RFLFGxhJ
	NGTz33P0YCPr5COBM7lRFg71+htH6Ly5J6mNCAulI3FPIInxQIiQTuUVU=
X-Received: by 2002:a05:6402:5188:b0:697:decc:7f9a with SMTP id
 4fb4d7f45d1cf-6a14f0e3895mr903543a12.9.1785876957840; Tue, 04 Aug 2026
 13:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729202953.704662-1-rosenp@gmail.com> <845bb9f6-73e9-4301-a5ee-94e7f7aacd88@redhat.com>
In-Reply-To: <845bb9f6-73e9-4301-a5ee-94e7f7aacd88@redhat.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 4 Aug 2026 13:55:46 -0700
X-Gm-Features: AUfX_mzis7sgeJcF6cLGH85YSpRtHBgW9r-2amGtUvZGpPj5OTqtXQkdemNHYwc
Message-ID: <CAKxU2N_hCnbJRRtP5bqVVRavORZVk-1UbKMEZ6s-FhjkDEbMUA@mail.gmail.com>
Subject: Re: [PATCHv3 net-next] net: dsa: b53: srab: propagate errors from
 init helpers
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:00=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 7/29/26 10:29 PM, Rosen Penev wrote:
> > -static void b53_srab_mux_init(struct platform_device *pdev)
> > +static int b53_srab_mux_init(struct platform_device *pdev)
> >  {
> >       struct b53_device *dev =3D platform_get_drvdata(pdev);
> >       struct b53_srab_priv *priv =3D dev->priv;
> >       struct b53_srab_port_priv *p;
> > +     void __iomem *mux_config;
> >       unsigned int port;
> >       u32 reg, off =3D 0;
> >       int ret;
> >
> > -     if (dev->pdata && dev->pdata->chip_id !=3D BCM58XX_DEVICE_ID)
> > -             return;
> > +     if (!dev->pdata || dev->pdata->chip_id !=3D BCM58XX_DEVICE_ID)
> > +             return 0;
> >
> > -     priv->mux_config =3D devm_platform_ioremap_resource(pdev, 1);
> > -     if (IS_ERR(priv->mux_config))
> > -             return;
> > +     mux_config =3D devm_platform_ioremap_resource(pdev, 1);
> > +     if (IS_ERR(mux_config))
> > +             return PTR_ERR(mux_config);
>
> Sashiko noted this strict checking may cause regression on previously
> working setup:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260729202953.704662=
-1-rosenp%40gmail.com
It mentions this only applying to out of tree dtbs.
>
> /P
>
