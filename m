Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2C4749C3;
	Wed, 22 Jul 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735859; cv=none; b=T/C6QVIMKz1u726y8nMqHWosKt4vZnnQCSKF/DW+qZAPZN1/nq6ifcto9BYq9rA0QdgYh8nzG3xdERV/rkWU5mUELcVbhDVlm0Yu9wZvrAha8a21hpphtcMIoL6OfbIi1hu4zlhbiR9OHNKaxd0+sBJ21rCsfUykjBeGvoHv5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735859; c=relaxed/simple;
	bh=KIjt7GvxIMrQtfY/iQSmi5bBUWN5NrMc3BFLc2cvaS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYYJrl5q2WbV4MuxGPEBY2ANGUVrLR7rGuW/NcmT5zgK51j/RGvwpjxjueoe46KfLnHGc17BJp0PHDWW/U1r1KFbxgUWgm3C9l8yCQdzHda7j4bxiwYEiw8tXAT412WNNzNVckCKSe4fpdhGE1IRj1Tbo81tDhSr9c4iJa/PM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZGfcRyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZGfcRyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B081F000E9;
	Wed, 22 Jul 2026 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784735855;
	bh=aKhPZ76IcTT0ulH0kKnlFEzg1yMBUkRbpHe4lT3tg9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZZGfcRyHfgxir6Elxi2P5v8xKROWJ6sRhcsAD2lDwP3cXOAgfMhncCcm99Mdk280m
	 mO0nY5jc1pyGoa3VtL3Zp9lfxtEkhpKS+X4evrp5ihBWvX6t4LrchuRRo01W5H/Kgh
	 R5u/nr1xEWWKojnJ9e6KqSm7WeP8aXElq4KGYiWtZyhXTxcLysJ5JE0flBNGe7x3+Z
	 spr7BNMibKBAjDzrJ5NfSUH3+hGQw4IwhHE4ub8D0UW35ukeMVxhuWciKicgpxJJxm
	 QUrPtKg8uQSuvM2Cqj5WzW2L9Tpcgh/iphZxHKwXXkr+axeLCQr+Zvi7ovXkcZGb3B
	 1iTFFrK0YrjUg==
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
Subject: Re: [PATCH net-next v5 05/15] libie: add bookkeeping support for control queue messages
Date: Wed, 22 Jul 2026 16:55:19 +0100
Message-ID: <20260722155519.538443-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715180042.1972010-6-anthony.l.nguyen@intel.com>
References: <20260715180042.1972010-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260715180042.1972010-2-anthony.l.nguyen@intel.com?part=5
---
--- Patch [5]: [PATCH net-next v5 05/15] libie: add bookkeeping support for control queue messages ---
commit d43a66e84fe554628118bb85dd302d63d942c80b
Author: Phani R Burra <phani.r.burra@intel.com>

    libie: add bookkeeping support for control queue messages

    Small send control queue message buffers are managed and reused by
    libie itself, bigger send buffers are consumed. All are tracked with
    the unique transaction (Xn) ids until they receive response or time out.
    Responses can be received out of order, therefore transactions are stored
    in an array and tracked though a bitmap.

> diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
> index a3aa241f03b9a..0a179957bfeff 100644
> --- a/drivers/net/ethernet/intel/libie/controlq.c
> +++ b/drivers/net/ethernet/intel/libie/controlq.c
> @@ -611,6 +611,613 @@ u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,

[ ... ]

> +static struct libie_ctlq_xn *
> +libie_ctlq_xn_pop_free(struct libie_ctlq_xn_manager *xnm)
> +{
> +	struct libie_ctlq_xn *xn;
> +	u32 free_idx;
> +
> +	guard(spinlock)(&xnm->free_xns_bm_lock);

[Severity: High]
Does acquiring this lock using a plain spinlock in process context risk a
deadlock? The receive path processes completions and executes in softirq
context. If a softirq interrupts the process context while a shared lock
is held on the same CPU, it could cause a deadlock. Should this use
guard(spinlock_bh) or guard(spinlock_irqsave)?

> +
> +	if (unlikely(xnm->shutdown))
> +		return NULL;

[ ... ]

> +static bool __libie_ctlq_xn_push_free(struct libie_ctlq_xn_manager *xnm,
> +				      struct libie_ctlq_xn *xn)
> +{
> +	__set_bit(xn->index, xnm->free_xns_bm);

[Severity: High]
Can this non-atomic bitwise write cause data corruption or tearing?
In libie_xn_check_async_timeout(), the free_xns_bm bitmap is traversed
locklessly:

    for_each_clear_bit(idx, xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES) {

Concurrently, __set_bit() here and __clear_bit() in libie_ctlq_xn_pop_free()
modify the bitmap. Reading a bitmap concurrently modified by non-atomic
operations can lead to data races.

> +
> +	if (unlikely(xnm->shutdown) &&
> +	    bitmap_full(xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES))
> +		return true;
> +
> +	return false;
> +}

[ ... ]

> +static bool
> +libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
> +			   struct libie_ctlq_msg *ctlq_msg)
> +{
> +	struct libie_ctlq_xn_manager *xnm = params->xnm;
> +	struct libie_ctlq_xn *xn;
> +	u16 msg_cookie, xn_index;
> +	struct kvec *response;
> +	int status;
> +	u16 data;
> +
> +	data = ctlq_msg->sw_cookie;
> +	xn_index = FIELD_GET(LIBIE_CTLQ_XN_INDEX_M, data);
> +	msg_cookie = FIELD_GET(LIBIE_CTLQ_XN_COOKIE_M, data);
> +	status = ctlq_msg->chnl_retval ? -EFAULT : 0;

[Severity: Medium]
Does truncating the specific hardware error code to a generic -EFAULT lose
important information? For synchronous messages, this always translates to
-EBADMSG, preventing callers from differentiating between specific errors
like unsupported features or out-of-memory conditions.

> +
> +	xn = &xnm->ring[xn_index];
> +	spin_lock(&xn->xn_lock);
> +	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
> +	    msg_cookie != xn->cookie) {
> +		spin_unlock(&xn->xn_lock);
> +		return false;
> +	}
> +
> +	if (xn->state != LIBIE_CTLQ_XN_ASYNC &&
> +	    xn->state != LIBIE_CTLQ_XN_WAITING) {
> +		spin_unlock(&xn->xn_lock);
> +		return false;
> +	}
> +
> +	response = &ctlq_msg->recv_mem;
> +	if (xn->state == LIBIE_CTLQ_XN_ASYNC) {
> +		xn->resp_cb(xn->send_ctx, response, status);
> +		libie_ctlq_release_rx_buf(response);
> +		xn->state = LIBIE_CTLQ_XN_IDLE;
> +		spin_unlock(&xn->xn_lock);

[Severity: High]
Does executing the opaque response callback with the transaction spinlock held
risk deadlocks? If the driver callback attempts to send a new control queue
message, it will acquire another transaction's xn_lock, which can trigger
recursive or nested lockdep warnings (A-A deadlock). If the callback acquires
driver locks, it risks an AB-BA lock inversion with paths like shutdown.

> +		libie_ctlq_xn_push_free(xnm, xn);
> +
> +		return true;
> +	}

[ ... ]

> +static void libie_xn_check_async_timeout(struct libie_ctlq_xn_manager *xnm)
> +{
> +	u32 idx;
> +
> +	for_each_clear_bit(idx, xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES) {
> +		struct libie_ctlq_xn *xn = &xnm->ring[idx];
> +		u64 timeout_ms;
> +
> +		spin_lock(&xn->xn_lock);
> +
> +		timeout_ms = ktime_ms_delta(ktime_get(), xn->timestamp);
> +		if (xn->state != LIBIE_CTLQ_XN_ASYNC ||
> +		    timeout_ms < xn->timeout_ms) {
> +			spin_unlock(&xn->xn_lock);
> +			continue;
> +		}
> +
> +		xn->resp_cb(xn->send_ctx, NULL, -ETIMEDOUT);
> +		xn->state = LIBIE_CTLQ_XN_IDLE;
> +		spin_unlock(&xn->xn_lock);

[Severity: High]
Is it safe to call the response callback here while holding xn->xn_lock? As with
the receive path, calling into driver code while holding this spinlock could
cause a deadlock if the callback attempts to acquire other locks or send
additional control queue messages.

> +		libie_ctlq_xn_push_free(xnm, xn);
> +	}
> +}

[ ... ]

> +u32 libie_ctlq_xn_recv(struct libie_ctlq_xn_recv_params *params)
> +{
> +	struct libie_ctlq_msg ctlq_msg;
> +	u32 budget = params->budget;
> +
> +	while (budget && libie_ctlq_recv(params->ctlq, &ctlq_msg, 1)) {
> +		budget--;
> +		if (!libie_ctlq_xn_process_recv(params, &ctlq_msg))
> +			params->ctlq_msg_handler(params->xnm->ctx, &ctlq_msg);
> +	}
> +
> +	libie_ctlq_post_rx_buffs(params->ctlq);
> +	libie_xn_check_async_timeout(params->xnm);

[Severity: High]
Can asynchronous messages hang indefinitely if the hardware stops responding?
Because timeouts are exclusively checked in libie_ctlq_xn_recv(), if the
hardware hangs and no RX interrupts fire, the timeout logic will never execute.
Should there be a dedicated background timer to enforce timeouts?

> +
> +	return budget;
> +}

[ ... ]

> +static
> +int libie_ctlq_xn_process_send(struct libie_ctlq_xn_send_params *params,
> +			       struct libie_ctlq_xn *xn)
> +{
> +	size_t buf_len = params->send_buf.iov_len;
> +	struct device *dev = params->ctlq->dev;
> +	void *buf = params->send_buf.iov_base;
> +	struct libie_cp_dma_mem *dma_mem;
> +	u16 cookie;
> +
> +	if (!buf || !buf_len)
> +		return -EOPNOTSUPP;
> +
> +	if (libie_cp_can_send_onstack(buf_len)) {
> +		dma_mem = xn->dma_mem;
> +		memcpy(dma_mem->va, buf, buf_len);
> +	} else {
> +		dma_mem = &xn->send_dma_mem;
> +		dma_mem->va = buf;
> +		dma_mem->size = buf_len;
> +		dma_mem->direction = DMA_TO_DEVICE;
> +
> +		if (!libie_cp_map_dma_mem(dev, buf, buf_len, DMA_TO_DEVICE,
> +					  dma_mem))
> +			return -ENOMEM;
> +	}
> +
> +	cookie = FIELD_PREP(LIBIE_CTLQ_XN_COOKIE_M, xn->cookie) |
> +		 FIELD_PREP(LIBIE_CTLQ_XN_INDEX_M, xn->index);
> +
> +	scoped_guard(spinlock, &params->ctlq->lock) {

[Severity: High]
Should this use scoped_guard(spinlock_bh) or spinlock_irqsave?
Acquiring this lock with a plain spinlock in process context risks a deadlock
against the receive softirq path.

> +		struct libie_ctlq_info *ctlq = params->ctlq;
> +		struct libie_ctlq_msg *ctlq_msg;

[ ... ]

> +int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params)
> +{
> +	bool free_send = !libie_cp_can_send_onstack(params->send_buf.iov_len);
> +	struct libie_ctlq_xn *xn;
> +	int ret;
> +
> +	if (params->send_buf.iov_len > LIBIE_CTLQ_MAX_BUF_LEN) {
> +		ret = -EINVAL;
> +		goto free_buf;
> +	}
> +
> +	xn = libie_ctlq_xn_pop_free(params->xnm);
> +	/* no free transactions available */
> +	if (unlikely(!xn)) {
> +		ret = -EAGAIN;
> +		goto free_buf;
> +	}
> +
> +	spin_lock(&xn->xn_lock);

[Severity: High]
Does acquiring xn->xn_lock using a plain spinlock in process context risk a
deadlock if softirq handles a receive on the same CPU? Use of spin_lock_bh
or spin_lock_irqsave would protect against this.

> +	if (xn->state == LIBIE_CTLQ_XN_SHUTDOWN) {
> +		ret = -ENXIO;
> +		goto unlock_xn;
> +	}
> +
> +	xn->state = params->resp_cb ? LIBIE_CTLQ_XN_ASYNC :
> +				      LIBIE_CTLQ_XN_WAITING;
> +	xn->ctlq = params->ctlq;
> +	xn->virtchnl_opcode = params->chnl_opcode;

[ ... ]

> +	wait_for_completion_timeout(&xn->cmd_completion_event,
> +				    msecs_to_jiffies(params->timeout_ms));
> +
> +	spin_lock(&xn->xn_lock);
> +	switch (xn->state) {
> +	case LIBIE_CTLQ_XN_WAITING:
> +		ret = -ETIMEDOUT;
> +		break;
> +	case LIBIE_CTLQ_XN_COMPLETED_SUCCESS:
> +		params->recv_mem = xn->recv_mem;
> +		break;
> +	default:
> +		ret = -EBADMSG;
> +		break;
> +	}
> +
> +	/* Free the receive buffer in case of failure. On timeout, receive
> +	 * buffer is not allocated.
> +	 */
> +	if (ret && ret != -ETIMEDOUT)
> +		libie_ctlq_release_rx_buf(&xn->recv_mem);

[Severity: Critical]
Can this cause a double free on a stale receive buffer if the transaction was
aborted? When a transaction is returned to the free pool, xn->recv_mem is not
cleared. If it is reallocated and enters the WAITING state, it still contains
the recv_mem pointer from its last successful use. If libie_ctlq_xn_shutdown()
aborts this transaction, its state changes to SHUTDOWN. This switch falls through
to the default case setting ret = -EBADMSG, and this cleanup logic will call
libie_ctlq_release_rx_buf() on the stale recv_mem pointer.

> +
> +release_xn:
> +	xn->state = LIBIE_CTLQ_XN_IDLE;
> +	reinit_completion(&xn->cmd_completion_event);
> +unlock_xn:
> +	spin_unlock(&xn->xn_lock);
> +	libie_ctlq_xn_push_free(params->xnm, xn);
> +free_buf:
> +	if (free_send)
> +		params->rel_tx_buf(params->send_buf.iov_base);

[Severity: High]
Does this silently leak dynamically allocated send buffers that are smaller than
or equal to 128 bytes? If the payload is <= LIBIE_CP_TX_COPYBREAK (128 bytes),
free_send is initialized to false at the top of the function. Consequently,
params->rel_tx_buf is never called. If a caller allocates a small payload
dynamically expecting the framework to free it, it will leak.

> +
> +	return ret;
> +}

[ ... ]

> +u32 libie_ctlq_xn_send_clean(const struct libie_ctlq_xn_clean_params *params)
> +{
> +	struct libie_ctlq_info *ctlq = params->ctlq;
> +	struct device *dev = ctlq->dev;
> +	u32 ntc, i;
> +
> +	spin_lock(&ctlq->lock);
> +	ntc = ctlq->next_to_clean;
> +
> +	for (i = 0; i < params->num_msgs; i++) {
> +		struct libie_ctlq_msg *msg = ctlq->tx_msg[ntc];
> +		struct libie_ctlq_desc *desc;
> +		u64 qword;
> +
> +		desc = &ctlq->descs[ntc];
> +		qword = le64_to_cpu(desc->qword0);
> +
> +		if (!FIELD_GET(LIBIE_CTLQ_DESC_FLAG_DD, qword) &&
> +		    !(unlikely(params->force) && msg->data_len))
> +			break;
> +
> +		desc->qword0 = 0;
> +
> +		dma_mb();

[Severity: Medium]
Is it necessary to issue a full dma_mb() memory barrier for every cleaned TX
descriptor in this loop? The submission path already correctly issues a
dma_wmb() before writing the tail register, and unmapping a DMA buffer does not
require a prior full barrier. Issuing a full memory barrier in a tight packet
cleaning loop has a severe performance impact.

> +
> +		if (!libie_cp_can_send_onstack(msg->data_len)) {
> +			libie_cp_unmap_dma_mem(dev, &msg->send_mem);
> +			params->rel_tx_buf(msg->send_mem.va);
> +		}
> +
> +		memset(msg, 0, sizeof(*msg));
> +
> +		if (unlikely(++ntc == ctlq->ring_len))
> +			ntc = 0;
> +	}

[ ... ]

> +void libie_ctlq_xn_shutdown(struct libie_ctlq_xn_manager *xnm)
> +{
> +	bool must_wait = false;
> +	u32 i;
> +
> +	/* Should be no new clear bits after this */
> +	spin_lock(&xnm->free_xns_bm_lock);
> +	xnm->shutdown = true;
> +
> +	for_each_clear_bit(i, xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES) {
> +		struct libie_ctlq_xn *xn = &xnm->ring[i];
> +
> +		spin_lock(&xn->xn_lock);
> +
> +		switch (xn->state) {
> +		/* if an idle xn is not free, it is about to be either
> +		 * freed or initialized, prevent the latter and wait
> +		 */
> +		case LIBIE_CTLQ_XN_IDLE:
> +			xn->state = LIBIE_CTLQ_XN_SHUTDOWN;
> +			fallthrough;
> +		/* waiting thread possibly needs a push to return the xn,
> +		 * transaction will be reported as timed out
> +		 */
> +		case LIBIE_CTLQ_XN_WAITING:
> +			complete(&xn->cmd_completion_event);
> +			fallthrough;
> +		/* these states will return the xn soon */
> +		case LIBIE_CTLQ_XN_COMPLETED_SUCCESS:
> +		case LIBIE_CTLQ_XN_COMPLETED_FAILED:
> +		case LIBIE_CTLQ_XN_SHUTDOWN:
> +			must_wait = true;
> +			break;
> +		/* no thread should reference async xns at this point */
> +		case LIBIE_CTLQ_XN_ASYNC:
> +			xn->state = LIBIE_CTLQ_XN_IDLE;
> +			__libie_ctlq_xn_push_free(xnm, xn);
> +			break;

[Severity: High]
Does silently dropping pending asynchronous transactions here leak memory?
Callers dynamically allocate context (send_ctx) for asynchronous APIs and rely
on the response callback (resp_cb) to free it. By returning the transaction
to the free list without invoking the callback, that cleanup is skipped, causing
a memory leak in the driver.

> +		}
> +
> +		spin_unlock(&xn->xn_lock);
> +	}
> +
> +	spin_unlock(&xnm->free_xns_bm_lock);
> +
> +	if (must_wait)
> +		wait_for_completion(&xnm->can_destroy);
> +}
