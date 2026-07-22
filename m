Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A736197A;
	Wed, 22 Jul 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735722; cv=none; b=raA7hVaGZX3TNcE1b9xCo6jYKuzpdnWCAaQ/AqXs5rMZnKIPs4MZiMhwlq2r5X286CzNuMOGxrr3GAXAVOk/YbMnNmfnJexGdVR/iRTVgawxXHx1UlulWfCLXodxiq3UyTNYdMPW0yHDnCDWjGp9SIy+izAnRzgZ8bv5P33EL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735722; c=relaxed/simple;
	bh=0a/FtB9FALMgp/J4S6ndcA1A2BqiBUp6NBxPyxyX78g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrczJ9aAkmmJiStfTgHOzDNJETyxnO6RBKQrtrMCSGueTqUzbYjbMb7dfzezGACYrfN+0/vpx959/PQE7GGSpOPOxRk5EiolkwimSKgeeBchFkRw/CK3LaWvDcghdCwXNsTEU3g3I/TsUUQ3abJDSmCfXjtLZUrnFlfQyODHhKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJn6B+hJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJn6B+hJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38CF1F000E9;
	Wed, 22 Jul 2026 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784735719;
	bh=dUefdxIhGJPfMY9ctPzkQiXm7IuDd5B49RvTH61on9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJn6B+hJ6f2flseBfXIcxxFZhrSpEStdni/pWR07W36aLwOy91ajf/caSrY8flKvv
	 Qvkaw8T3wqwO5ALivz7QhLzJgZs3AHOqsiKxrGwAMpiwexEXbO3LpH0V7MLb4ZB5yV
	 0+VUdhsjX0ATUF2kWElqoJeZnkvtuATSicgyrpbxNXPhw1iC58satCDdMWQNX0xmIY
	 cEEMHLhdQYN8LAMGd3mWJ+gm7kzQ85BqPYQNizupX3sx+8So+Naev8icM+HsCzmGQj
	 SZOtP2Y5yexU28hQjODIT3po7BkvysS/xCMfdfXIm6sAkODc3sDgnhqP1+5q1E+3Pt
	 3u/oy0p4BXpbA==
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
Subject: Re: [PATCH net-next v5 04/15] libie: add control queue support
Date: Wed, 22 Jul 2026 16:54:58 +0100
Message-ID: <20260722155458.538349-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715180042.1972010-5-anthony.l.nguyen@intel.com>
References: <20260715180042.1972010-5-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260715180042.1972010-2-anthony.l.nguyen@intel.com?part=4
---
--- Patch [4]: [PATCH net-next v5 04/15] libie: add control queue support ---
commit 1bdb26ce5f332eed97512271b4f8acb160c1f3d5
Author: Phani R Burra <phani.r.burra@intel.com>

libie: add control queue support

Libie will now support control queue setup and configuration APIs. These
are mainly used for mailbox communication between drivers and control
plane. Make use of the libeth_rx page pool support for managing controlq
buffers.

> diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
> new file mode 100644
> index 0000000000000..a3aa241f03b9a
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/libie/controlq.c
> @@ -96,30 +96,30 @@ int libie_ctlq_post_rx_buffs(struct libie_ctlq_info *ctlq)

[ ... ]

>  	while (num_to_post--) {
>  		dma_addr_t addr;
>  
>  		ctlq->descs[ntp] = (struct libie_ctlq_desc) {};
>  
>  		addr = libeth_rx_alloc(&fq, ntp);
>  		if (unlikely(addr == DMA_MAPPING_ERROR)) {
>  			ret = -ENOMEM;
>  			goto post_bufs;
>  		}
>  
>  		libie_ctlq_prep_rx_desc(&ctlq->descs[ntp], addr, fq.truesize);

[Severity: High]
Since libeth_rx_alloc() updates buf->truesize to reflect the actual space
available for DMA, should this use ctlq->rx_fqes[ntp].truesize instead of
the fixed fq.truesize? Using the fixed maximum size could allow the hardware
to DMA data beyond the allocated page pool buffer boundaries.

>  
>  		if (unlikely(++ntp == ctlq->ring_len))
>  			ntp = 0;
>  	}

[ ... ]

> @@ -478,13 +478,13 @@ u32 libie_ctlq_send_desc_avail(const struct libie_ctlq_info *ctlq)
>  {
>  	u32 ntu = ctlq->next_to_use, ntc = ctlq->next_to_clean;
>  
>  	return (ntc > ntu ? 0 : ctlq->ring_len) + ntc - ntu - 1;
>  }

[Severity: High]
Is there a missing API to reap TX completions? The available TX slots are
calculated based on next_to_clean, but there doesn't appear to be any
function provided to advance next_to_clean for TX queues. This would lead
to the TX queue eventually becoming permanently exhausted.

[ ... ]

> @@ -524,30 +524,30 @@ static void libie_ctlq_fill_rx_msg(struct libie_ctlq_msg *msg,
>  				   const struct libie_ctlq_desc *desc,
>  				    struct libeth_fqe *rx_buf)
>  {

[ ... ]

>  	if (likely(msg->data_len)) {
>  		if (unlikely(msg->data_len > LIBIE_CTLQ_MAX_BUF_LEN)) {
>  			msg->data_len = LIBIE_CTLQ_MAX_BUF_LEN;
>  			msg->chnl_retval = U32_MAX;
>  		}

[Severity: High]
Does this length validation need to check against the actual available space?
Checking against LIBIE_CTLQ_MAX_BUF_LEN instead of rx_buf->truesize could
lead to out-of-bounds CPU memory accesses when syncing and processing the
received data, as it might exceed what was actually allocated.

>  		msg->recv_mem = (struct kvec) {
>  			.iov_base = netmem_address(rx_buf->netmem) +
>  				    rx_buf->offset,
>  			.iov_len = msg->data_len,
>  		};

[Severity: High]
Can this virtual address calculation omit the page pool's p.offset?

In libeth_rx_alloc(), the DMA address correctly incorporates it:

	return page_pool_get_dma_addr_netmem(buf->netmem) + buf->offset +
	       fq->pp->p.offset;

If p.offset is non-zero in the page pool configuration, omitting it here
would result in reading from the wrong memory location, pointing prior to
the actual data payload.

>  		libeth_rx_sync_for_cpu(rx_buf, msg->data_len);
>  	} else {

[ ... ]

> @@ -584,20 +584,20 @@ u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,
>  		    u32 num_q_msg)
>  {
>  	u32 ntc, i;
>  
>  	ntc = ctlq->next_to_clean;
>  
>  	for (i = 0; i < num_q_msg; i++) {
>  		const struct libie_ctlq_desc *desc = &ctlq->descs[ntc];
>  		struct libeth_fqe *rx_buf = &ctlq->rx_fqes[ntc];

[Severity: High]
What happens if a caller attempts to use this function to reap completions
on a TX queue?

Since rx_fqes and tx_msg share a union in struct libie_ctlq_info:

	union {
		struct libeth_fqe		*rx_fqes;
		struct libie_ctlq_msg		**tx_msg;
	};

Blindly accessing rx_fqes without verifying the queue type would treat a
pointer to struct libie_ctlq_msg as a struct libeth_fqe, leading to
type confusion and wild pointer dereferences in libie_ctlq_fill_rx_msg().
