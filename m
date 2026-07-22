Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCFC35837C;
	Wed, 22 Jul 2026 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736985; cv=none; b=d7Aak+Wh3JFphRvlNbFCi8vHOBq2SfYm+gfZIKu4T8onVbZPRdiyKDbLkheI7FdMLJslm9i55hINrMFyIIyuqGSlNXr0e9yPBPkQd5EaHmF2bJxaXrUSioC5qmoML40JhOalkFuXi0Zs7h3dpfYJxQOU62qD/EOdQFEoZVKg6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736985; c=relaxed/simple;
	bh=/Zcjto8xP9EvdxXT7mM1A5K0aW+GmHBjYLWG40Q6YJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1HT7JYcSXRa3xTP/RRXF6OuIGUjez17btGNdWBhl7XKuSoIy7ixIbBLU1gUjOyZEM0bkKs92of0h9x5kCe3dwgsONbyf5SmbRjbz6vhe/SM/+vc2BCHv1/nWMug0IgFbgMMMurPobJ4DjAm16CQ52z8ZumhFUK7G7dpQOXb/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1t0o38M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1t0o38M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C5B1F000E9;
	Wed, 22 Jul 2026 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736983;
	bh=QhJ/EAHFRirVf4HqrZszcfdFB0neAZ7q25qE3L8HUXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1t0o38M3aQ8BsBYeYurv9RTl5wnu6eT4ygJBvzR9fZV1tu3dy5QvknioOZAG+XFF
	 77tvZLIGL51sC0HuM1xrpzOiqeYPG+O5fvis/Fs8rm10Wb9HNJQ1dbubpTm+OCJL4T
	 XAccWYccsTCjmCAedb8jSn4k4ATac0hfKzAin3E9DGh2kt2Wr6sCbYX3gD9YBY52IQ
	 vaZ9OeLbt4EXhAvxs4E87lkspxcOyPkf7BsTVkAZoj6kfCCuXrI4tyhMWGx7srvnT2
	 5tQfWSSfUaPOc+7Nd3gpjjedRxtPt5G8p+Q2J4c9RpwYotl8MuijXi5kh+Ixf7GzEY
	 cEOHgWL4ASsXQ==
From: Simon Horman <horms@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	corbet@lwn.net,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Bharath.r@intel.com
Subject: Re: [PATCH net-next v5 09/15] idpf: refactor idpf to use libie control queues
Date: Wed, 22 Jul 2026 17:16:09 +0100
Message-ID: <20260722161609.543609-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715180042.1972010-10-anthony.l.nguyen@intel.com>
References: <20260715180042.1972010-10-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260715180042.1972010-2-anthony.l.nguyen@intel.com?part=9
---
--- Patch [9]: [PATCH net-next v5 09/15] idpf: refactor idpf to use libie control queues ---
commit 06a0b55dccd2a8bd004309d725e04b4253d24231
Author: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: idpf: refactor idpf to use libie control queues

This commit refactors the idpf driver to use the libie control queue
APIs for initializing, configuring, and managing control queue
transactions. It replaces the local control queue implementation with
libie equivalents, which introduces DMA mapping of send buffers rather
than performing memory copies.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c

[ ... ]

> -static int idpf_mb_clean(struct idpf_adapter *adapter,
> -			 struct idpf_ctlq_info *asq)
> +static void idpf_mb_clean(struct idpf_adapter *adapter,
> +			  struct libie_ctlq_info *asq, bool deinit)
>  {
> -	u16 i, num_q_msg = IDPF_DFLT_MBX_Q_LEN;
> -	struct idpf_ctlq_msg **q_msg;
> -	struct idpf_dma_mem *dma_mem;
> -	int err;
> -
> -	q_msg = kzalloc_objs(struct idpf_ctlq_msg *, num_q_msg, GFP_ATOMIC);
> -	if (!q_msg)
> -		return -ENOMEM;
> -
> -	err = idpf_ctlq_clean_sq(asq, &num_q_msg, q_msg);
> -	if (err)
> -		goto err_kfree;
> -
> -	for (i = 0; i < num_q_msg; i++) {
> -		if (!q_msg[i])
> -			continue;
> -		dma_mem = q_msg[i]->ctx.indirect.payload;
> -		if (dma_mem)
> -			dma_free_coherent(&adapter->pdev->dev, dma_mem->size,
> -					  dma_mem->va, dma_mem->pa);
> -		kfree(q_msg[i]);
> -		kfree(dma_mem);
> -	}
> -
> -err_kfree:
> -	kfree(q_msg);
> +	struct libie_ctlq_xn_clean_params clean_params = {
> +		.ctlq		= asq,
> +		.rel_tx_buf	= kfree,
> +		.num_msgs	= IDPF_DFLT_MBX_Q_LEN,
> +		.force		= deinit,
> +	};
>  
> -	return err;
> +	libie_ctlq_xn_send_clean(&clean_params);
>  }

[Severity: Medium]
Does setting force = deinit here cause a memory leak when encountering
zero-length messages?

If a zero-length payload message (like a VF reset message) is enqueued
followed by a non-zero length message, libie_ctlq_xn_send_clean evaluates
the loop break condition on the zero-length payload. If the condition
!(params->force && msg->data_len) evaluates to true due to data_len being 0,
the cleanup loop terminates early.

Could this cause any subsequent pending messages in the queue to be skipped,
leaking their DMA mappings during a teardown path?

[ ... ]

> +void idpf_send_vf_reset_msg(struct idpf_adapter *adapter)
> +{
> +	struct libie_ctlq_info *ctlq = adapter->asq;
> +
> +	/* Forcefully claim send queue slot */
> +	idpf_mb_clean(adapter, ctlq, true);

[Severity: High]
Could this forceful cleanup unmap DMA buffers that the hardware is still
actively reading?

During driver unload or VF reset, the hardware is still active since the
reset message hasn't been sent yet. Calling idpf_mb_clean with deinit=true
bypasses the hardware Done check for non-empty messages and immediately
unmaps their DMA buffers.

Can this lead to a DMA use-after-free and trigger IOMMU faults if the
hardware attempts to read the unmapped buffers?

> +
> +	scoped_guard(spinlock, &ctlq->lock) {
> +		*ctlq->tx_msg[ctlq->next_to_use] = (struct libie_ctlq_msg) {
> +			.opcode = LIBIE_CTLQ_SEND_MSG_TO_CP,
> +			.chnl_opcode = VIRTCHNL2_OP_RESET_VF,
> +		};
> +
> +		libie_ctlq_send(adapter->asq, 1);
> +	}
> +}
