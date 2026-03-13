Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D3336EE7;
	Fri, 13 Mar 2026 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394360; cv=none; b=rTDukgrUW/PZ4S/tAP3SLtl2wx2H9JJQdjlZE6um5rxmLiu0NWnN/IXguyF4VdZvRtA4WW3LYYxGw9oK+pKb4FVUKpoTFFol47Ii7DlUOhKrpyIexXca624G2zqfLSf/d6dkVYHc/yDfgYDDqFO++hh8akMM7a08CZO01w2tyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394360; c=relaxed/simple;
	bh=vL6usZZMjF3Kj4743w1ZZ9CrFn6N8IuNz7N0YyKmijc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYEI0OjOE8OAai9pfcTk4VS+JoEyU/xP6oSmRZ3j7ydqf2+39p+4Mr1uZNf7LRmeeSQ3spIElWu1Clg1AQq8laf2yQpJG+SuRuyrDH8af00+/sAP8vkOjXcTgHSxawJUHYXbkXusbF7vJxyBYv4jZmKYs8HP3QxOicixK08zJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KXkh2Yw3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KXkh2Yw3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A6oGlsV387MSkeGlfgdCPnuYQ1UUU9UaeP1u0pOYQpk=; b=KXkh2Yw3uuUce4xfJqcyDT6oXr
	NRROy1CK1FouZHjjYNBKR2TFjMoRAZ2pWKnrY+1cq9s/8a+FY9Nft+WGiMUC8FWoaHV/2x5ubEhYH
	XaU/j2ue9XT2gar4kfcuZzK397RG7LTkvzV+2bkjezPlGbaFkd3pRlXRthrAg2M+A6mi7PAlniBiv
	vVVabrRHlZRVtvPeJY5k7iYghXxYTi0jmWjOEGsP0rW3hbOLvqNmcX+0rnaJ8YdjfBcYIIYGKXGVH
	WB3ZOeLd4KmXSxr7a+/NyvLj12mwLVSr+P4XCVeMiTYKvAYg3/+BwoMe2FI3QdJyQGGBmYt/S/b0o
	I2ghAwcg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54034)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0ysa-000000000Zx-4BKS;
	Fri, 13 Mar 2026 09:32:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0ysY-0000000086W-3QeX;
	Fri, 13 Mar 2026 09:32:22 +0000
Date: Fri, 13 Mar 2026 09:32:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	vladimir.oltean@nxp.com, boon.khai.ng@altera.com
Subject: Re: [PATCH net-next v12 4/4] stmmac: s32: enable support for
 Multi-IRQ mode
Message-ID: <abPZpiCsirNzvqJt@shell.armlinux.org.uk>
References: <20260313-dwmac_multi_irq-v12-0-b5c9d0aa13d6@oss.nxp.com>
 <20260313-dwmac_multi_irq-v12-4-b5c9d0aa13d6@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-dwmac_multi_irq-v12-4-b5c9d0aa13d6@oss.nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 13, 2026 at 08:13:35AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> Based on previous changes in platform driver, the vendor
> glue driver can enable Multi-IRQ mode, if needed.
> 
> To get enabled Multi-IRQ mode for dwmac-s32, the driver checks:
> 
>   1) property of 'snps,mtl-xx-config' subnode
>      defines 'snps,xx-queues-to-use' bigger then one, ie:
> 
>      ethernet@4033c000 {
>          compatible = "nxp,s32g2-dwmac";
>          ...
>          snps,mtl-rx-config = <&mtl_rx_setup>;
>          ...
> 
>          mtl_rx_setup: rx-queues-config {
>              snps,rx-queues-to-use = <2>;
>          };
> 
>   2) queue based IRQs are set, ie:
> 
>      ethernet@4033c000 {
>          compatible = "nxp,s32g2-dwmac";
>          ...
>          interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
>                       /* CHN 0: tx, rx */
>                       <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
>                       /* CHN 1: tx, rx */
>                       <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
>          interrupt-names = "macirq",
>                            "tx-queue-0", "rx-queue-0",
>                            "tx-queue-1", "rx-queue-1";
> 
> If those prerequisites are met, the driver switches to Multi-IRQ mode,
> using per-queue IRQs for rx/tx data pathr:
> 
> [    1.387045] s32-dwmac 4033c000.ethernet: Multi-IRQ mode (per queue IRQs) selected
> 
> Now the driver owns all queues IRQs:
> 
> root@s32g399aevb3:~# grep eth /proc/interrupts
>  29:    0    0    0    0    0    0    0    0    GICv3  89 Level   eth0:mac
>  30:    0    0    0    0    0    0    0    0    GICv3  91 Level   eth0:rx-0
>  31:    0    0    0    0    0    0    0    0    GICv3  93 Level   eth0:rx-1
>  32:    0    0    0    0    0    0    0    0    GICv3  95 Level   eth0:rx-2
>  33:    0    0    0    0    0    0    0    0    GICv3  97 Level   eth0:rx-3
>  34:    0    0    0    0    0    0    0    0    GICv3  99 Level   eth0:rx-4
>  35:    0    0    0    0    0    0    0    0    GICv3  90 Level   eth0:tx-0
>  36:    0    0    0    0    0    0    0    0    GICv3  92 Level   eth0:tx-1
>  37:    0    0    0    0    0    0    0    0    GICv3  94 Level   eth0:tx-2
>  38:    0    0    0    0    0    0    0    0    GICv3  96 Level   eth0:tx-3
>  39:    0    0    0    0    0    0    0    0    GICv3  98 Level   eth0:tx-4
> 
> Otherwise, if one of the prerequisite don't met, the driver
> continue with MAC IRQ mode:
> 
> [    1.387045] s32-dwmac 4033c000.ethernet: MAC IRQ mode selected
> 
> And only MAC IRQ will be attached:
> 
> root@s32g399aevb3:~# grep eth /proc/interrupts
>  29:    0    0    0    0    0    0    0    0    GICv3  89 Level   eth0:mac
> 
> What represents the original MAC IRQ mode and is fully backward
> compatible.
> 
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
