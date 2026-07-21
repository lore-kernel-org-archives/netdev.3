Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4A4D9917
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647067; cv=none; b=d1TrX4MwQAb2tpBoeMEK/Mvm32baxdRTxr9i24zLJj/Kc4bHmAdJEqRK7Ip01Ply7Erhvj8EsN+oSicjezsokQOK/cjJkGa9NhLv12FocqEWWyVz14JlxUquIv6ZccczuGSvFgdzv8RDaTHss5z8LFmRXDqC01l8grbLsvKFnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647067; c=relaxed/simple;
	bh=fqPMMjGoiS6f599d6RrjmqZ98GVYGZMjjNdCGuXB4O4=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ENfJcvojLe1JOh6TSZV4Daib01ag22czaX2dskgBx8VALb4r2ke0jjELP8oy9s/15Nwb2NYgwiqQok/NIQRx/7iwrEsymdzwCIsH4nc7g723e+VbjVa3PFykj4+uJV1ntwY8pdOWP1HKyNyA0DKcGAniznqLzcS9ETid+BIbhtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=VY4ewzjM; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="VY4ewzjM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784647031; x=1785251831;
	i=markus.stockhausen@gmx.de;
	bh=D2ZYh/dTcLzu2WXZ3tifMXl1KEnviubv2B0ynLj6+m8=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VY4ewzjMAhq/xD622ER3f5azuahtygspVNnLkmKlyJ7PWA5ZjNeC7tTdffhYbTFp
	 N6h9P5L2whVfuOIt0FUUADMKWcPZUVo264peHH3L9nyastMvE5kWHBmknFxc3ZvQ/
	 OgF81OwRw0+peOb3T8hus74En92yoDCHNkVl4rUtvdVgJYw74XOoOKwN/OXN7dOZb
	 JXG0HSLxwXM2WRhg2AtPyzU66fvBokYgYk5jvanFkh9AfLi3Yf6g8SwO/QOpQF1VT
	 /I4sewwuWB7uZI7z0bVMUgLQtlgFiwU+6o47CZUJSiiPee+Ksz36m/oB7GSGtKRlS
	 eoh2Z1xqo1LTT6PIWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JmN-1wlv6M16f3-00FBOu; Tue, 21
 Jul 2026 17:17:11 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: <andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>
References: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
In-Reply-To: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
Subject: AW: [PATCH net-next v4 0/8] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Tue, 21 Jul 2026 17:17:07 +0200
Message-ID: <05d501dd1924$00ac6cc0$02054640$@gmx.de>
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
Thread-Index: AQF6MSBcDjGj5bVFJwbcqWCWVh2Yrrc95RhQ
Content-Language: de
X-Provags-ID: V03:K1:YI+F3TwuBE+8lSlK+NpPg12+yJFeMzPabgcobQHrWi8MvEoXa6Y
 dw2x/DQwc+ZhMu7CRlb02px29KylB/u6QIRmu4QYdGTya7y81OoLcsOwFVJ3jtWNU5CM+A3
 279vAqESqypeyjN2WEdnkazTKt17wRYevwPueAMpY74tQ6uPGbw4so9GZ93Pb1EqWTIZFys
 87RbqLB9Y5JwCOKi/x5WQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tjUXg60VqK8=;kXw41eDhrF3Wg816+eBwkq/l8TZ
 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

> Von: Markus Stockhausen <markus.stockhausen@gmx.de>=20
> Gesendet: Donnerstag, 9. Juli 2026 08:42
> Betreff: [PATCH net-next v4 0/8] net: mdio: realtek-rtl9300: Add RTL83xx
support
>=20
> The Realtek Otto switch platform consists of four different series
>=20
> - RTL838x aka maple   : 28 port 1G Switches
> - RTL839x aka cypress : 52 port 1G Switches
> - RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
> - RTL931x aka mango   : 56 port 1G/2.5G/10G Switches
>=20
> While the MDIO hardware polling unit and its necessity for the MAC=20
> layer was always well known, no detailed documentation was available.
> For this series the MDIO bus was inspected with a logic analyzer for=20
> a better understanding how polling and kernel access interact on the=20
> bus. All this will be explained now in the driver comments.
>=20
> This patch series adds support for the RTL83xx devices. For this
>=20
> - Enhance device tree binding.
> - Add special handling for limitations enforced by hardware polling.
>   These already have minor side effects on RTL93xx devices but are even
>   more critical for the RTL83xx hardware.
> - Add RTL83xx coding.
>=20
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Gentle ping.=20

