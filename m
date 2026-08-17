Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85C3DB314;
	Mon, 17 Aug 2026 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006215; cv=none; b=Rv1ZtNeBdahNmNBzlmY2/NdvAiSaX0qNlfTkgmoYhJXJQ+lx5W4uGH1tiCgIN/Ir6DEDcLz0r4XgkNbd94w0dTvTN4R2thcWtY3PBMt1Ft82GuL40IJExR8vCQXKHiNwdjuPyq3QpHOdnHiNGKbIAIvKxmRwTOT9E4ueaKVmOLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006215; c=relaxed/simple;
	bh=7ZzBeAHS8Ew0fPqjeOl3xyXeXTSTTmz3AlJqU5rUO2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bd/4p/QAtG4Zo1Nte0x7yzgoifunVJFd09q3kfC47gEs2kWh7sKQQWUoQ2e7rNo3sWoI8Vb4KCRK3XWHeHTaxhdJ7j1F3uB8CDDUgXVrMi+vtRK9dn0UE4jq5pJdysDqYATRqWYQwl1k35iqcOIRA0WQXvGRdhcssZ8tH8KPyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrLkPfJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrLkPfJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA811F00A3A;
	Mon, 17 Aug 2026 22:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787006214;
	bh=skJlv5nKrKt+KRG5Rl9pA53QIJvUZRFd59QA2jsBb7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IrLkPfJSSwOJfhJJMIu+eeJpnn9ObnoEbCNsBJQfqNlVJ9vFbMviZ227fJz+gox51
	 LsnIEJY4hf0CA3nuSm/jXKVWV2fEBmJxtdMrhDhkvFE45Aa4DRAS8pGXQvrQC7MsoY
	 na21r2TUdk3N4gkBenpctfhajDbn3vvz6h/PbtwlyoDeXe/h6OKesTV+0JDhOBulq9
	 5oyfQGy8raOuOM8x/6a6b9dMQajPWReKULUUcnn4VhZ/n/B1UhU7f9DJyT/gWP9/MH
	 Ob/Mb9B98dxq1baw7drUw/ZTQUDnrEcIIth0eUitmYPTyWwC7yUzzRp9AKcPEN61me
	 aDZILxQe2w03g==
From: Jakub Kicinski <kuba@kernel.org>
To: jackbb_wu@compal.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	wen-zhi.huang@mediatek.com,
	shi-wei.yeh@mediatek.com,
	Minano.tseng@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	robert_yu@compal.com,
	Jeff_Chang@compal.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 2/7] net: wwan: t9xx: Add control plane transaction layer
Date: Mon, 17 Aug 2026 15:36:52 -0700
Message-ID: <20260817223652.3688666-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-t9xx_driver_v1-v6-2-2c969fad57c6@compal.com>
References: <20260811-t9xx_driver_v1-v6-2-2c969fad57c6@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wwan: t9xx: Add control plane transaction layer

This patch adds the mtk_ctrl_blk and mtk_ctrl_trans data structures along
with mtk_ctrl_init()/mtk_ctrl_exit() for the T9XX WWAN driver.  It also
splits the build into a separate pcie/ Makefile gated by a new hidden
MTK_T9XX_PCI symbol.

A couple of questions below about the module split and the mtk_ctrl_exit()
documentation.

> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
> index 18bd40b3b8d21..a2ffed346acc9 100644
> --- a/drivers/net/wwan/Kconfig
> +++ b/drivers/net/wwan/Kconfig
> @@ -124,6 +124,7 @@ config MTK_T7XX
>  config MTK_T9XX
>  	tristate "MediaTek PCIe 5G WWAN modem T9xx device"
>  	depends on PCI && ACPI
> +	select MTK_T9XX_PCI
>  	select NET_DEVLINK
>  	help
>  	  Enables MediaTek PCIe based 5G WWAN modem (T9xx series) device.
> @@ -133,6 +134,10 @@ config MTK_T9XX
>  
>  	  If unsure, say N.
>  
> +config MTK_T9XX_PCI
> +	tristate
> +	depends on PCI
> +
>  endif # WWAN
>  
>  endmenu
> diff --git a/drivers/net/wwan/t9xx/Makefile b/drivers/net/wwan/t9xx/Makefile
> index 6f2dd3f914543..ae9d6f2344ab4 100644
> --- a/drivers/net/wwan/t9xx/Makefile
> +++ b/drivers/net/wwan/t9xx/Makefile
> @@ -4,7 +4,8 @@ ccflags-y += -I$(src)/pcie
>  ccflags-y += -I$(src)
>  
>  obj-$(CONFIG_MTK_T9XX) += mtk_t9xx.o
> +obj-$(CONFIG_MTK_T9XX_PCI) += pcie/
>  
>  mtk_t9xx-y := \
> -	pcie/mtk_pci.o \
> -	pcie/mtk_pci_drv_m9xx.o
> +	mtk_dev.o \
> +	mtk_ctrl_plane.o

[Severity: Low]
Should the commit message mention this module split?  Before this patch
mtk_t9xx-y contained pcie/mtk_pci.o and pcie/mtk_pci_drv_m9xx.o, so
mtk_t9xx.ko was the module carrying module_pci_driver() and
MODULE_DEVICE_TABLE(pci, ...) from mtk_pci.c.

After this patch those two objects move into a second module built from
pcie/Makefile:

  obj-$(CONFIG_MTK_T9XX_PCI) += mtk_t9xx_pcie.o

  mtk_t9xx_pcie-y := \
	mtk_pci_drv_m9xx.o \
	mtk_pci.o

so the module that binds the hardware and carries the PCI modaliases is
now mtk_t9xx_pcie.ko, while mtk_t9xx.ko only holds mtk_dev.o and
mtk_ctrl_plane.o with no driver registration.

The MTK_T9XX help text still says:

	  To compile this driver as a module, choose M here: the module will be
	  called mtk_t9xx.

Should that be updated to name mtk_t9xx_pcie as well?  The new hidden
MTK_T9XX_PCI symbol, which is what actually gates building the PCI driver
objects, is not described anywhere either.  Both the split and the help
text are still in this shape at the end of the series (cbf822bf).

> diff --git a/drivers/net/wwan/t9xx/mtk_ctrl_plane.c b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> new file mode 100644
> index 0000000000000..cf6079218e1ce
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> @@ -0,0 +1,45 @@

[ ... ]

> +int mtk_ctrl_init(struct mtk_md_dev *mdev)
> +{
> +	struct mtk_ctrl_blk *ctrl_blk;
> +
> +	ctrl_blk = devm_kzalloc(mdev->dev, sizeof(*ctrl_blk), GFP_KERNEL);
> +	if (!ctrl_blk)
> +		return -ENOMEM;
> +
> +	ctrl_blk->mdev = mdev;
> +	mdev->ctrl_blk = ctrl_blk;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mtk_ctrl_init);
> +
> +/**
> + * mtk_ctrl_exit() - Clean up the control plane block.
> + * @mdev: Pointer to the MTK modem device.
> + *
> + * Frees the control plane block associated with @mdev.
> + */
> +void mtk_ctrl_exit(struct mtk_md_dev *mdev)
> +{
> +	mdev->ctrl_blk = NULL;
> +}
> +EXPORT_SYMBOL(mtk_ctrl_exit);

[Severity: Low]
Does the kernel-doc for mtk_ctrl_exit() match what the function does?  The
comment says "Frees the control plane block associated with @mdev", but the
body only clears the pointer:

  void mtk_ctrl_exit(struct mtk_md_dev *mdev)
  {
	mdev->ctrl_blk = NULL;
  }

The block comes from devm_kzalloc(mdev->dev, ...) in mtk_ctrl_init(), so it
stays on the device's devres list until driver detach.

Tracing the callers at the end of the series (cbf822bf), mtk_ctrl_init() is
only reached via mtk_pci_probe()->mtk_pci_dev_init()->mtk_trans_ctrl_init(),
and mtk_ctrl_exit() only from the probe error path and mtk_pci_remove(), so
there is one init/exit per device lifetime and nothing is actually leaked
here.

The wording is still "Frees the control plane block" at cbf822bf, where the
body unregisters the FSM notifier, calls mtk_port_mngr_exit() and nulls the
pointer.  Could the doc be reworded to say the pointer is cleared and the
allocation is released by devres, so a later patch adding an explicit
devm_kfree() does not end up double freeing it?
