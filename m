Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690643;
	b=KgxSMD8lZngeunUza56bzKWsyjSwSitH0YexBXYvnEEHozKNTPse7mpE5ARUttcbtvJT
	 E6E3vSw7whRmJOwyU+/FXcIXIeq5mUPRoT5qJRNuHbb730Sh4+ytdBaV/es9GAriWZg4F
	 sK6uzJflQ7Iv8vU0kbaJ6QC3wT7O0E05orOMK/Ta49NGNa2IjJ0iv0HVL4XWuCNkHjRe/
	 lmR+8UXSNYghnXJZlErSF8o7EPge3SliF1VAiWgG8amG6NA6LqQseQ4YwC68MGwrY00go
	 vYB1QfqcNGWEQi1jdT4twXv5P8mYqAQnSEyr4dSzYk4joZzAWsiZPgWIwD7bVW2YARg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690643;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=90PpyRvqw50zWmq9+jh1atWjcGYKGRTrDoZ7I20u5a0=;
	b=r0ZIS86OZvgzPWswSSoiGWKgNfBd+SvG6mNVhkyZrMlwsTufWYkYSCeS5+TwV6Sw9t/G
	 aOxpDp/OaraYoKaHxFRmtpTJq/k33us2vsc5ygdCD86crwEgLwMrRNJepkg7VTmP964nC
	 nOtcYv/+BoijW900PSzsT9wYR3DIFXfxVIalppFZzSVp2rjoui3XcuC8jXGeDoYT8wq9e
	 I9Me9inP1LDjqmFdzyfCTfkgN/fGB9w6QQBSdBthMkMEfR4o4hKOIjCe868jAccUiCMfU
	 5qEqG4q8ygJ0/4nbYy2EmJ6jC94Z1MLIWkYuEr4zhiWYCFOZIzthwcTqY5VOP+CO+Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C9606AB50
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF8C9606AB50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e09aa5264so20309f8f.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792690641; x=1793295441;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=90PpyRvqw50zWmq9+jh1atWjcGYKGRTrDoZ7I20u5a0=;
        b=ZxhOR2ohsXibSQpSBrgakSzbtOSxLTFZ7V14pw/pVfBj8/xKS0sksRGhXJSc9Dt/wZ
         sE9LDHek7QrUhMK6oGTJdqPfaswJNEz3lTU6J6x/MWnULmX42n8P9+ty+ydMdVP0bjj4
         HLvfZnMBnR1tdSVcj8CT49PjAumtFH9Sg9CKOQ3j1dpUvjNQIX7SqYQBauHHqRBkUlFn
         9ldZGiLIN8Mrpzj+8gD9moPxt3EtIjBqA6BWCdv/r3T232zBJ9621Da7vj5Hb6693feQ
         Ve/e+j60T5l86t6I4wFzcnKRoT54NVFwKQa2i2y/nmTOnsE3Rsojl/4Y8U35PJFo6o0x
         GtKg==
X-Forwarded-Encrypted: i=1; AKwUvBypoWuN+nw9usxoVKcFS76lO5s22vRgWfoEzTxK9jvJ1hr6UMrXKPqJRbtMB5ZyC2Mdylruw/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdaxSeq7l+J05Co3Q/cZS/x3KC8iu85zYT+qJQ/kk3Bjwk36gb
	4LKMyP/e1fYDMLdx9HX5jmIkL1lIgALZ6deCqhCAUW4qh/Lpdr2HT2Ay
X-Gm-Gg: AYBFou06qAELUETsvwM6OlzDGc309I58A3rfWG3517tFJAVvMgVBu21ubuojgXDdW42
	8h0s9PgI4c8HbVhODJfZgOnnjcQK6VP0YQ0HvKBfAlc4kovZnttjFNU9Yw0O+kABOsuLrfhdqxs
	gHSg8cq4awLk31ccEva2Ss4lYSnLFDFkE2YvvCLMY7NuAivZ5/KmmavM+Gf64ATw9oOPiGQPp2P
	3FrTVd/oCK8/4GaPiOAV83c0Kt4QdP/7UjwAaSniAlC6VGzvjb6urtslP+z1NNpxrrMQiDp7cru
	RmwKH+KM/bgOJPBNkAESmkPITAJg9bjPeS6v0JtNX0fS3nLFP5QJbg2Gvmz3ouMCLB06Uw0UEgZ
	hHiy+rQxHghzUoA8aYeYVH/y7+9VihnorgEkPTNfkuYnekezQho52CbFZ7In7RL0aY+KhqbAS4l
	ZR4K4oS+bwPxNOhy+xeAQMMftCPBCULAxX8PSABJe0Q4bQhUTRQmp1BvN9zm3haNUVqrYxDQxso
	rD3xz6agqxy9BHlnW/onzOQEuNY/oULTPsTo1MOhVu3N0zeWHx9ortIErLOvdLYEc3aXo4eHzhf
	HWcxswj99afVprWNA4bhkMd1mhE29JNW
X-Received: by 2002:a05:6000:4e:b0:48d:f3a4:a6aa with SMTP id ffacd0b85a97d-48e264f2be7mr9021652f8f.35.1792690640831;
        Thu, 22 Oct 2026 10:37:20 -0700 (PDT)
Received: from [192.168.1.135] ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f0bc2sm13391825f8f.1.2026.10.22.10.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:37:20 -0700 (PDT)
Message-ID: <00b94eed-fe1b-4cf3-a4ed-12813faacb86@linux.com>
Date: Thu, 22 Oct 2026 18:37:19 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] net: stmmac: dwmac-meson8b: apply the RGMII delays
 the T7 way
To: Andrew Lunn <andrew@lunn.ch>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261010105900.247342-1-tanure@linux.com>
 <20261010105900.247342-5-tanure@linux.com>
 <a1c0b76b-7b67-43e9-af15-3139f17d7fe7@lunn.ch>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <a1c0b76b-7b67-43e9-af15-3139f17d7fe7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/2026 13:30, Andrew Lunn wrote:
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
>> @@ -82,6 +82,7 @@ struct meson8b_dwmac_data {
>>   	int (*set_phy_mode)(struct meson8b_dwmac *dwmac);
>>   	bool has_prg_eth1_rgmii_rx_delay;
>>   	bool has_pipeline_clk;
>> +	bool mac_applies_dt_delays;
> 
> Please can you invert this and call it broken delays.
> 
> We should make it clear that new devices should not set this, because
> it wrong, broken.

Moved to a function for T7. And the previous SoCs have their own 
function which gets a comment that new SoCs must not use it.

> 
>> +static int meson_dwmac_init_dt_delays(struct meson8b_dwmac *dwmac,
>> +				      struct plat_stmmacenet_data *plat_dat)
>> +{
>> +	struct device_node *np = dwmac->dev->of_node;
>> +	u32 tx_delay_ps = 0, rx_delay_ps = 0;
>> +	phy_interface_t phy_mode;
>> +	bool mac_tx, mac_rx;
>> +
>> +	mac_tx = !of_property_read_u32(np, "tx-internal-delay-ps", &tx_delay_ps);
>> +	mac_rx = !of_property_read_u32(np, "rx-internal-delay-ps", &rx_delay_ps);
>> +
>> +	/* one step is a quarter of the RGMII clock period, 2ns at 1Gbit/s */
>> +	if (tx_delay_ps > 6000 || tx_delay_ps % 2000)
>> +		return dev_err_probe(dwmac->dev, -EINVAL,
>> +				     "The RGMII TX delay must be 0, 2000, 4000 or 6000ps\n");
> 
> tx-internal-delay is not listed in amlogic,meson-dwmac.yaml. Please
> could you add it, and list the valid values.
Patch 2 of this series adds it to the T7 block with the valid values.
That changes in v4, see below.
> 
> Do you have access to the datasheet? Could you check these numbers are
> correct, because they are larger than typical. 4ns, and 6ns makes no
> sense, the RGMII standard only calls for 2ns.

Yes. The field is not a delay line. It selects the phase of the TX
clock sent to the PHY: 0, 1/4, 1/2 or 3/4 of the clock period. At
1Gbit/s that is 0, 2, 4 or 6ns, which is where the numbers come from
(the existing amlogic,tx-delay-ns property lists the same four). Only
1/4 is a usable RGMII delay; 1/2 is an inverted clock and 3/4 is a 2ns
lead. And since it is a fraction of the period, the 2ns is only true at
1Gbit/s, at 100Mbit/s the same setting is 10ns. I agree 4000 and 6000
make no sense.

> 
>> +
>> +	/* the RX delay line moves in 200ps steps and reaches 3000ps */
>> +	if (rx_delay_ps > 3000 || rx_delay_ps % 200)
>> +		return dev_err_probe(dwmac->dev, -EINVAL,
>> +				     "The RGMII RX delay range is 0..3000ps in 200ps steps\n");
> 
> Please could you listing these values in the binding.
> 
> Also, mark that amlogic,tx-delay-ns & amlogic,rx-delay-ns are not
> valid for this compatible.
The RX values are in patch 2 as well, the T7 shares the G12A list
(0..3000ps in 200ps steps); v4 drops the 0. The two vendor properties
are already rejected for the T7: they are only defined for the older
compatibles and the schema has unevaluatedProperties: false. v4 adds an
explicit "false" for both in the T7 block so that it is visible.
> 
>> +
>> +	phy_mode = phy_fix_phy_mode_for_mac_delays(dwmac->phy_mode, mac_tx,
>> +						   mac_rx);
> 
> This is not correct. This function assumes mac_tx and mac_rx are
> Boolean values, the MAC is applying the full 2ns delay. However, if
> rx-internal-delay-ps is only providing 200ps, that is not true.
> 
> I would prefer you keep to the usual way of doing things. Allow the
> MAC to apply small tuning delays, but have the PHY do the 2ns. So
> don't make any modification to phy-mode.
> 

OK. v4 does not touch phy-mode. rx-internal-delay-ps becomes the tuning
the MAC adds on top, 200..3000ps. On the TX side the T7 has nothing
small to offer, the only step is the 2ns phase, so v4 does not accept
tx-internal-delay-ps on the T7 at all, in the binding and in the
driver. The VIM4 then uses plain rgmii-id with the PHY adding both
delays. That also removes the wrong claim in patch 7 that the RTL8211F
TX delay does not work; the real cause was a bootloader value left in
the glue register, details in my reply to Martin on patch 7.
>>   static int meson8b_init_rgmii_delays(struct meson8b_dwmac *dwmac)
>>   {
>>   	u32 tx_dly_config, rx_adj_config, cfg_rxclk_dly, delay_config;
>> @@ -411,32 +455,34 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>>   	dwmac->dev = &pdev->dev;
>>   	dwmac->phy_mode = plat_dat->phy_interface;
>>   
>> -	/* use 2ns as fallback since this value was previously hardcoded */
>> -	if (of_property_read_u32(pdev->dev.of_node, "amlogic,tx-delay-ns",
>> -				 &dwmac->tx_delay_ns))
>> -		dwmac->tx_delay_ns = 2;
>> -
>> -	/* RX delay defaults to 0ps since this is what many boards use */
>> -	if (of_property_read_u32(pdev->dev.of_node, "rx-internal-delay-ps",
>> -				 &dwmac->rx_delay_ps)) {
>> -		if (!of_property_read_u32(pdev->dev.of_node,
>> -					  "amlogic,rx-delay-ns",
>> -					  &dwmac->rx_delay_ps))
>> -			/* convert ns to ps */
>> -			dwmac->rx_delay_ps *= 1000;
>> -	}
>> -
>> -	if (dwmac->data->has_prg_eth1_rgmii_rx_delay) {
>> -		if (dwmac->rx_delay_ps > 3000 || dwmac->rx_delay_ps % 200) {
>> -			dev_err(dwmac->dev,
>> -				"The RGMII RX delay range is 0..3000ps in 200ps steps");
>> -			return -EINVAL;
>> +	if (!dwmac->data->mac_applies_dt_delays) {
> 
> I suggest you do this at a higher level. Either call this function if
> _broken_delay is set, or the other one.

Done through the callback. Probe makes one call, and the parsing of the
vendor properties moves into the older function.
> 
> 	Andrew

