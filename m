Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792360;
	b=ou7BLkS3y8PS3db/93tkHADnS26vw+/Cm6CCLPE5kQngSUP58SOqQ9/kCp0IjlLMmuuu
	 +Hi40asCoakgoIPZDuoZbBVmkNHScBODtlpnLABlabxd2gW3eY+olClUJejcgL7GFNUVa
	 l2pnHuB2idPERk/G12EtV/hQ+9EotnzQYdN2sqleazwvjeQFlM7DkUirAPThRCfLktBHO
	 W8RVXOuyCkSbmaxy90mdIVbb8+ho+G9ENf+Bc1eMXbFpxOtINb6/4c+2hhNVK38roIlfe
	 xwKSgXmRU1sj0bmW4PD0xnNUbSdVyy++vVaX9Wp+fxTe9yxmE9CTPwjDVzM9u74D6qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792360;
	h=DMARC-Filter:DKIM-Signature:Cc:Date:Message-Id:Mime-Version:Received:
	 In-Reply-To:X-Original-From:User-Agent:From:Content-Transfer-Encoding:
	 References:X-Lms-Return-Path:Content-Type:To:Subject;
	bh=8SRH22hkLlGe2H+tqK/rV7yAjjgHaHhYIT6zi/fmEEg=;
	b=4antVEXwGEHK2EqQm39MQtVECZf47OMD14KOV0eLWtsYgZmNyWVlK/OQT7dldyB4mfSb
	 xPDVdB+dwU4tL7NyydJhQ96+dqPRXZfX/n3jxaNyLfZwmRF5PwgxDTjW5tN98ckhdHkR5
	 wO1sojRcOdTMgnL7lPWn9sR3jp8EqnLHkUZZOLcvrMegA45C+wUK2d9QoiSsOSRPs5KfO
	 NEP4f0PM+znoOZCh6pkXTcsrwQPY4Yrnz+FDlbzRtjeiUlvcXlnxXe8nc1DTd3RQiW7N3
	 o3RT4SHdyxV9R6/9cu7LDMXZB2QkToJ6z+HAdF+PcOHDpSgJ9G/OTViKAlbasn8DkuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yunsilicon.com;
	spf=pass smtp.mailfrom=yunsilicon.com;
	arc=none smtp.remote-ip=209.127.231.30
Received: from va-2-30.ptr.blmpb.com (va-2-30.ptr.blmpb.com [209.127.231.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9000A606A334
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 11:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9000A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1793792352; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=8SRH22hkLlGe2H+tqK/rV7yAjjgHaHhYIT6zi/fmEEg=;
 b=RAJJhd16mXoD9UaPxX4+Pqi7MqdX6r9CY2RgTHB52T02i7GKNhVBJT2nBlRyyi+AobFfpQ
 B3OUZbPaSGhvRA4VuVZX5mZmJ71mJZCRXTjwXahChZsGUE/1FZE4HnyE6Ynt4ZpxPHVrfB
 hUd9f3W4ry8gEwzmNZCMNF0aLfw0L/nvkN0P2i41aCgUQ4b30e4dyHVKOOG1iIt/fwqR/p
 vCe+HQIH/99OPowrtZqMYTPirP5vM8g974T+6/asdXvMY1eqK1JapLmwjvXU5+f3vzTGyG
 LXcdKW3EcriTFJ/0XQufESlAycxww4HbjObSQEbbSn+wE8HdqUqtKW0Y62unFw==
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, 
	"Leon Romanovsky" <leon@kernel.org>, <weihg@yunsilicon.com>, 
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, 
	<linux-rdma@vger.kernel.org>
Date: Wed, 4 Nov 2026 19:39:09 +0800
Message-Id: <fbea0512-f1d1-483b-b04f-eec0948db42a@yunsilicon.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from [127.0.0.1] ([180.152.18.210]) by smtp.feishu.cn with ESMTPS; Wed, 04 Nov 2026 19:39:09 +0800
In-Reply-To: <d9d02f67-558f-426f-b3a4-b13bd0a95c0e@lunn.ch>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
From: "Xin Tian" <tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
References: <20261012114352.2471317-1-tianx@yunsilicon.com> <20261012114354.2471317-3-tianx@yunsilicon.com> <d9d02f67-558f-426f-b3a4-b13bd0a95c0e@lunn.ch>
X-Lms-Return-Path: <lba+26aeb195e+09b9b4+vger.kernel.org+tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
To: "Andrew Lunn" <andrew@lunn.ch>
Subject: Re: [PATCH 02/15] yunsilicon: add the register HAL

On 10/12/2026 11:21 PM, Andrew Lunn wrote:
> On Mon, Oct 12, 2026 at 07:43:55PM +0800, Xin Tian wrote:
>> Add the register access layer and the per-device register map: doorbell
>> and interrupt registers, the command queue pointers and the device
>> capability queries that the upper layers call.  The register map is
>> described by xsc_hal.h and implemented for the Andes device.
>>
>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
>> ---
>>   .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   2 +-
>>   .../yunsilicon/xsc/pci/hal/andes_impl.c       | 708 ++++++++++++++++++
>>   .../yunsilicon/xsc/pci/hal/andes_reg.h        |  43 ++
>>   .../ethernet/yunsilicon/xsc/pci/hal/xsc_hal.h |  85 +++
>>   .../net/ethernet/yunsilicon/xsc/pci/main.c    |   3 +
>>   5 files changed, 840 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hal/andes_impl.c
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hal/andes_reg.h
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hal/xsc_hal.h
>>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> index c163aa950..81b65232e 100644
>> --- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> @@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
>>   
>>   obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
>>   
>> -xsc_pci-y := main.o
>> +xsc_pci-y := main.o hal/andes_impl.o
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/hal/andes_impl.c b/drivers/net/ethernet/yunsilicon/xsc/pci/hal/andes_impl.c
>> new file mode 100644
>> index 000000000..46fc045f9
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/hal/andes_impl.c
>> @@ -0,0 +1,708 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2024 - 2026, Shanghai Yunsilicon Technology Co., Ltd.
>> + * All rights reserved.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +#include "andes_reg.h"
>> +#include "common/xsc_core.h"
>> +#include "common/xsc_cmd.h"
>> +#include "common/xsc_hsi.h"
>> +#include "common/xsc_reg.h"
>> +#include "xsc_hal.h"
>> +
>> +/* message opcode */
>> +enum {
>> +	XSC_MSG_OPCODE_SEND		= 0,
>> +	XSC_MSG_OPCODE_RDMA_WRITE	= 1,
>> +	XSC_MSG_OPCODE_RDMA_READ	= 2,
>> +	XSC_MSG_OPCODE_MAD		= 3,
>> +	XSC_MSG_OPCODE_RDMA_ACK		= 4,
>> +	XSC_MSG_OPCODE_RDMA_ACK_READ	= 5,
>> +	XSC_MSG_OPCODE_RDMA_CNP		= 6,
>> +	XSC_MSG_OPCODE_RAW		= 7,
>> +	XSC_MSG_OPCODE_VIRTIO_NET	= 8,
>> +	XSC_MSG_OPCODE_VIRTIO_BLK	= 9,
>> +	XSC_MSG_OPCODE_RAW_TPE		= 10,
>> +	XSC_MSG_OPCODE_INIT_QP_REQ	= 11,
>> +	XSC_MSG_OPCODE_INIT_QP_RSP	= 12,
>> +	XSC_MSG_OPCODE_INIT_PATH_REQ	= 13,
>> +	XSC_MSG_OPCODE_INIT_PATH_RSP	= 14,
>> +
>> +	XSC_MSG_OPCODE_UNSUPPORT	= -1,
>> +};
>> +
>> +#define REG_ADDR(bp, offset)	((bp) + (offset))
>> +
>> +static void xsc_read32(void __iomem *bar, u32 off, void *data, int len)
>> +{
>> +	u32 val = readl(REG_ADDR(bar, off));
>> +
>> +	memcpy(data, &val, len);
Hi Andrew,

Both are fixed in v1, which I'll post shortly.
> Why memcpy. Probably because the types are messed up.
Fixed.
>> +}
>> +
>> +static void xsc_write32(void __iomem *bar, u32 off, void *data)
>> +{
>> +	writel(*(u32 *)data, REG_ADDR(bar, off));
>> +}
> Please sort out your types. You should not be passing a void *. Pass
> u32 *. Casts are a red flag, they are generally not needed and
> normally indicate bad design.
>
> 	Andrew
Fixed.

Thanks,
Xin Tian
