Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605171;
	b=u4RcayElfzz5TLiFqr5VgbNJYU9gSYZar7F+5mrLBOLnaVortZc9X//OWeR+88HlzEwp
	 gktI1c53qwLzTfsmND8lASt2stjTU9aieTlJ3Pt1KgR7Uwwd7sAkkbDk7KanwBCHkLvWT
	 b7D2rDRjZINmW+o837HWhJBcw7x9ueKU5nG0Gd87/X2zCUmkTDXhI78wjj4Jx/VmndqEe
	 J0o4K2Vo9etWVKm5iQDX5+X72vZLlfMunG3zDfkRKW5jCVEiVBRmzLbr+y454ar/9PAAG
	 F1t5dyL3/fikQgLbE/K5/EaLevfDu2411rvw8yxtTDKnW4jiOL8qnxxsTGiSVXNY1eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605171;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=14DbhITib14ppVX3i7Picll2u9OpRT8wBV6cw1FaJPg=;
	b=QmRYyoT+MV6l3t4uE9qR+y7p/ZpOFVQUghzUGCvm5c2yd9Ny3YJ9OIiGvShndZzJHsLf
	 zV2oL3an01eqe/co+4DFQlQCSNEb2sseo/Xbg/o96oHywPqnZI3Oi0V5xlosw19KqPIYY
	 zbbmrgzhNftQ/6QKvOY/PKom0ZgPx3Mm1ttezezD0mCjdbz5sh2tu9+ikh/6Tu7TEFKXq
	 dq+Grj6DAos0Uy2wdcNoNojk/vkm4KZMSGB48cVb2r+c82hR17eOKgQOqIeNw6FE/Znt1
	 csf31x2bWui4ZYGNehFcva4SlbpqBnPI2DvUvjAwCjtt096qIFyaN6j72ZlY0NmBmWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=AKqtjcn9;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5A606A32D;
	Fri, 13 Nov 2026 21:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C5A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=AKqtjcn9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=14DbhITib14ppVX3i7Picll2u9OpRT8wBV6cw1FaJPg=; b=AKqtjcn9H5nJ/tb/KVjKAhGI/L
	6FHDvu1Aj51VzpM+SCyLiV+/0BrV/gxyS4fhEbHJMP3ms9/TUQ4ZGw/uNwga4LPjxV8/p3vEn2YkL
	TMkSrJEDq1rDTm4Z5oedrU7wQMQ+OLvF67lqIuaiiJkxAr4yNehWj191xEz0tdHRfad74DdfHm5u6
	aY2fvq0o5kloTw6OExdw6AmUFgG4fBTLwPMeBKvYg8u0mf5sKJctUAMHv5xTS0TV2nhYhdryNvVsq
	8/DEv4d4D+blQJR3R9kEA45UGOGXMWNXxYC4OXvcKNa8qAgQwUj1ZEj44d4nAk6zZFxMhVFD0QNOs
	ESQ1gGXw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Richard Cochran <richardcochran@gmail.com>, 1579567540@qq.com
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH v5 2/4] clk: rockchip: Add internal support for 24-bit fractional
 dividers
Date: Fri, 13 Nov 2026 22:25:55 +0100
Message-ID: <Yf6NfRPFTxKjDagKAm6hpw@sntech.de>
In-Reply-To: <20261030-add-board-ok3572-c-clk-v5-2-9a43403cb149@qq.com>
References:
 <20261030-add-board-ok3572-c-clk-v5-0-9a43403cb149@qq.com>
 <20261030-add-board-ok3572-c-clk-v5-2-9a43403cb149@qq.com>
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

Hi,


sorry it took me a bit to get to clock driver patches :-)

Am Freitag, 30. Oktober 2026, 10:43:58 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Cunhao Lu via B4 Relay:
> From: Elaine Zhang <zhangqing@rock-chips.com>
>=20
> Some Rockchip clocks split each 24-bit numerator and denominator between
> a low register containing 16 bits of each value and a high register
> containing the remaining 8 bits.
>=20
> Add an internal Rockchip fractional-divider helper and clock branch type
> for this register layout. This provides the support needed by the RK3572
> audio fractional clocks.

Please add a paragraph about the "v2" naming.
I assume the v2 is a Rockchip naming, because v1 was the other one that
could still fit the regular franctional divider.



> +static inline u32 clk_fd_v2_readl(struct clk_fractional_divider_v2 *fd,
> +				  void __iomem *reg)
> +{
> +	return readl(reg);
> +}
> +
> +static inline void clk_fd_v2_writel(struct clk_fractional_divider_v2 *fd,
> +				    void __iomem *reg, u32 val)
> +{
> +	writel(val, reg);
> +}


why do we have those? They do not serve any purpose I can see.
So please just use readl and writel directly at the appropriate places.


> +static int clk_fd_v2_get_divider(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long parent_rate,
> +				 unsigned long *m, unsigned long *n)
> +{
> +	struct clk_fractional_divider_v2 *fd =3D to_clk_fd_v2(hw);
> +	u32 factor;
> +
> +	if (!parent_rate)
> +		return -EINVAL;
> +	if (!rate || rate > parent_rate)
> +		rate =3D parent_rate;
> +
> +	rational_best_approximation(rate, parent_rate,
> +				    GENMASK(fd->mwidth - 1, 0),
> +				    GENMASK(fd->nwidth - 1, 0),
> +				    m, n);
> +
> +	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
> +		(*m)--;
> +		(*n)--;
> +	}

=2E.. blank line please ...

> +	if (!*m && !(fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED))
> +		return clk_fd_v2_get_low_rate_divider(fd, rate, parent_rate, m, n);

=2E.. blank line please ...

> +	/*
> +	 * When compensation the fractional divider,
> +	 * the [1:0] bits of the numerator register are omitted,
> +	 * which will lead to a large deviation in the result.
> +	 * Therefore, it is required that the numerator must
> +	 * be at least 4.
> +	 *
> +	 * Note that there are some exceptions here:
> +	 * If there is an even frac div, we need to keep the original
> +	 * numerator(<4) and denominator. Otherwise, it may cause the
> +	 * issue that the duty ratio is not 50%.
> +	 */
> +	if (*m < 4 && *m !=3D 0) {
> +		if (*n % 2 =3D=3D 0)
> +			factor =3D 1;
> +		else
> +			factor =3D DIV_ROUND_UP(4, *m);
> +
> +		if (*m > GENMASK(fd->mwidth - 1, 0) / factor ||
> +		    *n > GENMASK(fd->nwidth - 1, 0) / factor) {
> +			if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED)
> +				return -EINVAL;
> +			return clk_fd_v2_get_low_rate_divider(fd, rate, parent_rate, m, n);
> +		}
> +
> +		*n *=3D factor;
> +		*m *=3D factor;
> +	}
> +
> +	return 0;
> +}
> +

[...]

> +
> +static const struct clk_ops clk_fractional_divider_ops_v2 =3D {
> +	.recalc_rate =3D clk_fd_v2_recalc_rate,
> +	.determine_rate =3D clk_fd_v2_determine_rate,
> +	.set_rate =3D clk_fd_v2_set_rate,
> +};
> +
> +static struct clk_hw *clk_hw_register_fractional_divider_v2(struct devic=
e *dev,

maybe adapt the function name.
=46unction above abbreviated things to

clk_fd_v2_something, so naming this clk_hw_register_fd_v2()
might make that line less unwieldy?



Thanks
Heiko


