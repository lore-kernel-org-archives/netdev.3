Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097864;
	b=urMynnzcRs70E9UsUk22EVWh0rEmj/VgX/8cQ5r7H67x1hy8Pf2NbREP4g2omVrtj2rR
	 B53L+ilNeQyBKBCyrCNykeo/1aZaDWAJA3fZyyRCB/1MX/1oiLw2j3pEWNOXStf1fpnou
	 fkJdvnA/ZSJJxOBUHPfj5ZP8XTAxYHk+0WyDWcs9NJ4U0XiI6bKAf5DO0YSADByGnxiYq
	 PdwnXXbnnIvhp4p9LYjPj0E2ecLfGjUdS2vA9cx1YLz+Oq/Z6+M1MXKHqp9CwwC3qMYSu
	 6PmPbvp1qGTmkAL0rvDkxVxjvcmrxaXC9JENE+xUzj7iu2EsxTeM64KDF2xuBXfJ6bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097864;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=EmwVVNfWTX/oFCv0ig9mplNZI03jXLrvbbZUZU4TCdw=;
	b=nKq2gJ8CGN18peJmmnYFBIVBeoB7cNjcAusDcgOcFUd+ov9SrYOfpyHUmIliSRWeEoDU
	 1HeF3U23jx0Ehi82BL21xGuK2YoeD3UPkGqz8WD2LnkblqMsYpdrxHPB8ZPyGL7Wj57EB
	 fKOYu2D/TlZlknvwBgTDkwG+Jm4utaLrISKGsvzFfc+QzkPkbcTuk58zCxAeJkhCwIB5Y
	 dgHCH/sZnfMiiMduxRJOazn9S7LsbeAlZ0Xx6JDoBWCR4/N1ZPy6S6GLHUyGTiwx5cnrW
	 RPhlwgIsVdTH7QPs7ilTLT1VQX60XQ6Pp8AsiSBR5V4TvibCcPDS0WDP14ch2Jl5k8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=dzX2nS9D;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D10606A31B;
	Tue, 27 Oct 2026 10:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2D10606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=dzX2nS9D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=EmwVVNfWTX/oFCv0ig9mplNZI03jXLrvbbZUZU4TCdw=; b=dzX2nS9D8BTfbltg7sf8EyWnIF
	YR5/lR8p2o7W4dSnji19TWCRsn1H6oc6EmAvEpiz+FBLQKDWeEgI7pTHnlTtIvp1nsnLXX8UVC2ft
	IPwf/6y30bWKyAuWnlAW4wtOf/pNr9jhSZ77jBW65spt2KshPXsdUzelQxnGT8T88QeTnipw4Ommm
	Hy1HiU7KeYrnWfYkjaQczWONxNwSpZjyJ/IYOSkv1vMtYOGqCz6QPQkkXX0HUiPo0VGPzSN/v3uao
	9gQc8Vy2Lgs9IxG+6H8yrUt8Tt+mHDKwYtFuFylXHSJtnAQEyzYFucOGzx988/fa3z7gsfQ/MCXw2
	/RfziD/Q==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Cunhao Lu <1579567540@qq.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: rockchip: Add RK3572 CRU
Date: Tue, 27 Oct 2026 11:43:56 +0100
Message-ID: <3011736.yaVYbkx8dN@diego>
In-Reply-To: <20261027-vagabond-gabby-caracara-4edabe@quoll>
References:
 <20261026-add-board-ok3572-c-clk-v3-0-dbabfa39d692@qq.com>
 <20261026-add-board-ok3572-c-clk-v3-1-dbabfa39d692@qq.com>
 <20261027-vagabond-gabby-caracara-4edabe@quoll>
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

Am Dienstag, 27. Oktober 2026, 11:17:08 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Krzysztof Kozlowski:
> On Mon, Oct 26, 2026 at 02:56:47PM +0800, Cunhao Lu wrote:
> > From: Elaine Zhang <zhangqing@rock-chips.com>
> >=20
> > The RK3572 CRU uses the PMU0 GRF for the AUPLL reference mux.
> > Describe the controller and define its clock and reset IDs.
> >=20
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> >=20
> > - Documented the xin24m input.
> > - Made the PMU0 GRF phandle required.
> > - Updated the example.
> > - Closed the reset ID gap while preserving each named reset's register
> >   mapping.
> > - Removed CLK_NR_CLKS from the clock binding.
> >=20
>=20
> All your patches seems to have odd commit msg.
>=20
> > Signed-off-by: Cunhao Lu <1579567540@qq.com>

With code originating in the vendor kernel, it is nice to know what changed,
but I guess there is a tradeoff between brevity and more details.

I guess this could be shorted to something less verbose, like

+++++++++++++
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
[adapted to mainline rockchip clock and reset handling (xin24m input,
  don't introduce CLK_NR_CLKS, etc ]
Signed-off-by: Cunhao Lu <1579567540@qq.com>
+++++++++++++




