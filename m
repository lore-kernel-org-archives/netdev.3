Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4404F5DE1;
	Thu,  1 Oct 2026 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846023; cv=none; b=TCfUqKulgXl4GyraUHxmY+1SxW6Ob9dqj76QiO9zFdGnvapEjooci6lnlkj0w8FJIeVtMGBtmrZb3UfR+ji2anYh17TnsPHyQI7T5WcfTMRgMlSxn4B8zRH53CUWiUIPffwYKa+nLK7n2bT8NfMOS4bCM+w3wajwbdFseCRVRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846023; c=relaxed/simple;
	bh=ABo2oGjho1eL6PPNt4dNMCjwNJK0cqXChzTEWGFEZeU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BV/7BaMhl7P9cReejDibts68Hz5DrcpFVnEuWH8l3k+lNOIdv0suxDci03U1zXEiztV8injROEITnaWksJPgDJdH2PJ3Xa8k8CoeZXyvfUU2Rm3txTwpjsBrFnKJGHi5fQdXbyTBNEDrEszQNkAOP4/m61woI84CPuc/exxP6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9qYSli8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9qYSli8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075221F000FF;
	Thu,  1 Oct 2026 09:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846020;
	bh=jlSp003ReBOYL9b632G0vnnfhBxn+Vkvl4nNnBOXOLQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j9qYSli8w/3UffRs4zEzH7CaLFzxudvnwIZm4BooxdS+RZIyoLbj854UQPLq9TtRL
	 fdsYbM4gz2ztD5H4RV6FOBv2wP87n5FcZR9+bm8KYr8K57DZBDxOwMk4GG+vTxWAAq
	 mP6BZeFXWZ2XJ9Wum0fSvw34ORMpB/YXZT4BArAvWaskpeqZPW8TxMKKBrM+5kpi61
	 0P3t04f4KP2RvikEnkPE33edqypiFiXiTGJH1YUMFHvpeTkS9y6647k8yKnvRsKnVU
	 npwu+SvybDKxwTFjcUPS2aG9ZhUMtfCUYY2DRFGxKZt9wGbzFWfudE4c1oXs7ZXx3U
	 ttu1duk4/D3IA==
Subject: Re: [net-next, v4 07/10] bnge: add NTUPLE filter infrastructure
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Thu, 01 Oct 2026 09:13:39 +0000
Message-ID: <179084601955.434549.5373208577920989982@kernel.org>
In-Reply-To: <20260928061307.1172344-8-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-8-vikas.gupta@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Readers and writers access the __le64 filter_id of an RCU-
  published L2 filter concurrently, with plain loads and stores and no…

--

bnge: add NTUPLE filter infrastructure

This commit adds the NTUPLE filter data structures, the hash table and
bitmap management, and HWRM wrappers that allocate and free ntuple filters.
It also adds an RCU lookup helper for L2 filter IDs, which later patches
use for kernel flow steering.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> index 3b26939b04578..7fbb67021b5d9 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c

[ ... ]

> @@ -49,12 +177,38 @@ static struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
>  	return NULL;
>  }
>  
> +__le64 bnge_lookup_l2_filter_rcu(struct bnge_net *bn,
> +				 struct bnge_l2_key *key,
> +				 u32 idx)
> +{
> +	__le64 id = BNGE_FLTR_ID_INVALID;
> +	struct bnge_l2_filter *fltr;
> +	struct hlist_head *head;
> +
> +	rcu_read_lock();
> +
> +	head = &bn->l2_fltr_hash_tbl[idx];
> +	hlist_for_each_entry_rcu(fltr, head, base.hlist) {
> +		struct bnge_l2_key *l2_key = &fltr->l2_key;
> +
> +		if (ether_addr_equal(l2_key->dst_mac_addr, key->dst_mac_addr) &&
> +		    l2_key->vlan == key->vlan) {
> +			id = fltr->base.filter_id;
                                          ^^^^^^^^^

[Severity: Low]

Can this plain load race with the store in bnge_hwrm_l2_filter_alloc()?

bnge_init_l2_filter() publishes the filter with hlist_add_head_rcu() while
filter_id is still BNGE_FLTR_ID_INVALID. The real ID is written later,
after the HWRM round trip (which can sleep). That write is a plain store,
and only the netdev instance lock is held:

bnge_hwrm_l2_filter_alloc() {
    ...
	if (!rc) {
		fltr->base.filter_id = resp->l2_filter_id;
		set_bit(BNGE_FLTR_VALID, &fltr->base.state);
	}
    ...
}

In the later patch "bnge: add aRFS flow steering ndo support", this helper
is called from bnge_rx_flow_steer(). That function runs in RX softirq and
holds neither the netdev lock nor ntp_fltr_lock.

The writer can run at the same time. bnge_cfg_rx_mode() calls
bnge_hwrm_set_vnic_filter() for secondary unicast MACs while the device
is open.

KCSAN should report this as a data race. BNGE can also be built for
32-bit, where the 64-bit load can tear. A value that is half INVALID and
half the real ID would pass this check in bnge_rx_flow_steer():

	filter_id = bnge_lookup_l2_filter_from_key(bn, &key);
	if (filter_id == BNGE_FLTR_ID_INVALID) {

The torn value would then be sent to firmware as req->l2_filter_id.

The aRFS commit message already says that a stale ID is either rejected
by firmware or aged out through rps_may_expire_flow(). A torn value would
end up in one of those two outcomes, so the effect is limited.

Would it make sense to use READ_ONCE() here, paired with WRITE_ONCE() in
bnge_hwrm_l2_filter_alloc()? The series already pairs them this way for
ntp_fltr_count.

> +			break;
> +		}
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com
