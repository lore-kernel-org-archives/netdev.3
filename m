Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B0337BB8;
	Sun, 12 Apr 2026 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775998776; cv=none; b=sGovFKoIEWKD/Hh2e7JlBr2M+AAVoMg3co9Hgg//5EVIuWmKKW3QUYhmyCqG82hW//QefyMigY+ED8dWysXvoQeJOqEsatDwVhQYCN23O+zHpno+qHl7hzEqM3wNmSBMlml7gxTsIQi+G0jXHoliDbhzHT8w0012Zq9xy7dHWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775998776; c=relaxed/simple;
	bh=S4MIU9n9WtZTHe6aWIPGYeDb4WdLPsLl4V1eij9uszc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX0fhSjzkwlMyQNEVcoVWgskMYrF9GkcDY9KzYlxhmw8K+ZrjXvNtewrSqm23D+jF3R3kh2sHqPI5R56A+iPGvMcN9shDLDuBsEUxGeDsPi69lg8vE718m4dsMR/fZJnXQv+UyVw0JaCI9nqBlPdU1Ot3UAbHAwI2ND1l4yxf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7wiMBHx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7wiMBHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40677C19424;
	Sun, 12 Apr 2026 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775998775;
	bh=S4MIU9n9WtZTHe6aWIPGYeDb4WdLPsLl4V1eij9uszc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7wiMBHxKsD3WT4v3W0fDtGgY0Zs5KCOQnjKtNOXsTJkAiZNDJH9mCbyeUjmig6lE
	 LvMavUWqxy1nlB+o1MWqaBabVQWAggOJ6rHpZjqKM0tttbHB5ohcDr3MPdSP99QjZ8
	 OIA65j6cLSyG74Hfn5ltDeGMmkA031uY5xHWbS51xFYETXBlU+EctiAZLgUh8ZfuYI
	 8AFiIq3XOR17EK/n+O9lCqBTQWNNT0/7nQrPubXpaDyulu4uu6d4h7zysUqvcOHm2m
	 Y+fL7JxNgFokCfvdFTO9+bdjG/5p5DjA/8bWIkbi59Gj9q5j1wielHcG5sB3PtqxFA
	 Fwz1hJPsIWqBA==
From: Simon Horman <horms@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Simon Horman <horms@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	andrew+netdev@lunn.ch,
	alvin.wang@nebula-matrix.com,
	corbet@lwn.net,
	enelsonmoore@gmail.com,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	sam.chen@nebula-matrix.com,
	vadim.fedorenko@linux.dev,
	edumazet@google.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	lukas.bulwahn@redhat.com,
	lorenzo@kernel.org,
	linux-kernel@vger.kernel.org (open list),
	linux-doc@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v11 net-next 05/11] net/nebula-matrix: add channel layer
Date: Sun, 12 Apr 2026 13:59:14 +0100
Message-ID: <20260412125914.663178-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408093739.56001-6-illusion.wang@nebula-matrix.com>
References: <20260408093739.56001-6-illusion.wang@nebula-matrix.com>
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
net/nebula-matrix: add channel layer

This commit adds a channel management layer for the nebula-matrix
network driver, providing mailbox-based communication between PF0
and other PFs with message send/receive, ACK handling, and
hash-based message handler lookup.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c

[ ... ]

> +static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
> +			     struct nbl_chan_send_info *chan_send)
> +{

[ ... ]

> +	if (test_bit(NBL_CHAN_INTERRUPT_READY, chan_info->state)) {
> +		ret = wait_event_timeout(wait_head->wait_queue,
> +					 wait_head->acked,
> +					 NBL_CHAN_ACK_WAIT_TIME);
> +		if (!ret) {
> +			wait_head->status = NBL_MBX_STATUS_TIMEOUT;
> +			dev_err(dev,
> +				"Channel waiting ack failed, message type: %d, msg id: %u\n",
> +				chan_send->msg_type, msgid.id);
> +			return -ETIMEDOUT;
> +		}

[ ... ]

> +	/*polling wait mailbox ack*/
> +	while (i--) {
> +		nbl_chan_clean_queue(chan_mgt, chan_info);
> +
> +		if (wait_head->acked) {
> +			chan_send->ack_len = wait_head->ack_data_len;
> +			wait_head->status = NBL_MBX_STATUS_IDLE;
> +			return wait_head->ack_err;
> +		}
> +		usleep_range(NBL_CHAN_TX_WAIT_ACK_US_MIN,
> +			     NBL_CHAN_TX_WAIT_ACK_US_MAX);
> +	}
> +
> +	wait_head->status = NBL_MBX_STATUS_TIMEOUT;
> +	dev_err(dev,
> +		"Channel polling ack failed, message type: %d msg id: %u\n",
> +		chan_send->msg_type, msgid.id);
> +
> +	return -EFAULT;
          ^^^^^^

The interrupt-based ACK wait path above returns -ETIMEDOUT on timeout,
but this polling-based ACK wait path returns -EFAULT. -EFAULT ("bad
address") is not the right error code for a timeout condition.

Should this also return -ETIMEDOUT for consistency? Any caller that
checks specifically for -ETIMEDOUT to handle timeouts would miss
this polling timeout case.

> +}

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c

[ ... ]

> +int nbl_common_create_wq(void)
> +{
> +	wq_mgt = kzalloc_obj(*wq_mgt);
> +	if (!wq_mgt)
> +		return -ENOMEM;
> +
> +	wq_mgt->ctrl_dev_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_UNBOUND,
> +					      0, "nbl_ctrldev_wq");
> +	if (!wq_mgt->ctrl_dev_wq) {
> +		pr_err("Failed to create workqueue nbl_ctrldev_wq\n");
> +		goto alloc_ctrl_dev_wq_failed;
> +	}
> +
> +	return 0;
> +alloc_ctrl_dev_wq_failed:
> +	kfree(wq_mgt);
> +	return -ENOMEM;
> +}

When alloc_workqueue() fails, wq_mgt is freed but the static pointer
is not set to NULL. After this error path, wq_mgt becomes a dangling
pointer.

If nbl_common_queue_work() or nbl_common_destroy_wq() is called
afterwards, they dereference wq_mgt unconditionally:

    nbl_common_queue_work():
        queue_work(wq_mgt->ctrl_dev_wq, task);

    nbl_common_destroy_wq():
        destroy_workqueue(wq_mgt->ctrl_dev_wq);
        kfree(wq_mgt);

Would adding "wq_mgt = NULL;" after kfree(wq_mgt) on the error path
prevent this?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h

[ ... ]

> +/* it used for y_axis no necessay */
> +struct nbl_hash_entry_node {
> +	struct hlist_node node;
> +	void *key;
> +	void *data;
> +};

This isn't a bug, but the comment "it used for y_axis no necessay"
appears garbled and "necessay" is misspelled. Could the comment be
rewritten to explain the purpose of this struct, or removed if it
is no longer relevant?
