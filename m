Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327561;
	b=DJEaTpJMkYCbyJXiHN8FMe53n1MtV+cI5Pu7qTP4aKD6Ot3VfWZNbKIUf5RZywkrPAiW
	 3mknf5HOzqVHGwMRduihki694roHA17MfeQAsQooKQ2yvw1rQaOVosQUIwDs5Yx1XrPg+
	 9KJl5/7mNLsNbZcFm+GIaMlymMS6Uv46VAQFH3J1dEJC3xydqnnkewdgC5IO7onN+N0lM
	 n7C+hEvJYaXemr5a2i4GShMMRtaQJ+yaX+3z8ZxgBJgtX3Ev8GxkuF5vuy+LIfTVgNeTD
	 MEl7hR3TCTAvJY7C6liMy2KwGrBwasYuBMa0PIku9i9BmNe9Q98vdJ0THOVHqIUa58A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327561;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HuPe6dmEQ+2xpU/EdEXCQURLryftSrUIBpmHH9pIKBE=;
	b=BkOgxBKiimP/USaY4E/sw0LrJgJQ2KpqvZ/bd4V0qLrEWexDYTpFiHWdlM1F3vQbJlTV
	 P8ZlzeY6XZ/JhZ9SpQwT5izHnIo2Yxpy7K6OSqMgWzBJ8slfLerxCKoWTt/KyKVGQR8Ug
	 nFcwqULSSFaagG2mVjhgRd0ugu0ripwEvKIfYVncaGuPuC6Lu5ozXTivQeWbW3Z1DXDEg
	 stw/B0pJ71H4+0bp1+4HXn4oiCKyIFlMc4+A1KkQnY/WAbUZaMUBwOMCPN4Q2/WiU24Od
	 wHo2axOvBhyd9UOWfmz9lydbyUdQsawG2qnGJVd0rkrYl8OMZpgJWRxcjZTDBT3uKJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwghNvSc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2560A261B;
	Tue, 10 Nov 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwghNvSc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F6B1F008A4;
	Tue, 10 Nov 2026 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327560;
	bh=HuPe6dmEQ+2xpU/EdEXCQURLryftSrUIBpmHH9pIKBE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GwghNvScvUtwDdUUE7mhwrwQHfKovhwLkF5xLv8e5+hdMjjYhbx07xtod+E6l9uMD
	 oyGa3S5SIAGl9PeI7H5QrzCZFlM57GQBcxiuqgkfhHjJe36MQCr/7AF+1DiUr9sUPR
	 6lpVC+7EFKgd2V8aQiUIcrBaFG6HJDvWoHnvQCv95a1VaRyy5cH5uYhlza2RX7G0/7
	 OMi18Bqg5StR3yn9t6tLZUqWVoxoiXoxDaeB7PqmiXGY3NjdO4qbDi/DZZ7HHIiEbT
	 /FqMgZWUdTgOdpTdbEUUijvqr49OoOk/K0pT5N1keudJVlTUcgAOrbHnax52RxlxJd
	 FA0P63GLl5aMw==
Subject:
 Re: [PATCH net-next v6 08/10] bnge: add NTUPLE filter support in ethtool
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Tue, 10 Nov 2026 16:19:19 +0000
Message-ID: <179432755946.994134.16437363574247692831@kernel.org>
In-Reply-To: <20261106093524.838341-9-vikas.gupta@broadcom.com>
References: <20261106093524.838341-9-vikas.gupta@broadcom.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] bnge_cfg_rx_mode()
  (drivers/net/ethernet/broadcom/bnge/bnge_netdev.c) used to program at…
- [Medium] bnge_cfg_rx_mode() decides from the shared L2 pool whether to
  program unicast filters or fall back to promiscuous mode.
- [Medium] bnge_srxclsrldel()
  (drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c) ignores the return…
- [Medium] bnge_hwrm_l2_filter_alloc() now sets
  CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_L2 for user ETHER_FLOW ring…
- [Low] Two existing ethtool operations gain new -EBUSY failures, and the
  commit message mentions neither.

--

bnge: add NTUPLE filter support in ethtool

This adds ethtool rxnfc operations to manage NTUPLE and ETHER_FLOW filters
in bnge. User filters stay in software across down/up and are programmed
again on open. The unicast address filters and the user ETHER_FLOW rules
now share the L2 filter pool. BNGE_MAX_UC_ADDRS is removed, and
l2_filters[] and uc_list are sized by BNGE_MAX_L2_FLTRS.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> index c370686e2b38d..440e0c206aeca 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c

[ ... ]

> @@ -999,6 +1001,12 @@ static int bnge_set_rxfh_fields(struct net_device *dev,
>  		return -EBUSY;
>  	}
>  
> +	if (bnge_has_usr_ntp_fltr(bn)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Delete user ntuple rules before changing the RSS hash fields");
> +		return -EBUSY;
> +	}
> +
>  	bd->rss_hash_cfg = rss_hash_cfg;
>  
>  	return 0;
> @@ -1060,6 +1068,12 @@ static int bnge_set_rxfh(struct net_device *dev,
>  		return -EBUSY;
>  	}
>  
> +	if (rxfh->key && bnge_has_usr_ntp_fltr(bn)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Delete user ntuple rules before changing the RSS hash key");
> +		return -EBUSY;
> +	}
> +

[Severity: Low]
This isn't a bug, but the commit message doesn't mention that two existing
ethtool operations can now fail with -EBUSY.

While a user ntuple rule exists, bnge_set_rxfh_fields() rejects any hash
field change and bnge_set_rxfh() rejects any RSS hash key change. The only
explanation is the comment above bnge_has_usr_ntp_fltr(). It says rules
are indexed by a hash of the RSS key and hash fields and are never
rehashed.

So a user who adds rules with ethtool -N and later runs ethtool -X ... hkey
or changes rx-flow-hash will now get EBUSY. Could the commit log mention
this restriction?

[ ... ]

> @@ -1243,6 +1257,611 @@ static int bnge_remove_rxfh_context(struct net_device *dev,

[ ... ]

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
> +		/* The firmware filter is gone once the interface is closed. */
> +		if (test_bit(BNGE_FLTR_VALID, &l2_fltr->base.state))
> +			bnge_hwrm_l2_filter_free(bn->bd, l2_fltr);
> +		bnge_del_usr_l2_filter(bn, l2_fltr);
> +		return 0;
> +	}

[ ... ]

> +	rcu_read_unlock();
> +	bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr);
> +	bnge_del_ntp_filter_rcu(bn, fltr);
> +	return 0;
> +}

[Severity: Medium]
What happens in bnge_srxclsrldel() if bnge_hwrm_l2_filter_free() or
bnge_hwrm_cfa_ntuple_filter_free() fails?

Both can fail through bnge_hwrm_req_send(). Examples are -EAGAIN for
HWRM_ERR_CODE_BUSY or HOT_RESET_PROGRESS, -EIO for unknown errors, and
timeouts. bnge_hwrm_cfa_ntuple_filter_free() resets filter_id only on
success.

In both branches the return value is ignored. The software entry is freed
by bnge_del_l2_filter_rcu() or bnge_del_ntp_filter_rcu(), and userspace
gets 0. The rule disappears from ETHTOOL_GRXCLSRLALL, but the firmware
filter would still be installed and still steering or dropping traffic.

The only record of that filter_id is gone, so nothing later can free it.
bnge_hwrm_clear_usr_l2_fltrs() walks only usr_fltr_list, and
bnge_hwrm_clear_vnic_filter() walks only vnic->l2_filters[].

For an ETHER_FLOW rule, bnge_del_usr_l2_filter() then programs a new
unicast filter for the same MAC on the default VNIC right away. The
orphaned RING_DST filter may still be in firmware at that point.

Should the error be returned and the software entry kept? bnxt_srxclsrldel()
in bnxt_en has the same pattern.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> index 3ebb3cae4829b..6cf6531a27231 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> @@ -584,3 +584,130 @@ int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,

[ ... ]

> +void bnge_del_usr_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr)
> +{

[ ... ]

> +	vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
> +	for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
> +		if (vnic->l2_filters[i] ||
> +		    !ether_addr_equal(vnic->uc_list + off, mac))
> +			continue;
> +		if (bnge_hwrm_set_vnic_filter(bn, 0, i, vnic->uc_list + off))
> +			netdev_warn(bn->netdev,
> +				    "failed to restore uc filter %pM\n", mac);
> +		break;
> +	}
> +}

[Severity: Medium]
Is a failed restore in bnge_del_usr_l2_filter() ever retried?

If bnge_hwrm_set_vnic_filter() fails here, even with a transient -EAGAIN
from HWRM_ERR_CODE_BUSY, the driver only prints a warning.
vnic->l2_filters[i] stays NULL. bnge_uc_list_updated() compares only the
address lists against vnic->uc_list:

    if (!ether_addr_equal(ha->addr, vnic->uc_list + off))
        return true;

Later rx_mode events and the core retry timer therefore see
uc_update == false and never reprogram that slot. Unicast traffic to the
MAC (a macvlan, for example) would be dropped until the address list
changes, unless the device is promiscuous for some other reason.

The commit message does say "the address is left without a filter until
its address list changes". Elsewhere the driver retries on -EAGAIN, but a
firmware-busy error here is never retried. The open path also reaches this
code: bnge_cfg_one_usr_fltr() calls it when a user L2 rule cannot be
restored.

A second stale state is not mentioned. Suppose bnge_cfg_rx_mode() chose
promiscuous mode earlier because uc_count > l2_free. Then uc_filter_count
is 1 and this loop does nothing. Deleting user rules frees L2 slots, but
nothing runs the promiscuous decision again. The VNIC stays promiscuous
until some unrelated rx_mode event.

Would it make sense to schedule an rx_mode update after a user L2 rule is
deleted?

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> index 33cbdd6d8276f..bb62333514841 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> @@ -906,15 +906,18 @@ int bnge_hwrm_l2_filter_alloc(struct bnge_dev *bd, struct bnge_l2_filter *fltr)

[ ... ]

> -	req->flags = cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX);
> -
> -	req->flags |= cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST);
> +	flags = CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX |
> +		CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST;
> +	if (BNGE_L2_FLTR_IS_NTP_MAC(fltr))
> +		flags |= CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_L2;
> +	req->flags = cpu_to_le32(flags);

[Severity: Medium]
Can RoCE traffic for a MAC end up with no L2 filter at all?

User ETHER_FLOW ring rules now get TRAFFIC_L2. The unicast and default
filters from bnge_hwrm_set_vnic_filter() keep traffic type 0
(CFA_L2_FILTER_ALLOC_REQ_FLAGS_TRAFFIC_NO_ROCE_L2).

When a user rule for MAC X already exists, bnge_alloc_l2_filter() returns
-EEXIST from the software hash lookup. bnge_cfg_rx_mode() then installs no
firmware filter for that address:

    if (rc == -EEXIST) {
        /* Already delivered by a user L2 rule */
        vnic->l2_filters[i] = NULL;
        continue;
    }

In the HWRM spec, type 0 exists for old drivers and covers both RoCE and
L2 traffic, while TRAFFIC_L2 matches L2 traffic only. If that reading is
right, no firmware L2 filter covers RoCE frames to MAC X while the rule
exists. One example is a RoCE GID on a macvlan with the rule's MAC, with
the bnge RoCE auxiliary device present.

The commit message only talks about L2 delivery to the rule's ring.
bnxt_en uses the same HWRM interface and never sets TRAFFIC_L2 on its L2
filters, so this split looks new to bnge.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index ff6573b5e60ec..94406d5ecb71e 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -2079,7 +2082,12 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
>  	netdev_hw_addr_list_for_each(ha, uc)
>  		if (!ether_addr_equal(ha->addr, dev->dev_addr))
>  			uc_count++;
> -	if (uc_count > BNGE_MAX_UC_ADDRS - 1) {
> +	/* The unicast addresses and the user ETHER_FLOW rules share the L2
> +	 * filters. Receive the addresses that do not fit in promiscuous mode.
> +	 */
> +	l2_free = BNGE_MAX_L2_FLTRS -
> +		  bitmap_weight(bn->l2_fltr_bmap, BNGE_MAX_L2_FLTRS);
> +	if (uc_count > BNGE_MAX_L2_FLTRS - 1 || uc_count > l2_free) {
>  		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
>  	} else {
>  		netdev_hw_addr_list_for_each(ha, uc) {
> @@ -2095,6 +2103,11 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
>  
>  	for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
>  		rc = bnge_hwrm_set_vnic_filter(bn, 0, i, vnic->uc_list + off);
> +		if (rc == -EEXIST) {
> +			/* Already delivered by a user L2 rule */
> +			vnic->l2_filters[i] = NULL;
> +			continue;
> +		}
>  		if (rc) {
>  			if (rc == -EAGAIN)
>  				netdev_warn(dev, "FW busy while setting vnic filter, will retry\n");

[Severity: Medium]
What happens in bnge_cfg_rx_mode() when firmware runs out of L2 filters?

Before this patch, at most 3 secondary unicast addresses were programmed
(BNGE_MAX_UC_ADDRS - 1). Anything beyond that fell back to promiscuous
mode. Now up to 127 can be programmed, but both bounds come only from the
software l2_fltr_bmap. bnge_hwrm_func_resc_qcaps() reads
hw_resc->max_l2_ctxs, but nothing uses it, and the CFA L2 table is shared
across functions.

Suppose firmware rejects a filter partway through this loop with an error
other than -EEXIST, for example HWRM_ERR_CODE_RESOURCE_ALLOC_ERROR, which
maps to -ENOSPC. The function then returns before skip_uc:

            vnic->uc_filter_count = i;
            return rc;

PROMISCUOUS is never set and the rx mask is not reprogrammed. The core
netif_rx_mode retry gives up after 4 attempts. After that, the remaining
addresses have neither a filter nor promiscuous mode, so their traffic
would be dropped silently. With the old 3-address cap this path was
practically unreachable.

Should a failure here fall back to promiscuous mode, or should the limit
take firmware capacity into account?

The commit message also says the driver uses promiscuous mode "as it
already does for more than BNGE_MAX_L2_FLTRS - 1 addresses". The old
threshold was actually BNGE_MAX_UC_ADDRS - 1, which is 3.

This change has two side effects. Every unicast list change now frees and
re-allocates up to 127 firmware filters through HWRM instead of 3. Also,
every struct bnge_vnic_info grows from 4 to 128 l2_filters[] pointers,
including the copy embedded in each struct bnge_rss_ctx, even though only
the default VNIC uses the array.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106093524.838341-1-vikas.gupta%40broadcom.com
