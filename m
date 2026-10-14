Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6EA4E323D
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976847; cv=pass; b=sIR5p0n8Iu59E9eK9Ywo3OZ+79qPnm2RZe3iBY+B+a6VXeXnUk8Rf0fQsQii0FFxvwwW2c1gnESc1gKY49oibgFeffLm2ojXM+7iPtGYVPARzv+W/UzcyE+hZuYPkokZ3cAFmu0uvWt7JhP8Sx4q8FnHawOqZA6s7KbhHU+MIfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976847; c=relaxed/simple;
	bh=Dm1smR04ZivAMkU8QgbMvCQPxO0lGpCaWtgIm5vurN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Osb3UzNWgEDYs7BARuDVoBBYcuitlInIL4Z0t+JOMs8yHtGviU/UKZ/hMhInijGfLUCTA4cTIl8gsnHZS8O4vGDAD2ePeTGCLHvwS4LaIdQjg4gfXrYKyjEHobVOVogRn3n/AVvJPXm5jpnBTwAJeaEnaHzat096cFA+n40aCCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCp4paHr; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCp4paHr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so24455635e9.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 04:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791976844; cv=none;
        d=google.com; s=arc-20260327;
        b=BUNx/FTf8xrMaaE8BvnBpN7ru5Va0znGcWClFwv4VTcdBpnALH6EpqLapCpyfw6LVM
         0eUoWEDzMTi/IE8n3Z7ZT/xFpGoa+zqlLO1eOvsU0C4MX9ZJkSWYVixj0AbO9BVi8o6M
         DM/3JI3z2u30VwF5LEtItjPnm7zQMUOqXRCPA9r4KJ80lP/coHmIhBpBZ5nm7QG0G0r9
         UURK1n5OAZqYpf6YXY51WPlRUNgGTm/OC3dWbMnjrJaWp1izh3IA//n/n1Z6HvPUQ+e4
         jaBbSzRRHJZw13pl5UYjLiDi7NCSneJWWaYEW49kt9rFZCF55O9dCKWUE00MlVmCnBgr
         jLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bO5/h39EF/Oj8X3PFjOOqCZcmmbplUnPDUCoN8XUO3Q=;
        fh=CDTilGWRTMwu8/iiMyxzHCFtDyz9Pz2UC8A8i6buNKY=;
        b=Ukn8x1Wse/enZ4+3K/okKLDYqDv5Z17n2huLCVFYTxUn7Ix8KQcWZU3IEZd7vOFVU3
         e2lcKc8UbnEbNEYrnpVEb4kFOIpv1w58pCSPrRAENa7R/g2piwKApAfzM4g/i9+gQoJ3
         aFQuOsAMLwnityJa5nXlfAAKRLgXbSx51tZaNINT6MbehECz+NOOm3I8Smy92CcC5BAu
         LLQPgGXTJW20gsiNptPdOpyFb7cjeTR7hUI3AdwRmiLl1n2TS+bSOjx2pUtSXUc/vCAr
         ZX9QJ/RHNWHUnAKPCk6zhBSJMLNTsJvn3j1J6FCbWAiBckTAkuGjQCNfAruLUd7gGFzn
         Nj6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791976844; x=1792581644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bO5/h39EF/Oj8X3PFjOOqCZcmmbplUnPDUCoN8XUO3Q=;
        b=iCp4paHrczB97BfRM2s9Ejtsf1TkEplvFt/4up8zH8BGspsqNcbsc8Gs/mLEhTgYj1
         sGm9CCM/komsQ9lr4+99Re+Ecjnzvps5UpmidI7SVbnMi3dATbEfhxdcftQg+UqM7Y+n
         m+tZ+c49dRFnc7yGaR08maSAmdg3qlMfZmXGRL8El4Zqo4AynX5J6oOxh7Y0IjW0bPu2
         62/B8Iaa5vOSBlTmTeGLZ/NJquY7xWH9OSIRywvO8skLVM4lrYrr+LDfZW153CABGMsj
         nqado3o3DM4ldUL4D6VxAOSTzOSl2GCjXxKzXnuVYbSGyAr/SAPxJw7uXbBt7utwCSst
         mhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791976844; x=1792581644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bO5/h39EF/Oj8X3PFjOOqCZcmmbplUnPDUCoN8XUO3Q=;
        b=WxrAOqY1hhfolyuMgLBHrdDk6CQu1uZvuxo+p2hN1P4+tsy6D+uiauuJmkwh9XUXhy
         p1+OUtxEJekXYJ0+fVbShhx7qJTJ9UmyYnYilCygX3/TUILiTYrZwY8zSBAcXpGb8T30
         xnZ2f4kJFGSMLcn9i683+n3ilZFqrTzDOgkP2g7tdf0ZFobV8V3gJfwh8arRN8jn274I
         csHTGhOFb5xfzrJLFg55LtkVY8a69bk3OMqdzl1l1+CUkrAf2CjHRjoM3wL8gefN7xib
         BEYxJVUB9pbqve/5lnl+eTjoUf9vDUDd7CH+EmccLw4MTzsiCMELN1Ltt9X4ETiLAPRL
         rfIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVd5qPCed1HBGwJVeegcWfqTAKuM5vUlo+27a/lgtGr+cRgAr6wEeoTXpEooa5Htd9M1ts6OE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlsIO4I9JlZYAbRZTr2hLGbEAjHSVIFBxGVRXVkh0ZLEaxio9H
	2mm/i90ls6CfeuIQVX/iTYBVxJebbNnyhwP/Xq+RHMa/MdpbQpg+ZDQqF/amasyjlCocbd3M/RL
	Yx1iFvXK37HHKRjt00C2sLvMZiXXe8/Q=
X-Gm-Gg: AYBFou3bcIwAaK8Xsok2JuFIl3U629PWuFOsnJOBHeo+U8XQBdYJnNY1/k2vStXDq6g
	P3/LcHLbQB7d3eXMe6yKi5NRDbW8L6J6GYz76Bmj51Usg2zcILd0412NhHrmd9Y0Lkr/DCzGbjX
	RyBqbRV4tQsWHW20LbAR/SunpcFQIfsd89e1dDW67GdqB22zdAy+Xw/mJEuPWQDZg8y5qXFTsto
	tneQXFBBZNHFIENnpfQKhKApwjZolZpj2/xKd8JC/o7T/ceIIHsfvCKF7Rej1PKqp5bLakdEYNF
	I5nMXhpplE9DUd7acggqOmRS+U/wZNx4cG5wvNwi6mccRqWVThGvNnWl+lvHDhUxCW6CwHFamVe
	+owzw9GAYqjaODUG8YywA7FCDLHpvC8IqFeGSb40Qnf9Sq60qhdchYl6c3e6zmQtUnpylRlXkF3
	vbxduMAarmDg==
X-Received: by 2002:a05:600c:6384:b0:4a1:7741:ec43 with SMTP id
 5b1f17b1804b1-4a18e4b8966mr285168845e9.26.1791976844095; Wed, 14 Oct 2026
 04:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-miic-validate-dtb-v3-v3-0-68617b3dca5c@reliablecontrols.com>
 <20261006-miic-validate-dtb-v3-v3-2-68617b3dca5c@reliablecontrols.com>
In-Reply-To: <20261006-miic-validate-dtb-v3-v3-2-68617b3dca5c@reliablecontrols.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 14 Oct 2026 12:20:17 +0100
X-Gm-Features: AclHuK9lTkcKfev6iJ1zocn1hec2LLI_EBu29VRkVnV_MFGRgCWPxR3baUck-N0
Message-ID: <CA+V-a8vZmCia0aRyx_KU+_3Wz4JJNOMG=-GC-QXcEL8RaE3-qg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: pcs: rzn1-miic: Validate dtb
 configuration values
To: khendry@reliablecontrols.com
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 5:48=E2=80=AFPM Kyle Hendry via B4 Relay
<devnull+khendry.reliablecontrols.com@kernel.org> wrote:
>
> From: Kyle Hendry <khendry@reliablecontrols.com>
>
> Bad configuration values from the dtb could result in out of bounds array
> access. Verify parsed values are within range for the SoC and fail the
> probe if invalid.
>
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> ---
>  drivers/net/pcs/pcs-rzn1-miic.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-m=
iic.c
> index 31716241b58f..10622eb654d2 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -693,16 +693,40 @@ static int miic_parse_dt(struct miic *miic, u32 *mo=
de_cfg)
>         memset(dt_val, MIIC_MODCTRL_CONF_NONE,
>                sizeof(*dt_val) * miic->of_data->conf_conv_count);
>
> -       if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf)=
 =3D=3D 0)
> -               dt_val[0] =3D conf;
> +       if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf)=
 =3D=3D 0) {
> +               if (conf >=3D miic->of_data->conf_to_string_count) {
> +                       dev_err(miic->dev, "Port input configuration out =
of range: %d\n",
> +                               conf);
> +                       ret =3D -EINVAL;
> +                       goto err;
> +               } else {
> +                       dt_val[0] =3D conf;
> +               }
> +       }
>
>         for_each_available_child_of_node(np, conv) {
>                 if (of_property_read_u32(conv, "reg", &port))
>                         continue;
>
> +               if (port < miic->of_data->miic_port_start ||
> +                   port > miic->of_data->miic_port_last) {
> +                       dev_err(miic->dev, "Port number out of range: %d\=
n", port);
> +                       of_node_put(conv);
> +                       ret =3D -EINVAL;
> +                       goto err;
> +               }
> +
>                 if (of_property_read_u32(conv, "renesas,miic-input", &con=
f))
>                         continue;
>
> +               if (conf >=3D miic->of_data->conf_to_string_count) {
> +                       dev_err(miic->dev, "Port %d configuration out of =
range: %d\n",
> +                               port, conf);
> +                       of_node_put(conv);
> +                       ret =3D -EINVAL;
> +                       goto err;
> +               }
> +
>                 /* Adjust for 0 based index */
>                 dt_val[port + !miic->of_data->miic_port_start] =3D conf;
>
> @@ -712,6 +736,7 @@ static int miic_parse_dt(struct miic *miic, u32 *mode=
_cfg)
>         }
>
>         ret =3D miic_match_dt_conf(miic, dt_val, mode_cfg);
> +err:
>         kfree(dt_val);
>
>         return ret;
>
> --
> 2.43.0
>
>
>
