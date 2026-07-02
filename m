Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6A480DCA
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985372; cv=none; b=YOdr5UaUeMUbDECWAiwmGoNkk/gh/KUh8hS6Ms/4wshhbFjyEaHF/92nQConA1NRtfiz3AQpxis0BDJBns59v55t1CkyfQ6sIwJEKdjs0m5AXkrPaXxzuRbJ2lgUMf8y/F0uNk4Wai2hIajqqNof6VtP+Z3S+Bv36HCBeokCDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985372; c=relaxed/simple;
	bh=zO7+2jYNP0p0Ryi/7/jQcKH3cF/htF5PPMcdV3l9NDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpG1KL5EGP8fcXLNknTPHR/9HRMiZmCJiJ41ghxRH0bs/r+ZtDmCS4F7iCIrOXGdIvziF+FSWR7+gQ2ecqU0tfHoMozvUc/cWqDZMZa/u42UAfFiWO+Bn42e0hRsrZ4Miq+5eYjdxxj5+P8yhoU3X1V0/K8Fx/9xUFT4GPAv4+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhNLStGW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhNLStGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782985370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwUN777qpsCSreohLVGTHDmdYcLkE9HL+kZ2EdbU/QI=;
	b=UhNLStGWR7xs/8n5YeX78VGAewgXkILSXCrmT+2uOGpITD00cye2dDim+VJP+kv7SlFOzA
	YfmPowWpyWdHe/BkphirV/jBKisccgS55uHCncP5Zf9MMhvdw1lFikQL288RXpm0+jF18O
	xl8Ssk6plkE2WhohpAGI1qthu/0Y9oU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-Tz5_TpCON5mKDlVKqCXEeg-1; Thu,
 02 Jul 2026 05:42:47 -0400
X-MC-Unique: Tz5_TpCON5mKDlVKqCXEeg-1
X-Mimecast-MFC-AGG-ID: Tz5_TpCON5mKDlVKqCXEeg_1782985365
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 972F11944D3A;
	Thu,  2 Jul 2026 09:42:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65AC4196B0A3;
	Thu,  2 Jul 2026 09:42:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 net-next 04/10] net/nebula-matrix: add channel layer
Date: Thu,  2 Jul 2026 11:42:29 +0200
Message-ID: <20260702094229.111353-1-pabeni@redhat.com>
In-Reply-To: <20260630010718.4346-5-illusion.wang@nebula-matrix.com>
References: <20260630010718.4346-5-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
Subject: net/nebula-matrix: add channel layer

This patch introduces a channel management layer for structured communication
between components and drivers. It implements message registration, sending,
and acknowledgment via hardware mailbox queues.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> index c7689f0e40293..eca9495449938 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
[ ... ]
> @@ -2,12 +2,997 @@
[ ... ]
> +static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
> +				   u8 chan_type)
> +{
[ ... ]
> +	/*
> +	 * Lock and unlock to ensure all in-flight callers have released the
> +	 * lock. After unlock returns, we're guaranteed no other thread is
> +	 * using the lock, so it's safe to destroy it.
> +	 */
> +	mutex_lock(&chan_info->txq_lock);
> +	mutex_unlock(&chan_info->txq_lock);
> +	wait_for_completion(&chan_info->teardown_done);
> +	mutex_destroy(&chan_info->txq_lock);
> +
> +	return 0;
> +}

[Severity: High]
Does this code deadlock or fail to synchronize?

Because nbl_chan_send_msg() calls complete(&chan_info->teardown_done) on
every exit path, it increments the completion counter for every message sent.
If no messages were ever sent, the counter is 0 and this wait_for_completion()
will block forever.

If messages were sent, the counter is greater than 0, so this returns
immediately without waiting for active senders. It then destroys txq_lock
while other threads might still be using it, which can cause a use-after-free
or lock corruption.

[ ... ]
> +static int nbl_chan_update_txqueue(struct nbl_channel_mgt *chan_mgt,
> +				   struct nbl_chan_info *chan_info,
> +				   struct nbl_chan_tx_param *param)
> +{
[ ... ]
> +	if (param->arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
> +		memcpy(tx_buf->va, param->arg, param->arg_len);
> +		tx_desc->buf_addr = cpu_to_le64(tx_buf->pa);
> +		tx_desc->buf_len = cpu_to_le16(param->arg_len);
> +		tx_desc->data_len = 0;
> +		memset(tx_desc->data, 0, sizeof(tx_desc->data));
> +	} else {
> +		memset(tx_desc->data, 0, sizeof(tx_desc->data));
> +		memcpy(tx_desc->data, param->arg, param->arg_len);
> +		tx_desc->buf_len = 0;
> +		tx_desc->data_len = cpu_to_le16(param->arg_len);
> +	}

[Severity: High]
Does this code leak host physical memory addresses to the receiving endpoint?

In the else branch (when embedding data), tx_desc->buf_addr is not cleared.
Since the TX descriptor ring is reused circularly, if this slot previously held
a large message, buf_addr still contains the physical DMA address of the host's
buffer.

This leaked physical address is written to memory shared with the receiving
endpoint, potentially crossing a security boundary.

[ ... ]
> +static void nbl_chan_clean_queue(struct nbl_channel_mgt *chan_mgt,
> +				 struct nbl_chan_info *chan_info)
> +{
[ ... ]
> +	while (le16_to_cpu(rx_desc->flags) & BIT(NBL_CHAN_RX_DESC_USED)) {
[ ... ]
> +		if (--budget == 0)
> +			break;
> +	}
> +	rxq->next_to_clean = next_to_clean;
> +}

[Severity: High]
Can this permanently stall the RX queue?

The loop exits when the budget is exhausted, but nbl_chan_clean_queue()
returns void and doesn't indicate that more packets remain.

The workqueue handler does not check if the RX queue was completely drained
and won't reschedule the work item. If the ring wasn't completely drained,
edge-triggered MSI-X interrupts won't fire again until a new packet arrives,
leading to a stalled queue and missed messages.

[ ... ]
> +static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
> +			     struct nbl_chan_send_info *chan_send)
> +{
[ ... ]
> +	if (!chan_send->ack) {
> +		complete(&chan_info->teardown_done);
> +		return 0;
> +	}

[Severity: High]
Is it intentional to call complete(&chan_info->teardown_done) here and on
all other exit paths of nbl_chan_send_msg()?

This increments the completion counter on every message sent, which breaks the
synchronization in nbl_chan_teardown_queue() (as mentioned above).

[ ... ]
-- 
This is an AI-generated review.

