Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A036C0DC
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063902; cv=none; b=V6TEOntTzojbEpCBTll/KHIlfzXmPubJgmsOs7lwhcjhUzOCOTrXubZCI41TQjQmxRwWT594F0CR5Lfbxs4NYZ62ICH7k4Q3t4xYpw1vZ8nSnzqvkzdokddtKXmWYU/8/mYnNcgRhpCK0frmUIIcODq+s6UqmrYLND5Wm98E0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063902; c=relaxed/simple;
	bh=iyUc74jc7ijhJLP8ajSR5KxWJEu21n/mJLzUQBETAuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pd8qA5dKpxWYv/ejOdWcthsDmljFKmWGulserh9Lp3jYlYsDGB4074jNXilr6VPs4VdSddPDmy8+kct2W2BLqiKqGzuOmL0h/2aiD7U3b2P8GvRJQgWw+S759tsCmFzV7lyJ2tBab7QEXBdEY4KmeX6wfUOR5OkhrjNW8zQcyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SD1H/G79; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SD1H/G79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783063900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9qWaa01/loIDeDsav1zvvi7/neNywYF4ga0f9wYthg=;
	b=SD1H/G79P99cfV/EyE57GlECZi2C/Xci4CE0t1kI6bHeChlgEHOek2rKN2D8JGnsFMEv+c
	cKFByJPL1O5m5jNg8rW1AJx48CMAOZhvGpn081mwf/6xx+K0I57F5UiuWcdPW4Rt62E9cl
	o7k0zZ+n75MgunRU96/+EbJFRPbiRA4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-V3llTC7ENlSuT51gjn2ADg-1; Fri,
 03 Jul 2026 03:31:36 -0400
X-MC-Unique: V3llTC7ENlSuT51gjn2ADg-1
X-Mimecast-MFC-AGG-ID: V3llTC7ENlSuT51gjn2ADg_1783063895
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BBB81944F00;
	Fri,  3 Jul 2026 07:31:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.68])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 576431944DFC;
	Fri,  3 Jul 2026 07:31:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: j.raczynski@samsung.com
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org,
	k.tegowski@samsung.com,
	k.domagalski@samsung.com,
	yashwant.v@samsung.com
Subject: Re: [PATCH net] net/stmmac: Set Rx queue page_pool to NULL when freeing DMA resources
Date: Fri,  3 Jul 2026 09:26:51 +0200
Message-ID: <20260703072651.110614-1-pabeni@redhat.com>
In-Reply-To: <20260630100953.747868-1-j.raczynski@samsung.com>
References: <20260630100953.747868-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net/stmmac: Set Rx queue page_pool to NULL when freeing DMA resources

This patch makes __free_dma_rx_desc_resources() clear rx_q->page_pool
after destroying it, to avoid a kernel panic if a subsequent
reinitialization triggers another teardown while page_pool_create()
fails in __alloc_dma_rx_desc_resources().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2a0d7eff88d3..6cc5a3496f39 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2172,8 +2172,10 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
>  		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
>  
>  	kfree(rx_q->buf_pool);
> -	if (rx_q->page_pool)
> +	if (rx_q->page_pool) {
>  		page_pool_destroy(rx_q->page_pool);
> +		rx_q->page_pool = NULL;
> +	}
>  }

[High]
Does this fix leave the other resources in __free_dma_rx_desc_resources()
exposed to the same crash class the commit message describes?

The same teardown function also frees rx_q->buf_pool, rx_q->dma_rx (or
rx_q->dma_erx), and uses rx_q->dma_rx_phy without ever clearing any of
those pointers:

    static void __free_dma_rx_desc_resources(...)
    {
        ...
        if (rx_q->xsk_pool)
            dma_free_rx_xskbufs(priv, dma_conf, queue);
        else
            dma_free_rx_skbufs(priv, dma_conf, queue);
        ...
        if (priv->extend_desc)
            addr = rx_q->dma_erx;
        else
            addr = rx_q->dma_rx;

        size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;

        dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
        ...
        kfree(rx_q->buf_pool);
        if (rx_q->page_pool) {
            page_pool_destroy(rx_q->page_pool);
            rx_q->page_pool = NULL;
        }
    }

Consider the same failure scenario the commit message names (a
page_pool_create() failure during reinitialization), but applied to a
later queue.

After ifdown, __free_dma_rx_desc_resources() has run on every queue and
buf_pool, dma_rx/dma_erx, and dma_rx_phy are all stale dangling values
on every queue.

On ifup, __alloc_dma_rx_desc_resources() begins assigning fresh pointers
queue by queue:

    rx_q->page_pool = page_pool_create(&pp_params);
    if (IS_ERR(rx_q->page_pool)) {
        ret = PTR_ERR(rx_q->page_pool);
        rx_q->page_pool = NULL;
        return ret;
    }

    rx_q->buf_pool = kzalloc_objs(*rx_q->buf_pool, ...);
    ...
    addr = dma_alloc_coherent(priv->device, size, &rx_q->dma_rx_phy, ...);
    ...

If page_pool_create() fails on queue Q, the rollback in
alloc_dma_rx_desc_resources():

    err_dma:
        free_dma_rx_desc_resources(priv, dma_conf);

walks every queue including Q+1..N-1, where buf_pool, dma_rx/dma_erx and
dma_rx_phy still hold the stale values left behind by the prior
__free_dma_rx_desc_resources() call.

Does __free_dma_rx_desc_resources() on those queues then:

  - read rx_q->buf_pool[i] in dma_free_rx_skbufs() ->
    stmmac_free_rx_buffer() from already-freed slab memory:

        static void stmmac_free_rx_buffer(...)
        {
            struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
            if (buf->page)
                page_pool_put_full_page(rx_q->page_pool, buf->page, false);
            ...
        }

  - call dma_free_coherent() a second time on the stale
    rx_q->dma_rx/dma_erx and rx_q->dma_rx_phy?

  - call kfree() a second time on the stale rx_q->buf_pool?

Would also nulling rx_q->buf_pool, rx_q->dma_rx, rx_q->dma_erx, and
rx_q->dma_rx_phy in __free_dma_rx_desc_resources() (or having the alloc
path defensively reset them before any early return) be appropriate to
cover the same failure mode the commit message describes?
-- 
This is an AI-generated review.

