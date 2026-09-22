Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51475448BA8;
	Tue, 22 Sep 2026 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071901; cv=none; b=VjBWoZ3uyXuvtQFqkYQdwSvQU8aAj0mljpw98M+54YAT/4QS0VeQH0UmqH8NLK4SCrcVhksuEXt5TbprezxfK0WNT35HY9NMeNGytcImGuszuK9X6VXESgaXyu0evQMkGkFE5/c7HnX8Hga+gnaF3wabHar+q1xYGQcOGBUqwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071901; c=relaxed/simple;
	bh=ApUOSYbngQerDis+rtCdK9s0LZzGi2Fz9DaM0N1qFRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUTi7vhx3/qPg+Azkd1w4EywN3DVUkdnJ7B6bj+p56WVla1Wr6SLE7hO/1UKbDpkFkG3QduHDpFwL0mln27LxTZDfAn6PLLNU6j23SHMIroJLuc/Qtj+QiJAbZUsn12U8B1WOp4SlDB+sn2e+ifs1gvgoGjtI7WumY7pDOkVjS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIpzh9Zs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIpzh9Zs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC471F00893;
	Tue, 22 Sep 2026 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071897;
	bh=STVr/3O21htEEge5Zpm/AMAISou4BlQFWnDGyHPhfGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZIpzh9ZsLRzhd+o+JwmwEV0fy8zxT0wPSqv4mK/1opiunW72OYgGme859BX+DHr3D
	 zs+8eMstMHnyP2AAEfmMA7l+3mLqkmY2HF+7I9YQ+qR8xWjvCMRYmvCrmbUdAQYNdr
	 DZpKCbeBVJYKbTyKfvKRfDuydkkzoY3/PEuMbBnh6c9w1PSQ1S3/2aWKL/t95w0oEq
	 SaVFWSRFFsqAccut9gSGpGZqKNl7gXKVf4966Wb4euErmGmbKpmH64Z7Sa9IMBfQxx
	 +REqGGIGovUe/VA/pR0ub/wDLpo/VouGnX9R5X0aubUUpfRo+lyf98JNL8t16wmefv
	 46MU4T/PYW+hg==
Date: Tue, 22 Sep 2026 11:11:33 +0100
From: Simon Horman <horms@kernel.org>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v3 1/3] dinghai: add firmware version check and?
 RISC-V readiness polling
Message-ID: <20260922101132.GB13925@horms.kernel.org>
References: <202609211451400236_aZ55Ox3y7NW8MQnYImM@zte.com.cn>
 <202609211456442872LYTVrDg_UG7l6DJ0Slmt@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202609211456442872LYTVrDg_UG7l6DJ0Slmt@zte.com.cn>

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
>  drivers/net/ethernet/zte/dinghai/en_pf.c | 113 +++++++++++++++++++++++
>  drivers/net/ethernet/zte/dinghai/en_pf.h |  46 +++++++++
>  2 files changed, 159 insertions(+)
> 
> diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
> index 86d437408820..7c991e0951a8 100644
> --- a/drivers/net/ethernet/zte/dinghai/en_pf.c
> +++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
> @@ -6,6 +6,8 @@
> 
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <net/devlink.h>
>  #include <linux/dma-mapping.h>
>  #include "en_pf.h"
> @@ -369,6 +371,103 @@ int zxdh_pf_modern_cfg_init(struct zxdh_core_dev *zxdh_dev)
>  	return ret;
>  }
> 
> +/* Read the firmware version block and verify the driver/firmware
> + * version contract.
> + */
> +static int zxdh_pf_fw_compat_check(struct zxdh_core_dev *zxdh_dev)
> +{
> +	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
> +	struct zxdh_fw_compat __iomem *compat;
> +	struct zxdh_fw_compat *fw_compat;
> +	u32 erased;
> +
> +	fw_compat = &pf_dev->fw_compat;
> +	compat = pf_dev->pci_ioremap_addr[0] + ZXDH_FW_COMPAT_OFFSET;
> +
> +	/* The region reads as all ones until the firmware populates it at
> +	 * the end of its boot; allow up to 200 s for a cold boot.
> +	 */
> +	readx_poll_timeout(ioread32, compat, erased, erased != 0xffffffffU,
> +			   USEC_PER_SEC,
> +			   ZXDH_FW_COMPAT_TIMEOUT_SEC * USEC_PER_SEC);

Hi,

There is an AI-generated review of this patch available at
https://sashiko.dev/#/patchset/202609211451400236_aZ55Ox3y7NW8MQnYImM%40zte.com.cn

In my view the critical point made there, which I'd appreciate you looking
into, is:

  Is the timeout error intentionally ignored here? If legacy firmware never
  populates this region, wouldn't the 200 second stall exceed the default
  udev timeout (180s), causing the worker to be killed and completely
  breaking legacy hardware support?

> +
> +	/* Firmware predating the compatibility region keeps the erased
> +	 * pattern, which fails the module id check below and defers the
> +	 * decision to the readiness wait.
> +	 */
> +	fw_compat->module_id = ioread8(&compat->module_id);
> +	fw_compat->major = ioread8(&compat->major);
> +	fw_compat->fw_minor = ioread8(&compat->fw_minor);
> +	fw_compat->drv_minor = ioread8(&compat->drv_minor);
> +	fw_compat->patch = ioread16(&compat->patch);
> +
> +	if (fw_compat->module_id != ZXDH_MODULE_ID) {
> +		dev_info(zxdh_dev->device,
> +			 "unknown module id %u, skip fw compat check\n",
> +			 fw_compat->module_id);
> +		/* Unknown firmware is treated as predating the HPIRQ
> +		 * patch, so that the readiness wait is skipped.
> +		 */
> +		fw_compat->patch = 0;
> +		return 0;
> +	}
> +
> +	if (fw_compat->major != ZXDH_MAJOR) {
> +		dev_err(zxdh_dev->device,
> +			"driver major %u incompatible with firmware major %u\n",
> +			ZXDH_MAJOR, fw_compat->major);
> +		return -EINVAL;
> +	}
> +
> +	if (fw_compat->fw_minor < ZXDH_FW_MINOR) {
> +		dev_err(zxdh_dev->device,
> +			"firmware fw_minor %u older than required %u\n",
> +			fw_compat->fw_minor, ZXDH_FW_MINOR);
> +		return -EINVAL;
> +	}
> +
> +	if (fw_compat->drv_minor > ZXDH_DRV_MINOR) {
> +		dev_err(zxdh_dev->device,
> +			"driver drv_minor %u older than required by firmware %u\n",
> +			ZXDH_DRV_MINOR, fw_compat->drv_minor);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

...
