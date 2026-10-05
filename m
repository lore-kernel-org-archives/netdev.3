Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BC41A55C
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791242307; cv=none; b=YUNGuBWwmSCpcPEv7S9GdBGogS/wTGsvFm8cbwHyR7VaQoboD8cXnBGPWJD1XDP9kVYYNzsGiHxoXZTE6qcX72xUiAwn9ecVJ14limxHwTIWNB1SNLZRzAb7+gEf88duKcwiE+JAzdJBPRnmRXnpXT4FDIBaq5BAGHwzELOMZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791242307; c=relaxed/simple;
	bh=vqJr189aB6M/6k1UCPtjVmkb5zvPig46uo0mk1JCeMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTFSes/X239JrEhOUwRlY1HyjxCO6dxU3kWKK+9mEsAMmJXQz0bpq1M5Nf79tprk38KiunbVa4KzRvV57d+FYaeu5hSArXDN/Bu7AEYxwkr7TJtV3HKi6bXkr8SFMfUVkPqZClPvn6hxWStxHewHSGfxlYqKKwYebLrFpg5VJcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBlRD5ys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBlRD5ys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D107F1F0089B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791242305;
	bh=m1vHZTgiceqAeKubO4yteGWWVpfrRtEcB3KrQZKdVic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cBlRD5ysFzMUhIxx6nnCNE3HXRi3fltTuzomaxiJ+5Ulh5zJnd7tIkGaluVbxK9c3
	 1kF1oDXfDdrnvFewaRKPJHvdoCmc9gR7BbbneZowbMOLLY0d0P9tJDXRFUPDKYota0
	 JNgPgVmhtBJP+SoALYliEKKrFTY+VbwZXrsFcqsi8d5XYgpe0iKOuLk735YwPRkqmV
	 qpK2iaL0I/bOvp3ZsBC5ZisiK23K2QmQvLoNh417RZdyO7X0QLUGP2Jct5tNsAkAv1
	 tLoDuoFKFXfjnk0qTs3qjz2+6vXM42tU890lDNmd72suqfwp1Juit2Xq7rOyWgax/m
	 ffzjCEZvzjx3g==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8e986b8b1so2902633e87.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:18:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzpBpx+q/XXb1ZahFjUO1mTk1GgT4jx/EXcgzs4Vg/X5+yyt4Z3sUxEtvv++kVA6ZNMcRA3clc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAn+9mNV1ElMOgOpqOPe1JGJkCEaVKEwAQb89zdySc7ip/FLRA
	wFaEI2efha1WwKdRvkIIzvIzYD+h2VLeVIAXKmtmyzWTngzA2ArRXh0UyQ2ViNO7yv0IsEv8yhB
	URx1V80HVhTGjQNj2lIMcy5d7lFVtMwg=
X-Received: by 2002:a05:6512:ba6:b0:5bb:7b0b:7bd8 with SMTP id
 2adb3069b0e04-5bb93832eb3mr4128213e87.7.1791242304567; Mon, 05 Oct 2026
 16:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de> <20261002115850.962676-7-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-7-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 6 Oct 2026 01:18:11 +0200
X-Gmail-Original-Message-ID: <CAD++jL=tuGRjbKqLhSLTobRC00UJkG0XhWxguxRRwDOTQLHd2w@mail.gmail.com>
X-Gm-Features: AclHuK_4TTLuhQrg31EG1rZy12IMoUL0uk0wkqHxXU1WENSCWOtzWqpYpVQCY5U
Message-ID: <CAD++jL=tuGRjbKqLhSLTobRC00UJkG0XhWxguxRRwDOTQLHd2w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 6/8] net: dsa: realtek: rtl8365mb: add QoS
 baseline and DCB default priority
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

thanks for your patch!

As mentioned I think the main logic of this DCB stuff needs to go into
common code.

Whether to use rtl83xx.c or create a new file rtl83xx-dcb.c with just this
QoS DCB stuff is up to you.

Some detailed comments:

On Fri, Oct 2, 2026 at 1:58=E2=80=AFPM Oleksij Rempel <o.rempel@pengutronix=
.de> wrote:

> +#define RTL8365MB_QOS_QMAP_IDX(_nq)                    ((_nq) & 0x7)
> +
> +/* Internal priority -> queue-id map. Eight tables (one per queue count)=
,
> + * indexed [table][prio]; four priorities per register, 3-bit qid. An N-=
queue
> + * configuration uses table N-1 (1Q is table 0 at 0x0904, 8Q is table 7)=
.
> + */
> +#define RTL8365MB_QOS_PRI_TO_QID_TABLE(_nq)            ((_nq) - 1)
> +#define RTL8365MB_QOS_PRI_TO_QID_REG(_t, _pri) \
> +       (0x0904 + ((_t) << 1) + ((_pri) >> 2))

(...)

> +static int rtl8365mb_qos_setup_queues(struct realtek_priv *priv,
> +                                     unsigned int nq)
> +{
> +       int table =3D RTL8365MB_QOS_PRI_TO_QID_TABLE(nq);

Prio to qid table is nq-1

> +       struct dsa_switch *ds =3D &priv->ds;
> +       struct dsa_port *dp;
> +       int tt, ret;
> +
> +       dsa_switch_for_each_port(dp, ds) {
> +               u32 reg =3D RTL8365MB_QOS_PORT_QUEUE_NUMBER_REG(dp->index=
);
> +               int off =3D RTL8365MB_QOS_PORT_QUEUE_NUMBER_OFFSET(dp->in=
dex);
> +
> +               ret =3D rtl8365mb_set_field(priv, reg,
> +                                         rtl8365mb_qos_sel_field_mask(of=
f),
> +                                         RTL8365MB_QOS_QMAP_IDX(nq));

This sets qos port queue number to RTL8365MB_QOS_QMAP_IDX(nq)
which is nq & 7.

> +               if (ret)
> +                       return ret;
> +       }
> +
> +       for (tt =3D 0; tt < IEEE8021Q_TT_MAX; tt++) {
> +               u32 reg =3D RTL8365MB_QOS_PRI_TO_QID_REG(table, tt);

This finds the reg for table nq-1

> +               int off =3D RTL8365MB_QOS_PRI_TO_QID_OFFSET(tt);
> +               int tc =3D ieee8021q_tt_to_tc(tt, nq);
> +
> +               if (tc < 0)
> +                       return tc;
> +
> +               /* QID field holds the traffic class */
> +               ret =3D rtl8365mb_set_field(priv, reg,
> +                                         rtl8365mb_qos_sel_field_mask(of=
f), tc);
> +               if (ret)
> +                       return ret;
> +       }

And sets it.

In a code dump I have for RTL8370 writes the same index into both registers=
,
so something like:

{
   int qmapidx =3D RTL8365MB_QOS_QMAP_IDX(nq);

    ret =3D rtl8365mb_set_field(priv, reg,
     rtl8365mb_qos_sel_field_mask(off),
     qmapidx);

(...)

    for (tt =3D 0; tt < IEEE8021Q_TT_MAX; tt++) {
      u32 reg =3D RTL8365MB_QOS_PRI_TO_QID_REG(qmapidx, tt);
      int off =3D RTL8365MB_QOS_PRI_TO_QID_OFFSET(tt);
      int tc =3D ieee8021q_tt_to_tc(tt, nq);
(...)

So we compute index once and use it both for port selection and
table programming.

Can you check this in the RTL8365MB manual, this old RTL8370 code
could be wrong but it's also the way RTL8366RB does things.

Yours,
Linus Walleij
