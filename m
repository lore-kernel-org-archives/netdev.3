Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609803;
	b=e4Fisj+AY+z8TWbrJ34hDHeTTB2Pe00gZY+6qzW9YxTnzJXowBefCqVBTSDcfAtkGOBo
	 vyKKDVVu8TNiFlxBXnGrWehDfDsziyvMfLWBzqcANyYFLEgNm1r1sPDT4IJZc8LLxRHuW
	 ALwUVaPKo50wLazE6+T40Ar8FkFO/iDsmcQ90+Kt9BHHYhN5HbVZW0hL4ksWZUb3T3E6m
	 k1RGwpVDLl4+sFCRoUlAnESmm/kCgHId+SebRy6SOB6f6OHZeSFN2pEhEUk/WqmuBzjV7
	 44DW7vFZTcoLqGNkbAIRRhCL6oOkBttNrtPw8ykXh3LI3YsXcQAIUzgugul0V607nug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Dxs3zEoSbcXfyuXkzQruDQFVj4t8rdiDEgXMtvqtLxY=;
	b=upOV0rJVFwgw7VCG/ieg+oTahbrMF615mIdrhpI55CU+8MkBhJfi9gJgyGPpkpIbQIhi
	 XinZeNEODoSaXC4jz+YnMrcanxwF/hNaJm+WgE9/A2QxvIweuh1lPANCDdxtq7N/ZgKTN
	 efb2mNSgZ3n/Ji1EcDNC6rHGURFosG1OPInsm4t1LO1Ra7I4f+yJMw1xhW9hx4a90PLla
	 XIE6m/jigoeST3aYJab9NxQjKHnNfgv1f8cpc03ObOs8B7l7GpmpcTS8ZuAQ5f9H0KNjM
	 8hqY3JttlQQ/P/k/yufqasD9K6iyM7C3km3vf8d2AWELvzyniOrDqb9k3y/a92U06+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lXNS6fzM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9E606A33A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 22:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53A9E606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lXNS6fzM
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ece6c1d1cbso467504e0c.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:43:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794609799; cv=none;
        d=google.com; s=arc-20260327;
        b=jC1KFpfinE2U7Vt/v/zCB4cYEHUDYSfmqeyjA+hVWqGps3cfil4rZCUBovCn+8arSB
         ZDe4ln+3FJdsATxKgogthAdiakUfr84B43zOyrWMy/iPdWciBKfrZULhFT8px97JDwMm
         RYyUhoHyaxWcl7bgJDmAt7f0eOxdHkHHKKiyDh8ET4VuDvyCu+yTw9O7HhLf33KPSViO
         YWyfm+wP+IeCwu7VDz/spEdkFubh1F1gX47hjAOZT2sCW5nVvP3OdB6GOBZBkFYZKtl6
         aJ0guywzJ6W67i7NSMpYLKVEGyb4+BmvOUoLdkdKNu0Ga3HBlsKHxpc9i4vKdvVI+ud5
         oehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dxs3zEoSbcXfyuXkzQruDQFVj4t8rdiDEgXMtvqtLxY=;
        fh=j+bX9ovjuhiLO9ZXjbHQx1qL1hH/OjM/RH/6DZlZqP0=;
        b=bjifEI7I1f2+oQprxd+rDX+cayWo6MLorphSrAgmK1yA3Aq7DKDrR5spOkLduDGPUS
         bMTD0dYtRMKWnZyCN5rafxPVAZCkXmVYLGZVX4dxzkqIWaXGDE8/Haq9H0vg885e0Nor
         uRH8SjXNlwQd54GcJa4GqtMCf+psqtQC5Qczfdv34eVON9Zkqtvw8qzt6uKuW4Lee5VR
         epdYmD3hWPLpFxybRSXA5bc2alaSPHidt2FornuC4C/9YppxBnxb1lI7uHPKkmb2Oe7b
         ie6TmsOo7ESaG228Pe+uIjo8jUBKW4T8fxOTJkretozGK8jcNlki74ksGCbauApcfzJN
         0xqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794609799; x=1795214599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dxs3zEoSbcXfyuXkzQruDQFVj4t8rdiDEgXMtvqtLxY=;
        b=lXNS6fzML+4ms8KRhgrDko+jDoeFLKoP7/8V9vvA0kngy5RONQDDaSWlykfzxvWBqy
         ba3/RQkLsh5FJA7UziUKYswTcUoLp64Sprh1UKYouGqpRI4Zo52eTG9fTjA419TGXujq
         ioxmWNLa+9j3Thyf7jRbQTEXHmqlt/zskzknrOjWG26iWAH1Jm868zz2hs9QpgTc4UMh
         7aTNKsMd9Fd+lzUjNUj0iqIKUs2rHsbmTDUJJOhbyOKm8W+bzoO03dOKoulBUbuBt+Wm
         PbaO0hG5DWySwdQCyKK6qRZ1lJwXcgfoAIi/koTLJVlNNaqY5YaC9c/u23zPaw4bZOv7
         18Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794609799; x=1795214599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dxs3zEoSbcXfyuXkzQruDQFVj4t8rdiDEgXMtvqtLxY=;
        b=vc3eRbzyQnsWVhI2aPBn8FHw7eKfr7JmO8QfGGBUXw+oC4uxs4hlH3NtbbXRr6ydpk
         NPqhc3DuCi5485gIt6Gfwv1bCNh1SOK3bBtYnJPKGJa++nH699KkdJ7PHAuPvLAP4+p2
         VQJLIBd6Gwv+4uv42eYhi/0UtLCIetIvxURGdXoNL04fDyf4ickn7184rnCbptrfHdiK
         Uo87xw56QPKDytKsExUFt3cVZVgRKOAXstE8YvDLSyaoV46MJzFWcho5nP+yraVxQfRX
         oM+eCZuk0WXIOVAmzwc8s04wK7rImFggwuA20q1zPZF+7vlxXRPYbFMc/CaLHNgg5Hf2
         YF5A==
X-Forwarded-Encrypted: i=1; AL+hErEYSUL2FQC2gcsTKU34zyPesmqRd25XgCPc4cCPetFUMTwJtUQiHglH2PuAm2kGyYc9Tj0D0UA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eTgL2zFx7w4osSRLvDQ+XDjWKaqAFdNcajvAmYYN3UY8whElE
	aU5TTlqXoE92Z3iHmJ2AbGB2ReDXEifO7pgTR8oq1UCmXzqeOWa4gdkIjEDh2iaAaObZyi20zc5
	74w76yGiUOyHmZWJJTDls8kXbmqVRES4=
X-Gm-Gg: AYBFou0hlmpfEV3T7+v5SRmxaIoec44xRxxEYR+Aeuw6WpZZqDJfD5mx/crcovbBZNI
	xlmZ9aJO17VVA0CrM1GTeCvruq/t//F5ngab4iK5qBR7SqkYRKSykOu5a5EJLDvu5amvsgP2zUv
	yZi3RUELecDdLO3pqlUNxxdsBX+ADWtgV58z6d0vwdCNuT1sv4Trq27Nssj2F44KQ6hqvfFn92n
	Y2LhVjnDpSgc1eFNpyzop1lyOs8qwx2PIC0XCItI7Tr7/lbGEof2YuY2jnZNzyQNDJccWxI1zVj
	Bvu5JwrJ2mm4O6dGPWOzoyHtyzi7PziHfQuzX14VzGN3j+PguDTrEDW50kxASI8ZidNHuaUIJ9e
	1uEgMke9/bTcbG25cPYzb6fCcxxBeYZYu5BgvOB5vBGCuGVVJU96t3P4iD5/F643xGhlW06j63g
	ftAy6QMcxcHnb/mK7cUBbJ5Hq+qHLsqLAnuVYMhZ1KhK2Le8kYFXbtJwoGyoI0f3PtITmqkJS/W
	bxEqdrpb4Bat5G/btQdvjo/Eh+T/w==
X-Received: by 2002:a05:6102:84c2:b0:7cc:ccb:ce5a with SMTP id
 ada2fe7eead31-7d64d89cdabmr1053049137.28.1794609799139; Fri, 13 Nov 2026
 14:43:19 -0800 (PST)
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
 <20261109-submit-acx00-phy-stats-v1-v3-1-fbc6327c5be4@gmail.com>
 <348f19e7-120e-4b41-adab-be016c7a6083@lunn.ch> <avdaBgWc5tpMhtqF@pengutronix.de>
In-Reply-To: <avdaBgWc5tpMhtqF@pengutronix.de>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 15:43:08 -0700
X-Gm-Features: AclHuK_y5r8zy20zeheg5z5NyDwRpxzoSdoNuCWdWvLU_7paTeMna_98mFT74a0
Message-ID: <CADvTj4q+QuSOre_Z7Kq286fLqrLfTq26oBCarDzx=wrc7Zz_WQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] ethtool: add PHY receive frame and byte totals
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 11:42=E2=80=AFAM Oleksij Rempel <o.rempel@pengutron=
ix.de> wrote:
>
> On Tue, Nov 10, 2026 at 05:42:33PM +0100, Andrew Lunn wrote:
> > On Mon, Nov 09, 2026 at 07:48:32PM -0700, James Hilliard wrote:
> > > The generic PHY receive packet and byte counters describe successfull=
y
> > > received traffic. Some PHYs instead count all received frames and byt=
es,
> > > including frames with errors. A frame error count cannot recover the
> > > number of successfully received bytes because damaged frames have
> > > different lengths.
> > >
> > > Add optional receive-total counters to ethtool_phy_stats and the phyd=
ev
> > > statistics group. Count frame bytes including the Ethernet header, pa=
dding
> > > and FCS, and excluding the preamble and start frame delimiter. These
> > > counters describe reception at the PHY, before MAC or host filtering.
> > >
> > > Append the new attributes so existing statistic IDs and their meaning=
s
> > > remain unchanged. Publish the names through the existing statistics s=
tring
> > > set, and retain the unset-counter convention so drivers can report ei=
ther
> > > set of counters independently.
> > >
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > ---
> > >  Documentation/networking/ethtool-netlink.rst | 16 +++++++++++++++-
> > >  include/linux/ethtool.h                      |  6 ++++++
> > >  include/uapi/linux/ethtool_netlink.h         |  2 ++
> > >  net/ethtool/stats.c                          |  8 +++++++-
> > >  4 files changed, 30 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/networking/ethtool-netlink.rst b/Documenta=
tion/networking/ethtool-netlink.rst
> > > index eba226c79ec3..5528d0f7afdd 100644
> > > --- a/Documentation/networking/ethtool-netlink.rst
> > > +++ b/Documentation/networking/ethtool-netlink.rst
> > > @@ -1665,7 +1665,7 @@ the ``ETHTOOL_A_STATS_GROUPS`` bitset. Currentl=
y defined values are:
> > >   ETHTOOL_STATS_ETH_PHY  eth-phy  Basic IEEE 802.3 PHY statistics (30=
.3.2.1.*)
> > >   ETHTOOL_STATS_ETH_CTRL eth-ctrl Basic IEEE 802.3 MAC Ctrl statistic=
s (30.3.3.*)
> > >   ETHTOOL_STATS_RMON     rmon     RMON (RFC 2819) statistics
> > > - ETHTOOL_STATS_PHY      phy      Additional PHY statistics, not defi=
ned by IEEE
> > > + ETHTOOL_STATS_PHY      phydev   Additional PHY statistics, not defi=
ned by IEEE
> > >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > >
> > >  Each group should have a corresponding ``ETHTOOL_A_STATS_GRP`` in th=
e reply.
> > > @@ -1683,6 +1683,20 @@ by ``ETHTOOL_A_STATS_GRP_SS_ID``. Complex stat=
istics (such as RMON histogram
> > >  entries) are also listed inside ``ETHTOOL_A_STATS_GRP`` and do not h=
ave
> > >  a string defined in the string set.
> > >
> > > +The ``phydev`` group provides separate counters for successfully rec=
eived
> > > +traffic and total received traffic.
> >
> > You need to be careful with naming here. This is a
> > kAPI. phydev/phylib/phylink are implementation details, a set of
> > helpers which some MAC drivers use to implement PHYs. But MAC driver
> > can implement PHYs in different ways, and don't need to use a phydev.
> >
> > ``ETHTOOL_A_STATS_PHY_RX_PKTS``
> > > +(``RxFrames``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES`` (``RxOctets``) c=
ount
> > > +successfully received frames and bytes. ``ETHTOOL_A_STATS_PHY_RX_PKT=
S_TOTAL``
> > > +(``RxFramesTotal``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES_TOTAL`` (``Rx=
OctetsTotal``)
> > > +include frames with errors. The total byte count includes the Ethern=
et header,
> > > +padding and FCS, but excludes the preamble and start frame delimiter=
.
> >
> > And what would you call it when the counter does include the preamble
> > and start frame delimiter?
> >
> > Take a step back. Just because this PHY has these counters, do we need
> > to support them? And what happens when the next PHY comes along with
> > slightly different counters? Do we add them as well?
> >
> > It is vendor SDK syndrome. The hardware can do this, so lets expose
> > it.
> >
> > What is your use case here which justifies these specific counters.
>
> I have the same question. James, your answer mentions traffic monitoring
> and error diagnosis, but not a concrete problem on AC200/AC300 that these
> totals would help with. My guess is a receive problem that another driver
> for this PHY already works around.
>
> Rockchip's vendor driver for the same PHY ID (RK630 and RV1106) reads the
> packet and CRC error counters from page 9, registers 0x1b/0x1c and
> 0x1d/0x1e:
>
> https://github.com/rockchip-linux/kernel/blob/eeb355823a794954737fd75820d=
fccdab4c57af6/drivers/net/phy/rk630phy.c#L430
>
> The vendor driver does not export them. It polls them to tune the
> receiver. If there is a signal but no link, it switches to a second
> analog setting and checks again. It switches settings in two more cases:
> too few frames arrive, or more than 15% of the frames have a CRC error.

Allwinner applies efuse-derived trim on both AC200 and AC300 alongside
hard-coded PHY register settings. AC200 uses one fixed set of settings;
AC300 selects between two sets using efuse bit 9. These are applied at
initialization, rather than adjusted from live packet/error statistics.

> Its comments call this "Long network cable parameters". It also changes
> the RX detect threshold depending on the temperature.
>
> Do you see a problem like this on your AC200/AC300 boards? If so, can
> you describe it? Then we can decide whether the driver should work
> around that problem.

I haven't reproduced that problem or tested long cables and temperature
extremes. Temporary register changes on AC200 confirmed that candidate
tuning fields are writable, but not that their analog meanings match
Rockchip's. Adaptive tuning could be relevant future work, but I don't
yet have evidence that ACx00 needs the Rockchip workaround.

>
> Oleksij
