Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE913F23B7
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169569; cv=none; b=IJgu4xQfP3ApAu2NsywmQx8E91sJABTf8teEnEYCbKKy9lwl1fq9InVLq0XmrehpNPIaxO6wusiQgicAt+f+D/r22n6sMuWa3JEahA5Ul1iED4/VK5TJ4ne0ATeDnmrVz0zPtPfCbI8hxrla2p+DMK0G7hoLHlgZFk5P7oKi3VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169569; c=relaxed/simple;
	bh=tuRMfuqzjk3zPzc28TBPNvmeE9sXe5PtWX66GxtjSH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULlrAjUgwnQsSiNrFOrwpW0aj0Jja0FFcYTnoJYEbvK4NrLtr3wf3LDUvRc4Sx6osx3+riM/kjamcpnbRNHAqWabVI+23tJA4pl2/3kRQcMi3lUwKeyL2OXLjwtfONzC9M99djbT/GnHzhSDyF9oOjZdq8q7XvOrzzKBs2Gqhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edo0/JyA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edo0/JyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F8CC2BCB2;
	Thu,  7 May 2026 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169569;
	bh=tuRMfuqzjk3zPzc28TBPNvmeE9sXe5PtWX66GxtjSH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edo0/JyA1/F4UzPQIZ94UM2fM7lBzByJCx6Hlolq8WhOyvBrHcGqzv/9vNbfgCJKm
	 cacW/zNeoUYK5CORqh71zGbrGt4qEB9udqLFr+xeLSRVvh58ulQVMz98HagBZGpqN0
	 hDfE1w5AN+w2MDCje23ITI1m6LXZnwTm3zu5g/85hqvGyZKkFSd1Cq69T0VpnTFR8F
	 pCdLvDlCUAGwjvF8CjJA0gdhv01nP6OEMAb/6KAInX5drzQYbVjOxFBy3lurE7sWMw
	 NY/hcHmLHLRA4dXGOcRtGks+L8+rxkJkrdU7xtWE4K8exm89q2eW6/CGLcQgg4B57v
	 Hvl8BApsCjUPA==
From: Jakub Kicinski <kuba@kernel.org>
To: eric.joyner@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	prabu.ponrajthayalan@amd.com
Subject: Re: [PATCH net v2 5/5] ionic: fix completion descriptor access with 2x desc size
Date: Thu,  7 May 2026 08:59:28 -0700
Message-ID: <20260507155928.2537928-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506035706.12373-6-eric.joyner@amd.com>
References: <20260506035706.12373-6-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ionic: fix completion descriptor access with 2x desc size

This commit fixes completion descriptor access when the IONIC_Q_F_2X_CQ_DESC
flag is set. It introduces pointer arithmetic to correctly calculate the
offset of the 32-byte completion descriptor slot.

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
[ ... ]
> @@ -729,7 +725,12 @@ static bool __ionic_rx_service(struct ionic_cq *cq, struct bpf_prog *xdp_prog)
>  	struct ionic_queue *q = cq->bound_q;
>  	struct ionic_rxq_comp *comp;
>  
> -	comp = &((struct ionic_rxq_comp *)cq->base)[cq->tail_idx];
> +	if (likely(cq->desc_size == sizeof(*comp)))
> +		comp = &((struct ionic_rxq_comp *)cq->base)[cq->tail_idx];
> +	else
> +		comp = cq->base +
> +		       cq->desc_size * cq->tail_idx +
> +		       cq->desc_size - sizeof(*comp);
>  
>  	if (!color_match(comp->pkt_type_color, cq->done_color))
>  		return false;

This is a pre-existing issue, but since the descriptor access is being
modified here, should there be a dma_rmb() after the color_match() check?

Without a read memory barrier, weakly-ordered CPU architectures might
speculatively read other fields of the descriptor from memory before checking
the color bit. This could result in processing stale data from the previous
ring cycle.

[ ... ]
> @@ -1244,7 +1240,12 @@ static bool ionic_tx_service(struct ionic_cq *cq,
>  	unsigned int pkts = 0;
>  	u16 index;
>  
> -	comp = &((struct ionic_txq_comp *)cq->base)[cq->tail_idx];
> +	if (likely(cq->desc_size == sizeof(*comp)))
> +		comp = &((struct ionic_txq_comp *)cq->base)[cq->tail_idx];
> +	else
> +		comp = cq->base +
> +		       cq->desc_size * cq->tail_idx +
> +		       cq->desc_size - sizeof(*comp);
>  
>  	if (!color_match(comp->color, cq->done_color))
>  		return false;

Does this color_match() check also need a dma_rmb() immediately following it
to prevent stale descriptor reads on the transmit side?
