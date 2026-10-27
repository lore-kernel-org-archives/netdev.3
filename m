Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105614;
	b=DDjENLFyJDM13K7t/wrUQMIZ8TyzdAqkMuM6fQvI+j/A+oPnctgQqThvVCrpy7u8jhSu
	 +fhhY2to/TTkNmneu/Sp1Sh6YkvUuT4mA9yVt3+FxQe84Vdn8NikJAbaWopxrSOGgN4ls
	 HUiKSwMrOV2ZN/JmRxjd85tLjNQlMuUS2BXsMEpScy3acY4Nt33F/OqIMd7xaVFHncgYZ
	 2Y6T4/JhfhExRBg+U8R5X3dM4qmai3ksdlhQdrZ+xdm4xMRvo4hMi2lDYRB1EK/PaGR5M
	 5B+GkMRbF7KAOpLX3N56BpxGDPFm2QJbtEnnPgfb2c0iSZ75nFalkHtd0+6NHbGvTzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105614;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=B3x+ve/3y8894hAz6Kf2M5B/2DKTWxmuPKSuFN/yyCo=;
	b=j+NYJ2yGZQ2ho+8Lf0yu9CeTyB74QaAegQStsQg1X2dECepVOAv67hqCr0Lm7ouE4z78
	 71rnuzWhtuXej6lQijCHpnbR+7ruax4tz1qKDVxtwHtxkWes1lzPQV/t9vOrH311/4eiP
	 6IBa9qHqPGnYRvrgkLZPOvyw4D7o6/zBbiXOD/usHkvB/9yyqryv2qGCydajg82xYDNh+
	 y0konz6W1EORvhL1UghpOSXSMjZhDq7q9UnLYOXZVgYQsIK+6NUl4u9Y/98W+P8S1ig0/
	 5yBrr5nKwK0c/aR39dk48TTXBStKOLSGoyKr8DKsBmZyrWDl29FLm4XphWh00C51PzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=AFcHvXIh;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE1606A31A;
	Tue, 27 Oct 2026 12:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48BE1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=AFcHvXIh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=B3x+ve/3y8894hAz6Kf2M5B/2DKTWxmuPKSuFN/yyCo=; b=AFcHvXIhhGrKyfs9/MEEb2VHHP
	lneMt/MX28F0QNNgpDxTH+e7aeEYK1POI8mqG8oTD43odd/FssBI+at/TdQ46iYEWIhqQ9yAPEbki
	Zbv2J/jbVy0uXNymHAnB/CV1ql7+G7KKNLb+FM842Fs6NjFIVaUit6rp22B3MoT/ywKS60BfjzyP7
	qh2V/aPdZo+EXMYESreOURbgACsTKgBGqaHXbLjlJMsEf1RGP2ktznToxAwVwAxP6bEWaCaqcc5qR
	uBr8u2AlPqAx/n0iNfz29QRJgICC9ID81sbIPpdEJ4NARgRxkpmtgkY776RdUolbbVG5kL/UgIxZ5
	zs+Hxbag==;
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
Date: Tue, 27 Oct 2026 13:53:18 +0100
Message-ID: <22145329.0c2gjJ1VT2@diego>
In-Reply-To: <c1fc1868-5583-420f-b945-2bf934873713@kernel.org>
References:
 <20261026-add-board-ok3572-c-clk-v3-0-dbabfa39d692@qq.com>
 <3011736.yaVYbkx8dN@diego> <c1fc1868-5583-420f-b945-2bf934873713@kernel.org>
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

Am Dienstag, 27. Oktober 2026, 12:07:12 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Krzysztof Kozlowski:
> On 27/10/2026 11:43, Heiko St=C3=BCbner wrote:
> > Am Dienstag, 27. Oktober 2026, 11:17:08 Mitteleurop=C3=A4ische Normalze=
it schrieb Krzysztof Kozlowski:
> >=20
> > With code originating in the vendor kernel, it is nice to know what cha=
nged,
> > but I guess there is a tradeoff between brevity and more details.
>=20
> Honestly I disagree :). Vendor kernel commits and their messages are
> irrelevant per se. They are only useful as source of knowledge, but what
> was exactly written there does not matter. Quality is dubious, coding
> practices are terrible. We want to extract the knowledge, the important
> details, but not the exact commit. We do not care what changed from
> downstream to upstream, because we know that downstream sucks so much
> that we don't even want to touch it.

Here I partially disagree :-) .

We trained Rockchip somewhat well over the years in that for example
the per-soc clock drivers fit quiet nicely into the upstream framework,
as both sides follow the mainline driver structure I did in 2013
(which is still surprising that that mostly holds).

But you're right for other parts like the whole graphics stack, which
diverted so much from mainline that things can't get transplanted at all.


> > I guess this could be shorted to something less verbose, like
> >=20
> > +++++++++++++
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > [adapted to mainline rockchip clock and reset handling (xin24m input,
> >   don't introduce CLK_NR_CLKS, etc ]
> > Signed-off-by: Cunhao Lu <1579567540@qq.com>
> > +++++++++++++
>=20
> Yes, if this brings anything useful. For example removal of CLK_NR_CLKS
> is completely pointless to mention. How does it explain the hardware or
> design choices? How does it explain why this driver was written that or
> other way?
>=20
> Just take the authorship of downstream commits and send them as your
> own. Both GPL and DCO allow this and if downstream did not bother to
> upstream that stuff, they do not deserve credits.

So personally I do believe in giving credit where credit is due and
trying to make them better citizens instead of just telling the vendor
"your code sucks" ;-) .


The authorship question is likely not as relevant for the binding, but
for example for the clock driver itself, where Elaine did most of the
work matching the hardware- description to the clock structure, I  really
believe that Elaine should get credit for that.


Heiko


