Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873E370AE4;
	Thu, 10 Sep 2026 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015273; cv=none; b=opTAlZDduaXcQ72AO/JkB2jzsKaCojTeZ8QtsdRdkVzWtrJFPqm4PGvtIB9NsX2JErRsKkkxxVkBHjx4vzGT9vifpZ7jqD/tj9hE3F3ClGzlHCJPS+WAIpBBZjkz0EwgFHKBozfWsryO7QvDfMFiB0hAfdxv8QY7yKnnS3UED8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015273; c=relaxed/simple;
	bh=UQ75wqmnGISw5I5mKUrZlB20Tv+Mdwj1JlciOXQxDF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j5jD+muMU70/7XVVtpFRV0uuS8OeUvWCZXTXWzwIOLxgR21n4F/n5V96XHzmhGY4p8QkLL0wgNPExsEa0TSow3yIdx7/mc5KfuzXg0dvS+jLRFhifc7V1wHZWGDshaWre9yOhJIz49EqpfW4gzEF7LvwplX13Hv4HcizFvg7Wl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GmGweGvw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GmGweGvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789015272; x=1820551272;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UQ75wqmnGISw5I5mKUrZlB20Tv+Mdwj1JlciOXQxDF8=;
  b=GmGweGvwJBxmooe2a8oMDQcQ3Lb+gYpeXx9Y2LhCIzwbrapJYMNyoVJ2
   GoDotNyl6VA+z365apFJL23sJVzAtAiPHFvAOqIV8h+ZUqYlsoxQAsEID
   t/3rSa01XUXe29zb9+4CNFp3eELy+KQ4g1D7nkc+YIdCcxrEOZe+83Pc9
   TcpgkwXYyAgCk7yi/fSfkjXCK4oW8gNOwJjt/EW0QpEI/8cIoBkyXLtC0
   HeSO6tGz6PiShfiHBjIEy4Ujh6yAc9bvX++8tVTaD0/bDLqzyhAChhtEI
   mKjuQssPT3BRmRx8pn0RToZ1wgKyGCaseT66ZkqdE2xxBkRESiNnmcpWK
   A==;
X-CSE-ConnectionGUID: +haegaRbQgyLNY7cOmkNTQ==
X-CSE-MsgGUID: CpUNTH6fQ7O3ryt71w8a1A==
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="294805157"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 21:41:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 9 Sep 2026 21:41:11 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 21:41:06 -0700
Message-ID: <0dff5049-b2ff-4654-8644-bbfcbcd5b444@microchip.com>
Date: Thu, 10 Sep 2026 10:11:05 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ethernet: microchip: lan865x: add
 reset-gpios support
To: Alessandro Zini <alessandro.zini@siemens.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260909125358.23003-1-alessandro.zini@siemens.com>
 <20260909125358.23003-2-alessandro.zini@siemens.com>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <20260909125358.23003-2-alessandro.zini@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 09/09/26 6:23 pm, Alessandro Zini wrote:
> 
> +       priv->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> +                                                  GPIOD_OUT_LOW);
> +       if (IS_ERR(priv->reset_gpio)) {
> +               ret = dev_err_probe(&spi->dev, PTR_ERR(priv->reset_gpio),
> +                                   "Failed to get reset GPIO\n");
> +               goto free_netdev;
> +       }
> +
> +       if (priv->reset_gpio) {
> +               /* Assert hardware reset for 10 us (datasheet specifies min 5 us)
> +                * and allow 1 ms settle time for crystal oscillator startup.
> +                */
> +               gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +               fsleep(10);
> +               gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +               fsleep(1000);
> +       }
> +
According to the 
OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf, Section 8.2 
mentions the following:

reset 	This variable reflects the logical-OR of all reset sources of 	 
         the MAC-PHY and is TRUE when any of the reset sources are 
asserted. Reset sources include power-on reset (POR), software reset 
(see Section 9.2.4.2), and an external RESET pin (if implemented).

In my opinion, the “external RESET pin” can be considered optional. As 
mentioned in the specification, it would be better to move this 
functionality to oa_tc6.c so that any implemented MAC-PHY device can 
make use of it.

Best regards,
Parthiban V>          priv->tc6 = oa_tc6_init(spi, netdev, NULL);
>          if (!priv->tc6) {
>                  ret = -ENODEV;
> --
> 2.55.0

