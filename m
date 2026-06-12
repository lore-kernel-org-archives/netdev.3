Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506A37188B;
	Fri, 12 Jun 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280493; cv=none; b=feeG4Qx+0fQu+ySUn0DQj+oPotJ9ySEbQV2lt1D+IaFwXpLzJxau8c2a43MKza0WQCpNb+tFh3XSPuTrkXbzi387xqT5pxJbq4U8g2HZElN1CXlArp9vuJ4FKoLDeq04nNKlKBx9TOiUmZU5JNb0FePtQPKa0stbSABx5T+d3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280493; c=relaxed/simple;
	bh=M/wf3o0DP9VXFIEP8CbWkMlCCFbRkDPnne6Va5fgV1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJQd2vsTAhDf4J6fpF9WN5/pS1jfL3m7b4tgL/Kw1yyOE9Pb8SxqMcIRj1aI1ACLUenBdCjZzIeGIxnq/537U+TY9BAlVji5vGPFx4UpiZ5LmVwZ4kulwD0VayPrqk8VcbwAseGVKkVFhWNE179XsqQWuoOOvPvEkUSWeizyraE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOEGeQkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOEGeQkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512FF1F000E9;
	Fri, 12 Jun 2026 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280492;
	bh=MTLXwO3pxjG0kNwRdFnumoaMgaDcU0lV/jCfpoGgX8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WOEGeQkGJHeE0IkHfsvf2KNGaYCVqEMk5WYKW1x3onaLqjO4v0Ono3xde+hChJy5m
	 3fvV6RsnIl/yYQmMo9h2Z6LiZrjjA/xJL0vwYDT/FWNmoMwnAtIc+0bR3MHrgAnToS
	 9B3qmsorLl+mfi1X7XTP584uWwUAU3kTp31OIn3dh7pzujrv3fkOlK8OSrDPHo58Ww
	 /72Nhbe3o+b9DI7B4E56d+Ag2eYEg6WHBxzgAcXw9NYJA4jnkcYOjKuroSUwslqYaF
	 LZbe7XWhtvEzaSk8wYj079VuLBkiscKsjX4iiVJkFK2SmkSP63mTmmALuEr2dItLXW
	 r8gmHJ5XQ3+gA==
From: Simon Horman <horms@kernel.org>
To: gongfan1@huawei.com
Cc: Simon Horman <horms@kernel.org>,
	wudi234@huawei.com,
	tengpeisen@huawei.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	ioana.ciornei@nxp.com,
	mohsin.bashr@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	luosifu@huawei.com,
	guoxin09@huawei.com,
	zhoushuai28@huawei.com,
	wulike1@huawei.com,
	shijing34@huawei.com,
	zhengjiezhen@h-partners.com,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v09 3/5] hinic3: Add ethtool coalesce ops
Date: Fri, 12 Jun 2026 17:08:04 +0100
Message-ID: <20260612160805.690542-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <dda2f285e7314fa4a682a031328766e58f3137dc.1781062575.git.wudi234@huawei.com>
References: <dda2f285e7314fa4a682a031328766e58f3137dc.1781062575.git.wudi234@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
hinic3: Add ethtool coalesce ops

This patch implements the .get_coalesce and .set_coalesce ethtool callbacks
for the hinic3 driver. It allows users to configure and monitor RX coalesce
parameters.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
[ ... ]
> @@ -975,9 +980,247 @@ static void hinic3_get_pause_stats(struct net_device *netdev,
> +static int hinic3_set_queue_coalesce(struct net_device *netdev, u16 q_id,
> +				     struct hinic3_intr_coal_info *coal,
> +				     struct netlink_ext_ack *extack)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_intr_coal_info *intr_coal;
> +	struct hinic3_interrupt_info info = {};
> +	int err;
> +
> +	if (nic_dev->adaptive_rx_coal) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Static coalesce not allowed in adaptive RX mode");
> +		return -EINVAL;
> +	}

[Severity: High]
When adaptive RX coalesce is enabled via ethtool, hinic3_set_coalesce()
sets nic_dev->adaptive_rx_coal to 1 before calling this function.

Will this check then unconditionally return -EINVAL, failing the operation
while leaving the software state permanently incorrectly recording that
adaptive mode is on?

> +
> +	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
> +	    q_id >= nic_dev->q_params.num_qps)
> +		return 0;
> +
> +	spin_lock(&nic_dev->coal_lock);
> +
> +	intr_coal = &nic_dev->intr_coalesce[q_id];

[Severity: Medium]
If the interface is down, this early return skips updating the software
configuration struct.

Will this cause the new coalesce parameters to be silently lost instead
of being applied when the interface is later brought up?

> +
> +	intr_coal->coalesce_timer_cfg = coal->coalesce_timer_cfg;
> +	intr_coal->pending_limit = coal->pending_limit;
> +	intr_coal->rx_pending_limit_low = coal->rx_pending_limit_low;
> +	intr_coal->rx_pending_limit_high = coal->rx_pending_limit_high;
> +	spin_unlock(&nic_dev->coal_lock);
> +
> +	info.msix_index = nic_dev->q_params.irq_cfg[q_id].msix_entry_idx;
> +	info.interrupt_coalesc_set = 1;
> +	info.coalesc_timer_cfg = intr_coal->coalesce_timer_cfg;
> +	info.pending_limit = intr_coal->pending_limit;
> +	info.resend_timer_cfg = intr_coal->resend_timer_cfg;
> +	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);

[Severity: High]
Does hinic3_set_interrupt_cfg() need to be protected by change_res_mutex
here?

The DIM code path in hinic3_set_interrupt_moder() holds change_res_mutex
when performing this same hardware configuration. Since ethtool commands
and the DIM workqueue can run concurrently, could this lead to a race
condition corrupting the read-modify-write hardware state?

> +	if (err) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Failed to set queue%u coalesce",
> +				       q_id);
> +		return err;
> +	}

[Severity: Medium]
If hinic3_set_interrupt_cfg() fails, the software state in intr_coal
has already been updated.

Because hinic3_set_hw_coal_param() runs this in a loop over all queues,
will a hardware configuration failure leave the software state permanently
diverging from the actual physical hardware state?

[ ... ]
> +static int hinic3_get_coalesce(struct net_device *netdev,
> +			       struct ethtool_coalesce *coal,
> +			       struct kernel_ethtool_coalesce *kernel_coal,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_intr_coal_info *interrupt_info;
> +
> +	memset(coal, 0, sizeof(*coal));

[Severity: Medium]
Is it safe to memset the entire ethtool_coalesce structure here?

The core ethtool ioctl code pre-initializes the cmd field to
ETHTOOL_GCOALESCE, so zeroing the entire struct will wipe the cmd field
and break the ethtool UAPI.

> +
> +	interrupt_info = &nic_dev->intr_coalesce[0];
> +
> +	coal->use_adaptive_rx_coalesce = nic_dev->adaptive_rx_coal;
> +
> +	if (nic_dev->adaptive_rx_coal) {
> +		coal->rx_max_coalesced_frames_low =
> +			interrupt_info->rx_pending_limit_low *
> +			COALESCE_PENDING_LIMIT_UNIT;
> +		coal->rx_max_coalesced_frames_high =
> +			interrupt_info->rx_pending_limit_high *
> +			COALESCE_PENDING_LIMIT_UNIT;
> +	} else {
> +		/* TX/RX uses the same interrupt.
> +		 * So we only declare RX ethtool_coalesce parameters.
> +		 */
> +		coal->rx_coalesce_usecs = interrupt_info->coalesce_timer_cfg *
> +					  COALESCE_TIMER_CFG_UNIT;
> +		coal->rx_max_coalesced_frames = interrupt_info->pending_limit *
> +						COALESCE_PENDING_LIMIT_UNIT;
> +	}

[Severity: High]
When adaptive mode is active, the static coalesce fields are left as 0,
and vice versa.

During an ethtool read-modify-write cycle, will the intermediate 0 values
be passed back to hinic3_set_coalesce() and unconditionally overwrite
the driver state, wiping out the inactive configuration?

[ ... ]
> +static int hinic3_set_coalesce(struct net_device *netdev,
> +			       struct ethtool_coalesce *coal,
> +			       struct kernel_ethtool_coalesce *kernel_coal,
> +			       struct netlink_ext_ack *extack)
> +{
[ ... ]
> +	intr_coal.coalesce_timer_cfg =
> +		(u8)(coal->rx_coalesce_usecs / COALESCE_TIMER_CFG_UNIT);
> +	intr_coal.pending_limit = (u8)(coal->rx_max_coalesced_frames /
> +				      COALESCE_PENDING_LIMIT_UNIT);
> +
> +	nic_dev->adaptive_rx_coal = coal->use_adaptive_rx_coalesce;

[Severity: High]
When disabling adaptive RX coalesce, is it necessary to cancel any
pending DIM work items before programming the hardware?

If a rxq->dim.work item is already executing concurrently or scheduled,
could it fire after the ethtool command completes and overwrite these newly
configured static limits with stale dynamically calculated values?

> +
> +	intr_coal.rx_pending_limit_high =
> +		(u8)(coal->rx_max_coalesced_frames_high /
> +		     COALESCE_PENDING_LIMIT_UNIT);
> +
> +	intr_coal.rx_pending_limit_low =
> +		(u8)(coal->rx_max_coalesced_frames_low /
> +		     COALESCE_PENDING_LIMIT_UNIT);
> +
> +	/* coalesce timer or pending set to zero will disable coalesce */
> +	if (!nic_dev->adaptive_rx_coal &&
> +	    (!intr_coal.coalesce_timer_cfg || !intr_coal.pending_limit))
> +		NL_SET_ERR_MSG_MOD(extack, "Coalesce will be disabled");
> +
> +	return hinic3_set_hw_coal_param(netdev, &intr_coal, extack);
> +}
