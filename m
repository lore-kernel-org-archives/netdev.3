Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BBE371063
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642755; cv=none; b=OYcccw7f/sDzYyXONdBpbWIImJI4ooKFHxfciz9omJGEMU3zQ6ZfyQ91oLTkkpMUJ3sJ8iBqClxCyKPS9KGcGqMnviCI7JFwydE1IDm0RbyIFax6QFEI3QStNBq6WESzImfbQbvYqXjLtTkMD+ics0zETYB6sb/cCVix4L1PsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642755; c=relaxed/simple;
	bh=GFMb8bPonvF6vYQtz0rN99DE19IvCSvh1hZleDN2lWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkaG7sIAZZC/KLKMpe34iqy9grX31RiGE7cbI28csheY40lAa64kA1bAmLhOx3Qebz7KSPxkzv5FjXtaYXvkPPqkv+tZ7mAcQ0PecTQc0Hd7FtvT84XNQn5NnvxXR8gd81q0rMcCfHUhnBodHaAJ+3RYQ76qGr7nq6hLNEDvX4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CyPJK8Vr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CyPJK8Vr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6/Bhdanj6O08thw4wV1ges687d1OPsjCQBMVncgJuLY=; b=CyPJK8Vr26ROn4aWjw4xu1m28i
	d9JZu6nJ0LZKt2PXB5K8uAQzFiq4gOrOiOP9OQMzvWQ9tmyksBUxUdhxybwAKG4uom8vJLbj8k3Pa
	ZitDjBPPb/y1PzmwywrBPVD7cwiXACkOIq0Hbzuj0CUTNWCZD3Ohi9VNxwLrgtv758boEFNE4It6p
	ews14KhFv9oW3lGurtaQCv5EPtLN+4uXH+jiXo8ggqnYHTJRre+dQrXVuf+FrVgq31Iuon2b/Lrpy
	30tQQUMW78ab2oWaHd/vc0f8hxdMtkPIE74R56kaisUai67PKbNE8fuN3f3faX7qFsJHvKlhlFsJs
	BOWy/aXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38542)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vpR42-000000001Zf-09zB;
	Mon, 09 Feb 2026 13:12:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vpR3x-000000001oO-376d;
	Mon, 09 Feb 2026 13:12:25 +0000
Date: Mon, 9 Feb 2026 13:12:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: netdev@vger.kernel.org, imx@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@denx.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Heiko Schocher <hs@denx.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>, Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Martyn Welch <martyn.welch@collabora.com>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Richard Hu <richard.hu@technexion.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Wei Fang <wei.fang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: stmmac: imx: Disable EEE
Message-ID: <aYndOVkz7AOQK7qr@shell.armlinux.org.uk>
References: <20260208232931.2272237-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208232931.2272237-1-laurent.pinchart@ideasonboard.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 09, 2026 at 01:29:31AM +0200, Laurent Pinchart wrote:
...
> Fix the issue by disabling EEE completely on i.MX8MP.
> 
> [1] https://lore.kernel.org/all/20251026122905.29028-1-laurent.pinchart@ideasonboard.com/
> [2] https://lore.kernel.org/all/20251123053518.8478-1-laurent.pinchart@ideasonboard.com/
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> This patch depends on https://lore.kernel.org/r/20251026122905.29028-1-laurent.pinchart@ideasonboard.com

Are you sure? That's the one adding the DT property, not my patch that
adds the flag you need for this.

> @@ -355,7 +354,8 @@ static struct imx_dwmac_ops imx8mp_dwmac_data = {
>  	.addr_width = 34,
>  	.mac_rgmii_txclk_auto_adj = false,
>  	.set_intf_mode = imx8mp_set_intf_mode,
> -	.flags = STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY,
> +	.flags = STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY
> +	       | STMMAC_FLAG_EEE_DISABLE,

I thought we had a coding style comment about wrapping like this
(operators should be trailing on the previous line, not at the
beginning of the following line) but I can find nothing in
Documentation/process/coding-style.rst  Confused. Maybe it's
somewhere else in the re-organised documentation.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
