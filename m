Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44C43E48B
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127762; cv=none; b=tNYceRDTmH8UqedrIXv6qUdwUoQ50rx6f1zG1Tmn6W4239kqucS7KeM54RlhJ1HF7lQvh8t4XDk+fiXI9es72lPHnKY5JHUP+8zomN/AUnDnqF9JlWG9dnUhc6AlfOFG0rzYR+mnW5dV1c+v9Z0+X0GjssIBvPVkeZXF8dKKam4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127762; c=relaxed/simple;
	bh=dp0/nCH05DwygzWEsV1XBCgBJ8K4fIcNyE/T0vIMAr4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tJcfgDs6aaN4AK1t86KeyBdyTK1HyScHZ1K69Jd9mbEX9FcFQWiVtmAua9qqaS5Sx40+6aLAiPCfJrOYrJn9ySIJJLikrlln19VkBN8eUVKtlsTnYxB04pog+gNqvXTT2VuUdnPUyQsvvFItyNsNmRilCLwmvweaWuNbI6H+8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRYhgNiD; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRYhgNiD"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so6307455e9.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 08:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791127757; x=1791732557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3n8J2PGXLDx/H5KLegGco+ygP5/7+r1Zqv1kXmn61w=;
        b=mRYhgNiDOpbsb/KbDnmqaEszbxWmIRzCpndJkQFw0ABhexqsVIopjprnglivtSlvDU
         /KpufS8FP/8nx2CjIGsMwD/KXoLPWBWmf23xhR1kTmxlhae1lyOEnOPfPhsMMDUisNW8
         eqMHe7C+9YjhVIkgtI8dVRVURsuVrewDDCIhmfF7UOap386Hu6yQMtg96QY9VOHS4pJ3
         GPadtTLcmXjPZ4z9siLdeI4EdWZ8/Z5KE2OmnSItc4VSvzcG3tZPcxbmmza9twfkuFC/
         7EnH2akgCCsjT5MUlxSkH0Y3Sglk3Z1PFiZWtHOelhBRN0gDEc7W6jcRPhZxsyfWseTf
         49Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791127757; x=1791732557;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i3n8J2PGXLDx/H5KLegGco+ygP5/7+r1Zqv1kXmn61w=;
        b=DmRMG+YdfHAZphsQUQ6b/3DqPmyyg2gN4z1DJM1KlhU5WW/0iM6V+trDCzbL4uaYf3
         Q1RJFfmDGC5FNSCDaEA84tVrZjjhOnopCNxjt0HeP6a4CRSw2QOFXcxIABwRtlGne4hQ
         gDcIQY/8ZVMzYiJHXdMKBb7ubetJ+S4osU1ntG6RJrqKjIDte42UWeEsXd/FLY2H0xQq
         vAKb0/t8qsGz6x5TOPefHkiw43ZQjgzP3ijpC7sSzAW2WjA5N9TYdks2iq2zPuoB8l4y
         bxMv9ytaEInJslJDiXY6nAsBOhSyQK9AOPmouLolQ2eMLiF7pNoos6giihXdhLcdWB30
         l00Q==
X-Gm-Message-State: AFuF++lXnxBkLo4QpLlpd4TKwgJq7QZsFdsx7oz2spbqLmTvUSSKBbJO
	POS12NekJRlH6Q070qauyZeSCTMqbqXwrH8TVOm1j+DnReoIgkX9WmhjPk1ck5URJG4=
X-Gm-Gg: AYBFou2y2/k3WHKI9tyNmirtV8saE0ywWbzAbSG5vRKnTW2bQqkDG1xk0aizztpKOPj
	OxTZzcom8+O505+hjHzTGKPAQNheP2rwNEGaSEeAwWOEEqDGEZ+wdM7eo9rlh5dzhkZkSSxfSYD
	in2iNdy/UUKnnZRyFCOybfM8gSODgrqcN76ThwNQPN8RhRvUwFv2StCeBcQDN32RZakqNKY32AO
	003zW5ZqKfrh5PHLPk29nLxO0cY16sqasWPe3f4ni0E7Mrebusr9FzCH32WHLkbs4A7luKjuD6L
	YGsXGyoad8LqH9lSo0dDQ10nwjYF2cyPLkz3on1Oxq+fcB7AlB6Sq8+n3gUfUELqBnfkUkFn44E
	cxcUxbvjkJyF7dtTe/VcAeN4Bq24AmNtWIF7D5UtRHEZeMKgOaRAYv0XxMzWrJ8DdTWrlwRaeZw
	/FU8Mv24LiNdKlAHjiR1PX6t6Gvlu7C0ebr9cAHOwFsObaRNtlUmZDXXVlImvFTzOwbcLdM7NsG
	7tdUAfS
X-Received: by 2002:a05:600c:4ecf:b0:49f:ce78:3567 with SMTP id 5b1f17b1804b1-4a02769ceefmr145584105e9.24.1791127756918;
        Sun, 04 Oct 2026 08:29:16 -0700 (PDT)
Received: from [172.20.10.3] ([37.169.53.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02769a818sm280087545e9.2.2026.10.04.08.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 08:29:16 -0700 (PDT)
Message-ID: <30637763-03bf-4d3c-a9e9-769de28c729d@linaro.org>
Date: Sun, 4 Oct 2026 17:29:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH 5/6] arm64: dts: amlogic: t7: add the ethernet
 controller
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
 <20261004144046.391444-6-tanure@linux.com>
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
In-Reply-To: <20261004144046.391444-6-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/26 16:40, Lucas Tanure wrote:
> The SoC pairs a Synopsys gigabit MAC with a small block of glue
> registers that selects the interface type and trims the clock timing,
> and with a multiplexer that points the management bus at either the
> on-chip 100M PHY or the external pins. None of it was described, so the
> port could not be used at all.
> 
> Add the controller and the multiplexer. The MAC reports a 5.10a core.
> The path the controller reaches memory over runs through a pipeline
> stage with a gate of its own, so hand that to the controller as well;
> nothing else claims it and it would otherwise be switched off as unused,
> leaving the port unable to complete a transfer.
> 
> The on-chip PHY behind the second port of the multiplexer is described
> the way the G12A does it. No board in tree uses it and that path is
> untested.
> 
> The controller is left disabled for boards to enable.
> 
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 57 +++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 7bd53ec16607..140f1836f3dd 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -250,6 +250,31 @@ gic: interrupt-controller@fff01000 {
>   			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
>   		};
>   
> +		ethmac: ethernet@fdc00000 {
> +			compatible = "amlogic,t7-dwmac",
> +				     "snps,dwmac-5.10a",
> +				     "snps,dwmac";
> +			reg = <0x0 0xfdc00000 0x0 0x10000>,
> +			      <0x0 0xfe024000 0x0 0x8>;
> +			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			clocks = <&clkc_periphs CLKID_SYS_ETH>,
> +				 <&scmi_clk CLKID_FCLK_DIV2>,
> +				 <&mpll CLKID_MPLL2>,
> +				 <&clkc_periphs CLKID_SYS_AMPIPE_ETH>;
> +			clock-names = "stmmaceth", "clkin0", "clkin1", "pipeline";
> +			power-domains = <&pwrc PWRC_T7_ETH_ID>;
> +			rx-fifo-depth = <4096>;
> +			tx-fifo-depth = <2048>;
> +			status = "disabled";
> +
> +			mdio0: mdio {
> +				compatible = "snps,dwmac-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
>   		apb4: bus@fe000000 {
>   			compatible = "simple-bus";
>   			reg = <0x0 0xfe000000 0x0 0x480000>;
> @@ -645,6 +670,38 @@ gpio_intc: interrupt-controller@4080 {
>   					<10 11 12 13 14 15 16 17 18 19 20 21>;
>   			};
>   
> +			eth_phy: mdio-multiplexer@28000 {
> +				compatible = "amlogic,g12a-mdio-mux";
> +				reg = <0x0 0x28000 0x0 0xa4>;
> +				clocks = <&clkc_periphs CLKID_SYS_ETHPHY>,
> +					 <&xtal>,
> +					 <&scmi_clk CLKID_FCLK_50M>;
> +				clock-names = "pclk", "clkin0", "clkin1";
> +				mdio-parent-bus = <&mdio0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				ext_mdio: mdio@0 {
> +					reg = <0>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +				};
> +
> +				int_mdio: mdio@1 {
> +					reg = <1>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					internal_ephy: ethernet-phy@8 {
> +						compatible = "ethernet-phy-id0180.3301",
> +							     "ethernet-phy-ieee802.3-c22";
> +						interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
> +						reg = <8>;
> +						max-speed = <100>;
> +					};
> +				};
> +			};
> +
>   			uart_a: serial@78000 {
>   				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
>   				reg = <0x0 0x78000 0x0 0x18>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
