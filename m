Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96A2DB789
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793003; cv=pass; b=rRh4CYBKQhaeha8Ee/44HTQker0VtpTtXDjXRzPL6Zz1pHmqGy8p8ZjuI07D2NQ6RCZSp+D8EJBpBCmh1pawonLoFcnju4XAV/47YssitY9TypzOs+4aoTbHECRdFnT+O5q3V9s3YP6dS12cS7h5Uibr7gumP83k4u/bfNqc/Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793003; c=relaxed/simple;
	bh=B5TquNOP4FHipMIgGwTA5hs3LpWn+L2AESOCu509OjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJmrSMH7CArCpEsW7MMg+A8oXkkdWzmaF5NZ+PliBgSxk3dPEdR0wx8tDJ6Dc/ZZ5LUW4CaR24vzsX8nYbr6yTdGruagPtC3Q7o72TtGMWA+sBROb+dhpxTSDhxqI579GxUTtiUkMjOhy6HbBHPwGQro+SEJ73Y3xdXtI9TAIzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMjwnvr8; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMjwnvr8"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15f6de6cdfso266988566b.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 11:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783793000; cv=none;
        d=google.com; s=arc-20260327;
        b=P7NX24VgpRGiKg4vD5dNJZb28wNApX7JmBYwr0NPFSU1zOoIlsEsPjJtAWx4Q/B4Wf
         PSB/XN8RGvVNO+9oxRLgYY16R2Q2eyNSyNkd+/R081C8NDfKSeEKHzvQeS0JsFqKijyV
         hQvXBUAWubolKKDbNYk0lpQ6KYfs4OFIjc/KmhrHI+VYbptcdX3Wf+rCzRgCunxgm1iv
         4XQYVYbfvnpN+fZTtKXTPBuFm3Vk8Dr+Y+0b9b49/mikk2g7qzbRhUGDcxNHkwZrHAN3
         UJ06g1HK31PHquyBXTJLx6dpURCqluN1I+eE5nMwiNfIYV6cQcvXaKUxhWNP2gNccG96
         Kt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oNzlktpBxrv5iwyyoiqPQSZB2sugZf9l4YTTMdUohF4=;
        fh=qtCuIhFZOTOUOAM/9K90tM3Ga4PFUoBLGI1u3EKu+ZU=;
        b=bEdAA9HR6bWTISkOpytxVpMpdkvgwaQT/Lq52OvBmSrTi7I1jEg4oacaQBmW2DFgEp
         fNfbSxeAJrjfoa/gaZl+iL+hb2UiA83RI24UciG/69HpkNLLpVcFNoOfSP3jpzIkKlih
         IzJEUvLcyfvEHkJ7mUH5soPEujtrDHrppVM8ZObaPALaDnqbCnEaGrC8iRoxwJ4KT08Q
         s0o2c9SMDsh0RQ9ybs+kLKg18z2sX1KBFqtBxdyLMH3oMeaDAYqq72N8lDIxnt0ZKFW0
         rcd2zzTAikFk7VLjCMb5ORrKLbGzYFxtpjrA7Xoz5WXumM73S+S8OXoy/Z+TZ1jKVoms
         FPkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783793000; x=1784397800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oNzlktpBxrv5iwyyoiqPQSZB2sugZf9l4YTTMdUohF4=;
        b=WMjwnvr8EEz91Igoktrjp1fyK7urU0mmDYcxksaEu2nek5VWMBgevrLOvyjhzld3N8
         OzmcIce5AmWHqWmlZvEacxTTrwVdyxDIk0Lzws7gJ9QSx8+rllGkE3QjETpSV2x6iknF
         W6b7DuqzV+FOLwEGWk/S6C6Dpc0pW9OFRpLKkj9Y1bMCYqwvIwemujI59evpAGZPtuCD
         1abglrrkqOx6CexxeQVBd4/fgxTvyYlzRw7m2nsYWGx7x6qBUpU9nlajz8r+3bdfqH9O
         8ULqIyz80wwG5GuLXwFaIoKZlf9alvyhkV9PJecuaIXBzViqiRM6rgvpPkpxpFxIJ/CF
         TpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783793000; x=1784397800;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oNzlktpBxrv5iwyyoiqPQSZB2sugZf9l4YTTMdUohF4=;
        b=Q949g1z02YHdk1fC7BjfoDH532DRZ6Lz6V0QFOeo54zG8hrXqXajlxMl1u1KNAeHfV
         7xtNu9nOcJnN8M42HxthbgNHb7oYbICMt3NmDY7Y5Lyr+p/jY74D9t4+8WPE+YtIP8lP
         sDntTtXzFNtbq3LJIx3xe+T0ebLFwQagk7H3AitcTv6wbiMMg5kEaRc37KfRr4nReW0M
         GDN+VVB6F9bzpp9l7IKFtAGGNhhBlvS4MK5GVF/YRA50MOS3vqJAdOsuli5goAt91tWq
         RFGks883S11ZRqwqxEPGvO2nTuwp3wuISCblhekThf5+fKgw/LNR3Dhqg2JvTmgqA3c7
         N3qQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJP8a76/gM4Drg+OtM3E/fRW1rWxpi4oqp4bDxDn490cxm3CXn0iLQ9uNuvUDfcXlPoPxMhLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRBnfJA26+G/4JrHf7qA+YngZcsu6voIsADrfcm2j9gMs0E1s
	x4qu4WrSKDuls7g5ErQxloPuBs6oPE/cSoiEUvJbkIfIh3UIvVFTZLuxmZxMJC+9fUWYy2G6w2E
	lOJUi06ioPPPzpl1z9y2cgdm6czCwxrE=
X-Gm-Gg: AfdE7cmBhnSSjO5GeafpjFlv6UEXzsdxsDqYFn/pDQiRaO7+6mOWJC7GiEMUXXu/38k
	KpW2o6JiuX1vzbiu4/EkmdEEvjj/+U1Q1OAv18UoAajCSKz9ttVQbqYsryr70STONr9gVBEJVRi
	+K2m+thM2gp50tOlUMLsPHotpiKWd04LE+3O5FlfZSsVehARIDWBDfICniDILYiDjDmkL62BgVB
	dtn8va33Me5CKdabk+kumNjrr/uKWY3OW5HJjwy5YPPsJ1m8kFe4EBbnuUTakgz+OSox9h4E1jH
	72SHOWo3EJwC8L53a0felT6u1ucejv7J9LRON2Y3uQ==
X-Received: by 2002:a17:907:787:b0:c15:e33b:8c4d with SMTP id
 a640c23a62f3a-c161e94089bmr141645766b.4.1783793000358; Sat, 11 Jul 2026
 11:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711-rtl8366rb-fixes-v1-1-12b9210b0cce@kernel.org>
In-Reply-To: <20260711-rtl8366rb-fixes-v1-1-12b9210b0cce@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 11 Jul 2026 15:03:07 -0300
X-Gm-Features: AUfX_mzV8eay2P0RAfV017vTX3C-ilKgmJkBpcIyTrvePUjsG1T1Xdt-00mlO-Q
Message-ID: <CAJq09z5s39bg34cPZpheBQWyZHROR-ja1nvrD9E-w9Ya45t0vw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8366rb: Fix up port isolation
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Em s=C3=A1b., 11 de jul. de 2026, 06:43, Linus Walleij <linusw@kernel.org> =
escreveu:
>
> Sashiko reports that we incorrectly disable isolation in the setup
> loop while what we want to do is to enable it.
>
> Just delete this setting: the next loop in the setup code, over the
> user ports, isolate all the ports from each other, so only the CPU
> port can see them.
>
> Fix up the comments so it is clear what is going on, including a
> missing word in the helper function.
>
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://sashiko.dev/#/patchset/20260630-rtl8366rb-improvements-v2=
-0-05eb9d6a37f5%40kernel.org
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/realtek/rtl8366rb.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realte=
k/rtl8366rb.c
> index d2fa8ff6a5d0..e615814049c1 100644
> --- a/drivers/net/dsa/realtek/rtl8366rb.c
> +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> @@ -794,8 +794,8 @@ static int rtl8366rb_setup_all_leds_off(struct realte=
k_priv *priv)
>  static int rtl8366rb_port_set_isolation(struct realtek_priv *priv, int p=
ort,
>                                         u32 mask)
>  {
> -       /* Bit 0 enables isolation so set this if we enable isolation
> -        * any of the ports an clear it if we disable on all of them.
> +       /* Bit 0 enables isolation so set this if we enable isolation on
> +        * any of the ports and clear it if we disable on all of them.
>          */
>         if (mask)
>                 mask =3D RTL8366RB_PORT_ISO_PORTS(mask) | RTL8366RB_PORT_=
ISO_EN;
> @@ -950,11 +950,6 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
>                  */
>                 rtl8366rb_port_stp_state_set(ds, dp->index, BR_STATE_DISA=
BLED);
>
> -               /* Start with all ports completely isolated */
> -               ret =3D rtl8366rb_port_set_isolation(priv, dp->index, 0);
> -               if (ret)
> -                       return ret;
> -

If you don't isolate the ports, what is the default port status?
Wouldn't it allow unused ports to talk with other ports and, at least,
send packets to other ports?
I think that it will not leak packets as the
.port_enable/.port_disable is present and all other ports will be
isolated from sending traffic to unused ports. Anyway, it would be
cleaner if all unused ports are really isolated.

>                 /* Disable learning */
>                 ret =3D rtl8366rb_port_set_learning(priv, dp->index, fals=
e);
>                 if (ret)
> @@ -974,7 +969,7 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
>                 if (!dsa_port_is_user(dp))
>                         continue;
>
> -               /* Forward only to the CPU */
> +               /* Forward only to the CPU, isolate from all other ports =
*/
>                 ret =3D rtl8366rb_port_set_isolation(priv, dp->index, upp=
orts_mask);
>                 if (ret)
>                         return ret;
>
> ---
> base-commit: 23dad2d088dfc82cae1f5a936f8ff7ffebb38dd9
> change-id: 20260702-rtl8366rb-fixes-a93f831ec2a4
>
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
>
>

Regards,

Luiz
