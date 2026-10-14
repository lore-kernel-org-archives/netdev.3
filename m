Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969A560AA8
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996247; cv=pass; b=M+PcJ2u6CxEpwCL89l/nKxjVxWF1xSOWHhY6zaS/mkqfmeCYDESqEXYTJdGdzNIc3OMxFtzvhLCkB4PiunEA6QGRzZ1OpUBKSCIMDC8x6kt/pXsWxrBJBiAsq1bNSoM763/ROIq15g4EBf+mRNbOc1WywYusyJP8e6soyojJKqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996247; c=relaxed/simple;
	bh=MMVXINMr7JZIMgeHG/AqGaqfPCjKzr4ZpfV8KNupDrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8hp9q1EjpqXCtkfWLC1+LeBOMu0Qzq350YcHNDdkAHKL1G7oPH2GHnbylzLxnT5PIrwB2W6rrBpSPoaB57wTDdl21ubQQZyvFBri9QAsW8wvvhgJXVX9sxwj0R6ubU9tU8mw4KH0rDV8tT1xZoPsiTuu44m7FjT1KBmOXWWSjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITh5ZqJA; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITh5ZqJA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b042c0759so3273423f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996242; cv=none;
        d=google.com; s=arc-20260327;
        b=FtEZ0Zp/XxsPEdGIDYuykE44IExzSYH3iDRcj6DzFktThGYz5BnB09PFDJuAAmXfCE
         ZXWa4Lngib0caXuEwbqBlulqOAEPck0Ey9PqHusnb5r3P6zW6w+bjKZ7/QyObKz5uYib
         V1aikuxSDkPwbdSBRsvvEKYdGipr1CanmYmbM2iwM0R5a88Zq+4M/xOSanyVZpvaemc8
         jsUHoP+zOIuUsH+Q1Ef8znnFkUR9SIxAr4sxL6r8JOuHwMPfbwt40kISLpVLXmq0Pf9T
         mzDYNzSXtS0IKjJhF9upbtJ5EaRsHRvZxxjGmPhXen58jfKePzPqYjmD6KB93IfXl3Vo
         //Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9q0DwdLIhqOGN7zNyyRQRC7CNxZQsLpoJL1VH7y7f/Y=;
        fh=GepoLgv6F2zxv3TON2DqB1r3SZJ0HVPQonCY5A/x3qQ=;
        b=cI732NsUJVSrAoIxe4Msdd/9LE4KgXe3Wd6ugeqOob7kcZwgbPO83HmqSK05iB47mA
         sAN1HVw7o7cggECB13VrNX6zWfdH8kJkoM4ZyzBWakQ6Mp+LtLsZxow6nH9hIiZe4zJa
         AWseklobUFLRhQLsCkMaMP604qKGoE+P+/QUl+shTzBIT6uKkb29F88xggyeVjT/i3I9
         44h1Udrx8J016S/5xlPLIIUswEqde6WtskQTnCiej4pcYEqX3ShW87Yv/2feP548ZbzH
         X8+U5D0VlDURZoAR42ziZbU/4R1cOrsgUA5k6wg6bgLlZUqsa4v55uOCOFNpLffyLXJz
         Jt8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791996242; x=1792601042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9q0DwdLIhqOGN7zNyyRQRC7CNxZQsLpoJL1VH7y7f/Y=;
        b=ITh5ZqJAGwUOL+qfGJ5aTDDRPWjr/F2s5ihb2gm7iLg1wULunz/3uz8Tld7bXRQepF
         LRwChIWZxumyb7DM/dsI/5+hm6Ks0TkoTKm70QllgZPgwsD3TNGriXksOxbwCWKd0Rs5
         cVQk3vVlHCKQkaQRXhQJMgcV6wVOAE49kcKVxsEA/k4FJIx6RWAsfQAXgmWkRfRkwQWY
         NSLMpbLWNbS5eS2B5m5NKZv+zb9XCIP4E+qpnxN0IVTbPSNy7h/XpID9J3dqlqMx3A0E
         Q318TeIJISdhqZo8fqJOhM0QkuBViOyaT+RxQ2Pihf/QSPHxxqzAdbVaYSNceYD3TL/H
         6hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996242; x=1792601042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9q0DwdLIhqOGN7zNyyRQRC7CNxZQsLpoJL1VH7y7f/Y=;
        b=SAmuKhX7dv4Nu3VGPcO8UvYTiirPthGp2mMs/Ix9Oyu1uDtisjUaohn309yo+FmS2F
         PrLOIWGR3thi6WJ++qOLt3yK9qJ6pp/BdP7VHRoHBn3Lun3Zvbz1PqPlZM6NJ0dBtod6
         XyMqHB9iimLZ12mlmt9vhOK3vvZ+84O+R7m6D4KWEeE1edQof/PrnujJEb//fNgnhjk/
         lMOfyKZesGEWF9mhVlL99DsHjPyFnxmb8xz5Tp2IRZ4/VxdaillSZMpcGCfKEw02BdZJ
         C8/1QMonNqPDopA8i6NI9cWS5PEqrIQsw4FhmGiLYmgKwEgsUu3jtDe9SHs6uGhvJnWS
         Cp/Q==
X-Forwarded-Encrypted: i=1; AKwUvByxuL9OWIWRn1XrGv42npbYNdXl7ADNMPzY8xOP+0AMILtQgewAYoawzcEuGN9uLniR/EHQGvU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVJftKGHU8mdWkZe4YVkOzJ43BWH+9nr/ewjKC+NRH/MO4LRiz
	VtK8j1SHHSabphKQHrbbRTgtdHqBJQe6mICnZaMlSFWZS9k9sjiGMPIGlU5dS1GesKzoEIALX+u
	BhxFK6qSmszOBlbsewyIVwoI2gjp9q2w=
X-Gm-Gg: AYBFou0cpeWGwCuInvvZ7eIoVnROBjYQqj7hyD9gJNwtat5MCeLFNcYaBEiK2awlDHT
	xrnQKw7YRnEKqKJNOZqmydLpgC5AArmRTYrJkJHzKZtN9nduFxG+0zdBauMZQaFjfRGrW5N5OKU
	9IHyZb4hbbv0Pihq6GLbZ7rGH8FQY4WoFa6CvDUheU8znCtbcm4BJarMFYAZZ7f1zMHAvg5Boqz
	omKbmgB09I2ELW2fs+hfkPnoYL1nWPRd4132DhBYBgGPB9GWUCKoV9JVP5QPzbBa9iAGHS33mLh
	vwhIWmtxomJuKVP09uLex4iIUEh2pPACnvaD59oWpx73e5MqxxpZrKh12R5uh7g/C9xUoFwp3Ju
	xnYNcK/TZeqzHkPKnu4b+c+WjWcWPfBhP2rBD5o8O3Aq/peBeLgDVEgJMtRFUmX+bTTWEB+UIXQ
	==
X-Received: by 2002:a05:6000:987:b0:488:7787:469d with SMTP id
 ffacd0b85a97d-48df14ed887mr2129597f8f.25.1791996242209; Wed, 14 Oct 2026
 09:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014-miic-validate-dtb-v3-v4-0-b7da71b3a106@reliablecontrols.com>
 <20261014-miic-validate-dtb-v3-v4-2-b7da71b3a106@reliablecontrols.com>
In-Reply-To: <20261014-miic-validate-dtb-v3-v4-2-b7da71b3a106@reliablecontrols.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 14 Oct 2026 17:43:34 +0100
X-Gm-Features: AclHuK9L-1D3Yt6ZN3HGXxulOCvvWz_eF-6S1YFQfIBvUb-SHdPO_MInoJxTrNw
Message-ID: <CA+V-a8v-YXma2NbeWP0Fhz+Fa5gmmq3oSPEZuKrDZhy6MHWcMw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net: pcs: rzn1-miic: Validate dtb
 configuration values
To: khendry@reliablecontrols.com
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 4:37=E2=80=AFPM Kyle Hendry via B4 Relay
<devnull+khendry.reliablecontrols.com@kernel.org> wrote:
>
> From: Kyle Hendry <khendry@reliablecontrols.com>
>
> Bad configuration values from the dtb could result in out of bounds array
> access. Verify parsed values are within range for the SoC and fail the
> probe if invalid.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> ---
>  drivers/net/pcs/pcs-rzn1-miic.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-m=
iic.c
> index 31716241b58f..f8bafce26bf1 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -693,16 +693,39 @@ static int miic_parse_dt(struct miic *miic, u32 *mo=
de_cfg)
>         memset(dt_val, MIIC_MODCTRL_CONF_NONE,
>                sizeof(*dt_val) * miic->of_data->conf_conv_count);
>
> -       if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf)=
 =3D=3D 0)
> +       if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf)=
 =3D=3D 0) {
> +               if (conf >=3D miic->of_data->conf_to_string_count) {
> +                       dev_err(miic->dev, "Port input configuration out =
of range: %d\n",
> +                               conf);
> +                       ret =3D -EINVAL;
> +                       goto err;
> +               }
>                 dt_val[0] =3D conf;
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
> @@ -712,6 +735,7 @@ static int miic_parse_dt(struct miic *miic, u32 *mode=
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
