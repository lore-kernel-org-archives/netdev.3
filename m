Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A35346771;
	Mon, 28 Sep 2026 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596827; cv=none; b=QPcY2ezDIg+ZDI0y0RoIyGyjn4YIHn0GO6k09S1w1910M5ZxufVFb9S+xbpYJsiZuyW79r8wyClI6uf4W8XlvqTADQTXUYUmiVE0mWx79vjvkodKmiXX9oLezw34tGa5KDN2diarhPCZqrUWi26Gy2BnoqyXwHB60h+Caa3ghwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596827; c=relaxed/simple;
	bh=zYdsQcEnYAWsUOqxNXD2vwYWfxz3L82ZjipydrjyGvs=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=nujGVo+Cp5en8EbRE1qBNlO6zn9F1M44x6/zC8DEf8kXJ4Ow33G5G12p3lHSQiEZdjayIlgulpNqgjrRwKyvH+z/lzDW60ANO3at4UfJcH0p6TSHFtraIGyHBBqGIs9ZB74QMo+w+zGDxs5xRK/0B+d3Iox1cL0xJpzE3f6DKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4htfyG0Srpz8Xrrc;
	Mon, 28 Sep 2026 20:00:22 +0800 (CST)
Received: from njb2app05.zte.com.cn ([10.55.22.121])
	by mse-fl1.zte.com.cn with SMTP id 68SC06AR046860;
	Mon, 28 Sep 2026 20:00:06 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app06[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 28 Sep 2026 20:00:09 +0800 (CST)
X-Zmail-TransId: 2afe6aba56c91e7-f8af4
X-Mailer: Zmail v1.0
Message-ID: <202609282000093256VYStp2PkmdFF-bDbs4Yv@zte.com.cn>
In-Reply-To: <20260922101132.GB13925@horms.kernel.org>
References: 202609211451400236_aZ55Ox3y7NW8MQnYImM@zte.com.cn,202609211456442872LYTVrDg_UG7l6DJ0Slmt@zte.com.cn,20260922101132.GB13925@horms.kernel.org
Date: Mon, 28 Sep 2026 20:00:09 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <horms@kernel.org>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dCB2MyAxLzNdIGRpbmdoYWk6IGFkZCBmaXJtd2FyZSB2ZXJzaW9uIGNoZWNrIGFuZD8gUklTQy1WIHJlYWRpbmVzcyBwb2xsaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 68SC06AR046860
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 28 Sep 2026 20:00:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ABA56D6.000/4htfyG0Srpz8Xrrc

On Mon, Sep 21, 2026 at 02:56:44PM +0800, han.junyang@zte.com.cn wrote:
> From: Junyang Han <han.junyang@zte.com.cn>
>
> The DingHai firmware publishes a version compatibility block and a
> RISC-V health buffer at fixed offsets within BAR 0.
>
> After the PCI capabilities are mapped, poll the compatibility block
> until the firmware populates it (the region reads as all ones until
> then) and verify the driver/firmware version contract. Then wait for
> the RISC-V management core to set its power-on flag in the health
> buffer before the rest of the probe continues.
>
> Firmware images predating the health buffer protocol (health version
> other than 1 and patch level below ZXDH_HPIRQ_PATCH) skip the
> readiness wait.
>
> Signed-off-by: Junyang Han <han.junyang@zte.com.cn>
> ---
> drivers/net/ethernet/zte/dinghai/en_pf.c | 113 +++++++++++++++++++++++
> drivers/net/ethernet/zte/dinghai/en_pf.h | 46 +++++++++
> 2 files changed, 159 insertions(+)
>
> diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
> index 86d437408820..7c991e0951a8 100644
> --- a/drivers/net/ethernet/zte/dinghai/en_pf.c
> +++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
> @@ -6,6 +6,8 @@
>
> #include <linux/module.h>
> #include <linux/pci.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> #include <net/devlink.h>
> #include <linux/dma-mapping.h>
> #include "en_pf.h"
> @@ -369,6 +371,103 @@ int zxdh_pf_modern_cfg_init(struct zxdh_core_dev *zxdh_dev)
> return ret;
> }
>
> +/* Read the firmware version block and verify the driver/firmware
> + * version contract.
> + */
> +static int zxdh_pf_fw_compat_check(struct zxdh_core_dev *zxdh_dev)
> +{
> + struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
> + struct zxdh_fw_compat __iomem *compat;
> + struct zxdh_fw_compat *fw_compat;
> + u32 erased;
> +
> + fw_compat = &pf_dev->fw_compat;
> + compat = pf_dev->pci_ioremap_addr[0] + ZXDH_FW_COMPAT_OFFSET;
> +
> + /* The region reads as all ones until the firmware populates it at
> + * the end of its boot; allow up to 200 s for a cold boot.
> + */
> + readx_poll_timeout(ioread32, compat, erased, erased != 0xffffffffU,
> + USEC_PER_SEC,
> + ZXDH_FW_COMPAT_TIMEOUT_SEC * USEC_PER_SEC);

> Hi,

> There is an AI-generated review of this patch available at
> https://sashiko.dev/#/patchset/202609211451400236_aZ55Ox3y7NW8MQnYImM%40zte.com.cn

> In my view the critical point made there, which I'd appreciate you looking
> into, is:

> Is the timeout error intentionally ignored here? If legacy firmware never
> populates this region, wouldn't the 200 second stall exceed the default
> udev timeout (180s), causing the worker to be killed and completely
> breaking legacy hardware support?

The ignored return value is intentional: distinguishing "firmware has not
populated the region yet" from "firmware never will" is only possible by waiting,
so the timeout itself is the legacy-firmware detection. On timeout the module id
check fails and the driver defers the decision to the readiness wait as
described in the commit message.

The udev concern is addressed in v4 by budget: the firmware publishes
the block within 10 s of boot, and the wait is now bounded at 20 s, an
order of magnitude below the 180 s event window, so even the
module-load path no longer risks the worker timeout. v4 also logs
the "assuming legacy firmware" case when the wait gives up.

While at it, the wait now checks every field of the block instead of
only the first dword: the firmware fills the fields one by one, so a
dword-granular check could observe a half-populated block.
