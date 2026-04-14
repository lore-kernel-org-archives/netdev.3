Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C803AE71E
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173382; cv=none; b=IGSCrgPt2e0E2+8VmWl6PcNyngYO5mR6BUk6botmsxIU5yzK5d7wr6tKlA6rsnwonhVYy+VUXWnpIzJ1nP/2dSkpvFTnLoHEOKaREQfJnQvUl4OHDXgHk24w2vhu8ZCCAAa4WsGitjIN8BBZBvQ3aZySzeSXsA49D9xEI/Oa9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173382; c=relaxed/simple;
	bh=zsM9dsmbiVIJiMJTT1sM6WsEpvpqK7LiJCBq22uxOaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6ykiSMPHQ0jgLw9sHsGY2end6GPfvRfShlVYNtYvg5QSaHRn2Kij9wW9Q9ogfyGYx3DQNSRvXDZpFNrq8qPtxcIhG86lX15KcUsmjKGRUyY2l/U1yHtlP3udZBbkF9/amC9uMgISK5p2AXmjx1G7QBFcOjoWtMmKrCCJWnRxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NalWhCba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NalWhCba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12FAC19425;
	Tue, 14 Apr 2026 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173382;
	bh=zsM9dsmbiVIJiMJTT1sM6WsEpvpqK7LiJCBq22uxOaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NalWhCbatjG5CCe9zEOfzvQ6CwSNVjaRgaJsc9Tm711uhDIGZcyTZn4II5KkvFpS3
	 2H+1X/8DetWwTUR3wC9hoyAdqqaXOdDFbEYGom73iFMgbOlHgx8OirRDvqpa0Ss0S2
	 gqnteCD1SICL7mKDIBfXBJ5lZ1twHnbJ8NB1PmNsIHHtbdOL5GXCa+8I6RcInEez27
	 +Er8RcY1CXmxYEIZRXWBrYR/Mtgfn8DMXQb2SRuTuoBUq7Uz1JaApKgQ3Oln6ZDO+y
	 MjAapKJHTh7BFE2/6K558x7kZRDW81nOSeMn4T0bhke9oXpuI0KnHZduvV0p4e3c5Y
	 XSSlReAnvMArw==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	marcin.szycik@linux.intel.com,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 7/8] ixgbe: use GFP_KERNEL in ixgbe_fcoe_ddp_setup()
Date: Tue, 14 Apr 2026 14:29:35 +0100
Message-ID: <20260414132935.757593-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408131216.2662245-8-aleksandr.loktionov@intel.com>
References: <20260408131216.2662245-8-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ixgbe: use GFP_KERNEL in ixgbe_fcoe_ddp_setup()

This commit restructures ixgbe_fcoe_ddp_setup() to use GFP_KERNEL
instead of GFP_ATOMIC by splitting get_cpu()/put_cpu() usage into two
narrow critical sections, moving DMA mapping and pool allocation between
them where preemption is enabled.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> index 011fda9c6193..e338ff0e6522 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c

[ ... ]

> @@ -179,29 +180,43 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
>  		return 0;
>  	}
>
> +	/* Pin to current CPU only to read the per-CPU pool pointer; drop
> +	 * the pin before any allocations that may sleep under direct reclaim.
> +	 */
>  	ddp_pool = per_cpu_ptr(fcoe->ddp_pool, get_cpu());
>  	if (!ddp_pool->pool) {
>  		e_warn(drv, "xid=0x%x no ddp pool for fcoe\n", xid);
> -		goto out_noddp;
> +		put_cpu();
> +		return 0;
>  	}
> +	pool = ddp_pool->pool;
> +	put_cpu();
>
>  	/* setup dma from scsi command sgl */
>  	dmacount = dma_map_sg(&adapter->pdev->dev, sgl, sgc, DMA_FROM_DEVICE);
>  	if (dmacount == 0) {
>  		e_err(drv, "xid 0x%x DMA map error\n", xid);
> -		goto out_noddp;
> +		return 0;
>  	}
>
> -	/* alloc the udl from per cpu ddp pool */
> -	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_ATOMIC, &ddp->udp);
> +	/* Allocate from per-CPU pool; GFP_KERNEL is safe: preemption is
> +	 * re-enabled after the put_cpu() above.  Per-CPU DMA pools are only
> +	 * destroyed under RTNL during interface teardown, so the saved pool
> +	 * pointer remains valid.
> +	 */
> +	ddp->udl = dma_pool_alloc(pool, GFP_KERNEL, &ddp->udp);

Is this safe given the calling context?

Looking at the call path from the FCoE stack:

fc_exch_seq_send()
  fc_exch_alloc()
    fc_exch_em_alloc()
      spin_lock_bh(&pool->lock)
      # allocate exchange
      # set ep->ex_lock = held
      return with ep->ex_lock still held
  fc_fcp_ddp_setup()
    lport->tt.ddp_setup()
      .ndo_fcoe_ddp_setup() == ixgbe_fcoe_ddp_get()
        ixgbe_fcoe_ddp_setup()  # <-- we are here
  # ... continues with ep->ex_lock held
  spin_unlock_bh(&ep->ex_lock)

fc_exch_em_alloc() acquires ep->ex_lock (a spinlock) and returns with
it held. The lock remains held through fc_fcp_ddp_setup() and into
ixgbe_fcoe_ddp_setup(). Additionally, spin_lock_bh() disables bottom
halves.

Can GFP_KERNEL be used while holding ep->ex_lock with BH disabled, or
does this require GFP_ATOMIC?
