Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D224EDCCF;
	Fri, 18 Sep 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734346; cv=none; b=dZExvFIMG0THy8tVrUJY7HoHAuzVqxjbxi3tH4QMFGkASpDtQqEpMPABXn9piT4zCm+BpMmSH+jVZKfPNVDjxruwstRW89DHrhFegPwYcYR3d5SdeYw3JDIFm9QxduHK+5eIwOWsALaFkpTxGgxOj01mbIIZzo1NZfblLljT/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734346; c=relaxed/simple;
	bh=pwoth8A68uKPG0mGoQjNPVpeIDll2HuWzMUx+qHpwkk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BCV9LJTjUuMGOQPUPM6E0u+Qiuu+Cm22vaRIfulDfUVUv0gCDzVWHkviY6b4ER9V/IPV29w3hRZ5T+egs95xFs/A5AVwrE0vb0T6a34uesJZWk6HNGymz3sELwecglBnOxHheUS+rAaFGQ6uFWW9/lEIIsxSEEnZC+24mAzCAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=e9Fyd26y; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="e9Fyd26y"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06695A0350;
	Fri, 18 Sep 2026 14:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789734335; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QNYlyICHDiAtyzbtSm0WmmoGzJl3BdJ+V4spo9bThFU=;
	b=e9Fyd26yQqmSW8ysRa3AoKtnYuq3pFrXjn7p/7K2qYMpUHkXi5USPm4YZVNPkSf8VLfe+w
	YOd+n9cN3EKDLom5BLPVHdMt5AwlWd0eYhYe1lePleDHFisV0A1BVrwAdmrH/3JarZhdb3
	hyyeia5Ds8EItRyit+65PTkgFDsKtKC+EchfhZIwPiAk+/DwX+L9/93/Gc+dkPnOvPjG5B
	vpe8QW/udvQ0D2yk4ImyFMVxrdooiCSkI5BAFTNEeIoRuv3Tnuftf4OaaEUXVVnUouyOXD
	A6V2YXpwAYdHoq8nQKPEEyyFqcPNO8x0MI2mJ3UpoLEm6r/92aP1d+MMvfXSGQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 14:25:16 +0200
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
Subject: Re: [PATCH net v4 5/7] net: stmmac: dwmac4: Use the correct bufzise
 when the len is exactly 8K
In-Reply-To: <20260917215339.2022523-6-maxime.chevallier@bootlin.com>
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
 <20260917215339.2022523-6-maxime.chevallier@bootlin.com>
Message-ID: <4b3c26c482ac1d26f39b53fea072e4d1@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime

On 17.9.2026 23:53, Maxime Chevallier wrote:
> DMA bufsize selection isn't made on the MTU but the actual frame 
> length,
> so including the L2 header. On DWMAC4, if the len is exactly 
> BUF_SIZE_8KiB,
> the next larger size is incorrectly selected.
> 
> Lets fix the comparison and while at it, rename the parameter from len
> to mtu.

Isn't it "[...] from mtu to len"?

> 
> Fixes: c3efed5ad1b0 ("net: stmmac: Enable dwmac4 jumbo frame more than 
> 8KiB").
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 4 ++--
>  drivers/net/ethernet/stmicro/stmmac/hwif.h         | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/ring_mode.c    | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c 
> b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> index 2994df41ec2c..c6a8f8d73501 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> @@ -474,11 +474,11 @@ static void dwmac4_set_sarc(struct dma_desc *p, 
> u32 sarc_type)
>  					  sarc_type));
>  }
> 
> -static int set_16kib_bfsize(int mtu)
> +static int set_16kib_bfsize(int len)
>  {
>  	int ret = 0;
> 
> -	if (unlikely(mtu >= BUF_SIZE_8KiB))
> +	if (unlikely(len > BUF_SIZE_8KiB))

Should we drop set_16kib_bfsize() instead?

After 6/7 it looks to me like the same test as the first branch of
stmmac_set_bfsize(). The caller ends up there anyway when it returns 0
and chain_mode_ops doesn't have it at all.

>  		ret = BUF_SIZE_16KiB;
>  	return ret;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h 
> b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 04dafec021b4..de7aa6d28148 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -540,7 +540,7 @@ struct stmmac_mode_ops {
>  	bool (*is_jumbo_frm)(unsigned int len, bool enh_desc);
>  	int (*jumbo_frm)(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>  			 int csum);
> -	int (*set_16kib_bfsize)(int mtu);
> +	int (*set_16kib_bfsize)(int len);
>  	void (*init_desc3)(struct dma_desc *p);
>  	void (*refill_desc3)(struct stmmac_rx_queue *rx_q, struct dma_desc 
> *p);
>  	void (*clean_desc3)(struct stmmac_tx_queue *tx_q, struct dma_desc 
> *p);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c 
> b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
> index f7949419eb9f..d2f0c321661d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
> @@ -124,10 +124,10 @@ static void clean_desc3(struct stmmac_tx_queue 
> *tx_q, struct dma_desc *p)
>  		p->des3 = 0;
>  }
> 
> -static int set_16kib_bfsize(int mtu)
> +static int set_16kib_bfsize(int len)
>  {
>  	int ret = 0;
> -	if (unlikely(mtu > BUF_SIZE_8KiB))
> +	if (unlikely(len > BUF_SIZE_8KiB))
>  		ret = BUF_SIZE_16KiB;
>  	return ret;
>  }

regards
Nicolai
