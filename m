Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9F3E274B
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033616; cv=none; b=DJwqaMImMMDA2/OEGsemNz/JwOjsk/FhEFILuh8OOakWZVYV5t4PoAbwcx9Jl9mK1UbSNCyvU8EkxuJjXW8nSQdGRnSctEVzyhxdLTvZoXJMulzh/4WOFqVEGxHGetxQAGvlNSKcImJyAvaepN8VIFWNDANGkU8dD9h+p1Rnmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033616; c=relaxed/simple;
	bh=PY769dikClxRKUlT8JTWcKWeNDJivOIMFzPkL9Y7A2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=likbhicn4LgmGxQhtnBnbw2ok348RW31fhykTabjRvdYajj0kB9a6u4LeD8OA0IuTxTBFMMOPgnwQI9N2wy7VtdmFkwNqgenUiWiP5foTybDLLKmPUpVBmrCiaY/3PEoiTVsUjkfAgeczoAoXdX4CYW7y6C1hF3N96IKDzVzMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp1gA8pc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp1gA8pc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C61A1F000E9;
	Tue, 14 Jul 2026 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784033614;
	bh=EMkk7CFtTQcIlGBgRJv9LJja2Ycb8KtPZthsLBihCqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mp1gA8pcEahDgKIw5Qycwx1OZhwPqMMHSLJDxBv34rD0UuhlBfQtwFpEQoPVo6gku
	 uqt+ZMqIP5XkisRmSdtm6/xzqApyhmIHEpe90NFHOMTXrO1x6b9aIcWsV1A1KF294B
	 VFUHiOwdHS6LuKMmCMB0Ye9GN0MppyxqMN3V3HazkKG2kHkJa110+vIXUBYzcrcXt8
	 1vpz4kbhL2Rgse4UrRmo8/0r0X2feCODsp4CFrq8UyzqB/+zDrG+3fnUwx2QltcpmF
	 pKpwWaAW1Vy08yjxHnlLHsRUiUZsF5eoQxtjpnroOu8ZG9jC/muelTwG6fXtd+uv46
	 2T99lTU53CcrA==
From: Simon Horman <horms@kernel.org>
To: mmc@linux.ibm.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v3 09/15] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Tue, 14 Jul 2026 13:50:20 +0100
Message-ID: <20260714125019.1833862-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-10-mmc@linux.ibm.com>
References: <20260706193603.8039-10-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ibmveth: Add queue-aware RX buffer submit helper for MQ

This patch updates the ibmveth driver's buffer replenishment path to
be queue-aware for multi-queue receive support. It adds a helper to select
the correct hypervisor call and handles fallback to single-buffer mode if
batch operations are unsupported.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index fa2d4777ffc7b..b3b3886c3eedb 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -597,11 +597,73 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)

[ ... ]

> +static long ibmveth_add_logical_lan_buffers(struct ibmveth_adapter *adapter,
> +					    union ibmveth_buf_desc *descs,
> +					    int filled,
> +					    unsigned long buff_size,
> +					    int queue_index)
> +{
> +	struct vio_dev *vdev = adapter->vdev;
> +	unsigned long rc;
> +
> +	if (adapter->multi_queue) {
> +		unsigned long buffersznum = (buff_size << 32) | filled;
> +		unsigned long ioba[IBMVETH_MAX_RX_PER_HCALL / 2] = {0};
> +		int i;
> +
> +		/* Pack descriptor addresses into ioba pairs.
> +		 * Each ioba holds two 32-bit addresses packed into 64 bits:
> +		 * - Even descriptors (0,2,4...) go in high 32 bits
> +		 * - Odd descriptors (1,3,5...) go in low 32 bits
> +		 */
> +		for (i = 0; i < filled && i < IBMVETH_MAX_RX_PER_HCALL; i++) {
> +			int pair_idx = i / 2;           /* Which pair: 0-5 */
> +			int is_high = (i % 2 == 0);     /* High or low 32 bits */
> +
> +			if (is_high)
> +				ioba[pair_idx] = (unsigned long)descs[i].fields.address << 32;
> +			else
> +				ioba[pair_idx] |= descs[i].fields.address;
> +		}
> +
> +		rc = h_add_logical_lan_buffers_queue(vdev->unit_address,
> +						     adapter->queue_handle[queue_index],
> +						     buffersznum,
> +						     ioba[0], ioba[1], ioba[2],
> +						     ioba[3], ioba[4], ioba[5]);
> +		adapter->hcall_stats.add_bufs_queue++;

[Severity: Medium]
Will this counter increment lose updates when multiple NAPI poll routines run
concurrently on different CPUs?

Since multi-queue enables concurrent execution, it seems global statistic
counters like hcall_stats.add_bufs_queue and replenish_add_buff_success might 
need atomic or per-CPU operations to avoid read-modify-write data races.

> +	} else if (filled == 1) {
> +		rc = h_add_logical_lan_buffer(vdev->unit_address,
> +					      descs[0].desc);
> +		adapter->hcall_stats.add_buf++;
> +	} else {
> +		rc = h_add_logical_lan_buffers(vdev->unit_address,
> +					       descs[0].desc, descs[1].desc,
> +					       descs[2].desc, descs[3].desc,
> +					       descs[4].desc, descs[5].desc,
> +					       descs[6].desc, descs[7].desc);
> +		adapter->hcall_stats.add_bufs++;
> +	}
> +
> +	return rc;
> +}

[ ... ]

> @@ -745,24 +798,19 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>  		}
>  		adapter->replenish_add_buff_failure += filled;
>  
> -		/*
> -		 * If multi rx buffers hcall is no longer supported by FW
> -		 * e.g. in the case of Live Partition Migration
> -		 */
> -		if (batch > 1 && lpar_rc == H_FUNCTION) {
> -			/*

[ ... ]

> +		if (lpar_rc == H_FUNCTION) {
> +			if (adapter->multi_queue) {
> +				netdev_err(adapter->netdev,
> +					   "Unexpected H_FUNCTION from multi-queue buffer add (queue=%d, batch=%d)\n",
> +					   queue_index, batch);
> +				break;
> +			} else if (batch > 1) {
> +				netdev_warn(adapter->netdev,
> +					    "H_FUNCTION from legacy batch buffer add (batch=%d), falling back to single buffer mode\n",
> +					    batch);
> +				adapter->rx_buffers_per_hcall = 1;
> +				continue;

[Severity: High]
Does this continue statement cause an infinite loop?

Looking at ibmveth_replenish_buffer_pool(), the local batch variable is set
before the while loop:

	batch = adapter->rx_buffers_per_hcall;
	while (remaining > 0) {
		...

If the fallback updates adapter->rx_buffers_per_hcall to 1 and issues a continue,
the loop will restart but the local batch variable will retain its original
value.

Would this lead to the loop repeatedly attempting the unsupported batch size
and failing with H_FUNCTION forever?

> +			}
>  		}
>  		break;
>  	}
> @@ -784,18 +832,24 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>  }
>  
>  /* replenish routine */
> -static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
> +static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
> +				   int queue_index)
>  {
>  	int i;
>  
> +	if (queue_index >= adapter->num_rx_queues)
> +		return;
> +
>  	adapter->replenish_task_cycles++;

[Severity: Medium]
Similar to the hcall_stats counters above, could this increment suffer from data
races when multiple queues are processed concurrently across different CPUs?
