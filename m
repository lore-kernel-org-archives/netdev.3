Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A13F9281
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147543; cv=none; b=VimbPmMERPGk2pXTx7tO0pEP4AvhwtBHrfJWVp8RdvfZwU0f662XSLrPCS7IVes+YYQsALpWqOh03VljCPSql8Ge2dToJ0/+mUa9Upus8aWYgbmXNhGSSMos39tFjmumgFPBWDtctjuPi8NsBGscjm/ujQgKWHnGcBadsIU9x90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147543; c=relaxed/simple;
	bh=eQsgQYdHnnL3VJecUGS4MAkSXP6VNzWsrHw6fiRz7MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAoF5k//1SP4nLuE0gEJ0GwM2PKupf7coBlHCSmWsr5hNxobV5sNPShIA+nxBx2HQPTJzD0Rf5XGHk2+xbj+dhYMD4vBio4//P3/5NyCzlWwWFdUYpErcQVg1+Gv7GI4cjGOaTAO2l3AKq1T2auYiNcv73FtpD8fc6ssrNadfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FGN/etFs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FGN/etFs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3DECA4E41168;
	Sun,  4 Oct 2026 20:58:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EBE57604FE;
	Sun,  4 Oct 2026 20:58:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1989E1032820F;
	Sun,  4 Oct 2026 22:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791147537; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jM6fCgMzlrh3EWJKc1X+4QJ1+TyZKSQffV+aGGr36KY=;
	b=FGN/etFsNicQkwc2Ng7T0X4rN7HYvMj2fTVXXMnfELUCfl4IhdTkNd7SFwlWk5F1qcN7aD
	J3DQ8UTrVIagIX/QB7I7HHFQi1goueoTBFG9aMaVIKIziZr1QH1BDapG+ln6oSCrK2bBOb
	9cjbwUA3p+uQmCKNixLCtzgzWHW7Om+LXQxSf1TmuEUvlrg+FuLGufWM6i3UG0c8EqS9YD
	ziPlqAKqS7PZXkp/y+MtKjFhZpbsCVe4Zw8Eab1OkZTW4UZdOHuv8r5ldHWmaTAffhlpv0
	QZeyESje0WfG4MTJhKqYCJnPz5rfylaQb8e4Qn+AhhHW4IfZzDCJRrnZQX+x4Q==
Message-ID: <d1ae6c21-72a9-4bc7-aaaf-9051d0f6b1b0@bootlin.com>
Date: Sun, 4 Oct 2026 22:58:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] arm64: dts: amlogic: t7: khadas-vim4: enable the
 ethernet port
To: Lucas Tanure <tanure@linux.com>, xianwei.zhao@amlogic.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20261004144046.391444-1-tanure@linux.com>
 <20261004144046.391444-7-tanure@linux.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261004144046.391444-7-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lucas,

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
>  .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> index 0fa83362b417..5d0365ddde72 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> @@ -14,6 +14,7 @@ / {
>  	compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
>  
>  	aliases {
> +		ethernet0 = &ethmac;
>  		serial0 = &uart_a;
>  		mmc0 = &sd_emmc_c;
>  		mmc1 = &sd_emmc_b;
> @@ -256,6 +257,33 @@ xtal: xtal-clk {
>  	};
>  };
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

In devicetree, "rgmii" means that the delays are inserted at the hardware
level, i.e. with longer PCB traces for the clock. With the above comment,
this is therefore wrong.

As a rule of thumb, "phy-mode = rgmii" is almost always wrong.

The right behaviour here is to represent the HW as it is, that is to say
pass phy-mode = "rgmii-id"; delays are internal. In DT we don't say who
inserts the delays (MAC or PHY), that's for the drive to figure out.

If the MAC inserts the delays, then it needs to fixup the mode passed to the PHY so that
they follow this doc :

https://www.kernel.org/doc/html/v7.2/networking/phy.html#rg-mii-electrical-interface-considerations

Maxime

