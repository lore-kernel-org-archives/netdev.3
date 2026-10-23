Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792732450;
	b=En4MRpwQwCwBTtvX0fJkbscfKstRi4kNTNDDNnlygIBB2CJj0vyIEGgm4xhIlrBqTF22
	 QP3wGQW5sWw9k++KjAqqAJLp+U2pQ70G7/YjXfvFE7DVRZfDHSwIr8cgkz6m5CAAXh29H
	 GhdLV48v7+swHDJ2/DajItUvwXWcNcPkIK201qYPvqWIoRVfF1aNnIIK0TrIgLGxz7NXj
	 BicmII9ivepPOGtfPgSDD7o+8nP5mQKnLwkjp7bro9CP3MPLQTltN33ypQmzWKSKjwFCD
	 9HR5YyN9/mdc3Jweb32d1kUH21rg81eDbnInamRTMaQlMLbgv/frC8oDMfGzbTmFWdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732450;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/sy7g4D+Ct+QfqtJ/+4EFOAgm3xrpivnxb24FrepwAo=;
	b=Z7O8qvxjtpYhinrCYbCAx0WmL75CBxCM0zXO3qjelPxnRNdw+8/HdpEnAETK2VjbsqeM
	 NmNDe+Txm9qeO+PLGNFyuJykZFM5vEkcvD+XEFE0fNKPqaATUd0sBW5hv19Ub2qHuzsuT
	 O8u7iWn6S21PaoezSpEIsvNZRculnbBQ29X6CRb2/qJ5OMP5T46NpuM0CZzTpFcszuWTQ
	 J+pd1J0w4RTequXRyZaMNe2ugwybMcLZ3TM2e4ULRzEscCKDBCC1zF9Vu/FFNzzgfl0PU
	 pVJs2ax8+T7vDVdklvZlvxfQnz5OPQ4tir5fFf1To6UPOUFmkmh6eNULUWHSL3jJOlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ROo3UrtT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE2606A31F;
	Fri, 23 Oct 2026 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ROo3UrtT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0AD1F01825;
	Fri, 23 Oct 2026 05:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792732449;
	bh=/sy7g4D+Ct+QfqtJ/+4EFOAgm3xrpivnxb24FrepwAo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ROo3UrtTvt2EDavuHQOPPLqtEgdgOvu6g9NK2spN10zeX08ZeMRH/3SntVRUKDqLf
	 p50ah3c5Ndwt+OtymyhR6PKZ27n3LLoaSTMLgTDjzzMKkgiydcEFTpnFYIYTb+0dNt
	 9hqLG/l/5KUQzaFa37XPLsAhkYjOE0WtPir9QDRGtxSM0TjHlclzYdRhW0CbQ1/gbc
	 Gao/Y7Wv9Xa3TL9ra8mx38uBRgQzMtMouPKFdn8puQL6outlwihfJOOlbkUeskZt4R
	 3lzQ3TbjTZQm4t1aWOLwDVPdZ+LXKrP1fwPQPev3HDdWXEUwExqS0Qbtb0lTI3kVi3
	 ADQL+S3mReYYQ==
Subject:
 Re: [PATCH 1/2] net: qrtr: ns: keep going when an announcement cannot be sent
From: netdev-bot+sashiko@kernel.org
To: igor.opaniuk@oss.qualcomm.com
Cc: mani@kernel.org, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, pranav.phansalkar@oss.qualcomm.com,
 christopher.lew@oss.qualcomm.com, deepak.singh@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 05:14:07 +0000
Message-ID: <179273244795.3134.17153116106017337905@kernel.org>
In-Reply-To:
 <20261019-upstream-qrtr-hello-gate-fix_b4-v1-1-bd420aec171b@oss.qualcomm.com>
References:
 <20261019-upstream-qrtr-hello-gate-fix_b4-v1-1-bd420aec171b@oss.qualcomm.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Several statements in the commit message do not match the
  code, and they overstate what the patch fixes and why.
- [Medium] announce_servers() (net/qrtr/ns.c:228-237) no longer stops at
  the first failed send.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  leaves it next to the code it changes.
- [Low] This problem wasn't introduced by this patch, but it limits what
  the ctrl_cmd_new_server() change can achieve.

--

net: qrtr: ns: keep going when an announcement cannot be sent

This patch changes announce_servers() so it logs a failed announcement and
moves on to the next local server instead of returning. It also changes
ctrl_cmd_new_server() so a failed broadcast of a new local server no
longer skips the lookup_notify() loop.

> ctrl_cmd_new_server() returns
> before lookup_notify() when the broadcast of a new local server fails,
> so lookups already registered for that service, including the ones of
> remote nodes, are never told the server exists.
>
> A send failure to one node says nothing about the others. Log it and
> carry on in both places.

[Severity: Medium]
Can a remote node have a lookup in qrtr_ns.lookups at all? Lookups are
only added in ctrl_cmd_new_lookup(), and that function rejects
non-local senders:

net/qrtr/ns.c:ctrl_cmd_new_lookup() {
    ...
	/* Accept only local observers */
	if (from->sq_node != qrtr_ns.local_node)
		return -EINVAL;
    ...
}

So every lookup the patch now notifies seems to belong to a local
observer.

Does "a send failure to one node says nothing about the others" apply to
announce_servers()? Each service_announce_new(sq, srv) call in its
xa_for_each() loop goes to the same sq, the one node that sent HELLO. The
loop walks servers, not nodes.

The most likely failure there is the -EAGAIN that qrtr_node_enqueue()
returns before HELLO has gone out to that node:

net/qrtr/af_qrtr.c:qrtr_node_enqueue() {
    ...
	if (!node->hello_sent && type != QRTR_TYPE_HELLO) {
		mutex_unlock(&node->ep_lock);
		kfree_skb(skb);
		return -EAGAIN;
	}
    ...
}

In that case every later send fails the same way. With this patch alone,
would the node still learn about none of the servers?

For ctrl_cmd_new_server(), qrtr_bcast_enqueue() always returns 0. That
leaves errors raised in qrtr_sendmsg() before enqueue, which in practice
means -ENOMEM from sock_alloc_send_skb(). Could the commit message say
that this half of the change only matters under allocation failure?

The next patch in the series, "net: qrtr: hold control packets behind the
HELLO gate instead of dropping them", only touches af_qrtr.c and does not
change any of the above. Since this patch has a Fixes: tag, could the
description be made more accurate?

> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index bcb090ee79d49..dfc2cdad688f7 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -232,7 +232,7 @@ static int announce_servers(struct sockaddr_qrtr *sq)
>  				continue;
>  
>  			pr_err("failed to announce new service\n");
> -			return ret;
> +			/* the remote needs the other servers no less */
>  		}
>  	}
>  	return 0;

[Severity: Medium]
With the return removed, announce_servers() walks every local server, up
to QRTR_NS_MAX_SERVERS (256). It calls the non-ratelimited pr_err() once
for each failed send. All sends go to the same sq, so a failure tied to
that destination happens again on every iteration.

Can one HELLO now produce up to 256 KERN_ERR lines, where before it
produced at most one?

An unprivileged local user in init_net seems able to trigger this.
qrtr_create() has no capability check. qrtr_ns_worker() dispatches on the
cmd in the payload, and ctrl_cmd_hello() checks neither origin nor
privilege before calling announce_servers().

Suppose a socket shrinks SO_RCVBUF, never reads, and sends a payload with
cmd QRTR_TYPE_HELLO to (local_node, QRTR_PORT_CTRL). Once its queue is
full, each reply is rejected in qrtr_local_enqueue():

net/qrtr/af_qrtr.c:qrtr_local_enqueue() {
    ...
	if (sock_queue_rcv_skb(&ipc->sk, skb)) {
		qrtr_port_put(ipc);
		kfree_skb(skb);
		return -ENOSPC;
	}
    ...
}

The -ENODEV check does not filter -ENOSPC, so every server logs a line.
The user can also raise the count by registering servers from other
sockets.

The same flood happens on the normal path when a remote HELLO arrives
before the local HELLO has gone out to that node, because
qrtr_node_enqueue() returns -EAGAIN for each announcement. The last patch
in the series turns that -EAGAIN into a backlog of at most 64 packets.
That narrows this path, but it still floods with more than 64 servers.
The -ENOSPC path is unchanged at the end of the series.

Would pr_err_ratelimited(), or a single message after the loop, work
better here?

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch.
ctrl_cmd_bye() and ctrl_cmd_del_client() still stop at the first error,
and in those loops each iteration goes to a different local port:

net/qrtr/ns.c:ctrl_cmd_bye() {
    ...
	xa_for_each(&local_node->servers, index, srv) {
		...
		ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
		if (ret < 0 && ret != -ENODEV) {
			pr_err("failed to send bye cmd\n");
			goto delete_node;
		}
	}
    ...
}

ctrl_cmd_del_client() does the same thing with "return ret".

qrtr_local_enqueue() returns -ENOSPC when a single receiver's queue is
full. Can one local server that never reads its socket then prevent every
server after it, in port order, from learning that a remote node or
client has gone away?

An unprivileged user can set this up, since anyone can bind ports
>= QRTR_MIN_EPH_SOCKET. The later patch in the series, "net: qrtr: hold
control packets behind the HELLO gate instead of dropping them", does not
change these loops.

Should these loops also log and continue?

> @@ -488,10 +488,12 @@ static int ctrl_cmd_new_server(struct sockaddr_qrtr *from,
>  
>  	if (srv->node == qrtr_ns.local_node) {
>  		ret = service_announce_new(&qrtr_ns.bcast_sq, srv);
> -		if (ret < 0) {
> +		/*
> +		 * A failed broadcast must not hide the server from the
> +		 * lookups already registered for it.
> +		 */
> +		if (ret < 0)
>  			pr_err("failed to announce new service\n");
> -			return ret;
> -		}
>  	}
>  
>  	/* Notify any potential lookups about the new server */

[Severity: Low]
This isn't a bug introduced by this patch, but qrtr_bcast_enqueue()
limits which errors this check can ever see:

net/qrtr/af_qrtr.c:qrtr_bcast_enqueue() {
    ...
	list_for_each_entry(node, &qrtr_all_nodes, item) {
		...
		skbn = pskb_copy(skb, GFP_KERNEL);
		if (!skbn)
			break;
		skb_set_owner_w(skbn, skb->sk);
		qrtr_node_enqueue(node, skbn, type, from, to);
	}
	mutex_unlock(&qrtr_node_lock);

	qrtr_local_enqueue(NULL, skb, type, from, to);

	return 0;
}

The per-node results from qrtr_node_enqueue() and qrtr_local_enqueue()
are ignored. A pskb_copy() failure skips all the remaining remote nodes,
and the function still returns 0.

That means the ret < 0 check here only sees errors from qrtr_sendmsg()
before enqueue, mainly -ENOMEM from sock_alloc_send_skb().

Under memory pressure, can the remote nodes after a failed pskb_copy()
miss this NEW_SERVER broadcast without ns.c ever finding out?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-upstream-qrtr-hello-gate-fix_b4-v1-0-bd420aec171b%40oss.qualcomm.com
