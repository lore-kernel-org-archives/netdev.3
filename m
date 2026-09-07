Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16279443A84
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809996; cv=pass; b=CjaSYMnZDHJ/RABhnyqTaLkVwA9RUuW7OSbv1nCuuF4WBx3q9asXB2RYi8vKJwXfJ7ejd2+uaNUKfVbACM+LYL9wrtTM/faKB4RvVr5xK2DH8NkSCrDlZ9PiVFnd+HWjosEJM9SsA7GRA3XpAg7TgxCiLNlyq/kSqZ4zBzma1/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809996; c=relaxed/simple;
	bh=gfb1OFy6HnketlAtt5XqTvEazZ7wrq8ZI6YrMsSum2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACo2AbgEVbIPj2ai3x3STeuIcTHXi2v2z9wWcA4VeNJn/HKohvwwUMc32nIWyTdV11WU7jOk3Nxzy8RbYkNBaJ4AHe6+VFjeh8ts89hzc88Oyu2EUr1HO5bDlv7y6vlUGd4y87yCfaNAzExfjsyo5iPjgWfamen8Q5lQqzGLaik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppLTYMGu; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppLTYMGu"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so2101225f8f.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788809993; cv=none;
        d=google.com; s=arc-20260327;
        b=dOXK1pSbJ8894eznBa7+OcSMYzn26uVEx7kJgcC5oeYJjVNVqLgcCRJblB6Xoo1frs
         XB7+D18wYtVdaP88nOIWfG3zkvs4ezRorfQzM2lY2hT415lzILJTyH34GHYIjRoqcwr6
         oNwFsNcyXisoaGyj5Z+B0RLqjgTgvUPY1SG+9zXKR10lLHtRejmF/PEhogLvyu0SxKw3
         p5+CqXXXnRor7aThjXYYYwwxrREdks19N/bg6Zuaaq6QW7oApUnDX1Ap32KJ1tafV9VC
         Z9emd6emLF7zsJFlkCljDraQXDGGvB5zxqIlq3/49jGmPXLfUDnudKSthYak1YK74Ymi
         7zzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UbTECHpg/c3ZKvu0s3KVwXXekuTGLp53kt2aih8Xec4=;
        fh=VJsfMNkIukoMsu4G22qpatalPfkzYYEzKBT2FE2wdOo=;
        b=iOS+/qv/UkODkHlI5BgTZt56qMg82EOX+ZdadcgRrkRQn1Nj6F+HEXVQCmqoMXZ6/D
         CJHmxDq068RP67HvnocMDTqML2ySZnvvAuKE4fVzhbs580eE2J7pPijZeZwxNEOw+9lj
         Akld8Tgl8mVG3uI540eZa/kai53Mt/e9hVQu6Es/ni9T62Hk30xnokw1ThszhNh1P5TH
         icuH/and2EZchFNDcXStxU2DHU045WfzwpYHANOqvLqNzYq+gFALra6Mhc3rydY4kxbx
         azSR89SAuIr9aVyJuNB20GFSz5bHz4EuIRxon4/HrmmoKsR5gv1AYmXqgsPGxHdnjfg0
         wE5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788809993; x=1789414793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UbTECHpg/c3ZKvu0s3KVwXXekuTGLp53kt2aih8Xec4=;
        b=ppLTYMGu2vSdw0/65kAKro4AL1aOex0UDW/GtT4vRTKXPAH4lFCzFhLEKjre1vJO9N
         zn9CdtoHfF+eJMyM4cIhjoQG0klhZWCSt0E938vF17zVjHcSx30fBLFSp+EpaFqevFZW
         7X5UjSf22/CcOsAmxyEnVxq75NJR3A7awvZPJ4nlDVpkGHAe4hQmmuOxXFBipVHDPuqK
         NJte8q/uP5b9KhLA7SJUvc9IgokZyhXgcsuS7eVSvLUxIsSFGAhwPwYwMG+Ryp9YTOcl
         tar/3MhjurwOtcou22/8mTkOusDJ7phk3YINcWQUf4I6QnqC02xXvwLwA3+qXcUWxBbo
         W9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809993; x=1789414793;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbTECHpg/c3ZKvu0s3KVwXXekuTGLp53kt2aih8Xec4=;
        b=CPOmQMmybVxcB9pbc+HRw8d91gOVEhdRNKGI2WT74C1hHbu1cshQs+OyIuEVXcCaIU
         L5HRkjdT4KIBH7lC+z+DHVWqtS7OoZ+vVKqNAshn8p8d9kG7iqzAE2AUMQLDLgnahmJA
         iqoOIqfpEXQ7TBVEWgG/2Y8GvH8ps/eh1f3zzspfgdRD/b/8V4vr6Z5zRvPxYahRhclv
         rsu+wQSuKRJ6AcIRV0tiQHYGAMlcmsL+3ODqHlmOILAqBjoQyqjWhkOmKiqORQLvl+XW
         C/ytAMhrRFbVPX96hq7sqYZqzHoGdXdrTKKEMG90DPHExOlW34L2qxhuqIswm4ZwAsoc
         Pnsw==
X-Forwarded-Encrypted: i=1; AKwUvBx7cqhJ0TWO+g88IWWwbcOj/p1u6OG+7i8Y1MVEr/GzRcBdEwiyyH2IwVGBM+HCApQHG6qdsa8=@vger.kernel.org
X-Gm-Message-State: AFuF++kfDWiCMOvaO3/7ZGMpKPvwigVMhmPpDUt2PFFgiDYirFtC0LEf
	inEZAPBF/plYBQfM5KBtjN3dUvE0fK5UcOmT2vRXr89D5GyJc/s0ATHiS5e3ImBJViGPYaf4OA7
	053wxuNwN1owsQfEZ92XarstrChIf3fw=
X-Gm-Gg: AYBFou0w+j7m/Skthd3vOASgQv7q62ZiIDv4++RJl1qpYkAdjk6W+PwIU3Dna3PKxVP
	UtS9+E81P5YWsO8517+XZHkWB2zUq5g9rIgNvMy/VmsWkRJqSxV/AKsI2tivLoKNFtNnGDn87Qf
	DyU0q4qJ/Rk49OusJjdSBbZ051DRQAPJxPVPGEl8ub8PO7z+egq+MjuriK0KpW79piZRJ8ZfhIF
	tyuoEhA9hcRJ2XHBTmSpLYxr6fq/vHv+av+bIxhSdj9X3QEYYRprjyM+KwDz4thvPOp+z4nAhun
	jjyY6g2e0CdzcOGkK8kU8iKlmP9UZI11Y26STuNZkr64xb7HpsZyLHMfGCd+zOiBaGmhBEZxX6M
	R45oZs1PrugidyE7XfbM9qOgX7kqwcVgK
X-Received: by 2002:a5d:6f08:0:b0:485:8a47:5b8e with SMTP id
 ffacd0b85a97d-4858a475d4cmr24045312f8f.43.1788809993301; Mon, 07 Sep 2026
 12:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
 <20260902-rzn1-miic-fix-array-v3-2-3f7dccffaf5a@reliablecontrols.com>
In-Reply-To: <20260902-rzn1-miic-fix-array-v3-2-3f7dccffaf5a@reliablecontrols.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 7 Sep 2026 20:39:27 +0100
X-Gm-Features: AcwNN1WqIPfZI7d2ltyP8smilE59YQ5lZz8X2iBCgOL-jJlaLFlqC46GZV_NYfo
Message-ID: <CA+V-a8tOLKxFEKF+yZ0Asf_KYb=_hrFuJagkdzHPxZ_zf3MNRw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net: pcs: rzn1-miic: Verify port number from dtb
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

On Wed, Sep 2, 2026 at 7:55=E2=80=AFPM Kyle Hendry via B4 Relay
<devnull+khendry.reliablecontrols.com@kernel.org> wrote:
>
> From: Kyle Hendry <khendry@reliablecontrols.com>
>
> Add check to make sure port number is in range before writing
> to dt_val array
>
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> ---
>  drivers/net/pcs/pcs-rzn1-miic.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-m=
iic.c
> index c50b65d064fa..3ee40eb9d545 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -692,6 +692,12 @@ static int miic_parse_dt(struct miic *miic, u32 *mod=
e_cfg)
>                 if (of_property_read_u32(conv, "reg", &port))
>                         continue;
>
> +               if (port < miic->of_data->miic_port_start || port > miic-=
>of_data->miic_port_max) {
> +                       dev_err(miic->dev, "Port number out of range: %d\=
n", port);
> +                       kfree(dt_val);
> +                       return -EINVAL;
> +               }
> +
Query to maintainers, what policy should be followed? Since the
dtbinding check complains if the port is out of range should the code
also check it?

For the patch,
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

>                 if (of_property_read_u32(conv, "renesas,miic-input", &con=
f))
>                         continue;
>
>
> --
> 2.43.0
>
>
>
