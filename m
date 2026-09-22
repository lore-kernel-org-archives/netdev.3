Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953A381B0F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042173; cv=none; b=L5ddc8v99lqoWymLHKsBa751GI9bJzn2iJPHpivWACDGMGjB9MYS8T+FdTOzwzu2bpS+5+WQ76XKbKnDbmd/2isngIxOPn9geMXNIlXvP32tp9zJGU2yG6mz7RfpCNRUlHQpUp21lUU9/5+jz6/+gxux8Pjn1OMp3TS16zIuRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042173; c=relaxed/simple;
	bh=0hturaBzqNkWjMUJRwt/OacDxU8kZ//r6Je7qhA4reQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7rrxqZEnAKhUxtatMZbrgb4uNk/3LOvJQMpI3rwzi6C6GsNOuD50lii7PNQPkDT0xhEIcV/zBH/RTWY72+48JOG0tJK7vPKVlw/3EFXLpL36Xloc7ryBW9byuuSHs43Tln5lm9LhHGJEEWsgGQFFV4oWy3qVpSkIiAA2O5nAnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFXcYrc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFXcYrc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33921F00898;
	Tue, 22 Sep 2026 01:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042171;
	bh=4cDbQ2XjlK8caS1koUdv9wju6FB2V1XX4UzhExBsVx0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CFXcYrc8ZJh/2We4HGpYgJlr7Kbxy4oM0VykdfKyAzAD6kaIt4II33fGxsH1+zHhs
	 tOlGxAaRoZWrdtRk/tGrMMh5/H6pciOInZcfauPzItrqsfJVxxFTmz7+CCmPDuylOO
	 43LRS2MnCMuFDHHlz3pOgDIsCK9Fj7tNLoqh7cVwsDmxrprn3cMNzSajXTCdJjKUqJ
	 uDxTa5wc7iF/0ZYJv2IgqsxYCWha85IEb00dWOJYzO8jweqiBnFGxchkCIqbYDbLB/
	 bczZ/S01vHOaDWKhdWOZxH46tK3gXojo/PW7rFGqIY08LkjRFRXNBifzQ+09lRtj5S
	 ArRRdiWLhJsBQ==
Subject: Re: [PATCH net-next v17 12/15] tls: device: add RX KeyUpdate support
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:56:10 +0000
Message-ID: <179004217021.2160803.17949873036879323455@kernel.org>
In-Reply-To: <20260917224355.2288021-13-rjethwani@purestorage.com>
References: <20260917224355.2288021-13-rjethwani@purestorage.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 4 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A record whose payload the NIC transformed (XORed) with the
  retired key but could not authenticate can be classified as untouched…
- [High] The inverse of the same ambiguity: tls_device_reencrypt() now
  rewrites every fragment whose skb->decrypt_failed is set (`if…
- [High] Re-adding an mlx5 RX offload context on a live socket (now
  possible because this patch calls tls_dev_del() followed by…
- [High] mlx5e_ktls_add_rx() publishes the new priv_rx into the TLS
  context (mlx5e_set_ktls_rx_priv_ctx()) before creating the TIR and…
- [Medium] Commit message contradicts the code for the two sequence
  computations the whole RX rekey classification rests on.
- [Medium] During the old-key drain, tls_device_decrypted() advances
  ctx->rekey.old_rec_seq before software decryption of the record has…
- [Medium] In tls_set_device_offload_rx()'s rekey path, an empty TCP
  receive snapshot is treated as proof that no old-key-transformed data…
- [Low] The patch adds three user-visible SNMP counters
  (TlsRxRekeyFallback, TlsCurrRxRekey, TlsRxRekeyAborted) exposed via…
- [Low] The patch silently fixes a pre-existing, userspace-observable
  tracepoint bug (trace_tls_device_decrypted() passed…

--

tls: device: add RX KeyUpdate support

This adds RX KeyUpdate handling to the TLS device offload path: the old
AEAD, IV and record sequence are kept on tls_offload_context_rx, the NIC
key is deleted when a KeyUpdate record is decoded, and records are then
classified against old_nic_boundary until the old key can be retired.
Installation of the new key on the NIC is deferred until the old key's
records have drained, with new SNMP counters and a TLS_RX_REKEY_FAILED
flag for the SW fallback accounting.

A few questions below, first about the commit message and then about the
code.

> rec_start_seq is the TCP sequence of the record's first byte, used both
> for the trace_tls_device_decrypted() tracepoint and the old_nic_boundary
> classification above. Because copied_seq is advanced at different points
> in the two strparser modes, the record start is computed differently: in
> copy_mode the record has already been dequeued (tcp_read_done() in
> tls_strp_msg_cow() advanced copied_seq past it), so full_len is
> subtracted; in non-copy mode copied_seq still points at the record start
> and is used directly.

[ ... ]

> installs the new key when the first post-boundary record is seen. It
> anchors the NIC on that record's start (rec_start_seq, already
> copy_mode-adjusted as above) paired with the new key's starting record
> number, read from crypto_recv.info after tls_sw_ctx_finalize() stored it
> there.

[Severity: Medium]
Do these two paragraphs describe something different from what the code
does?

tls_device_rx_rec_start() subtracts the anchor length, not full_len:

	if (sw_ctx->strp.copy_mode)
		return copied_seq - sw_ctx->strp.anchor->len;

and the helper's own comment attributes the copy_mode advance to
tls_strp_read_copy() -> tls_strp_read_copyin() -> tcp_read_sock(), not to
tcp_read_done() in tls_strp_msg_cow().

The two quantities coincide only at the tls_device_decrypted() call site,
where msg_ready implies anchor->len == full_len.  At the other call site,
drain_start in tls_set_device_offload_rx(), tls_strp_read_copy() has
zeroed anchor->len and tcp_read_sock() may have appended a partial record
or only header bytes, so full_len would be the wrong quantity there.

For the second paragraph, tls_device_deferred_dev_add_rx() deliberately
overwrites the frozen crypto_recv.info record number with the live one:

	crypto_ctx = tls_ctx->crypto_recv;
	memcpy(crypto_info_rec_seq(&crypto_ctx.info, cipher_desc),
	       tls_ctx->rx.rec_seq, cipher_desc->rec_seq);

and the comment right above it explains why the value from
crypto_recv.info must not be used.  Could the message be updated to match,
so a later simplification toward the described behaviour does not
desynchronise the (TCP seq, record number) pair handed to the NIC?

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index f32c1bb6b497..ac09f356cff9 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c

[ ... ]

> @@ -192,6 +202,129 @@ static void tls_device_commit_start_marker(struct sock *sk,
>  	tcp_write_collapse_fence(sk);
>  }
>  

[ ... ]

> +static int tls_device_dev_add_rx(struct sock *sk, struct tls_context *tls_ctx,
> +				 struct net_device *netdev,
> +				 struct tls_crypto_info *crypto_info,
> +				 u32 cur_seq, bool is_rekey)
> +{
> +	const struct tls_cipher_desc *cipher_desc;
> +	char *rec_seq;
> +	int rc;
> +
> +	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
> +	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
> +
> +	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk,
> +					     TLS_OFFLOAD_CTX_DIR_RX,
> +					     crypto_info, cur_seq);

[Severity: High]
Calling tls_dev_add() for RX on a live socket is new here (previously add
happened once and del only at close).  Can a GET_PSV completion belonging
to the retired mlx5 context then operate on the new one?

mlx5e_ktls_del_rx() states that it does not wait for those completions:

	/* priv_rx should normally be freed here, but if there is an outstanding
	 * GET_PSV, deallocation will be delayed until the CQE for GET_PSV is
	 * processed. */

and mlx5e_ktls_handle_get_psv_completion() resolves the resync state
through the socket, not through its own retired priv_rx:

	rx_ctx = tls_offload_ctx_rx(tls_get_ctx(priv_rx->sk));
	async_resync = rx_ctx->resync_async;

After a del+add, that pointer is the new generation's &resync->core, so
the stale completion's DELETING branch would call
tls_offload_rx_resync_async_request_cancel() on the new generation's
pending request, leaving the NIC unsynced.

Can the same completion also write through freed memory?
mlx5e_ktls_add_rx() publishes

	tls_offload_ctx_rx(tls_ctx)->resync_async = &resync->core;

before the fallible post_rx_param_wqes(), and the error path does
kfree(priv_rx) without clearing that pointer.

[Severity: High]
Related question on the same call: is the replacement priv_rx visible to
NAPI before it is fully initialised?  mlx5e_ktls_add_rx() calls
mlx5e_set_ktls_rx_priv_ctx() before mlx5e_rx_res_tls_tir_create() and
resync_init(), so at that moment resync->priv is still NULL (kzalloc'd),
resync->work is uninitialised and the refcount is 0.

A RESYNC CQE generated before tls_dev_del() but polled after the re-add
finds the socket by 5-tuple in resync_update_sn() and reaches
resync_queue_get_psv(), which only checks pointer presence and
MLX5E_PRIV_RX_FLAG_DELETING:

	mlx5e_ktls_priv_rx_get(priv_rx);
	if (unlikely(!queue_work(resync->priv->tls->rx_wq, &resync->work)))

Would that dereference a NULL resync->priv in softirq context, on top of a
refcount_inc() from 0 and a queue_work() on an uninitialised work_struct?
The synchronize_net() in mlx5e_ktls_del_rx() only waits for a running
poll, not for CQEs already sitting in the CQ, and the new
TLS_RX_DEV_CLOSED test only gates the core parser path.

[ ... ]

> +void tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx)
> +{

[ ... ]

> +	set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
> +	synchronize_net();
> +	netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> +					TLS_OFFLOAD_CTX_DIR_RX);
> +	up_read(&device_offload_lock);
> +}
> +

[ ... ]

> @@ -1114,7 +1249,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
>  	if (skb_pagelen(skb) > offset) {
>  		copy = min_t(int, skb_pagelen(skb) - offset, data_len);
>  
> -		if (skb->decrypted) {
> +		if (skb->decrypted || skb->decrypt_failed) {
>  			err = skb_store_bits(skb, offset, buf, copy);
>  			if (err)
>  				goto free_buf;
> @@ -1141,7 +1276,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
>  		copy = min_t(int, skb_iter->len - frag_pos,
>  			     data_len + rxm->offset - offset);
>  
> -		if (skb_iter->decrypted) {
> +		if (skb_iter->decrypted || skb_iter->decrypt_failed) {
>  			err = skb_store_bits(skb_iter, frag_pos, buf, copy);
>  			if (err)
>  				goto free_buf;

[Severity: High]
Can decrypt_failed be used as proof that these bytes were XORed?  The
kernel-doc for the new bit says it cannot:

 * The payload may have been transformed (XORed) or left as wire
 *		ciphertext, so software must re-authenticate the record and undo the
 *		transform on any XORed fragment

If a fragment marked decrypt_failed was left as wire ciphertext, does
skb_store_bits() here overwrite pristine new-key ciphertext, so the SW
AEAD that follows rejects an otherwise valid record and
tls_rx_one_record() calls tls_err_abort(sk, -EBADMSG)?

There is also no way to tell the two kinds of fragment apart at this
point, since skb_cmp_decrypted() ignores the bit:

	return skb2->decrypted - skb1->decrypted;

so tcp_gro_receive() (flush |= skb_cmp_decrypted(p, skb)) and
tls_strp_copyin() can merge an XORed decrypt_failed segment with an
untouched one into a single skb or anchor fragment that carries one mark.

Note this hunk also affects sockets that never rekey, via the
TLS_RX_DEV_DEGRADED path in tls_device_decrypted().

> @@ -1158,6 +1293,77 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
>  	return err;
>  }
>  

[ ... ]

> +static u32 tls_device_rx_rec_start(struct sock *sk,
> +				   struct tls_sw_context_rx *sw_ctx)
> +{
> +	u32 copied_seq = tcp_sk(sk)->copied_seq;
> +
> +	if (sw_ctx->strp.copy_mode)
> +		return copied_seq - sw_ctx->strp.anchor->len;
> +
> +	return copied_seq;
> +}
> +
>  int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
>  {
> @@ -1165,6 +1371,7 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
>  	struct sk_buff *skb = tls_strp_msg(sw_ctx);
>  	struct strp_msg *rxm = strp_msg(skb);
>  	int is_decrypted, is_encrypted;
> +	u32 rec_start_seq;
>  
> @@ -1174,10 +1381,72 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
>  		is_encrypted = 0;
>  	}
>  
> -	trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full_len,
> +	rec_start_seq = tls_device_rx_rec_start(sk, sw_ctx);
> +
> +	trace_tls_device_decrypted(sk, rec_start_seq,
>  				   tls_ctx->rx.rec_seq, rxm->full_len,
>  				   is_encrypted, is_decrypted);
>  

[Severity: Low]
This change also fixes a user-visible tracepoint bug that predates the
patch: the old expression subtracted rxm->full_len unconditionally, and on
the non-copy path tcp_sk(sk)->copied_seq is still at the record start, so
the tracepoint reported the previous record's start.

Would it be worth splitting this into its own patch with a Fixes: tag, so
it can be backported independently of the feature?

> +	if (unlikely(ctx->rekey.old_aead_recv)) {
> +		bool nic_touched = !is_encrypted || skb->decrypt_failed;
> +		bool before_nic_boundary;
> +

[ ... ]

> +		if (nic_touched &&
> +		    !before(rec_start_seq, ctx->rekey.old_nic_boundary))
> +			ctx->rekey.old_nic_boundary = rec_start_seq + rxm->full_len;
> +
> +		before_nic_boundary =
> +			before(rec_start_seq, ctx->rekey.old_nic_boundary);
> +
> +		if (before_nic_boundary) {

[ ... ]

> +			if (is_encrypted) {
> +				tls_bigint_increment(ctx->rekey.old_rec_seq,
> +						     tls_ctx->prot_info.rec_seq_size);
> +				return 0;
> +			}
> +
> +			return tls_device_reencrypt_old_key(sk, ctx,
> +							    sw_ctx, tls_ctx);
> +		}

[Severity: High]
Is a record whose payload the NIC XORed with the retired key always
flagged mixed, so that it takes the reencrypt path rather than this
is_encrypted shortcut?

mixed_decrypted is derived solely from skb_cmp_decrypted() in
tls_strp_copyin():

	strp->mixed_decrypted |= !!skb_cmp_decrypted(skb, in_skb);

and skb_cmp_decrypted() looks only at skb->decrypted:

	return skb2->decrypted - skb1->decrypted;

So a record whose every segment carries only decrypt_failed is non-mixed,
is_encrypted is 1, and the branch above returns 0 without ever calling
tls_device_reencrypt_old_key().

The commit message says such a record "was not transformed", but
mlx5e_ktls_handle_rx_skb() sets the flag unconditionally and says the
opposite:

	/* The device could not authenticate the payload. Depending on
	 * where the failure occurred the bytes may have been transformed
	 * (XORed) or left as wire ciphertext. */
	skb->decrypt_failed = 1;

If the payload was transformed, tls_decrypt_sw() authenticates XORed bytes
and tls_rx_one_record() does:

	if (err < 0) {
		tls_err_abort(sk, -EBADMSG);
		return err;
	}

which kills a healthy TLS 1.3 connection during the rekey the patch is
meant to support.

Independently of what the device does, does GRO destroy the per-segment
distinction this classification depends on?  tcp_gro_receive() has:

	flush |= skb_cmp_decrypted(p, skb);

which is 0 for a (unmarked, decrypt_failed) pair, so the two are merged
into one skb carrying only the head's flags.

[Severity: Medium]
Can old_rec_seq end up one record ahead if software decryption of this
record fails transiently?  The increment above happens before
tls_decrypt_sw() runs, and on a failure tls_rx_one_record() returns
without tls_advance_record_sn() and without consuming the strparser
record.

On the next recvmsg(), tls_rx_rec_wait() returns 1 immediately because
tls_strp_msg_ready() is already true - its sk_err checks live inside the

	while (!tls_strp_msg_ready(ctx))

loop - so tls_device_decrypted() runs again for the same record and
advances ctx->rekey.old_rec_seq a second time.  Would a later mixed record
then be reconstructed by tls_device_reencrypt_old_key() with the wrong
nonce?

[ ... ]

> @@ -1804,73 +2073,224 @@ int tls_set_device_offload(struct sock *sk,

[ ... ]

> +		} else {
> +			struct tcp_sock *tp = tcp_sk(sk);
> +			u32 nic_end;
> +
> +			if (context->rekey.old_aead_recv) {
> +				crypto_free_aead(context->rekey.old_aead_recv);
> +				context->rekey.old_aead_recv = NULL;
> +			}
> +
> +			/* Flush the backlog so TCP's view is current, then take the
> +			 * highest byte TCP holds, including the out-of-order tail:
> +			 * a NIC-transformed segment behind a host-side drop sits
> +			 * above rcv_nxt until the retransmit fills the hole and
> +			 * must still be classified against the old key. This is
> +			 * still only the stack's view, a transformed segment the
> +			 * NIC has not delivered yet is caught in-band by
> +			 * tls_device_decrypted(), which slides the boundary.
> +			 */
> +			__sk_flush_backlog(sk);
> +			nic_end = tp->rcv_nxt;
> +			if (!RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
> +			    after(TCP_SKB_CB(tp->ooo_last_skb)->end_seq, nic_end))
> +				nic_end = TCP_SKB_CB(tp->ooo_last_skb)->end_seq;
> +
> +			if (before(drain_start, nic_end)) {
> +				context->rekey.old_aead_recv = sw_ctx->aead_recv;

[Severity: Medium]
What happens when this snapshot finds nothing queued?  Then
before(drain_start, nic_end) is false, no old AEAD/IV/rec_seq is retained
(any previous one has just been freed above) and the new key goes to the
NIC immediately.

The comment in tls_device_decrypted() says a late arrival is possible:

	 * A segment the NIC transformed with the old
	 * key before tls_dev_del returned can still be in the RQ/CQ, in
	 * a GRO list or in the socket backlog when that snapshot is
	 * taken and reach TCP later, above it.

but the boundary-sliding code that compensates for that runs only inside
if (unlikely(ctx->rekey.old_aead_recv)).  With no old key retained, would
a late mixed record fall through to the tail of tls_device_decrypted() and
be reconstructed by tls_device_reencrypt() with the current key, so
authentication fails and the connection is aborted with -EBADMSG?

The synchronize_net() in mlx5e_ktls_del_rx() removes the steering rule and
TIR but does not drain already-transformed RX packets into TCP, so is
there anything that rules out this asymmetry between the retain and
no-retain branches?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
