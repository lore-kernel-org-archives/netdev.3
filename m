Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A944A4821;
	Mon, 12 Oct 2026 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819721; cv=none; b=mvZ0qjt28tRpfTdGglzImRuhvoLAjWWibKRc8O81Qfq4xFOU2rEe6S7+vO/mofIO3r+kcq2hjLsJy8Rv2/6DUl/4IzKPBwWgX0+uiidTVPY5vaw0V8/UWkgyscTvjUzQGsXKWTqboM47AoMBXEykOY/Na++F21wgvLolZQwvMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819721; c=relaxed/simple;
	bh=XAnhz1mirDwmVj3aOExItfgA4mwZ21O63+rFq0efbFc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HR1bF64IfJPog6K0Eg/+blMoxcH4lN6i3aDetSDxqsd9/B0OvTCXUre2etuUzdraKZ71S0MF2hmTvwpuLALWyPjddMT7DoIMyU6M2zmq09sxxFmnVq6kwkgf1ukLDZrQ0SnIVsU07MzhOtxw2LcKjvznGFki1xqtlB77CFa1cEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC52byWd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC52byWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A8E1F0089C;
	Mon, 12 Oct 2026 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819720;
	bh=wuLf0VrLEynp1JMveews2MJ12aRA4lFDnGWjYHOdqT0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fC52byWdfO2ZG6dmR23zbwbId4Uq0J5tDNvIZNz6W5wm6pwmCfwaED/zZwLpUVsrF
	 dLM5oiyvSrn7nqKyQrKwJh2BahNPHPpO8E3CxYG8vIK+IYuKdNGJ+OAYcydNqixi/t
	 X7BZiWPFgMLYMwgad3WbEPzlZj88VIqpwprE/tZUJ1mvaic5CsEdeTafT5BhH9GuYY
	 84r1jUJ4iGPIsEq7+ghow9FAvOkbzXfSxnEsa44SchVsdbxP/6jCkqawMK5BfN88Ze
	 t5w1Q9Jc/iTo77kHzHsaZVj3MRokMlTRZqEd+L9Fdn2m/ztaJhiHqYmC7aAn6aZBRY
	 PYY7BuINC8vqw==
Subject: Re: [PATCH net-next 07/11] net: ethernet: qualcomm: ppe: Add IPQ5424
 QM configuration
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
Date: Mon, 12 Oct 2026 15:41:58 +0000
Message-ID: <179181971879.434549.6176463312872998713@kernel.org>
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-7-16caf43e44ee@oss.qualcomm.com>
References: <20261008-qcom_ipq5424_ppe-v1-7-16caf43e44ee@oss.qualcomm.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, ppe_config_qm() succeeds on IPQ5424 for the
  first time, so probe goes on to ppe_config_scheduler().
- [Low] The new comment above ipq5424_ppe_qm_group_config
  (ppe_config.c:317-321) says multicast queues 284-299 are missing…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but
  ppe_queue_counter_get() in ppe_debugfs.c still loops `for (i = 0; i <…

--

net: ethernet: qualcomm: ppe: Add IPQ5424 QM configuration

This commit adds an IPQ5424 case to ppe_config_qm(). It sets the shared
group0 buffer pool to 2010 buffers, unicast queues to 0-255, and multicast
queues to 256-283, because IPQ5424 has fewer PPE ports than IPQ9574.

> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> index 3afa571193238..dec8eed772539 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> @@ -314,6 +314,37 @@ static const struct ppe_qm_queue_config ipq9574_ppe_qm_queue_config[] = {
>  	},
>  };
>  
> +/* Multicast queues are dedicated per PPE port. IPQ5424 has only 3 physical
> + * PPE ports, versus IPQ9574's 6 PPE ports, so multicast queues 284 to 299
> + * are not available on IPQ5424, and the buffer pool assigned to the general
> + * 'group0' is larger here, 2010 versus IPQ9574's 2000.
> + */

[Severity: Low]
This isn't a bug, but is the explanation in this comment complete?

ppe_scheduler_res gives each port 4 multicast queues. On IPQ9574, ports 4,
5, 6 and 7 own 284-287, 288-291, 292-295 and 296-299. Three fewer physical
ports only cover 12 of the 16 missing queues.

Port 7 is the EIP FIFO, and IPQ5424 doesn't have one either:

drivers/net/ethernet/qualcomm/ppe/ppe.c:
/* 6 physical ports, 1 EDMA FIFO and 1 EIP FIFO. */
#define IPQ9574_PPE_PORT_MAX		8
/* 3 physical ports and 1 EDMA FIFO. */
#define IPQ5424_PPE_PORT_MAX		4

The 256-283 range itself looks correct. The commit message gives the same
reason:

  IPQ5424 has only 3 physical PPE ports, versus IPQ9574's 6 PPE ports, so
  multicast queues 284 to 299 are not available on IPQ5424

Could the comment and the commit message also mention the missing EIP FIFO?
The comment is still the same at the end of the series.

> +static const int ipq5424_ppe_qm_group_config = 2010;
> +
> +/* Default QM settings for unicast and multicast queues for IPQ5424. */
> +static const struct ppe_qm_queue_config ipq5424_ppe_qm_queue_config[] = {

[ ... ]

> +	{
> +		/* QM settings for multicast queues 256 to 283. */
> +		.queue_start	= 256,
> +		.queue_end	= 283,

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch. IPQ5424 is
now limited to multicast queues 256-283, but ppe_queue_counter_get() in
ppe_debugfs.c still loops over all 300 queues on every SoC:

drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c:ppe_queue_counter_get() {
    ...
	for (i = 0; i < PPE_QUEUE_TX_COUNTER_TBL_ENTRIES; i++) {
		reg = PPE_QUEUE_TX_COUNTER_TBL_ADDR + PPE_QUEUE_TX_COUNTER_TBL_INC * i;
    ...
}

PPE_QUEUE_TX_COUNTER_TBL_ENTRIES is defined as 300. The PPE_CNT_QM clear
path in ppe_packet_counter_write() does the same.

On IPQ5424, wouldn't this read the queue TX, multicast pending and
per-port multicast drop counters for queues 284-299? The clear path would
also write to them, even though this patch says those queues don't exist.

A later commit in the series, "Add IPQ5424 counter debugfs support", makes
the BM counter tables per-SoC but leaves the QM loops at 300. Queues 284-299
get no traffic on IPQ5424 and only non-zero counters are printed, so the
output may look the same.

Should the QM loops have a per-SoC limit too?

> +		.prealloc_buf	= 0,
> +		.ceil		= 250,
> +		.weight		= 0,
> +		.resume_offset	= 36,
> +		.dynamic	= false,
> +	},
> +};

[ ... ]

> @@ -1547,6 +1578,11 @@ static int ppe_config_qm(struct ppe_device *ppe_dev)
>  		queue_cfg = ipq9574_ppe_qm_queue_config;
>  		queue_cfg_count = ARRAY_SIZE(ipq9574_ppe_qm_queue_config);
>  		break;
> +	case IPQ5424_PPE:
> +		group_buffer_cfg = ipq5424_ppe_qm_group_config;
> +		queue_cfg = ipq5424_ppe_qm_queue_config;
> +		queue_cfg_count = ARRAY_SIZE(ipq5424_ppe_qm_queue_config);
> +		break;

[Severity: Medium]
With this case added, ppe_config_qm() now succeeds on IPQ5424, so probe
goes on to ppe_config_scheduler(). At this commit, that function uses the
IPQ9574 tables on every SoC:

drivers/net/ethernet/qualcomm/ppe/ppe_config.c:ppe_config_scheduler() {
    ...
	count = ARRAY_SIZE(ipq9574_ppe_sch_bm_config);
	bm_cfg = ipq9574_ppe_sch_bm_config;
    ...
}

ipq9574_ppe_sch_bm_config and ipq9574_ppe_sch_qm_config give BM and QM
arbitration slots to ports 4-7, and IPQ5424 doesn't have those ports.

If a kernel is built from this commit, won't an IPQ5424 device get the
IPQ9574 BM and QM scheduler calendars?

A later patch in this series, "net: ethernet: qualcomm: ppe: Add IPQ5424
scheduler configuration", adds ipq5424_ppe_sch_bm_config and
ipq5424_ppe_sch_qm_config and a per-SoC switch in ppe_config_scheduler().
That means this only affects builds between the two commits, for example
during bisection.

Could the scheduler configuration patch come before this one, so that each
commit configures IPQ5424 correctly?

>  	default:
>  		dev_err(ppe_dev->dev, "Invalid PPE type %d\n", ppe_dev->type);
>  		return -EINVAL;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee%40oss.qualcomm.com
