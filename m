Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503AA3BBFD8;
	Mon, 17 Aug 2026 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998357; cv=none; b=ukLZDzeXyT+wZzzXn2QvGV4bCFeBdQkBKrg2iS1EaOJtrAxnH9wvY6AySKqnqnzWlKDj4N29/oh6SM84uDZgaYmOsOACw2l2CIBXjjmokeP6kCwI/aQaWvNcMNSeggwFjskI9jaIprPjANAhnX18SsauwvbYQ48qk+pg5ZoWXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998357; c=relaxed/simple;
	bh=AVnx3DAdj6Cyi14fjjQHWQ/swKlwcYzl1ibk0O3fgG0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=L2LxeiQ2/bRcGHikKexBW6ExwLpc9bJSJL5K3U7eaF/al9rSFh6lWKCjCz9XklRYXeVbGoF6lFrqWLpikZE33de5Mf6egkloDkd5zwYRZIXugUzgidtTr3/wj5F7ymbqKzToHviBVEh7cIzpQsmxvTa1Il+4DPPzo1c7wZsPozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=TR3jQDmK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="TR3jQDmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786998352; x=1787603152;
	i=markus.stockhausen@gmx.de;
	bh=3XGkZOhwZAJdcT9ht8yn4Pv3NFHopPeAvBI13iiCrjc=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TR3jQDmKiJygepIolZPfTdA91FaUkZ/AuiowUVXoJPay2qMJLQgmay7OCPVg7NoW
	 HBKmSMZfFsFz1iXOa8zJ3f9UbW51A/daHjP3GW0JBy3qVUvVn/0vPYqxkzSHwG/b1
	 4GIhl9Kg2448pyWTdr1cT4ak8eaE5qCSrmRb7PP5czGSB3amWgV/A02bp7p3saCHy
	 FzDFCR34aPpLA+TCS0+GK6a7iMS38jpKlnBvuU4KpgYzK0qsML/31eMPKqqYcBgWB
	 07qMraswvG0jUVdBcYG79MosUb/V5DuVxWxImIOKP61hyaQw+N33NpSdyZeBa3rly
	 jdr0N0IXp72VL8pkvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBm1U-1x87873A8i-004giJ; Mon, 17
 Aug 2026 22:25:51 +0200
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
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de> <20260817162632.1208891-11-markus.stockhausen@gmx.de> <cf8bdf97-64f9-4120-bdeb-c5a91a274490@lunn.ch> <070901dd2e6d$f5b70c30$e1252490$@gmx.de> <0a125ab4-2453-4d32-b158-8bdaaca16674@lunn.ch> <089001dd2e83$b8957920$29c06b60$@gmx.de> <2fd17092-753a-4a80-bdf4-72801eca8d0a@lunn.ch>
In-Reply-To: <2fd17092-753a-4a80-bdf4-72801eca8d0a@lunn.ch>
Subject: AW: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open up C22 and C45 space in parallel
Date: Mon, 17 Aug 2026 22:25:47 +0200
Message-ID: <08e501dd2e86$98e9fdf0$cabdf9d0$@gmx.de>
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
Thread-Index: AQKGRKDnP2yh8sOJ5M24BwCNtDMK1QH1jg89AffL5+ICqsGtjAEuNNjXAY0ikhsA+OoE97T+Hlmw
Content-Language: de
X-Provags-ID: V03:K1:pZOsp5jWNWfypoMBolOBp9WFTPiclxJhLtXlYZiNJHscU2Gs6Ha
 P18BNMyY4tPkYzG1MbZwKjZwqUMo1Q2SbT6AzgOoEU917xkV14kQVegXaxT4R25AO8BAoZJ
 dznB66y8MGpRMsYkzobTL2KfrNVkvzQ5YhRUyXHc27mB62qsug0qC7Qe7kEolXRqVqkV46P
 j0mEsJ/J97kYE40bWkP+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sQg4QtYVXe8=;vNb9fUCS9wonrVo/whPr/Al15k2
 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

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Montag, 17. August 2026 22:11
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open
up C22 and C45 space in parallel
>
> > All downstream 1G PHY drivers for that platform use dedicated=20
> > read_mmd/write_mmd callbacks that run __mdiobus_c45_read/write().
> > So no warnings during bootup.
>
> O.K.
>
> In Mainline, please think about how you make that work. Are these PHYs
> also used with MDIO busses which have working C45 over C22? And no
> C45?

Until now we never encountered any of these PHYs in scope=20
(RTL8218x octa port) outside of the Realtek RTL83xx/RTL93xx=20
ecosystem.

Independent from that upstream "Generic FE-GE Realtek PHY"
uses the same unconditional C45 access  - regardeless of the bus=20
feature set.

Makrus



