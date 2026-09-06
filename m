Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29863B47E6
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788676157; cv=none; b=IcfZP57YsyFZj3NSM6YpLh1Z6FQXpuVl77Fgn7XWM/PqRytG/uNugJZOzr0RwGr/6mn5DzV/kMTmg8ojrcOE1XzO+xbDANAVTa+hNzYwdixinvB/3w7H8s6l8UfI9cLIgw2qRS9aSM6UGr8oIDFGpwlnl/bgiRfdhhDd/R2oBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788676157; c=relaxed/simple;
	bh=yLGNHsjzdS8jPFsNcYioR6RUcmjiiworjndzAs+9P1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1HEetFQPxzoSpdEBdrzlsI04H/0+RcorYrz/wvk+xKMBgBuLYY0AFSFMkXKylMOagxBVTjQj4mDZCKxD/ptoyt8hDDyBVTpUjQS2WvsbxwXDZgep0hkR/CHqD/t7SEGbCqpFCdhqttNhTS1waX24hLvxHTsUvHw1PH4jaBkgUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=l9E2pgbA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="l9E2pgbA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fe89fb333so1429034f8f.3
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 23:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788676152; x=1789280952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JRrwyh1GV38tMLqmo1DwCJhHJystogA1fhGBbH9cNao=;
        b=l9E2pgbAiRFoWuV+WIgzOkTyYO1fxrYcsyULu2pLfk3Z/hl9njsE3DjedqmGq/b7tT
         dEL0aO5hr1cvka6VNkzxicbb9L/bmagEyjb6F84hW8z0ly28lYF4GhMPTFiQvoQiAORY
         n6ACJWr/+H25FtaiwbpVdn3OT8iqsfW0gN6gvwiKP568RSeAbvIP+4lgJTzcrt9Qfh2P
         S1ruWVrghDZMMcMM2zXsG51ilaJ6pAW3TzoeuG59PF0XM3er+7E5/auOwNaqnoRK5uyL
         eC7g2j2wDV+i5mxj6Vhamkr4C9VSN3QvJQ4Jnf1TzwfxS7juh3gczz1kxDYnNi+8qNGp
         vmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788676152; x=1789280952;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JRrwyh1GV38tMLqmo1DwCJhHJystogA1fhGBbH9cNao=;
        b=Uq1YI+yxvoHnodNJck1gCe4G8VRPTQenqClQGcAbkC54K4+Rv1FxVPnWYHZdZWgDWA
         5eAEtCeKivLkT1DYxi3JusaruE3XHXPQDxNapPPyFkKfMk9sOjejQLdbZVrI3BgALdxt
         p0PsDA1dPsFZo9pPLd+WNlUJhPdvYIndEG9+U6GBXtAwIm4of4CdtgDTva4vDmCaxmgJ
         ej1/K4YEbFmkuW6b28MOsoY9LWHksWG9C3m/otLA89aj7gmkCHxbtqMGPiejn33ZHUdD
         ur6ntL2pdaQgiURHXyzOug4rabgC2ymEpWWya14KOFg3UiUclHBQr0gXrxq50RdeQCjn
         AQ+w==
X-Forwarded-Encrypted: i=1; AKwUvBzwTHiRo8cwT7NQ1ZbAcufqV6XjxFiAreDZ9DX9RPcczgvkScr4pZbFdUl6ZJmvqIcwjzTauXM=@vger.kernel.org
X-Gm-Message-State: AFuF++mo0kCcEvfyHF/Q4vb11EPHeWczukirAARpuwYDdoFN635yAkSo
	u+1PtPk5EOUFJ/h0TEyvvh0AXjfy8F40tQ5Fbgda4yxPVgBxAg0tWSEaEml8NSxl6yk=
X-Gm-Gg: AYBFou3WAFoOPjKFrko08qRprIsdxBg0ata6F1qomeWfojl0D59KpZ+52WxrNZOJqFa
	CDpCVJ5el9yiNGR76LQboenv5D5O8BGaG4NWdCVBS/Ze45T1W8JS81cLWpAhUD4HwOuzqtvR2uK
	gD5s9IyHbHDLmn+i5eLb5ii8hOiS1haqs8vCsAo+iKqw0qEuVr/UPjS8xHhy8Gpqr0F7e8Pjz4E
	q8wdOUtc9oT8L/yTVg+UFyyonhhJEY0nCyI6Zrj87u7ccMFDkAdriE6+V1RHJm3k1W5xemHaMXj
	No85AhWxk9Vlyg06FNYuuLSaUQqxpRhjV69j3oksRQiT8RAJnPmdDHOvoPV5Sl8iyW+P9TrGcsh
	+Ow1s9b/KFiHMwmI/0PTQ4jWe7Aj/tY/EnpVR4DMqsxRUKFtjvE94tQbewcryJam1r2Qb45RH98
	kWiMYGtf1dHELbV/AwnjmhgEekg+xh7Rcg6jSVBuBmW2INOi3NXwheO5Z1cDKi3EVarYIIQf2Kq
	uS+
X-Received: by 2002:a5d:5e90:0:b0:485:8a47:5b90 with SMTP id ffacd0b85a97d-4858a475da2mr14160635f8f.45.1788676151912;
        Sat, 05 Sep 2026 23:29:11 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4858bc74298sm16329876f8f.6.2026.09.05.23.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:29:11 -0700 (PDT)
Date: Sun, 6 Sep 2026 08:29:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <mkp@kernel.org>
Subject: Re: [PATCH] zorro: use module_driver() to avoid repeated boilerplate
 code
Message-ID: <ap0Hpa5BNKgMg9rO@monoceros>
References: <20260906034037.81379-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j5xthm2rjqmnrlry"
Content-Disposition: inline
In-Reply-To: <20260906034037.81379-1-enelsonmoore@gmail.com>


--j5xthm2rjqmnrlry
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] zorro: use module_driver() to avoid repeated boilerplate
 code
MIME-Version: 1.0

On Sat, Sep 05, 2026 at 08:40:19PM -0700, Ethan Nelson-Moore wrote:
> Many Zorro drivers have module_init and module_exit functions that only
> call zorro_register_driver() and zorro_unregister_driver(). The
> module_driver() macro automatically generates these functions given the
> register and unregister functions. Switch to it to simplify the code.
>=20
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/ethernet/8390/hydra.c     | 13 +------------
>  drivers/net/ethernet/8390/zorro8390.c | 13 +------------
>  drivers/net/ethernet/amd/a2065.c      | 13 +------------
>  drivers/net/ethernet/amd/ariadne.c    | 13 +------------
>  drivers/scsi/a2091.c                  | 12 +-----------
>  drivers/scsi/gvp11.c                  | 12 +-----------
>  drivers/scsi/zorro7xx.c               | 13 +------------
>  drivers/scsi/zorro_esp.c              | 13 +------------
>  8 files changed, 8 insertions(+), 94 deletions(-)


>=20
> diff --git a/drivers/net/ethernet/8390/hydra.c b/drivers/net/ethernet/839=
0/hydra.c
> index 9a59915436d2..2edf97e500df 100644
> --- a/drivers/net/ethernet/8390/hydra.c
> +++ b/drivers/net/ethernet/8390/hydra.c
> @@ -257,18 +257,7 @@ static void hydra_remove_one(struct zorro_dev *z)
>      free_netdev(dev);
>  }
> =20
> -static int __init hydra_init_module(void)
> -{
> -    return zorro_register_driver(&hydra_driver);
> -}
> -
> -static void __exit hydra_cleanup_module(void)
> -{
> -    zorro_unregister_driver(&hydra_driver);
> -}
> -
> -module_init(hydra_init_module);
> -module_exit(hydra_cleanup_module);
> +module_driver(hydra_driver, zorro_register_driver, zorro_unregister_driv=
er);

If there was

#define module_zorro_driver(__platform_driver) \
        module_driver(__platform_driver, zorro_register_driver, zorro_unreg=
ister_driver)

this could be reduced to just

+module_zorro_driver(hydra_driver);

=2E

With or without that addition I like the patch.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--j5xthm2rjqmnrlry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqdCDIACgkQj4D7WH0S
/k5Q+wgAqaAciwF0YQfLcSh7llXTFmwTcZrnjuYaboZmPy6Bde2NcpAvROn5uu/V
AhrAf39Mz9RPYp5G+tY7+lWRdGAt6yuufobAtfhCkTA6hYraHFIpQa1dAbX92wL7
jdwdxzpV3TEGPtCbMgcraK0U3PC5H2mVVNSo18Eco+d7KaG8FQerkp0SBR0ro1G/
mHXkCiL0bBcO8GAJcao4XKTEpQLnfYzdgbRCYvFvo6umMcgTgykBpOTpO9XreNNj
NhQQzaQakXTDexeTzkFKhIOiMsrWHEeKW5Dkf+RW7wyy2By3Swu8haih6zzcrlSY
M/zV59jEuiJGxiuJ2HXuATz7myHCGg==
=AWHm
-----END PGP SIGNATURE-----

--j5xthm2rjqmnrlry--
