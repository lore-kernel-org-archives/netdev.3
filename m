Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44E3427FB0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789597783; cv=pass; b=n0kq2iKixri/UbAs+Rp8Gu+NqW+JtXyCCHSa++8n0ZVsTloQGkHYwJYrxQqgRYjuQwA1T0WodqRy0FC/RrtBlGg8vs7v/as92NuwIYznxfvu4H0iLt6NC0fFqTdu/hk3E37qOtu+ES4oLVAQMjAWOwR2yR/MJs8FRpEReBhwgoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789597783; c=relaxed/simple;
	bh=pGZ/71YA8CSBb9++N0cC++WjH4Vc8ogllmY1COp7VX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGlnj0//tjwPZbQtD8LzCE0vPuwL5xqSTkEJiXy9Vol/GR1QepMP4ZpNV8sJBsQ1FTcGNvzmof/P0QmHXbZWkVFmpt72L2gYpAD+ZYniZEMPZZO88QiQ+Ox6db4x61MOudZyEqaxvznjWvp+jSBkXodKpoG7kgj3N1SFukpFpKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VypkWEso; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VypkWEso"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20ce3c118aso22284466b.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789597777; cv=none;
        d=google.com; s=arc-20260327;
        b=KhUh3x4dBoecj+lapF3hF049dfS3p19MR9PwEYwPoOdPcE347oS3TfLPQGbOBY+GVf
         dyGmzwZuBjT7J/iC7doCz9Y7NmJNfTxg85X1NrAvMKuEHLZlEkN9Mmw+f6thTz+boiQI
         /CH6dtGDrJvrpdHlCoqnYZtuXVHsbLWUpqZA1xkcVQANb9VCEuEJL11EiHKQGUzJ7r68
         fxPnazDs7JEUopSHzToXznDz3ADPuufrVpqTV+0/ZwZI8jjFIzDcbpFyV5AM4rh7ORKr
         luNKhqQgnYtijE/tTtlbgFaZHzZ7KmxMI9xfnnr3z9mDVsv5ePSlJmT8D9We109m9br+
         ndtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S49vLPerQfvIiWHoJPoKgafWU31+ORUFFMofvJ5+kis=;
        fh=MWEu/WMxMl8sxL1qajgKyzN1sIU11NFOXDDskjxlMdc=;
        b=Ay4doxs4j22QrhgvvQFEQ/bJ7mhNH7+tAb4MHEDASGitk5O4WzO+CfDHhHq9jK4Kma
         Sh9nz4acq+mEXOGeBrLmuYUKEi9JGE/2qGLxpoUK/0j44UOPu5DzEYksljGvtD864Wdo
         oKODspHKZoZBGavAPfmKubJIWehGBTZUqyjiNtA5h07DR3LIlIgChYQFcd8AmNPHbGD7
         Lr3jIbhcnexzrygU7NzFODpGBb1bN5PIvbxVDd1pT2tIULmcCL/r5SRPXWCze7/ef3G3
         UvqbGG7tMVQfJji43a2nibv4NltBfVMSNFm6esb6QUQMNXWV3nmxbrJa42sNRZuDt5OO
         q6FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789597777; x=1790202577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S49vLPerQfvIiWHoJPoKgafWU31+ORUFFMofvJ5+kis=;
        b=VypkWEso71wPY8UypkK/YhjngRya//EWHCTQqTvynK42T4Gxq81DBGKWTKnRwgqPxd
         J8h4SFRSUp4ayk7TPxW2Zd9GcqQsgv69Ke7y+Ja9wIHGsONyCSdNNZuGUaoJVzBjG0ht
         BcTrFrpIfM5vEafjt/Or3GwTHFQVytQkdKhKX6Ll90HJxjzesx3WSUoFXcAoNtxTlgd+
         xMWrNYdy2j4ZicCTVdTCXIFQquDM9YxznlX1TqpTRTFukgQSN0WbsCd97yyhftAptaxG
         9Zg0aIt0gj9qD4N/kn7QZNjwjFgjyFZLi06xSOupLTK6BXudqEaVVkQ7WAEFo7LPiOai
         eckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597777; x=1790202577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S49vLPerQfvIiWHoJPoKgafWU31+ORUFFMofvJ5+kis=;
        b=WR86vrAWHXyFO2mlSiOirxXiEDVK/Hm2MDtAgkJTOMcbGXJqY77Sgv4c1S1ryu3cv6
         MVvqftZfrc/nN/oKgIjJXWyXcN8tCa0kORLAS/f/rD8igNNf0r2tgUkl6OF4BDh+2a2A
         rzzK5MeGzPx+1eeLHCk0omkpJJ7WI25iWGyCoSdsuQ5rZouvkhLEo8fw1AKIxhGPlrUx
         xejWgjG4x/12AjWcmRNgjodEJS/xhIfwy8t4p1eIpXjoXyq+lci8ygXukR58CMQ941wN
         Jv0J0zpn3kTm97XCUbaYcTvR3eQfO5TlywzwI3iRAxRCrRTgqj+6X2MMIoZDvWlwJaFv
         b1Bg==
X-Gm-Message-State: AFuF++mZOac4vf/S7S3B0agGRa/m7JxiLU1mYvJiMY7ZUMV/XUO2p0cM
	N9zYGwaPWbK2/6xKXPZ4H8UCusieb+sT3/Xu/QAUp25vtVNpn928jm3cGu1KN8C4u3RLrPTmats
	mKTgOlxxQZfCuMgnL9hCeh15BnnIecMMEgA==
X-Gm-Gg: AYBFou0rd0SuuMmSxNHvTcCy7ry4FpEU7lE/2l3ZRU6DbqI3Je95If0E7boXLvAiogX
	nSZoKVJyB6Wcvt+W20p5kwvt/jn/+EQBy42BU9nqOPkHvmIee7/DzbsNZFaIFSmhHP3KitFoCbp
	0jRvxVqyRx1cm1DsmnxPPKBWzoYEHMT4hctw7JnNFIRVsWSq6v0n6OyTRv71GDbhVkWk97SZkuG
	K91vC7MPAunTYsw7eBgTKKJysPw6ofAEB9z9BJgh6PjE06gKdCEap6CvQyBDlS1mDYK9ExsVGSf
	Fx9yNRVyxSr9lrnAaN0x83oecdZ75e0+1q1DljAXzhYg0vH2AoLzliNVeoazbFlQPQc8ec8KxhL
	RpDryrghwP6u9RMQ0maRjJn0axdv7GJuHm95BZhGeApkmWxx9IxWDtvUxqMyk0jtbCsYmOgiOsw
	ZEHcAfYmE/PaD7AB/pZDr9I7mIC4//rU7/QnqojGkAvP9wTVs901n5wkwYeOqr5/XE8Q==
X-Received: by 2002:a17:906:7945:b0:c25:4d9e:bb28 with SMTP id
 a640c23a62f3a-c29f5229606mr88747566b.3.1789597776312; Wed, 16 Sep 2026
 15:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916220931.262932-1-rosenp@gmail.com>
In-Reply-To: <20260916220931.262932-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 16 Sep 2026 15:29:25 -0700
X-Gm-Features: AcwNN1XfvFE2d-KqqJJucIZTjIcWqKEqlJgqdSjJo6IKZHJ_MeeZJH_xFe-plEo
Message-ID: <CAKxU2N-T3urb8Wv3sW1=YaT6AjoicgJ95msTDA8cdsivkiR5vg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: fec: gate MPC52xx driver on PPC_MPC52xx
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 3:09=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> The FEC MPC52xx driver only applies to the MPC52xx family of SoCs,
> but only depended on PPC_BESTCOMM. Restrict the driver to MPC52xx
> platforms so it is not offered if COMPILE_TEST is applied to
> PPC_BESTCOMM. Otherwise the following errors happen during linking:
>
> ERROR: modpost: drivers/net/ethernet/freescale/fec_mpc52xx.ko: symbol 'mp=
c5xxx_fwnode_get_bus_frequency' undefined!
> ERROR: modpost: drivers/net/ethernet/freescale/fec_mpc52xx_phy.ko: symbol=
 'mpc5xxx_fwnode_get_bus_frequency' undefined!
>
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/freescale/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/etherne=
t/freescale/Kconfig
> index b34c0fcfddea..d81984fcec64 100644
> --- a/drivers/net/ethernet/freescale/Kconfig
> +++ b/drivers/net/ethernet/freescale/Kconfig
> @@ -38,7 +38,7 @@ config FEC
>
>  config FEC_MPC52xx
>         tristate "FEC MPC52xx driver"
> -       depends on PPC_BESTCOMM
> +       depends on PPC_BESTCOMM && PPC_MPC52xx
oh this is against local changes. Please ignore.
>         select CRC32
>         select PHYLIB
>         select PPC_BESTCOMM_FEC
> --
> 2.55.0
>
