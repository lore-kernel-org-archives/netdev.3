Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8F2E7635;
	Thu, 13 Aug 2026 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584736; cv=none; b=OS9PBy5N5Dxgsgo3ovOclHjaarvym6KwEG8xtF5FNsOcU8eaFAB0hLA3AZetIw3eq0a0j1iEXzEjOGQWIwb5DSQdxdYzMEgySRkQKB31u7wCyXTFMHcn3I7eZkJEz1yNmj10Ca75jqXVpXQzfJWjhrTnFnc1d4SU0cjTo9fxRG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584736; c=relaxed/simple;
	bh=GX/hHYYWhNHwht+o/zoYGZRHCemyfE/H/jJi5IojnQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foBkcDZFR68E1QNsc9IAWL+HVP5UvNQUusta0e22jRlU9ETPlCaudZ+XySw9/RuA0tuEFXfq5KcMUqwiuCxipD5ogY+RWTh6NmQjJLQqxT2eQGgEX0SGh8Y0Hird1ia9Ctv+2O7yAHlpruaj2CtAYy089wQ0MUNR3Mgz6MnXSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkoMzrVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkoMzrVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBDA1F000E9;
	Thu, 13 Aug 2026 01:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786584734;
	bh=JQMXTwIUMYN/72eJNBAPGEVp3KvhSScNoacaneGNUbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IkoMzrVcl/+0oRmNsWO6W7GibkzpjIeIPxES5liQs0Qw98+BO59LOQJZKNGcF97fi
	 VDuVs2SiUxo1hKrrtIZOjtMqbtafE/SL0Jp+aYqjqWgzgKppPq4imXZEphY+442SrL
	 b3zwljXv7SUcd0BCI/cVtnirjgjBe8N4VrKRYrv5Oeh5vFr18o+p8TsEkyne4UXM6i
	 w3ukKt5w51kp7Uoh6fMHXMtu2X//sRjU8owdScFkyyKZD6KUa1JPlH5n3Ojtn56NzC
	 l8NBtinde41AxJiwBFaat5/nD4yTcFDolePZ3JBMMILAnvLODJ8FKGMjFC2H77Fiqd
	 qU9GMI3bRKE+g==
From: Jakub Kicinski <kuba@kernel.org>
To: pranav.phansalkar@oss.qualcomm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	mani@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com
Subject: Re: [PATCH v2] net: qrtr: Send HELLO message on endpoint register
Date: Wed, 12 Aug 2026 18:32:13 -0700
Message-ID: <20260813013213.2315080-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807-qrtr-hello-on-ep-register-v2-1-a7f265a42f7e@oss.qualcomm.com>
References: <20260807-qrtr-hello-on-ep-register-v2-1-a7f265a42f7e@oss.qualcomm.com>
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
net: qrtr: Send HELLO message on endpoint register

This moves ownership of the QRTR HELLO handshake from the name server into
the core layer by scheduling a work item at endpoint registration time.
Non-HELLO packets are dropped until a HELLO has been transmitted, tracked by
a new node->hello_sent flag under ep_lock, and the name server no longer
sends a HELLO in reply to an inbound one.

Link: https://lore.kernel.org/r/20260731-qrtr-hello-on-ep-register-v1-1-ddee5b1bfaec@oss.qualcomm.com

> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index d02ef9a74c3c..7adc0a053125 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c

[ ... ]

> @@ -341,6 +349,14 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  	size_t len = skb->len;
>  	int rc, confirm_rx;
>  
> +	mutex_lock(&node->ep_lock);
> +	if (!node->hello_sent && type != QRTR_TYPE_HELLO) {
> +		mutex_unlock(&node->ep_lock);
> +		kfree_skb(skb);
> +		return 0;
> +	}
> +	mutex_unlock(&node->ep_lock);
> +

[Severity: High]
Should this gate return 0 after freeing the skb?  A few lines further down in
the same function, the semantically identical "peer is gone" case reports an
error instead:

	mutex_lock(&node->ep_lock);
	rc = -ENODEV;
	if (node->ep)
		rc = node->ep->xmit(node->ep, skb);
	else
		kfree_skb(skb);

qrtr_sendmsg() then translates the new 0 into a full-length success:

	rc = enqueue_fn(node, skb, type, &ipc->us, addr);
	if (rc >= 0)
		rc = len;

so userspace is told the payload went out while the skb was discarded, with
no way to retry.  Would -EAGAIN or -ENETDOWN be more honest here?

The ns.c senders are affected the same way.  They only distinguish negative
errnos (-ENODEV versus other), so NEW_SERVER/DEL_SERVER/BYE/DEL_CLIENT and
the announce_servers() reply to an inbound HELLO are all recorded as
delivered and never retried or logged.

The case that looks least recoverable is QRTR_TYPE_RESUME_TX.  Inbound data
does not depend on our own HELLO having been sent, so this path can run
while hello_sent is still false:

qrtr_recvmsg() -> qrtr_send_resume_tx() -> qrtr_node_enqueue(..., QRTR_TYPE_RESUME_TX, ...)

The RESUME_TX is dropped and ret is 0.  Since the peer only clears its
flow->pending when it receives a RESUME_TX, and there is no timeout or
retransmission, does its transmitter stall permanently once it hits
QRTR_TX_FLOW_HIGH?

Note also that this drop path skips the qrtr_tx_flow_failed() compensation
that the other drop paths in this function perform.

>  	confirm_rx = qrtr_tx_wait(node, to->sq_node, to->sq_port, type);
>  	if (confirm_rx < 0) {
>  		kfree_skb(skb);

[ ... ]

> @@ -372,6 +388,8 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  			rc = node->ep->xmit(node->ep, skb);
>  		else
>  			kfree_skb(skb);
> +		if (!rc && type == QRTR_TYPE_HELLO)
> +			node->hello_sent = true;
>  		mutex_unlock(&node->ep_lock);
>  	}

[Severity: Medium]
Is rc == 0 from ep->xmit() strong enough to latch hello_sent?

For MHI, qcom_mhi_qrtr_send() returning 0 only means mhi_queue_skb() placed
the skb in the UL transfer ring.  Actual consumption is reported later via
qcom_mhi_qrtr_ul_callback()/mhi_result->transaction_status, and a channel
reset discards still-queued ring elements.

hello_sent has exactly one initialiser (qrtr_endpoint_register()) and this
one setter, so there is no way to re-arm it.  net/qrtr/mhi.c resets and
re-prepares the channels across suspend/resume without unregistering the
endpoint:

qcom_mhi_qrtr_pm_suspend_late()
	mhi_unprepare_from_transfer(mhi_dev);

qcom_mhi_qrtr_pm_resume_early()
	mhi_prepare_for_transfer(mhi_dev);
	qcom_mhi_qrtr_queue_dl_buffers(mhi_dev);

The qrtr_node therefore survives a full channel reset with hello_sent still
true and say_hello never rescheduled.  Does the freshly re-armed channel
then never see a HELLO, leaving the peer in the same wait-for-HELLO state
this patch exists to break?

>  	/* Need to ensure that a subsequent message carries the otherwise lost
> @@ -379,6 +397,9 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  	if (rc && confirm_rx)
>  		qrtr_tx_flow_failed(node, to->sq_node, to->sq_port);
>  
> +	if (rc && type == QRTR_TYPE_HELLO)
> +		schedule_work(&node->say_hello);
> +

[Severity: High]
Can this become a tight self-requeuing loop?  qrtr_hello_work() is itself
the caller of this enqueue, and there is no delayed_work, no retry counter
and no backoff:

qrtr_hello_work()
	alloc_skb(GFP_KERNEL)
	qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, ...)
		mutex_lock(&node->ep_lock)
		node->ep->xmit() fails
		schedule_work(&node->say_hello)   /* same work, zero delay */

Persistent failures look reachable:

drivers/bus/mhi/host/main.c:mhi_queue() {
	...
	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
		return -EIO;
	...
}

so a crashed or wedged modem link gives -EIO forever.  qcom_smd_qrtr_send()
propagates rpmsg_send() errors, skb_put_padto() can return -ENOMEM, and
after qrtr_endpoint_unregister() sets node->ep = NULL the enqueue returns
-ENODEV for as long as a node reference is outstanding.

qrtr_tx_wait() returns 0 immediately for non-DATA types, so nothing in the
loop rate limits it.  Does this spin a worker on system_percpu_wq and hammer
the skb allocator until the transport recovers or the last node reference
drops and __qrtr_node_release() runs cancel_work_sync()?

>  	return rc;
>  }
>  

[ ... ]

> @@ -570,6 +591,35 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt,
>  	return skb;
>  }
>  
> +static void qrtr_hello_work(struct work_struct *work)
> +{
> +	struct sockaddr_qrtr from = {AF_QIPCRTR, 0, QRTR_PORT_CTRL};
> +	struct sockaddr_qrtr to = {AF_QIPCRTR, 0, QRTR_PORT_CTRL};
> +	struct qrtr_ctrl_pkt *pkt;
> +	struct qrtr_node *node;
> +	struct qrtr_sock *ctrl;
> +	struct sk_buff *skb;
> +
> +	node = container_of(work, struct qrtr_node, say_hello);
> +
> +	/* NS must be bound before we can send */
> +	ctrl = qrtr_port_lookup(QRTR_PORT_CTRL);
> +	if (!ctrl)
> +		return;
> +
> +	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
> +	if (!skb) {
> +		qrtr_port_put(ctrl);
> +		return;
> +	}
> +

[Severity: High]
Do these two early returns abandon the handshake for good?

The changelog says the work item sends a HELLO "once the name server is
bound, retrying on failure", but the only retry is the schedule_work() in
the rc-failure branch of qrtr_node_enqueue().  Neither of these returns
reaches it, and neither leaves a pending work item, timer or wakeup.
node->hello_sent stays false, and nothing else in the tree sets it.

For the allocation case the trigger is just a failed GFP_KERNEL alloc_skb()
under memory pressure:

qrtr_endpoint_register()
	schedule_work(&node->say_hello)
		qrtr_hello_work()
			qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL) == NULL
			return    /* no re-arm */

From then on, does the new gate in qrtr_node_enqueue() free every
DATA/RESUME_TX/BYE/DEL_CLIENT/NEW_SERVER packet for that node for the rest
of its lifetime, even though the transport probe reported success?

The name-server broadcast HELLO cannot rescue it either, because the same
patch makes qrtr_bcast_enqueue() skip nodes with nid == QRTR_EP_NID_AUTO,
which is the state of every freshly registered in-tree endpoint (mhi, smd
and tun all pass QRTR_EP_NID_AUTO).

The comment "NS must be bound before we can send" describes a wait that
does not seem to be implemented - there is no retry or wakeup when the CTRL
port later appears.  In-tree this is unlikely to fire because qrtr_ns_init()
binds QRTR_PORT_CTRL from qrtr_proto_init() before any transport can
register, but the consequence is the same as the allocation failure.

> +	pkt->cmd = cpu_to_le32(QRTR_TYPE_HELLO);
> +	from.sq_node = qrtr_local_nid;
> +	to.sq_node = node->nid;
> +	qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, &from, &to);
> +	qrtr_port_put(ctrl);
> +}
> +

[ ... ]

> @@ -605,6 +658,9 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
>  	mutex_unlock(&qrtr_node_lock);
>  	ep->node = node;
>  
> +	/* Initiate HELLO handshake from the core layer */
> +	schedule_work(&node->say_hello);
> +

[Severity: Medium]
Is it safe for registration itself to trigger a hardware transmit before the
registering transport driver has finished bringing its channels up?

net/qrtr/mhi.c probes in this order:

qcom_mhi_qrtr_probe()
	mhi_prepare_for_transfer(mhi_dev);
	rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
	if (rc)
		goto err_unprepare;
	rc = qcom_mhi_qrtr_queue_dl_buffers(mhi_dev);

The work runs on system_percpu_wq and can execute on another CPU
concurrently with the rest of the probe, so qrtr_hello_work() ->
qrtr_node_enqueue() -> qcom_mhi_qrtr_send() -> mhi_queue_skb() can ring the
UL doorbell while the DL ring still holds zero host-posted, device-writable
buffers.

Can the modem's HELLO/control reply be lost in that window?  With the name
server no longer replying to an inbound HELLO and hello_sent latched on the
UL enqueue, there does not appear to be a way to recover from a lost reply.
If qcom_mhi_qrtr_queue_dl_buffers() then fails, the probe unwinds with
qrtr_endpoint_unregister() and mhi_unprepare_from_transfer() after a HELLO
has already been put on the wire.

>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(qrtr_endpoint_register);
> @@ -879,6 +935,11 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  
>  	mutex_lock(&qrtr_node_lock);
>  	list_for_each_entry(node, &qrtr_all_nodes, item) {
> +		/* Skip nodes whose node ID is not yet known; they cannot
> +		 * receive broadcast packets before the HELLO handshake.
> +		 */
> +		if (node->nid == QRTR_EP_NID_AUTO)
> +			continue;

[Severity: Low]
The comment talks about the HELLO handshake, but the test is on node->nid
rather than the new node->hello_sent flag.  The two are independent.

node->nid only leaves QRTR_EP_NID_AUTO in qrtr_node_assign(), i.e. from a
driver-supplied nid (mhi, smd and tun all pass QRTR_EP_NID_AUTO) or from the
src_node of a received packet.  hello_sent is set after a successful HELLO
xmit.

So a node can have hello_sent == true with nid still QRTR_EP_NID_AUTO (we
greeted it but it has not sent us anything yet) and be excluded from every
broadcast (NEW_SERVER/DEL_SERVER/BYE/DEL_CLIENT and the ns.c HELLO)
indefinitely, even though the handshake the comment refers to completed.

Conversely, a node with a known nid but hello_sent == false passes this
filter and is then dropped by the gate in qrtr_node_enqueue().  Could the
comment be reworded to describe the nid condition it actually implements?

[Severity: Low]
Should this read of node->nid be annotated?  It is written under a
spinlock:

qrtr_node_assign() {
	spin_lock_irqsave(&qrtr_nodes_lock, flags);
	radix_tree_insert(&qrtr_nodes, nid, node);
	if (node->nid == QRTR_EP_NID_AUTO)
		node->nid = nid;
	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
}

but the new readers hold only qrtr_node_lock here, and no lock at all in
qrtr_hello_work() ("to.sq_node = node->nid;"), so the lockset intersection
for node->nid is empty.

This turns a racy value into a control-flow decision: qrtr_endpoint_post()
-> qrtr_node_assign() on another CPU can give the node a valid nid right
after the check, and the broadcast is then silently skipped for that node
with no retransmission.  qrtr_hello_work() may likewise build the HELLO with
a stale QRTR_EP_NID_AUTO destination.  Taking qrtr_nodes_lock would not
close the check/act window, so would a READ_ONCE() plus a note about the
race be the intent here?

>  		skbn = pskb_copy(skb, GFP_KERNEL);
>  		if (!skbn)
>  			break;
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index b3f9bbcf9ab9..14262623d2dd 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c

[ ... ]

> @@ -349,15 +350,8 @@ static int say_hello(struct sockaddr_qrtr *dest)
>  	return ret;
>  }
>  
> -/* Announce the list of servers registered on the local node */
>  static int ctrl_cmd_hello(struct sockaddr_qrtr *sq)
>  {
> -	int ret;
> -
> -	ret = say_hello(sq);
> -	if (ret < 0)
> -		return ret;
> -
>  	return announce_servers(sq);
>  }

[Severity: Medium]
With this removal, is there anything left in the kernel that emits a HELLO
in response to an inbound HELLO?  say_hello() now has qrtr_ns_init() as its
only caller, and qrtr_endpoint_post() has no HELLO handling of its own - it
just forwards control packets to the NS socket.

The core layer sends exactly one HELLO per endpoint registration and latches
node->hello_sent = true as soon as ep->xmit() returns 0.  If that single
HELLO is accepted by the transport but not consumed by the remote QRTR
stack, no further HELLO is generated, not even when the remote later sends
its own.  Is that not the same stall class the patch sets out to fix?

While hello_sent is still false, an inbound HELLO cannot bootstrap the link
either, since the announce_servers() reply is discarded by the new gate in
qrtr_node_enqueue().

The changelog describes this hunk as pure de-duplication:

    - Remove say_hello() from the name server's ctrl_cmd_hello() handler;
      the core layer is now the sole sender of the outbound HELLO.

Could it also mention that the reply-on-receive recovery behaviour is being
removed?
-- 
pw-bot: cr
