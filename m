Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1E2DC798;
	Thu, 23 Jul 2026 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787846; cv=none; b=KIiUEjH5f/Ukch2T6G7WnCFvGuMkWvsewnZaXUsW1amFo7qosiq4dlC6efRYC9FwpYPViyH3odnhTnXJz6fKTo380H1HfYIS8yzsFwYtyVltGB1BWq1YybO8WhxFVPc0RQ6BKZbmGL9/j4JxI7qWwxfZ3MMVtYnW5ljpZfWirP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787846; c=relaxed/simple;
	bh=tc6srfmfbkX8xKf2ajbh+WN25RTTUHiHpd7j6NCVrhA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=YlLFKUNoYdqOhxc636Scz0SGzPgXEiQPVpVge8oF8ENYsnHWDhxwvq2NThocrA3suB050ewXaRxSB4BVdqsmNhO3ITR0yPYB+o8isR2m3GClUGjujqygo05bT8OFoAm7xgS00gWSiOJvVsCGGuL4KHgO1tVtXDWiuYS4G/qdAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=cKduGRaz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="cKduGRaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784787840; x=1785392640;
	i=markus.stockhausen@gmx.de;
	bh=rMNHjMfCTW2Nqvh5ou6g/SM5X/rutCk/CWReuMCieXc=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cKduGRazuPmcypwAPq1FnNpLbYxPbufEiknBfO4OxO1OwQoNSluL3PPkyZhmJlm9
	 avzJiHi6SX4KblZgzgQiWpEQOAniQN04f2kUeENhgWxHuyxNruPIwFlhWMMo+Wvyk
	 1paYoOxaq8b5iAfOeciu6gC+h70W/MjapjsufwncLd2cnRRwjKQMmDOosLFkd6u/A
	 g0fXwJoVIJM+IgD/EDXoVD5KRkKhEcBF7ZeoJZ3bHrjU6pKSDtZhzLGUpp92YfgvL
	 YriKnzHWP5NZYSJPFIlkyZwg89hR20+2z53eQxvEMBxC+a5Svp5nQXITdrDLvKZG/
	 wqrXZsIJ4CA55QfVZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1wbqe01CsS-00NDkk; Thu, 23
 Jul 2026 08:24:00 +0200
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
References: <20260722062356.12291-1-markus.stockhausen@gmx.de> <20260722062356.12291-3-markus.stockhausen@gmx.de> <ef41a5bc-804e-4a5f-863d-7221fc1ef1ac@lunn.ch>
In-Reply-To: <ef41a5bc-804e-4a5f-863d-7221fc1ef1ac@lunn.ch>
Subject: AW: [PATCH net-next v5 2/8] net: mdio: realtek-rtl9300: Add polling documentation
Date: Thu, 23 Jul 2026 08:23:53 +0200
Message-ID: <009e01dd1a6b$d9726a80$8c573f80$@gmx.de>
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
Thread-Index: AQK/Le43oqC7DF9RxGQXBKOvw8+FqAGoVyPIAknS77u0ltzqwA==
Content-Language: de
X-Provags-ID: V03:K1:iqJ/pO8jO0V6wyPJdtLm56uu9eZuT2IsxRsWJJw6P69Tc2UDILw
 h46hDux+lh6wbLXjz5K8pyDnrUV+0zo0P1/yhZyqe7gDaH/5w+WvZ5t4Lr6iJ4ahJGtMFZc
 2D03IcNQz29tKk5COaojUnZX1QP0BywEgq3eUrKE6dPcM6e0drIsvzkutGZU/HBqWaxY3YZ
 KKrcXopEJSJ4bjcAe8B7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9jUUvK/TKDM=;kfkck3PAq2QsYMNivRTiveM0CVw
 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
 P/GaN5oePyXJQyLUFrRQU

Hi Andrew,

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Mittwoch, 22. Juli 2026 21:09
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
>  Betreff: Re: [PATCH net-next v5 2/8] net: mdio: realtek-rtl9300: Add
polling documentation
>
> > + * Each device has a SMI_POLL_CTRL register. A per-port bitmask decid=
es
if the hardware polling of
> > + * the associated bus/address is active or not. The hardware runs a
tight loop over this and for
> > + * each set polling bit it issues a status check for the PHY. Attachi=
ng
a logic analyzer to the
> > + * MDIO bus of an RTL8380 and RTL8393 gives the following commands (i=
n
kernel notation):
> ...
>=20
> I've not seen anything about what you intend to do with the fact the
> hardware is polling the wrong registers.
>
> The link speed is in register 0x1a, which the polling is not looking
> at. The PHY will indicate the media side is doing 100Mbps, but the MAC
> polling register 10 probably thinks it is 1G. I expect bad things will
> then happen.
>
> I know it is not possible to configure the MAC, but can you at least
> see how it has configured the MAC? You can then make the mac_link_up()
> callback check what the phylib driver says against what the broken
> polling says, and when they are different force the interface down and
> report the hardware design is broken.

Appreciate your feedback. I will sum up the situation and my point of=20
View about the C22 PHYs in this single answer.

Regarding speed detection: I ran a quick test and MAC side 100Mbit=20
detection works fine. So we have no issues there. Assumption is: I only=20
took some snippets from the tons of data the logic analyzer produced.=20
So either the access to 0x1a runs not every poll cycle or the device=20
simply derives the link speed from the default registers. From looking at=
=20
genphy_read_status() I understand that regardless of autonegotiation=20
any C22 link speed can be derived from registers 0, 1, 4, 5, 9 & 10.=20
Maybe Realtek implemented that part of polling in a generic way.

Regarding hardware designs and page handling: I do not know where=20
your information about non-Realteak C22 PHY is from. Maybe some=20
noise about the C45 Aquantia PHYs. We have

- C22 access is only enabled for 1G PHYs [1]
- All known devices run RTL8218 (B/D/E) or RTL8214FC on 1G [2]
- RTL839x gives link flapping when deactivating polling for a port [3]
- otto_emdio_notify_phy_attach() errors out for non Realtek PHYs [4]
- RTL838x polling unconditionally resets register 31 to zero [4]

So we look at a Realtek-only ecosystem. The downstream-proven=20
driver-only page handling patch without any new MDIO callbacks=20
is the lowest common denominator.

Other feedback will be integrated into v6 or I will respond individually.

Best regards.

Markus

[1]
https://elixir.bootlin.com/linux/v7.2-rc4/source/drivers/net/mdio/mdio-rea=
lt
ek-rtl9300.c#L531
[2] https://github.com/openwrt/openwrt/tree/main/target/linux/realtek/dts
[3]
https://lore.kernel.org/netdev/20260629152336.2239826-9-markus.stockhausen=
@g
mx.de/=20
[4]
https://lore.kernel.org/netdev/20260722062356.12291-6-markus.stockhausen@g=
mx
.de/=20


