Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5583C4548;
	Thu, 18 Jun 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774940; cv=none; b=J02+vw8HQhQYE56gwgb4+xPfFqGv/t+VYyIM42HrroF3rH4M0rhk7lk2+OeJq80V+7HqDd1ShtQlsaji6QI//ZIu+dvE1HMYnGkdX5lmZXhhWRsK8IOUyIbHIN/5AhqDLPCpktVD9wK9I+bN5vzDx4O/2Q19V7axfJlKAxj7R1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774940; c=relaxed/simple;
	bh=04V51Do/ddsEblzF46wftbAWhOKq0EbfrQ4E/JQKWsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hru+CsiIga9PeFV/BoEXT0UM9FEBH4rfROdoDVlQBr244qt5MOUE5SEjU7jIGdfu15kwDpU/vR9jhiJ0TC1IgyVm5il7e6fIqk6Lo1mCeEcyaFj2RpLR09mcRmQebhpnOsXxuWO2FSRetuT9hirVEU1baAKkfChmQzhVRK+h4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccEMPgpg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccEMPgpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9826F1F00A3F;
	Thu, 18 Jun 2026 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781774939;
	bh=Jt2XuqikvU1qv2HE6czbAZ3NLNhPzCBmn3S/q0LYmIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ccEMPgpgZDr2r5HleYCD1DmYRxPW9H+sI+eGq/qPeHfXYh1hjIeklNltAyj48EVGU
	 P7zqUFadB8SWecRlwrIH6CyhK7ZpErDfTU1wFzNN2LBBDh9lkaxP7LLTD/g83s5+nR
	 EH4ujJ2OpzFua1x4/DXsXZBpoIjwFrBl40h8XXEPTQKa0cE0eDeIoPsbbf/j3od2Q/
	 eyFx9OfW1yyN9u85Y6fUQyq+VbUCQlq+2FUc9w3rbU/ovE34YLfkQOOFEPRIARMmQn
	 uB9KlQCahemRZbxbXWnqz1wN3LXoj6RTx1SIWoe4Bpo2t1tj7Sl0vvX5ZE9rARAZOK
	 bXT74VYHJ0UKw==
From: Simon Horman <horms@kernel.org>
To: dhowells@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	d4n.for.sec@gmail.com,
	n05ec@lzu.edu.cn,
	jaltman@auristor.com,
	stable@kernel.org
Subject: Re: [PATCH net 1/5] rxrpc: input: reject ACKALL outside transmit phase
Date: Thu, 18 Jun 2026 10:27:33 +0100
Message-ID: <20260618092733.887894-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616155749.2125907-2-dhowells@redhat.com>
References: <20260616155749.2125907-2-dhowells@redhat.com>
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
rxrpc: input: reject ACKALL outside transmit phase

rxrpc_input_ackall() accepts ACKALL packets without checking whether
the call is in a state that can legitimately have outstanding transmit
buffers. A forged ACKALL can reach a new service call and trigger a null
pointer dereference.

> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index ce761466b02d6..37881dffa898b 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c

[ ... ]

> @@ -1214,8 +1214,22 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
>  static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
>  {
>  	struct rxrpc_ack_summary summary = { 0 };
> +	rxrpc_seq_t top = READ_ONCE(call->tx_top);
> +
> +	switch (__rxrpc_call_state(call)) {
> +	case RXRPC_CALL_CLIENT_SEND_REQUEST:
> +	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
> +	case RXRPC_CALL_SERVER_SEND_REPLY:
> +	case RXRPC_CALL_SERVER_AWAIT_ACK:
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	if (call->tx_bottom == top)
> +		return;
>  
> -	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary))
> +	if (rxrpc_rotate_tx_window(call, top, &summary))

[Severity: High]
This isn't a bug introduced by this patch, but it appears the fix might be
incomplete. The patch prevents a NULL pointer dereference in
rxrpc_input_ackall() by checking if call->tx_bottom == top before calling
rxrpc_rotate_tx_window().

However, does the same vulnerability remain in rxrpc_receiving_reply()?

If a client in the RXRPC_CALL_CLIENT_SEND_REQUEST state receives a forged or
early DATA packet (acting as a reply) before it has queued any transmit data,
call->tx_top and call->tx_bottom will both be 0, and call->tx_queue will be
NULL.

rxrpc_receiving_reply() will then unconditionally call:

    if (!rxrpc_rotate_tx_window(call, top, &summary)) {

Because rxrpc_rotate_tx_window() uses a do { ... } while (before_eq(seq, to))
loop, it executes exactly once for seq = 1 and to = 0, which dereferences
the NULL tq:

    if (tq->bufs[ix]->flags & RXRPC_LAST_PACKET) {

Should the empty window check be placed at the top of rxrpc_rotate_tx_window()
instead, or mirrored in rxrpc_receiving_reply() to protect against early
replies?

>  		rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ackall);
>  }
