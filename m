Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D83D3488
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651238; cv=none; b=MFL02EOnQwpgFNITeApEKHKDhZpbvXPy/F0V0PX+msMc4046E89Vm8qtanJrMOA3qZluLSqGamqy7f88sKWEmapt9prWSAKzm7xQ2wXG/3ER/LX1sxB9QPxZzy8EZkMAF/W+zcvGjjedyWPldjIRCSlur14ga7AmpPDxhWOTMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651238; c=relaxed/simple;
	bh=G4lC1D3BJj1GP7SqDT3o1cd9MdTrOYq6mdzrdXD4MIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHSnBcBwQEAp7GFDEF/15bAP1BlKEEPojnayI0QXcVzDtMCiUaPoUFW0PNj3bt5HpH5LKZFo2WlQzTQkCUkD0cfquPVp+IXH0g3z9fjCqum5OBfsObbUj95I5eEqcz3rGbLuYyygmasXEIQYAj0Qs9ON6sW3XsZ+71Kdn16Fm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFDzFYtA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFDzFYtA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB94C2BCB4;
	Fri,  1 May 2026 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777651237;
	bh=G4lC1D3BJj1GP7SqDT3o1cd9MdTrOYq6mdzrdXD4MIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JFDzFYtA1QoFT55a03xSVuKv+Fz8Q3QyUP91CUxnoC44nd+MIgEqZNXgmPKBnOv7y
	 2fsKTPnwGsCef+DlQY5RFUyUclt3jAd1qJ6lhxJOZC7tdKuFlMy7nMh1ZM0j4/hB7E
	 Q34E6fyeDQqtskl8TJsWyJuDYh2NqYNqQA4SoqXriYW/lH+D7CPCX4AtaELJjuZk1U
	 9kYTBE0swFGnfYGzssl/2225cLFyCs/wwSpTWIXiMBXo6sl1dQ7Hy8I517M6zpBW6i
	 TTNXn8ACNZvFUmMB9qn3hOyIyuiEWywS4c4SHQSfB8LNODRtoX8FQx9u3Ib4u8vtTU
	 qORvtNF23Ubxw==
From: Simon Horman <horms@kernel.org>
To: imv4bel@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
Date: Fri,  1 May 2026 16:58:08 +0100
Message-ID: <20260501155806.222592-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <afKV2zGR6rrelPC7@v4bel>
References: <afKV2zGR6rrelPC7@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present

This commit updates the DATA and RESPONSE packet handlers in rxrpc to copy
the skb into a linear one if there are paged fragments present. This ensures
the security handler operates on a fully linear skb during decryption.

> diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> index fdd683261226..6c924ef55208 100644
> --- a/net/rxrpc/call_event.c
> +++ b/net/rxrpc/call_event.c
> @@ -334,7 +334,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
>  
>  			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
>  			    sp->hdr.securityIndex != 0 &&
> -			    skb_cloned(skb)) {
> +			    (skb_cloned(skb) || skb->data_len)) {
>  				/* Unshare the packet so that it can be
>  				 * modified by in-place decryption.
>  				 */

Since modern NIC drivers commonly use page pools where packet payloads are
placed in page fragments, skb->data_len will be greater than zero for almost
all standard incoming packets.

By taking this path, the code calls skb_copy() right after this check.
Will this force a full packet copy for nearly all incoming RxRPC DATA
packets, bypassing zero-copy receive paths and causing a large performance
regression?

Additionally, skb_copy() fully linearizes the packet by allocating a single
contiguous buffer for the entire packet size. For RxRPC Jumbo packets or UDP
GRO-aggregated packets (which can reach up to ~64KB), this requires an
order-4 page allocation.

Could relying on an order-4 GFP_ATOMIC allocation cause reliable OOM
failures and packet drops on fragmented systems?

If the goal is to ensure the skb is writable for in-place decryption, would
it be safer to use skb_cow_data() instead of forcing a full contiguous
linearization?

Simon says:

I note that this patch included
Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
And that the suggestion in the last paragraph above would
reintroduce back to the problem addressed by d0d5c0cd1e71.
