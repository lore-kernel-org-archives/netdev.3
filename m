Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD142765E2;
	Wed, 23 Sep 2026 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177526; cv=none; b=JzAs11aJguqa/bCWQ97vcMRFD6tRwU0dS5YnpBhkDMFLrfGHKmijlOJbwI4DUjMoEpxzDNxSH3U3EuaK9nqP8wyUW5O5BsjHG+GEt6Z7LwdhlOYOC32iGWewuOYFdbsSSeOdOfPzNEE1etf+Jx506H8n8PecAoa/JkSuhIT5lCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177526; c=relaxed/simple;
	bh=16GtAyWXg9XHT6NYcnN6c6+63crY4W8msaHGFRCzii4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXMI82gydl9u2w9wiRvvoa3Od4/YXfGloy6y+3/rkxfYRT+m+3AF8ly4zQ8D8ZBPCHXVMMajvsUg1zGVokTUoiSZXOjQv5rKtgJoKTI5ve/SQxB7npXd6XNz73+pqM3tJ6Uz/N8d3s25X94WbfsZ2oPeEFxXLCboR3KwT7KqXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQrd7bY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQrd7bY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AF51F000FF;
	Wed, 23 Sep 2026 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177517;
	bh=U1Bvd6/p/gkQXGYEOxDXN7iUZg0k/gL9HPhVzPJ3J5o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KQrd7bY3+yTVOBqTgyfdP0Yqd7j6FFJkIPqNGFL8t1+/xnf9K+ZSMfc2WXZ0y8mTv
	 FgeAafl+mjI/N1YuknJtgANlyVLJRFGoa8UpN7Zm4KtimcLy3duVE42sw+zlju0bNa
	 iTUaODYP82jQKSiNmCRavjXzuwhKpcyNKvtf+7DJb+WLv3wTpY12ONZ5ypOFcOAdxi
	 +6IU4FO+Tj75bqkK/846/OewWIY+jWGLmA74ic3PURKdzg891A3Bifrqu98B1CN0eG
	 LE4+immFNaHHVNEaXKknGA7zdqrMx4jc012cQlGpOb91mzAdYhxmKeivn7iCfzpoeG
	 wjpqWVz7XDl+g==
Subject: Re: [PATCH] net: qrtr: ns: validate msglen and sq_port in
 qrtr_ns_worker() and ctrl_cmd_bye()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 15:31:56 +0000
Message-ID: <179017751615.2160803.4681331359759254914@kernel.org>
In-Reply-To: <20260919212850.3240353-1-benquike@gmail.com>
References: <20260919212850.3240353-1-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Over-broad minimum-length gate in net/qrtr/ns.c:qrtr_ns_worker()
  (lines 645-646, `if (msglen < sizeof(*pkt)) continue;`) silently…
- [Medium] The commit message contains two factually incorrect supporting
  claims.
- [Medium] The new unconditional `if (from->sq_port != QRTR_PORT_CTRL)
  return -EINVAL;` in net/qrtr/ns.c:ctrl_cmd_bye() (lines 350-351) also…

--

net: qrtr: ns: validate msglen and sq_port in qrtr_ns_worker() and ctrl_cmd_bye()

This adds two checks to the in-kernel QRTR nameservice: a minimum length
test of sizeof(struct qrtr_ctrl_pkt) on every control datagram received by
qrtr_ns_worker(), and a requirement that BYE messages arrive with
from->sq_port == QRTR_PORT_CTRL in ctrl_cmd_bye().

A few questions about the commit message and the two new checks below.

> 1. `qrtr_ns_worker()` receives control packets into a single reused
>    4096-byte `recv_buf` via `kernel_recvmsg()` without checking that
>    `msglen >= sizeof(*pkt)` (20 bytes). If a short packet arrives on
>    `qrtr_ns.sock`, `qrtr_ns_worker()` reads stale bytes from previous
>    control messages (or uninitialized heap memory on the first packet)
>    when parsing `pkt->cmd` and its union fields.

[Severity: Medium]
Is the "uninitialized heap memory on the first packet" part accurate?
qrtr_ns_worker() allocates the buffer with kzalloc():

net/qrtr/ns.c:qrtr_ns_worker() {
	recv_buf = kzalloc(recv_buf_size, GFP_KERNEL);
	if (!recv_buf)
		return;
}

so every byte not written by the first kernel_recvmsg() reads as zero.  The
remaining exposure looks like stale data from an earlier, longer datagram
handled in the same worker invocation, since the buffer is reused across
loop iterations without being re-zeroed.  Could the changelog be narrowed
to that, so the bug is not triaged as an uninitialized-memory/infoleak
class issue?

> 2. Unlike `ctrl_cmd_del_client()`, `ctrl_cmd_bye()` does not verify that
>    `from->sq_port == QRTR_PORT_CTRL`, allowing any unprivileged local
>    `AF_QIPCRTR` socket to send a `QRTR_TYPE_BYE` packet and purge all
>    registered services for the local node.

Does ctrl_cmd_del_client() actually contain that check?  The sender
validation there is:

net/qrtr/ns.c:ctrl_cmd_del_client() {
	/* Don't accept spoofed messages */
	if (from->sq_node != node_id)
		return -EINVAL;

	/* Local DEL_CLIENT messages comes from the port being closed */
	if (from->sq_node == qrtr_ns.local_node && from->sq_port != port)
		return -EINVAL;
}

QRTR_PORT_CTRL does not appear, and the second test deliberately requires
the client port being closed rather than the control port.  The new BYE
rule is an unconditional authorization requirement instead of a match to an
existing sibling check, so could the comparison be reworded?

> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index bcb090ee79d4..d7e1a37f0717 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -347,6 +347,9 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
>  	iv.iov_base = &pkt;
>  	iv.iov_len = sizeof(pkt);
>  
> +	if (from->sq_port != QRTR_PORT_CTRL)
> +		return -EINVAL;
> +

[Severity: Medium]
Can this reject BYE messages from remote endpoints that encode their
control source port as the legacy value?  net/qrtr/af_qrtr.c defines:

#define QRTR_PORT_CTRL_LEGACY 0xffff

and qrtr_endpoint_post() only normalizes the destination:

net/qrtr/af_qrtr.c:qrtr_endpoint_post() {
	...
	if (cb->dst_port == QRTR_PORT_CTRL_LEGACY)
		cb->dst_port = QRTR_PORT_CTRL;
}

For QRTR_PROTO_VER_1 the source port is taken raw:

	cb->src_port = le32_to_cpu(v1->src_port_id);

and the v2 path only maps (u16)QRTR_PORT_CTRL, i.e. 0xfffe, not 0xffff.
qrtr_recvmsg() then copies it verbatim:

	addr->sq_port = cb->src_port;

So a BYE arriving with src_port 0xffff would now return -EINVAL before any
teardown runs.  Since ctrl_cmd_bye() is the only place that does:

net/qrtr/ns.c:ctrl_cmd_bye() {
	xa_for_each(&node->servers, index, srv)
		server_del(node, srv->port, true);
	...
delete_node:
	xa_erase(&nodes, from->sq_node);
	kfree(node);
	node_count--;
}

does an early return here leak the struct qrtr_node and all of its struct
qrtr_server objects, keep one of the QRTR_NS_MAX_NODES slots occupied for
the module lifetime, and leave the dead node's services advertised, with
only a rate-limited pr_err as a symptom?

The neighbouring handlers restrict the source port only for local-node
messages:

net/qrtr/ns.c:ctrl_cmd_del_client() {
	/* Local DEL_CLIENT messages comes from the port being closed */
	if (from->sq_node == qrtr_ns.local_node && from->sq_port != port)
		return -EINVAL;
}

Would gating the BYE check on from->sq_node == qrtr_ns.local_node, or
normalizing legacy source ports in qrtr_endpoint_post(), block the local
abuse described in the changelog while keeping remote node cleanup working?

>  	node = node_get(from->sq_node);
>  	if (!node)
>  		return 0;

[ ... ]

> @@ -639,6 +642,9 @@ static void qrtr_ns_worker(struct work_struct *work)
>  			break;
>  		}
>  
> +		if (msglen < sizeof(*pkt))
> +			continue;
> +

[Severity: High]
Does this blanket 20-byte floor drop control packets that the router itself
treats as valid?  qrtr_endpoint_post() only requires the full
struct qrtr_ctrl_pkt for two types:

net/qrtr/af_qrtr.c:qrtr_endpoint_post() {
	if (!size || size > len || len != ALIGN(size, 4) + hdrlen)
		goto err;

	if ((cb->type == QRTR_TYPE_NEW_SERVER ||
	     cb->type == QRTR_TYPE_RESUME_TX) &&
	    size < sizeof(struct qrtr_ctrl_pkt))
		goto err;

	if (cb->dst_port != QRTR_PORT_CTRL && cb->type != QRTR_TYPE_DATA &&
	    cb->type != QRTR_TYPE_RESUME_TX)
		goto err;
}

Everything else with a 4-byte payload is accepted and queued to
QRTR_PORT_CTRL, and qrtr_sendmsg() states the same lower bound for control
port senders:

net/qrtr/af_qrtr.c:qrtr_sendmsg() {
	if (ipc->us.sq_port == QRTR_PORT_CTRL) {
		if (len < 4) {
			rc = -EINVAL;
}

The per-command needs in ns.c look like 4 bytes for HELLO and BYE (neither
handler reads the union), 12 bytes for DEL_CLIENT, NEW_LOOKUP and
DEL_LOOKUP, and 20 bytes only for NEW_SERVER and DEL_SERVER.

With this check, does a 4-byte HELLO get discarded by the bare continue
with no diagnostic, so ctrl_cmd_hello() and announce_servers() never run
and local services are never announced to that node?

And does a 4-byte BYE now skip ctrl_cmd_bye() entirely, leaking the
struct qrtr_node plus its struct qrtr_server objects and consuming a node
slot permanently, since that function is the only node teardown path?

Would per-command length checks mirroring af_qrtr.c (4 /
offsetofend(struct qrtr_ctrl_pkt, client.port) / sizeof(*pkt)), or simply
memset()ing recv_buf at the top of each loop iteration, remove the stale
byte read without dropping traffic the router considers legal?

>  		pkt = recv_buf;
>  		cmd = le32_to_cpu(pkt->cmd);
>  		if (cmd < ARRAY_SIZE(qrtr_ctrl_pkt_strings) &&

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919212850.3240353-1-benquike%40gmail.com
