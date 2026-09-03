Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1E33FE33;
	Thu,  3 Sep 2026 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425984; cv=none; b=l+C28Pk9d4IcUia5t0q8xS0tib9Kq5uoAN9sZKshIcc1T0yf6G6PQ80X4973hpO2LQvOFmgTdJO+MYKVhtEjgX+TgcvkAhmc/4eEyhy6hpUITSsUzT0UbkxrbkUDpQEMkq0oLg7mKqlEti2D0Wk73aiQKrnUu9EQxKUAlQrueEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425984; c=relaxed/simple;
	bh=kVnEmuck5YlW+cysPHQ3yekEWh5fBAZYSZ+FOgY3PiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFJkUNei/2tZYwTUZEYJQW1dzIq7WyEO6OtwtdKLt/zGjmdbo/G8gy1Awds+XlzTkQ1qHF7YT32S0JZ1z4r7wrQO6rCoRS23rmc6epqOTgab6C0yaTIvw4ntplROXYbo/ZIa9kfj8X1u78P2Rnnf5hzvoPCI/0/Qxu9NravS4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NSAfZPyF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NSAfZPyF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E7D5D4E414EA;
	Thu,  3 Sep 2026 08:59:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B3073602B8;
	Thu,  3 Sep 2026 08:59:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D55D11C79B6F;
	Thu,  3 Sep 2026 10:59:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788425975; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=PiL0n2uXooBtcEc368JZodVn4EdHp6AGVsRm0KQPqdM=;
	b=NSAfZPyFa9kKtVaFiAwBkbsvfBe6WXTmXNm2f7foXwBePTVa3H+um9g9CFDz2W8fd/X5xc
	E8nIZDWfVUXYxXhzu0UxH8/n+TJc2bvmjpDPFp0h2uWAimVXBXZFXIJfDnlpbC/BICsVHO
	7OgGrMYElME/1bbRs1vfRILU5p97XBKrDBpkYQHx0vntvAqBPNmT/95Rfcn6qO2umjS/dz
	6bNKILtLX1sD6vMvjgaFXhbdCNFXR3o05SWWTOZ3FmVvXWWFNSL6JpLYpfHaj/zqjTK7JA
	1+EbewU6Kz/XhoqxrQ9mynIRFw4QwXYbxT9kLtPnVi4X1WF8Vvs2BzeoooPLaQ==
Message-ID: <54544759-8668-41af-ba05-68b8b3f00416@bootlin.com>
Date: Thu, 3 Sep 2026 10:59:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/10] net: stmmac: dwmac-rk: add SGMII
 support for RK3568
To: Coia Prant <coiaprant@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>,
 David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org
References: <20260901150111.141037-1-coiaprant@gmail.com>
 <20260901150111.141037-9-coiaprant@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260901150111.141037-9-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

On 9/1/26 17:01, Coia Prant wrote:
> The RK3568 SoC integrates a Synopsys DesignWare XPCS that can be
> connected to GMAC0 or GMAC1 in SGMII mode.  Add the necessary glue
> logic to support this configuration.
> 
> The current dwmac-rk driver does not support SGMII mode.  SGMII
> requires a PCS to handle auto-negotiation and link state reporting,
> but the existing driver only supports RGMII and RMII.
> 
> Add a set_to_sgmii() callback to configure the GMAC GRF register for
> SGMII mode (bit 7 set, interface selection bits 4:6 cleared).  Also
> add a supports_sgmii flag to indicate SGMII capability.
> 
> Provide pcs_init/pcs_exit callbacks to create/destroy the XPCS via
> xpcs_rk_create() from the Rockchip XPCS platform driver, and a
> select_pcs callback to return the XPCS to phylink.
> 
> While at it, fix the clock enable ordering in rk_gmac_powerup():
> gmac_clk_enable() is now called before any register access, including
> the SGMII mode setup path.  Previously SGMII mode would bypass the
> clock enable via a goto, which could cause synchronous external abort
> when accessing MAC registers with the clock domain disabled.
> 
> Also clean up the error handling in rk_gmac_powerup() by using a
> unified clk_disable label, and add error handling for the default
> (unhandled interface) case.
> 
> SGMII In-band vs Out-of-band
> ============================
> On RK3568, the MAC clock is fixed at 125 MHz and cannot be dynamically
> changed by the stmmac core's set_clk_tx_rate callback.  In-band mode
> works because the PCS handles rate adaptation internally.  Out-of-band
> mode does not work because the MAC would need to change the clock rate
> to 125/12.5/1.25 MHz for 1000/100/10 Mbps respectively, and the clock
> is fixed.
> 
> Enable default_an_inband for SGMII and disable the generic stmmac
> set_clk_tx_rate callback.  This forces phylink to use in-band mode,
> where the PCS is responsible for speed/duplex negotiation.  Without
> this, the stmmac core would attempt to change the clock rate on speed
> changes, causing TX to work but RX to fail.
> 
> Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 386)
> Signed-off-by: Coia Prant <coiaprant@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


