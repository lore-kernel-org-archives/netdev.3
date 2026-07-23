Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B23DBD57;
	Thu, 23 Jul 2026 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835826; cv=none; b=nZRaUhNhBCv2grGTRd22T6pUxvJvUbGmmpNEzVH/AsA+uNQTLtqMS+XjH2y2L3t55X/NlT1NGvWSgsqlKemE7J87GNwuyyP+0bx96GU/7n4si3izN+KqrLir1pTJSdqSVP6Jd37bD6v51OYSXozet7z4k4ngeE3TIjZH0aHT0ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835826; c=relaxed/simple;
	bh=iswGGNi6TcCJl3ezzYFIVHhUlEtDM5XP8pSG3SdhZww=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=WbhgX1L1OQlgK+2UkIBpEUc0NmGaAlOWdHr5y+87OrQfLxv5kL+UYOjotd62g/XCQGvKMjHt5wLUc0ONUzT/eJ+CvVv34e+PYlDehdGiZ9uH7RJcivzBYdroU7f4esWykabtoGNaeN7qdProU0BdjMCC3A9SdSDYeMIGvJL3z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=NtRuzlu1; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="NtRuzlu1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784835789; x=1785440589;
	i=markus.stockhausen@gmx.de;
	bh=yt0vY5wckX91qJDGAiKvp3b9MaPtgDfkmoixDCvwJZM=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NtRuzlu1vpo0FNR7eDTKTtkKCcI6c/j8owZx1lP7ZGVZY+l8V3dpsopW8IZgiAd+
	 Mya164vo5Ed/c0SSFf2A6Ka9ePK9ce/FDrAiSC7c6P4ry00bxysUG6Yv1P8qFN+Yo
	 TxqYCHzSzcGCJXVaL8/JCzWgYwO3Hulgmfh0+6bERRPlSTUa/4ZwtilEJfmvUTbop
	 0vkg4ySi5plgRDgouTYv/KrnFHEPjPx3DKDwNAzsw+2oJay97861oYYdbP9ul1YhG
	 YdB+NlIzU2EnsQIXfHNpf7cXLGA26uvFxfGzRZ36dqzk3JMXA3EcCUvLmmEmKRjCf
	 ZQPi2CcGpCaVUr4Maw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1wxSbO42vq-00yiea; Thu, 23
 Jul 2026 21:43:09 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de> <20260722062356.12291-3-markus.stockhausen@gmx.de> <ef41a5bc-804e-4a5f-863d-7221fc1ef1ac@lunn.ch> <009e01dd1a6b$d9726a80$8c573f80$@gmx.de> <420dbb03-6a39-4ef3-9cb3-da78401fd4ce@lunn.ch>
In-Reply-To: <420dbb03-6a39-4ef3-9cb3-da78401fd4ce@lunn.ch>
Subject: AW: [PATCH net-next v5 2/8] net: mdio: realtek-rtl9300: Add polling documentation
Date: Thu, 23 Jul 2026 21:43:02 +0200
Message-ID: <005601dd1adb$7d1cc3a0$77564ae0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK/Le43oqC7DF9RxGQXBKOvw8+FqAGoVyPIAknS77sCpcYhcQIdcjnstHGp1GA=
Content-Language: de
X-Provags-ID: V03:K1:Inxb2o4bu7NsbdH4lIuLiezCzItMk19BLe6KEY9o7oBYWiW8018
 TYSZ6gqknOW3hx+Jsh8dx6l8GwNTO21aAP7Zua/euE4ILDov73hnLQP9h/ZeFRyVt54aJ4x
 lx1hu/GSObUf0QkRziGIAR3dU/nAxy8HUBKV9RlpjrVmJrsnyOOi6JByHKqoDvbqgCoNNFX
 4fRG0LTzjG0TqL8J+Tn9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qv65clQw4hk=;NHPAydwOXAKtdaOlkpro4iyp7JG
 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

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Donnerstag, 23. Juli 2026 16:18
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next v5 2/8] net: mdio: realtek-rtl9300: Add
polling documentation
> ..
> Just to be sure. You have a broken cable, so could trigger downshift?

I usually tape pin 8 for these kind of tests.
RTL838x switch side gives (port 8 aka LAN1):

MAC link status:
root@OpenWrt:~# devmem 0x1b00a190
0x00010000

So Port 8 =3D 100 Mbit
see https://svanheule.net/realtek/maple/register/mac_link_spd_sts

MAC force mode for port 8:
root@OpenWrt:~# devmem 0x1b00a124
0x00D71EEC

So port 8: NWAY_EN=3D1 SPD_SEL=3D3 (aka 1000Mbit)
See https://svanheule.net/realtek/maple/register/mac_force_mode_ctrl

PHY view
root@OpenWrt:~# ethtool lan1
Settings for lan1:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
        Link partner advertised pause frame use: No
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 8
        Transceiver: external
        Auto-negotiation: on
        MDI-X: Unknown
        Supports Wake-on: d
        Wake-on: d
        Link detected: yes

Nanopi R5S on other side gives:

root@nanopi:~# ethtool eth2
Settings for eth2:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
        Link partner advertised pause frame use: Symmetric Receive-only
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        MDI-X: Unknown
        Supports Wake-on: pumbg
        Wake-on: d
        Link detected: yes

