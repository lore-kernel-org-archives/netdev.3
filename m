Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264940;
	b=ak0hYlfTOXvIozAv299/pyem2QGaqWR5kZ1G7G9yYvaCtZP4o+JX9zbztjOglBcf2WKD
	 Ay/HVb+XrTgk9h9Jj9SsLjFyUTqNYFSbQSx5sLyWLMDC7l0LIes5XHEsqozXjza63FNe4
	 0VKFq0VO1EwQXlTQI2wrlHRoyt6dJkm66iAcIkPJ2fleRx/01szBO/gRHpK2UL0vkT87J
	 AwrNlf4HsIz/Jv8ne0OVTXkXxfBfW4iEDOC0MsqGHCim8nWiFSnGJhiVYQshwphYH23Ik
	 sfTYrzAjh13vSupwxRz6Q5boRR6QAuYIA+y246xlYJDWiP5ARU3nG+2suQoLYc31Bxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264940;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YuhrPDfdKB1a4odfbM1ADNnm1xwi0g6i/dY3IIlQvsU=;
	b=TNPEoUuCm1U4PbHRFF8v5iIc8k92FNqHRBN/uAnGJr7PWXcC/mFWQwJjp65lcMp0wrUi
	 7J3Up6wTrNtZ7zN4n3eGLyytSBbl11T+cknKeqSXPJ4JH8AkrkIP3cikrJ1/ak/YHyhz2
	 ECyevNXJ9sR0aCvEEvySfrz6KrQ21ZKcrPuqrxF7LoLmty2R4FdYGbPXWMrnq/DvWS770
	 7mwWd8gKiqR7P3UzsmOc/IHK2bMD8+TTLvzm+ffxVQtCUP3xsbRnuh0wkIP+PtsB6GsUB
	 o6G6fCYvS6tO+9neHW2La7aec3nmNxvc9KzWsQD4frQsr3nLHdDexMJCNTiTzR547XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fwb7X+Vf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC977606A31C;
	Mon,  9 Nov 2026 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fwb7X+Vf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281301F0089F;
	Mon,  9 Nov 2026 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264939;
	bh=YuhrPDfdKB1a4odfbM1ADNnm1xwi0g6i/dY3IIlQvsU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fwb7X+VfYRTi9ieQwtzlu112pJeKcS/CUTN5jNwCKYu9khi4QgKatVp3AhrqtLO/H
	 2RNFIJGSRGLkj2bq9YR8jKQGtbZ+fmYKe1vza7P2JovlXaS0Yb5UORwczxP5OfGulb
	 WrCGnJ0A6RNTGwGTUW1//A6KgmrZfS8SfDhajY28d2TV08lyVG95J86KTbN2elMUPD
	 pw7eRcm13li7Y0pOUEojWCKttIu25nZuItYCxy5zheUi2SwGbphm6sAJn1zQt3R6b6
	 RzrlWMuezFWRB9Kok3Xmn0Z1zbTrRWktWQtCdu1eZ4o0WAxQEeYkoxnzzOlw8hlwuP
	 rXuwtOcRFO/XQ==
Subject: Re: [PATCH] nfc: llcp: drop socket reference on undelivered UI frames
From: netdev-bot+sashiko@kernel.org
To: NoahWeinberger2003@proton.me
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 22:55:38 +0000
Message-ID: <179426493870.994134.13632392913540647589@kernel.org>
In-Reply-To: <-mPkBfqn9vzam8gV7Gbd5HGTPILiECmnRoTWiEESIGtgUyQCeZ3cmL9anfsTEqgkI_OIepj_Pf31PXrps4461AE48xq0Vp0R1dnAuSYk_8I=@proton.me>
References: <-mPkBfqn9vzam8gV7Gbd5HGTPILiECmnRoTWiEESIGtgUyQCeZ3cmL9anfsTEqgkI_OIepj_Pf31PXrps4461AE48xq0Vp0R1dnAuSYk_8I=@proton.me>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 (1) · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: the same remote refcount leak is still
  present in nfc_llcp_recv_connect().
- [Low] The patch cannot be merged as submitted.
- [Low] The commit message understates how easy the leak is to trigger,
  and part of its description is inaccurate.

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the UI
  delivery block the patch wraps hands the skb to the socket before it…

--

nfc: llcp: drop socket reference on undelivered UI frames

This patch makes nfc_llcp_recv_ui() drop the socket reference taken by
nfc_llcp_sock_get() when the matched socket is not SOCK_DGRAM. Before,
that path returned with the reference still held. UI frames are still
delivered only to connectionless sockets.

> A remote LLCP peer can arrange for non-DGRAM sockets whose (ssap, dsap)
> match this lookup (accepted stream sockets take dsap from the peer's
> CONNECT ssap; connections by service name use dsap = LLCP_SAP_SDP) and
> then send any number of UI PDUs addressed to the socket's ssap.

[Severity: Low]

Is this description accurate? The leak looks easier to trigger than this
suggests.

nfc_llcp_sock_alloc() starts every socket with:

	llcp_sock->dsap = LLCP_SAP_SDP;

llcp_sock_bind() keeps that dsap and links the socket into local->sockets.
listen() leaves it there. So an ordinary bound or listening SOCK_STREAM
server already matches this lookup in nfc_llcp_recv_ui():

	llcp_sock = nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);

Before this patch, a peer only had to send UI PDUs to the SAP of any local
stream server. No connection or other setup was needed first.

The service name client case also looks off. A connecting client stays on
local->connecting_sockets, not local->sockets, until CC arrives. After
that, nfc_llcp_recv_cc() sets its dsap to the peer's ssap.

Could the changelog describe the trigger more precisely?

> All sibling handlers (hdlc, disc, cc, dm) pair the put on every path;
> recv_ui is the exception. The patch below puts the reference on all
> paths and only delivers to connectionless sockets.

[Severity: High]

Does nfc_llcp_recv_connect() leak the socket reference in the same way?
It does the same lookup, and nfc_llcp_sock_get() calls sock_hold() on
any match:

net/nfc/llcp_core.c:nfc_llcp_recv_connect() {
	...
	if (dsap != LLCP_SAP_SDP) {
		sock = nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
		if (sock == NULL || sock->sk.sk_state != LLCP_LISTEN) {
			reason = LLCP_DM_NOBOUND;
			goto fail;
		}
	...
fail:
	/* Send DM */
	nfc_llcp_send_dm(local, dsap, ssap, reason);
}

If the socket is found but is not in LLCP_LISTEN, the fail label only
sends a DM. sock_put() is never called. Every other early exit in this
function calls sock_put() before goto fail.

A remote peer can reach this with a CONNECT PDU whose dsap matches the
ssap of a non-listening socket in local->sockets that has
dsap == LLCP_SAP_SDP. That includes:

  a bound SOCK_DGRAM socket (the kind this patch delivers UI frames to)
  a bound SOCK_STREAM socket that has not called listen()
  an accepted child created from a CONNECT with ssap=1

Each CONNECT leaks one reference, so the socket is never freed after
close. llcp_sock_destruct() never runs either, so the nfc_llcp_local
reference the socket holds stays pinned too.

Should nfc_llcp_recv_connect() be fixed as part of this patch, with the
changelog updated to match?

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index 74bf817007cf2..78f80c41421aa 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -917,9 +917,15 @@ static void nfc_llcp_recv_ui(struct nfc_llcp_local *local,
>  
>  	/* We're looking for a bound socket, not a client one */
>  	llcp_sock = nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
> -	if (llcp_sock == NULL || llcp_sock->sk.sk_type != SOCK_DGRAM)
> +	if (llcp_sock == NULL)
>  		return;
>  
> +	/* Only connectionless sockets receive UI frames, but the
> +	 * reference taken by nfc_llcp_sock_get() must be dropped on
> +	 * every other path as well.
> +	 */
> +	if (llcp_sock->sk.sk_type == SOCK_DGRAM) {
> +

[Severity: Low]

This isn't a bug, but the new block wraps the old body without
re-indenting it. It also adds blank lines after the opening brace and
before the closing brace. Would something like this be simpler?

	if (llcp_sock->sk.sk_type != SOCK_DGRAM)
		goto out;
	...
out:
	nfc_llcp_sock_put(llcp_sock);

The changelog also probably needs a respin before this can be applied.

There is no Signed-off-by line.

There is no Fixes tag. git blame points the leaking type check at:

  Fixes: 968272bf0087 ("NFC: Handle LLCP UI frames")

There is no Cc: stable tag, even though this fixes a leak a remote peer
can trigger.

Text such as "Hello,", "The patch below ...", the "Affected
version/commit:" line, and "Please treat this as a report for
verification rather than a battle-tested fix" would go into git history
as is.

The Reported-by tag names the patch author.

The message also says the patch has not been compiled or tested.

>  	/* There is no sequence with UI frames */
>  	skb_pull(skb, LLCP_HEADER_SIZE);
>  	if (!sock_queue_rcv_skb(&llcp_sock->sk, skb)) {

[Severity: Critical]

This is a pre-existing issue, but can a reader free the skb before
skb_get() runs here?

sock_queue_rcv_skb()->__sock_queue_rcv_skb() puts the skb on the receive
queue and wakes readers before it returns:

net/core/sock.c:__sock_queue_rcv_skb() {
	...
	spin_lock_irqsave(&list->lock, flags);
	sock_skb_set_dropcount(sk, skb);
	__skb_queue_tail(list, skb);
	spin_unlock_irqrestore(&list->lock, flags);

	if (!sock_flag(sk, SOCK_DEAD))
		sk->sk_data_ready(sk);
	return 0;
}

nfc_llcp_recv_ui() calls skb_get(skb) only after that. At that point the
skb has one reference, owned by nfc_llcp_rx_work() through
local->rx_pending (or by new_skb in nfc_llcp_recv_agf()).

llcp_sock_recvmsg() dequeues with skb_recv_datagram() without taking
lock_sock, and then calls kfree_skb(skb). If that happens inside the
window:

nfc_llcp_rx_work()
  nfc_llcp_rx_skb()
    nfc_llcp_recv_ui()
      sock_queue_rcv_skb()       <- skb visible, one reference
                                    llcp_sock_recvmsg() frees the skb
      skb_get(skb)               <- writes to freed skb->users
  kfree_skb(local->rx_pending)   <- second free of the same skb

nfc_llcp_recv_hdlc() uses the same queue-then-skb_get order for I frames.
This order appears to date from commit 1727cf937401 ("NFC: llcp: Fix Rx
memory leak").

Would it avoid the race to take the extra reference with skb_get() before
queueing, and drop it with kfree_skb() if queueing fails?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/-mPkBfqn9vzam8gV7Gbd5HGTPILiECmnRoTWiEESIGtgUyQCeZ3cmL9anfsTEqgkI_OIepj_Pf31PXrps4461AE48xq0Vp0R1dnAuSYk_8I%3D%40proton.me
