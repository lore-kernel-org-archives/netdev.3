Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6C30C177;
	Fri, 31 Jul 2026 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461439; cv=none; b=OwjchA4xMuOI0dSQuEfv+AYwoouM0hqIIGhn7mDn0x7ZP9GX7Ybjc1s78Ua73p74X2iCvZnqIOEVTjr/UGttNI0BF2n5uNaZUA5ELG0YyTIlVKCNKuz3OCH2cwN/5jErMsMXQhdiIrqKzW4oj6E4xxMILRtCNf208t9ax9NRQJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461439; c=relaxed/simple;
	bh=TsMoykL7BvCKk270QaB3mqcRMHeTr8QP6nLUSIEMK7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs6IesLGRyvwWOVm3T39amTJhrczNj8V/QhdjDeC4yiTvUA2gTHz2MArlw4RcW+5sYsF4j133FQE4bWc3nBSB8vgrbNJ2p0rQ+U/eAU3WsgFYjqFuIZdI+luqRyb6nG1hwqdbvUTl9Fq6loCLRLcd1brLwDHFpCy25D4r+K4xbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/8mW3+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/8mW3+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1DA1F00A3F;
	Fri, 31 Jul 2026 01:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461437;
	bh=fiSu6Y55OVJxnZkiVxkg5hIuPzI417fX13rScOQmTZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E/8mW3+Kf02AtAZVx1/zAcUtT85nwKumcjH/RM9FZyTrqmm0nD9c8E+fe2QSVdInV
	 i6CmjfZ2af9HOpyPonbANOEynJ0Z4/lfyBPzk+nRdFvVCEnnywSo9tMmFewrkN9QKV
	 o5Jdr5bexvjQsCNtZFZ190Ad1gtYe9Q7b41BABGItObEhorIs0IEvXADC6wM3AP2OX
	 BQNUSZrjBvYeyaAPQ7qupVNbBvevZgFfYV4aD2gIHlItnhfykuA4vZXGSPRlIsGZBD
	 PGtVAYdC4tul6bs8JcWFn79PB6yQVXjgDhQG3FzUybpunRsspiaM2F08Xm1BRp9Tz/
	 P9W80ibz3YpiA==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
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
Subject: Re: [PATCH v22 net-next 11/12] net/nebula-matrix: add common/ctrl dev init/remove operation
Date: Thu, 30 Jul 2026 18:30:36 -0700
Message-ID: <20260731013036.745280-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723040110.91410-12-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-12-illusion.wang@nebula-matrix.com>
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
--- Patch [11]: [PATCH v22 net-next 11/12] net/nebula-matrix: add common/ctrl dev init/remove operation ---
commit 16bce0d3af6a82a0084a93157844e7c5875d3c59
Author: illusion wang <illusion.wang@nebula-matrix.com>

net/nebula-matrix: add common/ctrl dev init/remove operation

This commit adds initialization and teardown helpers for common and
control devices. It hooks these helpers into the main init/remove
paths and configures mailbox message processing via a work_struct.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> new file mode 100644
> index 0000000000000..eae6a00e6fccb
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> +static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
> +				   &common_dev->clean_mbx_task);
> +	/*
> +	 * Even if has_ctrl=false (no dedicated control PF channel), we fetch
> +	 * VSI/ETH info via regular mailbox message  instead of
> +	 * dedicated control command.
> +	 */
> +	ret = disp_ops->get_vsi_id(priv, NBL_VSI_DATA, &common->vsi_id);

[Severity: High]
Will this mailbox message fail silently and read uninitialized zeros?

Since get_vsi_id() is called here before interrupts are enabled,
NBL_CHAN_INTERRUPT_READY is false. When nbl_chan_send_msg() processes
this message, it checks the interrupt ready flag:

if (test_bit(NBL_CHAN_INTERRUPT_READY, chan_info->state)) {
        spin_lock_irq(&wait_head->status_lock);
        while (!READ_ONCE(wait_head->acked)) {
                ...
        }
}
...
inflight_dec_out:
        atomic_dec(&chan_info->inflight_tx_cnt);
        return ret;

Because the flag is false, does it skip waiting for the ACK and immediately
return success (0)?

If so, this would leave the caller reading zeroed variables for the
VSI and ETH IDs, resulting in incorrect initialization and potentially leaving
a dangling pointer in the wait queue.

> +	if (ret)
> +		goto err_cleanup;
> +	ret = disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_num,
> +			     &common->eth_id, &common->logic_eth_id);
> +	if (ret)
> +		goto err_cleanup;

[ ... ]
