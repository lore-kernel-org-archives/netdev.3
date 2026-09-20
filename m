Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB572630;
	Sun, 20 Sep 2026 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941560; cv=none; b=QmZ7Bhkdbpo8WE8QDL13GaJ3KGkRh/4mu44ZcNDKKbsBRtAOqA/5U4+X01OBC1FiJ8QrGSazjYXnQtFXinv6ZJuofBXjkLzGCHnFr7zgk7osMu6kLdfxqdhF7GT8iyVUUcHxii2rzBHyRP/0U+43xQO+KmdOICkHXqKkn5zX5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941560; c=relaxed/simple;
	bh=ENFcCuzTSzNJansVm6xk7VlHUZ5ka0mGTB/JtICLkoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tL0bj09tWfQ/ZwAxXkiN61y+k8xuDvRqXCHw03tqX+bUKO1D4iCoSok3GmGRJO2MgHNwqmRF5LP5/aoGZttLtvKvREengGigrtC3nTUBwwgnzBPNZKymv1wRNuyff3uoXbhRL2/ThT3JnWhywnW6zHqqI//oQtzR8b/iIblFy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=eUYQMERM; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="eUYQMERM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=jH89/eRi22ETk60jcZZWWsxXWB9XkoRdP5UQ7ZiQNJs=; b=eUYQMERMUGvmRYPWE9MG/fAeiZ
	5Hl3Nu2wuESMYC0X1UD3fj10sMty5If4a2lM6qA2MmqGUXllc0JQHAAa4MwyEGZZl1kpJClvLUDVh
	S7BetuprJn8+VQGwvRHM1OiYFiEpZFI5nTblGCtUU7hasHw8pB6gHaIluYQ+7dRMUmhM5+YIilNhH
	HNIiyIgS32IU0ndzCf43RbL8FM3WzLSpVoz7+mKMG3ivnBJwa/vRdm6Ofl7Plby+SG+DCsPdT8tQl
	El3CLNPJPrPs/iMHS8NpS1BTyUNLbYZ6inJLGQSwnU3MiOD7nnT4wYoXED4Mp1Yd6SfTHxh4qNY4C
	QN0t+haw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Coia Prant <coiaprant@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coia Prant <coiaprant@gmail.com>
Subject:
 Re: [PATCH net] net: ethernet: stmmac: dwmac-rk: fix bulk clock leak when the
 PHY clock fails
Date: Sun, 20 Sep 2026 23:58:45 +0200
Message-ID: <4340525.usfYGdeWWP@diego>
In-Reply-To: <20260919174223.2356964-1-coiaprant@gmail.com>
References: <20260919174223.2356964-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Samstag, 19. September 2026, 19:42:23 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Coia Prant:
> gmac_clk_enable() enables the bulk clocks first and then the optional
> PHY clock. If clk_prepare_enable() on the PHY clock fails, the function
> returns without rolling back the bulk clocks, and bsp_priv->clk_enabled
> stays false, so the later gmac_clk_enable(bsp_priv, false) becomes a
> no-op and the bulk clock references are leaked.
>=20
> Add the missing clk_bulk_disable_unprepare() on that failure path.
>=20
> Fixes: ea449f7fa0bf ("net: ethernet: stmmac: dwmac-rk: rework optional cl=
ock handling")
> Signed-off-by: Coia Prant <coiaprant@gmail.com>

Thanks for catching this

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net=
/ethernet/stmicro/stmmac/dwmac-rk.c
> index 8d7042e689261..f3a98bd9d6ead 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1163,7 +1163,10 @@ static int gmac_clk_enable(struct rk_priv_data *bs=
p_priv, bool enable)
> =20
>  			ret =3D clk_prepare_enable(bsp_priv->clk_phy);
>  			if (ret)
> +				clk_bulk_disable_unprepare(bsp_priv->num_clks,
> +							   bsp_priv->clks);
>  				return ret;
> +			}
> =20
>  			rk_configure_io_clksel(bsp_priv);
>  			rk_ungate_rmii_clock(bsp_priv);
>=20




