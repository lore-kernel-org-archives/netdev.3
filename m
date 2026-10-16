Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB23C8C60
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179546; cv=pass; b=QSsoFFV+F4UC/I38bH6bXfw9oc9iRGpBYtk7mNZLOl8ceKdsaT8Gyr5mKflQiDtVveHTTXn7EUyAg+CcXlr/XYM8iy3oCgHNuHMhNm4kQBvkDkbChr7RJwWRvkjtMJJutuyityOuDQv/CJNykok+YuVmUCGDqTZoVL9eX2+9cZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179546; c=relaxed/simple;
	bh=ttNt0pCWtIYi5Xwqcvq+nRkbDyN+s8BRgGWTRR1hLng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGEgqsUSPiBXxDODqB81r/X+PD6dPjlWhN7+LCHrZeJL53dObmWKvqW85yGr8Y/1wbv+U02n3uL4OJ6iR0jaSeEJA86HtgJjiulEdsFpT22ZdLEgdkLJe/7QSc7wXcwSbhlS78m6aYc2u6VQ2V/arF5o28qdiGr0LqwAh6mruuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4oXtQhp; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4oXtQhp"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-843b6f8e2c7so148123a34.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 12:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792179538; cv=none;
        d=google.com; s=arc-20260327;
        b=X8/SwO4/d+2r6u/1nyCSEbdatGgpTeJm8/3wxekerrBO7sqWir0bSanTUhYk06cPbM
         yJSqSXsMeAltxc4b/upJqQ3Kj/RqUbCRvBi9xDfPsFuqZcsSCkyAkxCu8gJ8mP41BCLR
         VqlqLdsLAj/vTOTbAjFxs1sWLp/naP7ruZF7d4b9MSE7L59e6YsAWrUUVoyzCq4S7Jk9
         LiINXrM2Bl37PHyezntPkmMJwU1AZIKrRMOZWDWUwRb5ofoCe6IUXf53JNKR7fROrS1t
         duNmfkm53tH4Vtq2Y4B0nljza+Nj6/V5rD0kYh6rtsjvn/AeY5LFygnacoXSDOWLOTFx
         8i3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=77hTM8EJJKmduk7MEyJTqP0/PRriK6Ki1atqibncfhI=;
        fh=936zHD9EqajUl0jnIxT9Q6nOeoKGEls+y+aXwvroLSQ=;
        b=m1Hb/nWMooyzB19UAX/NiAZpFJaBQ5MThYxlTcGykv8Ho+Zd/sz1OFHfkcqIMceHaa
         NBHsHMEZRiYtaktX6IjLcSsiLlPhbymOMKBaBSpry0lyQVx8z8PjX4jTQvch4m4X93xD
         CXkJOjdxOH3TNsjAmLw3GfrcUQVz/dRMADpkbigf8TzY7k7+AbOR6i5R0rBdtyYIBdTC
         1h4CqKRsBO3EXfhx8h9hDFXbBJeOLP4pFM8Da5R+9M1KSaJWiD5LL15YEKrgiM/A4bTq
         gH5Tvnb8Kk4fzxKHc4CCAo6jGJD+cj4pGkpWLq4XBErVD+UKkXar4ZotO9AAK5TnmIhu
         P9sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792179538; x=1792784338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=77hTM8EJJKmduk7MEyJTqP0/PRriK6Ki1atqibncfhI=;
        b=M4oXtQhpHmumqaJWPWN8sZKGsqL6L5qPrNXGfv9Fr1/qsDPX6LprOewCRSAvxun2xM
         P1RbnyO9jg6e6wp5Rr5vVFAyE25iWBqGwOeEq1VeGdY7ipGRK1zIF96EcEIuDYAJVY4I
         nYawlVyji5PVQFozReAxGYtu44HEGbq7SuKujpYH3mJVA4DnHOX9JONMDYtG7p5GFl6x
         j4AgJflV6JGoq1EADqA3mzCdqWbdZJLszj15Md7pIT0t4im8LECrVVHEVneUIBvH8X9V
         gQJXab4oo6wMTFMKLKuuBHIaAjyrqSLmsZn43zuEuvUkVenT0XYbil6X6XDYLZoYHLOg
         LkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179538; x=1792784338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77hTM8EJJKmduk7MEyJTqP0/PRriK6Ki1atqibncfhI=;
        b=thpha0fxeM1aVdzH01gifQhZYW33IL/8FsyXOUBrID4c6+7GiyaIgpzUOz4DVn52QH
         Z0lK3YCVybhX9I9deDZBDoqXu3SwwMxlc5NVmEZPq6qxEze2H2s3F6/KG5dQ9li5yDrv
         wc1nd99+uDJQBzhKX9krWpUTYxPnhEqpE3r4dlQi32clgQb58zFYtG1x8qGeFLtlWx8r
         7r6NHz7OVRizthyx70VBTm5KBCDaueYayYNYtIfymoj543NodSE/JlbDfkLdaedCUjg7
         qn/04dx3WDxgMWvi8f+MkXx4MaClPFz5ZNeFEx/1ncdnaq+A13PRsNicF2XUl7wNTjde
         3hIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWO00Cr+PJmQq9l2mTLWUi7KxxMOCkRYaipYa9JZIwW8LIa9JqhPK1O6R+QICnnjjwJnW/YU0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKELWI2z2MoGpo0OyEUtiZgp2OjXz3eGPkH99/3n8kyKs4wKRM/
	WXWFMdSw07QzRnuWQgFQ16hxShApTOJAPRWuQaN0r/jsdaqrH8j9L2Xyxt0IeniVt5IKlgG4z4h
	nhmVTItBYo10CEAQ0tQEu5tEuzu0AbvgSig3GG0j5ng==
X-Gm-Gg: AYBFou0Z86ZgiBLU5nXyTLu4mteyit0L4bpxC0dLgOtX3J+t9fDTR4XjGf0Af5OTVA1
	bMYHCjfNTEnoKqkJ6qePDNc9lpf816f9fJ+hvWzkqSVXck8HKGOcUR55vU7QhMgwDYqKbSqmVGe
	b2TeTEfkR4CISO6HJmVSl/ktdNuGGc4bg7YsHk/D8nCX9gQdG283AlgrSu69qATIf1QGMv1z1wD
	lv+qfDJJOpmOm5v52kMLwN49PDOlFXKsNWcD78Ptn5XUPIhmSIthqB4aOKPxzlYvfRg6LcdhPoO
	anBQIpzXnMkDWjQWKTvxLG6Q5YN2BoKRZDrVJzePat6JM0+rsnthqsIbTjom384Rd/4ORzCgs/L
	f++n3OVUR73XDSo4zoIeeIqA9PaYUfGcpev9I9LGobi9NJA==
X-Received: by 2002:a05:6808:6409:b0:511:528d:7576 with SMTP id
 5614622812f47-53cd0b3dc69mr594244b6e.54.1792179537603; Fri, 16 Oct 2026
 12:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013011122.1889766-1-kyle.switch@motor-comm.com> <20261013011122.1889766-4-kyle.switch@motor-comm.com>
In-Reply-To: <20261013011122.1889766-4-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Sat, 17 Oct 2026 03:38:21 +0800
X-Gm-Features: AclHuK9JrFOTB97m2FwJ_OxHZFE5heOx-9wmGKbfro2yt9RYpPOHq0k3WoWbavg
Message-ID: <CAAXyoMMw5ygXT7vO-GWWodY1HRuf+SgyfcaLenqnUGUvjTxjOg@mail.gmail.com>
Subject: Re: [PATCH net-next v14 3/5] net: dsa: motorcomm: use fixed-width
 GENMASK_U*() helpers
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 9:11=E2=80=AFAM Kyle Switch <kyle.switch@motor-comm=
.com> wrote:
> @@ -36,19 +36,19 @@
>  static const struct yt921x_info yt921x_infos[] =3D {
>         {
>                 "YT9215SC", YT9215_MAJOR, 1, 0,
> -               GENMASK(4, 0),
> +               GENMASK_U16(4, 0),
>                 BIT(9),
>                 BIT(8) | BIT(9),
>         },
>         {
>                 "YT9215S", YT9215_MAJOR, 2, 0,
> -               GENMASK(4, 0),
> +               GENMASK_U16(4, 0),
>                 BIT(9),
>                 BIT(8),
>         },
>         {
>                 "YT9215RB", YT9215_MAJOR, 3, 0,
> -               GENMASK(4, 0),
> +               GENMASK_U16(4, 0),
>                 BIT(8) | BIT(9),
>                 0,
>         },
> @@ -66,13 +66,13 @@ static const struct yt921x_info yt921x_infos[] =3D {
>         },
>         {
>                 "YT9218N", YT9218_MAJOR, 0, 0,
> -               GENMASK(7, 0),
> +               GENMASK_U16(7, 0),
>                 0,
>                 0,
>         },
>         {
>                 "YT9218MB", YT9218_MAJOR, 1, 0,
> -               GENMASK(7, 0),
> +               GENMASK_U16(7, 0),
>                 BIT(8) | BIT(9),
>                 BIT(8) | BIT(9),
>         },
> @@ -3741,7 +3741,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv=
 *priv)
>         if (res)
>                 return res;
>
> -       ctrl =3D GENMASK(10, 0);
> +       ctrl =3D GENMASK_U32(10, 0);
>         res =3D yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
>         if (res)
>                 return res;

The change below is fine, but the ones above aren't, the width is
already pinned by the variable being assigned to. Also DSA expects u32
port masks to some extent, those add unnecessary changes if you want
to change port masks in yt921x_info to u32 some day.

> diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motor=
comm/mdio_bus.c
> index 83f0212551ff..3aa1111efaa4 100644
> --- a/drivers/net/dsa/motorcomm/mdio_bus.c
> +++ b/drivers/net/dsa/motorcomm/mdio_bus.c
> @@ -159,7 +159,7 @@ int yt921x_mbus_int_init(struct yt921x_priv *priv, st=
ruct device_node *mnp)
>         mbus->write =3D yt921x_mbus_int_write;
>         mbus->parent =3D dev;
>         max_ports =3D priv->series->max_ports;
> -       mbus->phy_mask =3D (u32)~GENMASK(max_ports - 1, 0);
> +       mbus->phy_mask =3D ~GENMASK_U32(max_ports - 1, 0);
>
>         res =3D devm_of_mdiobus_register(dev, mbus, mnp);
>         if (res)
> --
> 2.25.1
>
