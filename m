Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70536522EF8;
	Tue, 22 Sep 2026 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067600; cv=none; b=RTtakISJ2OEslYDzKJr03XFRqGaRFyM4YnDEIHFDtCXscpC6eE269pka2UKTPRAx64jMVFIv2/Cksnu4B9Ud6DlfbWo2AgiOC1gXF9knezuT/aHHxmbXsle4mG7b0x+PnECy6mhC85Vpuyih25cg8v0E59a/pEJ3r74OU6O711w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067600; c=relaxed/simple;
	bh=qYJV7JWdfXBNIxWuJp7MfRiiykEXZJEOtJgP1BbMg2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uWiQqoMZsS6irEu7h/ywmhIkVN6cEWFfliDrZxMl0AYs7XuW4YpudFzyocoIK9ARyHykT0/98ZD1yiAwnI0EO+ewR32KOg6V0mye/yKCtHm/GCI0lheDtjAKlxPc2QVv5vAVySCMoDqd99C3ifsHAfk8XJK1Xg9PYZM09G5yCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hgBt1Z/T; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hgBt1Z/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790067598; x=1821603598;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qYJV7JWdfXBNIxWuJp7MfRiiykEXZJEOtJgP1BbMg2g=;
  b=hgBt1Z/To4XFKbGEwxjzk4MC6wmB9a7BMFDAYfwVoVSaaiF2kFceWlj1
   z6jmpDoQY68wwVFJa3f7HmCCawG0vR21Lm6nUXbamWGeTJHWivZr/4ECS
   cx+l6wBQexHdgVYtoWEWm8IkxSNFe8g9FDgN5Lmjj3Zgeagx/oo2eJtYt
   JP6Juj4U0LkLcEj6Mo52djNaol0tM2va+Szl2SjEuzd/ZG6xdOSOOQhtA
   BJdD0sqlRuY/Qu7Uky1cEA1LFvwUt38lERn/UvGzlI+Rfg6gX4q6mGjmI
   y4Un6BXrq59ki2iZL/L/DZxUt3R6dSYPVtDjQ0jq33oirp0VfSkfBdWFe
   w==;
X-CSE-ConnectionGUID: k1D90LeFSX2FUpoK8pyFFw==
X-CSE-MsgGUID: jgE12pKaQTePJMxsxaF6uQ==
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="295379275"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 01:59:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 22 Sep 2026 01:59:51 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 22 Sep 2026 01:59:46 -0700
Message-ID: <56ded0b9-4975-46fd-93dd-b5777a24b2c8@microchip.com>
Date: Tue, 22 Sep 2026 14:29:45 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/3] net: ethernet: oa_tc6: add reset-gpios
 support
To: Alessandro Zini <alessandro.zini@siemens.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ciprian Regus <ciprian.regus@analog.com>, Qingfang Deng
	<qingfang.deng@linux.dev>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260918231450.55966-1-alessandro.zini@siemens.com>
 <20260918231450.55966-4-alessandro.zini@siemens.com>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <20260918231450.55966-4-alessandro.zini@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alessandro,

On 19/09/26 4:44 am, Alessandro Zini wrote:
> 
>   #include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/iopoll.h>
>   #include <linux/interrupt.h>
>   #include <linux/mdio.h>
> @@ -88,6 +90,7 @@ struct oa_tc6 {
>          bool disable_traffic;
>          bool prot_ctrl;
>          enum oa_tc6_quirk_flag quirk_flags;
> +       struct gpio_desc *reset_gpio;
>   };
> 
>   enum oa_tc6_header_type {
> @@ -1504,6 +1507,22 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
>          if (!tc6->spi_data_rx_buf)
>                  return ERR_PTR(-ENOMEM);
> 
> +       tc6->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> +                                                 GPIOD_OUT_HIGH);
> +       if (IS_ERR(tc6->reset_gpio))
> +               return ERR_PTR(dev_err_probe(&spi->dev,
> +                                            PTR_ERR(tc6->reset_gpio),
> +                                            "failed to get reset gpio\n"));
> +
> +       if (tc6->reset_gpio) {
> +               /* Keep the reset asserted for 10 us and then allow 1 ms of
> +                * settle time for the crystal oscillator startup.
> +                */
> +               fsleep(10);
> +               gpiod_set_value_cansleep(tc6->reset_gpio, 0);
> +               fsleep(1000);
> +       }
> +

How do we ensure that the reset has completed before proceeding? Should 
we check for a reset-complete status indication instead of relying only 
on fixed delays?

Also, do we still need oa_tc6_sw_reset_macphy() when reset_gpio is 
implemented? My understanding is that the software reset path is mainly 
needed for MAC-PHYs that do not expose a reset GPIO. In that case, it 
may be cleaner to prefer the GPIO reset when available and fall back to 
the software reset otherwise, rather than always performing both resets.

Best regards,
Parthiban V>          /* Check the PROTE bit status so that we can reset 
the device */
>          ret = oa_tc6_check_ctrl_protection(tc6);
>          if (ret) {
> --
> 2.55.0

