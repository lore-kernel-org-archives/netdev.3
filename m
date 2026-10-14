Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA53546ED;
	Wed, 14 Oct 2026 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945407; cv=none; b=U9Yo9PrHz3iBCxM7h3cVvr/vvubgfwUcGUOnhZd/xAYoYYg3j4Vp96tIZRYievfEdGh0Rp2/E1mrMOzPGEu2gqV57XGw+cdW9V1YLMqD0pGVFCwMFOSx1Bekw7DXhrlxlQRLU91xX9y81/hLNuZoEDMRANwfSIk77EoBBak4NL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945407; c=relaxed/simple;
	bh=nBYPJ6hQ2zwD9dhiLLMMERUOYL/Q6XZyOvsjIQMqHog=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XyjZtrajHwnGjlw+K5m70QJ/hzQC8ZUyo6E6z+T12AYkLbb0qDyT1vjGeec7wi7JByJcLJJHnZeKb0PcP9C/PVn/cXJZRtYG8FJjRpSdZsyl26yoI0M97Fj34X+r4PmsDlLHBYKEotN/M1h0MjfAjbXWPKQJ9MWDonXni2yVKsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2AP7ouo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2AP7ouo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D9D1F00893;
	Wed, 14 Oct 2026 02:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945405;
	bh=NFKiLkRrPiUeuoNYCtT7oKjnxArLpHFtM3eBd6KaK7A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I2AP7ouov0sOgDuJVi0YU4/Qa+jileELU8/OpmPIBeN0H/DN+xC7qD0yh9A3tOl/1
	 wO8zIBJwNPMy3ekKIwlTaHyzfnpwhDYV1sbYTgrw2k7w0ZFu2jfb9m3Y2TNQn0e+QY
	 A70JX/+oJo7zjvwwlzYXctXdQ3VN5z45w3stLsFqGSa3ZGYClDLpSduU/cJjq6KLi0
	 SuAe8KKkJECptWRPys5nrE94SxPyQT7oruG2P6eAnAqcjWDWicRJ+81SBX9ftqphA8
	 HzNwRCCkovYOkD93rnSpd3I6rxxy/XDRSUGOCHoDs+5wCAsFrGE3WrSE412kpboh7r
	 lcAZRzBXW8k9g==
Subject: Re: [PATCH net-next v14 2/2] hinic3: Add ethtool statistic ops part2
From: netdev-bot+sashiko@kernel.org
To: gongfan1@huawei.com
Cc: wudi234@huawei.com, tengpeisen@huawei.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, ioana.ciornei@nxp.com,
 maxime.chevallier@bootlin.com, mohsin.bashr@gmail.com,
 dimitri.daskalakis1@gmail.com, hramamurthy@google.com,
 larysa.zaremba@intel.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 zhoushuai28@huawei.com, wulike1@huawei.com
Date: Wed, 14 Oct 2026 02:36:44 +0000
Message-ID: <179194540407.434549.6240409030242210074@kernel.org>
In-Reply-To:
 <d3d6148426f3228b52e9b8082262aa71c7fdf6dc.1791858167.git.gongfan1@huawei.com>
References:
 <d3d6148426f3228b52e9b8082262aa71c7fdf6dc.1791858167.git.gongfan1@huawei.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Of the five new callbacks, only hinic3_get_eth_phy_stats()
  returns early for VFs (`if (HINIC3_IS_VF(nic_dev->hwdev)) return;`).
- [Medium] Several counters are now reported through both the private
  ethtool -S table and the standard RMON uAPI.
- [Medium] Nothing can ever call hinic3_get_pause_stats().
- [Low] The commit message does not describe this patch.

--

hinic3: Add ethtool statistic ops part2

This commit adds five standard ethtool statistics callbacks to the hinic3
driver: get_eth_phy_stats, get_eth_mac_stats, get_eth_ctrl_stats,
get_rmon_stats and get_pause_stats. Each callback reads the physical port
counters from firmware via hinic3_get_phy_port_stats() and copies them
into the standard ethtool structures.

>   Add PF/VF statistics functions in TX and RX processing.

[Severity: Low]
This isn't a bug, but this sentence matches the one in the part1 commit
("hinic3: Add ethtool statistic ops part1"). This patch doesn't touch any
TX or RX processing code. It only adds read-only ethtool callbacks in
hinic3_ethtool.c that use the MAG_CMD_GET_PORT_STAT firmware query.

The message also doesn't say how VFs are handled. Only
hinic3_get_eth_phy_stats() returns early for VFs.

Could the commit message be updated to describe what this patch does?

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 3863d26542ad4..f61337d494444 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> @@ -723,6 +723,179 @@ static void hinic3_get_ethtool_stats(struct net_device *netdev,
>  	hinic3_get_drv_queue_stats(netdev, data + i);
>  }
>  
> +static void hinic3_get_eth_phy_stats(struct net_device *netdev,
> +				     struct ethtool_eth_phy_stats *phy_stats)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct mag_cmd_port_stats *ps;
> +	int err;
> +
> +	if (HINIC3_IS_VF(nic_dev->hwdev))
> +		return;

[ ... ]

> +static void hinic3_get_eth_mac_stats(struct net_device *netdev,
> +				     struct ethtool_eth_mac_stats *mac_stats)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct mag_cmd_port_stats *ps;
> +	int err;
> +
> +	ps = kmalloc_obj(*ps);
> +	if (!ps)
> +		return;
> +
> +	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
> +	if (err) {
> +		kfree(ps);
> +		netdev_err(netdev, "Failed to get eth mac stats from fw\n");
> +		return;
> +	}

[Severity: Medium]
Should this callback, and the new ctrl, rmon and pause callbacks, have the
same HINIC3_IS_VF() check as hinic3_get_eth_phy_stats()?

As written, on a VF these call hinic3_get_phy_port_stats(), which sends
MAG_CMD_GET_PORT_STAT for hinic3_physical_port_id(hwdev).

The rest of the driver keeps physical port stats away from VFs. For
example, hinic3_get_ethtool_stats() does:

	if (!HINIC3_IS_VF(nic_dev->hwdev))
		i += hinic3_get_ethtool_port_stats(netdev, data + i);

hinic3_get_hw_stats_strings() and hinic3_get_sset_count() do the same.
hinic3_get_link_settings() also skips the pause query on VFs.

ETHTOOL_MSG_STATS_GET does not require admin permission. Any unprivileged
user can reach these callbacks with something like
"ethtool -S <vf> --groups eth-mac eth-ctrl rmon".

If firmware accepts the query from a VF, the VF sees port-wide MAC, control
and RMON counters. Those include traffic from the PF and every other VF on
the port.

If firmware rejects it, each request makes several blocking mailbox round
trips. Each failure also logs an unratelimited dev_err() in
hinic3_get_phy_port_stats() plus a netdev_err() in the callback. Could
that be used to flood the kernel log?

[ ... ]

> +static void hinic3_get_rmon_stats(struct net_device *netdev,
> +				  struct ethtool_rmon_stats *rmon_stats,
> +				  const struct ethtool_rmon_hist_range **ranges)
> +{

[ ... ]

> +	rmon_stats->undersize_pkts	= ps->mac_rx_undersize_pkt_num;
> +	rmon_stats->oversize_pkts	= ps->mac_rx_oversize_pkt_num;
> +	rmon_stats->fragments		= ps->mac_rx_fragment_pkt_num;
> +	rmon_stats->jabbers		= ps->mac_rx_jabber_pkt_num;
> +
> +	rmon_stats->hist[0]		= ps->mac_rx_64_oct_pkt_num;

[ ... ]

> +	rmon_stats->hist_tx[10]		= ps->mac_tx_9217_12287_oct_pkt_num;

[Severity: Medium]
Are these counters now reported to userspace twice? hinic3_port_stats[],
added by the part1 patch, still exports the same values through
ethtool -S:

	HINIC3_PORT_STAT(mac_tx_64_oct_pkt_num),
	...
	HINIC3_PORT_STAT(mac_tx_9217_12287_oct_pkt_num),
	...
	HINIC3_PORT_STAT(mac_rx_fragment_pkt_num),
	HINIC3_PORT_STAT(mac_rx_undersize_pkt_num),
	...
	HINIC3_PORT_STAT(mac_rx_64_oct_pkt_num),
	...
	HINIC3_PORT_STAT(mac_rx_9217_12287_oct_pkt_num),

The table already omits the counters that the new mac, ctrl, pause and phy
callbacks report (good, multi and broad counts, pause, control, oversize,
jabber, sym_err, fcs_err). The RMON histogram, fragment and undersize
entries are still in it.

Counters that have a standard uAPI should not be duplicated in ethtool -S.
Should these 24 entries be removed from hinic3_port_stats[]?

[ ... ]

> @@ -734,6 +907,11 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
>  	.get_strings                    = hinic3_get_strings,
>  	.get_sset_count                 = hinic3_get_sset_count,
>  	.get_ethtool_stats              = hinic3_get_ethtool_stats,
> +	.get_eth_phy_stats              = hinic3_get_eth_phy_stats,
> +	.get_eth_mac_stats              = hinic3_get_eth_mac_stats,
> +	.get_eth_ctrl_stats             = hinic3_get_eth_ctrl_stats,
> +	.get_rmon_stats                 = hinic3_get_rmon_stats,
> +	.get_pause_stats                = hinic3_get_pause_stats,
>  };

[Severity: Medium]
Can hinic3_get_pause_stats() ever be called? The driver doesn't provide a
.get_pauseparam callback, and pause_prepare_data() in net/ethtool/pause.c
returns before it calls get_pause_stats:

	if (!dev->ethtool_ops->get_pauseparam)
		return -EOPNOTSUPP;
	...
	dev->ethtool_ops->get_pauseparam(dev, &data->pauseparam);
	if (req_base->flags & ETHTOOL_FLAG_STATS &&
	    dev->ethtool_ops->get_pause_stats)
		dev->ethtool_ops->get_pause_stats(dev, &data->pausestat);

Pause stats aren't part of the ETHTOOL_MSG_STATS_GET groups either. So
"ethtool -I -a <dev>" fails with -EOPNOTSUPP, and there is no standard way
to read mac_tx_pause_num or mac_rx_pause_num.

Does this patch also need a .get_pauseparam implementation?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791858167.git.gongfan1%40huawei.com
