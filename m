Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5FA2765D4;
	Fri, 15 May 2026 01:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807716; cv=none; b=nlqZYZI4iUMK7L66JX1hv4sFpI0YsEgfMWloP+tPd3jZnAFBfrdXDalu/kaBCm6VMjUU0J38ypV0ugwGpETlzZTLSPGTQnXbZhThw0TsUUS5TkQuAV06rTjdDdxVjSkMjBHMGQg7qUCvcY/sZeBDxBmd9UNccrSRth5DopzEZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807716; c=relaxed/simple;
	bh=b3iq2J+YIcndn8QLpvGHJ73HcIZdauDYczrDl1wqxts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CH5Hp7Cg+VNaqdwJVWFXSTenjprHfE0d68tK8j2DR1qkjvXg4AFY2KFl24+YZ+RouZb5VEGU/qK2k2n3WxdDgHhloNaL/H5Fd1ICbGJudx3J3lneSHrRcCfCixarSfbqIc0cCPxyXdTpw4q21Qnaz1/IHXyFnKh8emeNG0XfNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcU4sXEo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcU4sXEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289E0C2BCC6;
	Fri, 15 May 2026 01:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778807715;
	bh=b3iq2J+YIcndn8QLpvGHJ73HcIZdauDYczrDl1wqxts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcU4sXEoZTUglnsv2AW/9LJgnjTsm8QoXIhokrPRh88mP1Ob7ErgPLfyILrFQYwhs
	 3gIr0yH1vwb730bPcAQ2YKJCgCcW0WmMP2bPsotqHcbqeVDNE3UyLkge7Hq0GkYIOQ
	 i5pJtw1uwsjoVRTtttxXKy0uGGfd8weESZaGv054IhqHX8t9pUXyaYtFgPacW47c96
	 /fUSpdU+/GmMhC1XyFePq3V8zTYNzddzO72N1gCxSRXhvAa1tCnkYiRG1hKIwpuVDw
	 zlSvm3n1cCtuF/0N3qHPxPgsUTdZuoT4Pq6lN15CZQFhvghBpR5DcuB2Wd6WKjHnep
	 IjR4hF9oVGKmw==
From: Jakub Kicinski <kuba@kernel.org>
To: bastien.curutchet@bootlin.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	richardcochran@gmail.com,
	pascal.eberhard@se.com,
	miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	tristram.ha@microchip.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 13/15] net: dsa: microchip: bypass dev_ops for port_setup()
Date: Thu, 14 May 2026 18:15:13 -0700
Message-ID: <20260515011513.1270901-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512-clean-ksz-2nd-series-v1-13-c00f6ce037fa@bootlin.com>
References: <20260512-clean-ksz-2nd-series-v1-13-c00f6ce037fa@bootlin.com>
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
net: dsa: microchip: bypass dev_ops for port_setup()

This commit removes an indirection layer for KSZ switches by connecting
the port_setup operations directly to dsa_switch_ops, bypassing the
ksz_dev_ops callback mechanism.

> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index 7385aa4e788a1..2f63a3a7d6ceb 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
[ ... ]
> @@ -1309,6 +1309,23 @@ static void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
>  	ksz_pwrite8(dev, port, regs[REG_PORT_PME_CTRL], 0);
>  }
>  
> +int ksz9477_dsa_port_setup(struct dsa_switch *ds, int port)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	int ret;
> +
> +	if (!dsa_is_user_port(ds, port))
> +		return 0;
> +
> +	ksz9477_port_setup(dev, port, false);
> +
> +	ret = ksz9477_set_default_prio_queue_mapping(dev, port);
> +	if (ret)
> +		return ret;
> +
> +	return ksz_dcb_init_port(dev, port);
> +};

This isn't a bug, but there's a stray semicolon at the end of the function definition.

[ ... ]
> diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
> index ecb072cd99819..aff0c2735c307 100644
> --- a/drivers/net/dsa/microchip/lan937x_main.c
> +++ b/drivers/net/dsa/microchip/lan937x_main.c
[ ... ]
> @@ -823,7 +822,7 @@ const struct dsa_switch_ops lan937x_switch_ops = {
>  	.phy_read		= ksz_phy_read16,
>  	.phy_write		= ksz_phy_write16,
>  	.phylink_get_caps	= lan937x_phylink_get_caps,
> -	.port_setup		= ksz_port_setup,
> +	.port_setup		= ksz9477_dsa_port_setup,

Is it intentional to use ksz9477_dsa_port_setup() for LAN937x switches here?

Previously, the shared ksz_port_setup() dynamically dispatched the
initialization via dev->dev_ops->port_setup(), which correctly resolved to
lan937x_port_setup() for LAN937x devices.

Since the new ksz9477_dsa_port_setup() function explicitly hardcodes a call
to ksz9477_port_setup(), won't this cause LAN937x ports to skip their
specific initialization logic and instead receive incorrect register
configurations meant for KSZ9477 hardware?
-- 
pw-bot: cr
