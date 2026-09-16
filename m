Received: from mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C244CF5E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548052; cv=none; b=IZTo0qqz4Vgj9w856ksUUQ90rR/BRKH8obBzn53K5qGUcuDeZ8TmzfZdY8RE33p2BwQzTMGi+qy7AWzTFKVFjT9q89La4w6KApx4mvuqsf70e4xrn0zXUfhJaqh48fjixTyeE4kbjsCVY//Nr8qA8uQn5Y6i82vgSSUBTVbrgdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548052; c=relaxed/simple;
	bh=FhrTUCd/cVH8OoVyad9tP9zVOBg5mMP7ZPaAcgmccV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBd5W0CFw33edXDdk2eWVdp1mL36TJvDC5AHHumdy1RnEv13Rr9Zw8E0VdR4+YO1D8xAitIYK7X3i8oTx9S7iIjv/NT66Jx8Bs2twH9ToMlE0NIMoQKRCtylRYQl8dqmty4Jja987W7JR+IU5ZLMrcJlphjGE3/OmfVp+Rsdd0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z14n6AO8; arc=none smtp.client-ip=91.218.175.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z14n6AO8"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FhrTUCd/cVH8OoVyad9tP9zVOBg5mMP7ZPaAcgmccV4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789548048; v=1; x=1790152848;
 b=Z14n6AO8qkfBp86t4Gm46sWpqIlvYAfyZfVpPzzJiUzVdmfdNFvJaEOB1sMhi/NO6mF85lAx
 iojhbLRngx4alc45P+bj+EzbgtwvAsL5IfQMwheaYQQRL6rhRD97wQfDbDXRT5uGKKnc43xFjBz
 SAYVCrYnfEjJd4AWMw6iRoXs=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6f5ce7a0d81dd4a7;
	Wed, 16 Sep 2026 08:40:42 +0000
X-Mizu-Trace-ID: 6f5ce7a0d81dd4a7
X-Migadu-Flow: FLOW_OUT
Message-ID: <d29a20bc-eaf1-4745-9470-188613965c46@linux.dev>
Date: Wed, 16 Sep 2026 16:40:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: ethernet: oa_tc6: add reset-gpios
 support
To: Alessandro Zini <alessandro.zini@siemens.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260916075349.21822-1-alessandro.zini@siemens.com>
 <20260916075349.21822-3-alessandro.zini@siemens.com>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260916075349.21822-3-alessandro.zini@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2026/9/16 15:53, Alessandro Zini wrote:
> OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface specification
> (v1.1, Section 8.2) defines an external RESET pin as an optional reset
> source for the MAC-PHY.
>
> Add support for an optional reset GPIO in oa_tc6_init(). If specified in
> the device tree, assert the hardware reset line for 10 us and allow 1 ms
> settle time for crystal oscillator startup before performing the initial
> TC6 control protection check and software reset.
>
> Suggested-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
> ---
> Changes in v2:
> - Moved reset GPIO handling from lan865x.c to common oa_tc6.c as suggested
>    by Parthiban Veerasooran.
>
>   drivers/net/ethernet/oa_tc6.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 6fcc5f561d560..a697e2cb99cd8 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -11,6 +11,8 @@
>   #include <linux/mdio.h>
>   #include <linux/phy.h>
>   #include <linux/oa_tc6.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/delay.h>
>   
>   /* Control command header */
>   #define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
> @@ -88,6 +90,7 @@ struct oa_tc6 {
>   	bool disable_traffic;
>   	bool prot_ctrl;
>   	enum oa_tc6_quirk_flag quirk_flags;
> +	struct gpio_desc *reset_gpio;
>   };
>   
>   enum oa_tc6_header_type {
> @@ -1503,6 +1506,24 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
>   	if (!tc6->spi_data_rx_buf)
>   		return NULL;
>   
> +	tc6->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> +						  GPIOD_OUT_LOW);

Please use GPIOD_OUT_HIGH here, so the reset pin is initially asserted, 
and the first gpiod_set_value_cansleep below can be removed. See 
function __mdiobus_register as an example.

> +	if (IS_ERR(tc6->reset_gpio)) {
> +		dev_err_probe(&spi->dev, PTR_ERR(tc6->reset_gpio),
> +			      "Failed to get reset GPIO\n");
> +		return NULL;
> +	}
> +
> +	if (tc6->reset_gpio) {
> +		/* Assert hardware reset for 10 us (datasheet specifies min 5 us)
> +		 * and allow 1 ms settle time for crystal oscillator startup.
> +		 */
> +		gpiod_set_value_cansleep(tc6->reset_gpio, 1);
> +		fsleep(10);
> +		gpiod_set_value_cansleep(tc6->reset_gpio, 0);
> +		fsleep(1000);
> +	}
> +
>   	/* Check the PROTE bit status so that we can reset the device */
>   	ret = oa_tc6_check_ctrl_protection(tc6);
>   	if (ret) {

Kind regards,

