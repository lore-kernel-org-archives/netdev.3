Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666ED4BD0F1;
	Thu, 24 Sep 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269669; cv=none; b=V8Joa358LKaM/UOqIS62ZyxMXp8qwIdlmeCKSgMzHTl4gcpCsveKsyV9kuxs0ELlGGB7gep19p7PiViage8+PboACnThajyMwBtWHAIcx9551JhFgGPo2U98LOxcbQc2BDob+OzK5bunJkFq89CDuulWZmxPyPaVW8jiGPqHYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269669; c=relaxed/simple;
	bh=AiH9cFIWHVD4prFhgPMfQvZab9ExT+8eOmoaNVDyePc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SLFkukAFx0nLFdyehIvXszl2wZ6x5ajHidXgadiafAoMFDTYxgKKG29M5iC71lXGfDa4sRj6eWnpZkWIE+Ftt2oKo8PIJIbz00gXQvI3HNNwUabsVsgP0A7xHr8AgcZvQc4xDbTOw6bpsX2YUb5AR90lxpdt6AMfcMBU50FnXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZxQlQQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZxQlQQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA7D1F000FF;
	Thu, 24 Sep 2026 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269668;
	bh=wyXJMtH/Jv3R/bYoJWwyQ2UaEckkFA30XCVmg+XBN9w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PZxQlQQ/+32WyfDs0krI7ByxXyrs6vgH6PP5AT1MfNKqosty+amp+3zJ9O564XwVN
	 11myADxx0F6Ugz7Ae/FeoI9sG5u1cdevLUdyZw5Xm56TXe09IIwU8P4G69juiNG0Az
	 KvPStqoYssP5lfrpGxYBOUd+3HAIPTdCXgjDKxaDfPTw7KNl3vpX/RzWzAHCamJBAI
	 oiyk8Dy1cAV2KLEs5uo8e89brETfLNhnaBDaS0tvCs1MQs28w7nHFCNReWF5BuRwbY
	 xHRd8Xs0m/qauzUuIUKG7PzZe2trz4Vm8Ey4l3NPGna+WYgllupvkL/9A3LkwL4850
	 EEtREpSldYlUg==
Subject: Re: [PATCH net-next v2 1/6] bnge: Extract bnapi allocation and
 cleanup into helpers
From: netdev-bot+sashiko@kernel.org
To: bhargava.marreddy@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 dharmender.garg@broadcom.com
Date: Thu, 24 Sep 2026 17:07:47 +0000
Message-ID: <179026966721.2160803.3672240762098051468@kernel.org>
In-Reply-To: <20260922052904.59237-2-bhargava.marreddy@broadcom.com>
References: <20260922052904.59237-2-bhargava.marreddy@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes the three new NULL guards as
  preparatory hardening ("add NULL guards for rx_ring and tx_ring in…

--

bnge: Extract bnapi allocation and cleanup into helpers

This moves the bn->bnapi allocation and free code out of
bnge_alloc_core()/bnge_free_core() into bnge_alloc_bnapi_mem() and
bnge_free_bnapi_mem(), and adds NULL checks for bn->rx_ring and
bn->tx_ring in the ring cleanup helpers.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index a4288f0258f87..c1810a3098883 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -825,6 +825,9 @@ static void bnge_free_tpa_info(struct bnge_net *bn)
>  	struct bnge_dev *bd = bn->bd;
>  	int i, j;
>  
> +	if (!bn->rx_ring)
> +		return;
> +
>  	for (i = 0; i < bd->rx_nr_rings; i++) {
>  		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
>  
> @@ -881,6 +884,9 @@ static void bnge_free_rx_rings(struct bnge_net *bn)
>  	struct bnge_dev *bd = bn->bd;
>  	int i;
>  
> +	if (!bn->rx_ring)
> +		return;
> +
>  	bnge_free_tpa_info(bn);
>  	for (i = 0; i < bd->rx_nr_rings; i++) {
>  		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
> @@ -1024,6 +1030,9 @@ static void bnge_free_tx_rings(struct bnge_net *bn)
>  	struct bnge_dev *bd = bn->bd;
>  	int i;
>  
> +	if (!bn->tx_ring)
> +		return;
> +

[Severity: Medium]
Are these three new NULL checks really just preparation, or do they fix a
reachable NULL pointer dereference that exists today?

The commit message says only:

    Prepare the driver to move bnapi allocation out of the open/close path,
    and add NULL guards for rx_ring and tx_ring in core driver cleanup paths.

Before this patch, bnge_alloc_core() allocates bn->bnapi, then bn->rx_ring,
then bn->tx_ring, and every failure goes to err_free_core: which calls
bnge_free_core(). bnge_free_core() unconditionally calls
bnge_free_tx_rings() and bnge_free_rx_rings(), so if the bn->rx_ring
allocation fails both pointers are still NULL:

drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:bnge_free_tx_rings() {
	for (i = 0; i < bd->tx_nr_rings; i++) {
		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
		...
		bnge_free_ring(bd, &ring->ring_mem);
}

and bnge_free_ring() dereferences that near-NULL address right away:

drivers/net/ethernet/broadcom/bnge/bnge_rmem.c:bnge_free_ring() {
	if (!rmem->pg_arr)
		goto skip_pages;

The rx side looks the same: bnge_free_rx_rings() -> bnge_free_tpa_info()
reads rxr->rx_tpa_idx_map, and bnge_free_rx_rings() itself calls
page_pool_destroy(rxr->page_pool), both off a NULL bn->rx_ring.

Since bnge_alloc_core() runs from the ndo_open path, an allocation failure
during "ip link set dev ethX up" would oops instead of returning -ENOMEM.
git blame points the affected loops at commit 0259379037cab9 ("bng_en: Add
initial support for RX and TX rings"). Would it make sense to split these
guards into their own patch with a Fixes: 0259379037cab9 tag, so it can be
picked up for stable? No commit in this series (10cfa109c8..63494c308b19)
carries such a tag or mentions the crash.

Note that bnge_free_rx_ring_pair_bufs() already had the same
if (!bn->rx_ring) return; check, which suggests the guard is functional
rather than cosmetic.

>  	for (i = 0; i < bd->tx_nr_rings; i++) {
>  		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
>  		struct bnge_ring_struct *ring;

[ ... ]

> @@ -1241,6 +1254,19 @@ static int bnge_alloc_core(struct bnge_net *bn)
>  		nqr->ring_struct.ring_mem.flags = BNGE_RMEM_RING_PTE_FLAG;
>  	}
>  
> +	return 0;
> +}
> +
> +static int bnge_alloc_core(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int i, j, rc;
> +
> +	rc = bnge_alloc_bnapi_mem(bn);
> +	if (rc)
> +		return rc;
> +
> +	rc = -ENOMEM;
>  	bn->rx_ring = kzalloc_objs(struct bnge_rx_ring_info, bd->rx_nr_rings);
>  	if (!bn->rx_ring)
>  		goto err_free_core;

This is the branch that reaches bnge_free_core() with both bn->rx_ring and
bn->tx_ring still NULL.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922052904.59237-1-bhargava.marreddy%40broadcom.com
