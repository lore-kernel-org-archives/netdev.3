Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1B4F6480
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961459; cv=pass; b=J/MxQmkCtODz3wzn86WvG4+ag/BBVwYCNFdid/D2jwfXOSIB3eAzBY3vzGHRrUZe3/H7ah2ir/eYUxNu0S8rnr5AqB6Ywirus2qduQ52BjYTKRruTL9sUUnxcS+6S2TAxuIUMxW1gRM+MZbNTc2T09TLG046jKShD1CEG2Yff6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961459; c=relaxed/simple;
	bh=n5D2qlyDzMHZj5m2y0QbEBL1DRTWhDy15nyyKnkV0Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dilGtV9NhuFviEwbZ1YIrQpEL/bBHhZkKAeXYTyXF7itg9vdbdF5esetAwacFMVBroB2XTPCniazPKjM4ykIi7gsfy7tHDmuWYr9GlEbymab+z6SQnAVbeIXFrnbtJz1kLFAMW1yfnnVzJ4KSrRlzkt+1Euf+ZDdJ5vXuRE4a1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdQr8fSL; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdQr8fSL"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e1b09e0c7so16265966b.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 10:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790961452; cv=none;
        d=google.com; s=arc-20260327;
        b=iwIgpUHht9wXdMUgtzgJMLVrsQKNHi5vL2U0lc+EB3gsC3hd7PaA+7PzOp4VZdSC38
         xbfzh8eIyUXLjkNX312eWDoZNUr66DR2bce16FBzbmPAKQeFLc453VkJGF1em8qdbIoz
         qm98qK5E5BiR9Y7iRFC0hXfU0JVUikjlEjnhMu9TTcVRxweHY4/773kQLta/kMURcJAG
         cw28jwOpg0oGHMX210rMzBADEPHKgc/DmQp69iz3w0QFmjOn8NajSKvH4Dz/qRZoGYui
         18uxPExqeSAAlsKCn/JczgotFy58uOQkzkwJVlYFMznamTDAhzSZOp3Q/sBKFt4FwdpK
         FQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aADe7OTnnLJ+BldvnfgmjEHwTQr8EjDevVArWJMRlrQ=;
        fh=X6pbdfJass06jjZuA/fRA+SLOQVAp4AxGjgZzGhiYHU=;
        b=UTlib6iVRAB9ZKgutwX/0qmUTYPNSAsZZb09M+ro7HJYEyum4oXWdCmWoYDsWjr5UP
         KvJ8SAu6cQk+sYg1MeDVkKVqiWRQ9QjeXZzsQHFwDOi9F1fQv0ER9YwgklndKGiyMVjS
         sOUGhaMKPpxtmNURmbvc5H/K43gEv/3uE4Ut/GfUXKEWt0eQNYlBO41noO9nLzng+7B+
         4oZjeeCTH9TwLHKkfMNIpH57JskeBZkmTPXTqVmSgSmHxWma1htjjEaBESZXgEgROnQi
         LsI0OLYiBGqjnCCppm1Zf9c40j92GMxdQdA0DBZbCqwom+Ow2U8XpICgkdq4ZFFrJUF5
         PObQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961452; x=1791566252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aADe7OTnnLJ+BldvnfgmjEHwTQr8EjDevVArWJMRlrQ=;
        b=RdQr8fSL3Jdb9SEmESXIIejOOgUCMGRwB7wHCAiaE5fH7/wqfWvw2t7l8ITENo6YTR
         Vvo+obLgyey2UYijSi19VUp0EDJ4OAHSgWsDAS28OjX42rTC+rpv9zYlPu9snamZcLMj
         7LNtccD7e7xGlHVT+IV0JiIvIuvTwPQOyyJcpxeN+ksgPN8BD+tHtMmdQlNy+QmVwLem
         cB3M0kloTtcL3NcE9bed7vF4ytfHKPXdYQIkqTkv6C1S8tr+QEiye/5h1HaKiWFr82rn
         RlN35nmzU1RIxhAQm8I5Z40STeHR6AKowS4kzwj5d9tIUQauA+LpDgmYbBb0mewYz3SS
         G4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961452; x=1791566252;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aADe7OTnnLJ+BldvnfgmjEHwTQr8EjDevVArWJMRlrQ=;
        b=ErGgd1AsZRzItZ+f6QyK97tCDTdGakW256Sw9pJfXi8zjLwAKygJ3k3QMtG8njxtCy
         KS51pOxyWp9GDovhd84tKfcLjzlKjkedS1qQtXdqynesRGlJ/RkWpa9jakLsDv43HzmW
         nvnoIoVzOaOnRHmtNaRhkJcLPfUq1EOJNTB0xTT6spLZw55XZrMOw74Fdx5sH8UOa0H7
         BJC3PLMNtlnDuOXjKIsZSj9vGxn536OhJvHk3MhA1LXYvA3oYtMXdiGrg3N7RVs9j55G
         Cje0h03XIJMTpmPabq0ceV0YR5KV5ZJXg6px6TeHFGFskLu0DS6Mm4NLl9nptX7EfdCY
         yZoA==
X-Forwarded-Encrypted: i=1; AKwUvBw992sr7+F6Og7ZbXjHCB0YqSP6/33eL1JM75w8NppQqWGlRus0aTH9MXVnX89JypjxxDip/Ns=@vger.kernel.org
X-Gm-Message-State: AFuF++mA+BMMhtPXPfFosR7gQLhIdz0+M6GobBc8y7pqYEKIokNCm8wW
	muBQkXHJ95dEQuc8t9YLyYVNSAz/dBdiKrAqsWP3nfGWjv5ZbQjCn4mw00v1bevMqNC/T1dkIaq
	vtORTgMz9SZDJW0yE/ufNfscPIULl56E=
X-Gm-Gg: AYBFou0kGiBqWT23ox6nPDXEna2TZmnB8WHKYHxzgXYcECCCv2g8pmDUzmQLIti76Oz
	UPpCmQpnKORNy+Pmkg4mJwmL2CEB7JU+AsgioPAwq4XWwE9FGE7K9VlS/vZhr6FHNyXL7dEQBkD
	KH1QG58rHhabZy/2njF0ue1f5+PHzitdkTVco7ZiFRGqvDn2I+dCGkZVyei9kTOmbbuMfH83+B+
	I7/cn1qJlGqFNu8uPMIrIemVGePlik70W+DVYf4tS9cgAfcuVrM62WLjVo79fNEXlM2XETD2P5N
	Wz3iK3Der5+RfqnhdcfrGVGueYATifEENyv9AGLuxEAH52wJSxN1Ucv1
X-Received: by 2002:a17:907:807:b0:c2d:cd1a:d5b4 with SMTP id
 a640c23a62f3a-c2e4ad79a59mr254697166b.11.1790961452112; Fri, 02 Oct 2026
 10:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929092007.1184843-1-o.rempel@pengutronix.de> <179085726415.434549.9532496066289384267@kernel.org>
In-Reply-To: <179085726415.434549.9532496066289384267@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 2 Oct 2026 14:17:20 -0300
X-Gm-Features: AclHuK8NZ5uQBj7n9NZ_Yv6VXKadyF4TKLxzCFdA2RLurxUCYYwPqDYt8w7wMRs
Message-ID: <CAJq09z6YL-sgRHYe=VCJ3awDM66PH5Bo0q34DynGoVt9+XZyEQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] net: phy: realtek: add MDI-X support for RTL8365MB-VC
To: netdev-bot+sashiko@kernel.org
Cc: o.rempel@pengutronix.de, linusw@kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org, 
	alvin.sipraga@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Oleksij for your patch.

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] Changing MDI/MDI-X on a port that is forced to 10 or 100 Mb/s
>   does not restart the link, so the new setting is not applied.
>
> --
>
> net: phy: realtek: add MDI-X support for RTL8365MB-VC
>
> This commit adds config_aneg and read_status hooks for the RTL8365MB-VC
> internal PHY. They let the MDI/MDI-X crossover mode be forced through a
> chip-specific control register and report the resolved MDI-X state to
> ethtool.
>
> > diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/r=
ealtek/realtek_main.c
> > index 3b3352e2cdc6a..e14960192e791 100644
> > --- a/drivers/net/phy/realtek/realtek_main.c
> > +++ b/drivers/net/phy/realtek/realtek_main.c
>
> [ ... ]
>
> > @@ -3058,6 +3068,74 @@ static irqreturn_t rtl8221b_handle_interrupt(str=
uct phy_device *phydev)
> >       return IRQ_HANDLED;
> >  }
> >
> > +static int rtl8365mb_config_mdix(struct phy_device *phydev)
> > +{
>
> [ ... ]
>
> > +     return phy_modify_changed(phydev, RTL8365MB_VC_PHYCR1,
> > +                               RTL8365MB_VC_PHYCR1_MDIX_FORCE |
> > +                               RTL8365MB_VC_PHYCR1_MDI, val);
> > +}
> > +
> > +static int rtl8365mb_config_aneg(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +
> > +     ret =3D rtl8365mb_config_mdix(phydev);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* The pair assignment is only evaluated while the link is brough=
t up,
> > +      * so renegotiate if the crossover configuration changed.
> > +      */
> > +     return __genphy_config_aneg(phydev, ret);
>
> [Severity: Medium]
> Does this renegotiate when the port is forced to 10 or 100 Mb/s?
>
> When autoneg is disabled and the speed is below SPEED_1000,
> __genphy_config_aneg() returns early and drops the changed argument:
>
> drivers/net/phy/phy_device.c:__genphy_config_aneg() {
>     ...
>         } else if (phydev->speed < SPEED_1000) {
>                 return genphy_setup_forced(phydev);
>         } else {
>     ...
>         return genphy_check_and_restart_aneg(phydev, changed);
> }
>
> genphy_setup_forced() only calls phy_modify() on MII_BMCR. If speed and
> duplex are unchanged, __mdiobus_modify_changed() skips the write. Nothing
> then restarts the link: there is no ANRESTART, no soft reset and no power
> cycle.
>
> For example, take a link that is up at a forced 100/full:
>
>   ethtool -s <dev> autoneg off speed 100 duplex full
>   ethtool -s <dev> mdix on
>
> This goes through:
>
> phy_ethtool_ksettings_set()->phy_start_aneg()->rtl8365mb_config_aneg()->
>     __genphy_config_aneg()->genphy_setup_forced()
>
> PHYCR1 bits 9:8 get updated. According to the comment above, though, the
> pair assignment is not re-evaluated until the link drops for some other
> reason. This part depends on the hardware behaviour that comment describe=
s.
>
> In the meantime, rtl8365mb_read_status() reads the new mode back from
> PHYCR1 and reports it as mdix_ctrl. That no longer matches the pair
> assignment actually in use.
>
> The eth_tp_mdix_ctrl description in include/uapi/linux/ethtool.h says:
> "When written successfully, the link should be renegotiated if necessary.=
"
>
> Would it help to handle the forced case the way marvell.c does? That
> driver calls genphy_soft_reset() when "phydev->autoneg !=3D AUTONEG_ENABL=
E ||
> changed".
>
> > +}
> > +
> > +static int rtl8365mb_read_status(struct phy_device *phydev)
> > +{
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260929092007.1184843-1-o.rempel%40pengutronix.de

I tested this patch and tried to reproduce the corner case Sashiko pointed =
out.
My device has a RTL8367S switch, using a straight-through cable
directly connecting lan1 and lan3.

# 1. Force speed to 100/full and disable autoneg on both ports
ethtool -s lan1 autoneg off speed 100 duplex full
ethtool -s lan3 autoneg off speed 100 duplex full
# 2. Establish a working link by setting MDI-X on lan1 and MDI on lan3
ethtool -s lan1 mdix on
ethtool -s lan3 mdix off
# (At this point, the link is UP)
# 3. Force MDI off on lan1
ethtool -s lan1 mdix off
# 4. The link goes down as expected
# ethtool lan1
Settings for lan1:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  100baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 3
        Transceiver: external
        Auto-negotiation: off
        MDI-X: off (forced)
        Supports Wake-on: d
        Wake-on: d
        Link detected: no
# ethtool -s lan1 mdix on
# 5. and it is back up
# ethtool lan1
Settings for lan1:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  100baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 3
        Transceiver: external
        Auto-negotiation: off
        MDI-X: on (forced)
        Supports Wake-on: d
        Wake-on: d
        Link detected: yes

At least for me, I couldn't reproduce any issue.

Tested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
