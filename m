Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EEC296BC8;
	Sun,  4 Oct 2026 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119864; cv=none; b=fXv2B+eIMCn9XaRpl7peXYwbRprKatfeJWrOkv09wZDcrqErHT0Vl+qMjwj4f0TVk8/cfzBYhT0mV8d/qtbVDQ1BzkgKgG25naL7MzWDdpTQR5ncgNiUTN1h+sHvRJmEnZY+AsN+eUi2NRcK42XgrVYA/vjOcQs22XepqiQggg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119864; c=relaxed/simple;
	bh=Hti5+OOkxQauKue4Ej4SUGwcqHvfHL11YM7MBS9DzZw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lwRRGwnUVbTy/9LIcru4bQwNaZGbMoGFUkJb6VSaN+xA+aXRYYj5YascBMWfGS8p3xg6BGXtxKOsRJGaoKN1k94uxxNqpATqIgij0HENx/Bx/DAw0ZMOIE43F09nU9TfZO7crEqRw00Jsh9k4uD8wG1wFm9BUlhRjg++JjmZlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXKt+OXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXKt+OXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A921F000FF;
	Sun,  4 Oct 2026 13:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119863;
	bh=2jR4kp0vYc7dw8g8qKDnqJBw25nMwGXdA+Ey7E8EQzk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FXKt+OXRKfDkiAoNlgf1z/xkQWePcXxJPifx9MpY+hw5yArCBusi8FAmj5Cr9VFfU
	 kUp65pldBXSaW+aFslTDMUd7WvqtL5v/vHpnXiy8cCswBqdVuaFRDyuEgAIZhdIWm9
	 SPJzm6BZfyqNlfBLMKnmmIjl6lC4Gneq55zf4TtA11Npbai2Em15FnSL3VcgrHbSR9
	 JM9gosdTn9FpNkbrwjRm1yY0/v88HexgQeXtOIJtRfaOZ7Ql0XuzmPnEdWeLte9oOC
	 KifNizJvDNIa4AaEvfHQZ3iPgDaypDZVZeXbNHssugt5/B+4/8DiV28lmpy1ebP4Rw
	 VJIynJGU0/Ecg==
Subject: Re: [PATCH 3/5] net: phy: mxl-gpy: release MxL86211C Super Isolate
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, lxu@maxlinear.com,
 michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Date: Sun, 04 Oct 2026 13:17:41 +0000
Message-ID: <179111986196.434549.4683250107533877836@kernel.org>
In-Reply-To: <20260930122305.293686-3-robert.marko@sartura.hr>
References: <20260930122305.293686-3-robert.marko@sartura.hr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch clears Super Isolate only once, in mxl86211c_probe()
  (drivers/net/phy/mxl-gpy.c:459-463).

--

net: phy: mxl-gpy: release MxL86211C Super Isolate

This commit clears VSPEC1_PM_CTRL.SI in mxl86211c_probe() so that a
MxL86211C strapped into Super Isolate mode gets released. The clear
happens after the MDIO voltage regulator is registered, and gpy_probe()
now runs after it.

> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index 4cbbfae046317..790075632fc3f 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c

[ ... ]

> @@ -459,7 +456,15 @@ static int mxl86211c_probe(struct phy_device *phydev)
>  		return PTR_ERR(rdev);
>  	}
>  
> -	return 0;
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_PM_CTRL,
> +			     VSPEC1_PM_CTRL_SI,
> +			     0);

[Severity: High]
Can the PHY end up back in Super Isolate after a later hardware reset?

The commit message says the strap leaves "the PHY halted after reset until
software releases it". However, SI is only cleared here in probe, and
probe runs once per driver bind.

On boards that have a PHY reset-gpio or reset controller, phylib can
pulse the reset line after probe. phy_detach_internal() asserts it:

drivers/net/phy/phy_device.c:phy_detach_internal() {
    ...
	/* Assert the reset signal */
	phy_device_reset(phydev, 1);
    ...
}

On the next attach or resume, phy_init_hw() releases reset. After that it
only calls soft_reset (this PHY has none) and config_init:

drivers/net/phy/phy_device.c:phy_init_hw() {
	/* Deassert the reset signal */
	phy_device_reset(phydev, 0);
    ...
	if (phydev->drv->config_init) {
		ret = phydev->drv->config_init(phydev);
    ...
}

The MxL86211C entry in genphy_driver[] uses gpy21x_config_init() as its
.config_init. That function only sets possible_interfaces and writes
PHY_ERRCNT, and nothing else in the driver clears VSPEC1_PM_CTRL_SI.

Take a MAC driver that connects the PHY in ndo_open and disconnects it in
ndo_stop. Wouldn't an "ip link set dev X down; ip link set dev X up"
cycle bring the PHY back isolated, with no link until the driver is
rebound?

The same could happen on a resume that power-cycles the PHY, because
mdio_bus_phy_resume() also goes through phy_init_hw().

Later in the series, "net: phy: mxl-gpy: support MxL86211C lane mapping"
adds mxl86211c_config_init(). It only calls
mxl86211c_configure_lane_asp_map() and gpy21x_config_init(), so the SI
clear is still only done in probe at the end of the series.

Would it be better to clear SI in a MxL86211C-specific config_init, so
that it runs after every phy_init_hw()?

> +	if (ret)
> +		return ret;
> +
> +	ret = gpy_probe(phydev);
> +
> +	return ret;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930122305.293686-1-robert.marko%40sartura.hr
