Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB93D34B5
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854113; cv=pass; b=WASK/vI6uUcdEK4tFQQg4XsednELJoVMrqbes/sOUhcFstqilqtn7wnp7W/xsyLrLsiKWzm/dgKbHPrnlV5SlW2sdnvchxXO2CQsazSZvglPS4d07Rqt8iSwg8TChbhtUJFlbkbpl4vDrGYXeCbOFs8Q7heakhuPwVxL0sp9uC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854113; c=relaxed/simple;
	bh=AwszME0PVQXG1C2Shl+TVih5js5vNu61zvf1dP2CyC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rrf6qHG9qxA5UDZRlBTTt+OBUUfPmDSxYNI1+zH/NOi6Gi+uS2u2kbyZ4Nv4Bi7+VlIoGC1c++/BymJMZDulcQmXpmXw2vm6SXAaiHRaLr2GigTwEjRWhK1RJXnS7k37pZ6XBeNKdS90yeYkZdSshzFPmA7bVIxcTiIPVbNNxgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmRgA7XM; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmRgA7XM"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so3900261f8f.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 04:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790854104; cv=none;
        d=google.com; s=arc-20260327;
        b=reg9zSNLeiK3+mRCc876KyQyTN7Bj/xFe12zZTtKF7stu8yQsYqdxaxTFeFl9kBM7i
         KnJD1c+D3quZ4rC2Tan1nTaxocDg22luMm7d9J+Ob6Nl+vtGoaBCGLZJ2uZeKrqST/Hw
         jnxySVKJGn2Z81u3V+hZKflhdozYmIXh13r053KaqTHXegUCu36kix9s4qkJnwA6O2Xo
         LJLU1WP0nevjN0zFbCtVhg0AOQgpKeWOXnFjTypfdBxR6ZdpAeApHO3R7nPk1NGKg6tM
         3vHNiAfSgNkAk0boSj30utougCfZi5R7scuKT6FWouD03GNq7a3TwJh0fsQt4uWPwf9u
         r9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wlTXVZFyOCFbc+V/2yF4m7zDYgmRZl4N5AzvlwIj8Is=;
        fh=TUkiMiUlKPh//BXE14kWm131hVHoZV5vwGOcNF/Nsi8=;
        b=F1Q16sx8X00KZ8jrn+rBeTOOV1sn4kp3jymwwd0fcOewsbYunIgMYyRWjC3XtmdLuB
         ibf6OJjPuGX7B/pWw+IGnL7wugrjDE/ctWH0chyplR0kxG+WvL8hnc8V0L7w2acl2dqr
         0zE+upwYN24UzhSHm8DWa8KRldX5m4I7uHP8DA1b3u/0tvNgqLxQosUpYhXkxc2AhVF+
         jtBZ+zvoh5fD1ckD6se8iar2oqeD7/0KPOuZPHURYXzMMBhspS6Zo8Gv2RQuUU20bLiB
         1MjTOsikhw3T5uZqmB2K1VXMwaETfXuojtEmHyGMefv3RYEoPlIETuP6k3Td1NjSkj0S
         19hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790854104; x=1791458904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wlTXVZFyOCFbc+V/2yF4m7zDYgmRZl4N5AzvlwIj8Is=;
        b=hmRgA7XMkdEUl5NDDcgnxH6nPHV45XbFOLCGcbW6yI+zubzTerjygoc2LBiwsmEZMY
         Z5sVoZc72Xc22ckzOZ2IJVDFOpxSGVn8Uw3mPLFJKbE6IX5hsi6ocKjWNa3VpPTIGEIw
         vEz4TFynFiB+apqfoP18RiyMc/TgfInaxGvebKBiwx/xzcccAcMXPsAKMX1/UChjKbVw
         jr47EM+HKDM9cvF29ONKb1phPGWuoZ2rawclhn93dovhH4dlbnsxXm/USeHV8OZpVdB5
         1bwQkcTF7V8nOyXeX1NfHfGV+hJj3iYn74DPrTPbdZVYztIEKyDhoADHfLlDaIm2iS8Z
         lE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790854104; x=1791458904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wlTXVZFyOCFbc+V/2yF4m7zDYgmRZl4N5AzvlwIj8Is=;
        b=DoHtlR9maudjT4iqZL3zmvcBRtAip/fKCBWT/c6RepMzFlbQzhts5jGUt58ZA9u4kK
         p7wuvZdLTgI1mnOEfkpraDjY0FB9dmoOVFeKkiUq+z99rcFQMmOl65mK6dTN9uSyXe/c
         ULuMsBXs36c2cYzXiiYHLOpZoZ1Okr2AfS4HYkakrQYOu7qo7qg09rmqQ1JH2aaDYsPX
         4jwX3uov/PtjGPpHErb08qxixZoB6nYRw04artApdg6I3XIOHJr5t96LIPiD4i4XhCSE
         NiUnUJsY3RO3Wz9dtqagsFvkkUo8JzRB/i9X5jOT84Mjlr2Suw8gDH9skQjLetRmgJpc
         uyMw==
X-Forwarded-Encrypted: i=1; AKwUvBwobdSVWlpI54waVpX8pccL9u5NgQsUSMGvxIWOx0VtT5lglw9XOnvQLAU+0BMru/hlW9B0XvM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLicmWCmlptZ8vgk9N2xaUqOTqIMW6zcnTonpWaInQZDKjMov9S
	BzvZNOfc9YDol2GPBIhxdg0j4q+cDY2wHdWDpwQfJCHi77PDDAghYv1+h4Yx5/KIivLhrStqgHo
	GZUrCtDWkT/SYZUk5e56tx9pMKs2wZv8=
X-Gm-Gg: AYBFou1DhCyt4Uua/HKnDNmfhe68kxabXEtEvJAhZn/BDnR0Hnig4rkCS5aOgHeivvc
	MyIguXKr8A9tH4nOtG4E3PpOaTDgpDVoJOXFd2W7DkkQI6v4BJJRHVhU2C9HFdlH/T8ad9Ntv5Y
	dMznfP4Ix5MBUl1B/aoahDiYF50JIXk6f/IDhG4eCr7LLEcnEKpWR5FTz8ugPmq1GSOCtAP7ewD
	m+vKJpdtTnqfvEaOiKAsWQfcJDKWUj9hy+xGsHAb9lwViZjri4ro8dqG5VUSbjZAyFA9RvGULRp
	guWz8XjJZoNvddZTjTaCfez99obPvA70TuWWVgFJ6HlKiDv2HOibiGdrMkZjoavv27z8lmlDlek
	D3Zye64aFMo8EQQ12GJOr39xoDahxmaUyJjhEkUDo+4VJHeOq4I1sU5QRWfbSqv8JuCN/i4L2MA
	==
X-Received: by 2002:a05:6000:290c:b0:48a:fcf8:20d1 with SMTP id
 ffacd0b85a97d-48b02550600mr8872303f8f.48.1790854103827; Thu, 01 Oct 2026
 04:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-miic-validate-dtb-v2-0-1ee3d33748e9@reliablecontrols.com>
 <20260928-miic-validate-dtb-v2-1-1ee3d33748e9@reliablecontrols.com>
In-Reply-To: <20260928-miic-validate-dtb-v2-1-1ee3d33748e9@reliablecontrols.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 1 Oct 2026 12:27:56 +0100
X-Gm-Features: AclHuK8F6U7l3QWG93hRCdan52bWlrmjNJx7o9EjG92O3k2nxmSLT0XW8-w3RDA
Message-ID: <CA+V-a8uGauEQZD4dT7woBmg4b0dqgvWNQ7JCdCgpf4U=aZ0X-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: pcs: rzn1-miic: Fix port numbering
 on RZ/T2H
To: khendry@reliablecontrols.com
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

Thank you for the patch.

On Mon, Sep 28, 2026 at 10:19=E2=80=AFPM Kyle Hendry via B4 Relay
<devnull+khendry.reliablecontrols.com@kernel.org> wrote:
>
> From: Kyle Hendry <khendry@reliablecontrols.com>
>
> The port numbers on the RZ/T2H are documented as 0 to 3. Update the info
> structure to reflect this.
>
> Fixes: 08f89e42121d421b ("net: pcs: rzn1-miic: Add RZ/T2H MIIC support")
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> ---
>  drivers/net/pcs/pcs-rzn1-miic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-m=
iic.c
> index cb74861e823c..df70309c2d97 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -838,7 +838,7 @@ static struct miic_of_data rzt2h_miic_of_data =3D {
>         .index_to_string =3D rzt2h_index_to_string,
>         .index_to_string_count =3D ARRAY_SIZE(rzt2h_index_to_string),
>         .miic_port_start =3D 0,
> -       .miic_port_max =3D 4,
> +       .miic_port_max =3D 3,
The description for miic_port_max in struct miic_of_data needs
updating. I would suggest renaming this variable to miic_port_last.

Cheers,
Prabhakar

>         .sw_mode_mask =3D GENMASK(2, 0),
>         .reset_ids =3D rzt2h_reset_ids,
>         .reset_count =3D ARRAY_SIZE(rzt2h_reset_ids),
>
> --
> 2.43.0
>
>
>
