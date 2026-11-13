Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794547943;
	b=HpPZU3OuTqi8RTy/xutZgm67dV8qYfz0U/90PQgMTd9CfgaoTPoEHN6IDQUMRa87+lGN
	 ITsnmWw7iz31XsIZ5JOAgl52+c4aJ/BtF7d881323Tp1dE5+Z7JIOnnOI3obkoKyuqpY5
	 vBs5ee9eVZGDy9Sec9zylxzp7nUpJtIj3nU888kS98U0Gsc/vs7dBNxEed8F2yWdz87fW
	 tu7iMBINCXefFYhFMIzmF6m6oE0ENY9kqHDoVeASNFEKgXGnBtKgU2bkM0xWJpCtTAL+7
	 VP2g5+d0ZwOi9T/qzhYpqSSWwnkaBEFJMkCt7BC7B00sVuArWX4G5b7wLvYAROHhY3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=PMkxrO97b4yYbWVhj8cUtAkoX0Am73APWYvTvRhYbIc=;
	b=5RFtryGLT1MOxEiKK0lwBt6d/0cImZK+AttB5HajnhGrHzz6GLu1YjiQsf53AamRIQ4B
	 NWYYnv8bEdr7No7X9B0rurtAIdYq7SBR0WS1LMwjYv/fvEFoCakzbZi7ZYRirYvWZnj5O
	 oI8zjrnTBeqO94bDvl/7YlHQFYfgL1cB97mK/3Tin+yQoTKGI3ulTDtMO+/tUjj0ZL35a
	 MYPJNit6LBtWvCsiR8xUyGUVpK22BCwKoIumtFeGh2KzY15TvabMAnvByfGfaP6FaqXPd
	 4Wom/TiRN6pCqDez8Ih9SJTFTnRLFZbHZTOMzpI8k71SWGMFjNpZ+5Z5pF6l/yIzO3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i7Bz1cSG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F18606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32F18606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i7Bz1cSG
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4395d31228so93913966b.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 21:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794547941; cv=none;
        d=google.com; s=arc-20260327;
        b=rE+ab1kdu7sKpWqg3jv1rlNC/PijUbkminVDIMVgfo77nXrihVWzTomPW1VnxfaQcj
         OlakRtYS4QO6HUulViOWzuHrfX2fEOy5XZ3wWNX4SmXNDej59y0cEU6O1Y40BPBLgN3Z
         7zrinjLcaRESoY+dSDNngQX3qBhXzeStAk4p86TkGZOquTWhZ8xllzLvTKCjpWf3Z2wW
         uzI4lChLUCzN4avtsrBIrxQ+X0+KxeJihrtTskBcwtZP1/lqsJ36Cg+zSDykHnu/l14k
         T4Zhl6uzX9WESeviIaIdK3rIscdp8HsgELPix5AqYzTTe7FNBjehCdk47L/XHDdHuvl1
         TcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PMkxrO97b4yYbWVhj8cUtAkoX0Am73APWYvTvRhYbIc=;
        fh=5YcUdr51mEwSimtte9FwvxJKXNYF1RC/Mr248au2xPY=;
        b=dMNQt0QM/XwJcR2LF1NHymH+nSmeA7oRDuui3bID8aS/RIAga9t+SFWVd6G0s/GzYJ
         6XfxzmfRjHmVYaZeFvbYmLLw7Sf9AwG5d6H8N+iiUD/A8vyvSl+i9N0+AYn0cxh0V8cD
         OTdRGVQGYYr58H7ihwGpMAcsOLknX9BTAR9bPcI5HrBHlDhmYOZTFCvtCdYdRX6WGZoz
         tPuS8aQthPt0m35L7I9mpM1d5J4G7a/H7vloZy7nDVGPHPkDm8MflxDc8NFJ0WaSaeV5
         r4tsiWYy+xtBKNEK6aPeRa7XnZS74yosbcXs/ZYdBwe8zjvVZr96ahUtrxU5U41uNftN
         PLlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794547941; x=1795152741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PMkxrO97b4yYbWVhj8cUtAkoX0Am73APWYvTvRhYbIc=;
        b=i7Bz1cSGySrpRLfuA2G5mTTDTcA965wGlPtRw04ytS9JqqYi4jWtdPDOc7qlTXQO/6
         D0i4sQD/m0/DQRp0MDc0+cYAXqGLbhFJaNZlS/iXQee9ohRuSTb1foJ32qK2vCtogbnR
         xcW4S37KeBsulUEk82WYoEhAxEM3cvqfQ4Yo1iO5UZmb84UClIbd6LpIulNLBeCjHuM8
         D1hc3K9YvSEqPKc8GoK4axF7VKyrbtGI5d6st8BNcRv+DK+eA0izIbUmJ/dLpz4DMPgr
         yRbI8lAWwSb5RBR/8LsM4Bu020xg8/eIeBrNNduTnrw0YqervkxBPcZkdRNUxtIw8Uyi
         hApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547941; x=1795152741;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PMkxrO97b4yYbWVhj8cUtAkoX0Am73APWYvTvRhYbIc=;
        b=EJvQ5Q0UzsyPcng1IfCt4NM2q9CQrxTTcGUWFGWp8WVPHXcxD2tFZQ0ipiBtkeks+y
         k5JiRo7jfoPyz8WR/i/Bac0HDLjfsm16L+EdUEPEwz45KL4rOtdM8sGKeBoW+xNq6y0K
         UofGq3RPQSdfCI5iww2pSH9ngpVHwUWJTgRHciQRSeSWShnW5zYdq4TW8MJPu1SoYiIt
         zGdzfhdtOl51fMMIRGzGt5oToEoWDjJ+z3jMwGahCZxwjdnLKAHqStDIIlmnqqiBTqsA
         5HqSwnQx5CWybreM+bE4+oTQ4Kryk6h8Gk1lJof1SHiCE81AMoqcz+ZneSzA13rPdWqM
         E/sQ==
X-Gm-Message-State: APuU4Z+v0UJhAaug76x1Rc7v0WR5IVuus0rDMmJHa2+9/zCe2daCHb4r
	kyHbbFr8d16VRCinMwtSxYiWrosBZY6LNw0U1gAB1xEMXhKDqEMhfkexnhfsvuorWwA54bVUF7t
	cpprl3sEzUCAT/HB46c7euF+D/0I9Qgo=
X-Gm-Gg: AYBFou28Wum/RFytcV+Cor5nHElX+qMpgdg0MNHkaw1+Tr3+05tBKXvRve0eRxE3qaM
	/i48x3EthFLpaRO9SqXXwYNokSKIr/XHvqbXnlkSpdnOHfhBJ5dxniCu/Oh4CbirShfOBsoJvJg
	GkdHMSHose6vt4uUdHomURCc/o7A8LrXnGzmlQE6BuxjcQkXIWI+mzW5Ug2YJnBnuvFJC3zeAwG
	FDNujVEFWfJgiaJ1kT5W05T/q+kINj1ex+p+d9qJ+oH4AckY8MhKv9Gl0yO69mFFTS6ldYJ/DFO
	20Cuc93pR0zkYM448ATkXDB12CO3LWkJww9z99aYLRw7YDAjI0iRxMPere24aUuIKjK9mlQxVj6
	ofppLL00U75sj0ssZT9umtQ83da4/a6AEAT1HsTdY6Nw6b4gMib6h1pEoqUsHhROAI3NfaUTYc6
	/8VW+turNvlHkS0yYRaA816+OL9ZyzCm4NgCHgHabmoeU3zd+hzoo3xPR0E1/AnMG+Ek7yy5Lrf
	X/f08dfRICGkFkqFFp7/T24HOu368x8K0fMzIi3VaZnf1EN7Q==
X-Received: by 2002:a17:907:94c5:b0:c50:576f:b3a8 with SMTP id
 a640c23a62f3a-c50963d9089mr139709166b.48.1794547941457; Thu, 12 Nov 2026
 21:32:21 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110014313.1586633-1-rosenp@gmail.com> <20261112120835.jhn7kbktc6fpcbof@DEN-DL-M70577>
In-Reply-To: <20261112120835.jhn7kbktc6fpcbof@DEN-DL-M70577>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 12 Nov 2026 21:32:09 -0800
X-Gm-Features: AclHuK_Oj6JOWF2brwq_WBXYttccflddgxa3n2BDAOW2bY8VaPvLi0wYucZWSm4
Message-ID: <CAKxU2N-TdAD8uCK5FJ_bNcFDhUggoRSwXVow2dasMSoX-sGAdA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ibm: emac: fix MR0 write in emac_rx_enable()
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik <jeff@garzik.org>, 
	David Gibson <david@gibson.dropbear.id.au>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 4:08=E2=80=AFAM Daniel Machon
<daniel.machon@microchip.com> wrote:
>
> Hi Rosen,
>
> > When an asynchronous RX disable is still in progress, emac_rx_enable()
> > waits for MR0[RXI] with
> >
> >       while (!(r =3D in_be32(&p->mr0) & EMAC_MR0_RXI) && n)
> >
> > which assigns only the RXI bit to r, as & binds tighter than =3D. The
> > following write of r | EMAC_MR0_RXE then clears every other MR0 bit,
> > including TXE, and TX stays stopped until the watchdog resets the EMAC.
> >
> > This path is taken when RX is restarted after an RX descriptor error.
> >
> > Replace the open-coded loop with read_poll_timeout_atomic(), which
> > stores the full register value in r.
> >
> > Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: use read_poll_timeout_atomic
> >  drivers/net/ethernet/ibm/emac/core.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/etherne=
t/ibm/emac/core.c
> > index 1b95b4d5deff..0311131055f7 100644
> > --- a/drivers/net/ethernet/ibm/emac/core.c
> > +++ b/drivers/net/ethernet/ibm/emac/core.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/string.h>
> >  #include <linux/errno.h>
> >  #include <linux/delay.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/types.h>
> >  #include <linux/pci.h>
> >  #include <linux/etherdevice.h>
> > @@ -248,12 +249,10 @@ static void emac_rx_enable(struct emac_instance *=
dev)
> >       if (!(r & EMAC_MR0_RXE)) {
> >               if (unlikely(!(r & EMAC_MR0_RXI))) {
> >                       /* Wait if previous async disable is still in pro=
gress */
> > -                     int n =3D dev->stop_timeout;
> > -                     while (!(r =3D in_be32(&p->mr0) & EMAC_MR0_RXI) &=
& n) {
> > -                             udelay(1);
> > -                             --n;
> > -                     }
> > -                     if (unlikely(!n))
> > +                     if (read_poll_timeout_atomic(in_be32, r,
> > +                                                  r & EMAC_MR0_RXI, 1,
> > +                                                  dev->stop_timeout, f=
alse,
> > +                                                  &p->mr0))
> >                               emac_report_timeout_error(dev,
> >                                                         "RX disable tim=
eout");
> >               }
> > --
> > 2.56.0
> >
>
> I think the v2 conversion to read_poll_timeout_atomic() looks good. But I=
 wonder
> why you dropped the tested line in v2? Was this version not tested? Eithe=
r way,
> the commit message should say so.
v1 was not tested separately from other changes. v2 was not tested at
all. The whole point of iopoll.h is to prevent bugs.
>
> /Daniel
>
