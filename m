Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2CC25C804;
	Mon, 17 Aug 2026 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987774; cv=none; b=G6ZqaBh35f5aro1r6tVDk5tTnOydPWyp6kFcZjWtWK8LvqX8rwbq3NeUzddGcUBBYPvrGnPGM1NbAW+BYX+hVEYOkGUCg2DfZNbQpBd/Og2G/l9fuSwFqFWzJZwq7rR2SN2mXiEYPbPQgJaK7Uhct3xGA/MxEeUVjj6HJTONBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987774; c=relaxed/simple;
	bh=nlZ5LEqA83AXCbq8cPQgAh8lLjUaLJPxaCqzmQ20c/M=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=DEbP/1sr+PuoiEnGo14fjz2BefrG3z0OHil7LOnS4uhtTlBVXbIas9cqQI/wyIWdiheihReRBy2N/X7lB055haym/dIXp7sh47Z9hvEiRcyd5mTna8FJY3j6LGNH7ZSlXkmzHjuyUuuikWB3xB/ZXoUHjP6A3MUvmB2TvXJhwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=sXDM/dNm; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="sXDM/dNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786987770; x=1787592570;
	i=markus.stockhausen@gmx.de;
	bh=nlZ5LEqA83AXCbq8cPQgAh8lLjUaLJPxaCqzmQ20c/M=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sXDM/dNmeLBoZJUSR/KQ3ByOe1WmXNP+KnJyZasA2MuByoC9uWdTY4IX6ebEsolM
	 RGz7ELiGIs4BhR+oxWZCld1oKhfKJ0veTMdG+nOhLYF9xQDu3O2uFUd5B4WLwW0JR
	 K1pqvcsc+BsfiK6Kar2s6TyyTLIIcTLNKlrg+QKpmleOKLiADePcrVIRUWsKdf6ZU
	 s310Xdk4ubH5v0HnEBEHnXT2DRVEyHpG4vqsxEYnUAf4T0XuF/EnW8CH2al6UkCNE
	 Lqe1MkMeqHOfJeZdLZs06ZfCaBGQkp2uYTkP6W3EzsS7S6Dn3lGbXd2V1+AMxV1uQ
	 EUt4UiwVpwn7ryK3AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1xRcTs4Acv-00Jt8u; Mon, 17
 Aug 2026 19:29:30 +0200
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
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de> <20260817162632.1208891-11-markus.stockhausen@gmx.de> <cf8bdf97-64f9-4120-bdeb-c5a91a274490@lunn.ch>
In-Reply-To: <cf8bdf97-64f9-4120-bdeb-c5a91a274490@lunn.ch>
Subject: AW: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open up C22 and C45 space in parallel
Date: Mon, 17 Aug 2026 19:29:25 +0200
Message-ID: <070901dd2e6d$f5b70c30$e1252490$@gmx.de>
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
Thread-Index: AQKGRKDnP2yh8sOJ5M24BwCNtDMK1QH1jg89AffL5+K1MOY9EA==
Content-Language: de
X-Provags-ID: V03:K1:hJJYYYoZUk4b3HByq1SduikGSTUecUDo/8Q6HjEKrjy4Iigdobk
 aj9MkBnX082y6mX34f+fMCNz4tpmlye0Q4FoZ2b8jp/cpFSn6ZpOnNFL40jgBlj1DAsxOpO
 YhIvibRaPMBDmAYpBkeqr0cvaqoGv/kKiOHuT9QdN9s1Pq5IJKsaKj/8MCamxCpoIV+YBAT
 ck1OUDgGrLrjKfftvlb5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aOE1T4v60os=;nEIIBOI7g74wT5bfJn1FE3Lz7uM
 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

Hi Andrew,

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Montag, 17. August 2026 19:04
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open
up C22 and C45 space in parallel
>=20
> ...
>=20
> And I really think you need to block C45 over C22, since we know it
> will go horribly wrong.

as per your guidance I Included that as patch 3 of this v14 series

https://lore.kernel.org/netdev/20260817162632.1208891-4-markus.stockhausen=
@g
mx.de/T/#u

Markus


