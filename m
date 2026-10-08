Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DD37FF53;
	Thu,  8 Oct 2026 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430282; cv=none; b=jZhLjal5X8w72wm5pWX1mTaVTKVwHcuxexXndawb9jhfrK5mfWwEKkKpw/I9W8ILBgvdfm5cfbTU8bSd40pnyR4qbxHVdl553gMtxyLJ4Eg8PefQ6QcKoQwSD5jb1QsrJtFlDwceevorUTob9zXqMHURVuCHcaXiT+WRVqnUolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430282; c=relaxed/simple;
	bh=Rsk8qalhAFrI7bNXjDuRHfYdKBM4cNyRHBGNeCntXgU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gge6VBwg/0Q/ylsYr2ugsWkz4PWU9f9pz5BuKJ2pKQfsZjcmGzaEDEdjXuFargoLrYmMF4LucFmy80/k5sOHQprf1P3ESNPg0Xd9lQVjPXQ6kwFw+3AtYWA6crGGNQxRr/lYCQT31h0E8FS5xhYofSqfDJrVh+02Pm9vbGnCFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuTyKB8P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuTyKB8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AA01F000FF;
	Thu,  8 Oct 2026 03:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791430280;
	bh=doKya4TAuwuHLjF27X1lAAmDyISiCJjGAuVsJzbKKn8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SuTyKB8PKCpuXQRpNNMteStsvgdrrTq2oVSPKL1hgKIngWsnJNqMsCeOMPeokbN3J
	 +zzkePmdsXkyx29wm5SIejSGty1eVdM8tJXkuJwxrwbi+ki0Sir7RWcrD33lQJNjpG
	 DbuZXEhScB1+Crbc+ehCF6MXNxJqPwTzc55mFDWNR6ca8ChFRG8ycFsH7yE1J6tWfX
	 Yo3eKm9IYYhAZ+n7MqeGhZk8oH32Ou7W3btRNvGo6SUZ/dSeLawd1ApR4KZY09Yi/O
	 LoZ8BxVw1v6vIHiLyPfJtxgN4NrgFt3QlDivG8m8mJrBGScsdyaHuo1+kiuk8omp0e
	 LtI8yrqJImX4Q==
Subject:
 Re: [PATCH net-next 4/4] net: ethernet: qualcomm: ppe: Add IPQ5332 support
From: netdev-bot+sashiko@kernel.org
To: mail@tk154.de
Cc: netdev@vger.kernel.org, jie.luo@oss.qualcomm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 quic_leiwei@quicinc.com, quic_suruchia@quicinc.com, quic_pavir@quicinc.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Thu, 08 Oct 2026 03:31:18 +0000
Message-ID: <179143027873.434549.15034517641240789690@kernel.org>
In-Reply-To: <20261005152915.101780-5-mail@tk154.de>
References: <20261005152915.101780-5-mail@tk154.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] On IPQ5332, the comment in ppe_clock_init_and_reset() (ppe.c
  lines 187-190) is no longer true.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  depends on it.

--

net: ethernet: qualcomm: ppe: Add IPQ5332 support

This patch adds qcom,ipq5332-ppe match data to the PPE driver: a 200 MHz
PPE clock, four interconnect paths and three ports. It also adds IPQ5332
specific BM/QM limits, thresholds and scheduler arbitration tables, and
reuses the IPQ9574 scheduler resource table for ports 0-2.

> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
> index 0ef72c20364be..69e970db4a78b 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c

[ ... ]

> @@ -65,6 +89,14 @@ static const struct icc_bulk_data ipq9574_icc_data[] = {
>  	},
>  };
>  
> +static const struct ppe_plat_data ipq5332_ppe_data = {
> +	.soc_cfg = &ipq5332_soc_config,
> +	.icc_data = ipq5332_icc_data,
> +	.ppe_clk_rate = 200000000,

[Severity: Low]
This isn't a bug, but now that IPQ5332 goes through
ppe_clock_init_and_reset(), is the comment there still accurate?

drivers/net/ethernet/qualcomm/ppe/ppe.c:ppe_clock_init_and_reset() {
    ...
	/* The PPE clocks have a common parent clock. Setting the clock
	 * rate of "ppe" ensures the clock rate of all PPE clocks is
	 * configured to the same rate.
	 */
	clk = devm_clk_get(dev, "ppe");
    ...
}

In this series, the qcom,ipq9574-ppe.yaml binding requires a fifth clock
for qcom,ipq5332-ppe. It is described as "PPE sleep clock from GCC" and
does not share the NSSCC parent of the other PPE clocks.

devm_clk_bulk_get_all_enabled() enables that clock at its own rate. Only
"ppe" gets clk_set_rate().

Could the comment be updated so it no longer claims that all PPE clocks
end up at the same rate?

> +	.num_icc = ARRAY_SIZE(ipq5332_icc_data),
> +	.num_ports = 3,
> +};

[ ... ]

> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> index 65ac6c0841d5a..91e6ee9524a60 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c

[ ... ]

> @@ -264,6 +298,30 @@ static const struct ppe_qm_queue_config ipq9574_ppe_qm_queue_config[] = {
>  	},
>  };
>  
> +/* IPQ5332 unicast and multicast queue thresholds. */
> +static const struct ppe_qm_queue_config ipq5332_ppe_qm_queue_config[] = {

[ ... ]

> +	{
> +		/* QM settings for multicast queues 256 to 299. */
> +		.queue_start	= 256,
> +		.queue_end	= 299,
> +		.prealloc_buf	= 0,
> +		.ceil		= 50,
> +		.weight		= 0,
> +		.resume_offset	= 18,
> +		.dynamic	= false,
> +	},
> +};

[Severity: Medium]
This is a pre-existing issue, but do these multicast thresholds ever reach
the hardware? ppe_config_qm() indexes the multicast admission control
table with the global queue ID:

drivers/net/ethernet/qualcomm/ppe/ppe_config.c:ppe_config_qm() {
    ...
	} else {
		reg = PPE_AC_MULTICAST_QUEUE_CFG_TBL_ADDR +
		      PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC * queue_id;
    ...
}

The multicast config table is a separate table with 44 entries:

#define PPE_AC_MULTICAST_QUEUE_CFG_TBL_ADDR	0x84a000
#define PPE_AC_MULTICAST_QUEUE_CFG_TBL_ENTRIES	44
#define PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC	0x10

With that indexing, queue 256 maps to 0x84b000 and queue 299 maps to
0x84b2b0. Both addresses are past the end of the table at 0x84a2c0 and
before PPE_AC_GRP_CFG_TBL_ADDR (0x84c000).

The debugfs code for the matching multicast counter table subtracts the
unicast entry count first:

drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c:ppe_queue_counter_get() {
    ...
			int mq_offset = i - PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES;
    ...
}

If that is the intended indexing, neither these IPQ5332 values (ceil 50,
resume_offset 18) nor the IPQ9574 ones are ever written. The real
multicast entries keep their reset values, and the read-modify-write
cycles hit undocumented QM addresses instead.

This looks like it goes back to commit 806268dc7efd ("net: ethernet:
qualcomm: Initialize PPE queue management for IPQ9574").

Should ppe_config_qm() use queue_id - PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES
as the multicast table index?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005152915.101780-1-mail%40tk154.de
