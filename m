Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC96317173;
	Thu,  1 Oct 2026 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860026; cv=none; b=dgtzE+8pw9pAG41BfhyI10sQEc5g4UJ/KqDFudJhYFfMeV9jASzNPE1fBl9gwGJvdYCR7W2+wruL/lNQKM+aBAskcUX+Rg5e6wkEIRZVsMfB7mAIav/6ZMqYuEL5dCpY7QAnSrZgImVM4R8w98F3u0Hf39vKOCXkCSw6zJGG7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860026; c=relaxed/simple;
	bh=hV3l5aKp+inai970W/w7ZcfCEh+Y4NSyjMYaLLuFvac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNlLv/UxJNp43U+Ojtqlbrk/TdU8hRikd6ntGFCcn0nPRFu6a1c0BWM/sgOblJg9hGvassLY//sCgD0WJFGDIUbiK+7XRkuHJ3uBbvrIpRXSI6hxXZmwn9aYRuRwJhtpt7vucfpuIIyOQDm7z3m1MXoFjInh6dZu1Oe4LskzCTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNtpG/vF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNtpG/vF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF23F1F000FF;
	Thu,  1 Oct 2026 13:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790860025;
	bh=AfSVUT+UhXA8LWZczVWVBm06UfetFfTzo7Ie9vpO6Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lNtpG/vFtFFjRXuH3iuqmrbjSGEH+tZfadODqGoJS0WCSFssmAisDwMV+oybIqYJ9
	 Qsxqtcc7iz80+Noxd7hf81kyLEdMECtzvxJVugJyst26GtVGSWDt8PZaQ7UMKmBeZ3
	 kSFhDOnvFzq0qhM94ySyL7kyr4MUZ2psQDpVbinIWzkuhoXT7WW6OS1OaDFe/v7kay
	 DYefKdKNrW6ce94n7ojeXHNe9wc+otbvtaqukGIOv0mNMQQwnT+nBW7hKlzUtRvWFt
	 paaNkALSsQREXcfe3IkoLsOnmlVp02uhP+OrW15NslvNzqdHy2FGUzGEvOv2RWcVLF
	 Mbwj2atGyTHXw==
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
Subject: Re: [PATCH net-next v4 1/3] dinghai: add firmware version check and RISC-V readiness polling
Date: Thu,  1 Oct 2026 14:06:52 +0100
Message-ID: <20261001130652.1038851-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <202609282024273579VUWteKdnnbvWlyjERLQ-@zte.com.cn>
References: <202609282024273579VUWteKdnnbvWlyjERLQ-@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/202609282024273579VUWteKdnnbvWlyjERLQ-@zte.com.cn?part=1
---
dinghai: add firmware version check and RISC-V readiness polling

The commit adds firmware version checks and a polling mechanism for RISC-V
readiness on DingHai devices. It maps a compatibility block and a health
buffer in BAR 0 to verify driver and firmware compatibility and wait for
power-on status.

> diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
> --- a/drivers/net/ethernet/zte/dinghai/en_pf.c
> +++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
[ ... ]
> @@ -369,6 +371,120 @@ int zxdh_pf_modern_cfg_init(struct zxdh_core_dev *zxdh_dev)
[ ... ]
> +static int zxdh_pf_fw_compat_check(struct zxdh_core_dev *zxdh_dev)
> +{
> +	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
> +	struct zxdh_fw_compat __iomem *compat;
> +	struct zxdh_fw_compat *fw_compat;
> +	bool ready;
> +	int err;
> +
> +	fw_compat = &pf_dev->fw_compat;
> +	compat = pf_dev->pci_ioremap_addr[0] + ZXDH_FW_COMPAT_OFFSET;

[Severity: High]
Does this code verify the BAR length before calculating offsets into BAR 0?

The driver computes fixed offsets into BAR 0 (ZXDH_FW_COMPAT_OFFSET at 0x5400,
and later ZXDH_RISCV_HB_OFFSET at 0x5300) without validating that the reported
BAR length is large enough.

If a malformed PCI device, emulated device, or corrupt PCI configuration space
presents a BAR smaller than 0x5400 plus the size of the structure, can this lead
to an out-of-bounds MMIO read and page fault during probe?

> +
> +	/* The firmware publishes the block within 10 s of boot; wait twice
> +	 * that to leave margin.
> +	 */
> +	err = readx_poll_timeout(zxdh_pf_fw_compat_ready, compat, ready,
> +				 ready, USEC_PER_SEC,
> +				 ZXDH_FW_COMPAT_TIMEOUT_SEC * USEC_PER_SEC);

[Severity: High]
Is there a performance regression here where this loop forces an unconditional
20-second delay on legacy firmware?

If the driver probes legacy hardware that predates the compatibility region,
the region permanently contains the erased pattern (0xFF). Since legacy
firmware never writes to this region, zxdh_pf_fw_compat_ready() will not see
the fields lose their 0xFF values, meaning the loop waits for the entire
timeout before proceeding.

Could this delay severely degrade system boot or module load times?

[Severity: Low]
Are we passing 1,000,000 microseconds to usleep_range() in this macro?

The readx_poll_timeout macro expands to use usleep_range() for its sleep
intervals. Passing USEC_PER_SEC exceeds the recommended 20ms maximum for
usleep_range(), exhausting hrtimers unnecessarily.

Would it be better to use a smaller polling interval (e.g., 20ms) or a macro
that utilizes msleep() to avoid this timer regression?

> +	if (err)
> +		dev_info(zxdh_dev->device,
> +			 "compat region not populated, assuming legacy firmware\n");
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

[Severity: Medium]
Could this logic incorrectly return success for a dead or physically removed
PCI device?

If a PCI device experiences a bus error or is disconnected, reading its MMIO
registers typically returns an all-ones value (0xFF). Here, an all-ones read
causes module_id to equal 255.

Since the driver treats this as legacy firmware, it skips the compatibility
check. Later, in zxdh_pf_wait_riscv_ready(), a health_version of 255 is also
allowed to skip synchronization, leading to a successful probe.

Does the driver need a check to distinguish between actual legacy firmware and
a broken PCIe link?

[ ... ]
> +static int zxdh_pf_wait_riscv_ready(struct zxdh_core_dev *zxdh_dev)
> +{
[ ... ]
> +	err = readx_poll_timeout(ioread8, &hb->riscv_power_on, power_on,
> +				 power_on == 1, USEC_PER_SEC,
> +				 ZXDH_RISCV_READY_TIMEOUT_SEC * USEC_PER_SEC);

[Severity: Low]
This is another instance of passing 1,000,000 microseconds to usleep_range()
via readx_poll_timeout. Should this use a smaller sleep interval or an
msleep()-backed polling macro?
