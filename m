Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E97343216
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778219859; cv=none; b=ShEv5ZJ5b0rhaTPTK+YWxqkY2Cb7MqNabl91RnOHYZ4QVxP5IVwTQ4IMDkLfKp1YWHJuOLOBMIMh0taecIjlZWY53jI520fGv6omtz2PNNH8KbBqEqm3EsTFGDkcvNiwYKLRiH3knTJCxzcbsiggSxswHOkf4naCjbH/ObRtX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778219859; c=relaxed/simple;
	bh=Q8iQ5oKYpNWlooeXbi/5OQ4Oh8nrDr0N3nkHem0tgo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO7lhHS1MpO7CfBnrmVbt2NOtiyBUjR8Asl4ETEPloKRvt/MwINpsFlzvO34cqJE6INWTOxvyK+5exsHTDVdmqn9PeKaK6yVy38+cZySc3KX+J7KlT5DdPT3yNaEeZNFCJT2CduU7i4aOELaZP8MbF7/PBrriyGMGVss8gbkJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YxqGG18w; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YxqGG18w"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778219843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ct2pIyRxDBx3gdYX08AC7c84QzUSggtk08N5J4OSxrk=;
	b=YxqGG18wjkfF/AwKXpU1WOIL4dNkfs3hh1218lMQD5a0BT0vSVI09luslPQTOWesDT3Jzt
	O2FcaMOKNScvCFgombZao1Gchz+ournPNCZmqwy5PL8lUbnINxZ4JS+6Pm2fKTosp++aOJ
	YK83CGlW4iMxjUyOu5b+28HrgnKmRWA=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
Date: Fri,  8 May 2026 13:57:15 +0800
Message-ID: <20260508055716.89380-1-qingfang.deng@linux.dev>
In-Reply-To: <afKV2zGR6rrelPC7@v4bel>
References: <afKV2zGR6rrelPC7@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu, 30 Apr 2026 08:35:55 +0900, Hyunwoo Kim wrote:
> 
> The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
> handler in rxrpc_verify_response() copy the skb to a linear one before
> calling into the security ops only when skb_cloned() is true.  An skb
> that is not cloned but still carries paged fragments (skb->data_len != 0)
> falls through to the in-place decryption path, which binds the frag
> pages directly into the AEAD/skcipher SGL via skb_to_sgvec().
> 
> Extend the gate so that any skb with non-linear data is also copied,
> ensuring the security handler always operates on a fully linear skb.
> The OOM/trace handling already in place is reused.
> 
> Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/rxrpc/call_event.c | 2 +-
>  net/rxrpc/conn_event.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
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

It's recommended to use skb_is_nonlinear() instead of open-coding
skb->data_len.

>  				/* Unshare the packet so that it can be
>  				 * modified by in-place decryption.
>  				 */
> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index a2130d25aaa9..eab7c5f2517a 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c
> @@ -245,7 +245,7 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
>  {
>  	int ret;
>  
> -	if (skb_cloned(skb)) {
> +	if (skb_cloned(skb) || skb->data_len) {

Ditto.

>  		/* Copy the packet if shared so that we can do in-place
>  		 * decryption.
>  		 */

Regards,
Qingfang
