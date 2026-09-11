Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8723EC81A;
	Fri, 11 Sep 2026 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098107; cv=none; b=hwlCiX2B+1jzLNVLDs68kMmJcW0oMPr/dwCVC/foL7S4NWsP4M+BUCA3BmZQhL4AGx4wsXyju2CHAkqH0A8xK0h9ovZdXPMlO8+y3Rhbl1entKNhhkTo1K2BEC3KQIW1FfGR7nOF+S/J7Avzv2cdeXdOM7gmHRqn2cQXY7RdPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098107; c=relaxed/simple;
	bh=UwBpjNMpo48jJ5QbQUIJrNE1UOxgBMLHYaEbTduqBwI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Czsa7F9CXeLVNTiwisT80XM3PUfaxYIsCFrcIR750rxK4sQTfuxW0Sl3mDIrAHO7dXqZ/U9u4NPM7f7HxihX2TnaJVXICXxMspzGrrM3fl6Qeh7ymSMfDjBZf+PzipwnhnI/16ubDV2R0+c1TYpWsYRzcS1HSjHrcaywPMduQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZJHIRQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZJHIRQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E5E1F00893;
	Fri, 11 Sep 2026 03:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789098105;
	bh=QgM2SfXxk1VkiHMaSW45hR8xjauP3M24rjcutCAeXzU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZZJHIRQENoCBBh0U+HYLlO9dFHb1uTMjPusqQX0G8GMF6eAuibFHAvNyWWD3p9s5F
	 a8zjG8vJDtxW7PEMK+qhV3r9Fz6rdP32CyldZ5SSSvuFJWld8lm89tqR0czoXIkPi5
	 wsZyJYDQzGC6jpL4c5Y8pxAfVHKLa8pO1BT/D3Gd/RGavMx/C5keaMTPfIsSdJMkm/
	 atVvVPnMADXeGqIRo0W8WJOrSN5o74T9ozIDLDKmH3OjZ8a2hJbDq08S8XZLK9c02N
	 jGIUuvBqOOdGheVRP5alxROXFs+HmRiE0naXPr2WgG5rTHjvTOLC9w+85p3bruEMLP
	 GPm5HVZgqdbLw==
Subject: Re: [PATCH v27 net-next 02/10] net/nebula-matrix: add core driver
 architecture and HW layer initialization
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 03:41:44 +0000
Message-ID: <178909810446.219967.2776050584450559930@kernel.org>
In-Reply-To: <20260907123848.30256-3-illusion.wang@nebula-matrix.com>
References: <20260907123848.30256-3-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Series-structure remark (validated as NOT a defect): nbl_probe()
  changes from an unconditional -ENODEV to a success path that enables…
- [Low] Dead code introduced by this patch: (a) nbl_hw_leonis.c includes
  <linux/spinlock.h> and <linux/bitfield.h> although the file at this…

--

net/nebula-matrix: add core driver architecture and HW layer initialization

This adds the nbl_adapter/nbl_core/nbl_common_info device context, turns
the previously stubbed nbl_probe() into a working PCI probe path, and adds
the Leonis hardware layer that requests BAR0/BAR2 and ioremaps them via
pcim helpers.

A couple of small questions below about unused code added by this patch and
about the point in the series where the device starts being claimed.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> index 6c14d1071c0c2..cc060cf8bf759 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> @@ -3,4 +3,5 @@
>  
>  obj-$(CONFIG_NBL) := nbl.o
>  
> -nbl-objs +=	nbl_main.o
> +nbl-objs +=	nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
> +		nbl_main.o
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> new file mode 100644
> index 0000000000000..0ba0b7f643c64
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2026 Nebula Matrix Limited.
> + */
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include <linux/bits.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +#include <linux/bitfield.h>
> +#include "nbl_hw_leonis.h"

[Severity: Low]
This isn't a bug, but are linux/spinlock.h and linux/bitfield.h needed here
yet?  Grepping nbl_hw_leonis.c at this commit for spin_lock or FIELD_ returns
no matches, so both look like leftovers from splitting a larger file (the
spinlock and FIELD_*() users appear only in later patches).  Could they be
added in the patch that first uses them?

[ ... ]

> +		hw_mgt->hw_size = PAGE_ALIGN_DOWN(NBL_MEM_BAR_TOTAL_SIZE -
> +						 NBL_RDMA_NOTIFY_LEN);
> +		hw_mgt->hw_addr =
> +			pcim_iomap(pdev, NBL_MEMORY_BAR,
> +				   hw_mgt->hw_size);

[Severity: Low]
Is hw_mgt->hw_size read anywhere?  It is stored in both branches but never
used to bound a register access, here or later in the series, where only
mailbox_bar_size ends up being checked.  Passing the size straight to
pcim_iomap() and dropping the field would work too.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
> new file mode 100644
> index 0000000000000..da30244fe75d6
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
> @@ -0,0 +1,32 @@
[ ... ]
> +struct nbl_common_info {
> +	struct pci_dev *pdev;
> +	struct device *dev;
> +	u32 msg_enable;
> +	u16 vsi_id;

[Severity: Low]
What uses msg_enable?  At this commit the only occurrence in the whole nbl
directory is this declaration, and by the end of the series struct
nbl_common_info no longer has the member at all, so it is added and then
silently removed within the same series.  Should it just be dropped here?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 199626159a4ce..f2552bc732937 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
[ ... ]
>  static int nbl_probe(struct pci_dev *pdev,
>  		     const struct pci_device_id *id)
>  {
> -	return -ENODEV;
> +	struct nbl_init_param param = { { 0 } };
> +	struct device *dev = &pdev->dev;
> +	struct nbl_adapter *adapter;
> +	int err;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to enable PCI dev, err=%d\n", err);
> +		return err;
> +	}
> +
> +	nbl_get_func_param(pdev, id->driver_data, &param);
> +	/* never return fail when DMA_BIT_MASK(64) */
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +
> +	pci_set_master(pdev);
> +
> +	adapter = nbl_core_init(pdev, &param);
> +	if (IS_ERR(adapter)) {
> +		dev_err(dev, "Nbl adapter init fail: %pe\n", adapter);
> +		err = PTR_ERR(adapter);
> +		goto adapter_init_err;
> +	}
> +	pci_set_drvdata(pdev, adapter);
> +	return 0;
> +adapter_init_err:
> +	pci_clear_master(pdev);
> +	return err;
>  }

[Severity: Low]
This isn't a bug, but from this commit on nbl_probe() returns success after
pcim_enable_device(), dma_set_mask_and_coherent(), pci_set_master() and the
BAR mappings, while no network interface is created.

Grepping the nbl directory for register_netdev or alloc_etherdev at the end
of the series finds no matches either, so the module claims every ID in
nbl_id_table[] and exposes no netdev at any point in the series.

The commit message does describe this as "preparing for subsequent device
implementations", so the only question is placement: would it be preferable
to keep probe returning -ENODEV until the netdev registration lands, so that
bisecting between these patches does not leave the hardware bound to a
driver that offers nothing?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907123848.30256-1-illusion.wang%40nebula-matrix.com
