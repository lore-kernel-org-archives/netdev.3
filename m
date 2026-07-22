Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1D41A51F;
	Wed, 22 Jul 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737077; cv=none; b=WtVkmMixs2JNJ4rc2V28Ll1soccXZjF5nWXskiyT8NIBOdjurN6AsojbILBHRKT8DT3uKKgLxEfCxqzu14Rs9EtIcGy4Of2IAUTnq8ndabf3/iPBI4Gsrfpwv5FTdqUT0TUn/KE6r5xT83gkveynkLmG78SJ6/E4Dj1BHXU/6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737077; c=relaxed/simple;
	bh=P8/sMtdSMKxJmobas/0QPomlj8pJ5gAPx7RDJQo7siE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcItoW+5eDOBlCBcY9Pre3uf70nlu1mvXYc4kYJ8btI1wIezeNUu6Q8du7zLfgmdSu3FC6ka92R1tviKtDfPtzOBvcfSq1O6SFyPMLRi0YTbSg7rDjpMsHO35cX2j7QKOUSW0tIooutvV6eix9JABH/9uNbtvSgtYYOQMM78uMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT0WX7D+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT0WX7D+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377571F000E9;
	Wed, 22 Jul 2026 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784737076;
	bh=YXfFrDI1Gbs1aZPpZE/egTbSAbU7MCuNUiXD/BjcYx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XT0WX7D+HtENNn44tPUmJ6EXie/+lCvZtd2vSns15v/W1fmj9ElS2o1NG1H2xdknM
	 2KKOBRSfFhJsZoJDMnDEKiol1DTKuLap33CZPyfreF8sbN3A0vtK5Xabl1nGS6qYRA
	 QdwlLUZOv491ZxrBhPmqLb6uXmjoovghU0UvLYftKOnRl8yjFrjmBhgdyGDCzKs3aV
	 ukg625n3qAwnBSoylbKfjyzq0MVg0NOycLzhMrBvsPEP7y9bXmDeHQGqYj3ImWGZpv
	 XidPXLrZdWyIqJe2x0NpeyQZfL5K+ak7HyZMML/6nCpWvVZn65TcIUHT8RuYNpQK5j
	 cO55RUlgvZEMQ==
From: Simon Horman <horms@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	corbet@lwn.net,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Bharath.r@intel.com
Subject: Re: [PATCH net-next v5 13/15] ixd: add reset checks and initialize the mailbox
Date: Wed, 22 Jul 2026 17:17:47 +0100
Message-ID: <20260722161747.544002-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715180042.1972010-14-anthony.l.nguyen@intel.com>
References: <20260715180042.1972010-14-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260715180042.1972010-2-anthony.l.nguyen@intel.com?part=13
---
--- Patch [13]: [PATCH net-next v5 13/15] ixd: add reset checks and initialize the mailbox ---
commit 9019dd0f9c2d33f542f42c411b53c595e9c03614
Author: Larysa Zaremba <larysa.zaremba@intel.com>
Subject: ixd: add reset checks and initialize the mailbox

This commit introduces the reset and mailbox initialization sequence for the
Intel CPF device driver. It adds functions to trigger and verify hardware
resets, initializes default control queues, and sets up a delayed work task to
handle the post-reset initialization flow. It also adds cleanup logic to the
device removal path.

> diff --git a/drivers/net/ethernet/intel/ixd/ixd_dev.c b/drivers/net/ethernet/intel/ixd/ixd_dev.c
> new file mode 100644
> index 0000000000000..cdd5477cc1f4d
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_dev.c
[ ... ]
> +void ixd_trigger_reset(struct ixd_adapter *adapter)
> +{
> +	void __iomem *addr;
> +	u32 reg_val;
> +
> +	addr = libie_pci_get_mmio_addr(&adapter->cp_ctx.mmio_info,
> +				       ixd_reset_reg.rtrigger);
> +	reg_val = readl(addr);
> +	writel(reg_val | ixd_reset_reg.rtrigger_m, addr);

[Severity: Medium]
If the device has been hot-removed or is experiencing a PCIe link error,
could readl() return 0xFFFFFFFF?

If reg_val is not checked for 0xFFFFFFFF, this will write all 1s back to
the PFGEN_CTRL register. Could this trigger unintended hardware actions or
test modes if the link recovers or the write completes?

> +}
[ ... ]
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
> index 75ee53152e614..35d0ff5c8d983 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd_main.c
> +++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
[ ... ]
> @@ -16,7 +17,15 @@ static void ixd_remove(struct pci_dev *pdev)
>  {
>  	struct ixd_adapter *adapter = pci_get_drvdata(pdev);
>  
> -	libie_pci_unmap_all_mmio_regions(&adapter->hw);
> +	/* Do not mix removal with (re)initialization */
> +	cancel_delayed_work_sync(&adapter->init_task.init_work);
> +	/* Leave the device clean on exit */
> +	if (adapter->xnm)
> +		libie_ctlq_xn_shutdown(adapter->xnm);
> +	ixd_trigger_reset(adapter);
> +	ixd_deinit_dflt_mbx(adapter);

[Severity: High]
Since ixd_trigger_reset() uses a posted write (writel) without a following
readl() to flush it, could the reset fail to reach the hardware before the
PCI subsystem disables Memory Space Enable?

Additionally, ixd_deinit_dflt_mbx() is called immediately after triggering
the reset. Does this free the control queue DMA memory before the hardware
is guaranteed to have halted? If the reset hasn't taken effect yet, could
the device continue to master DMA to the freed memory and cause IOMMU DMAR
faults or memory corruption?

> +
> +	libie_pci_unmap_all_mmio_regions(&adapter->cp_ctx.mmio_info);
>  }
