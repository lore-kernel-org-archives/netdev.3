Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098574;
	b=065WZvUKVpX5vn1MyzsIeBoU2yY7a7/R+iXYZKTzr6RRlahM0Ldk8hASY/x6zqe96pwv
	 HblW6vL4wTa03ix9Hy2X0SSZDHyLGg3RZYaJ7MY2LAbvdQrWJsmSdbSWrsGUv1T64sfZd
	 UCS4wvRJnNnubJcUjPL/O1EP71LsArq//ft+GyIPLD5bIE1g+B04+MzTCvxrDQlQYBPEq
	 cyvpX579HqNx2m6FEAS9Rejz4oMJahtJtZvBcn8p2PVvWHjm/o6bMXburrC1oHceAICOl
	 hRP9DV7MLELCcTc7BMRxTW2NcDH9p6q+QXqUA3ZBaBQe6af13A+ZbyLSeTNu8uazpww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098574;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=iRDyXe44Y1voxIFFug2VYkvVa9+PxgdNI7cbcINaWFg=;
	b=MJ+EhJplTBDW/uptdM46TKSKujO2IuidE7o34B/fYHG4NP4mv2Uhksr+UKZ4yUusF/bN
	 Jm7H7hPecqOnyy+Y4pDVF6CZAtI5xxDI96z2vfp2QRmLYDtFJaUwmkdngLukYGfMWgMYr
	 4IgUhfgoTxQfAA0ln5uB+HJehwUWUeS0g3KkwcnTFdgJO3ctqZuap/EV8v6e3tvtWQGiv
	 ahuae+Dr8BF8NmH2GaDLpauQ3vSIs5/oCJIRElRN6PvWgP/ACLDMbyI1qa9hfZOFJjdGs
	 KmnLmtsbrZXMxQXPsXse5YXobV8o46xntH2H9O1VIWLL9bIkwWpec1PgnmE1wZwZNkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Jze5PRda;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C1606A31A;
	Tue, 27 Oct 2026 10:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 306C1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Jze5PRda
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=iRDyXe44Y1voxIFFug2VYkvVa9+PxgdNI7cbcINaWFg=; b=Jze5PRdaRk9WLOOmvuXfp6Fv5c
	z/BRwx79xy+Bac7g8xaYFbMgRA4ELz86k5d/AfFqTIsCADA3A2n7jTE1rVlWdtA8LyfiPMNtRztjW
	G89mdyzGt4ka6hPAT9OfTAgv9SQ5F7GVD+6fzH8mVyZ5mmdTU0WnW7hR6nal9n+n4nN6yiCA72bd0
	vB2K+U8dlcvPuTdD6n2V1vTmP0vNMlxw2E30WIlvyFeDb2Ag5vL9n8zR3tsN0RKSSgMfswC5cV25n
	bHbArBhy9RoRocsNbMs4ITAUdGjm3CCNtkGdNgqPa9wiqau3Sasx4Yhx9+OzdVVAhYb9ncqx4nkX0
	OH8DZpKQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Shawn Lin <shawn.lin@rock-chips.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Richard Cochran <richardcochran@gmail.com>, Cunhao Lu <1579567540@qq.com>
Cc: "shawn.lin" <shawn.lin@rock-chips.com>,
 linux-clk <linux-clk@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Subject:
 Re: [PATCH v4 2/4] clk: rockchip: Add internal support for 24-bit fractional
 dividers
Date: Tue, 27 Oct 2026 11:56:01 +0100
Message-ID: <6321950.31tnzDBltd@diego>
In-Reply-To: <tencent_AE0E51DA2FACC999E65D6631016044234005@qq.com>
References:
 <20261027-add-board-ok3572-c-clk-v4-0-d4152b4fedaa@qq.com>
 <f9068153-0d6c-471f-a08b-41cff51ff748@rock-chips.com>
 <tencent_AE0E51DA2FACC999E65D6631016044234005@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 27. Oktober 2026, 11:41:25 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Cunhao Lu:
> > I guess you are describing what you changed against the
> > original patch from Elaine. But this is not how it works.
>=20
> I'm very sorry for the mistake. After carefully reviewing the guidelines,
> I understand that my notes about changes to Elaine's original patch should
> have been enclosed in square brackets []. I will keep only the significant
> changes in those notes and place them within square brackets.
>=20
> Thank you again for pointing out my mistake. This reminds me that I still
> have much to learn.

and as I wrote in my reply to Krzysztof slightly, less verbosity is
usually better. I.e. a short description what you did, not a detailed
list is usually nicer, i.e. something like

+++++++++++++
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
[adapted to mainline rockchip clock and reset handling (xin24m input,
  don't introduce CLK_NR_CLKS, etc) ]
Signed-off-by: Cunhao Lu <1579567540@qq.com>
+++++++++++++

And as for speed, maybe give it a bit more time between iterations.
A version per day is a bit fast, as it doesn't give people time to actually
respond.


