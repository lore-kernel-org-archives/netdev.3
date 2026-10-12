Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33614AB1A6;
	Mon, 12 Oct 2026 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819720; cv=none; b=ERq8eeTEJclNJ8jP9pIn4uXnx/Wh5m56NcGIMdLixyVUadWZYDcIK5i07pFNoCxx4PAiMB2OnRBe7v904um5/mRxR67OhosNgAk4i0a9/HJ66bnkAOh6/DP/BHhySvgd7tHudDsuX6aS/X5dp5PbTnGIbR3FVxvRjHdXX20Kvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819720; c=relaxed/simple;
	bh=yZ9SsIc249aRwfRHlkDfG8fT/TgA5OCr6NuE69xYyDs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+wa6zgqhudsUeEXN4xauW9XmGrQ1TICPVeDa+i6m6p6Yc89dOMUvNaNtBCjtPABLSwrikVuTUmU1JrtNkaw2tbu0TmK1zHCbPLxbxdXtb+GcrrJ5S/O3Qhsu9BabzGVgSDgdbYo37enXHRhaXcEr6RBBPr/Z9bx7zDHbNOt6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYXsfCUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYXsfCUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFA71F0089D;
	Mon, 12 Oct 2026 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819718;
	bh=ujwFhpLz3XKASWHL3YRWTgjhGqU2MyFjle4dKcAC3s4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HYXsfCUTZ/ABUJW2XWAQCOeE0QSo8eGPn8RXD0FtVxDe+FVWGieulRPn+KW0s3/Hi
	 NG6c5aFQWuZoRdr4zmYlV/cznfjmH8PN2kFU47+bMuxxiDdpVnO06vN6vl+isi8c3N
	 UQ88+2+xzzO0iY4eBdAjH5lZHKHdHh7VNf6juX3mEJ7RGp8G6YfxDYCXWIa6LSZu2Z
	 /f8CT3r9in2z36m1aTAlol+uQFGmo1M3sY5ER/Av9IwCdbw+ZzkZCl7oM1RkzT87VM
	 EV/qpaczIXqft2B/iqlZwXMc1/UtOY5aQDYFXige3vCuGSMU4ATGinFQnuqhXZce0+
	 9KuPe7b4DTn1g==
Subject: Re: [PATCH net-next 06/11] net: ethernet: qualcomm: ppe: Add IPQ5424
 BM buffer configuration
From: netdev-bot+sashiko@kernel.org
To: jie.luo@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com,
 quic_pavir@quicinc.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Date: Mon, 12 Oct 2026 15:41:57 +0000
Message-ID: <179181971709.434549.2234734092674556107@kernel.org>
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-6-16caf43e44ee@oss.qualcomm.com>
References: <20261008-qcom_ipq5424_ppe-v1-6-16caf43e44ee@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] IPQ5424 probe fails at this one commit and works again after
  the next patch.
- [Low] The IPQ5424 BM USED/REACT debugfs dump reads the wrong registers
  at this one commit and is fixed later in the series.

--

net: ethernet: qualcomm: ppe: Add IPQ5424 BM buffer configuration

This commit adds a PPE type field so the driver can pick settings per SoC.
It also adds the IPQ5424 BM port and shared group buffer configuration. Some
BM register addresses and entry counts become per-device macros, because
IPQ5424 has 19 BM ports and some BM tables sit at different addresses.

> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> index 8a553902ffad1..3afa571193238 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c

[ ... ]

> @@ -1472,12 +1535,23 @@ static int ppe_config_bm(struct ppe_device *ppe_dev)
>   */
>  static int ppe_config_qm(struct ppe_device *ppe_dev)
>  {
> +	int ret, i, group_buffer_cfg, queue_id, queue_cfg_count;
>  	const struct ppe_qm_queue_config *queue_cfg;
> -	int ret, i, queue_id, queue_cfg_count;
>  	u32 reg, multicast_queue_cfg[5];
>  	u32 unicast_queue_cfg[4];
>  	u32 group_cfg[3];
>  
> +	switch (ppe_dev->type) {
> +	case IPQ9574_PPE:
> +		group_buffer_cfg = ipq9574_ppe_qm_group_config;
> +		queue_cfg = ipq9574_ppe_qm_queue_config;
> +		queue_cfg_count = ARRAY_SIZE(ipq9574_ppe_qm_queue_config);
> +		break;
> +	default:
> +		dev_err(ppe_dev->dev, "Invalid PPE type %d\n", ppe_dev->type);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Does IPQ5424 fail to probe at this commit? This switch has no IPQ5424_PPE
case. However, this patch now sets ppe_dev->type = IPQ5424_PPE for the
qcom,ipq5424-ppe compatible.

ppe_hw_config() always calls ppe_config_qm() right after ppe_config_bm().
On IPQ5424 the path is:

qcom_ppe_probe()
  ppe_hw_config()
    ppe_config_bm()    <- succeeds with the new IPQ5424 tables
    ppe_config_qm()    <- default branch, returns -EINVAL

Probe then fails with "PPE HW config failed".

The next patch in the series, "net: ethernet: qualcomm: ppe: Add IPQ5424
QM configuration", adds the IPQ5424_PPE case, so the series works once it
is fully applied.

Could the QM case be added here, or the ppe_config_qm() refactor be moved
into the next patch? Either way, this commit would stay bisectable on
IPQ5424.

Also, the commit message only describes the BM changes. It doesn't mention
the ppe_config_qm() refactor.

> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
> index 746dfbb5a6821..441e8e04a80b1 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
> @@ -386,17 +386,32 @@

[ ... ]

> -#define PPE_BM_PORT_GROUP_ID_ADDR		0x600180
> -#define PPE_BM_PORT_GROUP_ID_ENTRIES		15
> +#define PPE_BM_PORT_GROUP_ID_IPQ9574_ADDR	0x600180
> +#define PPE_BM_PORT_GROUP_ID_IPQ5424_ADDR	0x6001c0

[Severity: Low]
Does the BM USED/REACT dump in debugfs read the wrong registers on IPQ5424
at this commit?

The IPQ5424 group ID table now starts at 0x6001c0. The counter tables
further down this file still use the IPQ9574 addresses and entry counts:

drivers/net/ethernet/qualcomm/ppe/ppe_regs.h:
#define PPE_BM_USED_CNT_TBL_ADDR		0x6001c0
#define PPE_BM_USED_CNT_TBL_ENTRIES		15
...
#define PPE_BM_REACT_CNT_TBL_ADDR		0x600240
#define PPE_BM_REACT_CNT_TBL_ENTRIES		15

ppe_bm_counter_get() uses these values whatever ppe_dev->type is:

drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c:ppe_bm_counter_get() {
    ...
	for (i = 0; i < PPE_BM_USED_CNT_TBL_ENTRIES; i++) {
		reg = PPE_BM_USED_CNT_TBL_ADDR + i * PPE_BM_USED_CNT_TBL_INC;
    ...
		reg = PPE_BM_REACT_CNT_TBL_ADDR + i * PPE_BM_REACT_CNT_TBL_INC;
    ...
}

On IPQ5424 this has three effects:

- The group ID registers are reported as used buffer counts.
- The react counts are read from the wrong address.
- BM ports 15-18 are never read.

The last patch in the series, "net: ethernet: qualcomm: ppe: Add IPQ5424
counter debugfs support", appears to fix this. It adds per-device
PPE_BM_USED_CNT_TBL_ADDR(ppe_dev) (0x600220) and
PPE_BM_REACT_CNT_TBL_ADDR(ppe_dev) (0x600280), both with 19 entries.

Could those definitions move into this patch with the other BM address
changes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee%40oss.qualcomm.com
