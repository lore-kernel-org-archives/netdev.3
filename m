Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C83AA500;
	Mon, 14 Sep 2026 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370446; cv=none; b=kXasNljh3ujbiig6dEK8WjJsyDvXY73ok4rvEwNf9uXn7FlEkwdah3zWeUpwQgkcU12SDV7ci3h+/wJgxXk1zjSQZH6JmGYc31J1W4JlnVhJwH/F42klPU2uOHFZ6QBR8dcxDrtU6TC4wCmq0pG8OxQZowk/O/dcuvCl+UI8jUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370446; c=relaxed/simple;
	bh=LwSyQU3OWa2SyY2qro8MVRIlfKJFMJzFCVGke3h3i+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skWJWeXCeAv1p/G/5LZtcun6l39+N08Y5UYOQD+k+kZIdn85c6PK0I4HFDUhTJ19HjNgHzhblwXQrMAaxWSYmXHpg2ThlpCJVSY/p3MZs3ZEDF9w5NF8hw3RCz76E9JSh73wAFj5re9CPY8AuK24j0GtzDe87yTLN0TZDY+rMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2yMnOT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2yMnOT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEDE1F000FF;
	Mon, 14 Sep 2026 07:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789370444;
	bh=nw8sfb3jc/uyfHo1pOrrShUfhlusFHRbBLbIysFLmis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X2yMnOT6A1wtkhltHzzsfN4dGF/ZfG4X2PO7cZPFry6M2gLII9VpHdSH9C9hUZLhO
	 Tc334/a7hVGzE0zsaJEWs/zsVekzzI9JxVJNvM0vRaP1b6eXYidoj9jY+JE9Odb7QL
	 fx4ylifNqwrBdyBd53KgCzYJ5wybi+EjuDSGBcIBsmBOTiJsYYaYNdkBUCDRsJ9RFR
	 7/YaRrHA3xwMmRi1sJ6gGcdrC3/0BNnWTfDKUQsWgib9NGcuBLwMHFURBUNcMmufQP
	 mHvxZsj2cI5XXO+uoNiLRODvbgG+TSB7/4IrayrO8XYz7LJ4LNP/dMHFcHXKASp7ma
	 CtZuR4FxsRhTg==
From: Simon Horman <horms@kernel.org>
To: han.junyang@zte.com.cn
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: =?UTF-8?q?Re=3A=20=5BPATCH=20net-next=20v2=201/3=5D=20dinghai=3A=20add=20firmware=20version=20check=20and=C2=A0RISC-V=20readiness=20polling?=
Date: Mon, 14 Sep 2026 08:20:31 +0100
Message-ID: <20260914072032.232931-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911115929435mXJzcTF08xlUAdjnT8qqm@zte.com.cn>
References: <20260911115929435mXJzcTF08xlUAdjnT8qqm@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260911115929435mXJzcTF08xlUAdjnT8qqm@zte.com.cn?part=1
---
dinghai: add firmware version check and RISC-V readiness polling

This patch introduces firmware version compatibility checks and RISC-V health
buffer readiness polling during device probe. It reads version information from
a fixed offset in BAR 0 and waits for the firmware's RISC-V management core
to set a power-on flag.

> diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
> index 86d4374088203..d257d8e9b612e 100644
> --- a/drivers/net/ethernet/zte/dinghai/en_pf.c
> +++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
[ ... ]
> @@ -369,6 +371,99 @@ int zxdh_pf_modern_cfg_init(struct zxdh_core_dev *zxdh_dev)
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

[Severity: High]
Is it intended to ignore the return value of readx_poll_timeout() here?

When running on older firmware that does not populate the compatibility
region, the memory remains 0xffffffff, which causes the driver to spin
synchronously for the full 200 seconds during device initialization.

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

[Severity: Medium]
Could there be a race condition between the firmware writing the
compatibility block and the driver reading it?

The readx_poll_timeout() loop polls the first 4 bytes using ioread32() and
proceeds as soon as they change from 0xffffffff. If the firmware writes
the data sequentially, the patch field might still be 0xFFFF when read by
the driver immediately afterward, potentially triggering false version
mismatches.

[Severity: High]
Can an erased compatibility region cause the probe to fail on older
firmware, despite the intended backward compatibility?

When the region is erased, fw_compat->patch is populated with 0xFFFF.

Later in zxdh_pf_wait_riscv_ready(), the driver attempts to skip the wait:

    if (health_version != 1 &&
        pf_dev->fw_compat.patch < ZXDH_HPIRQ_PATCH)
        return 0;

Since 0xFFFF < 4 evaluates to false, the driver falls through, waits an
additional 40 seconds, and fails the probe.

[ ... ]
> @@ -405,6 +500,18 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto err_cfg_init;
>  	}
>  
> +	ret = zxdh_pf_fw_compat_check(zxdh_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "zxdh_pf_fw_compat_check failed: %d\n", ret);
> +		goto err_cfg_init;
> +	}
> +
> +	ret = zxdh_pf_wait_riscv_ready(zxdh_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "zxdh_pf_wait_riscv_ready failed: %d\n", ret);
> +		goto err_cfg_init;
> +	}

[Severity: High]
Do these error paths leak the PCI I/O regions acquired earlier?

The error paths jump to err_cfg_init when these checks fail, which only
calls zxdh_pf_pci_close(). However, the mappings created in
zxdh_pf_modern_cfg_init() require a call to zxdh_pf_modern_cfg_uninit() to
be properly cleaned up.

> +
>  	devlink_register(devlink);
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.h b/drivers/net/ethernet/zte/dinghai/en_pf.h
> index 7373dee8d1a9f..bc275ddd75b81 100644
> --- a/drivers/net/ethernet/zte/dinghai/en_pf.h
> +++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
[ ... ]
> @@ -29,6 +29,51 @@
>  #define ZXDH_PF_ALIGN2			2
>  #define ZXDH_PF_MAP_MINLEN2		2
>  
> +/* Fixed offsets of the firmware interface regions within BAR 0. */
> +#define ZXDH_RISCV_HB_OFFSET	0x5300
> +#define ZXDH_FW_COMPAT_OFFSET	0x5400
> +
> +/* Driver/firmware version contract. The firmware publishes its side of
> + * the contract in the region at ZXDH_FW_COMPAT_OFFSET.
> + */
> +#define ZXDH_MODULE_ID		1
> +#define ZXDH_MAJOR		1
> +#define ZXDH_FW_MINOR		0
> +#define ZXDH_DRV_MINOR		0
> +/* Firmware patch level that introduced the health buffer protocol. */
> +#define ZXDH_HPIRQ_PATCH	4
> +
> +#define ZXDH_FW_COMPAT_TIMEOUT_SEC	200
> +#define ZXDH_RISCV_READY_TIMEOUT_SEC	40
> +
> +/* Firmware version compatibility block at ZXDH_FW_COMPAT_OFFSET.
> + * Fields are read through ioread*(), which converts from little-endian.
> + */
> +struct zxdh_fw_compat {
> +	u8 module_id;
> +	u8 major;
> +	s8 fw_minor;

[Severity: Medium]
Will firmware minor versions 128 or greater be improperly rejected due to
the signedness of fw_minor?

When fw_minor is read into an s8, values 128 or greater will wrap to
negative numbers. The validation check in zxdh_pf_fw_compat_check():

    if (fw_compat->fw_minor < ZXDH_FW_MINOR) {
        ...

(where ZXDH_FW_MINOR is 0) evaluates to true for these negative values,
incorrectly triggering a version incompatibility error.

> +	u8 drv_minor;
> +	u16 patch;
> +	u16 rsv;
> +} __packed;
