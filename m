Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F984D9F70;
	Thu,  1 Oct 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846027; cv=none; b=quP2e7/eAUoh6g70Jy0quzo/ROv6aoE7kJukKKM6yG+8kz0Vi5xKqI3Oepe4iEgvJXbCXyunCBVQYEhtLbGvVIeAKD+zS4Ud5ZVR4WhlnpGc3IQWzAnxrXPRBrI5TIyTXyIbD6JIR7pJtjmW1ZY9RbUDEsjGTd1dNEZXYLuFHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846027; c=relaxed/simple;
	bh=r6lLX0WRDeYIMf6digYlzwHG3C7DoxLUfIkPV2KWRlM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLsdBIuR3AUE560B5teUO6J0veUrW+6obYPSQedgLFCuw9VVCJJQ67HwJBWV+B9R2yiaHGUL+i5PC7oaHsl7xDcgwkscgsm2rLOvyO0YKxf7kMIEdldcRMwWlbGjqiE/i3VVBS9xzG6u/YGzY50tIPzujSimpCFyneTfmYjdBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu00ODsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu00ODsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F45A1F00898;
	Thu,  1 Oct 2026 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846022;
	bh=8DJ1dyK0Djl1K6iAKj0C0Zu3pBE9x2y0YsAsFlxuAZQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Iu00ODsliPLL1OTRI/3zBVnLABmbo+p1cFoq0SPljmniMq5jpraah0vd+ovpjDDnu
	 mlM7xFOKu5SudPEOcNJ0Uxw1E+E61CpM5hVBgh/2CcYY7P8924su0O6WV1fShm5uHt
	 yjsxLMbVZQ3Q0eW2CxecfY/Mot446H4dbNV+V8CLAdUyS8PPNhRCOWrT4e+jeSsjNb
	 pmotkYr0rySt5hBqO8MsFha4JOuPzJIXTuKbLicQz1AT9r6WDai87NflBFgKJnCx7Q
	 APaYeDwqJa4YHbElTRLWR80lKovZOTa5haBP7aEVsrKDB+xh9r1S6qZWf4ca6vCQ8N
	 /bB9yoUiD3VCQ==
Subject: Re: [net-next, v4 08/10] bnge: add NTUPLE filter support in ethtool
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Thu, 01 Oct 2026 09:13:41 +0000
Message-ID: <179084602105.434549.5068586938723657056@kernel.org>
In-Reply-To: <20260928061307.1172344-9-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-9-vikas.gupta@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 12 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 8 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Once a user ETHER_FLOW rule exists for MAC M, adding M as a
  secondary unicast address (for example a macvlan on top of the port)…
- [Medium] The patch adds CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_L2
  unconditionally in bnge_hwrm_l2_filter_alloc().
- [Medium] This patch makes user filters exist only while NTUPLE is
  enabled (bnge_set_features calls bnge_clear_usr_fltrs when NTUPLE goes…
- [Medium] When a user L2 (ETHER_FLOW) filter is restored on open, it
  reuses a firmware vNIC id that may no longer be valid.
- [Medium] The rule table size reported to userspace is inconsistent and
  too small for the locations the driver hands out.
- [Medium] bnge_add_l2_cls_rule() accepts ETHER_FLOW rules that ask to
  match on fields it does not implement, then drops those fields without…
- [Medium] User filters are kept in software across close, but the close
  path never frees their firmware entries, and the new open path…
- [Medium] ETHER_FLOW ring rules may land on the wrong queue once the RSS
  indirection table has been changed.
- [Medium] If firmware grants fewer RX rings when the interface is
  reopened, restored filters can steer to a different ring than the one…
- [Low] If the caller's rule_locs buffer is too small,
  ETHTOOL_GRXCLSRLALL silently returns a truncated list as a success.
- [Low] bnge_add_l2_cls_rule() requires m_ext->vlan_tci == htons(0xfff)
  but sets key.vlan = ntohs(h_ext->vlan_tci) without masking to…
- [Low] net: bnge: lost destination ring information for RSS-enabled
  NTUPLE filters

--

bnge: add NTUPLE filter support in ethtool

This commit adds get_rxnfc/set_rxnfc ethtool operations to bnge for
listing, inserting and deleting ETHER_FLOW and ntuple rules. User filters
are restored in bnge_open_core() and cleared when NTUPLE is disabled in
bnge_set_features(). It also adds the TRAFFIC_L2 flag to L2 filter
allocation requests.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> index 85dbe64d4c129..8e9cfbad98e04 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c

[ ... ]

> @@ -1169,6 +1170,594 @@ static int bnge_remove_rxfh_context(struct net_device *dev,

[ ... ]

> +static int bnge_grxclsrlall(struct bnge_net *bn, struct ethtool_rxnfc *cmd,
> +			    u32 *rule_locs)
> +{
> +	u32 count;
> +
> +	cmd->data = bn->user_fltr_count;
> +	rcu_read_lock();
> +	count = bnge_get_all_fltr_ids_rcu(bn, bn->l2_fltr_hash_tbl,
> +					  BNGE_L2_FLTR_HASH_SIZE, rule_locs, 0,
> +					  cmd->rule_cnt, 0);
> +	cmd->rule_cnt = bnge_get_all_fltr_ids_rcu(bn, bn->ntp_fltr_hash_tbl,
> +						  BNGE_NTP_FLTR_HASH_SIZE,
> +						  rule_locs, count,
> +						  cmd->rule_cnt,
> +						  BNGE_MAX_L2_FLTRS);
> +	rcu_read_unlock();
> +
> +	return 0;
> +}

[Severity: Low]
What happens when rule_cnt is smaller than the number of installed rules?
bnge_get_all_fltr_ids_rcu() stops once id_cnt entries have been copied and
doesn't check whether more remain. bnge_grxclsrlall() then always returns 0.

The get_rxnfc documentation in include/linux/ethtool.h says drivers must
return -EMSGSIZE when rule_cnt is too small. With two rules installed and
rule_cnt = 1, userspace would get one rule and no error. The same thing can
happen if rules are added between ETHTOOL_GRXCLSRLCNT and
ETHTOOL_GRXCLSRLALL.

[ ... ]

> +static int bnge_add_l2_cls_rule(struct bnge_net *bn,
> +				struct ethtool_rx_flow_spec *fs)
> +{

[ ... ]

> +	if (!is_broadcast_ether_addr(m_ether->h_dest))
> +		return -EINVAL;
> +
> +	if (is_broadcast_ether_addr(h_ether->h_dest) ||
> +	    is_multicast_ether_addr(h_ether->h_dest))
> +		return -EINVAL;
> +
> +	ether_addr_copy(key.dst_mac_addr, h_ether->h_dest);
> +	key.vlan = 0;

[Severity: Medium]
Should this also reject masks for fields the filter doesn't implement?
Only the dst MAC mask and the VLAN TCI mask are checked, and only dst MAC
and VLAN are copied into key.

Non-zero masks in m_u.ether_spec.h_source and m_u.ether_spec.h_proto are
silently dropped. The same goes for m_ext.vlan_etype and m_ext.data when
FLOW_EXT is set. ethtool_set_rxnfc() in net/ethtool/ioctl.c doesn't check
these masks either.

For example, 'flow-type ether dst M src S proto 0x0800 action 3' would be
installed as a dst-only rule. It would then steer traffic that doesn't
match the requested source or EtherType.

> +	if (fs->flow_type & FLOW_EXT) {
> +		struct ethtool_flow_ext *m_ext = &fs->m_ext;
> +		struct ethtool_flow_ext *h_ext = &fs->h_ext;
> +
> +		if (m_ext->vlan_tci != htons(0xfff) || !h_ext->vlan_tci)
> +			return -EINVAL;
> +		key.vlan = ntohs(h_ext->vlan_tci);
> +	}

[Severity: Low]
The mask has to be htons(0xfff), but key.vlan isn't masked with
VLAN_VID_MASK. Can PCP/DEI bits end up in the software key and in
req->l2_ivlan, while l2_ivlan_mask is 0xfff?

bnge_lookup_l2_filter() compares the full vlan. So two rules with the same
VID but different PCP would pass the duplicate check and create duplicate
hardware filters.

A priority-tagged TCI such as 0x2000 would also pass the !h_ext->vlan_tci
check and install a num_vlans = 1 filter on VID 0.

> +
> +	flags = BNGE_ACT_RING_DST;
> +	vnic_id = bn->vnic_info[BNGE_VNIC_DEFAULT].fw_vnic_id;

[Severity: Medium]
Do ETHER_FLOW ring rules still reach the requested ring after the RSS
indirection table has been changed?

With BNGE_ACT_RING_DST set, bnge_hwrm_l2_filter_alloc() programs dst_id as
the default vNIC and uses rxq as the ring table index:

	if (BNGE_L2_FLTR_IS_NTP_MAC(fltr)) {
		req->enables |= cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_ENABLES_RFS_RING_TBL_IDX);
		req->rfs_ring_tbl_idx = cpu_to_le16(fltr->base.rxq);
	}

The ntuple path in bnge_cfg_rfs_ring_tbl_idx() uses BNGE_VNIC_NTUPLE
instead. bnge_fill_hw_rss_tbl() gives only that vNIC an identity table, via
ethtool_rxfh_indir_default(). The default vNIC's table comes from
bd->rss_indir_tbl.

After 'ethtool -X', wouldn't matching packets go to rss_indir_tbl[ring]
while bnge_grxclsrule() still reports the requested ring?

For comparison, bnxt doesn't use RFS_RING_TBL_IDX on L2 filters and refuses
ETHER_FLOW ring rules on P5+ chips.

> +
> +	fltr = bnge_alloc_user_l2_filter(bn, &key, flags);
> +	if (IS_ERR(fltr))
> +		return PTR_ERR(fltr);

[Severity: High]
Can a user ETHER_FLOW rule for MAC M break RX filtering once M is also
added as a secondary unicast address, for example by a macvlan on top of
the port?

User L2 rules now go into the same l2_fltr_hash_tbl as the vNIC unicast
filters. bnge_alloc_l2_filter() returns ERR_PTR(-EEXIST) when the
{mac, vlan} key is already there. bnge_cfg_rx_mode() only skips uc entries
equal to dev_addr, so M reaches bnge_hwrm_set_vnic_filter():

bnge_set_rx_mode()
  bnge_cfg_rx_mode()
    bnge_hwrm_set_vnic_filter()
      bnge_alloc_l2_filter()      -> -EEXIST
    vnic->uc_filter_count = i;
    return rc;

This returns before the skip_uc label, so bnge_hwrm_cfa_l2_set_rx_mask()
never runs and the bcast/mcast/promisc mask updates are lost.

User L2 filters also survive close. bnge_hwrm_clear_vnic_filter() only
frees vnic->l2_filters[], and bnge_free_l2_filters() is only called from
bnge_netdev_free(). On the next open:

bnge_init_chip()
  bnge_cfg_rx_mode()              -> -EEXIST
  else if (rc)
      goto err_out;

Wouldn't the interface then fail to open until the ethtool rule is deleted?
In that case bnge_cfg_usr_fltrs() is never reached either.

Before this patch only vNIC unicast filters could be in the L2 hash, so
this collision couldn't happen.

[ ... ]

> +static int bnge_srxclsrldel(struct bnge_net *bn, struct ethtool_rxnfc *cmd)
> +{

[ ... ]

> +	if (fltr_base) {
> +		struct bnge_l2_filter *l2_fltr;
> +
> +		l2_fltr = container_of(fltr_base, struct bnge_l2_filter, base);
> +		rcu_read_unlock();
> +		bnge_hwrm_l2_filter_free(bn->bd, l2_fltr);
> +		bnge_del_l2_filter_rcu(bn, l2_fltr);
> +		return 0;
> +	}

[Severity: Medium]
Are the firmware entries for user filters ever freed across close/open?
User filters stay in software over close, but the close path doesn't free
them in firmware:

- bnge_hwrm_clear_vnic_filter() only frees vnic->l2_filters[]
- bnge_free_core() -> bnge_free_ntp_fltrs(bn, true) skips user filters and
  issues no HWRM call
- on open, bnge_cfg_usr_fltrs() allocates every user filter in firmware
  again and overwrites base.filter_id

If firmware doesn't free these implicitly, each close/open cycle leaks the
previous entries. bnge_clear_usr_fltrs() has the same problem when NTUPLE
is turned off. That can only happen while the interface is down, because
fix_features blocks the change while it is running.

If firmware does free them with the vNIC, then deleting an L2 rule here
while the interface is down sends HWRM_CFA_L2_FILTER_FREE with the
filter_id from the previous up cycle. Unlike the ntuple free helper,
bnge_hwrm_l2_filter_free() has no BNGE_STATE_OPEN check.

Could that command fail, or free an unrelated filter if the id has been
reused?

[ ... ]

> +	switch (cmd->cmd) {
> +	case ETHTOOL_GRXCLSRLCNT:
> +		cmd->rule_cnt = bn->user_fltr_count;
> +		cmd->data = bd->max_fltr | RX_CLS_LOC_SPECIAL;
> +		break;

[Severity: Medium]
Is this the right rule table size? bd->max_fltr is BNGE_MAX_NTUPLE_FLTRS
and doesn't include the L2 range. Ntuple rules, however, are returned at:

	fs->location = BNGE_MAX_L2_FLTRS + new_fltr->base.sw_id;

bnge_grxclsrule() also accepts locations up to
BNGE_MAX_L2_FLTRS + bd->max_fltr. So valid locations can go past the
advertised size.

bnge_grxclsrlall() reports a rule count instead of the table size:

	cmd->data = bn->user_fltr_count;

So a single ntuple rule at location 128 gives @data = 1.

include/uapi/linux/ethtool.h defines @data as the size of the rule table
for both ETHTOOL_GRXCLSRLCNT and ETHTOOL_GRXCLSRLALL. bnxt avoids the first
mismatch because its max_fltr includes BNXT_L2_FLTR_MAX_FLTR.

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> index 7fbb67021b5d9..764c967c64572 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> @@ -577,3 +577,63 @@ int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,

[ ... ]

> +	if (fltr->type == BNGE_FLTR_TYPE_NTUPLE) {
> +		ntp_fltr = container_of(fltr, struct bnge_ntuple_filter, base);
> +		l2_fltr = bn->vnic_info[BNGE_VNIC_DEFAULT].l2_filters[0];
> +		ntp_fltr->l2_filter_id = l2_fltr->base.filter_id;
> +		if (bnge_hwrm_cfa_ntuple_filter_alloc(bn->bd, ntp_fltr)) {

[Severity: Medium]
Can the saved base.rxq be out of range here? On open,
bnge_reserve_rings() can lower bd->rx_nr_rings and log "RX rings resv
reduced". It handles the RSS indirection table through
ethtool_rxfh_indir_lost(), but it doesn't touch ring-steering filters.

This path reprograms each filter with its old rxq and doesn't check it
against the new rx_nr_rings. The NTUPLE vNIC's ring table is
ethtool_rxfh_indir_default(i, rx_nr_rings).

Wouldn't an rxq at or above the new count then resolve to
rxq % rx_nr_rings, while get_rxnfc still reports the old ring?

> +			netdev_err(bn->netdev,
> +				   "restoring previously configured ntuple filter id %d failed\n",
> +				   fltr->sw_id);
> +			bnge_del_ntp_filter_rcu(bn, ntp_fltr);
> +		}
> +	} else if (fltr->type == BNGE_FLTR_TYPE_L2) {
> +		l2_fltr = container_of(fltr, struct bnge_l2_filter, base);
> +		if (bnge_hwrm_l2_filter_alloc(bn->bd, l2_fltr)) {

[Severity: Medium]
Is fltr->base.fw_vnic_id still valid at this point? bnge_add_l2_cls_rule()
saved the default vNIC's firmware id when the rule was added:

	vnic_id = bn->vnic_info[BNGE_VNIC_DEFAULT].fw_vnic_id;
	...
	fltr->base.fw_vnic_id = vnic_id;

bnge_clear_vnic() frees that vNIC on close, and on open
bnge_hwrm_vnic_alloc() gets a new id from firmware (resp->vnic_id). This
branch doesn't refresh fw_vnic_id, so req->dst_id still carries the old id.

The ntuple branch above does refresh its per-open handle (l2_filter_id).

If firmware hands out a different vNIC id, wouldn't the restored rule point
at a stale vNIC? Or, if firmware rejects the id, the rule would be removed
by bnge_del_l2_filter_rcu() with only a log message.

[ ... ]

> +void bnge_cfg_usr_fltrs(struct bnge_net *bn)
> +{
> +	struct bnge_filter_base *usr_fltr, *tmp;
> +
> +	list_for_each_entry_safe(usr_fltr, tmp, &bn->usr_fltr_list, list_node)
> +		bnge_cfg_one_usr_fltr(bn, usr_fltr);
> +}

[Severity: Medium]
Should this check BNGE_NET_EN_NTUPLE before reprogramming filters?

User filters are cleared when NTUPLE is turned off through
bnge_set_features(). However, bnge_init_chip() can also turn it off when
bnge_alloc_rfs_vnic() fails during open, and it doesn't clear user filters:

	bd->flags &= ~BNGE_EN_ARFS_CAP;
	bn->priv_flags &= ~BNGE_NET_EN_NTUPLE;
	bn->netdev->features &= ~NETIF_F_NTUPLE;

bnge_open_core() then calls bnge_cfg_usr_fltrs(), which restores every
saved filter. DROP and L2 filters stay active. Non-RSS ntuple filters get
dst_id = vnic_info[BNGE_VNIC_NTUPLE].fw_vnic_id from
bnge_cfg_rfs_ring_tbl_idx(), and that is the vNIC that just failed.

A later 'ethtool -K ntuple off' would also do nothing. bnge_set_features()
returns early when flags == priv_flags, so bnge_clear_usr_fltrs() never
runs.

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> index 3eb67379c1a57..473d1aec80f38 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> @@ -906,15 +906,17 @@ int bnge_hwrm_l2_filter_alloc(struct bnge_dev *bd, struct bnge_l2_filter *fltr)

[ ... ]

> -	req->flags = cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX);
> -
> -	req->flags |= cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST);
> +	flags = CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX |
> +		CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_L2 |
> +		CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST;
> +	req->flags = cpu_to_le32(flags);

[Severity: Medium]
CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_L2 is now set for every L2 filter.
That includes the default vNIC MAC filters that bnge_hwrm_set_vnic_filter()
installs on every open.

The traffic field used to be 0 (TRAFFIC_NO_ROCE_L2), and bnxt doesn't set
this flag. Is this change intended, and could it affect RoCE/L2 steering
for the aux RoCE driver?

The commit message doesn't mention this change. It also doesn't mention
that user filters are now restored on open (bnge_cfg_usr_fltrs()) and
flushed when NTUPLE is disabled (bnge_clear_usr_fltrs()).

The commit message says:

  Since with ethtool support user filters creation is supported, when
  interface is down clearing of filters which are in software remains
  intact.

Isn't this already the existing behaviour? bnge_free_core() already calls
bnge_free_ntp_fltrs(bn, true) under the comment "Free non-user filters
only", and this patch doesn't change that.

[ ... ]

> @@ -1169,6 +1170,594 @@ static int bnge_remove_rxfh_context(struct net_device *dev,
>  	return 0;
>  }
>  
> +#define BNGE_IP_PROTO_FULL_MASK	0xFF
> +#define BNGE_IP_PROTO_WILDCARD	0x0
> +
> +static u32 bnge_get_all_fltr_ids_rcu(struct bnge_net *bn,
> +				     struct hlist_head tbl[],
> +				     u32 tbl_size, u32 *ids, u32 start,
> +				     u32 id_cnt, u32 offset)
> +{
> +	u32 i, j = start;
> +
> +	if (j >= id_cnt)
> +		return j;
> +
> +	for (i = 0; i < tbl_size; i++) {
> +		struct bnge_filter_base *fltr;
> +		struct hlist_head *head;
> +
> +		head = &tbl[i];
> +		hlist_for_each_entry_rcu(fltr, head, hlist) {
> +			if (!fltr->flags ||
> +			    test_bit(BNGE_FLTR_FW_DELETED, &fltr->state))
> +				continue;
> +			ids[j++] = fltr->sw_id + offset;
> +			if (j == id_cnt)
> +				return j;
> +		}
> +	}
> +	return j;
> +}
> +
> +static struct bnge_filter_base *bnge_get_one_fltr_rcu(struct bnge_net *bn,
> +						      struct hlist_head tbl[],
> +						      u32 tbl_size, u32 id,
> +						      u32 offset)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < tbl_size; i++) {
> +		struct bnge_filter_base *fltr;
> +		struct hlist_head *head;
> +
> +		head = &tbl[i];
> +		hlist_for_each_entry_rcu(fltr, head, hlist) {
> +			if (fltr->flags && fltr->sw_id + offset == id)
> +				return fltr;
> +		}
> +	}
> +	return NULL;
> +}
> +
> +static int bnge_grxclsrlall(struct bnge_net *bn, struct ethtool_rxnfc *cmd,
> +			    u32 *rule_locs)
> +{
> +	u32 count;
> +
> +	cmd->data = bn->user_fltr_count;
> +	rcu_read_lock();
> +	count = bnge_get_all_fltr_ids_rcu(bn, bn->l2_fltr_hash_tbl,
> +					  BNGE_L2_FLTR_HASH_SIZE, rule_locs, 0,
> +					  cmd->rule_cnt, 0);
> +	cmd->rule_cnt = bnge_get_all_fltr_ids_rcu(bn, bn->ntp_fltr_hash_tbl,
> +						  BNGE_NTP_FLTR_HASH_SIZE,
> +						  rule_locs, count,
> +						  cmd->rule_cnt,
> +						  BNGE_MAX_L2_FLTRS);
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +
> +static int bnge_grxclsrule(struct bnge_net *bn, struct ethtool_rxnfc *cmd)
> +{
> +	struct ethtool_rx_flow_spec *fs =
> +		(struct ethtool_rx_flow_spec *)&cmd->fs;
> +	struct bnge_filter_base *fltr_base;
> +	struct bnge_ntuple_filter *fltr;
> +	struct bnge_flow_masks *fmasks;
> +	struct bnge_dev *bd = bn->bd;
> +	struct flow_keys *fkeys;
> +	int rc = -EINVAL;
> +
> +	if (fs->location >= BNGE_MAX_L2_FLTRS + bd->max_fltr)
> +		return rc;
> +
> +	rcu_read_lock();
> +	fltr_base = bnge_get_one_fltr_rcu(bn, bn->l2_fltr_hash_tbl,
> +					  BNGE_L2_FLTR_HASH_SIZE,
> +					  fs->location, 0);
> +	if (fltr_base) {
> +		struct ethhdr *h_ether = &fs->h_u.ether_spec;
> +		struct ethhdr *m_ether = &fs->m_u.ether_spec;
> +		struct bnge_l2_filter *l2_fltr;
> +		struct bnge_l2_key *l2_key;
> +
> +		l2_fltr = container_of(fltr_base, struct bnge_l2_filter, base);
> +		l2_key = &l2_fltr->l2_key;
> +		fs->flow_type = ETHER_FLOW;
> +		ether_addr_copy(h_ether->h_dest, l2_key->dst_mac_addr);
> +		eth_broadcast_addr(m_ether->h_dest);
> +		if (l2_key->vlan) {
> +			struct ethtool_flow_ext *m_ext = &fs->m_ext;
> +			struct ethtool_flow_ext *h_ext = &fs->h_ext;
> +
> +			fs->flow_type |= FLOW_EXT;
> +			m_ext->vlan_tci = htons(0xfff);
> +			h_ext->vlan_tci = htons(l2_key->vlan);
> +		}
> +		if (fltr_base->flags & BNGE_ACT_RING_DST)
> +			fs->ring_cookie = fltr_base->rxq;
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +	fltr_base = bnge_get_one_fltr_rcu(bn, bn->ntp_fltr_hash_tbl,
> +					  BNGE_NTP_FLTR_HASH_SIZE,
> +					  fs->location, BNGE_MAX_L2_FLTRS);
> +	if (!fltr_base) {
> +		rcu_read_unlock();
> +		return rc;
> +	}
> +	fltr = container_of(fltr_base, struct bnge_ntuple_filter, base);
> +
> +	fkeys = &fltr->fkeys;
> +	fmasks = &fltr->fmasks;
> +	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
> +		if (fkeys->basic.ip_proto == BNGE_IP_PROTO_WILDCARD) {
> +			fs->flow_type = IP_USER_FLOW;
> +			fs->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
> +			fs->h_u.usr_ip4_spec.proto = BNGE_IP_PROTO_WILDCARD;
> +			fs->m_u.usr_ip4_spec.proto = 0;
> +		} else if (fkeys->basic.ip_proto == IPPROTO_ICMP) {
> +			fs->flow_type = IP_USER_FLOW;
> +			fs->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
> +			fs->h_u.usr_ip4_spec.proto = IPPROTO_ICMP;
> +			fs->m_u.usr_ip4_spec.proto = BNGE_IP_PROTO_FULL_MASK;
> +		} else if (fkeys->basic.ip_proto == IPPROTO_TCP) {
> +			fs->flow_type = TCP_V4_FLOW;
> +		} else if (fkeys->basic.ip_proto == IPPROTO_UDP) {
> +			fs->flow_type = UDP_V4_FLOW;
> +		} else {
> +			goto fltr_err;
> +		}
> +
> +		fs->h_u.tcp_ip4_spec.ip4src = fkeys->addrs.v4addrs.src;
> +		fs->m_u.tcp_ip4_spec.ip4src = fmasks->addrs.v4addrs.src;
> +		fs->h_u.tcp_ip4_spec.ip4dst = fkeys->addrs.v4addrs.dst;
> +		fs->m_u.tcp_ip4_spec.ip4dst = fmasks->addrs.v4addrs.dst;
> +		if (fs->flow_type == TCP_V4_FLOW ||
> +		    fs->flow_type == UDP_V4_FLOW) {
> +			fs->h_u.tcp_ip4_spec.psrc = fkeys->ports.src;
> +			fs->m_u.tcp_ip4_spec.psrc = fmasks->ports.src;
> +			fs->h_u.tcp_ip4_spec.pdst = fkeys->ports.dst;
> +			fs->m_u.tcp_ip4_spec.pdst = fmasks->ports.dst;
> +		}
> +	} else {
> +		if (fkeys->basic.ip_proto == BNGE_IP_PROTO_WILDCARD) {
> +			fs->flow_type = IPV6_USER_FLOW;
> +			fs->h_u.usr_ip6_spec.l4_proto =
> +				BNGE_IP_PROTO_WILDCARD;
> +			fs->m_u.usr_ip6_spec.l4_proto = 0;
> +		} else if (fkeys->basic.ip_proto == IPPROTO_ICMPV6) {
> +			fs->flow_type = IPV6_USER_FLOW;
> +			fs->h_u.usr_ip6_spec.l4_proto = IPPROTO_ICMPV6;
> +			fs->m_u.usr_ip6_spec.l4_proto =
> +				BNGE_IP_PROTO_FULL_MASK;
> +		} else if (fkeys->basic.ip_proto == IPPROTO_TCP) {
> +			fs->flow_type = TCP_V6_FLOW;
> +		} else if (fkeys->basic.ip_proto == IPPROTO_UDP) {
> +			fs->flow_type = UDP_V6_FLOW;
> +		} else {
> +			goto fltr_err;
> +		}
> +
> +		memcpy(fs->h_u.tcp_ip6_spec.ip6src,
> +		       &fkeys->addrs.v6addrs.src,
> +		       sizeof(struct in6_addr));
> +		memcpy(fs->m_u.tcp_ip6_spec.ip6src,
> +		       &fmasks->addrs.v6addrs.src,
> +		       sizeof(struct in6_addr));
> +		memcpy(fs->h_u.tcp_ip6_spec.ip6dst,
> +		       &fkeys->addrs.v6addrs.dst,
> +		       sizeof(struct in6_addr));
> +		memcpy(fs->m_u.tcp_ip6_spec.ip6dst,
> +		       &fmasks->addrs.v6addrs.dst,
> +		       sizeof(struct in6_addr));
> +
> +		if (fs->flow_type == TCP_V6_FLOW ||
> +		    fs->flow_type == UDP_V6_FLOW) {
> +			fs->h_u.tcp_ip6_spec.psrc = fkeys->ports.src;
> +			fs->m_u.tcp_ip6_spec.psrc = fmasks->ports.src;
> +			fs->h_u.tcp_ip6_spec.pdst = fkeys->ports.dst;
> +			fs->m_u.tcp_ip6_spec.pdst = fmasks->ports.dst;
> +		}
> +	}
> +
> +	if (fltr->base.flags & BNGE_ACT_DROP) {
> +		fs->ring_cookie = RX_CLS_FLOW_DISC;
> +	} else if (fltr->base.flags & BNGE_ACT_RSS_CTX) {
> +		fs->flow_type |= FLOW_RSS;
> +		cmd->rss_context = fltr->base.fw_vnic_id;
> +	} else {
> +		fs->ring_cookie = fltr->base.rxq;
> +	}
> +	rc = 0;
> +
> +fltr_err:
> +	rcu_read_unlock();
> +
> +	return rc;
> +}
> +
> +static bool bnge_verify_ntuple_ip4_flow(struct ethtool_usrip4_spec *ip_spec,
> +					struct ethtool_usrip4_spec *ip_mask)
> +{
> +	u8 mproto = ip_mask->proto;
> +	u8 sproto = ip_spec->proto;
> +
> +	if (ip_mask->l4_4_bytes || ip_mask->tos ||
> +	    ip_spec->ip_ver != ETH_RX_NFC_IP4 ||
> +	    (mproto && (mproto != BNGE_IP_PROTO_FULL_MASK ||
> +			sproto != IPPROTO_ICMP)))
> +		return false;
> +	return true;
> +}
> +
> +static bool bnge_verify_ntuple_ip6_flow(struct ethtool_usrip6_spec *ip_spec,
> +					struct ethtool_usrip6_spec *ip_mask)
> +{
> +	u8 mproto = ip_mask->l4_proto;
> +	u8 sproto = ip_spec->l4_proto;
> +
> +	if (ip_mask->l4_4_bytes || ip_mask->tclass ||
> +	    (mproto && (mproto != BNGE_IP_PROTO_FULL_MASK ||
> +			sproto != IPPROTO_ICMPV6)))
> +		return false;
> +	return true;
> +}
> +
> +static int bnge_add_ntuple_cls_rule(struct bnge_net *bn,
> +				    struct ethtool_rxnfc *cmd)
> +{
> +	struct ethtool_rx_flow_spec *fs = &cmd->fs;
> +	struct bnge_ntuple_filter *new_fltr, *fltr;
> +	u32 flow_type = fs->flow_type & 0xff;
> +	struct bnge_l2_filter *l2_fltr;
> +	struct bnge_flow_masks *fmasks;
> +	struct flow_keys *fkeys;
> +	u32 idx;
> +	int rc;
> +
> +	if (!bn->vnic_info)
> +		return -EAGAIN;
> +
> +	if (fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT))
> +		return -EOPNOTSUPP;
> +
> +	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
> +	    ethtool_get_flow_spec_ring_vf(fs->ring_cookie))
> +		return -EOPNOTSUPP;
> +
> +	if (flow_type == IP_USER_FLOW) {
> +		if (!bnge_verify_ntuple_ip4_flow(&fs->h_u.usr_ip4_spec,
> +						 &fs->m_u.usr_ip4_spec))
> +			return -EOPNOTSUPP;
> +	}
> +
> +	if (flow_type == IPV6_USER_FLOW) {
> +		if (!bnge_verify_ntuple_ip6_flow(&fs->h_u.usr_ip6_spec,
> +						 &fs->m_u.usr_ip6_spec))
> +			return -EOPNOTSUPP;
> +	}
> +
> +	new_fltr = kzalloc_obj(*new_fltr, GFP_KERNEL);
> +	if (!new_fltr)
> +		return -ENOMEM;
> +
> +	l2_fltr = bn->vnic_info[BNGE_VNIC_DEFAULT].l2_filters[0];
> +	new_fltr->l2_filter_id = l2_fltr->base.filter_id;
> +	fmasks = &new_fltr->fmasks;
> +	fkeys = &new_fltr->fkeys;
> +
> +	rc = -EOPNOTSUPP;
> +	switch (flow_type) {
> +	case IP_USER_FLOW: {
> +		struct ethtool_usrip4_spec *ip_spec = &fs->h_u.usr_ip4_spec;
> +		struct ethtool_usrip4_spec *ip_mask = &fs->m_u.usr_ip4_spec;
> +
> +		fkeys->basic.ip_proto = ip_mask->proto ? ip_spec->proto
> +						       : BNGE_IP_PROTO_WILDCARD;
> +		fkeys->basic.n_proto = htons(ETH_P_IP);
> +		fkeys->addrs.v4addrs.src = ip_spec->ip4src;
> +		fmasks->addrs.v4addrs.src = ip_mask->ip4src;
> +		fkeys->addrs.v4addrs.dst = ip_spec->ip4dst;
> +		fmasks->addrs.v4addrs.dst = ip_mask->ip4dst;
> +		break;
> +	}
> +	case TCP_V4_FLOW:
> +	case UDP_V4_FLOW: {
> +		struct ethtool_tcpip4_spec *ip_spec = &fs->h_u.tcp_ip4_spec;
> +		struct ethtool_tcpip4_spec *ip_mask = &fs->m_u.tcp_ip4_spec;
> +
> +		if (ip_mask->tos)
> +			goto err_free_fltr;
> +
> +		fkeys->basic.ip_proto = IPPROTO_TCP;
> +		if (flow_type == UDP_V4_FLOW)
> +			fkeys->basic.ip_proto = IPPROTO_UDP;
> +		fkeys->basic.n_proto = htons(ETH_P_IP);
> +		fkeys->addrs.v4addrs.src = ip_spec->ip4src;
> +		fmasks->addrs.v4addrs.src = ip_mask->ip4src;
> +		fkeys->addrs.v4addrs.dst = ip_spec->ip4dst;
> +		fmasks->addrs.v4addrs.dst = ip_mask->ip4dst;
> +		fkeys->ports.src = ip_spec->psrc;
> +		fmasks->ports.src = ip_mask->psrc;
> +		fkeys->ports.dst = ip_spec->pdst;
> +		fmasks->ports.dst = ip_mask->pdst;
> +		break;
> +	}
> +	case IPV6_USER_FLOW: {
> +		struct ethtool_usrip6_spec *ip_spec = &fs->h_u.usr_ip6_spec;
> +		struct ethtool_usrip6_spec *ip_mask = &fs->m_u.usr_ip6_spec;
> +
> +		fkeys->basic.ip_proto = ip_mask->l4_proto ? ip_spec->l4_proto
> +					: BNGE_IP_PROTO_WILDCARD;
> +		fkeys->basic.n_proto = htons(ETH_P_IPV6);
> +
> +		memcpy(&fkeys->addrs.v6addrs.src, ip_spec->ip6src,
> +		       sizeof(struct in6_addr));
> +		memcpy(&fmasks->addrs.v6addrs.src, ip_mask->ip6src,
> +		       sizeof(struct in6_addr));
> +		memcpy(&fkeys->addrs.v6addrs.dst, ip_spec->ip6dst,
> +		       sizeof(struct in6_addr));
> +		memcpy(&fmasks->addrs.v6addrs.dst, ip_mask->ip6dst,
> +		       sizeof(struct in6_addr));
> +		break;
> +	}
> +	case TCP_V6_FLOW:
> +	case UDP_V6_FLOW: {
> +		struct ethtool_tcpip6_spec *ip_spec = &fs->h_u.tcp_ip6_spec;
> +		struct ethtool_tcpip6_spec *ip_mask = &fs->m_u.tcp_ip6_spec;
> +
> +		if (ip_mask->tclass)
> +			goto err_free_fltr;
> +
> +		fkeys->basic.ip_proto = IPPROTO_TCP;
> +		if (flow_type == UDP_V6_FLOW)
> +			fkeys->basic.ip_proto = IPPROTO_UDP;
> +		fkeys->basic.n_proto = htons(ETH_P_IPV6);
> +
> +		memcpy(&fkeys->addrs.v6addrs.src, ip_spec->ip6src,
> +		       sizeof(struct in6_addr));
> +		memcpy(&fmasks->addrs.v6addrs.src, ip_mask->ip6src,
> +		       sizeof(struct in6_addr));
> +		memcpy(&fkeys->addrs.v6addrs.dst, ip_spec->ip6dst,
> +		       sizeof(struct in6_addr));
> +		memcpy(&fmasks->addrs.v6addrs.dst, ip_mask->ip6dst,
> +		       sizeof(struct in6_addr));
> +
> +		fkeys->ports.src = ip_spec->psrc;
> +		fmasks->ports.src = ip_mask->psrc;
> +		fkeys->ports.dst = ip_spec->pdst;
> +		fmasks->ports.dst = ip_mask->pdst;
> +		break;
> +	}
> +	default:
> +		rc = -EOPNOTSUPP;
> +		goto err_free_fltr;
> +	}
> +	if (!memcmp(&BNGE_FLOW_MASK_NONE, fmasks, sizeof(*fmasks)))
> +		goto err_free_fltr;
> +
> +	idx = bnge_get_ntp_filter_idx(bn, fkeys, NULL);
> +	rcu_read_lock();
> +	fltr = bnge_lookup_ntp_filter_from_idx(bn, new_fltr, idx);
> +	if (fltr) {
> +		rcu_read_unlock();
> +		rc = -EEXIST;
> +		goto err_free_fltr;
> +	}
> +	rcu_read_unlock();
> +
> +	new_fltr->base.flags = BNGE_ACT_NO_AGING;
> +	if (fs->flow_type & FLOW_RSS) {
> +		struct bnge_rss_ctx *rss_ctx;
> +
> +		new_fltr->base.fw_vnic_id = 0;
> +		new_fltr->base.flags |= BNGE_ACT_RSS_CTX;
> +		rss_ctx = bnge_get_rss_ctx_from_index(bn, cmd->rss_context);
> +		if (rss_ctx) {
> +			new_fltr->base.fw_vnic_id = rss_ctx->index;
> +		} else {
> +			rc = -EINVAL;
> +			goto err_free_fltr;
> +		}
> +	}
> +	if (fs->ring_cookie == RX_CLS_FLOW_DISC)
> +		new_fltr->base.flags |= BNGE_ACT_DROP;
> +	else
> +		new_fltr->base.rxq = ethtool_get_flow_spec_ring(fs->ring_cookie);
> +	__set_bit(BNGE_FLTR_VALID, &new_fltr->base.state);
> +	rc = bnge_insert_ntp_filter(bn, new_fltr, idx);
> +	if (!rc) {
> +		rc = bnge_hwrm_cfa_ntuple_filter_alloc(bn->bd, new_fltr);
> +		if (rc) {
> +			bnge_del_ntp_filter_rcu(bn, new_fltr);
> +			return rc;
> +		}
> +		fs->location = BNGE_MAX_L2_FLTRS + new_fltr->base.sw_id;
> +		return 0;
> +	}
> +
> +err_free_fltr:
> +	kfree(new_fltr);
> +	return rc;
> +}
> +
> +static int bnge_add_l2_cls_rule(struct bnge_net *bn,
> +				struct ethtool_rx_flow_spec *fs)
> +{
> +	u32 ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
> +	struct ethhdr *h_ether = &fs->h_u.ether_spec;
> +	struct ethhdr *m_ether = &fs->m_u.ether_spec;
> +	struct bnge_l2_filter *fltr;
> +	struct bnge_l2_key key;
> +	u16 vnic_id;
> +	u8 flags;
> +	int rc;
> +
> +	if (ethtool_get_flow_spec_ring_vf(fs->ring_cookie))
> +		return -EOPNOTSUPP;
> +
> +	if (!is_broadcast_ether_addr(m_ether->h_dest))
> +		return -EINVAL;
> +
> +	if (is_broadcast_ether_addr(h_ether->h_dest) ||
> +	    is_multicast_ether_addr(h_ether->h_dest))
> +		return -EINVAL;
> +
> +	ether_addr_copy(key.dst_mac_addr, h_ether->h_dest);
> +	key.vlan = 0;
> +	if (fs->flow_type & FLOW_EXT) {
> +		struct ethtool_flow_ext *m_ext = &fs->m_ext;
> +		struct ethtool_flow_ext *h_ext = &fs->h_ext;
> +
> +		if (m_ext->vlan_tci != htons(0xfff) || !h_ext->vlan_tci)
> +			return -EINVAL;
> +		key.vlan = ntohs(h_ext->vlan_tci);
> +	}
> +
> +	flags = BNGE_ACT_RING_DST;
> +	vnic_id = bn->vnic_info[BNGE_VNIC_DEFAULT].fw_vnic_id;
> +
> +	fltr = bnge_alloc_user_l2_filter(bn, &key, flags);
> +	if (IS_ERR(fltr))
> +		return PTR_ERR(fltr);
> +
> +	fltr->base.fw_vnic_id = vnic_id;
> +	fltr->base.rxq = ring;
> +	rc = bnge_hwrm_l2_filter_alloc(bn->bd, fltr);
> +	if (rc)
> +		bnge_del_l2_filter_rcu(bn, fltr);
> +	else
> +		fs->location = fltr->base.sw_id;
> +	return rc;
> +}
> +
> +static int bnge_srxclsrlins(struct bnge_net *bn, struct ethtool_rxnfc *cmd)
> +{
> +	struct ethtool_rx_flow_spec *fs = &cmd->fs;
> +	struct bnge_dev *bd = bn->bd;
> +	u32 ring, flow_type;
> +	int rc;
> +
> +	if (!netif_running(bn->netdev))
> +		return -EAGAIN;
> +	if (!(bn->priv_flags & BNGE_NET_EN_NTUPLE))
> +		return -EPERM;
> +	if (fs->location != RX_CLS_LOC_ANY)
> +		return -EINVAL;
> +
> +	flow_type = fs->flow_type;
> +
> +	if (flow_type & FLOW_MAC_EXT)
> +		return -EINVAL;
> +
> +	flow_type &= ~FLOW_EXT;
> +
> +	if (fs->ring_cookie == RX_CLS_FLOW_DISC && flow_type != ETHER_FLOW)
> +		return bnge_add_ntuple_cls_rule(bn, cmd);
> +
> +	ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
> +	if (ring >= bd->rx_nr_rings)
> +		return -EINVAL;
> +
> +	if (flow_type == ETHER_FLOW)
> +		rc = bnge_add_l2_cls_rule(bn, fs);
> +	else
> +		rc = bnge_add_ntuple_cls_rule(bn, cmd);
> +	return rc;
> +}
> +
> +static int bnge_srxclsrldel(struct bnge_net *bn, struct ethtool_rxnfc *cmd)
> +{
> +	struct ethtool_rx_flow_spec *fs = &cmd->fs;
> +	struct bnge_filter_base *fltr_base;
> +	struct bnge_ntuple_filter *fltr;
> +	u32 id = fs->location;
> +
> +	rcu_read_lock();
> +	fltr_base = bnge_get_one_fltr_rcu(bn, bn->l2_fltr_hash_tbl,
> +					  BNGE_L2_FLTR_HASH_SIZE, id, 0);
> +	if (fltr_base) {
> +		struct bnge_l2_filter *l2_fltr;
> +
> +		l2_fltr = container_of(fltr_base, struct bnge_l2_filter, base);
> +		rcu_read_unlock();
> +		bnge_hwrm_l2_filter_free(bn->bd, l2_fltr);
> +		bnge_del_l2_filter_rcu(bn, l2_fltr);
> +		return 0;
> +	}
> +	fltr_base = bnge_get_one_fltr_rcu(bn, bn->ntp_fltr_hash_tbl,
> +					  BNGE_NTP_FLTR_HASH_SIZE, id,
> +					  BNGE_MAX_L2_FLTRS);
> +	if (!fltr_base) {
> +		rcu_read_unlock();
> +		return -ENOENT;
> +	}
> +
> +	fltr = container_of(fltr_base, struct bnge_ntuple_filter, base);
> +	if (!(fltr->base.flags & BNGE_ACT_NO_AGING)) {
> +		rcu_read_unlock();
> +		return -EINVAL;
> +	}
> +	rcu_read_unlock();
> +	bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr);
> +	bnge_del_ntp_filter_rcu(bn, fltr);
> +	return 0;
> +}
> +
> +static int bnge_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
> +			  u32 *rule_locs)
> +{
> +	struct bnge_net *bn = netdev_priv(dev);
> +	struct bnge_dev *bd = bn->bd;
> +	int rc = 0;
> +
> +	switch (cmd->cmd) {
> +	case ETHTOOL_GRXCLSRLCNT:
> +		cmd->rule_cnt = bn->user_fltr_count;
> +		cmd->data = bd->max_fltr | RX_CLS_LOC_SPECIAL;
> +		break;
> +
> +	case ETHTOOL_GRXCLSRLALL:
> +		rc = bnge_grxclsrlall(bn, cmd, (u32 *)rule_locs);
> +		break;
> +
> +	case ETHTOOL_GRXCLSRULE:
> +		rc = bnge_grxclsrule(bn, cmd);
> +		break;
> +
> +	default:
> +		rc = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +static int bnge_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
> +{
> +	struct bnge_net *bn = netdev_priv(dev);
> +	int rc;
> +
> +	switch (cmd->cmd) {
> +	case ETHTOOL_SRXCLSRLINS:
> +		rc = bnge_srxclsrlins(bn, cmd);
> +		break;
> +
> +	case ETHTOOL_SRXCLSRLDEL:
> +		rc = bnge_srxclsrldel(bn, cmd);
> +		break;
> +
> +	default:
> +		rc = -EOPNOTSUPP;
> +		break;
> +	}
> +	return rc;
> +}
> +
>  static const struct ethtool_ops bnge_ethtool_ops = {
>  	.cap_link_lanes_supported	= 1,
>  	.get_link_ksettings	= bnge_get_link_ksettings,

[Severity: Low]
When BNGE_ACT_RSS_CTX is set, this branch sets FLOW_RSS and
cmd->rss_context, but it never writes fs->ring_cookie.
bnge_add_ntuple_cls_rule() still stores the requested ring in base.rxq
for these filters, because the RX_CLS_FLOW_DISC check there doesn't
depend on FLOW_RSS.

ethtool_get_rxnfc() copies the whole struct ethtool_rxnfc from
userspace. So for ETHTOOL_GRXCLSRULE, the ring_cookie reported for an
RSS filter is whatever the caller happened to pass in, not the ring
offset stored with the rule. The drop and plain-ring branches do fill
it in.

The ethtool core rejects a non-zero ring with FLOW_RSS unless
cap_rss_rxnfc_adds is set, and bnge_ethtool_ops doesn't set it. So
base.rxq should always be 0 here, and the practical effect is that the
caller's input gets echoed back. Should the RSS branch also set
fs->ring_cookie = fltr->base.rxq, so the rule reads back the way it
was inserted?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com
