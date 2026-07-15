Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E28481250
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136201; cv=none; b=LaLHlvvs9N2q0jzgQ8HzkaiMHCYkP+OgeW8vqXkhg/4cqaDYSg20SNwXB/zdMT+L30SfxhoKBomcXLLjVzEfqv9CkFeUAB+VfvtXUgukXXAKCfdScsL4RsQriCmBuOYSaO62VmjvSIizx0oBYRMx4A3MhklZ5bdr5oXImkVo/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136201; c=relaxed/simple;
	bh=T32ieNcWNOOhdix6IYwpq76c/8S7NsOsGMYaEilOXi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myz9cYNNZzc7duGa9rHdcr0EqgyCZkTNuXxRX7lIl2Ex+YEw6b8Sx/J0d+gU8o8nAnpfUaFQ9NHtR/ZEiivUFv6G/QL31s7Dr4Py4mhIDHf1ntMvj0NcIRtrn+jI55Vbdj+mXVuZFUs2QzNUSKo/cXcCxmCkYxgVLGgQDyBUiJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzABgkO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzABgkO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6371F000E9;
	Wed, 15 Jul 2026 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784136196;
	bh=Cu9Ng29KbrpsgUJXgAzfzTzIdGAe2OnG6Df0Rz74Wo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HzABgkO0JrF0jaE6YwlUenhPBBENFGe+ZSza2/DuTdcPHW3ez1KVsu3O6Z0NrU4x8
	 liQ02LtS/zGpMrIrQUR78jffayKK+RZENuZn8v5E8RHjCq1u66lAnnqhPDwSPuFyQr
	 Lob153ndlHR0yNsESE/m944oKsQicayh2pEkHAXKlRqFSsXu6t0mMzkAn8f+AGyySl
	 o+5FU71B56RknZ/JH4xIcpbVPGt+mPArriQ0SB/1S1y+dLV8YZ6v3v/BiS70we03q5
	 gT8ZlHkvR3zlCA5kkipyEt2Pa91aktzuokMo7oRstVvxW6eQidHamGKx40fLjr4GF2
	 noErfK16FRJKg==
From: Simon Horman <horms@kernel.org>
To: harshitha.vr@chelsio.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	bharat@chelsio.com
Subject: Re: [PATCH net] cxgb4: consider EtherType when validating filter priority ordering
Date: Wed, 15 Jul 2026 18:23:03 +0100
Message-ID: <20260715172302.124955-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708131650.14747-1-harshitha.vr@chelsio.com>
References: <20260708131650.14747-1-harshitha.vr@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://netdev-ai.bots.linux.dev/sashiko/
---
cxgb4: consider EtherType when validating filter priority ordering

The commit relaxes cxgb4_filter_prio_in_range() so that neighbouring
filters with a different matched EtherType no longer block insertion of
a new filter. Both the callee and cxgb4_get_free_ftid() gain a new
ethtype argument, and callers in the tc flower, matchall, and u32 paths
are updated accordingly.

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
> index 657d96b9e2f6..8462455d9330 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c

[ ... ]

> @@ -536,15 +536,24 @@ static bool cxgb4_filter_prio_in_range(struct tid_info *t, u32 idx, u8 nslots,
>  	if (!prev_fe->fs.type)
>  		prev_fe = &prev_tab[prev_ftid];
>  
> -	if ((prev_fe->valid && prev_fe->fs.tc_prio > prio) ||
> -	    (next_fe->valid && next_fe->fs.tc_prio < prio))
> +	/* Filters with different EtherTypes can never match the same
> +	 * packet, so skip the priority check between them.
> +	 */
> +	if (prev_fe->valid && prev_fe->fs.tc_prio > prio &&
> +	    (!prev_fe->fs.mask.ethtype || !ethtype ||
> +	     prev_fe->fs.val.ethtype == ethtype))
> +		return false;
> +
> +	if (next_fe->valid && next_fe->fs.tc_prio < prio &&
> +	    (!next_fe->fs.mask.ethtype || !ethtype ||
> +	     next_fe->fs.val.ethtype == ethtype))
>  		return false;

[Low]
Does this comparison handle neighbouring filters that use a partial
ethtype mask?

The check treats two filters as targeting different EtherTypes when
prev_fe->fs.val.ethtype != ethtype, but it consults only the neighbour's
mask and never the new filter's mask. If a neighbour is inserted with,
for example, val.ethtype = 0x0801 and mask.ethtype = 0xFFFF, and the new
filter is inserted with val.ethtype = 0x0800 and (a hypothetically
propagated) mask.ethtype = 0xFF00, both filters can in principle match a
packet with EtherType 0x0801, yet the equality test 0x0801 == 0x0800
evaluates false and permits an out-of-order insertion.

A masked form such as:

    ((prev_fe->fs.val.ethtype ^ new_val) &
     prev_fe->fs.mask.ethtype & new_mask) == 0

would cover partial masks, but the current cxgb4_get_free_ftid() API
only carries the new filter's ethtype value and not its mask, so a
masked check cannot be expressed. Was the partial-mask case considered,
and should the new argument include the mask as well?

> +		return false;
> +
>  	return true;
>  }
>  
>  int cxgb4_get_free_ftid(struct net_device *dev, u8 family, bool hash_en,
> -			u32 tc_prio)
> +			u32 tc_prio, u32 ethtype)
>  {

[ ... ]

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> index 3307e5042681..07d9170cdb6f 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> @@ -885,8 +885,8 @@ int cxgb4_flow_rule_replace(struct net_device *dev, struct flow_rule *rule,
>  	 * rule. Only insert rule if its prio doesn't conflict with
>  	 * existing rules.
>  	 */
> -	fidx = cxgb4_get_free_ftid(dev, inet_family, fs->hash,
> -				   tc_prio);
> +	fidx = cxgb4_get_free_ftid(dev, inet_family, fs->hash, tc_prio,
> +				   fs->mask.ethtype ? fs->val.ethtype : 0);

Related to the question above: the caller here discards fs->mask.ethtype
before it reaches cxgb4_filter_prio_in_range(), so a new filter with a
partial ethtype mask is compared as if its value were fully specified.
Is that intentional, or should the mask be plumbed through as well?
