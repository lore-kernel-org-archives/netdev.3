Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B483E3C49
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040721; cv=none; b=mju11xuiwBGZvCfpiE9g/y/cRgGBa5TX5CHHEVwoPXUo4Q8aWi3vVgOZyfTsGtIXKDyfLN0zdHK8VAp5pxlPlqpfvErYVV5cEyng3h5ZXkDE06YeNI+KwGIRWyBW4L/zrEI81YJw04QUTe6bFJvO5vl5MesP7jhwqR9qbHwRZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040721; c=relaxed/simple;
	bh=WAiXRaxAM4Z1bZ828ygiu2QGKA8btwndyvH6LWkBmvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czPk+CdNR4anBA4LVlx8XozmYEw2VDxaLWxM/OQgAGkwmpjSbPmhQhXZdv1MEXQZTkuKvw+D65YhWjTAmoIvs2g3PZieuZvnxIabX6G+cHhePeDHbAuipzMRXlbONxbniZmcxJ4SoKJYIMVZ/W09JaJxzIGXPrc4cE6zb9y2OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=uoS8Wc2e; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="uoS8Wc2e"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-486503ae8f0so4496835b6e.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1781040718; x=1781645518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQKbERiB0ntPOS/R2wMXRwGJAn2HHwIq3s8Tu7uVMO4=;
        b=uoS8Wc2e1VeGoY7G1XUBEHm43nmS5gaWrdYwUmiNUbR6nAUt8w6us5wXqa8zvD0j8H
         pElFvyvcXDwQRbA7XsXg25ZJRHvM8K6goHxTNObZ69eH7g4DY9o3ebLH0iTTxx0j3y5M
         VKauDGWMkjgBFheiP8YjscG+JfsiNeZJp9RizPBwnWb2BY01EYdCMVKjHh58PXuq6py0
         aKLhGhGkk7vUvFMeaqQ3OwEj7d8vo+rsKGKph1+Ix/B9kDz3fL8ZlaUpliFLu5oek+3b
         oYjsUvyheB3NSko8ugKmu0mQq0yhwZCWmxtPvlx7+eF5c3u1n/XFljjOak4mPeOyK6q4
         D2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040718; x=1781645518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQKbERiB0ntPOS/R2wMXRwGJAn2HHwIq3s8Tu7uVMO4=;
        b=eElzttMNojqTolelzgsO8t3j/aHfLrOtiKB9jp6s+ZbftbCIP0/QscuiO5MxC6Agj6
         vQIGbGWx3j+XQt5at8FlViqHkQmCbbEIi3WaShKJsQVY90EUTvX++WV/XjxbtksGsLp4
         ejxUBlKCCyloZOiboUTvCfLEq+3+CJIv1TdmJ94Nr10+T4s6Ij8Z7Tdm1xSwnWqK9Oe6
         qvcQkw74mZsT39Ov+5FCA4f4IhVRl9t2YopO//V2Xm6vWPqn89vI5Sa+fLMFiLEpyOgv
         2fv6+mli2/QWMga2MqjYFccjboquktOvvKSpzdrFlzItsq7c8MuYusdZiFqJWnfbFlRG
         L7Dg==
X-Forwarded-Encrypted: i=1; AFNElJ86lRiDUzY7OQH843A8C0RPs7VJQEJKTYR5WrbEsJTj2smoFjreXgKy+9I+nAbrJ/rcvAWT5f4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5rGWABb9ngTL9GaXvB6L6GBpkJqY3KSCKRi71uHmDaYjjB2y
	DejRKfUzf6yqgc1zZkbpzZe32W+3whfd+/LCy6pa2VggVgPztXZBdrBnvgi6vi2SDFM=
X-Gm-Gg: Acq92OGRt6P8F0LFI0Hqwe/NmLeQLv3sij8eRoIgDJUAO/3jiGNcmN/of+M7/G2USKk
	2xfMwVDiAzmO8PBSSj/a0r56lUO7O8OHYeplhFKn8WJZjI5513BWThJNt72v3KLwgynJhDyD5Bk
	6CU8DhT+g0wZctQeHDmtf8eCXURSYMZrDsy6kg/7rkSzw/2c5O+cFCzo2Yn3Phgr863c6QV28Ps
	3022VSRgAaiTVt3lSupYKh+GbxNBW8R+U/KUkQzPyJQ+Ny/NhFaQYSI4VhJtywnd2FLYK80Wh3g
	d/XwmFAo4ElEqb6/LsjHi6el3rGwHJIr1n5R26pfNZTeWVRTZ1KRfHshhf2EniyoeXz1uduK96M
	MAxRrFwUl+qonlcspVpaHYqFGK+/6+XDOAuSayTToOO4qD4612ZYigVjHGaCyUs1dVvaqms0/4q
	SYxNfREvAHYOcf2LFRoagLbNSqSyJ97aXu7SL5xX8XFZDG
X-Received: by 2002:a05:6808:4fe2:b0:485:a9b2:5457 with SMTP id 5614622812f47-4868df63ae3mr15052790b6e.35.1781040718541;
        Tue, 09 Jun 2026 14:31:58 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5a64sm17024127b6e.4.2026.06.09.14.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 14:31:58 -0700 (PDT)
Message-ID: <b89fe088-496f-4281-9d27-7f8b0b3f38cb@riscstar.com>
Date: Tue, 9 Jun 2026 16:31:55 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/14] net: stmmac: tc956x: add TC956x/QPS615
 support
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org,
 Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
 a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, chenhuacai@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com,
 inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com,
 livelycarpet87@gmail.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-14-elder@riscstar.com>
 <20260605144758.GB3659201-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260605144758.GB3659201-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/26 9:47 AM, Rob Herring wrote:
> On Thu, Jun 04, 2026 at 08:00:20PM -0500, Alex Elder wrote:
>> From: Daniel Thompson <daniel@riscstar.com>
>>
>> Toshiba TC956x is an Ethernet AVB/TSN bridge and is essentially a
>> small and highly-specialized SoC. TC956x includes an "eMAC" subsystem
>> that can be accessed, along with several other peripherals, via two
>> PCIe endpoint functions. There is a main driver for the endpoint that
>> decomposes things and creates auxiliary bus devices to model the SoC.
>>
>> The eMAC consists of a Designware XGMAC, XPCS and PMA. Each eMAC is
>> supported by an MSIGEN that bridges TC956x level interrupts to PCIe
>> MSIs.
>>
>> Add a driver for the eMAC/MSIGEN combination.
>>
>> Co-developed-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> 
> The order is wrong here unless you worked on it and then Daniel took
> over. Tags should be chronological order.

I think this was a dumb reorder I did to address a complaint
from checkpatch, but in any case I'll fix this.  Yes, my
signoff should "wrap" the others.

>> ---
>>   MAINTAINERS                                   |   2 +
>>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  14 +
>>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +
>>   .../ethernet/stmicro/stmmac/dwmac-tc956x.c    | 818 ++++++++++++++++++
>>   4 files changed, 836 insertions(+)
>>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0439607d1155f..418537cbefbbb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -27059,6 +27059,8 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>>   F:	drivers/gpio/gpio-tc956x.c
>>   F:	drivers/misc/tc956x_pci.c
>> +F:	drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>> +F:	include/soc/toshiba/tc956x-dwmac.h
>>   
>>   TOSHIBA WMI HOTKEYS DRIVER
>>   M:	Azael Avalos <coproscefalo@gmail.com>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> index e3dd5adda5aca..8d247e033e356 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> @@ -404,6 +404,20 @@ config DWMAC_MOTORCOMM
>>   	  This enables glue driver for Motorcomm DWMAC-based PCI Ethernet
>>   	  controllers. Currently only YT6801 is supported.
>>   
>> +config DWMAC_TC956X
>> +	tristate "Toshiba TC956X DWMAC support"
>> +	depends on PCI
>> +	depends on COMMON_CLK
>> +	depends on TOSHIBA_TC956X_PCI
>> +	default TOSHIBA_TC956X_PCI
>> +	select GENERIC_IRQ_CHIP
>> +	help
>> +	  This selects the Toshiba TC956X (and Qualcomm QPS615) support in the
>> +	  stmmac driver.
>> +
>> +	  This provides support for the ethernet controllers found on these
>> +	  devices.
>> +
>>   config STMMAC_PCI
>>   	tristate "STMMAC PCI bus support"
>>   	depends on PCI
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
>> index a1cea2f57252e..e8e7f95dbe3e8 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
>> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
>> @@ -51,4 +51,6 @@ obj-$(CONFIG_STMMAC_PCI)	+= stmmac-pci.o
>>   obj-$(CONFIG_DWMAC_INTEL)	+= dwmac-intel.o
>>   obj-$(CONFIG_DWMAC_LOONGSON)	+= dwmac-loongson.o
>>   obj-$(CONFIG_DWMAC_MOTORCOMM)	+= dwmac-motorcomm.o
>> +obj-$(CONFIG_TC956X_PCI)	+= tc956x-pci.o
>> +obj-$(CONFIG_DWMAC_TC956X)	+= dwmac-tc956x.o
>>   stmmac-pci-objs:= stmmac_pci.o
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>> new file mode 100644
>> index 0000000000000..c77585e4a50e6
>> --- /dev/null
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>> @@ -0,0 +1,818 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
>> + *
>> + * Derived from code having the following copyrights:
>> + * Copyright (C) 2011-2012  Vayavya Labs Pvt Ltd
>> + * Copyright (C) 2025 Toshiba Electronic Devices & Storage Corporation
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
> 
> Based on the block diagram, these are PCI devices. Auxiliary bus is the
> wrong thing to use here.

As I said in the other message, I'm going to rearrange this
to use pci-ep-bus and platform drivers.  Most of the core
code should be stay the same but the overall structure will
change.

Thanks for your suggestions.

					-Alex

> 
> Rob

