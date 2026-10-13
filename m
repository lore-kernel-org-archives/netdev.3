Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966673A543A
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882717; cv=none; b=PIgC9yUDrzivcBDACS4P1bwgD+knrX1Ay9tQK3i6l538qZGcjopdmlI3YEFlVlXApABpvgyRUdo2SCxWboCcX1A49qK9Dj7ewm/NPkm7HFjYQ3mOoCJkt5jO9gzkwOcRZ1FmuaxHJ2/Tj571bO7+tkVcz4ROlAfwjptaeF1zFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882717; c=relaxed/simple;
	bh=LNqgK+ThuQWm741F/edvyBg8jFCl1W6hNc65f7NQBFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBu8HQ2q4M3NWI8rbrLdivYC1XsvnapK/yCGA1MhjaEl8Q5AzeJJqGFWjZQNSFATmJyui3bwWgLd4bvNyj1DCFNqcCG7jDcKOxyqFmXilb7D2hsTUck3izL//FwFd8LhJeGaUXFReh74lm5RLhcOgr63/7mDPWo+r8hyoCE8tV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqRd4eqK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqRd4eqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791882714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bvip8uZjAuKgwd4ZsnUKeueJ25BeNpS+0VBC9hYO3gA=;
	b=SqRd4eqKDkwhd6u+9lNaRXw5AqO+/9HjVxelBv8NFbb+LtvWTuqW/w1gNcxEtps4bMrsQ9
	3GXGatZwCb339tbXFSb99yaX0YyFxRvtLRL5FuHERjcxhh0S2NZ4gwhmfjjL5O30WO73Ee
	1VJO4NX+xMX7Y7mR5I3hQ0BAaonJ5yM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-3AVAuE51NfiTLekxqgArQQ-1; Tue,
 13 Oct 2026 09:11:47 +0000
X-MC-Unique: 3AVAuE51NfiTLekxqgArQQ-1
X-Mimecast-MFC-AGG-ID: 3AVAuE51NfiTLekxqgArQQ_1791882705
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FEA51955DDB;
	Tue, 13 Oct 2026 09:11:44 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6989E1956095;
	Tue, 13 Oct 2026 09:11:41 +0000 (UTC)
Message-ID: <d7737c9d-d4ea-4060-b82f-c7d6630ed407@redhat.com>
Date: Tue, 13 Oct 2026 11:11:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 03/12] dpll: add basic SiTime SiT9531x
 support
To: Ali Rouhi <arouhi@sitime.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
 Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-4-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261009183151.78497-4-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/9/26 20:31, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> The SiT9531x is an I2C clock generator with four independent PLLs, up to
> eight input clocks and up to twelve outputs.  Later patches register the
> PLLs with the DPLL subsystem and expose the clocks as pins; this one adds
> only what is needed to reach the device.
> 
> The register space is paged: 32 pages of 256 registers, selected by
> writing the page number to offset 0xFF, which is present in every page.
> A regmap range configuration describes that window, so the rest of the
> driver addresses a register as a page and an offset and never touches the
> selector itself.  Pages come in pairs for the PLLs (0x0A/0x1A for PLLA,
> and so on).
> 
> Probe reads the rate of the crystal feeding XIN, since every frequency
> the driver later computes derives from it; takes the optional reset line
> and leaves it deasserted, because the device configuration comes from
> efuse or from a blob applied before probe and a reset would discard it;
> then identifies the variant from the single byte at page 0 offset 0x02
> and refuses to bind on anything unknown.
> 
> Suggested-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: LLM
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>   MAINTAINERS                    |   1 +
>   drivers/dpll/Kconfig           |   2 +
>   drivers/dpll/Makefile          |   1 +
>   drivers/dpll/sit9531x/Kconfig  |  13 ++
>   drivers/dpll/sit9531x/Makefile |   4 +
>   drivers/dpll/sit9531x/core.c   | 320 +++++++++++++++++++++++++++++++++
>   drivers/dpll/sit9531x/core.h   |  91 ++++++++++
>   drivers/dpll/sit9531x/regs.h   |  44 +++++
>   8 files changed, 476 insertions(+)
>   create mode 100644 drivers/dpll/sit9531x/Kconfig
>   create mode 100644 drivers/dpll/sit9531x/Makefile
>   create mode 100644 drivers/dpll/sit9531x/core.c
>   create mode 100644 drivers/dpll/sit9531x/core.h
>   create mode 100644 drivers/dpll/sit9531x/regs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 858fe1c4332c..64e15831055e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25187,6 +25187,7 @@ M:      Ali Rouhi <arouhi@sitime.com>
>   L:     netdev@vger.kernel.org
>   S:     Maintained
>   F:     Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> +F:     drivers/dpll/sit9531x/
> 
>   SL28 CPLD MFD DRIVER
>   M:     Michael Walle <mwalle@kernel.org>
> diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
> index be98969f040a..f8f7ca121b93 100644
> --- a/drivers/dpll/Kconfig
> +++ b/drivers/dpll/Kconfig
> @@ -23,6 +23,8 @@ config DPLL_REFCNT_TRACKER
> 
>            If unsure, say N.
> 
> +source "drivers/dpll/sit9531x/Kconfig"
> +
>   source "drivers/dpll/zl3073x/Kconfig"
> 
>   endmenu
> diff --git a/drivers/dpll/Makefile b/drivers/dpll/Makefile
> index 9e7a3a3e592e..4adc50d748d4 100644
> --- a/drivers/dpll/Makefile
> +++ b/drivers/dpll/Makefile
> @@ -8,4 +8,5 @@ dpll-y                  += dpll_core.o
>   dpll-y                  += dpll_netlink.o
>   dpll-y                  += dpll_nl.o
> 
> +obj-$(CONFIG_SIT9531X_DPLL)    += sit9531x/
>   obj-$(CONFIG_ZL3073X)  += zl3073x/
> diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig
> new file mode 100644
> index 000000000000..ac5b7f31a034
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config SIT9531X_DPLL
> +       tristate "SiTime SiT9531x DPLL driver"
> +       depends on I2C && NET
> +       select DPLL
> +       select REGMAP_I2C
> +       help
> +         Driver for SiTime SiT9531x family clock generators
> +         (SiT95317, SiT95316).
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called sit9531x.
> diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefile
> new file mode 100644
> index 000000000000..a221fe55386a
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_SIT9531X_DPLL) += sit9531x.o
> +sit9531x-y := core.o
> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> new file mode 100644
> index 000000000000..c7c14442df92
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SiTime SiT9531x DPLL core driver
> + *
> + * Copyright (C) 2026 SiTime Corp.
> + * Author: Ali Rouhi <arouhi@sitime.com>
> + * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> + *
> + * I2C probe, paged regmap configuration and register access helpers.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#include "core.h"
> +#include "regs.h"
> +
> +#define SIT9531X_CHIP(_id, _nin, _nout, _name, _map) \
> +       { .id = (_id), .num_inputs = (_nin), .num_outputs = (_nout), \
> +         .name = (_name), .clkout_map = (_map) }
> +
> +/* Per-variant output index -> physical slot mapping */
> +static const u8 clkout_map_95317[] = {0, 3, 4, 5, 7, 8, 9, 11};
> +static const u8 clkout_map_95316[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
> +
> +static const struct sit9531x_chip_info sit9531x_chip_ids[] = {
> +       SIT9531X_CHIP(SIT9531X_VARIANT_ID_95317, 8, 8, "SiT95317",
> +                     clkout_map_95317),
> +       SIT9531X_CHIP(SIT9531X_VARIANT_ID_95316, 8, 12, "SiT95316",
> +                     clkout_map_95316),
> +};
> +
> +#define SIT9531X_RANGE_OFFSET  SIT9531X_PAGE_SIZE
> +
> +/*
> + * Everything the device holds can change without the driver writing it,
> + * so nothing here is cacheable except the page selector.  Caching that
> + * one spares a read of it before every access: the range code selects
> + * the page through a read-modify-write, and with no cache that read goes
> + * to the bus each time.
> + *
> + * The cached value is only as good as the last transfer, though.  A
> + * transfer that fails can leave the part on another page than the cache
> + * records, so every accessor drops the entry on an error and the next
> + * access reads the selector again.
> + */
> +static bool sit9531x_volatile_reg(struct device *dev __maybe_unused,
> +                                 unsigned int reg)
> +{
> +       return reg != SIT9531X_PAGE_SEL;
> +}
> +
> +static const struct regmap_range_cfg sit9531x_regmap_range = {
> +       .range_min      = SIT9531X_RANGE_OFFSET,
> +       .range_max      = SIT9531X_RANGE_OFFSET +
> +                         (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,
> +       .selector_reg   = SIT9531X_PAGE_SEL,
> +       .selector_mask  = GENMASK(7, 0),
> +       .selector_shift = 0,
> +       .window_start   = 0,
> +       .window_len     = SIT9531X_PAGE_SIZE,
> +};
> +
> +const struct regmap_config sit9531x_regmap_config = {
> +       .reg_bits       = 8,
> +       .val_bits       = 8,
> +       .max_register   = SIT9531X_RANGE_OFFSET +
> +                         (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,
> +       .ranges         = &sit9531x_regmap_range,
> +       .num_ranges     = 1,
> +       .volatile_reg   = sit9531x_volatile_reg,
> +       .cache_type     = REGCACHE_MAPLE,
> +};

This is only referenced from core.c. Could it be static, with the extern
declarations dropped from core.h?

The same for sit9531x_dev_probe().

Thanks,
Ivan

