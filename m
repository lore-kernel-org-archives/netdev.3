Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE14D797D;
	Thu,  1 Oct 2026 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846023; cv=none; b=SbJarxuJBDhghvYLD/EECQNKtpoD5tNJde9YNq77ayPBKo5pGzrCNtjZVB28j+8n6+/Q6folfYQfsIz7xJAZcoFp1ex22Pih+X9PtOZKUaTl6UprE6iIc5O4OKQkcutRMtC1ZhtpBVpL676mX8ryc9jOCKhF9Q8HZmEbauh156U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846023; c=relaxed/simple;
	bh=AleCVZmVzS2wkWzpfoYiipdQw93Ato0t2LjdPdLNEGY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ISlv7Ugp2cqHgjxiuFWyBQnxIUoz9BQummSEYQQGURaqYt0dlHshfYwPDLBYwOh3NHabQIrATiEIM6UNyrMtYxNYtWZv9wULCH9gZJ1lOf4tkjlMfI4Am6Q5Q7NG3XHEXwkUNNF26YWfgYj1bLnFdMZjR9l1YG01LF9QjeqBTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lltRzzG/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lltRzzG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CEB1F0089D;
	Thu,  1 Oct 2026 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846019;
	bh=U3nzgn0ImTE7+vVGTRgi9s+Cfc9Ehmo1qpyqHNResU8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lltRzzG/e6JCrXO+E+1DebqSc/Ei7YGL9ppLNYuP/z/iMpsE0rh/5h8plL9dT4vQO
	 LqBXeXy/i2SAfOtT0IogFA5W63TVULG6LoAOtwurN8NiMjBHAv/9yKijToKyXfXhFt
	 LIRVz483U7eIZLNCbKPAfkk/WV2ZOXtqmH/8dUDKpIj84KLKEA7qfIkyFti6NJ4teh
	 x4eRfTlAeGxp8/HtfxKUS1R0OEJlJj9juekAbxu+eSGTB5P0o1ZD27f25AoGmE4ut3
	 7kv4u1Rt9yAcRGy/5uznpf7w7iVEBTKqGx/2FyqAMPWy1bBnxeT/B0bERjiV8V0uvl
	 MjmyeT2YPypKA==
Subject: Re: [net-next, v4 06/10] bnge: remove refcount from L2 filter
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Thu, 01 Oct 2026 09:13:38 +0000
Message-ID: <179084601825.434549.14598090355667152020@kernel.org>
In-Reply-To: <20260928061307.1172344-7-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-7-vikas.gupta@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message does not describe what the patch actually
  changes.
- [Low] In bnge_cfg_rx_mode()
  (drivers/net/ethernet/broadcom/bnge/bnge_netdev.c), the patch now…

--

bnge: remove refcount from L2 filter

This commit removes the refcount from struct bnge_l2_filter, because a
filter will now only be removed by the context that created it.
bnge_alloc_l2_filter() now returns -EEXIST for a duplicate key. The unicast
rx-mode code now skips uc entries that match dev->dev_addr.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> index a8bb441ebef9a..3b26939b04578 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c

[ ... ]

> @@ -75,9 +58,10 @@ static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
>  
>  	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
>  	      BNGE_L2_FLTR_HASH_MASK;
> +
>  	fltr = bnge_lookup_l2_filter(bn, key, idx);
>  	if (fltr)
> -		return fltr;
> +		return ERR_PTR(-EEXIST);

[Severity: Medium]
Should the commit message describe this change? It only says:

    However, going forward, the filter will only be removed by the same
    context that created it, making refcount unnecessary.

The patch also makes two behaviour changes that depend on each other:

- bnge_alloc_l2_filter() now fails a duplicate key with -EEXIST. Before,
  it shared the existing filter.
- bnge_cfg_rx_mode() and bnge_uc_list_updated() now skip uc entries equal
  to dev->dev_addr.

Without the skip, opening the device with dev_addr in dev->uc would now
fail with -EEXIST.

Together these two changes seem to fix a bug that dates back to commit
9afad4a17174 ("bng_en: Configure default VNIC"). Before this patch, dev->uc
could hold the device's own MAC, for example after "bridge fdb add
<own-mac> dev X self". In that case the open path did:

bnge_init_chip()
    bnge_hwrm_set_vnic_filter(bn, 0, 0, dev_addr)
    bnge_cfg_rx_mode()
        bnge_hwrm_set_vnic_filter(bn, 0, 1, dev_addr)
            bnge_alloc_l2_filter()
                returns l2_filters[0] with refcount bumped
            bnge_hwrm_l2_filter_alloc()
                fltr->base.filter_id = resp->l2_filter_id;

After this, l2_filters[0] and l2_filters[1] pointed at the same object.
The original firmware ID for filter 0 was overwritten and leaked.

The next rx-mode update freed the new ID through l2_filters[1]. Later,
bnge_hwrm_clear_vnic_filter() freed that same ID a second time through
l2_filters[0]. If the firmware rejected the duplicate alloc instead,
bnge_init_chip() failed the open.

Could the commit message describe the -EEXIST and dev_addr skip changes?
Could it also carry a Fixes: tag, so this can be considered for stable?

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index ac77ba813f01c..29a271f50e044 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -2058,6 +2063,12 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
>  		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
>  	} else {
>  		netdev_hw_addr_list_for_each(ha, uc) {
> +			/* dev_addr is already installed as L2 filter 0; a uc
> +			 * entry equal to it hashes to the same key and would be
> +			 * rejected as a duplicate, so skip it here.
> +			 */
> +			if (ether_addr_equal(ha->addr, dev->dev_addr))
> +				continue;

[Severity: Low]
Should the overflow check just above this loop also leave out the dev_addr
entry? It still counts every entry in uc:

	if (netdev_hw_addr_list_count(uc) > (BNGE_MAX_UC_ADDRS - 1)) {
		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;

uc_list has room for BNGE_MAX_UC_ADDRS - 1 entries, which is 3. A skipped
dev_addr entry now takes neither a uc_list slot nor an l2_filters[] slot.

Take uc = {dev_addr, A, B, C}. The check sees 4 > 3 and turns on
promiscuous mode, although A, B and C would fit in exact-match filters.

In that state uc_filter_count stays at 1. So in bnge_uc_list_updated(),
the first entry that is not dev_addr hits:

		if (count >= vnic->uc_filter_count - 1)
			return true;

As a result, every ndo_set_rx_mode call redoes the uc rebuild and the
promiscuous rx mask setup over HWRM.

The same input also went promiscuous before this patch. Back then,
though, dev_addr did take a slot, so the count and the fill loop agreed.

The fill and compare loops now count only entries that are not dev_addr.
Could the threshold count the same way?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com
