Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6434F390D;
	Thu,  1 Oct 2026 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846022; cv=none; b=WslGGMr9EsIf10FCD/Dx6qUFkaZiNjQGV5yAHW4SjbAt8FxJSIilLqwNSiqU9q63TFHIhztrjuAyf6VUoPtiyeATpmDy298aCVraVbcut5sJQ2J6zl8IXozfU9OwuZeahZvfhv2VLzH5TBwnvXG8a7F5dyzBHg813ejwJYvSdGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846022; c=relaxed/simple;
	bh=8DBv/yjKRaZ3K7USU2hbQNQEQe8eXe5l0Z2nM1/TESM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFg83JztyTRhECY72lvG3ucurHFT7SGEZWh34BwNSEbuhlvnTMptOz0rH/8k1rD4ccnnpnrt/6YTcmbL4Sl1b7S7UXcLdDY0iiOP+P9rdR15O3PzavP6NeIB+gw1mFRQG+TRJ4ei3pjPjrvYDIWqiO+N6JwuffddczUzdacsfJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRnYeGCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRnYeGCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE471F0089C;
	Thu,  1 Oct 2026 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846016;
	bh=5AiXA5BsUes4gB3l1heHd7VxwQGpNzubwd12sHXe+Pk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kRnYeGCJgOySEC4LiBWH3hZP+OIQWyi3mWQwu4oEYvn8aGgVqjHihU046+DTaQLAU
	 wlhe+CllZiNG/MZjcnkFzfAiddKiD/vZn02m1uGG6nNPFWk97zO4wVAW7jnunoycMC
	 H2SQ9xhG1nnoSQL/OLPctp5XN5FOLdx8TrzcPz1DCrZI4FyQyit5SS/XmaUQivhys5
	 dpr3L0llGEnqifV+SDsax71BFk88QtaLMGdFSbNCsv7Up/0unNVkk5QcI2VMMZI11J
	 Afs4ygahMvabJAf+cv88fBkrmHSJ6UggVuSVz8pYacIib893vXg5FJOR0/QlghhX/d
	 pBy+zdjNFif/g==
Subject: Re: [net-next, v4 04/10] bnge: add RXFH ethtool support
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Thu, 01 Oct 2026 09:13:35 +0000
Message-ID: <179084601563.434549.7376080309317733874@kernel.org>
In-Reply-To: <20260928061307.1172344-5-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-5-vikas.gupta@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] buffer overflow and memset integer underflow when rx_nr_rings >
  512
- [Medium] bnge_set_rxfh_fields() reports success for data == 0 (disable
  hashing) on every flow type except IPV4_FLOW/IPV6_FLOW, but does not…
- [Medium] In bnge_set_rxfh_fields(), the IPv6 branch of the switch
  handles tuple == 4 differently from the IPv4 branch.
- [Medium] The individual AH_V4_FLOW/ESP_V4_FLOW (and
  AH_V6_FLOW/ESP_V6_FLOW) flow types ignore the SPI-hash bits that…
- [Low] In this commit, bnge_set_rxfh() (bnge_ethtool.c) lets userspace
  store a default-context indirection table in bd->rss_indir_tbl while…
- [Low] bnge_ethtool_ops sets .rxfh_per_ctx_key = 1,
  .rxfh_max_num_contexts = BNGE_MAX_ETH_RSS_CTX + 1 and .rxfh_priv_size…
- [Low] The patch changes how the default RSS key is generated, and the
  commit message does not say so.

--

bnge: add RXFH ethtool support

This commit adds ethtool RXFH operations to bnge for reading and
programming the RSS hash key, indirection table and hash fields. The set
operations are only allowed while the interface is down. It also moves
default RSS key generation to netdev_rss_key_fill() in bnge_netdev_alloc()
and adds an IPv6 flow label RSS capability bit.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> index 2467e44de291a..6fbda4fc1a0c4 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c

[ ... ]

> @@ -740,6 +743,272 @@ static int bnge_set_pauseparam(struct net_device *dev,

[ ... ]

> +static int bnge_get_rxfh_fields(struct net_device *dev,
> +				struct ethtool_rxfh_fields *cmd)
> +{

[ ... ]

> +	case AH_ESP_V4_FLOW:
> +		if (bd->rss_hash_cfg &
> +		    (VNIC_RSS_CFG_REQ_HASH_TYPE_AH_SPI_IPV4 |
> +		     VNIC_RSS_CFG_REQ_HASH_TYPE_ESP_SPI_IPV4))
> +			cmd->data |= RXH_IP_SRC | RXH_IP_DST |
> +				     RXH_L4_B_0_1 | RXH_L4_B_2_3;
> +		cmd->data |= bnge_get_ethtool_ipv4_rss(bd);
> +		break;
> +	case SCTP_V4_FLOW:
> +	case AH_V4_FLOW:
> +	case ESP_V4_FLOW:
> +	case IPV4_FLOW:
> +		cmd->data |= bnge_get_ethtool_ipv4_rss(bd);
> +		break;

[Severity: Medium]
Should AH_V4_FLOW and ESP_V4_FLOW report the SPI bits here too?

When VNIC_RSS_CFG_REQ_HASH_TYPE_AH_SPI_IPV4 and ESP_SPI_IPV4 are set, the
hardware hashes AH/ESP packets on the SPI, and AH_ESP_V4_FLOW reports that
as a 4-tuple. AH_V4_FLOW and ESP_V4_FLOW fall into the generic IPv4 case
instead, and only report RXH_IP_SRC | RXH_IP_DST for the same packets.

The set side splits the same way. In bnge_set_rxfh_fields(), only
AH_ESP_V4_FLOW reaches the branch that clears the SPI bits:

	} else if (cmd->flow_type == AH_ESP_V4_FLOW) {
		...
		rss_hash_cfg &= ~(VNIC_RSS_CFG_REQ_HASH_TYPE_AH_SPI_IPV4 |
				  VNIC_RSS_CFG_REQ_HASH_TYPE_ESP_SPI_IPV4);

As a result, a 2-tuple or zero request for AH_V4_FLOW or ESP_V4_FLOW
returns success while SPI hashing stays on.

The ethtool netlink RSS flow-hash attributes expose ah4/esp4 separately
from ah-esp4. An RSS GET can therefore show ah-esp4 and ah4 disagreeing
about the same packets.

The IPv6 cases (AH_V6_FLOW and ESP_V6_FLOW versus AH_ESP_V6_FLOW) look the
same. bnxt_get_rxfh_fields() and bnxt_set_rxfh_fields() follow the same
pattern.

[ ... ]

> +static int bnge_set_rxfh_fields(struct net_device *dev,
> +				const struct ethtool_rxfh_fields *cmd,
> +				struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	switch (cmd->flow_type) {
> +	case TCP_V4_FLOW:
> +	case UDP_V4_FLOW:
> +	case SCTP_V4_FLOW:
> +	case AH_ESP_V4_FLOW:
> +	case AH_V4_FLOW:
> +	case ESP_V4_FLOW:
> +	case IPV4_FLOW:
> +		if (tuple == 2)
> +			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_IPV4;
> +		else if (!tuple && cmd->flow_type == IPV4_FLOW)
> +			rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV4;
> +		break;

[Severity: Medium]
What happens when data == 0 is requested for a flow type other than
IPV4_FLOW?

With tuple == 0, VNIC_RSS_CFG_REQ_HASH_TYPE_IPV4 is only cleared for
IPV4_FLOW. For SCTP_V4_FLOW, AH_V4_FLOW and ESP_V4_FLOW nothing changes,
so this check further down returns success, even while the interface is
running:

	if (bd->rss_hash_cfg == rss_hash_cfg)
		return 0;

For TCP/UDP/AH_ESP, only the L4 bit is cleared and the IPv4 2-tuple bit
stays set.

bnge_get_rxfh_fields() then reports RXH_IP_SRC | RXH_IP_DST for a flow type
that was just set to 0, and the hardware keeps hashing those packets. The
default rss_hash_cfg includes VNIC_RSS_CFG_REQ_HASH_TYPE_IPV4, so something
like this takes the no-op path:

  ethtool -N ethX rx-flow-hash sctp4 ""

The IPv6 branch has the same restriction on IPV6_FLOW.

bnxt_set_rxfh_fields() clears the L3 bit for any !tuple request, which is
where the two drivers differ. Would it be better to return an error for
zero requests that can't be applied, instead of returning 0?

> +
> +	case TCP_V6_FLOW:
> +	case UDP_V6_FLOW:
> +	case SCTP_V6_FLOW:
> +	case AH_ESP_V6_FLOW:
> +	case AH_V6_FLOW:
> +	case ESP_V6_FLOW:
> +	case IPV6_FLOW:
> +		if (cmd->data & RXH_IP6_FL) {
> +			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL;
> +			rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
> +		} else if (tuple == 2 || tuple == 4) {
> +			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
> +			rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL;

[Severity: Medium]
Is tuple == 4 meant to change the global IPv6 bits here?

On the IPv4 side, a 4-tuple request leaves VNIC_RSS_CFG_REQ_HASH_TYPE_IPV4
alone; only tuple == 2 sets it. Here, a 4-tuple tcp6/udp6/ah-esp6 request
sets VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6 and clears IPV6_FLOW_LABEL.

This sequence turns 2-tuple hashing back on for ip6/sctp6/ah6/esp6:

  ethtool -N ethX rx-flow-hash ip6 ""
  ethtool -N ethX rx-flow-hash tcp6 sdfn

In the same way, a tcp6 sdfn request after ip6 sdl silently turns off flow
label hashing.

RXH_4TUPLE already contains RXH_IP_SRC | RXH_IP_DST, so the TCP_V6_FLOW
readback does not need the IPV6 bit set.

> +		} else if (!tuple && cmd->flow_type == IPV6_FLOW) {

[ ... ]

> +static int bnge_set_rxfh(struct net_device *dev,
> +			 struct ethtool_rxfh_param *rxfh,
> +			 struct netlink_ext_ack *extack)
> +{
> +	struct bnge_net *bn = netdev_priv(dev);
> +
> +	if (rxfh->hfunc && rxfh->hfunc != ETH_RSS_HASH_TOP)
> +		return -EOPNOTSUPP;
> +
> +	if (netif_running(dev)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "RSS configuration can only be changed while the interface is down");
> +		return -EBUSY;
> +	}
> +
> +	bnge_modify_rss(bn, NULL, NULL, rxfh);

[Severity: High]
What limits tbl_size here when bd->rx_nr_rings is large?

bnge_modify_rss() copies bnge_get_rxfh_indir_size(bd) entries into
bd->rss_indir_tbl. That size grows with bd->rx_nr_rings through
bnge_cal_nr_rss_ctxs(). The table itself only holds
bd->rss_indir_tbl_entries entries (BNGE_MAX_RSS_TABLE_ENTRIES, 512):

drivers/net/ethernet/broadcom/bnge/bnge_vnic.c:bnge_modify_rss() {
    ...
		for (i = 0; i < tbl_size; i++)
			indir_tbl[i] = rxfh->indir[i];
		pad = bd->rss_indir_tbl_entries - tbl_size;
		if (pad && !rss_ctx)
			memset(&indir_tbl[i], 0, pad * sizeof(*indir_tbl));
    ...
}

With more than 512 RX rings, tbl_size is larger than the table. The
copy loop then writes past the end of bd->rss_indir_tbl. pad is a u32,
so it wraps around to a value near 4G, and the memset() clears
gigabytes of kernel memory after the table.

The ethtool core sizes rxfh->indir from get_rxfh_indir_size, so the
user buffer is fine. It is the driver table that overflows.
bnge_get_rxfh() has the matching out-of-bounds read, because it
copies tbl_size entries out of bd->rss_indir_tbl.

bnge_fill_hw_rss_tbl() uses the same tbl_size. It writes two __le16
values per entry into vnic->rss_table, which would overrun that DMA
buffer on open. That code predates this patch, but the root cause is
the same.

Does anything in the ring reservation path keep rx_nr_rings at or
below BNGE_MAX_RSS_TABLE_ENTRIES? If not, should the RX ring count be
capped there, or should bnge_get_rxfh_indir_size() be clamped to
bd->rss_indir_tbl_entries?

[Severity: Low]
Does the indirection table stored here survive the next open?

bnge_open_core() calls bnge_reserve_rings(), which still resets the table
without checking netif_is_rxfh_configured():

drivers/net/ethernet/broadcom/bnge/bnge_resc.c:bnge_reserve_rings() {
    ...
	if (old_rx_rings != bd->hw_resc.resv_rx_rings)
		bnge_set_dflt_rss_indir_tbl(bd);
    ...
}

The reserved RX ring count can change while the interface is down. For
example, bnge_is_agg_reqd() can flip after an MTU or LRO/GRO change, or
firmware can grant a different number of RX rings. In that case the user
table is silently overwritten while IFF_RXFH_CONFIGURED stays set.

The next patch in the series, "bnge: add ethtool support to manage RSS
contexts", appears to add a netif_is_rxfh_configured() guard and
ethtool_rxfh_indir_lost() handling here. If so, only this intermediate
commit is affected.

[ ... ]

> @@ -757,6 +1026,18 @@ static const struct ethtool_ops bnge_ethtool_ops = {
>  	.get_eth_ctrl_stats	= bnge_get_eth_ctrl_stats,
>  	.get_pause_stats	= bnge_get_pause_stats,
>  	.get_rmon_stats		= bnge_get_rmon_stats,
> +	/* RXFH */
> +	.rxfh_per_ctx_key	= 1,
> +	.rxfh_max_num_contexts	= BNGE_MAX_ETH_RSS_CTX + 1,
> +	.rxfh_indir_space	= BNGE_MAX_RSS_TABLE_ENTRIES,
> +	.rxfh_priv_size		= sizeof(struct bnge_rss_ctx),

[Severity: Low]
This isn't a bug, but rxfh_per_ctx_key, rxfh_max_num_contexts and
rxfh_priv_size are set here without create_rxfh_context,
modify_rxfh_context or remove_rxfh_context. At this commit the ethtool core
rejects every context request with -EOPNOTSUPP, so these fields and
BNGE_MAX_ETH_RSS_CTX have no effect.

The next patch, "bnge: add ethtool support to manage RSS contexts", adds
the callbacks. Would these fields fit better in that patch?

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index c6b9048586b36..ef5d13337e60b 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -1739,13 +1739,6 @@ static void bnge_init_vnics(struct bnge_net *bn)
>  				u8 *key = (void *)vnic->rss_hash_key;
>  				int k;
>  
> -				if (!bn->rss_hash_key_valid &&
> -				    !bn->rss_hash_key_updated) {
> -					get_random_bytes(bn->rss_hash_key,
> -							 HW_HASH_KEY_SIZE);
> -					bn->rss_hash_key_updated = true;
> -				}
> -
>  				memcpy(vnic->rss_hash_key, bn->rss_hash_key,
>  				       HW_HASH_KEY_SIZE);
>  
> @@ -3398,6 +3391,9 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
>  	bn->tx_ring_size = BNGE_DEFAULT_TX_RING_SIZE;
>  	bn->rx_dir = DMA_FROM_DEVICE;
>  
> +	netdev_rss_key_fill(bn->rss_hash_key, sizeof(bn->rss_hash_key));
> +	bn->rss_hash_key_updated = true;
> +

[Severity: Low]
This isn't a bug, but the commit message doesn't mention this change to
the default RSS key.

netdev_rss_key_fill() copies the global netdev_rss_key, so all bnge ports
now share one key. Before, each port got its own get_random_bytes() key on
first open.

Also, the removed check in bnge_init_vnics() was the only reader of
bn->rss_hash_key_valid. bnge_init_vnics() still sets it:

	bn->rss_hash_key_valid = true;

but nothing tests it any more. Can that field be removed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com
