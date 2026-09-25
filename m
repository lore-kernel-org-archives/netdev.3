Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BF2D063E;
	Fri, 25 Sep 2026 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790300112; cv=none; b=PeZyHB6ShEFqi/FhQMY796XdggfxnamqlTjb45ai8vqM4YseUE80u0OFyaiioO3Gbw2pj0vv9z6uxb0xjMus57uCUlrJApeQwrEZvyt5X+HFyrSAzirjOyxeQK3hP0ixKh8Y5Y16gwvZDrYtrXYXTQ5ClwtVjTXWnQ/2mIx7QJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790300112; c=relaxed/simple;
	bh=ZjNZ+vg6+gv9VPIHQk3ULZmrdtQYFAczZyveeVgwXMI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W67PKFzkvEDlFFcTxELtK7tEUfH9aJEjDPSoopUSZmSzJNCnvtWngEplJxKdgTrI/rwskssrw2Frk3UIHcsE+pbn4b1L17lyMk80BkaCede79elLcXJ5G0Fu4vaP0q/30B799N1o9Blm7A5OoKNR4JVEyQjJ8EVl84iJx/1PUAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyxRkFTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyxRkFTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB161F000FF;
	Fri, 25 Sep 2026 01:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790300110;
	bh=my7Bg+boIvu5CMYmwsn4caDDvDHYZ9X/ZTnCuDGdFqM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HyxRkFTeyDFrXxz5vOqR9bwuBLJX25nNIWJN1+D41iG02NlWJXdWqpm9YDMDTi0Wl
	 2XIb4LwqcMPLK6HDY/cCQbTPEo7n9uLICH+YQfU1R6E8W+TAg5diYISB1xhWYUESVn
	 ProWZFg9M2yn0p8UKT+9011YyjCK372zFxRwOxRRw7Kbn7wNc5GASNsgHBI6joP5U8
	 RnOTgnhVudChRNB2AsInIATD39KZgsG9DamzU+2faf9yxDVs1CdoPvKVdYeD1QjP7n
	 jQETIJy002OmManXDPuQ8fqznBEq2vABPSElgV+3anJvw493bez4vkFZwOd5TfZn7R
	 wBSt4lv24MYpg==
Subject: Re: [PATCH net RESEND] nfc: llcp: Fix list corruption / refcount
 desync in nfc_llcp_recv_dm()
From: netdev-bot+sashiko@kernel.org
To: qwe.aldo@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 01:35:09 +0000
Message-ID: <179030010938.2160803.11770090089846992037@kernel.org>
In-Reply-To: <20260923133339.2518641-1-qwe.aldo@gmail.com>
References: <20260923133339.2518641-1-qwe.aldo@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After lock_sock(), the patched nfc_llcp_recv_dm() only checks
  sk_hashed(sk).

Pre-existing issues:
- [High] After nfc_llcp_recv_dm() moves a CONNECTING socket to
  LLCP_CLOSED, the socket still holds everything connect() gave it:…
- [Medium] nfc_llcp_recv_dm() reads the DM reason from skb->data[2]
  (llcp_core.c:1258) without checking skb->len >= 3.

--

nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()

With this patch, nfc_llcp_recv_dm() takes the socket lock and re-checks
that the socket is still hashed. For DM(NOBOUND) and DM(REJ) it also
unlinks the socket from local->connecting_sockets before moving it to
LLCP_CLOSED. This follows the earlier nfc_llcp_recv_cc() fix, so
llcp_sock_release() no longer unlinks a connecting socket from the wrong
list.

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index cac1b5487064d..bd6361e2efa4f 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c

[ ... ]

> @@ -1262,6 +1263,7 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
>  	case LLCP_DM_NOBOUND:
>  	case LLCP_DM_REJ:
>  		llcp_sock = nfc_llcp_connecting_sock_get(local, dsap);
> +		connecting = true;
>  		break;

[Severity: Medium]
This is a pre-existing issue, but the reason byte that picks this branch
is read without a length check:

net/nfc/llcp_core.c:nfc_llcp_recv_dm() {
    ...
	reason = skb->data[2];
    ...
}

The only length check on the way in is in __nfc_llcp_recv():

	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {

LLCP_HEADER_SIZE is 2.

nfc_llcp_recv_agf() also accepts 2-byte inner PDUs:

	if (pdu_len < LLCP_HEADER_SIZE || pdu_len > skb->len) {

It then copies them into an nfc_alloc_recv_skb(pdu_len) buffer. For a
2-byte inner DM, data[2] is uninitialized tailroom. On the direct path it
is one byte past skb->len.

After this patch, that byte also decides whether the new
connecting_sockets unlink runs. Should there be a check such as
"if (skb->len < LLCP_HEADER_SIZE + 1) return;" before the reason is read?

[ ... ]

> @@ -1276,10 +1278,33 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
>  
>  	sk = &llcp_sock->sk;
>  
> +	lock_sock(sk);
> +
> +	/* Check if socket was destroyed whilst waiting for the lock */
> +	if (!sk_hashed(sk)) {
> +		release_sock(sk);
> +		nfc_llcp_sock_put(llcp_sock);
> +		return;
> +	}
> +
> +	/*
> +	 * For DM(NOBOUND)/DM(REJ) the socket is still linked on the
> +	 * connecting_sockets list.  Unlink it here, under the socket lock,
> +	 * before moving it to LLCP_CLOSED: llcp_sock_release() selects the
> +	 * list to unlink from by sk_state, so leaving a connecting socket
> +	 * in the CLOSED state would make it unlink from the wrong list and
> +	 * corrupt the connecting_sockets list / desync the socket refcount.
> +	 * This mirrors nfc_llcp_recv_cc().
> +	 */
> +	if (connecting)
> +		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);

[Severity: High]
Is sk_hashed() enough to show the socket is still on
local->connecting_sockets at this point? The connecting flag is set
before lock_sock(). While this handler waits for the lock, the socket
could move to local->sockets.

Consider this sequence:

llcp_sock_connect()
    nfc_llcp_sock_link(&local->connecting_sockets, sk);
    /* sk_state is still LLCP_CLOSED */
                                  rx_work: nfc_llcp_recv_dm()
                                    nfc_llcp_connecting_sock_get()
                                      /* matches on ssap only */
                                      sock_hold(&llcp_sock->sk);
                                    lock_sock(sk);  /* waits */
    nfc_llcp_send_connect() fails
    sock_unlink:
      nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
    release_sock(sk);

llcp_sock_bind() in another thread sharing the fd wins the lock
    sk->sk_state == LLCP_CLOSED, check passes
    nfc_llcp_sock_link(&local->sockets, sk);
    sk->sk_state = LLCP_BOUND;
                                    /* now gets the lock */
                                    sk_hashed(sk) is true
                                    nfc_llcp_sock_unlink(
                                      &local->connecting_sockets, sk);

A user can force the nfc_llcp_send_connect() failure. If sk_err is still
pending from an earlier DM, this call chain returns that error:

llcp_allocate_pdu()->nfc_alloc_send_skb()->sock_alloc_send_pskb()

At the end of this sequence, the socket is removed from the
local->sockets hlist while connecting_sockets.lock is held, not
sockets.lock. If bind used a different dev_idx, that lock may belong to a
different local. The newly bound socket is also closed with ENXIO.

Can this race with other writers of local->sockets, such as bind or close
of another socket, and corrupt that list? That is the same kind of
wrong-lock corruption the commit message describes.

Before this patch, nfc_llcp_recv_dm() never unlinked, so this path is
new. nfc_llcp_recv_cc() has the same hashed-only check.

For the connecting case, would it work to also require
sk->sk_state == LLCP_CONNECTING and llcp_sock->local == local after
lock_sock(), and bail out otherwise?

> +
>  	sk->sk_err = ENXIO;
>  	sk->sk_state = LLCP_CLOSED;
>  	sk->sk_state_change(sk);

[Severity: High]
This isn't a bug introduced by this patch, but after the socket is moved
to LLCP_CLOSED here, it still holds everything llcp_sock_connect() gave
it:

  - llcp_sock->local, with its kref and nfc_dev ref
  - the nfc_get_device() ref taken by connect
  - the SSAP bit from nfc_llcp_get_local_ssap()
  - the kmemdup'd service_name

llcp_sock_connect() rejects only two states:

	if (sk->sk_state == LLCP_CONNECTED) {
		ret = -EISCONN;
		goto error;
	}
	if (sk->sk_state == LLCP_CONNECTING) {

So an unprivileged user can call connect() again on the rejected socket.
The old values are then overwritten without being released:

	llcp_sock->dev = dev;
	llcp_sock->local = local;
	llcp_sock->ssap = nfc_llcp_get_local_ssap(local);
	...
	llcp_sock->service_name = kmemdup(addr->service_name,

Does each retry leak the old nfc_llcp_local kref, both nfc_dev refs, the
local SAP bit and the old service_name?

llcp_sock_destruct() drops the connect-time nfc_dev ref only for
connected sockets:

	if (sk->sk_state == LLCP_CONNECTED)
		nfc_put_device(llcp_sock->dev);

Each device has only LLCP_LOCAL_NUM_SAP (32) local SAPs. The leaked bits
are never cleared: nfc_llcp_mac_is_down() does not reset
local->local_sap, and the leaked local kref keeps local_release() from
running.

The trigger is a repeated non-blocking connect() to a peer that answers
DM(NOBOUND) or DM(REJ). That is the normal reply for an unknown service,
so no malicious peer is needed. After enough retries, every LLCP client
connect() on that device would fail with -ENOMEM until the device is
re-registered.

Before this patch, the same reconnect also added a node that was already
hashed. The patch removes that part, but the leaks remain.

There are two possible fixes. nfc_llcp_recv_dm() could do the same
teardown as the connect() error path (sock_unlink, sock_llcp_release,
sock_llcp_nullify). Or connect() could reject sockets whose
llcp_sock->local is already set.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923133339.2518641-1-qwe.aldo%40gmail.com
