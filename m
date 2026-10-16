Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F836E470;
	Fri, 16 Oct 2026 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150919; cv=none; b=OWtSvQErwwNnlDtxTvL6uxyC25y7y2RezG9YDA4wu/gJYmxnjHhxaBniPJWsIDg2jEIVSVrOq8RgrbdWVc0XxOxEbnLyGYuL1+Ee3NhxLaqyjI7ERP0tbqj5KKVejQu795XpWLsIScBvC2Pg6NmR3dWMMw44CCUgszZ0r6qrWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150919; c=relaxed/simple;
	bh=EFwob/W2pAfLqQXUwIN8VgnV11Dl4LNwQ4HTGLe/0EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTNB/lLRGTObYgu/AzrklqbND7+6cCX4gdtIwANEiTOSY0hLGfjwctU9tPYmiIPnqECZCAMXO5XbF6AlbDp35LGmJZdhCzJRtQYepwo7IWEpM2FRskcRTKiu0OyXp7qgkp+1ocCmakgMorF/hyKoMyGpazHFMvssQSBG97G6dXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0Cn16zag; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0Cn16zag"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E67A91A1254;
	Fri, 16 Oct 2026 11:41:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9E296075D;
	Fri, 16 Oct 2026 11:41:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A664410328113;
	Fri, 16 Oct 2026 13:41:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792150909; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=hGJBgDI14BOObFhSGsJ3MZ62g06s99V+45xcOlRDFXQ=;
	b=0Cn16zagvyaapyOS8DxB4yFsLERkVp/A1bg0W/VH+IKndZS55hQwICWuMc30/BLkk2Td+3
	3x875LnXJtmhNRtwkc/wxxeYlYJT+urW/LyVl68vs15cMS542/Km3VIH/SEJShSEEPhklM
	jlIQ5R+Wrnz9cn7MLpIbD+i5QGya49JzXvFcUqG1AFZsoVoAtJtUWWVaHrXtijRE5cu9it
	zovNo1RbdAHTjJnJXMO7HtwNEk7jNUXqsBgqSAAeMwBrGciU9OhuElYXmDHzcFRvRP43jV
	eiJUiK3YfkcsC6CxbwOwfmVky+OFQWEVfdrqqGmCbXttaDgMeB2l9Kj6qQQS9Q==
Message-ID: <eabe305d-bb0f-4927-919a-21b025ec145d@bootlin.com>
Date: Fri, 16 Oct 2026 13:41:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 7/9] net: stmmac: mediatek: use TX clock phase
 shift in RGMII mode with 1Gbps speed
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Biao Huang <biao.huang@mediatek.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Eric Dumazet <edumazet@kernel.org>
Cc: kernel@collabora.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
 <20261016-dwmac-mediatek-mt8189-v3-7-25daf2bbcf35@collabora.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261016-dwmac-mediatek-mt8189-v3-7-25daf2bbcf35@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/16/26 12:31, Louis-Alexis Eyraud wrote:
> Currently, if the devicetree of a board based on MT8195 (or compatible)
> configures the use of RGMII PHY mode and insert at MAC level additional
> delay on TX clock at MAC (with "mediatek,tx-delay-ps" vendor property
> presence), the driver inserts this delay by setting TX coarse delay
> bits (bit 0 to 5) of the Ethernet control 0 register from the
> peripheral configuration (pericfg) at probe time.
> 
> The HW delay macro circuit, that these bits enable, can be affected by
> external factors such as environment temperature or vcore voltage and
> thus applied delay value can change. For 10/100M link speed cases the
> variations are not problematic, but it can be for 1G link speed cases,
> that require much precise and stable timings (around 2ns).
> 
> The Ethernet control 0 register of MT8195 SoC has another bit (bit 22:
> MT8195_RGMII_TXC_PHASE_CTR) to enable the TX clock phase shift and
> insert a 2ns clock delay in a more consistence way, as it is not
> affected like the HW delay macro circuit under the same conditions.
> This only works though for 1G speed cases so it cannot be set
> unconditionally at probe time, thus needs to be set after link speed
> negotiation.
> 
> In order to allow the TX clock phase shift use in the driver, add in
> the variant platform data and probe sequence the support of
> fix_mac_speed callback, provided by dwmac core. This callback allows
> driver configuration update when the link speed has been negotiated.
> Implement it for MT8195 so that, when a delay needs to be inserted
> for TX clock (due to the devicetree configuration), it enables the
> TX clock phase shift in Ethernet control 0 register only and only if
> the PHY mode allows it and negotiated link speed is 1G, and fallback
> to the HW delay macro circuit otherwise.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index 7dd46cd5a49e..4b2d5280f703 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -104,6 +104,9 @@ struct mediatek_dwmac_variant {
>  				       u8 phy_intf_sel);
>  	int (*dwmac_set_delay)(struct mediatek_dwmac_plat_data *plat);
>  
> +	void (*dwmac_fix_mac_speed)(void *priv, phy_interface_t interface,
> +				    int speed, unsigned int mode);
> +
>  	/* clock ids to be requested */
>  	const char * const *clk_list;
>  	int num_clks;
> @@ -430,9 +433,65 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
>  	return 0;
>  }
>  
> +static void mt8195_fix_mac_speed(void *priv, phy_interface_t interface,
> +				 int speed, unsigned int mode)
> +{
> +	struct mediatek_dwmac_plat_data *priv_plat = priv;
> +	const struct mediatek_dwmac_variant *variant;
> +	struct mac_delay_struct *mac_delay;
> +	u32 tx_delay_stage_val, reg_offset;
> +	u32 reg_val = 0;
> +
> +	if (!priv_plat)
> +		return;
> +
> +	mac_delay = &priv_plat->mac_delay;
> +	variant = priv_plat->variant;
> +
> +	if (!mac_delay->tx_delay ||
> +	    (interface != PHY_INTERFACE_MODE_RGMII &&
> +	     interface != PHY_INTERFACE_MODE_RGMII_RXID))
> +		return;

I don't think this is right. PHY_INTERFACE_MODE_RGMII in that context comes
from the devicetree, and therefore means "RGMII delays are implemented through
traces on the PCB", the MAC isn't supposed to insert any. RXID means "TX delays
are on PCB, RX delays are internal).

I'd expect the condition here to be:

> +	if (!mac_delay->tx_delay ||
> +	    (interface != PHY_INTERFACE_MODE_RGMII_ID &&
> +	     interface != PHY_INTERFACE_MODE_RGMII_TXID))
> +		return;

Maxime
