Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327559;
	b=TDsnCQhztd+4Rcp6xMJ0F2WA4YerdOfZFdafTEEcYbirTr7CXd+6yqzrOT7F2giuZWhW
	 /4noy6D1BgDKBzS62WRDBr+tYi3o4TBzH4XIwXDylMqCr5/hiHIusycDowjSpl5mo+6+o
	 sUP2aTNTHNzFb4nrgURf7rz1ntj2XnUQySTunpp4OH3b1VWKPppFboQ88+QR+hrkaS5JR
	 o3dVc2Vii1Uospgs3nxvbrJBlnmnyHaSE7zTDNYgQkHPLuNzvox+C2JPhe+t++jMYlLQW
	 i33GhIe8ymihP+pifWIbKf+5l67XAp1/BD4JfN7+rqdDBwy63lZ3b/XAB/w8RmbVrMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327559;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=b4jgcdSU1sxO8tcohp/Dl4/gvNgv/kdtvbRcKsFcwtM=;
	b=wzmrM279Izkfv2iPplkz42QW/NN0yqJilAJAIACg3H/GVkqZLWVdQzyxA70Sx05sVXTb
	 KDoHuEiGdW1YRl8XwdZg/MpTl7ZeMNbKVvJ9cg6Q8WrImcAnQXKr+EcLEV91xwGs1iFm5
	 agPXxrJVRi1I8HyrgrpfDl8jiY3fhGqh1pwb8pKd4wyo2YK/RSGwUAuZgCP5HdPVAD/kd
	 T+eVgVhNm8ADxJsT7A75BpJoxe+4LTrTD9kOa5pYSpghFCl3J9TMlTJES3W3Uj8zoKEPC
	 o7hawd3sn+aUAI8q6qVOeOd/VV/S5+8klWfbpTdRAOxsISywnTm3j2ghwyZSGkOWucg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuhuAzdt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78060A260F;
	Tue, 10 Nov 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuhuAzdt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ADE1F008A5;
	Tue, 10 Nov 2026 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327559;
	bh=b4jgcdSU1sxO8tcohp/Dl4/gvNgv/kdtvbRcKsFcwtM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CuhuAzdtkOklvJZ8u8iKy5KCyEro0VzgRJcrKcFuYO9PKGvgQK7VqLO8Y0JdKuato
	 ALQsA54QTOZJYb1EcW8aEFRswxkzFpPSQFT+MdlceI1vgwylH0WV9LYGv9Uygsh76C
	 xlOdjb/8nyJOZvQBQ0EX2okoacOSNpcvJUtfm/OnEFI0ZGM5hTSCkUV/XsObUivdxB
	 KiEMv+SdY0VV7UmqssL2YnHXaBKOT5Tzf9Jny5FwMg3l2meUGh4wOZr9N4cXASOeK8
	 hvUraP4R67hpeo3wgwN3M1hdj6gcG0edqwySTs5AFuph4WycVGIsl+JslDcBzJAGdt
	 Cp4qGA3vVYzOQ==
Subject: Re: [PATCH net-next v6 07/10] bnge: add NTUPLE filter infrastructure
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Tue, 10 Nov 2026 16:19:18 +0000
Message-ID: <179432755803.994134.5748629111612164615@kernel.org>
In-Reply-To: <20261106093524.838341-8-vikas.gupta@broadcom.com>
References: <20261106093524.838341-8-vikas.gupta@broadcom.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] bnge: code duplication between bnge_alloc_user_l2_filter() and
  bnge_alloc_l2_filter()

--

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> @@ -72,10 +227,339 @@ static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
>  	if (!fltr)
>  		return ERR_PTR(-ENOMEM);
>  
> -	bnge_init_l2_filter(bn, fltr, key, idx);
> +	rc = bnge_init_l2_filter(bn, fltr, key, idx);
> +	if (rc) {
> +		kfree(fltr);
> +		fltr = ERR_PTR(rc);
> +	}
> +
>  	return fltr;
>  }
>  
> +struct bnge_l2_filter *bnge_alloc_user_l2_filter(struct bnge_net *bn,
> +						 struct bnge_l2_key *key,
> +						 u8 flags)
> +{
> +	struct bnge_l2_filter *fltr;
> +	u32 idx;
> +	int rc;
> +
> +	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
> +	      BNGE_L2_FLTR_HASH_MASK;
> +	fltr = bnge_lookup_l2_filter(bn, key, idx);
> +	if (fltr) {
> +		fltr = ERR_PTR(-EEXIST);
> +		goto l2_filter_exit;
> +	}
> +	fltr = kzalloc_obj(*fltr, GFP_KERNEL);
> +	if (!fltr) {
> +		fltr = ERR_PTR(-ENOMEM);
> +		goto l2_filter_exit;
> +	}
> +	fltr->base.flags = flags;
> +	rc = bnge_init_l2_filter(bn, fltr, key, idx);
> +	if (rc) {
> +		kfree(fltr);
> +		return ERR_PTR(rc);
> +	}
> +
> +l2_filter_exit:
> +	return fltr;
> +}
> +
> +void bnge_free_l2_filters(struct bnge_net *bn)
> +{
> +	int i;
> +
> +	netdev_assert_locked_or_invisible(bn->netdev);
> +
> +	for (i = 0; i < BNGE_L2_FLTR_HASH_SIZE; i++) {
> +		struct bnge_l2_filter *fltr;
> +		struct hlist_head *head;
> +		struct hlist_node *tmp;
> +
> +		head = &bn->l2_fltr_hash_tbl[i];
> +		hlist_for_each_entry_safe(fltr, tmp, head, base.hlist)
> +			bnge_del_l2_filter(bn, fltr);
> +	}
> +
> +	bitmap_free(bn->l2_fltr_bmap);
> +	bn->l2_fltr_bmap = NULL;
> +	bn->l2_fltr_count = 0;
> +}
> +
> +void bnge_free_ntp_fltrs(struct bnge_net *bn, bool skip_user)
> +{
> +	int i;
> +
> +	netdev_assert_locked_or_invisible(bn->netdev);
> +
> +	/* Under netdev instance lock and all our NAPIs have been disabled.
> +	 * It's safe to delete the hash table.
> +	 */
> +	for (i = 0; i < BNGE_NTP_FLTR_HASH_SIZE; i++) {
> +		struct bnge_ntuple_filter *fltr;
> +		struct hlist_head *head;
> +		struct hlist_node *tmp;
> +
> +		head = &bn->ntp_fltr_hash_tbl[i];
> +		hlist_for_each_entry_safe(fltr, tmp, head, base.hlist) {
> +			if (skip_user && bnge_is_usr_fltr(&fltr->base))
> +				continue;
> +			bnge_del_ntp_filter(bn, fltr);
> +		}
> +	}
> +
> +	if (skip_user)
> +		return;
> +
> +	bitmap_free(bn->ntp_fltr_bmap);
> +	bn->ntp_fltr_bmap = NULL;
> +	bn->ntp_fltr_count = 0;
> +}
> +
> +static int bnge_alloc_l2_fltrs_mem(struct bnge_net *bn)
> +{
> +	int i, rc = 0;
> +
> +	if (bn->l2_fltr_bmap)
> +		return 0;
> +
> +	for (i = 0; i < BNGE_L2_FLTR_HASH_SIZE; i++)
> +		INIT_HLIST_HEAD(&bn->l2_fltr_hash_tbl[i]);
> +
> +	bn->l2_fltr_count = 0;
> +	bn->l2_fltr_bmap = bitmap_zalloc(BNGE_MAX_L2_FLTRS, GFP_KERNEL);
> +
> +	if (!bn->l2_fltr_bmap)
> +		rc = -ENOMEM;
> +
> +	return rc;
> +}
> +
> +static int bnge_alloc_ntp_fltrs_mem(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int i, rc = 0;
> +
> +	if (!(bn->priv_flags & BNGE_NET_EN_NTUPLE) || bn->ntp_fltr_bmap)
> +		return 0;
> +
> +	for (i = 0; i < BNGE_NTP_FLTR_HASH_SIZE; i++)
> +		INIT_HLIST_HEAD(&bn->ntp_fltr_hash_tbl[i]);
> +
> +	bn->ntp_fltr_count = 0;
> +	bn->ntp_fltr_bmap = bitmap_zalloc(bd->max_fltr, GFP_KERNEL);
> +
> +	if (!bn->ntp_fltr_bmap)
> +		rc = -ENOMEM;
> +
> +	return rc;
> +}
> +
> +int bnge_fltrs_mem(struct bnge_net *bn)
> +{
> +	bool ntp_alloced = !bn->ntp_fltr_bmap;
> +	int rc;
> +
> +	rc = bnge_alloc_ntp_fltrs_mem(bn);
> +	if (rc)
> +		return rc;
> +
> +	rc = bnge_alloc_l2_fltrs_mem(bn);
> +	if (rc)
> +		goto err_free_ntp_mem;
> +
> +	return 0;
> +
> +err_free_ntp_mem:
> +	if (ntp_alloced) {
> +		bitmap_free(bn->ntp_fltr_bmap);
> +		bn->ntp_fltr_bmap = NULL;
> +	}
> +	return rc;
> +}
> +
> +#define BNGE_IPV4_4TUPLE(bd, fkeys)					\
> +	(((fkeys)->basic.ip_proto == IPPROTO_TCP &&			\
> +	  (bd)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV4) ||	\
> +	 ((fkeys)->basic.ip_proto == IPPROTO_UDP &&			\
> +	  (bd)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV4))
> +
> +#define BNGE_IPV6_4TUPLE(bd, fkeys)					\
> +	(((fkeys)->basic.ip_proto == IPPROTO_TCP &&			\
> +	  (bd)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV6) ||	\
> +	 ((fkeys)->basic.ip_proto == IPPROTO_UDP &&			\
> +	  (bd)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV6))
> +
> +static u32 bnge_get_rss_flow_tuple_len(struct bnge_dev *bd,
> +				       struct flow_keys *fkeys)
> +{
> +	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
> +		if (BNGE_IPV4_4TUPLE(bd, fkeys))
> +			return sizeof(fkeys->addrs.v4addrs) +
> +			       sizeof(fkeys->ports);
> +
> +		if (bd->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV4)
> +			return sizeof(fkeys->addrs.v4addrs);
> +	}
> +
> +	if (fkeys->basic.n_proto == htons(ETH_P_IPV6)) {
> +		if (BNGE_IPV6_4TUPLE(bd, fkeys))
> +			return sizeof(fkeys->addrs.v6addrs) +
> +			       sizeof(fkeys->ports);
> +
> +		if (bd->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6)
> +			return sizeof(fkeys->addrs.v6addrs);
> +	}
> +
> +	return 0;
> +}
> +
> +static u32 bnge_toeplitz(struct bnge_net *bn, struct flow_keys *fkeys,
> +			 const unsigned char *key)
> +{
> +	u64 prefix = bn->toeplitz_prefix, hash = 0;
> +	struct bnge_ipv4_tuple tuple4;
> +	struct bnge_ipv6_tuple tuple6;
> +	struct bnge_dev *bd = bn->bd;
> +	u8 *four_tuple;
> +	int i, j, len;
> +
> +	len = bnge_get_rss_flow_tuple_len(bd, fkeys);
> +	if (!len)
> +		return 0;
> +
> +	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
> +		tuple4.v4addrs = fkeys->addrs.v4addrs;
> +		tuple4.ports = fkeys->ports;
> +		four_tuple = (u8 *)&tuple4;
> +	} else {
> +		tuple6.v6addrs = fkeys->addrs.v6addrs;
> +		tuple6.ports = fkeys->ports;
> +		four_tuple = (u8 *)&tuple6;
> +	}
> +
> +	for (i = 0, j = 8; i < len; i++, j++) {
> +		u8 byte = four_tuple[i];
> +		int bit;
> +
> +		for (bit = 0; bit < 8; bit++, prefix <<= 1, byte <<= 1) {
> +			if (byte & 0x80)
> +				hash ^= prefix;
> +		}
> +		prefix |= (j < HW_HASH_KEY_SIZE) ? key[j] : 0;
> +	}
> +
> +	/* The valid part of the hash is in the upper 32 bits. */
> +	return (hash >> 32) & BNGE_NTP_FLTR_HASH_MASK;
> +}
> +
> +u32 bnge_get_ntp_filter_idx(struct bnge_net *bn, struct flow_keys *fkeys,
> +			    const struct sk_buff *skb)
> +{
> +	struct bnge_vnic_info *vnic;
> +
> +	if (skb)
> +		return skb_get_hash_raw(skb) & BNGE_NTP_FLTR_HASH_MASK;
> +
> +	vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
> +	return bnge_toeplitz(bn, fkeys, (void *)vnic->rss_hash_key);
> +}
> +
> +static bool bnge_fltr_match(struct bnge_ntuple_filter *f1,
> +			    struct bnge_ntuple_filter *f2)
> +{
> +	struct bnge_flow_masks *masks1 = &f1->fmasks;
> +	struct bnge_flow_masks *masks2 = &f2->fmasks;
> +	struct flow_keys *keys1 = &f1->fkeys;
> +	struct flow_keys *keys2 = &f2->fkeys;
> +
> +	if (keys1->basic.n_proto != keys2->basic.n_proto ||
> +	    keys1->basic.ip_proto != keys2->basic.ip_proto)
> +		return false;
> +
> +	if (keys1->basic.n_proto == htons(ETH_P_IP)) {
> +		if (keys1->addrs.v4addrs.src != keys2->addrs.v4addrs.src ||
> +		    masks1->addrs.v4addrs.src != masks2->addrs.v4addrs.src ||
> +		    keys1->addrs.v4addrs.dst != keys2->addrs.v4addrs.dst ||
> +		    masks1->addrs.v4addrs.dst != masks2->addrs.v4addrs.dst)
> +			return false;
> +	} else {
> +		if (!ipv6_addr_equal(&keys1->addrs.v6addrs.src,
> +				     &keys2->addrs.v6addrs.src) ||
> +		    !ipv6_addr_equal(&masks1->addrs.v6addrs.src,
> +				     &masks2->addrs.v6addrs.src) ||
> +		    !ipv6_addr_equal(&keys1->addrs.v6addrs.dst,
> +				     &keys2->addrs.v6addrs.dst) ||
> +		    !ipv6_addr_equal(&masks1->addrs.v6addrs.dst,
> +				     &masks2->addrs.v6addrs.dst))
> +			return false;
> +	}
> +
> +	return keys1->ports.src == keys2->ports.src &&
> +	       masks1->ports.src == masks2->ports.src &&
> +	       keys1->ports.dst == keys2->ports.dst &&
> +	       masks1->ports.dst == masks2->ports.dst &&
> +	       keys1->control.flags == keys2->control.flags &&
> +	       f1->l2_filter_id == f2->l2_filter_id;
> +}
> +
> +int bnge_insert_ntp_filter(struct bnge_net *bn, struct bnge_ntuple_filter *fltr,
> +			   u32 idx)
> +{
> +	struct bnge_ntuple_filter *f;
> +	struct hlist_head *head;
> +	int bit_id;
> +
> +	spin_lock_bh(&bn->ntp_fltr_lock);
> +
> +	head = &bn->ntp_fltr_hash_tbl[idx];
> +	hlist_for_each_entry(f, head, base.hlist) {
> +		if (bnge_fltr_match(f, fltr)) {
> +			spin_unlock_bh(&bn->ntp_fltr_lock);
> +			return -EEXIST;
> +		}
> +	}
> +
> +	bit_id = bitmap_find_free_region(bn->ntp_fltr_bmap,
> +					 bn->bd->max_fltr, 0);
> +	if (bit_id < 0) {
> +		spin_unlock_bh(&bn->ntp_fltr_lock);
> +		return -ENOMEM;
> +	}
> +
> +	fltr->base.sw_id = (u16)bit_id;
> +	fltr->base.filter_id = BNGE_FLTR_ID_INVALID;
> +	fltr->base.type = BNGE_FLTR_TYPE_NTUPLE;
> +	fltr->base.flags |= BNGE_ACT_RING_DST;
> +
> +	head = &bn->ntp_fltr_hash_tbl[idx];
> +	hlist_add_head_rcu(&fltr->base.hlist, head);
> +
> +	bnge_insert_usr_fltr(bn, &fltr->base);
> +	bn->ntp_fltr_count++;
> +
> +	spin_unlock_bh(&bn->ntp_fltr_lock);
> +
> +	return 0;
> +}
> +
> +struct bnge_ntuple_filter *
> +bnge_lookup_ntp_filter_from_idx(struct bnge_net *bn,
> +				struct bnge_ntuple_filter *fltr, u32 idx)
> +{
> +	struct bnge_ntuple_filter *f;
> +	struct hlist_head *head;
> +
> +	head = &bn->ntp_fltr_hash_tbl[idx];
> +	hlist_for_each_entry_rcu(f, head, base.hlist) {
> +		if (bnge_fltr_match(f, fltr))
> +			return f;
> +	}
> +	return NULL;
> +}
> +
>  int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
>  			      const u8 *mac_addr)
>  {

[Severity: Low]
bnge_alloc_user_l2_filter() is almost a copy of bnge_alloc_l2_filter()
just above it. Both do the jhash2() bucket computation, the
bnge_lookup_l2_filter() -EEXIST check, kzalloc_obj(), the
bnge_init_l2_filter() call and kfree() on failure.

There are only two differences. The user variant sets
fltr->base.flags before calling bnge_init_l2_filter(), and it
hardcodes GFP_KERNEL. GFP_KERNEL is also what the only caller of
bnge_alloc_l2_filter(), bnge_hwrm_set_vnic_filter(), passes, so the
gfp argument buys nothing today.

bnge_init_l2_filter() already decides from base.flags, via
bnge_insert_usr_fltr(), whether the filter goes on usr_fltr_list.
Could bnge_alloc_l2_filter() take a u8 flags argument instead, so
both paths share one helper? The gfp argument could be dropped
unless you expect a non-GFP_KERNEL caller later.

With two copies, one is likely to be fixed or extended without the
other, for example in the l2_fltr_bmap and sw_id handling that this
patch just added to both.

There is no functional problem here; this is a maintainability nit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106093524.838341-1-vikas.gupta%40broadcom.com
