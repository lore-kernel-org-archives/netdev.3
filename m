Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035538;
	b=1Zm9WQJN8yb38qkxMLh8/gCMgIovMadDsWMR0K5ezSni6t5mJcFRGb6tgD/iTeOqxgFf
	 q8IUYejXhlgOxaqoewcE/ToeC+uGHRjzab7ys9CNeAMz9BQhLegFZgU0ifJX3lL4eI95a
	 67ScHVSV2uKrhy9ewoiq+/e6/chNAlHuyJp6mNmiHbHfA+1XfWVFgRtm9so7PdIXIKF6a
	 BQB+Kqhfrp8zsOEp0EVmAgkj64EUDEvhLVq5qhgaxR4MoTGxv/XG3/cfW9hN66qac+jYv
	 K3XzgkfKHG9EgI/zfGQ+MPW24K0xbofuFqNG17ldc6ePQ1h5BUktlCgqzbFlYhj4Tjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035538;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=buxG7wzvUrhysQ03B60L3jHsDzOHP1rRWLo5WHGJFa8=;
	b=RAPTtSwq4ne+eSQuNAGlDFgOJ81Gnq2akaEbaTptExT/1iJmE9yX7lmx9DMc5Ank4ep8
	 +ZRPGhCPOrry9AKMyUed6cO6u2cnv9a3JjFSu+s7pREzfSM9CbP1/72d/VMG5pDquzogC
	 5NpMfVwajmrx04FHhEG/PnM66duAU9nbEaxyxDZuq/JQZ2Lj3ltzXVxssb7EB7wSwMB4W
	 Xb6TCsVZMGoJMMe+nuWnCOewvSr5099el6EMteynL0L+gDBWOHV101MjBZmvFeed64Dyv
	 pTJZrbICADO8lsJm8ie/40esLXxBuETwbzLIU/yqNi3FtAaPC6UChAs+xJcDCri7H4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=EuQoFvcT;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77223606A31D;
	Mon, 26 Oct 2026 17:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77223606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=EuQoFvcT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=buxG7wzvUrhysQ03B60L3jHsDzOHP1rRWLo5WHGJFa8=; b=EuQoFvcTmdF1MqhFINMp9kW4jn
	j4134NOWSe6VQzg3ql4+9o6rRcYSKwYYS+jPZIJDAJcUNXEAG79n6U7S60Ewwx/eKpabnRmMsKd95
	Uox2Wg7cZpNtvz1ZLGryqszWJ55+zPphKeoxIpSvElwfFvPlct1yjlrQzZ00VsB5jIMbYhnPtvbvW
	rbuGFvT9yBMLmTOYzxWtlcFUXZIes9qbDoSYCgPoenq9R+Mw7mNLwWuJ1Aspw1qme0grL2SmA8VJR
	Slv8bT7AHy09dEp/4zcbR7u5Qak62kGVUiFeySL1koTWdBHd5D7RuoxGxLecrCkU8+2z2nceTcPDw
	xB03/g7w==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: =?UTF-8?B?5byg5pm0?= <zhangqing@rock-chips.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Richard Cochran <richardcochran@gmail.com>, Cunhao Lu <1579567540@qq.com>
Cc: linux-clk <linux-clk@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] clk: rockchip: Add RK3572 clock and reset support
Date: Mon, 26 Oct 2026 18:25:14 +0100
Message-ID: <3062797.SvYEEZNnvj@diego>
In-Reply-To: <tencent_6876096D2306016F88487E0E4D78345B3208@qq.com>
References:
 <20261026-add-board-ok3572-c-clk-v3-0-dbabfa39d692@qq.com>
 <0d5de6fd-3150-4898-a652-7f5b64dcaf07@rock-chips.com>
 <tencent_6876096D2306016F88487E0E4D78345B3208@qq.com>
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

Am Montag, 26. Oktober 2026, 15:56:06 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Cunhao Lu:
> Hi zhangqing,
>=20
> > This is in clk.h, please submit it separately.
>=20
> Thanks for the review. I will move COMPOSITE_MUXTBL to clk.h and add it
> in a separate preparatory patch.
>=20
> > This is incorrect here; there should be no negative values. Two's
> > complement is used here, so a conversion is needed. For example,
> > -12955 should be 52581.
> >
> > In clk-pll.c, cur.k & BIT(15) is used to determine the two's complement
> > conversion.
>=20
> I agree that the hardware expects a 16-bit two's complement encoding:
> -12955 is encoded as 0xcd65, which is 52581 when read as unsigned. The
> difference here is how that coefficient is represented in the rate
> table on the kernel version this series targets.
>=20
> I found the cur.k & BIT(15) branch in Rockchip's downstream develop-6.12
> tree. There, k is unsigned int, so the driver explicitly checks bit 15
> and subtracts the magnitude of a negative fractional coefficient.
>=20
> This series uses the upstream implementation. Both v2 and v3 are based
> on a804c5742bff, which already contains commit
> 581478883477 ("clk: rockchip: Fractional PLL coefficient on RK3588/RK3576
> is two's complement"). That commit changed the k member of
> struct rockchip_pll_rate_table to:
>=20
>         s16 k; /* fractional part, 16 bit two's complement */
>=20
> On this base, rockchip_rk3588_pll_recalc_rate() uses signed arithmetic:
>=20
>         s64 frac_rate64 =3D (s64)prate * cur.k;
>         postdiv =3D cur.p * 65536;
>         rate64 +=3D div_s64(frac_rate64, postdiv);
>=20
> The signed type represents the negative coefficient directly, so this
> implementation does not need a separate cur.k & BIT(15) branch. For
> example, the mainline RK3576 rate table already contains:
>=20
>         RK3588_PLL_RATE(955520000, 3, 478, 2, -15730),
>         RK3588_PLL_RATE(785560000, 3, 393, 2, -14419),
>=20
> These are exactly the same entries as in this RK3572 patch, including
> p, m and s. Mainline RK3588 uses the same entries as well. Since RK3572
> uses this shared upstream PLL implementation, I will follow the
> mainline RK3576 convention for its rate table.
>=20
> Writing 52581 directly into an s16 initializer would require an
> out-of-range implicit conversion; a reduced compiler test reproduces
> Clang's constant-conversion diagnostic. An explicit cast such as
> (s16)52581 would produce the same signed coefficient, but would add a
> conversion that the existing mainline tables avoid. Using -12955
> directly makes the value used in the rate calculation clear and stays
> consistent with RK3576.
>=20
> The register encoding is preserved: the write path passes k through
> HIWORD_UPDATE() with a 0xffff mask, so -12955 still writes 0xcd65 into
> the coefficient field. The five initializer changes from v2 to v3 only
> make the signed values explicit; they do not change p, m, s or the
> 16-bit coefficient encodings. In particular, no further adjustment of
> m is needed for these representation changes.
>=20
> I will therefore retain the signed coefficients, following mainline
> RK3576.

I definitly agree. For reference the commit fixing rk3588/rk3576 and
containing all the details is
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D5814788834774ed6ad1a27ae91b44eeca80cd27f

Heiko


