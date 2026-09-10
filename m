Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B01356766;
	Thu, 10 Sep 2026 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065758; cv=none; b=svndf2Bj8IoW6zQ+VZK5QfVroGxQS53R4NYUHWo9sgdMtVr9XAnEU3H8JwKXBiNsXrz5q36Z6OOTFK8cEmObQGtirgJssk11gVzK3ZpMbtEqSauorf96l4jY5ibUI6S/UOaHwiXV7mceJtJzSN5upNyMu01DN7XS6ZpjvkZPv4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065758; c=relaxed/simple;
	bh=Rm395aCw/iOb4Bv+HzeK6TTDZkzeH/Tj/YSzAXyj0iw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JZtZqzY6wsTVFf/J8WnDJj4HKoKfLRes5LFjgdarqyJEBhiPPabuM02yUtDJPMmFSsuBbn9JKTiPDVWBV9Grdvw0ewE1HLDYh/2BqcNQn1Io0XYE+ChlagdjbpF0eLu+ty/m3Mrxu6pHeaN91VBd2VWy5PGv8N7PCHuHGu/Lh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ZeGzmp4e; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ZeGzmp4e"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2234A8F56;
	Thu, 10 Sep 2026 20:42:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789065751; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=J6vYeDOQvc6HcH8O/wl4zA/DD/Gh7wd3PXwiCbaa1Cs=;
	b=ZeGzmp4ez3/4rNyR8wD9FEb8lILhghscZ1gI9NPMmVEP1bdrF2F0dqngv0faFZqKJ52Yvt
	IMmt4Riltkkl5SQy1LcxtkBBNJy/4Xrg0xQ+Jzpa7GgUYWpN9nHUC/maFZgClgkDoRkaTA
	D5L38LJiqpRlVsSOIJ88TltfjUM81oOiljodf8dCKEtJgqNqy3825ddtu36Up/Kt/1hFot
	i2zlaqbpeziQvFaIIQDHHZ/Uk6yccHnIKTX9iGk2n2I6d056qqpetV2vFWa7NlQdrW+h/N
	LVw8ZmyVAuM6TeR8/HjhLCmtM3iWtxwapU05x2mqSTijheydsCmBvuJrLuzdgg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 20:42:22 +0200
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
Subject: Re: [PATCH net v2 5/6] net: stmmac: size the RX buffers from the
 frame length, not the MTU
In-Reply-To: <20260910151404.976753-6-maxime.chevallier@bootlin.com>
References: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
 <20260910151404.976753-6-maxime.chevallier@bootlin.com>
Message-ID: <2489a0482751f06eb4da702987c717e5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10.9.2026 17:14, Maxime Chevallier wrote:
> When picking the buffsize to use based on the MTU, we shouldn't check
> only the MTU value, but also :
>  - ETH_HLEN for the L2 header,
>  - up to 2 VLAN tags,
>  - the FCS,
>  - the NET_IP_ALIGN
> 
> The default bufsize is 1536 bytes, which is enough to contain all the
> above so this hasn't surfaced before, but the addition of NET_IP_ALIGN
> to the start of buffer address tripped the Jumbo selftest, leading to
> this discovery.
> 
> With that, we don't need the '>=' checks on the buffer len, we can use
> more consistent comparison operators in stmmac_set_bfsize.
> 
> Fixes: 286a83721720 ("stmmac: add CHAINED descriptor mode support 
> (V4)")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 5fe7e95fdd34..3664a298574a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1536,17 +1536,17 @@ static unsigned int stmmac_rx_offset(struct 
> stmmac_priv *priv)
>  	return NET_SKB_PAD + NET_IP_ALIGN;
>  }
> 
> -static int stmmac_set_bfsize(int mtu)
> +static int stmmac_set_bfsize(int len)
>  {
>  	int ret;
> 
> -	if (mtu >= BUF_SIZE_8KiB)
> +	if (len > BUF_SIZE_8KiB)
>  		ret = BUF_SIZE_16KiB;



> -	else if (mtu >= BUF_SIZE_4KiB)
> +	else if (len > BUF_SIZE_4KiB)
>  		ret = BUF_SIZE_8KiB;
> -	else if (mtu >= BUF_SIZE_2KiB)
> +	else if (len > BUF_SIZE_2KiB)
>  		ret = BUF_SIZE_4KiB;
> -	else if (mtu > DEFAULT_BUFSIZE)
> +	else if (len > DEFAULT_BUFSIZE)
>  		ret = BUF_SIZE_2KiB;
>  	else
>  		ret = DEFAULT_BUFSIZE;
> @@ -4063,7 +4063,7 @@ static struct stmmac_dma_conf *
>  stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
>  {
>  	struct stmmac_dma_conf *dma_conf;
> -	int bfsize, ret;
> +	int bfsize, len, ret;
>  	u8 chan;
> 
>  	dma_conf = kzalloc_obj(*dma_conf);
> @@ -4073,13 +4073,15 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, 
> unsigned int mtu)
>  		return ERR_PTR(-ENOMEM);
>  	}
> 
> -	/* Returns 0 or BUF_SIZE_16KiB if mtu > 8KiB and dwmac4 or ring mode 
> */
> -	bfsize = stmmac_set_16kib_bfsize(priv, mtu);
> +	len = mtu + ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
> +
> +	/* Returns 0 or BUF_SIZE_16KiB if len > 8KiB and dwmac4 or ring mode 
> */
> +	bfsize = stmmac_set_16kib_bfsize(priv, len);
>  	if (bfsize < 0)
>  		bfsize = 0;
> 
>  	if (bfsize < BUF_SIZE_16KiB)
> -		bfsize = stmmac_set_bfsize(mtu);
> +		bfsize = stmmac_set_bfsize(len);
> 
>  	dma_conf->dma_buf_sz = bfsize;
>  	/* Chose the tx/rx size from the already defined one in the

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
