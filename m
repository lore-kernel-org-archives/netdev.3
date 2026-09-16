Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F85A519900;
	Wed, 16 Sep 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577710; cv=none; b=tWOrMu/6/nn1fURsk2vYNkyf43SEjduwAUGcrw3kucpSab7bnkRbctpRFewna0W1fwr3BhoGZAgEtg4+1bHJqjlCUr39PTIOFyQb0SxtX44/mLPOEI/xaaerOHTicNRc+bu6+IHjvNuy6wqyi9MFpqF1DOYp62Ggo2+g7uDBUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577710; c=relaxed/simple;
	bh=ilqcGlbdKBIHL/vrmkB1/CafWnbor2h6Ggk0Ys2ks2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZY9b+PtTVhU1jJb42WBe+OVXINd6AD8pTlFJqFqFORx3tAhk3hvFly0zhVK6hZbvok2uvAMk3ggW2XgT7mtivkN2ca8lI6+Zr0xAHkhG4SrNb2XTCh9YUL0fsvg88zH2feqHvHOcQU2HhnnjE1AFeaLTTyD1UUHdO00A1tt3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NhoFKOkR; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NhoFKOkR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1A3A7C5CD6B;
	Wed, 16 Sep 2026 16:55:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E32F60337;
	Wed, 16 Sep 2026 16:54:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0397311C7B00D;
	Wed, 16 Sep 2026 18:54:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789577693; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2lcHsx/y5VbgHLRKTv0Ayc/1aoUYFwjE7vqzYZmM7YU=;
	b=NhoFKOkRv6qX9CIZ3xSNEGB+N0r0sG1vZlTQVMowAdgjJYQE/QOYS0MuuPc/phRNcuutAY
	7nQnLAatGxHb8ZOTOQrnIPcQl1TcXkVPH5aAHg6NA5EnKwQuhRtsTEbRqXfmO8uWshW99M
	v3tVI/hHdsXOGkXh/Qx5+asfYNmWFzxgrm+yleTK4nYUCIpmXF3CAkdRqYYlL3GXSZdg2H
	ymLxc6ADD3sPElUsD6xlx5P4VXLW438Bp8Fd+XyEUE1AstPcOBMWUSTww4ShzLTkIiP729
	v8S9WxYlP4PSVMAQeer2DqUdUtY+zCDrhpbl2kEbn1fEJEzrZybPQvfqY0tcWg==
Message-ID: <90a666a8-9f6a-4640-a219-731f3d551c66@bootlin.com>
Date: Wed, 16 Sep 2026 18:54:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: stmmac: Default DWMAC_MOTORCOMM to m on
 MACH_LOONGSON64
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Yao Zi <me@ziyao.cc>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260915073206.6665-1-yangtiezhu@loongson.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260915073206.6665-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

On 9/15/26 09:32, Tiezhu Yang wrote:
> Currently, there is no network connectivity when upgrading to the
> latest upstream mainline kernel on certain Loongson machines such
> as Loongson-3C6000 server, because the driver for the onboard NIC
> is not enabled.
> 
> Enable the Motorcomm PCI DWMAC driver as a module by default when
> building for the Loongson-64 platform.
> 
> This ensures out-of-the-box support for Motorcomm YT6801 Ethernet
> controllers on Loongson machines, enabling demand-loading without
> increasing the core kernel image size.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index ab3c4cf96423..c86d6c08977c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -408,6 +408,7 @@ config DWMAC_LOONGSON
>  
>  config DWMAC_MOTORCOMM
>  	tristate "Motorcomm PCI DWMAC support"
> +	default m if MACH_LOONGSON64
>  	depends on PCI
>  	select MOTORCOMM_PHY
>  	select STMMAC_LIBPCI

I agree with Yao Zi, this belongs in your .config, maybe your
defconfig, but not in the stmmac Kconfig.

Maxime

