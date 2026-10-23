Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792732451;
	b=ZSE2PPRpGzpr6DumhZ5XqnG/8h8OEI+cVJjAaCHMMv+DS++jn1Cw/wtVB50LcXosUDVL
	 dxItnJ1mB7EbpX4XvR0K7/zcA4q3bjoC8xTdODrZCo0BPUXn7e6EvqAAuVRkEIyxV6lRX
	 lo31EaSAJx6+xeVaDJgGS5sUFZu7jbf6TU54RSPLrFXwd90wGSgy//FaZjuFlvtN5mhhU
	 vekailCqJivcMGEzx0NQZ145zZalxsgsRDtqHGugQaOr23y5QFF6neeEwlVLuLCMuqXRB
	 6btdt67E+USObFEXJpzeiF0on9IiUsNMR8v7z8iY39pM6s9oJfAAvEm820ZMRSk+k8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732451;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XmOqjm4WHiCD0kYoV42fLK9W2WlzXMBzTDJHyAOsiDY=;
	b=Q6xHSN6KRP04jmCzVkStMCW6Z2MRJroahJCRoogqdwNyB3f37LyOk+AkZzNHwB/WqanF
	 AahEAFo2raGobiH47GZTrFfrJGW9aSF6H/pYOfxnDa5Dxby/+KTGuCZLavLnzRdNE09Z4
	 2XI7MZeafUT5C0PkZN5h21aDTQNgz2MIPsZoRDmDZnFwelHNyju2nh1SHJHFwT4kQDWnB
	 XmPbYzd2LX61J86DMW2Fm1c4rV7mGX59IIZKKDEPZnF+wBsN37VikLeFt4YB1+ekhhHlN
	 SNjdxDqrjiKr6lxSt9rHueUFFea/fO7KQRh3m1LVDsU8oRfmrWcCQwN0J6CrxnQREuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9SBfMhd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB7606A320;
	Fri, 23 Oct 2026 05:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9SBfMhd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFFB1F01828;
	Fri, 23 Oct 2026 05:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792732450;
	bh=XmOqjm4WHiCD0kYoV42fLK9W2WlzXMBzTDJHyAOsiDY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E9SBfMhdaeXijwTiDxd6JAnOZS4oHp1ESRlG2s4Jti+NZn614SjnsJ2/5sd0WyAT1
	 hBflTigqeufbQM4lX6OPhDYHlJeDfhmveXMe7v9mhJJm8B7RPBcXgzL8L90w5yQtMG
	 APPmxfEVqgfEu8eNJOEcQBUVwmEH/ijMF1BS62P25RyHhds7JynLvUox8b2ZZZhvp2
	 0kpZUD1UL32vtZPDHWnObVP2JIj8KxawDsqTZjvBVQIFbu5tVGtAP+lyO/FvywvtmC
	 9BvUZsMTBcpI5SAfV359TA27inPv1kHA0n13nZb/B7mygkGJlSJq63Orq7k5AqUgDx
	 UeHjx7iBv5z2g==
Subject: Re: [PATCH 2/2] net: qrtr: hold control packets behind the HELLO gate
 instead of dropping them
From: netdev-bot+sashiko@kernel.org
To: igor.opaniuk@oss.qualcomm.com
Cc: mani@kernel.org, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, pranav.phansalkar@oss.qualcomm.com,
 christopher.lew@oss.qualcomm.com, deepak.singh@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 05:14:09 +0000
Message-ID: <179273244924.3134.5322268137744281672@kernel.org>
In-Reply-To:
 <20261019-upstream-qrtr-hello-gate-fix_b4-v1-2-bd420aec171b@oss.qualcomm.com>
References:
 <20261019-upstream-qrtr-hello-gate-fix_b4-v1-2-bd420aec171b@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In net/qrtr/af_qrtr.c, held socket buffers keep their owner
  socket (skb->sk) and do not take a reference on it.
- [Medium] The HELLO is only re-armed when qrtr_node_enqueue() returns
  -EAGAIN (`if (rc == -EAGAIN && type == QRTR_TYPE_HELLO)…
- [Medium] qrtr_node_flush_backlog() (af_qrtr.c:353-364) sends each held
  control packet once.
- [Low] The check that refuses DATA packets before the HELLO
  (af_qrtr.c:379-385) and the later decision to queue into the backlog…
- [Low] qrtr_node_flush_backlog() sends up to 64 queued packets through
  node->ep->xmit() in one ep_lock critical section, the same one that…

--

net: qrtr: hold control packets behind the HELLO gate instead of dropping them

With this commit, control packets sent to a node whose HELLO has not gone
out yet are put on a new per-node tx_backlog, bounded to 64 entries.
Before, they were refused with -EAGAIN. The backlog is flushed right after
the HELLO succeeds and purged when the endpoint goes away, and data
packets are still refused before the HELLO.

> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index e7b3647424b8f..071fa980fae2e 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c

[ ... ]

> @@ -340,6 +343,26 @@ static void qrtr_tx_flow_failed(struct qrtr_node *node, int dest_node,
>  	}
>  }
>  
> +/*
> + * Control packets for a node whose HELLO has not gone out yet are held back
> + * and sent right after it; this bounds how many.
> + */
> +#define QRTR_TX_BACKLOG_MAX	64
> +
> +/* Send the control packets held back until the HELLO, in order. */
> +static void qrtr_node_flush_backlog(struct qrtr_node *node)
> +{
> +	struct sk_buff *skb;
> +
> +	lockdep_assert_held(&node->ep_lock);
> +
> +	while ((skb = skb_dequeue(&node->tx_backlog))) {
> +		if (node->ep->xmit(node->ep, skb))
> +			pr_warn_ratelimited("qrtr: held control packet to node %u lost\n",
> +					    node->nid);

[Severity: Medium]
If ep->xmit() fails here, the held packet is gone. The original sender got
rc == 0 when the packet was queued, so nobody retries it. The flush also
keeps going and qrtr_tx_flow_failed() is not called.

Are transient errors likely right after the HELLO? On glink the HELLO uses
up a remote rx intent. The next send can then go through
qcom_glink_request_intent(), which returns -ETIMEDOUT after 10 seconds or
-EAGAIN when the remote declines:

drivers/rpmsg/qcom_glink_native.c:qcom_glink_request_intent() {
    ...
	} else {
		ret = READ_ONCE(channel->intent_req_result) ? 0 : -EAGAIN;
	}
    ...
}

This patch retries the HELLO every 100 ms for that same condition.

On MHI, qcom_mhi_qrtr_send() uses the non-blocking mhi_queue_skb(), and
mhi_queue() fails once the ring is full:

drivers/bus/mhi/host/main.c:mhi_queue() {
    ...
	ret = mhi_is_ring_full(mhi_cntrl, tre_ring);
	if (unlikely(ret))
		return -EAGAIN;
    ...
}

pci_generic.c configures the IPCR UL channel with 8 elements:

	MHI_CHANNEL_CONFIG_UL(20, "IPCR", 8, 0),

Sending up to QRTR_TX_BACKLOG_MAX packets back to back can overflow that
ring.

Could the RMTFS NEW_SERVER announcement still be lost this way? Would it
make sense to stop the flush on error and leave the remaining packets
queued for a retry?

> +	}
> +}

[ ... ]

> @@ -349,8 +372,12 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  	size_t len = skb->len;
>  	int rc, confirm_rx;
>  
> +	/*
> +	 * Data before the HELLO is refused: it would count against the flow
> +	 * control window. Control packets are held back further down.
> +	 */
>  	mutex_lock(&node->ep_lock);
> -	if (!node->hello_sent && type != QRTR_TYPE_HELLO) {
> +	if (!node->hello_sent && type == QRTR_TYPE_DATA) {
>  		mutex_unlock(&node->ep_lock);
>  		kfree_skb(skb);
>  		return -EAGAIN;

[ ... ]

> @@ -383,13 +410,29 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  
>  	if (!rc) {
>  		mutex_lock(&node->ep_lock);
> -		rc = -ENODEV;
> -		if (node->ep)
> -			rc = node->ep->xmit(node->ep, skb);
> -		else
> +		if (!node->ep) {
>  			kfree_skb(skb);
> -		if (!rc && type == QRTR_TYPE_HELLO)
> -			node->hello_sent = true;
> +			rc = -ENODEV;
> +		} else if (!node->hello_sent && type != QRTR_TYPE_HELLO) {

[Severity: Low]
Can a DATA packet end up on tx_backlog here? The DATA check at the top of
qrtr_node_enqueue() and this check are in separate ep_lock sections. For
DATA, qrtr_tx_wait() can sleep between them.

Suppose qrtr_endpoint_hello() runs in that gap, as it does on the MHI
resume path:

qrtr_endpoint_hello()
	mutex_lock(&node->ep_lock);
	node->hello_sent = false;
	mutex_unlock(&node->ep_lock);

The DATA packet then matches this condition and is queued with rc == 0
instead of being refused. That contradicts "Keep refusing data packets" in
the commit message and the new comment above the first check.

That packet has already been counted in flow->pending and may carry
confirm_rx. If its xmit fails later in qrtr_node_flush_backlog(),
qrtr_tx_flow_failed() is never called. It also takes one of the 64 backlog
slots.

Should the DATA refusal be checked again here?

> +			/*
> +			 * The remote may not take traffic yet (a freshly
> +			 * booted remoteproc without rx intents). Dropping
> +			 * here would lose name server announcements for
> +			 * good, so hold them until the HELLO is out.
> +			 */
> +			if (skb_queue_len(&node->tx_backlog) < QRTR_TX_BACKLOG_MAX) {
> +				skb_queue_tail(&node->tx_backlog, skb);

[Severity: High]
Can the queued skb outlive the socket that owns it? The skb keeps skb->sk,
and no socket reference is taken before it goes on tx_backlog.

One path is closing a bound qrtr socket while a node with an assigned nid
still has hello_sent == false:

qrtr_release()
  qrtr_port_remove()
    skb_set_owner_w(skb, &ipc->sk);
    qrtr_bcast_enqueue()
      skb_set_owner_w(skbn, skb->sk);
      qrtr_node_enqueue()
        skb_queue_tail(&node->tx_backlog, skb);   <- returns 0
    __sock_put(&ipc->sk);
  sock_put(sk);                                   <- sk_refcnt reaches 0

>From then on, only the sk_wmem_alloc charge of the queued skb keeps the
struct sock in memory.

When the HELLO later succeeds, qrtr_node_flush_backlog() calls ep->xmit().
For MHI that is qcom_mhi_qrtr_send():

net/qrtr/mhi.c:qcom_mhi_qrtr_send() {
    ...
	if (skb->sk)
		sock_hold(skb->sk);
    ...
}

Wouldn't this hit the "refcount_t: addition on 0; use-after-free" warning
and saturate sk_refcnt?

The !hello_sent window can be open at three points:

- at probe, after the remote's first packet assigns the nid but before
  the HELLO succeeds
- while the HELLO is being retried every 100 ms
- after qrtr_endpoint_hello() sets hello_sent = false on MHI resume

Before this patch, these skbs were sent or freed synchronously while the
sender still held its references. Would calling skb_orphan() before
skb_queue_tail(), or holding a socket reference for each queued skb, avoid
this?

> +			} else {
> +				kfree_skb(skb);
> +				rc = -EAGAIN;
> +			}

[Severity: Medium]
What happens to the held packets if the HELLO fails with an error other
than -EAGAIN? The retry is only armed for -EAGAIN:

	if (rc == -EAGAIN && type == QRTR_TYPE_HELLO)
		schedule_delayed_work(&node->say_hello, msecs_to_jiffies(100));

qrtr_hello_work() also ignores the return value of qrtr_node_enqueue().

There are a few ways to get a different error. On glink,
qcom_glink_request_intent() returns -ETIMEDOUT when the remote does not
answer the intent request within 10 seconds. skb_put_padto() or
skb_linearize() can also fail with -ENOMEM.

hello_sent then stays false until the endpoint is unregistered or
qrtr_endpoint_hello() is called. Only mhi.c calls it, on resume.

The first 64 control packets to that node are queued with rc == 0 and
never sent. These include announce_servers() replies and the NEW_SERVER,
DEL_SERVER and DEL_CLIENT broadcasts.

Before this patch the senders got -EAGAIN, and ns.c logged "failed to
announce new service". Now the name server sees success for packets that
never go out.

The held skbs also stay charged to their senders' sk_wmem_alloc with no
time limit, and that includes the in-kernel name server socket.

Does the backlog depend on the -EAGAIN retry always succeeding in the end?

> +		} else {
> +			rc = node->ep->xmit(node->ep, skb);
> +			if (!rc && type == QRTR_TYPE_HELLO) {
> +				node->hello_sent = true;
> +				qrtr_node_flush_backlog(node);

[Severity: Low]
This sends up to 64 packets through ep->xmit() while still holding the
ep_lock taken for the HELLO. It runs from qrtr_hello_work() on the system
workqueue.

On glink each send can sleep up to 10 seconds, either in qcom_glink_tx()
waiting for FIFO space or in qcom_glink_request_intent(). The case this
patch targets is a remote that is alive but short of intents. Such a
remote could keep ep_lock held for a long time.

Every other sender to this node blocks on the first
mutex_lock(&node->ep_lock) in qrtr_node_enqueue() for the whole flush,
not for a single xmit as before. That includes the name server worker.

Teardown on glink is not blocked, because qcom_glink_native_remove() sets
abort_tx first, and MHI xmit does not block.

Is it intended to hold ep_lock for the whole drain?

> +			}
> +		}
>  		mutex_unlock(&node->ep_lock);
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-upstream-qrtr-hello-gate-fix_b4-v1-0-bd420aec171b%40oss.qualcomm.com
