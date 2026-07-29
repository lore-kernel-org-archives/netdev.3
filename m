Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F781DE894;
	Wed, 29 Jul 2026 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286053; cv=none; b=Ifi3iOQ07eKiJiyAjVG5u8Y9ZrPG3HBZDOC4n94k+lpFdKmv8dEdc8Q4n37MiBDNkhL0YbDLHr8noN0nEhmJKvjT3aBgPjtGCNOpokKtI73bh543XaXZfk7KnQ46jiw8PNrbwXsftKu7EiPa+ZASuVzElFqrGTq6semHw7kZGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286053; c=relaxed/simple;
	bh=+ROZvez8tFwzXQXYxR92lid3+Dn+lZIOjX5VnHidmBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyrIKuKH1by2Ou/9japJEDJLFDuj3fPpgcPF4X60UjodjJOrxwcaEJ08oep/Gyfne7N28YEhpczaJVMd8aQLVlayCfuUjQIcbvnQdCLTllIKfES+V7ZrAAYpqdhT9DxD23EajFPeM4TwhnOYOrqAhT4GArh2Injv1ByeMkOvz8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFCUBI7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFCUBI7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9548F1F000E9;
	Wed, 29 Jul 2026 00:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785286052;
	bh=zU6nuPqWUwoxALUnlgVi0XAz03PaAnH5G/kedoNak2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XFCUBI7g9qQ2xKj/mc9FkJN/Ncq/I/iHU4TvEkPxtvym3KcQ7u7aKu535b7gqLlHV
	 06gN+VFEkzHG8wxB7lhmYQBniamtQwyhr3vmfLlzSnxGIzKtJjC1UvF0pS3RjaSPpB
	 TivOg7CasGB72HP3svlqAUmbyF3q7foO/vRDhbDAtWzvArlB9T5bV98QdRE6zJyzZJ
	 N8GIepEFKBaChJouUFmyzFSTZjxLP2eGEKXRRBam3/xMESF1EyV1nQzvBApZruwiFp
	 UrV6AAOnGc2XZL7fIMC5+/kxmDAbvUbnYYg8OaezC9BOm3tHa/b/2VDtPCiCuomH/U
	 hI0Espwt8Sl/A==
Date: Tue, 28 Jul 2026 17:47:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <han.junyang@zte.com.cn>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <ran.ming@zte.com.cn>, <han.chengfei@zte.com.cn>,
 <zhang.yanze@zte.com.cn>
Subject: Re: [PATCH net-next v9 1/2] dinghai: add ZTE network driver support
Message-ID: <20260728174730.37e6665d@kernel.org>
In-Reply-To: <20260720181053485hNsVefbU8Lb_Ez3IvfHFG@zte.com.cn>
References: <20260720180651288d3b9DAp__Lfvo2x2PkMfC@zte.com.cn>
	<20260720181053485hNsVefbU8Lb_Ez3IvfHFG@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 18:10:53 +0800 (CST) han.junyang@zte.com.cn wrote:
> From: Junyang Han <han.junyang@zte.com.cn>
> 
> Add basic framework for ZTE DingHai ethernet PF driver, including
> Kconfig/Makefile build support and PCIe device probe/remove skeleton.
> 
> Signed-off-by: Junyang Han <han.junyang@zte.com.cn>

> +ccflags-y += -I$(src)

Why?

> +obj-$(CONFIG_DINGHAI_PF) += dinghai10e.o
> +dinghai10e-y := en_pf.o

> +static int zxdh_pf_pci_init(struct zxdh_core_dev *zxdh_dev)
> +{
> +	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
> +	int ret;
> +
> +	pci_set_drvdata(zxdh_dev->pdev, zxdh_dev);
> +
> +	ret = pci_enable_device(zxdh_dev->pdev);
> +	if (ret) {
> +		dev_err(zxdh_dev->device, "pci_enable_device failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = dma_set_mask_and_coherent(zxdh_dev->device, DMA_BIT_MASK(64));
> +	if (ret) {
> +		ret = dma_set_mask_and_coherent(zxdh_dev->device, DMA_BIT_MASK(32));
> +		if (ret) {

read Documentation/core-api/dma-api-howto.rst
these can't fail

> +			dev_err(zxdh_dev->device, "dma_set_mask_and_coherent failed: %d\n", ret);
> +			goto err_pci;
> +		}
> +	}
> +

> +static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct zxdh_pf_dev *pf_dev;
> +	struct zxdh_core_dev *zxdh_dev;

reverse xmas tree ordering, please

> +	struct devlink *devlink;
> +	int ret;
> +
> +	devlink = devlink_alloc(&zxdh_pf_devlink_ops, sizeof(struct zxdh_core_dev),
> +				&pdev->dev);
> +	if (!devlink) {
> +		dev_err(&pdev->dev, "zxdh_pf devlink alloc failed\n");

no errors on allocation failures please, core will print an OOM

> +		return -ENOMEM;
> +	}
> +
> +	zxdh_dev = devlink_priv(devlink);
> +	zxdh_dev->device = &pdev->dev;
> +	zxdh_dev->pdev = pdev;
> +	zxdh_dev->devlink = devlink;
> +
> +	pf_dev = zxdh_core_alloc_priv(zxdh_dev, sizeof(*pf_dev));
> +	if (!pf_dev) {
> +		dev_err(&pdev->dev, "zxdh_pf_dev alloc failed\n");
> +		ret = -ENOMEM;
> +		goto err_pf_dev;
> +	}
> +
> +	pf_dev->bar_chan_valid = false;
> +	pf_dev->vepa = false;

don't zero init fields in zalloc'ed structs

> +	mutex_init(&zxdh_dev->lock);
> +	mutex_init(&pf_dev->irq_lock);
> +
> +	zxdh_dev->coredev_type = GET_COREDEV_TYPE(pdev);
> +
> +	ret = zxdh_pf_pci_init(zxdh_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "zxdh_pf_pci_init failed: %d\n", ret);
> +		goto err_cfg_init;
> +	}
> +
> +	devlink_register(devlink);
> +
> +	return 0;
> +
> +err_cfg_init:
> +	mutex_destroy(&pf_dev->irq_lock);
> +	mutex_destroy(&zxdh_dev->lock);
> +	zxdh_core_free_priv(zxdh_dev);
> +err_pf_dev:
> +	devlink_free(devlink);
> +	return ret;

> diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.h b/drivers/net/ethernet/zte/dinghai/en_pf.h
> new file mode 100644
> index 000000000000..65eac936505b
> --- /dev/null
> +++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * ZTE DingHai Ethernet driver - PF header
> + * Copyright (c) 2022-2026, ZTE Corporation.
> + */
> +
> +#ifndef __ZXDH_EN_PF_H__
> +#define __ZXDH_EN_PF_H__
> +
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>

Why do you need device.h and slab.h here?

> +#define ZXDH_PF_VENDOR_ID	0x1cf2
> +#define ZXDH_PF_DEVICE_ID	0x8040
> +#define ZXDH_VF_DEVICE_ID	0x8041
> +
> +enum zxdh_coredev_type {
> +	DH_COREDEV_PF,
> +	DH_COREDEV_VF,
> +	DH_COREDEV_SF,
> +	DH_COREDEV_MPF

I suspect it will take some time/development to add SF support.
Please don't add unused enum entries

> +};
> +
> +struct devlink;

No need to forward declare types used as members in structs.

> +struct zxdh_core_dev {
> +	struct device *device;
> +	enum zxdh_coredev_type coredev_type;
> +	struct pci_dev *pdev;
> +	struct devlink *devlink;
> +	struct mutex lock; /* Protects device configuration */
> +	void *priv;
> +};
> +
> +struct zxdh_pf_dev {
> +	void __iomem *pci_ioremap_addr[6];
> +	bool bar_chan_valid;
> +	bool vepa;

same here, please don't add fields which are obviously unused

> +	struct mutex irq_lock; /* Protects IRQ operations */

and here.. you init / destroy this mutex but never take it

> +};
> +
> +#define GET_COREDEV_TYPE(pdev) \
> +	((pdev)->device == ZXDH_VF_DEVICE_ID ? DH_COREDEV_VF : DH_COREDEV_PF)
> +
> +void *zxdh_core_alloc_priv(struct zxdh_core_dev *zxdh_dev, size_t size);
> +void zxdh_core_free_priv(struct zxdh_core_dev *zxdh_dev);
> +void zxdh_pf_pci_close(struct zxdh_core_dev *zxdh_dev);
> +
> +#endif /* __ZXDH_EN_PF_H__ */

