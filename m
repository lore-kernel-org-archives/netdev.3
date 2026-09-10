Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22657C703;
	Thu, 10 Sep 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064037; cv=none; b=Xf5a7WGuKl7wi3+frj9BbIZzdLDe1FRhOmkqO4LQZXbAZ2s/fJV3wlgTlV5ypx2CJKP3A1rbrTsWFDjegXBBFvhomS+MaxjB8mUx1g82ukIB6OszuzeiDjUyBaCD9FcSFrHqUnTFvJBwgoAzFXrdGA7MjosBf8+651yOp+dkJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064037; c=relaxed/simple;
	bh=aBLp6XqOnutWnC4U8VHFXPHKvXDrPIdPy2K8iUuYW9U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JzwlM6JfJ6B6QYoZUp66ovID3JYXOQ55VJf8JjgvvjDSe6uSXloGh73KiT3JDuXSq3sNBB/0Aa5pOyNrH9yyIyAZPs+quB04eXSpsPDIWxhq6iYIdDfm+82A835/MLtQB6MJnDuQerefgob+15d74SvQOMrhKVx819rAMNA1obM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=3a+j74DP; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="3a+j74DP"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7832FA0580;
	Thu, 10 Sep 2026 20:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789064031; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gTba1NzUG5xbAP4x+gUk6us1Ud5EI0aPxbPupazDE+E=;
	b=3a+j74DPcEdAczUXBJ2bDGgzvEK5RyO+Ay2DOQr7R33QufMvsp0nffsp1zBVquSVDnGc5J
	TyUU2qWlioSFDGm8grYtMTRTx4Z7FJi0MHY7SozgArH83dIq4qLNIQJ4TTeUnVLhCuuEu3
	umKNP+Wj1eWVFll8NeAzku9iC5S2fqB/tREeCLzXAd/OL0UXxUyuo1y1y7AvaLrSfy9ecr
	MnfBY70d5ciTr5nZcygs98uzPqgKsZbFySqcYqC32OM08pa4hN2lwPY2wjnnUStUIHDMDC
	WHend6RCCH8FZeXtDesIMK7JWPYMYZiGJnoF5CLy7pwMz432k+8WS7l2GKosjA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 20:13:50 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Emil Renner Berthing
 <kernel@esmil.dk>, Minda Chen <minda.chen@starfivetech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de, David Laight
 <david.laight.linux@gmail.com>
Subject: Re: [PATCH net v2 6/6] net: stmmac: selftests: Account for alignment
 shift on dwmac1000 for Jumbo test
In-Reply-To: <20260910151404.976753-7-maxime.chevallier@bootlin.com>
References: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
 <20260910151404.976753-7-maxime.chevallier@bootlin.com>
Message-ID: <999537422e65948cc80714942b3d152a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10.9.2026 17:14, Maxime Chevallier wrote:
> On dwmac1000, we currently only support single-descriptor frames. The
> Jumbo test started failing when NET_IP_ALIGN was added to align the IP
> header, as this tests tries to send the biggest possible frame.
> 
> On dwmac1000 the DMA transfer is aligned on 4-bytes, so adding a 2-byte
> shift at the start-of-buffer address means it takes a whole extra 
> 4-byte
> DMA burst to receive the Jumbo packet, causing it to spill over the 
> next
> descriptor.
> 
> This doesn't seem to happen on dwmac4 and xgmac that appear to 
> correctly
> handle unaligned xfers (only tested on dwmac4)
> 
> Let's account for that in the Jumbo test, reduce the size of our big
> packet by the align size.
> 
> Fixes: 23680bf5f8c6 ("net: stmmac: restore NET_IP_ALIGN in the RX DMA 
> offset")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index ec56ee0031ab..fc8d69260f43 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> @@ -1776,6 +1776,9 @@ static int __stmmac_test_jumbo(struct stmmac_priv 
> *priv, u16 queue)
>  	struct stmmac_packet_attrs attr = { };
>  	int size = priv->dma_conf.dma_buf_sz;
> 
> +	if (!dwmac_is_xmac(priv->plat->core_type))
> +		size -= NET_IP_ALIGN;
> +
>  	attr.dst = priv->dev->dev_addr;
>  	attr.max_size = size - ETH_FCS_LEN;
>  	attr.queue_mapping = queue;

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
