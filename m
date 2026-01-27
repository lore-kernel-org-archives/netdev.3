Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570742AA6
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769474461; cv=none; b=DqYzOJYcIa5So53fMh+NOk8/YVLS5Nhy0Sa5eAVOWUFO460ob2h8zQlpqACEWS3pYilA/Ctvn84+H5a07dTDfRfTgKbl9QwxYZ26iNWh7yEPdBTBi0+UE9DC3+CdQ7Dxt1TvvifGvoKZvKW/7Ld/JiKGV9PwO+g7sgkFPjnV9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769474461; c=relaxed/simple;
	bh=E6r83GJEejdqNv42ad0axn2xC3bNIulFB7d/X0R4UEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbqR4JNPJnX4KrBGuiIioaKAHv7d12oE/LdT3EEf320rRZEMO0O+7uw690g9x09LcdIWhFCL7teCthxZX0L4Tnszc7JKzkmJg8DMb5uTwORigPM3k4CEHSn55IiLN9pgJItGl8jjAdh17oyc+zpNxHw4weHcTVsb230sckIhHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqvsPB4X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqvsPB4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076F2C116C6;
	Tue, 27 Jan 2026 00:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769474461;
	bh=E6r83GJEejdqNv42ad0axn2xC3bNIulFB7d/X0R4UEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqvsPB4XnXGAUSGtfXM2BLjW83pb+dmu9z0syFGF8qUO1beyR72ZsCuSiTzwgd3Ph
	 k/7VdLhJE+r0StwGC8QI1B+2qrRCNui/70imSiNwX9P0x57syOIGjpqh4hfVhL6QKF
	 z/XHx/6+Qjat2sO/QsNbSQFvqLTTGg3R4BNuADKsmYLBiNHgIyciMtYcOMa6xDGAUz
	 AQxAT1AsH2Ee6O7npCq6v2jhv71XmkIm3vCTcPsh6i8Qaoomosfn9xvBNgr4Nm6Z56
	 D+TQiaN7q19e7krhexQtow5GAan+Ug4W839LIxc336jnecHq/ZgZeO+3FTxm4jBudz
	 7lZcUee/VmbsA==
From: Jakub Kicinski <kuba@kernel.org>
To: rmk+kernel@armlinux.org.uk
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	linux-rockchip@lists.infradead.org,
	heiko@sntech.de,
	alexandre.torgue@foss.st.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com
Subject: Re: [net-next,v2,08/22] net: stmmac: rk: convert rk3588 to mask-based interface mode config
Date: Mon, 26 Jan 2026 16:41:00 -0800
Message-ID: <20260127004100.3785792-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vkL2I-00000005usu-42Hy@rmk-PC.armlinux.org.uk>
References: <E1vkL2I-00000005usu-42Hy@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: convert rk3588 to mask-based interface mode config

This patch adds a gmac_grf_reg_in_php flag and a rk_write_gmac_grf_reg()
helper to write to either php_grf or grf depending on the SoC. It also
adds an init function for rk3588 to set up the interface mode mask.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 35836ffdfc1d..5bbdcc963430 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -126,6 +127,18 @@ static u32 rk_encode_wm16(u16 val, u16 mask)
>  	return reg_val;
>  }
>
> +static int rk_write_gmac_grf_reg(struct rk_priv_data *bsp_priv, u32 val)
> +{
> +	struct regmap *regmap;
> +
> +	if (bsp_priv->ops->gmac_grf_reg_in_php)
> +		regmap = bsp_priv->php_grf;
> +	else
> +		regmap = bsp_priv->grf;
> +
> +	return regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
                          ^^^^^^^^^^^^^^

The regmap variable is computed based on gmac_grf_reg_in_php but then not
used - the call always writes to bsp_priv->grf instead of regmap. For
rk3588 where gmac_grf_reg_in_php is true, this writes to the wrong
register bank. Should this be regmap_write(regmap, ...) instead?

> +}

[ ... ]
