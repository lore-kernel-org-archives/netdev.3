Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F524477E3
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127785; cv=none; b=tIL7v5oXSDQi8M3uzLWn1bbDercvjTlTD0DJgzTt4UmOeSNK12VpsGHgRlAiSTiPT9Bz7k6us7xTzpW+/Xdz/JoMdJWf3/ETN6kvb0EQFdmJ5YstgigPR/wf6S8RZc5ODJU7Udw38vFdCj/01xL02rR7ShJLCf7wqDco0s2jSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127785; c=relaxed/simple;
	bh=xEn5Z1b6PaWQLfWKSkISq8/V99w7wGJxLyGbZB9ZtPQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k6td7WV/LHnHhi52QdvprcgztXkqZ8v6hIPhkx2NZJncmglj7SPjKQeMdebLf7g3s6lvIfhSoRS70BkZiPVZrA1e64qi02jxaYckYsJXDeJ0YdBsW65fgYAaNWy84/ccrMUz5f0pJIhTiIMcVg4mjosYU7oZh9r4KZPs5o/0Id4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXczgOto; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXczgOto"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a01ff8c098so6835885e9.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791127781; x=1791732581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ijVzIve29PHeaUaMD0UnyB/2N/58uvZFm5f+2hPLu0=;
        b=fXczgOtohJS7oN76SkNO//fzv5jIelOrz07NtnNnsKr/+GZprhQF2IWxmvA9ONBY4a
         cpQsoKUuLdCYljNAip/LobptP+nS2Ta3n9KTMQQLu4kXngMlS+s+M36u4GFpejxavkuy
         Vq9pG4xk14nAMQOMKWrD7YVdMKdRAeWsFqsN5FZwcUWXDhD5vm/QNOkUs5vb24MDI6YL
         87uAqnLbxXSIzD4egYCT6wbKDPOlle5d0KETHVC7naZQPWQRiTBcCh/s+PwTzuDuq99n
         ZAK6puFbWzeyZmTflDd7J84+VAQAnRBg3MUAElFGYiyVZazJb204tL56aOewJzxUdlH8
         RqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791127781; x=1791732581;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ijVzIve29PHeaUaMD0UnyB/2N/58uvZFm5f+2hPLu0=;
        b=prAtA3BmzvVSC/J5BsdMONTTB2uEuVnZUg2isGg/m1oxWl3uQJDDUI8sFfCELZXkte
         GdQlrs1PBiqrm7GZkPgl6F2K3T0EarhyT8f+IkxudKTZhuRV1RN6HVtsivgWW6G66JjQ
         8xiwqsd6RD/2gLoak5BJj+zn/iyuP5B9FxbPxMNM6CkYkStDAHyF7+zmm4Ugj8r/aI+J
         bHGQhVaLzHLPemA8QG+VQof100n1NyEGv3hyfcvhDBYmfvrXyTLDZvI4jkdmKDlPNGjv
         BkxCN4D9PRtO6b7BM33EZpvhKC6NfaZWYjikySAzq+w364mJQN/tzBwilYhW0TGNK0jW
         c/yw==
X-Gm-Message-State: AFuF++lcj3eQKEAiKOLouT5fhtOw/ZFPXJXtrfjtWWA2Nw/FtaifJMNh
	fYyfx1y5DyuM9tFjpuVHc7wO6jiWdygEg59z79UCFPqSuYyB3RnZ08vWyztghf8Oylo=
X-Gm-Gg: AYBFou2IxFMj2q3hxkNk2+YnFpmUTr7rFSdM3zuNUwL0dV89NYJPjhHK8CZUrVvI8vO
	NhX0s5p48zAIZ/AeLXJrYyQilB5YtccaOcS9w95xSR9kWoILjAiS3rYAr56ZPma4L0T/xUFerRS
	Z/KRZT3wg8HEbLel4UHnJbnwdD8FPrwSHBx8MxAgyAdhCBgEmmvTjhLkBkXR+M3lcBXViEiCUJp
	iN+aZwDCVz1EJ3JE/H0OewhJ8mnZhYDXDPTUwkSkBaNY/XBlBqSaJRQaAZNkFXimDoV3jpkIoiM
	gilV/Tkkn8pt0iIHuhVrv9YKeGuHAgJJ3IeDca/FjHKa7NsM4L6fx57097//aSIwZAekIc8/uJJ
	v7/V4uHbxbaNi+79TJvOS4yOfwnnbsGHR3a1n2sB27E+x/AT1Vepgk0lXiHYSqa4iWoP47okDSd
	HA/3JVR9AVQh+opoJGRGfdIvQr80f67yWrhabgUqC5rq45yneBkLkKEC/LRwKgodKEDAn0fvh1S
	8wL+mZn
X-Received: by 2002:a05:600c:8b22:b0:4a1:6811:8d with SMTP id 5b1f17b1804b1-4a1681100f1mr75606585e9.11.1791127780679;
        Sun, 04 Oct 2026 08:29:40 -0700 (PDT)
Received: from [172.20.10.3] ([37.169.53.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280d1e38sm220447725e9.13.2026.10.04.08.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 08:29:39 -0700 (PDT)
Message-ID: <e27cd2c3-7fd6-4327-a84d-3f66d902f141@linaro.org>
Date: Sun, 4 Oct 2026 17:29:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH 6/6] arm64: dts: amlogic: t7: khadas-vim4: enable the
 ethernet port
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
 <20261004144046.391444-7-tanure@linux.com>
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
In-Reply-To: <20261004144046.391444-7-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/26 16:40, Lucas Tanure wrote:
> The board carries a Realtek RTL8211F gigabit PHY on the external
> management bus, connected to the MAC over RGMII.
> 
> Enable the controller, hand it the ethernet pins and point it at the
> PHY. The clock delays RGMII needs are supplied by the MAC rather than
> the PHY: 2ns on transmit and 2000ps on receive, the values the vendor
> kernel programs.
> 
> The PHY interrupt output is wired to GPIOH_6, so describe it and let
> link changes be reported instead of polled. The PHY reset pin is driven
> by an RC network on the board, not by the SoC, so there is no reset line
> to describe.
> 
> Tested at 930Mbit/s sustained receive over a minute, with no MAC error
> counters moving in either direction.
> 
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>   .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> index 0fa83362b417..5d0365ddde72 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> @@ -14,6 +14,7 @@ / {
>   	compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
>   
>   	aliases {
> +		ethernet0 = &ethmac;
>   		serial0 = &uart_a;
>   		mmc0 = &sd_emmc_c;
>   		mmc1 = &sd_emmc_b;
> @@ -256,6 +257,33 @@ xtal: xtal-clk {
>   	};
>   };
>   
> +&ethmac {
> +	status = "okay";
> +	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
> +	pinctrl-names = "default";
> +
> +	/*
> +	 * The RGMII clock delays are added by the MAC, so the PHY is
> +	 * asked for the mode that adds none.
> +	 */
> +	phy-mode = "rgmii";
> +	phy-handle = <&external_phy>;
> +	amlogic,tx-delay-ns = <2>;
> +	rx-internal-delay-ps = <2000>;
> +};
> +
> +&ext_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211FD-CG */
> +		reg = <0>;
> +		max-speed = <1000>;
> +
> +		interrupt-parent = <&gpio_intc>;
> +		/* RGMII_INT on GPIOH_6 */
> +		interrupts = <154 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
>   &i2c_m_ao_a {
>   	status = "okay";
>   	pinctrl-0 = <&i2c0_ao_d_pins>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
