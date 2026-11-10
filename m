Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327562;
	b=EwwgchVmiI/wrwBSVxzA4q6NQqy4n2tW9YGw0KWBOB7W/S0AjFopavOwRMUpYb8P2l8U
	 xtVL6Qgnt7/M7hTQ2X0Wrki3+oD3nFHJ2Il9emg7YvBPX6dQXP/31GGd8F+7U/Y4cx4Dz
	 7GZok9bnwKPcSS6oRVBLeo7BnmL2zt50IW22ojj4ikomjU21d30G5nEHA6vmTTN97hXU5
	 11/jnk8A4fpxHw4BQUtxO2hCcP3yzdlIaznPapuGU/kQIJ+1t8VsBT/chvJLGdcIc4lRZ
	 CDJztpsm2asCmXJG4CrDnfNhqiMvgCWdcL5KZI5FtWterlO0WDamDvU6TPCLx9Gc0TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327562;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=U9KTfgYylCuk4PbZYViIq0oVpNPx7vLg8d1cb4C+QtI=;
	b=fSRNenqgYmmucfD7bo7P+6/I1cLY9Y6gHvEo//Y7PC9ZAaUhxMA1Bwwec9k5Lr51hZ3d
	 v54skyUeZjc5YgbnzqUDZUdrpogA8KEjzRBZh+6HsGrXWGXEZddhCUnXli7Skv6kdl2u6
	 jYpYTTGy9yQVj7+r5EpJH/XKTv5zQZECcxM+X4Vx00O45tpEzbpVCPK5vRcrt7LSqhUTI
	 62KnaN8vgt5V7klolfu+orR7/4j6mn/bXQtNS0qIHtyKeKmWdWlM5oMww8XKZJC4Slw6/
	 vMJPUMNVXfGPLZF2dh3wTfpgjXdsf+nK8MMEY9WRKWh2hJy2lce5gu1HViQTqs5O3rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U261z051;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96760A2639;
	Tue, 10 Nov 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U261z051
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546B21F008AB;
	Tue, 10 Nov 2026 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327562;
	bh=U9KTfgYylCuk4PbZYViIq0oVpNPx7vLg8d1cb4C+QtI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U261z051p+mnp3dxUKCoymxmWSqscSzRb3bhCTRyP0alhS9HjAwiTrXcG/UZTtgnQ
	 TjgGooIX9IDWw5kn2QMBZnxPqMXSvAFIYE8JFRSHhiOpib/fXza63V+ppTJ20SajQs
	 GqvdY4UGJ9azcGMI4Xtj1fy2j+RP9iJJjc6XuZdMJUROAqfJtT1wSwZOj2X8eFEc/C
	 DE4XdZPUkwjJwAjTEW7Dm6mjmen58jCzXcQDaC4Vmtwsb9ica6fSuZM0tyKtlZ5fhN
	 OTTmyI0AMtNNeGb1/jEYfCcbUsK4vr5lkI46tTIN0bGUS8eB6akY3a89mfXRAiSCRo
	 IfY9nJuSGd/kA==
Subject:
 Re: [PATCH net-next v6 09/10] bnge: add aRFS flow steering ndo support
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Tue, 10 Nov 2026 16:19:20 +0000
Message-ID: <179432756090.994134.6899387473854989127@kernel.org>
In-Reply-To: <20261106093524.838341-10-vikas.gupta@broadcom.com>
References: <20261106093524.838341-10-vikas.gupta@broadcom.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The aRFS expiry loop in bnge_cfg_ntp_filters()
  (drivers/net/ethernet/broadcom/bnge/bnge_filter.c) ignores the return…
- [Medium] Check-then-act race between the aRFS expiry loop in
  bnge_cfg_ntp_filters() and the retarget path in bnge_rx_flow_steer().
- [Medium] bnge: race on ntp_fltr->l2_filter_id in bnge_open_core()
  inserts duplicate filter

--

bnge: add aRFS flow steering ndo support

This commit adds an ndo_rx_flow_steer callback to the bnge driver. The
callback creates NTUPLE filters for aRFS and inserts them into the NTUPLE
hash table. A new function, bnge_cfg_ntp_filters(), runs from sp_task to
program pending filters in firmware, reprogram retargeted filters and
expire idle filters via rps_may_expire_flow().

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> index 6cf6531a27231..579eca2b7aee9 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c

[ ... ]

> @@ -711,3 +711,80 @@ void bnge_clear_usr_fltrs(struct bnge_net *bn)

[ ... ]

> +	list_for_each_entry_safe(fltr, tmp, &expire_list, base.list_node) {
> +		list_del_init(&fltr->base.list_node);
> +		/* Retargeted by bnge_rx_flow_steer() after the scan */
> +		if (test_bit(BNGE_FLTR_RXQ_UPDATE, &fltr->base.state))
> +			continue;
> +		bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr);
> +		bnge_del_ntp_filter_rcu(bn, fltr);

[Severity: Medium]
Should the return value of bnge_hwrm_cfa_ntuple_filter_free() be ignored
here?

The free can fail in two ways. bnge_hwrm_req_init() can fail to allocate
the request, or bnge_hwrm_req_send() can hit a firmware error or timeout.
In both cases filter_id stays valid:

bnge_hwrm_cfa_ntuple_filter_free() {
    ...
	rc = bnge_hwrm_req_send(bd, req);
	if (!rc)
		fltr->base.filter_id = BNGE_FLTR_ID_INVALID;
	return rc;
}

bnge_del_ntp_filter_rcu() then unlinks and frees the software filter,
which is the only object holding that firmware id. It also clears the
filter's sw_id bit in ntp_fltr_bmap.

Does this leak the firmware n-tuple rule? It would keep steering the flow
to the old RX queue, and the driver could not free it until the interface
is closed.

The update_list loop earlier in bnge_cfg_ntp_filters() handles the same
failure by keeping the software filter:

	if (bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr))
		continue;

Should the expire loop do the same?

This path becomes reachable once the follow-up patch "bnge: add cpu_rmap
support for IRQ affinity" sets dev->rx_cpu_rmap.

[Severity: Medium]
Can a concurrent retarget from bnge_rx_flow_steer() still get lost here?

The test_bit() check runs without ntp_fltr_lock. The filter also stays
linked in ntp_fltr_hash_tbl until bnge_del_ntp_filter_rcu() runs, which
happens after the sleeping HWRM free. One possible sequence:

sp_task, in bnge_cfg_ntp_filters():
  rps_may_expire_flow() returns true, so the filter goes on expire_list
  test_bit(BNGE_FLTR_RXQ_UPDATE) returns false
  bnge_hwrm_cfa_ntuple_filter_free() sleeps

softirq on another CPU, in set_rps_cpu()->bnge_rx_flow_steer():
  bnge_lookup_ntp_filter_from_idx() finds the still-linked filter
  WRITE_ONCE(fltr->base.rxq, rxq_index);
  set_bit(BNGE_FLTR_RXQ_UPDATE, &fltr->base.state);
  rc = fltr->base.sw_id is returned to set_rps_cpu()

sp_task:
  bnge_del_ntp_filter_rcu() unlinks the filter and clears its sw_id
  in ntp_fltr_bmap

set_rps_cpu() then stores the returned sw_id in rflow->filter. While the
flow stays active on the same CPU, set_rps_cpu() then takes this path:

	if (READ_ONCE(tmp_rflow->filter) != RPS_NO_FILTER) {
		if (rps_flow_is_active(tmp_rflow, ...)) {
			if (hash != READ_ONCE(tmp_rflow->hash) ||
			    next_cpu == tmp_cpu)
				goto out;

So ndo_rx_flow_steer() is not called again.

Doesn't that leave the flow without hardware steering until it goes idle
or moves to another CPU? The RPS flow table would also hold a sw_id that
has been released and can be reused.

The comment "Retargeted by bnge_rx_flow_steer() after the scan" suggests
this check is meant to cover that case.

The scan loop also reads rxq and flow_id as two separate lockless loads:

	rxq = READ_ONCE(fltr->base.rxq);
	flow_id = READ_ONCE(fltr->flow_id);

Could these see a torn pair while a retarget is in progress, and put a
filter that was just retargeted on expire_list?

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -3222,6 +3231,132 @@ static int bnge_set_features(struct net_device *dev, netdev_features_t features)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_RFS_ACCEL
> +static __le64 bnge_lookup_l2_filter_from_key(struct bnge_net *bn,
> +					     struct bnge_l2_key *key)
> +{
> +	u32 idx;
> +
> +	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
> +	      BNGE_L2_FLTR_HASH_MASK;
> +	return bnge_lookup_l2_filter_rcu(bn, key, idx);
> +}
> +
> +static int bnge_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
> +			      u16 rxq_index, u32 flow_id)
> +{
> +	struct ethhdr *eth = (struct ethhdr *)skb_mac_header(skb);
> +	struct bnge_ntuple_filter *fltr, *new_fltr;
> +	struct bnge_net *bn = netdev_priv(dev);
> +	struct flow_keys *fkeys;
> +	__le64 filter_id;
> +	u32 flags, idx;
> +	int rc = 0;
> +
> +	/* Hold rcu_read_lock() across the L2 filter lookup and check
> +	 * BNGE_STATE_OPEN inside it. bnge_close_core() clears the
> +	 * flag before bnge_shutdown_nic() frees the L2 filters via
> +	 * kfree_rcu(), so if we observe the device open here the
> +	 * filter cannot be freed under us for the duration of
> +	 * this critical section.
> +	 */
> +	rcu_read_lock();
> +	if (!test_bit(BNGE_STATE_OPEN, &bn->bd->state)) {
> +		rcu_read_unlock();
> +		return -EINVAL;
> +	}
> +
> +	if (ether_addr_equal(dev->dev_addr, eth->h_dest)) {
> +		struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
> +		struct bnge_l2_filter *l2_filter;
> +
> +		if (!vnic->uc_filter_count) {
> +			rcu_read_unlock();
> +			return -EINVAL;
> +		}
> +		l2_filter = vnic->l2_filters[0];
> +		filter_id = l2_filter->base.filter_id;
> +	} else {
> +		struct bnge_l2_key key;
> +
> +		ether_addr_copy(key.dst_mac_addr, eth->h_dest);
> +		key.vlan = 0;
> +
> +		filter_id = bnge_lookup_l2_filter_from_key(bn, &key);
> +		if (filter_id == BNGE_FLTR_ID_INVALID) {
> +			rcu_read_unlock();
> +			return -EINVAL;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	new_fltr = kzalloc_obj(*new_fltr, GFP_ATOMIC);
> +	if (!new_fltr)
> +		return -ENOMEM;
> +
> +	fkeys = &new_fltr->fkeys;
> +	if (!skb_flow_dissect_flow_keys(skb, fkeys, 0)) {
> +		rc = -EPROTONOSUPPORT;
> +		goto err_free;
> +	}
> +
> +	if ((fkeys->basic.n_proto != htons(ETH_P_IP) &&
> +	     fkeys->basic.n_proto != htons(ETH_P_IPV6)) ||
> +	    (fkeys->basic.ip_proto != IPPROTO_TCP &&
> +	     fkeys->basic.ip_proto != IPPROTO_UDP)) {
> +		rc = -EPROTONOSUPPORT;
> +		goto err_free;
> +	}
> +	new_fltr->fmasks = BNGE_FLOW_IPV4_MASK_ALL;
> +	if (fkeys->basic.n_proto == htons(ETH_P_IPV6))
> +		new_fltr->fmasks = BNGE_FLOW_IPV6_MASK_ALL;
> +
> +	flags = fkeys->control.flags;
> +	if (flags & FLOW_DIS_IS_FRAGMENT) {
> +		rc = -EPROTONOSUPPORT;
> +		goto err_free;
> +	}
> +
> +	new_fltr->l2_filter_id = filter_id;
> +
> +	idx = bnge_get_ntp_filter_idx(bn, fkeys, skb);
> +	rcu_read_lock();
> +	fltr = bnge_lookup_ntp_filter_from_idx(bn, new_fltr, idx);
> +	/* Filter already exists. If the flow moved to another queue,
> +	 * retarget it, sp_task reprograms it in hardware.
> +	 */
> +	if (fltr) {
> +		if (!(fltr->base.flags & BNGE_ACT_NO_AGING) &&
> +		    READ_ONCE(fltr->base.rxq) != rxq_index) {
> +			spin_lock_bh(&bn->ntp_fltr_lock);
> +			WRITE_ONCE(fltr->base.rxq, rxq_index);
> +			WRITE_ONCE(fltr->flow_id, flow_id);
> +			/* Pairs with test_and_clear_bit() in sp_task */
> +			smp_mb__before_atomic();
> +			set_bit(BNGE_FLTR_RXQ_UPDATE, &fltr->base.state);
> +			spin_unlock_bh(&bn->ntp_fltr_lock);
> +			bnge_queue_sp_work(bn, BNGE_RX_NTP_FLTR_SP_EVENT);
> +		}
> +		rc = fltr->base.sw_id;
> +		rcu_read_unlock();
> +		goto err_free;
> +	}
> +	rcu_read_unlock();
> +
> +	new_fltr->flow_id = flow_id;
> +	new_fltr->base.rxq = rxq_index;
> +	rc = bnge_insert_ntp_filter(bn, new_fltr, idx);
> +	if (!rc) {
> +		bnge_queue_sp_work(bn, BNGE_RX_NTP_FLTR_SP_EVENT);
> +		return new_fltr->base.sw_id;
> +	}
> +
> +err_free:
> +	kfree(new_fltr);
> +	return rc;
> +}
> +#endif
> +
>  static const struct net_device_ops bnge_netdev_ops = {
>  	.ndo_open		= bnge_open,
>  	.ndo_stop		= bnge_close,

[Severity: Medium]
Can bnge_rx_flow_steer() run here before the retained user n-tuple
filters have been rebound to the new L2 filter?

bnge_close_core() keeps the ethtool n-tuple rules in ntp_fltr_hash_tbl
and usr_fltr_list. They keep the l2_filter_id they had before the
close. On the next open, bnge_init_chip() allocates a fresh default L2
filter in vnic->l2_filters[0]. bnge_open_core() then enables NAPI,
sets BNGE_STATE_OPEN and enables interrupts. It calls
bnge_cfg_usr_fltrs() only after the sleeping HWRM calls in
bnge_get_port_module_status() and bnge_hwrm_realloc_rss_ctx_vnic().

In that window a packet for dev->dev_addr can reach
bnge_rx_flow_steer(). It passes the BNGE_STATE_OPEN check and picks up
the new vnic->l2_filters[0]->base.filter_id. It then looks the flow up
with bnge_lookup_ntp_filter_from_idx(). bnge_fltr_match() compares
l2_filter_id, so a retained user rule for the same tuple does not
match while it still carries the old id. The NO_AGING branch, which
is meant to let the user rule win, is skipped.
bnge_insert_ntp_filter() then adds a second, dynamic filter for that
flow to the bucket.

There is also a plain data race on the field itself.
bnge_cfg_one_usr_fltr() rewrites ntp_fltr->l2_filter_id without
ntp_fltr_lock:

	ntp_fltr->l2_filter_id = l2_fltr->base.filter_id;

At the same time, bnge_rx_flow_steer() and bnge_insert_ntp_filter()
can read that 64-bit value from softirq. On 32-bit the read can tear.

Doesn't this leave two hash table entries for the same flow? Once
sp_task programs the dynamic one, it could also leave two firmware
rules, one steering to the aRFS queue instead of the queue or action
the user configured with ethtool.

Would it make sense to restore the user filters before
BNGE_STATE_OPEN is set? Alternatively, bnge_rx_flow_steer() could
back off until bnge_cfg_usr_fltrs() has run. If the l2_filter_id
update has to stay where it is, should it at least be done under
ntp_fltr_lock?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106093524.838341-1-vikas.gupta%40broadcom.com
