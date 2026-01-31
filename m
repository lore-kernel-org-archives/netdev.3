Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA10321434;
	Sat, 31 Jan 2026 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824476; cv=none; b=UPPm9/6f67aTAX50Y8X8PvLGoSHEj6x77RA1EQoVys6Xh+v8lEjQZ+s3i1gR3loJZgJ4N8tWDa9170W+c69njkPAl1Kuy3E25NQJoRC236DIptsrwKXBUWlsqsdHuMkUJs4aymbbzfz3xAYxoNg8P1jlccwTjzcXI6avDRegZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824476; c=relaxed/simple;
	bh=7tL9q9XKleen5Up+Wt+oyqqMgj2ZPmG6LNTIPku7R04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPnBQcsiMOj2gR9WMzVCzWC1WXQBbL/5DWR69yxUjABWE/pGf1FfrS7tbxJYDT2gpRubUj5rIYChdCibfX+kxRInuFe3OGIxFuQdv4z4M5ovZrQjZeBmzjUGCMXA2glcZ8dQ3URq/IaP8rP2gXowhYndMcaY24UkQYhcHAjfIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfUWlX/W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfUWlX/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE728C4CEF7;
	Sat, 31 Jan 2026 01:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769824475;
	bh=7tL9q9XKleen5Up+Wt+oyqqMgj2ZPmG6LNTIPku7R04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfUWlX/W8vsQ9Rp4Mg0R0DastRitiVLxPKfoYmAnRuLm8TJRoCo7SE/th3F992qDw
	 irU13ZKqJ8fNgT6BTlZ8ZFL40IH64qCvTJZfUPkWY8K9s96tncqVChLF2nF9pG0QPp
	 j4+vZfeTSLAOGUCh9XW1vIDeU3d4pf+xpyTfwmlEH7ugdpMCOrHwAOWZW7rIflnY/+
	 n1Fw9g8rN6gHQDC8Bs5MG4MZv6yf+Kvg3ncwUtp9AJpRTXX+cYiBxNsUkLWquPzy0q
	 LQPu3LjL1MIvIb9UPmT2j7mikYQHAnb1ObHq0i5aZKs8zHMgr3wKiqxWl83EhVHiUr
	 oOM65obkeZ/+w==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	devicetree@vger.kernel.org,
	horms@kernel.org,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	richardcochran@gmail.com,
	shawnguo@kernel.org,
	edumazet@google.com,
	linux-arm-kernel@lists.infradead.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	wahrenst@gmx.net,
	davem@davemloft.net,
	festevam@gmail.com,
	conor+dt@kernel.org,
	imx@lists.linux.dev,
	andrew@lunn.ch,
	robh@kernel.org
Subject: Re: [net-next,v21,2/7] net: mtip: The L2 switch driver for imx287
Date: Fri, 30 Jan 2026 17:54:33 -0800
Message-ID: <20260131015433.972337-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129110154.1699976-3-lukasz.majewski@mailbox.org>
References: <20260129110154.1699976-3-lukasz.majewski@mailbox.org>
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
net: mtip: The L2 switch driver for imx287

This patch introduces support for the MTIP L2 switch embedded in the
imx287 SoC. It provides the core driver infrastructure including DMA
initialization, PHY/MDIO handling, and net device operations.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> new file mode 100644
> index 000000000000..7b61ba9642e3
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c

[ ... ]

> +static int mtip_mii_probe(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct phy_device *phy_dev = NULL;
> +	int port_idx = priv->portnum - 1;
> +
> +	if (fep->phy_np[port_idx]) {
> +		phy_dev = of_phy_connect(dev, fep->phy_np[port_idx],
> +					 &mtip_adjust_link, 0,
> +					 fep->phy_interface[port_idx]);
> +		if (!phy_dev) {
> +			netdev_err(dev, "Unable to connect to phy\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	phy_set_max_speed(phy_dev, 100);

If fep->phy_np[port_idx] is NULL (no phy-handle in device tree), the
if block is skipped entirely. In that case phy_dev remains NULL from
initialization, and phy_set_max_speed() is called with a NULL pointer.

phy_set_max_speed() dereferences phydev->supported via __set_phy_supported(),
which would cause a NULL pointer dereference crash when the interface
is opened.

Should phy_set_max_speed() and the subsequent accesses to
fep->phy_dev[port_idx] be moved inside the if block, or should the
function return an error when phy_np is NULL?

> +	fep->phy_dev[port_idx] = phy_dev;
> +	fep->link[port_idx] = 0;
> +	fep->full_duplex[port_idx] = 0;
> +
> +	dev_dbg(&dev->dev,
> +		"MTIP PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)\n",
> +		fep->phy_dev[port_idx]->drv->name,

This debug print also dereferences fep->phy_dev[port_idx]->drv->name,
which would crash if phy_dev is NULL.

> +		phydev_name(fep->phy_dev[port_idx]),
> +		fep->phy_dev[port_idx]->irq);
> +
> +	return 0;
> +}
-- 
pw-bot: cr
