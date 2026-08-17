Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA323EDAC1;
	Mon, 17 Aug 2026 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009209; cv=none; b=PPC7HzEeA6EEmbv2IzNVy36kty2rz9VFFmUPYj/RvBbcQT5OI4RJ632MXRAMs70A0GXD7RodJMvwGFoqUctCHHJpR2nGylIrxa5AM/QrRRvdq9sqLqzMivsM8ZwXHPUPorU2iGFM0JU1xAx7q0i04JK2tJ64XiJl61OjlNVREn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009209; c=relaxed/simple;
	bh=CJGyEzRnCHMiDixltde03aZUx6bqeNe+LxKN0VZwZSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4PWBEM2hsDPx3ftWH2YLkRHwhQhXyMcNhki14msSbOMyfnhVhM0Jg4diSGLAe0w/IPYehazqR2q+/Vno4OpRdVc7e44x7K6R09ejMv/Iw1MVZCXtzFYhaCZQq7EOHOJ7yZ0jMJZZOOk1Y8o6Aw4J0Wlk1OLbm/jenOLyn6zR94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRNl8+0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRNl8+0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0891F000E9;
	Mon, 17 Aug 2026 23:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009207;
	bh=CJGyEzRnCHMiDixltde03aZUx6bqeNe+LxKN0VZwZSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IRNl8+0pxap9y5upU7E3z7d8LY9Q20mTzs8+NikNuo3COJILP2VJNcyXoBF5kdrnA
	 WeY5OIu4urvG9S6jgkHZWpywnT7mTSS7JN61YHa9ES1DdKI/c/yBxvELbnFyJmn0IR
	 xbg/cdD9TRwbn7jr2+7BNILoV8gyBhxhI4OPh6oVeuldNJLhC9QK0xA4ApJ4cd0LPu
	 dF46Th+LtTdTgZHPsG8hNWqn0ORUOXmGE4COgchFlszU1huYeZ5Y2sAh1KKQO5KIO+
	 84CYZF/3jLBZl0rR7TIscjNm0tb70MG2/Mb1f1y1ALjrS7Xxmgk5MASn8qnpJqCsJ7
	 766Guf3/OtQMA==
Date: Mon, 17 Aug 2026 16:26:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, Hauke Mehrtens
 <hauke@hauke-m.de>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Semih Baskan
 <strst.gs@gmail.com>
Subject: Re: [PATCH V3 1/4 net] net: dsa: b53: deal with Northstar devices
 using CPU port 5 or 7
Message-ID: <20260817162646.6d6b9022@kernel.org>
In-Reply-To: <20260812132755.32585-1-zajec5@gmail.com>
References: <20260812132755.32585-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Aug 2026 15:27:52 +0200 Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> Northstar devices have 3 CPU ports. Ports 5 and 7 may be used but have
> their limitations. Warn user when CPU port 8 isn't used and add EAP
> setup workaround to avoid non-functional standalone ports.

FTR this needs to apply to the tree tagged in the first patch,
according to the CI it did not apply to net so repost will be needed.
