Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794330236;
	b=No1VEs8HR4DsiU8+EAvJBlZxRv0iL51ke+cb0ucJArW00vTT5jy4qFW8lLiSA3L1Prhe
	 V1kqcpML019AdrKeQ160BaHBnAv97MGWDsWr4bQnYq6nZTlMzpIzSzdzMghXateZYOJYA
	 u5otJcVXChsrIcL/jo4IZvt5/PPnoqU50j+4g0Oxx8jTtiU1wnLeYBxviv/fHCfZDXA1I
	 lXSjX+9pW0Dayirp7QIgPvt0ioEbsLLr/CI7g/MwXWiDYjJY3/bl9oPvZyiVflnp1OtOA
	 15Iq4y5dUtQLyFuQB6UXLAMZhBbZZ9pdiQ7y6TDC2TDbSs+GY9b1vr+k783A2yOs4Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hw7I9hsZ96oGDaDIXsGw69ed3kXOBiJKDxRNYwwzkh8=;
	b=AjVa6xCg34oE/PsGJf8ZFXImgRFRFT6hvjYCwF0o6CtHFrUz1m6nZdzc3GOEZsYhFZIM
	 qo0wbnc1xJXByI7DyAHqo6NK87egGbznPkG9E62wlEtSLTjNotmIKlEwR2yxhPzSnjoDe
	 s4qC8Z+o3evhE5n6p4E+k8yH+TbgEVgW/x6ChsMOZ5vuGRrxZUHe3bicex96nJDqmzRmV
	 rDZNMNX8TC1P150MlxjIj078ShubggKIiWTK4dzcdVzwfgI1mB9waklS5kz1EDuZPC0iU
	 c+pSq+Urr/9rMYUA8KvMonLOh6RFFQmJz5QugPAzvNMOaJ7FpFpBXkhzlemKZdFtP0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+xX50Mf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1F60A2619
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DC1F60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+xX50Mf
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9999f21f617so607127241.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:03:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794330234; cv=none;
        d=google.com; s=arc-20260327;
        b=XcvtNyqMf+rpfzeqXify60tTrD0LKZyXxXPvYOId++x4wlc6POqY8Fuy+nvmfq9uuo
         d/5saxABwVsvIUgr0muPJtNkc95oCYYYQ6uBxKwErEkZfmfTuCCPFV5c8dXqplrwVJKW
         57MmxyJ/FSp9uxAGbCHg8GNiAmhXmHrqJ77o8g6S9UWiDZ4mTtmJla7Rg9/Y2jIIfRLy
         qtI57ddOgt6jswEn9GFleEnfT5kn3z71Rk7IF8JSOg3Ty9DrCeS9Q2Y3DwwvRS9G26co
         kskg5LvtCT3D9zCYv5UsJibjY8bTt/uHbUt5iDALpvQhHmc+GCkaqs/mUKi1a9JZowLd
         qN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hw7I9hsZ96oGDaDIXsGw69ed3kXOBiJKDxRNYwwzkh8=;
        fh=o7xh9sEkgEjxA+KVvVnB3nN1ndcjWNY2Sc2YJgMXNMI=;
        b=ZBOgv5clcboUSzD04y3BDnB2su6Mpwk/D6COR+d7zDVyqOUS6X8o4fFeKI9N/IBhaq
         KC/9TyhVGqHZ+2uu2BMaqa3lYD67TeT6UknGa4R/1Es5cNsFFbo9qnOhxSUdC4ljLZqA
         GikVelg4EvXq8KHof5RgLy8J4uzlt40HdXZI1exE7FOdlEdA0VPXZblV+RqpZqleJyw9
         gu6qAdrWUzhIkuwRkvciU2MijFaG7q+sbW7cM8sXcE/jqH/BuWPaLWwwgvpAeTLnqfpB
         44Y9S4WbMuSzHahWba/L/X7ZVzJeigfEmszlzeY/Usi8AwjdhPTAq1xAibHfT6ysO52k
         hIKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794330234; x=1794935034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hw7I9hsZ96oGDaDIXsGw69ed3kXOBiJKDxRNYwwzkh8=;
        b=C+xX50MfFTGRaLCaw9FCaInNiqow40dLU19oaQBavHjb+6XrBt6q5sKQHiuEugVcVF
         6dCjelwB8xYfoa3CzbED4beBrLsGTMseiC/8fr5bPwBJZvsrNT06rIAAS8neYM7BHGHM
         P3E351uwr4bel1Dc9qVMvfrOfa1tGbBnH41QTdLlmpkUE2s1pag8FS5cZDhI00c0hdxo
         Qm5TXecpCjQ0ZcYq9oHYFNQUxaL0JkvhC+OHpd/YOL6+GCN+lG3WioxepeUWRo7Fp+dv
         fJowupWxKyXx+iyOsHP0LDloYU6lidBpKgKh2GVx9b69lwqS7z892ojtGlMU8RzePXeS
         r6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330234; x=1794935034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hw7I9hsZ96oGDaDIXsGw69ed3kXOBiJKDxRNYwwzkh8=;
        b=twsd+e/QT2mxS8WheWG/XX4bVfmITYwLuxk1zpdzbP6f5++rZq+vyKE6K9ELlyuKhz
         57qAuAKjGbjRz34gJAw5+ksaqqHfI4bZ/mt1WGZ2xQO4k2lh7VPth90fIcrcQ1UjqvsY
         sz1vnX7QGa0+qvuNRPjI9wEeRXcR9CSEg6IbA0yLkIW6laNTTS0GsetsAKYGDHpzLpuR
         w1d4Y7nVE15Y0f55zWRvIqJGtNTq/xx/9K3Ng9x3NUwCU1i6IOAEZgidJ1YiCVT3MHbO
         wj/rpgPDtpgi6NqlHTAFRUlLhN4fJNPo/jKkZuFuz1VVU6NxMb+SfnLuHJ+o4xKOf8gm
         Za3A==
X-Forwarded-Encrypted: i=1; AL+hErHNjo3B+kBeutPPgExJGStNsAaRqstxam0X2qVPtEjJ7u1edwaG+IuV6TUwau2vxLrN3bX8JeQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UIYkbaT4QBz3nUH7wywQYrdFeCv0VUTuIqQNgaw537z0jt2RL
	ELkrDeSPmN2pb70brLlUMe+sRNko39mEqqv541qbvn8ladUBI+fV2eGmXxU7S/5/ACXL6GGsXlU
	OIgwVXFC9nEDbmWZAy01Xb1GET5joi+k=
X-Gm-Gg: AYBFou2EbTV5klKIId0YvU1bMCLmpflJ3HGwxhTQj2Wt7NERbQwgdaSZqRhiV+UBb1b
	QR26qmmxayFsmD449vsrExArQ4Xkv0ey0OTOt6g4cb7ELL89JxawX4D7mBqJB5qRDegnWIfwg8P
	HCevk0A0ZF377RGaAHkfcdBbW9ARhx6phowOAd3T5LJ2NoEemQmFWtCfPzaw7uxxFXFUTfA9+Lw
	gBbQ3UHhjaLp/uwRICtoGHpVqHG+yFc/EkyK3em5W3PvXpbJK4MFH1ifcDIQJP4YfRg5hvaST09
	y/kMjrWPAG6GLdJ9TtnL9U/Kli5tz8nzaiN8+jLkd3tAE3ncdbTUF0+Je/uIzsRr6XZXjJS5W0S
	soUftmtRyVjnCRo58SNWr6kWMD2Ye9UWNEPktLGXQbbhpjyHnr0J9+MXfVsxvv+1AoU32FP8gk0
	zINqcmak+RUTjmSSP6gcGGWo0kcmgm1LxGvVKP9Yi5h92c5lSKc94YZaH+kDT7zTOLJTVI6nVbq
	lM90sgEV61O+GPFkYnQX5cbE/0ZqA==
X-Received: by 2002:a67:e103:0:b0:7cc:2152:4f72 with SMTP id
 ada2fe7eead31-7d301ab17a8mr1041991137.1.1794330234180; Tue, 10 Nov 2026
 09:03:54 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4@gmail.com>
 <20261109-submit-acx00-phy-stats-v1-v3-1-fbc6327c5be4@gmail.com> <348f19e7-120e-4b41-adab-be016c7a6083@lunn.ch>
In-Reply-To: <348f19e7-120e-4b41-adab-be016c7a6083@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 10 Nov 2026 10:03:41 -0700
X-Gm-Features: AclHuK9Z8HBeiil6sej5BA1Wz9f4abX4Dg7pGqCo1nUmbA_AdXdQ7J-TZIt3lPw
Message-ID: <CADvTj4p6q_-QT1R6CAVnhnWerzF3qsPhi8rPTcZBjbrbRCdtnA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] ethtool: add PHY receive frame and byte totals
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:42=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Nov 09, 2026 at 07:48:32PM -0700, James Hilliard wrote:
> > The generic PHY receive packet and byte counters describe successfully
> > received traffic. Some PHYs instead count all received frames and bytes=
,
> > including frames with errors. A frame error count cannot recover the
> > number of successfully received bytes because damaged frames have
> > different lengths.
> >
> > Add optional receive-total counters to ethtool_phy_stats and the phydev
> > statistics group. Count frame bytes including the Ethernet header, padd=
ing
> > and FCS, and excluding the preamble and start frame delimiter. These
> > counters describe reception at the PHY, before MAC or host filtering.
> >
> > Append the new attributes so existing statistic IDs and their meanings
> > remain unchanged. Publish the names through the existing statistics str=
ing
> > set, and retain the unset-counter convention so drivers can report eith=
er
> > set of counters independently.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  Documentation/networking/ethtool-netlink.rst | 16 +++++++++++++++-
> >  include/linux/ethtool.h                      |  6 ++++++
> >  include/uapi/linux/ethtool_netlink.h         |  2 ++
> >  net/ethtool/stats.c                          |  8 +++++++-
> >  4 files changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentati=
on/networking/ethtool-netlink.rst
> > index eba226c79ec3..5528d0f7afdd 100644
> > --- a/Documentation/networking/ethtool-netlink.rst
> > +++ b/Documentation/networking/ethtool-netlink.rst
> > @@ -1665,7 +1665,7 @@ the ``ETHTOOL_A_STATS_GROUPS`` bitset. Currently =
defined values are:
> >   ETHTOOL_STATS_ETH_PHY  eth-phy  Basic IEEE 802.3 PHY statistics (30.3=
.2.1.*)
> >   ETHTOOL_STATS_ETH_CTRL eth-ctrl Basic IEEE 802.3 MAC Ctrl statistics =
(30.3.3.*)
> >   ETHTOOL_STATS_RMON     rmon     RMON (RFC 2819) statistics
> > - ETHTOOL_STATS_PHY      phy      Additional PHY statistics, not define=
d by IEEE
> > + ETHTOOL_STATS_PHY      phydev   Additional PHY statistics, not define=
d by IEEE
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >
> >  Each group should have a corresponding ``ETHTOOL_A_STATS_GRP`` in the =
reply.
> > @@ -1683,6 +1683,20 @@ by ``ETHTOOL_A_STATS_GRP_SS_ID``. Complex statis=
tics (such as RMON histogram
> >  entries) are also listed inside ``ETHTOOL_A_STATS_GRP`` and do not hav=
e
> >  a string defined in the string set.
> >
> > +The ``phydev`` group provides separate counters for successfully recei=
ved
> > +traffic and total received traffic.
>
> You need to be careful with naming here. This is a
> kAPI. phydev/phylib/phylink are implementation details, a set of
> helpers which some MAC drivers use to implement PHYs. But MAC driver
> can implement PHYs in different ways, and don't need to use a phydev.

"phydev" is already the name exported for ETHTOOL_STATS_PHY by
stats_std_names[] in net/ethtool/stats.c. That documentation change
matches the existing group name; it does not rename the interface.
The proposed counters describe PHY reception independently of how
the driver implements PHY support.

>
> ``ETHTOOL_A_STATS_PHY_RX_PKTS``
> > +(``RxFrames``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES`` (``RxOctets``) cou=
nt
> > +successfully received frames and bytes. ``ETHTOOL_A_STATS_PHY_RX_PKTS_=
TOTAL``
> > +(``RxFramesTotal``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES_TOTAL`` (``RxOc=
tetsTotal``)
> > +include frames with errors. The total byte count includes the Ethernet=
 header,
> > +padding and FCS, but excludes the preamble and start frame delimiter.
>
> And what would you call it when the counter does include the preamble
> and start frame delimiter?
>
> Take a step back. Just because this PHY has these counters, do we need
> to support them? And what happens when the next PHY comes along with
> slightly different counters? Do we add them as well?
>
> It is vendor SDK syndrome. The hardware can do this, so lets expose
> it.
>
> What is your use case here which justifies these specific counters.

The use case is the same traffic monitoring and error diagnosis served
by the existing PHY packet, byte and error counters. The difference is
what the hardware measures: successful reception versus total reception,
including frames with errors.

This appears to be a recurring accounting model across vendors, rather
than an ACx00-specific definition. TI's DP83TG720 provides another PHY
example, which is why this series also updates its existing receive
packet statistic [1].

There are examples elsewhere in Ethernet hardware too. Microchip's
LAN9303 explicitly distinguishes received bytes including bad packets
from received bytes in good packets [2]. Those are MAC counters in a
switch, not PHY counters, but they illustrate the same distinction.
That supports a shared total-versus-successful abstraction, although
each device's exact error and byte-accounting rules still need checking.

The v2 review identified that ACx00's inclusive measurements do not
match the existing successful-only fields [0]. The successful byte
count cannot be derived by subtracting an error count, because damaged
frames have different lengths. The proposed fields preserve that
traffic accounting without changing the existing fields' meaning.

For the preamble/SFD case, a counter including those bytes would not
match the proposed definition unchanged. A driver could use the field
only if it can accurately normalize its measurement to the same
frame-byte definition; otherwise it would leave that field unset.

The intent is to represent a recurring measurement with consistent
semantics, rather than add a generic counter for every variation in
vendor register accounting.

[0] https://lore.kernel.org/r/20261109235715.1618218-1-kuba@kernel.org/
[1] https://www.ti.com/lit/ds/symlink/dp83tg720s-q1.pdf
[2] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductD=
ocuments/DataSheets/00002308A.pdf

>
>      Andrew
