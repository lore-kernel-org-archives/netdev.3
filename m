Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640806;
	b=Vp0Hvnv8ocmFdrDvUbXZMqa8sP0IogxRHjzMDT5Lm4M8R+xDolPj9jODbZP8ioX1NTVM
	 v0+iixDbuHOra8qXfGmGQtBnKJV7VkArLQ0nluyJN3Ce6cFW87JK8z+mNjJBiVfh67D2d
	 EdOW+YK7s6bKM3+nAP8CuiiBrZM4aitNGhpD0URsKLdrLTfDEfydiQNe3NqwWk7P2zRpJ
	 l2rVtnPgyuyje0A9jj+EWouB7Ptkn+DQPy9Y/yg76kk/KPQT672sNHZCkfJSMDhc3+AXO
	 d2rd4il5E2VLgMtRyM/05XXOqqaqzKU3C5oCw/+jWnHF984ZrjjZ0ZlkcgqHgVbKykg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640806;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4fcTMVzHIhmN5IoyyVLlVIfM3MPNNXbJtiu5nB9jYtM=;
	b=XEkxw1lIcry9NiTsGtCTwxNHqf5vmsul2Hgj1828mXByMn1WlNMl5T3vE/pExAuau5fb
	 PFVIHijfGPvv+MXXQRP3ZbfwJAmLSGZMotZI52WX0BmB2WUXBf7UwsdilsqhDlVFEtESi
	 7uTu9eu/CHM6ZG3X36s2AH+QGOiWaOp+Dhi1zKgcaMxBBmOSatzBJDCN+B9tfNADWL61o
	 OnW//q7L8x3ObOWQeOm09IDFe/flEjxoUcNTJeZQXN1omPIxjHX4Ndv0/wlpvHHa3L5Pb
	 q4bCCbCCXUd2BevkyjV2RILCPiBZQWtLXiZpN7KI01AjupvYf3HDyA4MmXVfhJoMP5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghz0bZcF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB0606A332;
	Thu, 22 Oct 2026 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghz0bZcF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3601F000C1;
	Thu, 22 Oct 2026 03:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792640805;
	bh=4fcTMVzHIhmN5IoyyVLlVIfM3MPNNXbJtiu5nB9jYtM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ghz0bZcFO2ICLR9nS07ZUgDU767zCaPKEsyCKqsacmuuH8982hXAxsATTzSaaW0ZN
	 JTw7DZP834wt0E4BgbJr4MP1UZ7tpbfuhHw0h1FhHdBt9HAiQepHpzmA5OX5TKVf9f
	 v27UtsWzvdJTfAEyEglRy40Aabu/0KU5Wgafn3CVNEc3D1TZV3kRILqZ7MeZS/D7UW
	 0GUyCCR6dQArj7wv0HB9vs4JUW38vt7wNKrZpFpPKDUcJ1WO5g7jY6ustHCwrgK8OB
	 oV3XE93uK8DpGpj4L6o4s2iQHscSob73JCNciJv3ixdmHVIr+UOkdi7+fjGUyG0MX8
	 WS2a8fZjKmtUA==
Subject: Re: [PATCH net-next v17 2/2] hinic3: Add ethtool statistic ops part2
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
Date: Thu, 22 Oct 2026 03:46:43 +0000
Message-ID: <179264080395.3135.834074310009074435@kernel.org>
In-Reply-To:
 <abc78c964dec55e440f8023db505632186d53d89.1792378301.git.gongfan1@huawei.com>
References:
 <abc78c964dec55e440f8023db505632186d53d89.1792378301.git.gongfan1@huawei.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] hinic3_get_pause_stats() can never be called.

--

hinic3: Add ethtool statistic ops part2

This commit adds five standard ethtool statistics callbacks to the hinic3
driver: get_eth_phy_stats, get_eth_mac_stats, get_eth_ctrl_stats,
get_rmon_stats and get_pause_stats. Each callback reads the physical port
counters from firmware and copies them into the standard ethtool
structures.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 64c862052f1e8..2ae4d5afe90df 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c

[ ... ]

> +static void hinic3_get_pause_stats(struct net_device *netdev,
> +				   struct ethtool_pause_stats *pause_stats)
> +{

[ ... ]

> +	pause_stats->tx_pause_frames = le64_to_cpu(ps->mac_tx_pause_pkts);
> +	pause_stats->rx_pause_frames = le64_to_cpu(ps->mac_rx_pause_pkts);
> +
> +	kfree(ps);
> +}

[ ... ]

> @@ -707,6 +904,11 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
>  	.get_strings                    = hinic3_get_strings,
>  	.get_sset_count                 = hinic3_get_sset_count,
>  	.get_ethtool_stats              = hinic3_get_ethtool_stats,
> +	.get_eth_phy_stats              = hinic3_get_eth_phy_stats,
> +	.get_eth_mac_stats              = hinic3_get_eth_mac_stats,
> +	.get_eth_ctrl_stats             = hinic3_get_eth_ctrl_stats,
> +	.get_rmon_stats                 = hinic3_get_rmon_stats,
> +	.get_pause_stats                = hinic3_get_pause_stats,

[Severity: Medium]
Can hinic3_get_pause_stats() actually be reached by the ethtool core?

hinic3_ethtool_ops sets .get_pause_stats but has no .get_pauseparam, and
nothing under drivers/net/ethernet/huawei/hinic3/ implements one. The
generic caller of get_pause_stats, pause_prepare_data() in
net/ethtool/pause.c, bails out before it gets to the stats callback:

net/ethtool/pause.c:pause_prepare_data() {
    ...
	if (!dev->ethtool_ops->get_pauseparam)
		return -EOPNOTSUPP;
    ...
	dev->ethtool_ops->get_pauseparam(dev, &data->pauseparam);
	if (req_base->flags & ETHTOOL_FLAG_STATS &&
	    dev->ethtool_ops->get_pause_stats)
		dev->ethtool_ops->get_pause_stats(dev, &data->pausestat);
    ...
}

The only other user, ethtool_aggregate_pause_stats(), is a helper that
MAC-merge-capable drivers call themselves, and hinic3 doesn't call it.
Pause stats also aren't one of the ETHTOOL_MSG_STATS_GET groups.

So "ethtool -I -a <dev>" would fail with -EOPNOTSUPP. That means
mac_tx_pause_pkts and mac_rx_pause_pkts never reach userspace, even though
the commit message lists get_pause_stats as one of the five added
callbacks.

The driver already has hinic3_get_pause_info() in hinic3_nic_cfg.c, which
hinic3_ethtool.c already calls elsewhere. Could that be used to add a
get_pauseparam implementation? Otherwise, could get_pause_stats wait until
one exists?

>  };
>  
>  void hinic3_set_ethtool_ops(struct net_device *netdev)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792378301.git.gongfan1%40huawei.com
