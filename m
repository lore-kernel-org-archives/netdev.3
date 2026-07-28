Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C7175A85;
	Tue, 28 Jul 2026 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199285; cv=none; b=awfsZx/5E8WN+JlKEkAymgd4AzQZ/InnNfQYHDsA09Ni8Nk+CjXFtGNMk0YZG/2+0eC7JHx1XwY5QNhl7idC8YpLVflONLTpS9+HHGeI9KbKQs3uMjldRlpXHA1Ut2RxlyZz/8Xvco7zePt9ay3wKRA1ir3KpptP4Bmp5+0bkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199285; c=relaxed/simple;
	bh=8Kzcn2XN2qqottjQ3F/+lsmWgQbnFhBZkPBLI+e4lT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFzcZahnYcq3PA4KT93GFLRLIjOmioYria61kNk3+cgMD/KRGFXqJyclbJeehkEqcWp2N6LoErC9g9Ug7LpbtL1QvuFgcQL1yZlxRYoyG8mI4NRfOEFadFdRCeEm+0EefsMW/8Pb/52DtW5mi1tlPbXtsmA7+EBX+DFk4zbwTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLUY+iRj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLUY+iRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB3E1F000E9;
	Tue, 28 Jul 2026 00:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785199284;
	bh=So9KdkYupwWzCLWpkv4u6aZV+9T2/N+/6nSKgTWPT18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NLUY+iRj839D92QMFqRZcHz9szTxNnv/4XkyhY+bTI1YA0A8KkWzmaXhUF6w+e6nO
	 +btVjNPNT+nhShjWGJJcyP/uR3BTZwMpG0XwK0kDUDcmrPMbUJvVIPjCkhJ3FEl9kR
	 3O4IBOSQFybEuvNLvuq6zQtR0wGkdkifrbTYg2ZkyT57DJrjK1sXqXmJ+UOtXUW4Xx
	 UOrg9DATc6/bZJzB7iEcPeCZSahWcR8fQlCH5gxg4ivrZpEewXQtl9fgtMmRCbMsOK
	 GVx3QSKlXlcJbR6As47tlCDB8GM6JiMXATivI6Wsr6gxXjKyOwGWKljA3cdsjY/Wms
	 PAQWjAzXsDz6Q==
From: Jakub Kicinski <kuba@kernel.org>
To: satishkh@cisco.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leitao@debian.org,
	sebaddel@cisco.com
Subject: Re: [PATCH net-next v12 05/12] enic: add admin CQ service with MSI-X interrupt and workqueue polling
Date: Mon, 27 Jul 2026 17:41:22 -0700
Message-ID: <20260728004122.2979545-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-5-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-5-6ff2c617001d@cisco.com>
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
Now I have the confirmation. Let me generate the report.

commit 91d5187517ef604e2669cd4fde3a2c606489afe1
Author: Satish Kharat <satishkh@cisco.com>

enic: add admin CQ service with MSI-X interrupt and workqueue polling

This adds an MSI-X driven CQ service for the admin channel with a
workqueue-based poller, a bounded admin_msg backlog, and a deferred
dispatch work_struct for received admin messages.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index b2be42092106..9358165263d9 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c

[ ... ]

> @@ -94,6 +96,266 @@ static void enic_admin_rq_drain(struct enic *enic)
>  	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
>  }
>  
> +static unsigned int enic_admin_cq_color(void *cq_desc, unsigned int desc_size)
> +{

[ ... ]

> +unsigned int enic_admin_rq_cq_service(struct enic *enic)
> +{
> +	struct vnic_cq *cq = &enic->admin_cq[1];
> +	struct vnic_rq *rq = &enic->admin_rq;
> +	struct cq_enet_rq_desc *rq_desc;
> +	struct vnic_rq_buf *buf;
> +	u16 bwf, bytes_written;
> +	unsigned int work = 0;
> +	void *desc;
> +
[ ... ]
> +		rq_desc = desc;
> +		bwf = le16_to_cpu(rq_desc->bytes_written_flags);
> +		bytes_written = bwf & CQ_ENET_RQ_DESC_BYTES_WRITTEN_MASK;
> +		if (bytes_written > buf->len)
> +			goto next_desc;
> +
> +		dma_sync_single_for_cpu(&enic->pdev->dev,
> +					buf->dma_addr, buf->len,
> +					DMA_FROM_DEVICE);
[ ... ]
> +		enic_admin_msg_enqueue(enic, buf->os_buf, bytes_written);

[Medium]
Can this path leak uninitialised heap contents to downstream admin
message consumers?

The admin RQ buffers are allocated with plain kmalloc() in
enic_admin_rq_post_one():

    buf = kmalloc(ENIC_ADMIN_BUF_SIZE, gfp);

so the buffer contents are uninitialised heap.  The only bound applied
here is bytes_written > buf->len, but there is no check that hardware
actually DMA'd bytes_written bytes.  enic_admin_msg_enqueue() then does:

    memcpy(msg->data, buf, len);

A firmware or peer that DMAs a short payload but reports a larger
bytes_written value would cause the tail region to be copied verbatim
from stale heap into the queued admin_msg.

The commit comment above this block already flags a "buggy or hostile
VF" as part of the threat model.  Would switching enic_admin_rq_post_one()
to kzalloc(), or zeroing [bytes_written, buf->len) after
dma_sync_single_for_cpu() and before enqueue, be preferable?

The admin_rq_handler is NULL at this point in the series, but later
patches ("enic: add MBOX PF handlers for VF register and capability"
and "enic: add MBOX VF handlers for capability, register and link
state") process payload bytes, so any stale content would then reach
handler logic.

[ ... ]

> +static void enic_admin_poll_work_handler(struct work_struct *work)
> +{
> +	struct enic *enic = container_of(work, struct enic, admin_poll_work);
> +	unsigned int credits;
> +	unsigned int rq_work;
> +
> +	/* Snapshot the pending credit count before draining so we acknowledge
> +	 * exactly what the hardware reported for this interrupt.  Credits that
> +	 * accrue while enic_admin_rq_cq_service() runs are left for the next
> +	 * interrupt, which is harmless on this low-rate control path.
> +	 */
> +	credits = vnic_intr_credits(&enic->admin_intr);
> +
> +	rq_work = enic_admin_rq_cq_service(enic);
> +
> +	if (rq_work > 0)
> +		schedule_work(&enic->admin_msg_work);
> +
> +	/* Acknowledge the snapshotted credits and unmask the vector.  Unlike
> +	 * the NAPI data path, the admin channel is not re-polled, so the vector
> +	 * must be re-armed here to receive the next completion.  The unmask is
> +	 * applied through the interrupt mask register independently of the
> +	 * credit count, so returning zero credits on a spurious wakeup still
> +	 * re-arms the vector.
> +	 */
> +	vnic_intr_return_credits(&enic->admin_intr,
> +				 credits,
> +				 1 /* unmask */, 0);
> +}

[Low]
The commit message states:

    At least one credit is returned so the write always
    carries a non-zero acknowledgment and re-arms the vector, since the
    admin channel is not re-polled like the NAPI data path.

Does the code actually enforce a floor of one credit?

credits comes directly from vnic_intr_credits() and is passed verbatim
to vnic_intr_return_credits() with no max(credits, 1U) clamp.  On a
spurious wakeup credits can be zero.  The in-function comment right
below correctly notes:

    returning zero credits on a spurious wakeup still
    re-arms the vector.

Should the commit message be reworded to match the actual behaviour
(the UNMASK bit re-arms the vector independently of the credit count),
or should a max(credits, 1U) be added to match the message?

[ ... ]
-- 
pw-bot: cr
