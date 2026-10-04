Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205661CAA6D
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127726; cv=none; b=trFXganYamBVvSfF3yi7IfMMx0uWfg9yneemZOCydv4EzYx8RG4C9Oi80Oq3GGg2cGAxwThONUYTCh+wl7PS4LwQp4uEoSMvR9wgfRqRb8vzSS7CfvCQ89hC2ZfqjgRel+1Kw7h0LrclPL8kc0Y9THsCjvz9q5K5VDQvKOiyNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127726; c=relaxed/simple;
	bh=bAbuzrhxzxKziDCqa8JoYkrRD1FsUq1P0pQ8nvCKJ7c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EqD2AR2LKpI3sL7TgJalgyYUD1bh0JAnZxQiSu0yDGwdGGnQmKuCu1Jd13z/sOOqSySUj+poMYhBrr4p3YRlmRcUnykOBXpRl8uLq4y6pHm+Xt5I9/uU33H5QJQ/glVhvFbPF1F5ndt8fAXwHAjL2eGi2s/aNJHCRJBDm2w5lWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wHLu3uL0; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wHLu3uL0"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so6503585e9.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791127722; x=1791732522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MkHQ33bfr4m25EDydRQk1cIUu8p3JZCdXBnxf0p91E=;
        b=wHLu3uL0quXkkD2knVQL5Ih1zMwbNfYU8SNRGgBdyo8KirDom3yXryyIj0GCIyRM0S
         yjbtgzK6BOSumTChwRmHi0ZxmuumzjNAm+p1AsOD5YXHZuWX+IYWjVe2gobbEJnC7yLR
         f8y232ZRDwxc1/4kkrUlcEkZ//wM1lTjnA/+gh2KQpWzr2R0qp/PhWx3xK5ozwh9spy7
         yS3iiEdDyncETVUp5gXDiT7lF708oWuOgOTF4coeMk9CKme+4QD/h8DHi6nS8fu9Z3qN
         EfHrTtXggfXE+rwIKgJeyLF0h/IfVNoaeta1LO8rz0+94E31TBhmXFxp0ysiRkJSozvK
         93EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791127722; x=1791732522;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0MkHQ33bfr4m25EDydRQk1cIUu8p3JZCdXBnxf0p91E=;
        b=XFXOBkOEutrys1Sgx8V8NCAnV3dDiuhlx3kFDbSXEt7Fgm7aXaSULSHaLWCiAMH06b
         6ysSeRJ1L7+hSG3ErEsn1cuzBMRU/sHXE+lUgRZen110y9y+QRLMXu2TcB/yQ3Sxxpkq
         V4EwYZ/nqoBgt0FBaROnnwZy16GdpFbDAopUyhkIcP00NH2DhddGrRZiyX5Bj0gvtMAq
         GUKOTvy1LgyjsqvP7kPBUswXkcLEy3/8JG0K0TQyDnETqKdCurpWt17vH3kAHEqBGkkZ
         29Unrr5BZsextIM5zpEiUM4qM9lkHoVfGvgIH/nqUXXXvttkfHhb7tVw/9aJShi5XO3C
         GClw==
X-Gm-Message-State: AFuF++nVA9OLNoJKozfg4WHqjnP/O8pAFa99V9jwSa6K0ePCMZO7SGRS
	VlJSYwu9RedKMjdPk84IY4k0Dr2734qdhHQfd2A0adZdKYvVwR0hFw8AustoQWvRiYg=
X-Gm-Gg: AYBFou2lppYWRFNTkjYVh6QPOgTaGlZqUWvUyhF5d95k6wE5Q+CnrQnPlUk1L6kVo5b
	nn7lYmx3vVfAEMYeFgKWEC/Gxvsk0Fw09jRpucBTT7ZhvalnRTE4TXSd/QmIzTpOWljL8mW3E7Y
	2+Nb+t+CoJO8UPrCp3fnWsHDJNRWNWK3XQ+paN2oAQdlR7OUX6slSAAcEGPkCXUfsGoDYKRTj73
	FlEVzDH6hlZXnqzTLx+mJeF+odi1KcNRj5c0zJQ7XqlRsCp5/QUaOkLGXEHeFKEELIZvePx3UU9
	9b/aToi9GQoHmFmHxgm3f+HvdZxkY55V0sM49Txf5guS0t9EeXKKuRBadrXfvdkZJ9MdPZC1vKC
	PaOBAD7Ls4IuYDeIfzotLaBJX39aqOlVHDPfJlxzNeFUkh76m9qt4gWZOOP+7nOI5nNu+zv796A
	yU3GGeOPDy4qjdIKw1jGKBLovz7wJ1SUGL1qlPcldRIqsa081wOb4odjC2hP6CcvAxQEX8dsTcW
	gAhyOD4gFB1Qxmsq+Ju
X-Received: by 2002:a05:600c:8b6c:b0:49f:ec98:f030 with SMTP id 5b1f17b1804b1-4a0276b3e15mr140322415e9.33.1791127722245;
        Sun, 04 Oct 2026 08:28:42 -0700 (PDT)
Received: from [172.20.10.3] ([37.169.53.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a039505568sm231387545e9.3.2026.10.04.08.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 08:28:41 -0700 (PDT)
Message-ID: <413e7e67-ccdc-40e3-b360-8e349820de85@linaro.org>
Date: Sun, 4 Oct 2026 17:28:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH 4/6] arm64: dts: amlogic: t7: add the ethernet pinctrl
 nodes
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
 <20261004144046.391444-5-tanure@linux.com>
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
In-Reply-To: <20261004144046.391444-5-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/26 16:40, Lucas Tanure wrote:
> The SoC brings its ethernet interface out on bank Z, but no pin groups
> were described, so a board had no way to hand those pins over to the
> MAC.
> 
> Describe them as the two sets a board actually needs: the nine pins the
> interface always uses, and the five extra ones RGMII adds for its wider
> data path.
> 
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 30 +++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 6894c06a836b..7bd53ec16607 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -376,6 +376,36 @@ mux {
>   					};
>   				};
>   
> +				eth_pins: eth {
> +					mux {
> +						groups = "eth_mdio",
> +							 "eth_mdc",
> +							 "eth_rgmii_rx_clk",
> +							 "eth_rx_dv",
> +							 "eth_rxd0",
> +							 "eth_rxd1",
> +							 "eth_txen",
> +							 "eth_txd0",
> +							 "eth_txd1";
> +						function = "eth";
> +						drive-strength-microamp = <4000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				eth_rgmii_pins: eth-rgmii {
> +					mux {
> +						groups = "eth_rxd2_rgmii",
> +							 "eth_rxd3_rgmii",
> +							 "eth_rgmii_tx_clk",
> +							 "eth_txd2_rgmii",
> +							 "eth_txd3_rgmii";
> +						function = "eth";
> +						drive-strength-microamp = <4000>;
> +						bias-disable;
> +					};
> +				};
> +
>   				i2c0_ao_d_pins: i2c0-ao-d {
>   					mux {
>   						groups = "i2c0_ao_sck_d",

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
