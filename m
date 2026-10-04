Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5711F39A06F
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127707; cv=none; b=recsCC5HFFAcTMmkEQGWjMK5UNjFVRwWmkaultdWQxddKlNMUTRJInJZ/3G83jRF2bJGbJD0/1vBTg5Ikd2NRKiyY6M3DLWet+VYJrusn2NwLgDAXP3EPkPVW/nzaVXTi4BU3wU8dugzre6YEX+GgeXkG2X2wwrEwXKgZpHAePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127707; c=relaxed/simple;
	bh=5mYst5Ullbp+HHdr6Uh5aXV63tNmZJUMGFOFHhbt800=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lwwG24qWWHTHnhHPVb2W5YFSfyJRyRuRiaxch2fLsIR6UXkrxeirmiMt9XOWb9QqkxIuWZ3ksxJ3CYb7/8pl/k6pdtukS1i/GmmCgcmJ3jS1iQGCmzh6WHF9338e80UDGsYO4dVGZ/AP/4AdrQCJrCuT0voQ3Nsw8R5Wylt2xyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HX7Q4eRR; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HX7Q4eRR"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so9281945e9.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791127704; x=1791732504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WA4cfENfPEbrDvuT53Cr6d7+lPDcZpBsXedFYV5NI20=;
        b=HX7Q4eRRpcUbqae8boTKZSbgrk+zYFV3KMoptto/dhZHtaGEv7Xb8D/1D63BgaD3j2
         R+eiHPeSaJIa4s4fbeETuzR1+AnhqgQo7mxI0jsnmbEKkoOumaAyUfd1xJ6+AgAqIzjg
         mdcf/w5is/dosUMtraMIon8QFgDIoHz6YrLpQRxl63OWIagb1ELSo0E4yx8u5xXQLD2S
         h8ydZdYq/xL+1XFFR8dfs5d+WiDwmAktDw5Uah/PLX+UtJepbHhwgJIzQQzuG7zwPQI8
         c8182pFY9F6Mfn+zgEeKQg43EcW4WJfZGHnW9yQzAuD+luPSn4Qffux0W9OK9Wci6fs2
         21Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791127704; x=1791732504;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WA4cfENfPEbrDvuT53Cr6d7+lPDcZpBsXedFYV5NI20=;
        b=tXKieB81DFJIYdwpG4XlAqqK9Y8LEVceySrJOQtSoO2lAGwOE1CvvQwZy8I2HRbFps
         U+Tks1ik23VWZnTO8I0cuLKl6wg9GD2pqElPvFh1dnBT+S2LKCuKEjZbsbhbFXb5S982
         Fuyg21y/LtrLy88yG8gDS29JaiRTKTgzJpGtD0aH5C558SL3dVx+MhpXMalAXDkHZHZ5
         mQTmMdHA1M2akvD6ZNeDYzv6kgXRwCIWqX+eLOnWWyK9dUCUQAV9yhGwFvNt2IOSKgMI
         4HGc5PC9iNzFvjezcXkbKR/FmIBIi8ZcbaOjFk9KrqqxQD39w2RbfuIuKHdaSqJ30S04
         S4qQ==
X-Gm-Message-State: AFuF++ndwxy+2qcdrC2EPkATLH1+Pizxp/G7snKDW1WuKenW6zAlVpIG
	yQ62ZugiWjtqlxs1pupJPwOF1lko/1mLijYVkgeIDAWqrvfO2Qy7qxm0ycc/kqSJdRE=
X-Gm-Gg: AYBFou08C4K0yd7E1lK0nb6Wm512FGDP8Va7WfO3IYXOE/FkvbkcNhibe275znj/1Qs
	rZQ2k8C9oUMNjBG9RLfF2n16dm9blog0F3+xDBE0zd/CXClnzLNoOKQN+/1zLxHWeKwoigQO/X7
	eRTnHfiISOPnOgIr8WQUtDCf9e5LdTfMIibmjPKVT+Gtc9nMyVlJCrrjXBoCvnvB7mEXoofsLA8
	jYoD+xUsijAGEQl+fwR+r26f27EsdKXgGGHj5DGU2eig+6MWy57LB9UA9EtaX3n95r/7HVxL4uk
	y3ZQEXpfCP2izz0LO4y+G9wOS+8pwC7sz0IS62F3LGW85Lw6Y8NTJR2DnISiXwE3pLLa8IDdZS5
	KjvBZrVdXnYmZIJW0trpbzNiU7Q9LH5y4hxnuEIKsKcF+GFe/jOYOFh8i7wuTAGJ4aWxSali2XD
	w65f+Ta7Q09/LE8VBavWdoweFzO2IZOeJVJ7kfdVqQx+4/cI+4DlW1eSO8r2jmzAI8zCeDdMbCk
	KvlHWB8
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a02757999cmr135331735e9.16.1791127704520;
        Sun, 04 Oct 2026 08:28:24 -0700 (PDT)
Received: from [172.20.10.3] ([37.169.53.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280d1e38sm220380705e9.13.2026.10.04.08.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 08:28:23 -0700 (PDT)
Message-ID: <162c3908-cbf9-4bf2-8594-8592d5e4c3e5@linaro.org>
Date: Sun, 4 Oct 2026 17:28:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH 3/6] net: stmmac: dwmac-meson8b: add support for the
 Amlogic T7
To: Lucas Tanure <tanure@linux.com>, xianwei.zhao@amlogic.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20261004144046.391444-1-tanure@linux.com>
 <20261004144046.391444-4-tanure@linux.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20261004144046.391444-4-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/26 16:40, Lucas Tanure wrote:
> The glue registers on the T7 are laid out exactly as the G12A ones, RX
> delay field included, so the T7 can reuse the G12A settings.
> 
> What the T7 does not share is how the controller reaches DRAM: the bus
> path goes through a pipeline stage with a gate of its own, and no device
> other than the controller has any use for that gate. Claim it and hold
> it enabled for as long as the controller is bound, otherwise it is
> switched off as unused and a transfer that has been started can never
> complete.
> 
> Give the T7 match data of its own so that only it looks the clock up,
> and require the clock instead of treating it as optional: the controller
> cannot do DMA without it, and failing the probe with a clear message
> beats booting and hitting an undiagnosable hang later.
> 
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>   .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> index e4d5c41294f4..450f7b4b29a6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> @@ -81,6 +81,7 @@ struct meson8b_dwmac;
>   struct meson8b_dwmac_data {
>   	int (*set_phy_mode)(struct meson8b_dwmac *dwmac);
>   	bool has_prg_eth1_rgmii_rx_delay;
> +	bool has_pipeline_clk;
>   };
>   
>   struct meson8b_dwmac {
> @@ -384,6 +385,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>   	struct plat_stmmacenet_data *plat_dat;
>   	struct stmmac_resources stmmac_res;
>   	struct meson8b_dwmac *dwmac;
> +	struct clk *pipeline_clk;
>   	int ret;
>   
>   	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> @@ -443,6 +445,13 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>   	if (IS_ERR(dwmac->timing_adj_clk))
>   		return PTR_ERR(dwmac->timing_adj_clk);
>   
> +	if (dwmac->data->has_pipeline_clk) {
> +		pipeline_clk = devm_clk_get_enabled(dwmac->dev, "pipeline");
> +		if (IS_ERR(pipeline_clk))
> +			return dev_err_probe(dwmac->dev, PTR_ERR(pipeline_clk),
> +					     "missing pipeline clock\n");
> +	}
> +
>   	ret = meson8b_init_rgmii_delays(dwmac);
>   	if (ret)
>   		return ret;
> @@ -479,6 +488,12 @@ static const struct meson8b_dwmac_data meson_g12a_dwmac_data = {
>   	.has_prg_eth1_rgmii_rx_delay = true,
>   };
>   
> +static const struct meson8b_dwmac_data meson_t7_dwmac_data = {
> +	.set_phy_mode = meson_axg_set_phy_mode,
> +	.has_prg_eth1_rgmii_rx_delay = true,
> +	.has_pipeline_clk = true,
> +};
> +
>   static const struct of_device_id meson8b_dwmac_match[] = {
>   	{
>   		.compatible = "amlogic,meson8b-dwmac",
> @@ -500,6 +515,10 @@ static const struct of_device_id meson8b_dwmac_match[] = {
>   		.compatible = "amlogic,meson-g12a-dwmac",
>   		.data = &meson_g12a_dwmac_data,
>   	},
> +	{
> +		.compatible = "amlogic,t7-dwmac",
> +		.data = &meson_t7_dwmac_data,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, meson8b_dwmac_match);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
