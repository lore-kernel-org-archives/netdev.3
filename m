Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC09431A4C;
	Mon, 20 Jul 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559160; cv=none; b=gZAfB2vJL16R8VXlaSmWhn+nb+JCzdvVjbdsqpB8q4kDHyTjNvFSBKPKxY0NXpuLkm0OFrelILxrTv2uYCy4L8ETbBzTUREPi8VaKF/PejX6wKUXpp2mgFPtitawKD3Mn1JrNarSRRWz3oW7n5FEhIyRgevY132l3cXOiTqK2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559160; c=relaxed/simple;
	bh=EPsyRR7LCFKmzeypBibz3LCRILY/20SblXsJzfVRsDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qshpXk6DqkxEPAC0ly01DkD+AnN2rV42PF6lik19HbtvI740pwvuOMz1Mk0uJ0ueOwouOYwSDms4lqsQlkhSFSNbKAAwJU9sL5s2GqZGT3sWIbnBoRi1QioE5N/JQ5DBtjbgMg3857bmzyXwzO9oRDoz/WsNIq9iH4YbkhwmHxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG/eenJr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG/eenJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCF21F000E9;
	Mon, 20 Jul 2026 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559159;
	bh=mNOG6tJb4ArYv61TC1J/bhHRHe0S/t8B6qvgryjB5RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RG/eenJrhlrFChjXoASIEwwaT96iqfec4D/FA+H47IEz1lQN2+SIcuTwaWcZ6Svbd
	 NPnno87gRDUyaX8F1WqM6hC19NYNS+AkPHDzAtc7AAn19W+FK8VvQZkpxJx3Od6Idm
	 8WQSkPUs9i3tM8ilnfMl5UUVuCj8kiNsx9uYwc93dI969JDEAdkl+ZCcKB2YlBnVf3
	 9c2H5HYZ614/4pEQvuO+WxzsHCoQ8p0cy5ubzzf9iMqgRbnRitVs6jDaYIl1W3ajy7
	 6kHpT48Fu0LouO3vvu2Uo/Cm4EYoG2PJTC37DAXUksxaC4uIa+rIXM+ImyTHKKqm4y
	 qyn4d4kPmhGhQ==
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
	stable@kernel.org
Subject: Re: [PATCH net v3 04/14] rxrpc: Fix packet encryption error handling
Date: Mon, 20 Jul 2026 15:52:22 +0100
Message-ID: <20260720145222.192109-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713081022.2186481-5-dhowells@redhat.com>
References: <20260713081022.2186481-5-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260713081022.2186481-8-dhowells@redhat.com?part=4
---
--- Patch [4]: [PATCH net v3 04/14] rxrpc: Fix packet encryption error handling ---
commit 01fc73762a5a2162d360f4b9e10f752440ebbd67
Author: David Howells <dhowells@redhat.com>

rxrpc: Fix packet encryption error handling

This commit modifies the error handling in rxrpc_send_data() when
secure_packet() fails. It treats -ENOMEM as a retryable error and marks
other errors as terminal by setting the RXRPC_CALL_TX_ERROR flag to abort
the call.

Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
[ ... ]
> @@ -440,12 +446,21 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  		/* add the packet to the send queue if it's now full */
>  		if (!txb->space ||
>  		    (msg_data_left(msg) == 0 && !more)) {
> -			if (msg_data_left(msg) == 0 && !more)
> -				txb->flags |= RXRPC_LAST_PACKET;
> -
> +			/* Do any required crypto.  If this fails, it could
> +			 * have corrupted the txbuf content with a partial
> +			 * encrypt.  Assume that ENOMEM is retryable, but
> +			 * everything else is terminal.
> +			 */
>  			ret = call->security->secure_packet(call, txb);
> -			if (ret < 0)
> +			if (ret < 0) {
> +				if (ret == -ENOMEM)
> +					goto maybe_error;

[Severity: High]
If secure_packet() fails with -ENOMEM, does this jump to maybe_error bypass
rxrpc_queue_packet() but still return a successful write length?

Looking at rxrpc_send_data(), the user data has already been copied into txb
and 'copied' has been incremented. The maybe_error path handles this:

maybe_error:
	if (copied) {
		...
		goto success;
	}

Because copied > 0, it jumps to success and returns the number of bytes
copied, including the data in the unqueued txb.

Could this mislead userspace into thinking the data was sent when it was
actually dropped, leaving the unencrypted packet permanently stuck in
call->tx_pending and leading to an application hang?

> +				set_bit(RXRPC_CALL_TX_ERROR, &call->flags);
>  				goto out;
> +			}
> +
> +			if (msg_data_left(msg) == 0 && !more)
> +				txb->flags |= RXRPC_LAST_PACKET;
>  			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
>  			txb = NULL;
>  		}
