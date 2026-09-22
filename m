Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6120C3815E7
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042172; cv=none; b=Vmb9Zlnu3Rc9HjIwl6uZzfPMBstB1Y5Lj80UbK734OzNCvyN801qT9O7ro3Y7+IA1n2tIcf7ShV70jQT1lUfhDQt2M9rFX1Zn1Tm4ZwOFu2bZ4tpzaBRkVSqDHA4h8F+6hLmwnuY0svCPKBriTAaxnh+9WtsXQ2IPAgGEkDzwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042172; c=relaxed/simple;
	bh=juFKEDPE9MrsUYab0D5Rv5mZiIfotCbLhOnZRcWPPAg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IcPR6ZKdarACA8dbk0/3XYeXIRtBQJtxCgXSx4Zw7fqhZwuGd0VOe3iUxGKpjhEQAXTwIa0LPghRHtvNp9cAVI007Vc+abOUXvtQdVh/78ied5Uj3104bvXYvfj7ji6c2oqnAiDPzGg9yon3fWP0D9G4BczH5ebuSqBqiUNBQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmLvHsfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmLvHsfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB2A1F00893;
	Tue, 22 Sep 2026 01:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042170;
	bh=KGFvH0i7woX3XmLcSCJGpxCVIFttA+tVJHPuZ0LNu0Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mmLvHsfg7PjBTNdLQLeC8g0cLP6Qn6gQMApbZDgR5lcQVtAmLv4+ubSglccqlV/Sl
	 2CP8FqtKn+zrJEhtYecuUBdTnE4+toYepHbAS4eCOgh8DUto3pLQ2MJQMjlYzdqc6Q
	 xU+AwYfxmzkfl4g9itjXnqRe7NyJsYOIt5jLquwcNioSu4PHivU0iRJ+TdDZ60lzAi
	 b9IxlnzdRGlykYgHKPk+LIQIlDY8B7+GN1EKOWINYSkX6smQn4YCecGBzbOt3RJlKh
	 EHuVxkP4n+72nT5c1R0MNPfucmyVwynYs+t6vzoo3oSpcj+GGkoUcYBf5OiBEadA18
	 kVFihzVvULlHQ==
Subject: Re: [PATCH net-next v17 11/15] tls: device: add TX KeyUpdate support
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:56:08 +0000
Message-ID: <179004216889.2160803.6708323245741788777@kernel.org>
In-Reply-To: <20260917224355.2288021-12-rjethwani@purestorage.com>
References: <20260917224355.2288021-12-rjethwani@purestorage.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 6 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] tls_validate_xmit_skb_rekey() ignores its `dev` argument, unlike
  its peer tls_validate_xmit_skb(), which passes the skb through when…
- [Medium] tls_tx_drop_acked_clone() (and the FAILED-state pass-through
  test in tls_validate_xmit_skb_rekey()) compute the skb's end of…
- [Medium] tls_device_sendmsg() evaluates TLS_TX_REKEY_READY once, before
  entering tls_sw_sendmsg_locked(), and the SW send loop never re-checks…
- [Medium] The deferred-rekey completion trigger can be lost, leaving the
  socket pinned to the temporary SW context.
- [Medium] The nskb->decrypted = 0 clearing added to complete_skb()
  repairs a data-corruption window that the earlier series commit…
- [Medium] The commit message describes only the rekey state machine and
  the tx_lock/getsockopt side effects, but the patch also changes the…
- [Medium] tls_sw_ctx_init() is changed so that ctx->push_pending_record
  is only assigned when tx != 0.
- [Low] The commit message states that a second KeyUpdate arriving while
  one is pending "re-keys the SW AEAD in place", while the code…
- [Low] Assessed as RESOLVED LATER IN THE SERIES (retained for policy
  combination).
- [Low] Assessed as RESOLVED LATER IN THE SERIES (retained for policy
  combination).

--

tls: device: add TX KeyUpdate support

This adds TX KeyUpdate support for the device-offload path: a temporary SW
context encrypts with the new key while old-key HW records drain, and HW
offload is reinstalled at the current write_seq once everything is ACKed.
A few shared fallback paths (complete_skb(), tls_sw_fallback(),
tls_validate_xmit_skb()) are touched along the way.

> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index 920a926e8e68..e749f429301a 100644

[ ... ]

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 972c9c7ba7de..f32c1bb6b497 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c

[ ... ]

> @@ -607,18 +701,46 @@ static int tls_push_data(struct sock *sk,
>  	return rc;
>  }
>  
> +/* True while TX is routed through the temporary SW rekey context: a rekey is in
> + * progress (PENDING) or has failed and the socket stays pinned to SW (FAILED).
> + */
> +static bool tls_device_tx_uses_sw(const struct tls_context *ctx)
> +{
> +	return test_bit(TLS_TX_REKEY_PENDING, &ctx->flags) ||
> +	       test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> +}
> +
>  int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  {
>  	unsigned char record_type = TLS_RECORD_TYPE_DATA;
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);
>  	int rc;
>  
> +	/* Reject unsupported flags up front. tls_push_data() enforces the same
> +	 * set, but during a rekey the send is routed to tls_sw_sendmsg_locked(),
> +	 * which is the _locked variant and does not re-check; without this,
> +	 * MSG_ZEROCOPY / MSG_OOB etc. would reach tcp_sendmsg_locked() on the
> +	 * kernel-owned record pages while PENDING/FAILED.
> +	 */
> +	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
> +			       MSG_SPLICE_PAGES | MSG_EOR))
> +		return -EOPNOTSUPP;
> +
>  	if (!tls_ctx->zerocopy_sendfile)
>  		msg->msg_flags &= ~MSG_SPLICE_PAGES;
>  
>  	mutex_lock(&tls_ctx->tx_lock);
>  	lock_sock(sk);
>  
> +	/* Old-key records all ACKed; switch back to HW. */
> +	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
> +		tls_device_complete_rekey(sk, tls_ctx, true, msg->msg_flags);
> +
> +	if (tls_device_tx_uses_sw(tls_ctx)) {
> +		rc = tls_sw_sendmsg_locked(sk, msg, size);
> +		goto out;
> +	}

[Severity: Medium]
Can a single very large send outrun the frozen boundary_seq here?

TLS_TX_REKEY_READY is evaluated once, before entering
tls_sw_sendmsg_locked(), and the SW loop never re-checks it, so
rekey.boundary_seq stays fixed for the whole call while the TCP sequence
advances.  The rekey provably cannot complete during the call either, since
tx_lock is held across the send and both completion sites require it.

Once the wire sequence advances more than 2^31 past boundary_seq, the signed
comparison in tls_validate_xmit_skb_rekey():

	if (!before(tcp_seq, pivot_seq))
		return skb;

	return tls_sw_fallback(sk, skb);

flips, and freshly produced SW ciphertext is treated as pre-boundary old-key
data.  In tls_sw_fallback() the old record can still be matched via
retransmit_hint, fill_sg_in() then returns non-zero with sync_size == 0, and:

	if (sync_size < 0 && payload_len <= -sync_size &&
	    !skb_is_decrypted(skb))
		nskb = skb_get(skb);
	goto put_sg;

leaves nskb NULL, so the skb is freed rather than transmitted.  Retransmits
are misclassified the same way, so the connection would stall.  A single
writev approaching MAX_RW_COUNT (~2 GiB) plus ~22 bytes of framing per 16KB
record is enough to exceed 2^31 of wire sequence space.  Would re-checking
READY inside the SW send loop, or refreshing the pivot, avoid this?

[ ... ]

> @@ -1106,6 +1246,425 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
>  	return offload_ctx;
>  }
>  

[ ... ]

> +static int tls_device_start_rekey(struct sock *sk,
> +				  struct tls_context *ctx,
> +				  struct tls_offload_context_tx *offload_ctx,
> +				  struct tls_crypto_info *new_crypto_info)
> +{

[ ... ]

> +		old_aead = offload_ctx->rekey.sw.aead_send;
> +		offload_ctx->rekey.sw.aead_send = new_aead;
> +		crypto_free_aead(old_aead);

[Severity: Low]
This isn't a bug, but the commit message says:

  "A KeyUpdate arriving while one is pending re-keys the SW AEAD in place"

The code does the opposite: tls_device_build_rekey_aead() allocates a fresh
transform, and the comment on that helper explains why in-place re-keying is
avoided:

  /* ... Re-keying a live tfm in place is not atomic:
   * a failed crypto_aead_setkey() leaves it with CRYPTO_TFM_NEED_KEY set,
   * destroying the previous key.

Then the swap above installs the new transform only on success and frees the
old one.  Could the changelog wording be adjusted, since "in place" is the
term the code's own comment uses for the approach it rejects?

> +
> +		tls_device_copy_rekey_iv_seq(offload_ctx, cipher_desc,
> +					     salt, iv, rec_seq);
> +
> +		if (rekey_failed) {

[ ... ]

> +			down_read(&device_offload_lock);
> +			spin_lock_irqsave(&offload_ctx->lock, flags);
> +			WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->snd_una);
> +			set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +			spin_unlock_irqrestore(&offload_ctx->lock, flags);

[Severity: Medium]
Can the deferred completion trigger be lost here, pinning the socket to the
temporary SW context?

Two cases look reachable.

First, the FAILED to PENDING re-arm above publishes
boundary_seq = tcp_sk(sk)->snd_una, a value that is already satisfied at the
moment it is written.  The only place that sets READY is
tls_tcp_clean_acked():

	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) &&
	    !test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
		u32 boundary_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);

		if (!before(acked_seq, boundary_seq))
			set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
	}

and that only runs when snd_una advances, so READY requires a *later* ACK
rather than the already-reached boundary.

Second, on the initial arm, tls_set_device_offload_rekey() decides defer from
tls_has_unacked_records()/tls_is_pending_open_record() before
tls_device_start_rekey() publishes boundary_seq and PENDING, and the arming
path sleeps in between (record flush, then crypto_alloc_aead() inside
tls_device_init_rekey_sw()).  If the ACK covering the boundary is processed in
that window, tls_tcp_clean_acked() skips the new block because PENDING is not
set yet, and nothing re-evaluates snd_una against boundary_seq afterwards.

The result is a socket that keeps encrypting in SW with the new key,
TlsCurrTxRekey staying elevated, and eventually TlsTxRekeyAborted.  Would a
post-arm check of snd_una versus boundary_seq close both cases?

The last patch in the series ("tls: document TLS 1.3 hardware offload rekey
handling") justifies this race by saying the acknowledgment of the flushed
record itself arms completion, but in the sub-case above there is no flushed
record still in flight when the arming ACK already arrived.

> +			/* Release pairs with test_bit_acquire() in the validator:
> +			 * a TX seeing FAILED clear must see the fresh boundary_seq.
> +			 */
> +			clear_bit_unlock(TLS_TX_REKEY_FAILED, &ctx->flags);
> +			up_read(&device_offload_lock);

[ ... ]

> +static int tls_set_device_offload_rekey(struct sock *sk,
> +					struct tls_context *ctx,
> +					struct tls_crypto_info *new_crypto_info)
> +{
> +	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
> +	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> +	bool defer = true;
> +	int rc;
> +
> +	/* Defer the switch back to HW until any in-flight old-key records are
> +	 * ACKed. A partially_sent_record needs no separate check: its record is
> +	 * on records_list before it is sent (tls_push_record()) and stays there
> +	 * until ACKed, so tls_has_unacked_records() already covers it.
> +	 */
> +	if (!rekey_pending && !rekey_failed)
> +		defer = tls_has_unacked_records(offload_ctx) ||
> +			tls_is_pending_open_record(ctx);

[ ... ]

> diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
> index 1110f7ac6bcb..f2a0ae827bb2 100644
> --- a/net/tls/tls_device_fallback.c
> +++ b/net/tls/tls_device_fallback.c
> @@ -190,6 +190,14 @@ static void complete_skb(struct sk_buff *nskb, struct sk_buff *skb, int headln)
>  
>  	skb_copy_header(nskb, skb);
>  
> +	/* nskb now carries ciphertext, but skb_copy_header() inherited
> +	 * skb->decrypted from the plaintext original. Clear it so the bit keeps
> +	 * meaning "still-plaintext, needs an encryptor": otherwise a requeued
> +	 * nskb would be needlessly re-validated (and re-encrypted) and would trip
> +	 * the NIC's decrypted-vs-start-marker WARN.
> +	 */
> +	nskb->decrypted = 0;

[Severity: Medium]
Should this clearing live in an earlier commit of the series?

The earlier series commit d209263206bf ("net: sched: re-validate parked
decrypted skbs on requeue") makes dequeue_skb() set validate for any requeued
skb with skb_is_decrypted():

	if (skb_is_decrypted(skb))
		*validate = true;

Until this commit, complete_skb() copied the plaintext original's headers into
the ciphertext nskb (skb_copy_header() -> __copy_skb_header() copies the
headers struct_group, which contains the decrypted bit) and set nskb->sk.  A
requeued fallback output would therefore be re-validated,
tls_validate_xmit_skb() would again see dev != ctx->netdev (the condition that
caused the first fallback) and tls_sw_fallback() would encrypt the ciphertext a
second time.

Because the second pass reuses the same record, rcd_sn, IV and sync_size, the
CTR keystream is applied twice, so the wire payload becomes the original
plaintext with a bogus tag.

Neither changelog mentions the dependency, so commits d209263206bf..3f66fe17313f
carry that window.  Could this hunk move into (or before) the sched commit, or
could both changelogs state the ordering requirement?

>  	skb_put(nskb, skb->len);
>  	memcpy(nskb->data, skb->data, headln);
>  
> @@ -396,8 +404,17 @@ static struct sk_buff *tls_sw_fallback(struct sock *sk, struct sk_buff *skb)
>  	sg_init_table(sg_out, ARRAY_SIZE(sg_out));
>  
>  	if (fill_sg_in(sg_in, skb, ctx, &rcd_sn, &sync_size, &resync_sgs)) {
> -		/* bypass packets before kernel TLS socket option was set */
> -		if (sync_size < 0 && payload_len <= -sync_size)
> +		/* Below the record range (start marker / already-freed record).
> +		 * Pass through only cleartext that was never offload-encrypted
> +		 * (skb->decrypted == 0): genuine pre-TLS bytes sent before the
> +		 * socket option was set, or SW-encrypted rekey ciphertext. A
> +		 * decrypted=1 skb here is offload-record plaintext whose record was
> +		 * purged (e.g. a rekey installed a new start marker above its seq);
> +		 * it must never reach the wire in the clear, so continue on and
> +		 * drop it (nskb stays NULL).
> +		 */
> +		if (sync_size < 0 && payload_len <= -sync_size &&
> +		    !skb_is_decrypted(skb))
>  			nskb = skb_get(skb);
>  		goto put_sg;
>  	}

[Severity: Medium]
Could the commit message cover the shared fallback-path changes too?

The changelog describes the rekey state machine, the tx_lock ordering and the
getsockopt accessor, but this patch also changes behaviour for every
device-offloaded socket that ever falls back (route change, bond member,
post-NETDEV_DOWN, funeth/nfp tls_encrypt_skb()):

 - complete_skb() now clears nskb->decrypted on all SW-fallback encryptions.
 - the hunk above turns a pass-through into a drop, and the comment describes
   it as preventing offload-record plaintext from reaching the wire in the
   clear.
 - tls_validate_xmit_skb() gains tls_tx_drop_acked_clone(), a per-skb
   header/sequence computation plus a silent kfree_skb() rule that stays armed
   for the socket's life once TLS_TX_REKEY_FLOOR is set.

The skb_is_decrypted() gate in particular looks like a standalone fix that a
stable backporter would want to find on its own.  Could it be split out, or at
least described in the changelog?

>  
> @@ -416,11 +433,57 @@ static struct sk_buff *tls_sw_fallback(struct sock *sk, struct sk_buff *skb)
>  	return nskb;
>  }
>  
> +/* Post-rekey drop floor. Once a rekey has completed (TLS_TX_REKEY_FLOOR set), a

[ ... ]

> +static bool tls_tx_drop_acked_clone(struct sock *sk, struct sk_buff *skb)
> +{
> +	int payload_len = skb->len - skb_tcp_all_headers(skb);
> +	u32 end_seq;
> +
> +	if (likely(!test_bit(TLS_TX_REKEY_FLOOR, &tls_get_ctx(sk)->flags)))
> +		return false;
> +
> +	if (payload_len <= 0)
> +		return false;
> +

[ ... ]

> +	end_seq = ntohl(tcp_hdr(skb)->seq) + payload_len;
> +	return !after(end_seq, READ_ONCE(tcp_sk(sk)->snd_una));
> +}

[Severity: Medium]
Does end_seq need to account for the FIN's sequence-space byte?

A FIN consumes one sequence number, so for a data+FIN skb whose payload is
fully ACKed but whose FIN is not (snd_una == seq + payload_len), the test
above is true and tls_validate_xmit_skb() frees the whole skb:

	if (unlikely(tls_tx_drop_acked_clone(sk, skb))) {
		kfree_skb(skb);
		return NULL;
	}

tcp_send_fin() can attach the FIN to an already-transmitted skb:

net/ipv4/tcp_output.c:tcp_send_fin() {
	...
	tskb = tail;
	if (!tskb && tcp_under_memory_pressure(sk))
		tskb = skb_rb_last(&sk->tcp_rtx_queue);
	...
}

so a clone parked in a qdisc can carry data plus a live FIN while the peer has
ACKed only the data.  Shutdown would then wait for the RTO.  The FAILED-state
pass-through in tls_validate_xmit_skb_rekey() makes the same payload-only
comparison:

		if (payload_len > 0 && !skb_is_decrypted(skb) &&
		    after(tcp_seq + payload_len, snd_una))
			return skb;

Would adding the FIN/SYN bit to end_seq (or skipping skbs that carry flags)
be appropriate here?

> +
>  struct sk_buff *tls_validate_xmit_skb(struct sock *sk,
>  				      struct net_device *dev,
>  				      struct sk_buff *skb)
>  {
> -	if (dev == rcu_dereference_bh(tls_get_ctx(sk)->netdev) ||
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +
> +	if (unlikely(tls_tx_drop_acked_clone(sk, skb))) {
> +		kfree_skb(skb);
> +		return NULL;
> +	}
> +
> +	if (dev == rcu_dereference_bh(tls_ctx->netdev) ||
>  	    netif_is_bond_master(dev))
>  		return skb;
>  
> @@ -435,6 +498,65 @@ struct sk_buff *tls_validate_xmit_skb_sw(struct sock *sk,
>  	return tls_sw_fallback(sk, skb);
>  }
>  
> +struct sk_buff *tls_validate_xmit_skb_rekey(struct sock *sk,
> +					    struct net_device *dev,
> +					    struct sk_buff *skb)
> +{
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +	u32 tcp_seq = ntohl(tcp_hdr(skb)->seq);
> +	u32 pivot_seq;

[Severity: High]
Should this validator consult dev the way tls_validate_xmit_skb() does?

The peer function passes the skb through when the device is the offload device
or a bond master:

	if (dev == rcu_dereference_bh(tls_ctx->netdev) ||
	    netif_is_bond_master(dev))
		return skb;

That netif_is_bond_master() branch exists because sk_validate_xmit_skb() runs
twice for a bonded socket: once at the master level and again on the slave.
Since ctx->netdev is the lowest device (get_netdev_for_sock() ->
netdev_sk_get_lowest_dev()), dev at the master level is bond0 != ctx->netdev.

Under the rekey validator a pre-pivot (old-key) retransmit then takes this
path twice:

tls_validate_xmit_skb_rekey(dev=bond0)
  before(tcp_seq, pivot_seq)
    tls_sw_fallback()            /* produces ciphertext nskb */
      complete_skb()             /* nskb->decrypted = 0, nskb->sk = sk */
bond_dev_queue_xmit()
  __dev_queue_xmit(slave)
    validate_xmit_skb()
      sk_validate_xmit_skb()
        tls_validate_xmit_skb_rekey(dev=slave)
          before(tcp_seq, pivot_seq)   /* still true */
            tls_sw_fallback()          /* encrypts the ciphertext again */

The record is still on records_list (it is unacked, which is why the rekey is
PENDING), so the sync_size < 0 bypass does not catch it, and the same record,
rcd_sn, IV and sync_size mean the same CTR keystream is XORed back over the
ciphertext.  Can this put the original plaintext on the wire with an invalid
tag?

tls_validate_xmit_skb_sw() has the same omission, but that one is only
reachable after tls_device_down(), whereas the rekey validator is on the
normal KeyUpdate path.

> +
> +	/* acquire pairs with clear_bit_unlock() on re-arm; makes the refreshed
> +	 * boundary_seq visible in the else branch below.
> +	 */
> +	if (test_bit_acquire(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
> +		int payload_len = skb->len - skb_tcp_all_headers(skb);
> +		u32 snd_una = READ_ONCE(tcp_sk(sk)->snd_una);
> +

[ ... ]

> +		if (payload_len > 0 && !skb_is_decrypted(skb) &&
> +		    after(tcp_seq + payload_len, snd_una))
> +			return skb;
> +
> +		pivot_seq = snd_una;
> +	} else {

[ ... ]

> +		smp_rmb();
> +		pivot_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
> +	}
> +
> +	/* At or after the pivot: already correctly encrypted, pass through */
> +	if (!before(tcp_seq, pivot_seq))
> +		return skb;
> +
> +	/* Below the pivot: retransmit of old data, SW fallback with old key */
> +	return tls_sw_fallback(sk, skb);
> +}

[ ... ]

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 5531303dd704..fd162d8f1d64 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -2609,7 +2633,8 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
>  			goto free_aead;
>  	}
>  
> -	ctx->push_pending_record = tls_sw_push_pending_record;
> +	if (tx)
> +		ctx->push_pending_record = tls_sw_push_pending_record;

[Severity: Medium]
Is this guard a separate fix that deserves its own patch and a Fixes: tag?

Before this change, an RX SW setsockopt on a socket already running HW TX
offload replaced the device dispatcher:

tls_set_device_offload_rx()
  tls_sw_ctx_init(sk, 0, NULL)
    ctx->push_pending_record = tls_sw_push_pending_record;

After that, with pending_open_record_frags set by tls_push_data(),
tls_handle_open_record():

	if (tls_is_pending_open_record(ctx))
		return ctx->push_pending_record(sk, flags);

calls tls_sw_push_pending_record(), which reads ctx->open_rec at the
tls_sw_context_tx offset while priv_ctx_tx is actually a
struct tls_offload_context_tx (landing inside sg_tx_data[]), and can then
dispatch bpf_exec_tx_verdict() on that.

The guard is also a prerequisite for the rekey flush, which calls
ctx->push_pending_record() and needs it to still be the device dispatcher.
Could this be split out with a Fixes: tag, or at least called out in the
changelog?

Two documentation concerns were also raised and are resolved later in the
series; noting them only for completeness.

The three new counters (TlsTxRekeyFallback, TlsCurrTxRekey,
TlsTxRekeyAborted) are not described in Documentation/networking/tls.rst at
this commit.

[Severity: Low]
The later commit "tls: document TLS 1.3 hardware offload rekey handling" adds
the TlsCurrTxRekey, TlsTxRekeyFallback and TlsTxRekeyAborted entries, so this
is addressed by the end of the series.

Documentation/networking/tls-offload.rst still says key rotation is not a
concern for offloaded connections and describes tls_dev_del() as destroy-time
cleanup only, while tls_device_complete_rekey() does a tls_dev_del() followed
by tls_dev_add() on a live socket.

[Severity: Low]
The same later documentation commit rewrites the tls_dev_del() lifecycle text
and the Rekey section, so this is addressed by the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
