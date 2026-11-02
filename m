Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608174;
	b=2U+kIUwToV83ZPffN7tlbm8b8W1jopdqxyXkWwuPrp0WNqu1h/8jaGoT6rj3tLM50sgA
	 aDui79ULmg+idriB2Z3Gxm4r55A8ebA9S5IUYf9Nhl1ZjmvVy6seFvpzkZEgJn9qzExi1
	 nwPcPCJ1LzNK1vKbe9NipJCTHoEhEo1l/g7mOEZLoxrUurgNWlWYZTlTCrrPsddSOBqMt
	 +fZsV07TlG2BY4mFcq58/IMxeu5tLM0asG52rdOIDVhaTXO0IkWpBvb2Vx0r3pAmAD67V
	 lBpeUvGnv3LZ4PstMolGHaCw+l16GSqeOHjg0vHeXrGGF2Kz0hyG83uXzJwVMBLV0VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608174;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=SVPciQr1s9BDQkZqo0irUvEcCQ8iKbnU6l79MHO+xgQ=;
	b=3VZFvRzaDHYUA3WdwAOFgnB4uJwt6yf2BEJtRp+GBLPcXpewsftDzlLp2SFF/3c0IgS9
	 Pk00X5heOOJgMKcNVZv79Z3W7fbI+/zM0xfSDAeWbUo4wv+JZEvVhKQ25CI2j5HRgd38X
	 riNn/ZRyxGvjjTQF0y0X+5rkyXrcdMSaGraVbPcupy/lelnK+Phnh1C2GU2JgnZYJLuop
	 CDnFKwDemJ/WN/4ZRSDTL/RjQa5eGfK3J3ettSQ5/peWZvF+EsXUULs3C083R2su4yupw
	 DSyNd7wF/IDDU6HL+e2zFlDEgwM3Jcs0jGEnYahpq4nmE1HVh9SQOfCb4WiBNX/u7zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=hZ6CDGNv;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99559606A324;
	Mon,  2 Nov 2026 08:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99559606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=hZ6CDGNv
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25664A1587;
	Mon, 02 Nov 2026 09:29:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793608163; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SVPciQr1s9BDQkZqo0irUvEcCQ8iKbnU6l79MHO+xgQ=;
	b=hZ6CDGNvoqmbNZETgMYos71ChglJxAY5D1UMWnFszUL9QlgIvEgwNXd2Fv3qIjv1OBaSoA
	1hehzwuSyn0Ktu816SVRZmeF0tPvTV0Ra2OJO7KKuYSjQ/ILeONbIIvgrpvcsX/3e3AgcC
	eZYOvT3CUa9vRaYKueSZrRbJplxNGPexFCAeOf0QfV9xAd2uKHUS/qHrKiQUf92s34ChUI
	Ofaw9ff8zVFsn+b9KUxUrpBzq/T8hO6kVumu711LTbLtlEX0fW0xagDc2L7cpcJUe7WIkf
	ygAKn7SkXoYQBj+dDBYxoSETGPoPKAdZycjEiSpajFA/54XP75s8d/05JJeydQ==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 02 Nov 2026 09:29:18 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Magnus Leatti <magnusleatti@kernelriot.com>
Cc: Yao Zi <me@ziyao.cc>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Nazim Amirul
 <muhammad.nazim.amirul.nazle.asmade@altera.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-motorcomm: mask the MISC interrupt
In-Reply-To: <20261102080938.2955-1-magnusleatti@kernelriot.com>
References: <20261102080938.2955-1-magnusleatti@kernelriot.com>
Message-ID: <805aeb73d9e32b237bcb30c8fd44ffed@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Magnus

On 2.11.2026 09:09, Magnus Leatti wrote:

> [...]

> Russell, d3265c19b35d ("net: stmmac: xgmac2: disable RBUE in default RX
> interrupt mask") describes a similar storm on xgmac2. Should dwmac4 do
> the same? I have only tested the glue change.

AFAIU RBU is the cause. Dropping it in dwmac4, as Russel did in  
d3265c19b35d,
would cover all multi-MSI users.

> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c 
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
> index 124fcd55a..610d533b9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
> @@ -30,6 +30,7 @@
>  #define OOB_WOL_CTRL				0x1010
>  #define  OOB_WOL_CTRL_DIS			BIT(0)
>  #define MGMT_INT_CTRL0				0x1100
> +#define  MGMT_INT_CTRL0_MASK_MISC		BIT(21)

Where is this bit documented? The vendor driver?

>  #define INT_MODERATION				0x1108
>  #define  INT_MODERATION_RX			GENMASK(11, 0)
>  #define  INT_MODERATION_TX			GENMASK(27, 16)
> @@ -172,7 +173,11 @@ static void motorcomm_reset(struct 
> dwmac_motorcomm_priv *priv)
> 
>  static void motorcomm_init(struct dwmac_motorcomm_priv *priv)
>  {
> -	writel(0x0, priv->base + MGMT_INT_CTRL0);
> +	/*
> +	 * Nothing services the MISC source, and once raised it never
> +	 * deasserts, so keep it masked.
> +	 */
> +	writel(MGMT_INT_CTRL0_MASK_MISC, priv->base + MGMT_INT_CTRL0);

Doesn't this turn off the stmmac MAC irq on vector 5 completely? If so,
please mention it in the comment.

Also, does the MSI fallback still get RX/TX interrupts with MISC masked?

> [...]

Thanks,
Nicolai
