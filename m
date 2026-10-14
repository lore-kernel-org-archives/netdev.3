Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318691D9A66;
	Wed, 14 Oct 2026 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791957883; cv=none; b=Bl7yfei1/EFmLw7/D5hALAMdlUsBH4N7Js+ccVHOV21qCFQbI5AOabEBXR9jBVPULLmzYxDbC0A1CObLbxs+fNCDs838mnWbflkj+e2NpJBI3sDgtbhQxyuNQpc8ZiLz8Gjb2g7wiOYkmZ0Sx2v2C6g3vm2mz6O+vO60mKk11h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791957883; c=relaxed/simple;
	bh=CWocyKd0KcfyoIDxuwCFFDOae8Flhfzy+TOJNvb4svo=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=GI61luKc4rTTxkJKKagOgibrXB44WkBq0biTqfQcONBhdGaoWVb0SsWga9WXoW0f/HFwbpSX2f5wlRsDme2MP7YC5kGQLol+rvIpnSD1YWsIH2DFckiWgqvh82NpusmyFi8dvgkPiOl9YYFgwO011iqUJXNPg8wajHBfDuSGeo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4LJF2xX9z8Xrrj;
	Wed, 14 Oct 2026 14:04:29 +0800 (CST)
Received: from njb2app05.zte.com.cn ([10.55.22.121])
	by mse-fl2.zte.com.cn with SMTP id 69E63uil094341;
	Wed, 14 Oct 2026 14:04:22 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app05[null])
	by mapi (Zmail) with MAPI id mid204;
	Wed, 14 Oct 2026 14:04:24 +0800 (CST)
X-Zmail-TransId: 2afd6acf1b6816e-58a49
X-Mailer: Zmail v1.0
Message-ID: <202610141404241184u7jiwKOMwCRlD6_Dqpnu@zte.com.cn>
In-Reply-To: <20261001130652.1038851-1-horms@kernel.org>
References: 202609282024273579VUWteKdnnbvWlyjERLQ-@zte.com.cn,20261001130652.1038851-1-horms@kernel.org
Date: Wed, 14 Oct 2026 14:04:24 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <horms@kernel.org>
Cc: <horms@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <ran.ming@zte.com.cn>, <han.chengfei@zte.com.cn>,
        <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dCB2NCAxLzNdIGRpbmdoYWk6IGFkZCBmaXJtd2FyZSB2ZXJzaW9uIGNoZWNrIGFuZCBSSVNDLVYgcmVhZGluZXNzIHBvbGxpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 69E63uil094341
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 14:04:29 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF1B6D.000/4j4LJF2xX9z8Xrrj

Hi Simon,
thanks for the reviews.

Replying to the AI review :
> [Severity: High]
> Does this code verify the BAR length before calculating offsets into BAR 0?
> 
> The driver computes fixed offsets into BAR 0 (ZXDH_FW_COMPAT_OFFSET at 0x5400,
> and later ZXDH_RISCV_HB_OFFSET at 0x5300) without validating that the reported
> BAR length is large enough.
> 
> If a malformed PCI device, emulated device, or corrupt PCI configuration space
> presents a BAR smaller than 0x5400 plus the size of the structure, can this lead
> to an out-of-bounds MMIO read and page fault during probe?

These offsets are part of the device interface, not something
negotiated at runtime: BAR 0 is mapped in full at probe time
(zxdh_pf_pci_init() ioremaps pci_resource_len(pdev, 0)), and
ZXDH_FW_COMPAT_OFFSET / ZXDH_RISCV_HB_OFFSET are fixed regions
of the hardware spec that our own firmware implements. A BAR
too small for them can only come from a device misimplementing
its own spec, which is not a condition this driver defends
against.

> [Severity: High]
> Is there a performance regression here where this loop forces an unconditional
> 20-second delay on legacy firmware?
> 
> If the driver probes legacy hardware that predates the compatibility region,
> the region permanently contains the erased pattern (0xFF). Since legacy
> firmware never writes to this region, zxdh_pf_fw_compat_ready() will not see
> the fields lose their 0xFF values, meaning the loop waits for the entire
> timeout before proceeding.
> 
> Could this delay severely degrade system boot or module load times?

This wait is the legacy-firmware detection itself, not a
regression: legacy firmware keeps the erased pattern in the
region, which is indistinguishable from slow firmware until the
timeout expires. The assumption is logged with dev_info(), and
the 20 s stay well within the udev settle timeout.

> [Severity: Low]
> Are we passing 1,000,000 microseconds to usleep_range() in this macro?
> 
> The readx_poll_timeout macro expands to use usleep_range() for its sleep
> intervals. Passing USEC_PER_SEC exceeds the recommended 20ms maximum for
> usleep_range(), exhausting hrtimers unnecessarily.
> 
> Would it be better to use a smaller polling interval (e.g., 20ms) or a macro
> that utilizes msleep() to avoid this timer regression?

The quoted 20 ms cap comes from the removed timers-howto.rst;
neither its replacement nor the current usleep_range() docs
state such a limit. readx_poll_timeout() documents sleep_us as
the maximum interval between reads and sleeps
(sleep_us >> 2) + 1 .. sleep_us, so each iteration here sleeps
250 ms..1 s — matching the seconds-scale nature of the wait.
Same for the riscv_power_on wait below.

> [Severity: Medium]
> Could this logic incorrectly return success for a dead or physically removed
> PCI device?
> 
> If a PCI device experiences a bus error or is disconnected, reading its MMIO
> registers typically returns an all-ones value (0xFF). Here, an all-ones read
> causes module_id to equal 255.
> 
> Since the driver treats this as legacy firmware, it skips the compatibility
> check. Later, in zxdh_pf_wait_riscv_ready(), a health_version of 255 is also
> allowed to skip synchronization, leading to a successful probe.
> 
> Does the driver need a check to distinguish between actual legacy firmware and
> a broken PCIe link?

It does not get that far. With the link down, configuration
space reads also return 0xff, so the vendor-capability scan in
zxdh_pf_modern_cfg_init() — which runs before
zxdh_pf_fw_compat_check() — finds no common config and probe
exits with -ENODEV ("missing capabilities, leaving for legacy
driver"). If the device dies later in probe instead, the
all-0xff reads are treated as legacy firmware as described, and
the next real hardware interaction — pci_alloc_irq_vectors() in
zxdh_pf_irq_table_init() — fails, unwinding through the normal
error paths with the dev_info() above in the log. So probe does
not succeed against a dead device.

> [Severity: Low]
> This is another instance of passing 1,000,000 microseconds to usleep_range()
> via readx_poll_timeout. Should this use a smaller sleep interval or an
> msleep()-backed polling macro?

Answered above.
