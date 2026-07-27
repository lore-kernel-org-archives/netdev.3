Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39AF3DB332;
	Mon, 27 Jul 2026 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136278; cv=none; b=hAfXoU19mr150C9t0Fifq+BA2OPSKlsot+MbHp01VkNjQyRulkEr572ef3ILJWplN4nfSb/n8LdCFnZZ18chFWE9NftiDEV00c0J1bI6ZxXWyYRqZUsNSQBfrH/+221k9tnnwugNpnBVoiOLIdXQ369l5Kg4AYRCjTdbvD+kMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136278; c=relaxed/simple;
	bh=hYT7rpqtX8Wos1K229nR5nZMGZoquXdBFCeWXlgkUhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYGM06iI/WVhAGn+vxqBgMH0MoEFtQvPPX3w0cdyAQ6gH4pd762kVAU3uzp+I3A7yXCl5FAzpG+ZGpsbAaBfMLl4M8MX+AhcYRqHVKmg2MBnJXzsW0X/s3OzO0HIWgU3TkDoTOmIEuw+VlbkFKYfowWjSP1Uh8QNal0kzRLiPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=offm4kt9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="offm4kt9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 237631A124F;
	Mon, 27 Jul 2026 07:11:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D976D601BE;
	Mon, 27 Jul 2026 07:11:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0886911C1067F;
	Mon, 27 Jul 2026 09:10:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785136268; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SN04qZu7ta/MgrN93457BarUq2CXz/Zpfiel64hteBA=;
	b=offm4kt9itCkBqiu6SCtD6aYb7dQjjySi+Mhklny/vQpgCPVf3BVBaKDYmfyO5Id7gNdPZ
	Fuvc5p+4f+u5PkUk1y8lzYI2pRaCe1Vc4tjwOMenN0Qo8xz8iGf/D6thvR59u7aX3OqT8i
	kvbpigcP6mkI4KAhf4tx5z5am+uzZjW5VaGbXAxbpWIUH6w/1ebzd4rKiA1KhVgbQbmles
	IOzqZLBeecYWCFPPri0/v46UycoK077bLyEXYU6bpTu201J+AZAbqMv/wOYBSy5AUB9AXA
	i/Egx4toEc2eY3vLG/DB9e1TACUwcVOGwcDKKfxBJzHiGjkINlJLp9srldSr2A==
Message-ID: <dae67c46-62b6-4233-92fc-69a09944baa5@bootlin.com>
Date: Mon, 27 Jul 2026 09:10:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: stmmac: dwmac-rk: add RK3576 GMAC 25M
 refout support
To: Gavin Gao <attinagaoxu@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, heiko@sntech.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, nicolas.frattaroli@collabora.com,
 sebastian.reichel@collabora.com, sashal@kernel.org, alchark@gmail.com,
 chaoyi.chen@rock-chips.com, amadeus@jmu.edu.cn, rmk+kernel@armlinux.org.uk,
 horms@kernel.org, alok.a.tiwari@oracle.com, david.wu@rock-chips.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20260727021048.3375444-1-attinagaoxu@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260727021048.3375444-1-attinagaoxu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/27/26 04:10, Gavin Gao wrote:
> Hi,
> 
> Some Rockchip GMAC instances can provide a 25 MHz reference clock output
> for an external RGMII PHY. Boards already describe the MAC clock direction
> with clock_in_out = "output", but the dwmac-rk driver does not currently
> request or enable the corresponding 25 MHz reference output clock.
> 
> On RK3576, this means the REFCLKO25M_GMACx_OUT clock may be disabled by
> the common clock framework as unused, even though the board expects the
> GMAC block to provide the PHY reference clock.
> 
> This series adds an optional "clk_mac_25m_refout" clock name to the
> Rockchip DWMAC binding, wires it up for RK3576 GMAC0/GMAC1, and enables
> it from the dwmac-rk driver when the MAC is configured for RGMII output
> clock mode.
> 
> The clock remains optional, so existing device trees and SoCs are not
> affected.
> 
> Tested on a PicoCOM RK3576 ACP board with a Motorcomm YT8521 PHY.
> The GMAC 25 MHz reference clock output remains active and Ethernet works.

I have a feeling this is using the common clock framework backwards. The
MAC in this case is a clock provider yet it uses the consumer API.

Shouldn't the MAC instead register a new clock, as a provider, for the ref
out ? The PHY device would then need to get/prepare/enable that clock.

I know we don't have a lot of clock providers in drivers/net/ethernet, but
I think we should have more...

Maxime
