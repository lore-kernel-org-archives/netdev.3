Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1563FCB1C
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181747; cv=pass; b=uxbWahRJhUphvMsY8qdTDZiS75I7/WlD4ez59qv7yfbGKbzqCuIoDCxKSrgGv7w2LSIoSi0Q8S1ZTREgKCntGbKRd5bG6Cnl3UF207qmt8Z6LIIzIbZOW81vKiB0AbKWng5UWFkvpKTxQlqjDZjoOfAXq4+NGyuXBlrkhsNaBRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181747; c=relaxed/simple;
	bh=gCtW1g9OXbHbP5WARIAr6crnyFAi76AA0+tgDuZZFxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpDRLUACM2z402Kql1Tj6y+YB1F6CCgJv95H25OTO6yQg8Xj1f7sGYaS/bf7dIALeNICgHa1dlLE4ncBnT+lTSn8kAsTwD3/IyQfDwExPoz6uaJ3PZGjf+w5sEC4E8zaDsHTTx61RJZnxZsoJI4M2b3MvyIHbcHpWSJqwv4xoEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxIjCsFF; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxIjCsFF"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-82380b0f55dso99672a34.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792181744; cv=none;
        d=google.com; s=arc-20260327;
        b=AJXj76pOyCor89b/JylVjV2XNXsulgoiQ2qO2hT80WpXb8aJ5FzU2Bakyne3ZDafDS
         DNFTsWPsGxZtgsOjIgn+rb8y47fQx2Xmym/W8TYDlHe3yshMDKFu11IdsrQbISm7wHb/
         wy6ktwS7dNyxbMG6wYBRBu2IBy1fWD7hNVS4RFxL3bBqxJ6Fz3Se0yJUtpLyiolmj3q2
         RCwnKnX/HJWtF8cH8kmo93B8CpwD/8MCcuQuxVMCvFkEwx/VdT6S1L70gZVVCZYcA8Ou
         llLj4lRbLTDapBhqlqOWBREJmCyK6uENo01znRZc0cpMfaVibMi2htJzSA4/uz6xqe8W
         eiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bu/RyIDM5PTqk4ZpQzE0STFmO57l8GWV7zB4VPEn3po=;
        fh=WGvprGIlIf6xJaVI44NxtPRC4TMaPtpNPJ7LL6o6Tqo=;
        b=o5XBlyLdIUQ9knLKJm8PqFcj0icuPgawFpgUAcL+qjZMkmWhSq9PVazfkGDPQ2yM7l
         S4ZJ+Q8avf9+rKKQTtfM0JPnrV3GG1B82C+IhnWzRT8ifA/zeDdTHNuGIoAE2TbX8sCN
         eC51XytcYMUmuKTl/LmqSP3QPc2BNIoBFU4oVKs0WRiDCNE9yovSdBHuvA8q/jcifUPd
         hAxsR09F2At4uqXE3tjWWG9vhzPDfK234DrQR6XR/QF0vnrLPPOEt0Twph/WUN4EvRyR
         Sp6ukxcCsIGdc+gbYRQhOeLhELj/XYTMS0GskI3+Fp7/T40oXpmanQDm/jVM/rnSLR8R
         C9Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792181744; x=1792786544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bu/RyIDM5PTqk4ZpQzE0STFmO57l8GWV7zB4VPEn3po=;
        b=BxIjCsFFDsYdZjwbYAmRxyVgsKZ1UOeeyABiGWQ5zGvPiFH0UypL+P5sCSGkjMiub7
         XTdnY7DCDTzwMZdEVuf8o1Nqjrg5NMxueZegQv1pk4nO1/aE6GjDPVq6o1adl0AbMDsR
         GROdKgDJiyqbUe4nFaMElmgy9pqjVg/gdFtR1wnx4VLdDZvGV9HU/Mgf2WYbhrrEG/zI
         M4CtQrik2JM3wUn38wZfDRDeRa6QBJM2mz0cc3oF4xRt40EOUf2Pvs03JHu5DfnoC+tk
         SfCXfrjz/ITEpxtf857t+DSknLbM81vw8pRrTQMfsA9Sd6PuL5TBow3z5bC0R00bDypM
         Wu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792181744; x=1792786544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bu/RyIDM5PTqk4ZpQzE0STFmO57l8GWV7zB4VPEn3po=;
        b=jfK4xJ2wNbiAxP3QA4EJMghJ4LSWZX3Tbwt+dBtp/9FCMyuzTX81kuLuzP+O8ppArl
         08bdSWgFp30QA71ET7qo6CxE1kBU7VfdCl51erc6iyuc6eUV3rl8AvbsnPacy+1cmJhs
         PDcvDg72sikL9QvQ7HGL4rhf6Fne6og3jdXPbafyGFl7B9B5m1hAJouwyIycuI/Sc6Fv
         lbeBD1RSbwcwCAFwyal7bGsOsAr/AwBHJJeezPh7oN68yiblfOEMzDx6TK2g631bejSX
         1CSph0YdYp5m1GYy6imKAMIz/Fx97QnQLsMsV89dJGcoXbz7kK4xveEmJcIUcsUz1S81
         28LQ==
X-Forwarded-Encrypted: i=1; AKwUvBwL9TC75HgQTCpRUhIlKcI8IPv6TQ13NyVSd/9cMXNVquFjbLqZZIW6SAJYKDIJx8Rmv/QPgGc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSBITn9xBh69AtzrQSLjj6pXcHKzb7TNnDCRwvd3KlFYXqycRg
	sITrdcIuPK8S17fAYNZ4mNDCw7wTf8zAwZuhWVCE/suYKuZjvLOCFVgINBUnJkdLtn1jQAfSBPc
	YZAx6FsjWdnxr2myq9xkFCW0On/9O4yc=
X-Gm-Gg: AYBFou2gha/c+L0KOP7sbYnxgPFgs9dG0jul9SyjWzshd3Q9NftFRUH+eFR/zCZUMuO
	qZ5TxxVHFTpxce9J9tHE8Z3rlKRHTZh0vLhI2UmXOIs8PHrAyiO/Dt1zXN1PqrkxiEiUx1hQ6Gs
	ycKgfj/ltSOieKQbQx14YygF6TjTyaX+XiEp4Dhkh4nbQ5ZEZgVCkzhstMR6KTfDf0KU9tUgKRa
	J/D0dMwPzEb0eXvO1J6tKlBLtD8HSmh8GNcsKQ/FFefDdodG3w3nXunPeRN30tG/rcRpFfzjzLt
	CoHuWi5FkqNnGEPQqb5VtVHAJ1y3zgawtlBBIpM5phxE5XveEvBG8UPpH2ULJFjni22mgfXxMeu
	fOfiHs+WTpGLv2tNcPWUsG2l/w6idCe2q/ntclifrANXFwg==
X-Received: by 2002:a05:6808:1507:b0:504:5fe1:c8d4 with SMTP id
 5614622812f47-53cd2f4386fmr654852b6e.59.1792181743855; Fri, 16 Oct 2026
 13:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013011122.1889766-1-kyle.switch@motor-comm.com> <20261013011122.1889766-6-kyle.switch@motor-comm.com>
In-Reply-To: <20261013011122.1889766-6-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Sat, 17 Oct 2026 04:15:07 +0800
X-Gm-Features: AclHuK9indAuT9sQ1gYBXpJavrWPxXYJRGBt8G_7TObPBqWYMK0ks2cmSCXGj8Y
Message-ID: <CAAXyoMPeOmMZ8u=+S9=W=aJ0riSRbkBX9afrcVdfrE4BreO-Hw@mail.gmail.com>
Subject: Re: [PATCH net-next v14 5/5] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
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
> +/* yt922x register lists */

The indents below look inconsistent. Please adjust to match the existing ma=
cros.

> +#define YT92XX_PAGE_SELECT     0x1e
> +#define YT92XX_PAGE            0x1f
> +#define YT922X_PORTn_STATUS(port)      (0x80200 + 4 * (port))
> +#define  YT922X_PORT_LINK_STATE                        BIT(8)
> +#define  YT922X_PORT_LINK_DUPLEX               BIT(7)
> +#define  YT922X_PORT_RX_FC_EN                  BIT(6)
> +#define  YT922X_PORT_TX_FC_EN                  BIT(5)
> +#define YT922X_PORT_SPEED_10           0
> +#define YT922X_PORT_SPEED_100          1
> +#define YT922X_PORT_SPEED_1000         2
> +#define YT922X_PORT_SPEED_10000                3
> +#define YT922X_PORT_SPEED_2500         4
> +#define YT922X_PORT_SPEED_5000         5

Leftover from yt921x_speed.

> +/* ISO */

The comments here (and below) did not provide much information beyond
the code itself.

> +#define YT922X_PORTn_ISOLATION(port)   (0x4 * (port) + 0x180d80)

(0x180d80 + 4 * (port))

> diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motor=
comm/mdio_bus.c
> index 3aa1111efaa4..a4cb74d0fd90 100644
> --- a/drivers/net/dsa/motorcomm/mdio_bus.c
> +++ b/drivers/net/dsa/motorcomm/mdio_bus.c
> @@ -299,3 +299,42 @@ int yt921x_mbus_ext_init(struct yt921x_priv *priv, s=
truct device_node *mnp)
>
>         return 0;
>  }
> +
> +/* intif extend register read/write api */
> +int
> +yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg, u16 =
val)
> +{
> +       int res;
> +
> +       if (port > priv->series->max_ports)
> +               return -ENODEV;
> +
> +       res =3D yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
> +       if (res)
> +               return res;
> +
> +       res =3D yt921x_intif_write(priv, port, YT92XX_PAGE, val);
> +       if (res)
> +               return res;
> +
> +       return 0;
> +}
> +
> +int
> +yt921x_intif_ext_read(struct yt921x_priv *priv, int port, int reg, u16 *=
valp)
> +{
> +       int res;
> +
> +       if (port > priv->series->max_ports)
> +               return -ENODEV;
> +
> +       res =3D yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
> +       if (res)
> +               return res;
> +
> +       res =3D yt921x_intif_read(priv, port, YT92XX_PAGE, valp);
> +       if (res)
> +               return res;
> +
> +       return 0;
> +}
> diff --git a/drivers/net/dsa/motorcomm/mdio_bus.h b/drivers/net/dsa/motor=
comm/mdio_bus.h
> index e79b725d435b..513a8d2d7618 100644
> --- a/drivers/net/dsa/motorcomm/mdio_bus.h
> +++ b/drivers/net/dsa/motorcomm/mdio_bus.h
> @@ -50,5 +50,7 @@ yt921x_intif_modify(struct yt921x_priv *priv, int port,=
 int reg, u16 mask,
>
>  int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *m=
np);
>  int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *m=
np);
> +int yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg, =
u16 val);
> +int yt921x_intif_ext_read(struct yt921x_priv *priv, int port, int reg, u=
16 *valp);
>
>  #endif

intif_ext_* should be placed right after intif_* (if they are still in
mdio_bus).
