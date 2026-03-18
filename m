Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323A27603A;
	Wed, 18 Mar 2026 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845711; cv=none; b=FpPCZf8CWENtLkC46DCzInMP07ydHiNenqoiWopM6KegNPrsxxwmb+VBNdCVuJcfW4UpZqgB9VqX8cPJHFmfiDNzcDwCp6/5ORoMlmCHtNVp0vzsYvWVWq/71EQGTXZBWn+YY+H/u4s7uaq0cOcdRHfiBZIYgBc3ab56yHafZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845711; c=relaxed/simple;
	bh=8mugyv/lN7wEPvUGMNIdplZjrESfOW5H0tfPJwSEnfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oY9BrLQiJ32U/pOnTYNXm6Q2Ow1JoMqM+aL5bvlWKoyoeC4MVqv6/YXj/HR2YUygvV3oiT6njZAfVvyPs3FMH+WJH9tb9Uaws5qWNlv86/clyWwVSAbRtaweJrKJZkrzXzGbdAWhvkEfECTp60vx5u8RWYTaB1n1s7CH4v2WGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8KXTwlV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8KXTwlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABF7C19421;
	Wed, 18 Mar 2026 14:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845711;
	bh=8mugyv/lN7wEPvUGMNIdplZjrESfOW5H0tfPJwSEnfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8KXTwlV4LuDtskDwXyq8ccRXP/66lSzJQgrNzmUNxBwBJkAe7TGybZzE83d14Gpd
	 e+/f2Xm706jU0Pc7gcyUU+NcfQThRW52iTUpX8wyQRHoUjtld5tCyDG5tyxaZdfOm4
	 CM3C2maXZe3CrQhEzFkj7rkIxwi30i67XMUyxjHYbiT47S29rwzNKaC7gxb1Sxv8Z9
	 uZ3gJtkQN/LxCWtgtxm8DHXaJ4L3XqHse3Wy0vsEG0Ojt2JghJyzbRpYG6Nww2tDfZ
	 dPsSgBVp2sT1WAXMH5h1pZ+TRG7W0+SJ5ZM3+YW46HUUnmapG0F03K31ErITVZu1mE
	 xG8LpnmxkiinA==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	xiaoning.wang@nxp.com,
	vladimir.oltean@nxp.com,
	kuba@kernel.org,
	davem@davemloft.net,
	linuxppc-dev@lists.ozlabs.org,
	krzk+dt@kernel.org,
	frank.li@nxp.com,
	claudiu.manoil@nxp.com,
	chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	imx@lists.linux.dev,
	pabeni@redhat.com,
	f.fainelli@gmail.com,
	linux@armlinux.org.uk,
	edumazet@google.com,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next,13/14] net: dsa: netc: initialize buffer bool table and implement flow-control
Date: Wed, 18 Mar 2026 14:54:52 +0000
Message-ID: <20260318145452.1898637-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316094152.1558671-14-wei.fang@nxp.com>
References: <20260316094152.1558671-14-wei.fang@nxp.com>
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

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: netc: initialize buffer bool table and implement flow-control

The buffer pool is a quantity of memory available for buffering a group
of flows (e.g. frames having the same priority, frames received from the
same port), while waiting to be transmitted on a port. The buffer pool
tracks internal memory consumption with upper bound limits and optionally
a non-shared portion when associated with a shared buffer pool. Currently
the shared buffer pool is not supported, it will be added in the future.

For i.MX94, the switch has 4 ports and 8 buffer pools, so each port is
allocated two buffer pools. For frames with priorities of 0 to 3, they
will be mapped to the first buffer pool; For frames with priorities of
4 to 7, they will be mapped to the second buffer pool. Each buffer pool
has a flow control on threshold and a flow control off threshold. By
setting these threshold, add the flow control support to each port.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index fd952b507cbd..15dd8d89f66d 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -640,6 +651,77 @@ static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
>  				       bcast, NETC_STANDALONE_PVID);
>  }
>
> +static u32 netc_get_buffer_pool_num(struct netc_switch *priv)
> +{
> +	return netc_base_rd(&priv->regs, NETC_BPCAPR) & BPCAPR_NUM_BP;
> +}
> +
> +static void netc_port_set_pbpmcr(struct netc_port *np, u64 mapping)
> +{
> +	u32 pbpmcr0 = lower_32_bits(mapping);
> +	u32 pbpmcr1 = upper_32_bits(mapping);
> +
> +	netc_port_wr(np, NETC_PBPMCR0, pbpmcr0);
> +	netc_port_wr(np, NETC_PBPMCR1, pbpmcr1);
> +}
> +
> +static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
> +{
> +	int num_port_bp = priv->num_bp / priv->info->num_ports;
> +	int q = NETC_IPV_NUM / num_port_bp;
> +	int r = NETC_IPV_NUM % num_port_bp;
> +	int num = q + r;
> +
> +	/* IPV-to–buffer-pool mapping per port:
> +	 * Each port is allocated `num_port_bp` buffer pools and supports 8
> +	 * IPVs, where a higher IPV indicates a higher frame priority. Each
> +	 * IPV can be mapped to only one buffer pool.
> +	 *
> +	 * The mapping rule is as follows:
> +	 * - The first `num` IPVs share the port's first buffer pool (index
> +	 * `base_id`).
> +	 * - After that, every `q` IPVs share one buffer pool, with pool
> +	 * indices increasing sequentially.
> +	 */
> +	for (int i = 0; i < priv->info->num_ports; i++) {
> +		u32 base_id = i * num_port_bp;
> +		u32 bp_id = base_id;
> +		u64 mapping = 0;
> +
> +		for (int ipv = 0; ipv < NETC_IPV_NUM; ipv++) {
> +			/* Update the buffer pool index */
> +			if (ipv >= num)
> +				bp_id = base_id + ((ipv - num) / q) + 1;
> +
> +			mapping |= (u64)bp_id << (ipv * 8);
> +		}
> +
> +		netc_port_set_pbpmcr(priv->ports[i], mapping);
> +	}
> +}
> +
> +static int netc_switch_bpt_default_config(struct netc_switch *priv)
> +{
> +	priv->num_bp = netc_get_buffer_pool_num(priv);
> +	priv->bpt_list = devm_kcalloc(priv->dev, priv->num_bp,
> +				      sizeof(struct bpt_cfge_data),
> +				      GFP_KERNEL);
> +	if (!priv->bpt_list)
> +		return -ENOMEM;
> +
> +	/* Initialize the maximum threshold of each buffer pool entry */
> +	for (int i = 0; i < priv->num_bp; i++) {
> +		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
> +
> +		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
> +		ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
> +	}

Is the return value of ntmp_bpt_update_entry() checked here? Other NTMP
table operations in this driver propagate errors from the update functions.

Looking at ntmp_fdbt_update_entry() usage in netc_port_set_fdb_entry():

drivers/net/dsa/netc/netc_main.c:netc_port_set_fdb_entry() {
	...
	err = ntmp_fdbt_update_entry(&priv->ntmp, fdbt, &hdr);
	if (err)
		return err;
}

And ntmp_vft_add_entry() usage in netc_add_standalone_vlan_entry():

drivers/net/dsa/netc/netc_main.c:netc_add_standalone_vlan_entry() {
	...
	err = ntmp_vft_add_entry(&priv->ntmp, vft);
	if (err)
		return err;
}

If ntmp_bpt_update_entry() fails (for example, DMA allocation failure or
hardware timeout), netc_switch_bpt_default_config() will return success to
netc_setup(). The driver's bpt_list will have threshold values that do not
match the hardware state. Later, netc_port_set_tx_pause() called from
netc_mac_link_up() will read stale bpt_list data and attempt to update based
on incorrect assumptions about hardware configuration.

Should this follow the same error checking pattern as the other NTMP table
operations?

> +
> +	netc_ipv_to_buffer_pool_mapping(priv);
> +
> +	return 0;
> +}

[ ... ]

> @@ -1241,6 +1327,40 @@ static void netc_port_set_hd_flow_control(struct netc_port *np, bool en)
>  			  en ? PM_CMD_CFG_HD_FCEN : 0);
>  }
>
> +static void netc_port_set_tx_pause(struct netc_port *np, bool tx_pause)
> +{
> +	struct netc_switch *priv = np->switch_priv;
> +	int port = np->dp->index;
> +	int i, j, num_bp;
> +
> +	num_bp = priv->num_bp / priv->info->num_ports;
> +	for (i = 0, j = port * num_bp; i < num_bp; i++, j++) {
> +		struct bpt_cfge_data *cfge;
> +
> +		cfge = &priv->bpt_list[j];
> +		if (tx_pause) {
> +			cfge->fc_on_thresh = cpu_to_le16(NETC_FC_THRESH_ON);
> +			cfge->fc_off_thresh = cpu_to_le16(NETC_FC_THRESH_OFF);
> +			cfge->fccfg_sbpen = FIELD_PREP(BPT_FC_CFG,
> +						       BPT_FC_CFG_EN_BPFC);
> +			cfge->fc_ports = cpu_to_le32(BIT(port));
> +		} else {
> +			cfge->fc_on_thresh = cpu_to_le16(0);
> +			cfge->fc_off_thresh = cpu_to_le16(0);
> +			cfge->fccfg_sbpen = 0;
> +			cfge->fc_ports = cpu_to_le32(0);
> +		}
> +
> +		ntmp_bpt_update_entry(&priv->ntmp, j, cfge);
> +	}
> +}

[ ... ]
