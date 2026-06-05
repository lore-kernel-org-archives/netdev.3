Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C78361650;
	Fri,  5 Jun 2026 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622669; cv=none; b=enM42X7LDMeogmH4meVKxAve/JIUTFO+7GxBBzSYhh2Mbc9dEYTrfSKw8cL6aae/5YIRpnF0Os2qvYUHSgASPcz6f4+xM8MBjjjhUierKmKYb4GKKuzYkGxFGXX41tLhqNvniH2HPzi4h4XmQA6T8I6fydkobhl4LA94lR8tu6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622669; c=relaxed/simple;
	bh=0F5y4FcvZ4sW3vclqK88EapePq6+JuWGywmKUd1PKE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPBnlbOn8mC9fDoKlCYKchYtQR+yTGIuBgkXMqpEWVg6wiExnYiVbPC4qWyK1I8Ihx1fgdz/FrKUtnzvuKZo4io9ETiiLceEyEYxAYinB+wgnFtuliL+Ijnw9ZQu9pOua+FTxjOrMiEqNEtdeJPJUXzCgB8R3oE+w7fTLaQpNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZNGRjx1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZNGRjx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DB41F0089B;
	Fri,  5 Jun 2026 01:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622663;
	bh=fewRWzJCNDCCA8/KFWnc5g54zB+46ySS+Do+r/WrM6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aZNGRjx1KgWzLCrVCPXsmakHcN8mAS8sdjpRpsacMcK7WB5KroIY8rF3ienwya3wL
	 Sr7BlH/b76XOW+OKekjkTQpUmuUZmXrRmB6trh3jaU3HMDIZKnXt6JE9JJ307vhVua
	 4XShbdHmCZHNGFlLOR6ONT8bhb6rYorYJmKM3lSlZ1VWWvNOgCrui8MAx+jagwTrtu
	 gsqkkp1iUqWiuduXK8NWO/edAL+zu7y7m6LS+6E2EkRh+knZUDZpmR15uzRjMmJFeo
	 7lS7wVgo0AKpGs7l+o21P4VRR25EGhTJmDQGrC32ebfw3s87aVfddikfsUneEiNFfi
	 w3NhvX6V9XbiA==
From: Jakub Kicinski <kuba@kernel.org>
To: devnull+george.moussalem.outlook.com@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	george.moussalem@outlook.com
Subject: Re: [PATCH next-next] net: dsa: qca8k: Add support for force mode for fixed link topology
Date: Thu,  4 Jun 2026 18:24:20 -0700
Message-ID: <20260605012421.3517532-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603-qca8337-force-mode-v1-1-caf7670ffab3@outlook.com>
References: <20260603-qca8337-force-mode-v1-1-caf7670ffab3@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: qca8k: Add support for force mode for fixed link topology
    
A fixed link topology is commonly used to connect this switch (on port
0 or 6) to a SoC's MAC over SGMII. When inband negotiation is not used,
the switch needs to be configured to operate in force mode. As such,
enable support for force mode.

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index a36b8b07030e3..3dbd18ab86380 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
[ ... ]
> @@ -1611,10 +1611,14 @@ static int qca8k_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  	if (priv->ports_config.sgmii_tx_clk_falling_edge)
>  		val |= QCA8K_PORT0_PAD_SGMII_TXCLK_FALLING_EDGE;
>  
> +	if (neg_mode == PHYLINK_PCS_NEG_OUTBAND)
> +		val |= QCA8K_PORT_PAD_SGMII_FORCE_MODE;
> +

[Severity: High]
Could there be an issue with configuring port 6 on QCA8327 and QCA8337
hardware?

Earlier in qca8k_pcs_config(), reg is overridden for these models:

	if (priv->switch_id == QCA8K_ID_QCA8327 ||
	    priv->switch_id == QCA8K_ID_QCA8337)
		reg = QCA8K_REG_PORT0_PAD_CTRL;

Since the SGMII force mode configuration uses this same reg variable,
won't this cause the FORCE_MODE bit for port 6 to be incorrectly written
to port 0's PAD control register on these specific switches?

>  	if (val)
>  		ret = qca8k_rmw(priv, reg,
>  				QCA8K_PORT0_PAD_SGMII_RXCLK_FALLING_EDGE |
> -				QCA8K_PORT0_PAD_SGMII_TXCLK_FALLING_EDGE,
> +				QCA8K_PORT0_PAD_SGMII_TXCLK_FALLING_EDGE |
> +				QCA8K_PORT_PAD_SGMII_FORCE_MODE,
>  				val);

[Severity: High]
Is FORCE_MODE properly cleared if it was previously set by a bootloader,
but we don't use outband negotiation and no clock falling edge properties
are configured?

If neg_mode != PHYLINK_PCS_NEG_OUTBAND and the clock phase bits are not set,
val will be 0. This causes the if (val) check to fail, skipping the
qca8k_rmw() call entirely, leaving FORCE_MODE unchanged in hardware.

However, if clock phases are configured in the device tree, val will be
non-zero, and qca8k_rmw() will clear FORCE_MODE. Does this create a
scenario where clearing this mode unpredictably depends on unrelated clock
configurations?

>  
>  	return 0;
-- 
pw-bot: cr
