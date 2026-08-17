Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604D63E2747
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004707; cv=none; b=hEIJeeZj+U7GpDcpN58pf2X7QG/h0THwjcniHkXh5yCTLTsXdFAnJze3et8pBECJQr8PxwuDdtzd4RzxhDfO9v0oF+u5+T82WFI7qGR4gLiK6kJLGupyUw6pyfIH+wpV/EcXxJO/o5gwLmZLnT5ykZ+giohIF56nRZaEJ1/Zpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004707; c=relaxed/simple;
	bh=A/RPz7dxpdWyV8nMHopIbs2hDdQrTps0f4/NrFHiGvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHpXuSoZnOmG4/imloMh5paqoCUb9M/m7tOOhMF+2t6U0/6y65XNKno5ayYkz+UBlj27d3vARctgpi70UujvgsfS7xbqS80HYZC39bM/gMnCahJYd5HSOu8Kmg6GJJECUW83PQuzK97zqJwnMZ5EYVa3Sa+6HU5FMqjgMsQeZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqjPBw9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqjPBw9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3E31F00A3A;
	Mon, 17 Aug 2026 22:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787004705;
	bh=qc/8OGGkF1m384C0tq3NDVtMi3Jn4yvyEw1AwlIAJ38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hqjPBw9/1hTjCUg7l30w8U286I+eoeAx3QVU0ueI153QkWiVoq7Fmp7yg3LZT/a61
	 2aAeWUuFBTUFLTgPSYFxJe+LedjsMnNrJnYwSBhn91ivHrCw2GWO6BbwoAU3AyQGim
	 2BGTn9QEDCbfPdeDbWck5g65ndf1N1ep+pc9vZgqrpP16QPzxiCjloHH06zVIew0Mi
	 K6rtaOpQg4Bd9oOLqDFMF1b7+50Nsp2QwFCmdEWYxZKbKAV4m9U9Xc7A7j7+lljPL5
	 GGKzTPFUNlIZL2oU6n2FyLXJKyphe5gXQ4TAvIQsEa29mggh9+Ja2Mvol3Jwv88VZY
	 35AognnNWzKWw==
From: Jakub Kicinski <kuba@kernel.org>
To: rjethwani@purestorage.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v16 07/10] tls: device: add TX KeyUpdate support
Date: Mon, 17 Aug 2026 15:11:44 -0700
Message-ID: <20260817221144.3666456-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807183853.2288959-8-rjethwani@purestorage.com>
References: <20260807183853.2288959-8-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
tls: device: add TX KeyUpdate support

This adds TX KeyUpdate for device-offloaded kTLS by installing a temporary
SW context with the new key, routing sendmsg through
tls_sw_sendmsg_locked() until all old-key HW records are ACKed, and then
reinstalling HW offload at the current write_seq. A few questions below
about the SW/HW transition, the record bookkeeping and the new counters.

> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> index 49f5640092a0..119fbd49179c 100644
> --- a/include/uapi/linux/snmp.h
> +++ b/include/uapi/linux/snmp.h
> @@ -369,6 +369,9 @@ enum
>  	LINUX_MIB_TLSTXREKEYOK,			/* TlsTxRekeyOk */
>  	LINUX_MIB_TLSTXREKEYERROR,		/* TlsTxRekeyError */
>  	LINUX_MIB_TLSRXREKEYRECEIVED,		/* TlsRxRekeyReceived */
> +	LINUX_MIB_TLSTXREKEYFALLBACK,		/* TlsTxRekeyFallback */
> +	LINUX_MIB_TLSTXREKEYINPROGRESS,		/* TlsTxRekeyInProgress */
> +	LINUX_MIB_TLSTXREKEYABORTED,		/* TlsTxRekeyAborted */
>  	__LINUX_MIB_TLSMAX
>  };

[Severity: Low]
These three names become visible in /proc/net/tls_stat through the new
SNMP_MIB_ITEM() entries in tls_mib_list[], but
Documentation/networking/tls.rst is not updated anywhere in this series,
even though it documents every other TLS counter including TlsTxRekeyOk,
TlsTxRekeyError, TlsRxRekeyReceived and the TlsCurrTx* gauges.

Should the statistics section of tls.rst gain these three?

Also, TlsTxRekeyInProgress is used as a gauge (incremented in
tls_set_device_offload_rekey() when the rekey is deferred, decremented in
tls_device_complete_rekey() and tls_device_free_resources_tx()), while
every other Tls*Rekey* counter is monotonic and the existing gauges use
the TlsCurr* prefix.

Would TlsCurrTxRekey (or similar) match the existing naming better?

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 4f6b3ea1bde4..85c74d0816b7 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c

[ ... ]

> @@ -252,7 +296,15 @@ void tls_device_free_resources_tx(struct sock *sk)
>  {
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);
>  
> -	tls_free_partial_record(sk, tls_ctx);
> +	if (unlikely(tls_ctx->rekey.sw_ctx))
> +		tls_sw_release_resources_tx(sk);
> +	else
> +		tls_free_partial_record(sk, tls_ctx);

[Severity: Critical]
Can tls_ctx->partially_sent_record still belong to the device path here,
while rekey.sw_ctx points at a brand new SW context whose tx_list is
empty?

The device push path leaves it set when the record does not fit in the
send queue:

net/tls/tls_device.c:tls_push_record() {
	...
	return tls_push_sg(sk, tls_ctx, offload_ctx->sg_tx_data, 0, flags);
}

net/tls/tls_main.c:tls_push_sg() {
	...
		ctx->partially_sent_offset = offset;
		ctx->partially_sent_record = (void *)sg;
}

tls_device_start_rekey() only flushes a pending *open* record
(tls_is_pending_open_record()), which is false for an already closed but
partially sent record, and the defer decision in
tls_set_device_offload_rekey() also does not look at it:

	if (!rekey_pending && !rekey_failed)
		defer = tls_has_unacked_records(offload_ctx) ||
			tls_is_pending_open_record(ctx);

The SW paths assume partially_sent_record implies the head of tx_list is
the owning tls_rec:

net/tls/tls_sw.c:tls_sw_release_resources_tx() {
	if (tls_ctx->partially_sent_record) {
		tls_free_partial_record(sk, tls_ctx);
		rec = list_first_entry(&ctx->tx_list,
				       struct tls_rec, list);
		list_del(&rec->list);
		sk_msg_free(sk, &rec->msg_plaintext);
		kfree(rec);
	}

With the freshly initialized offload_ctx->rekey.sw, tx_list is empty, so
rec becomes container_of(&offload_ctx->rekey.sw.tx_list, struct tls_rec,
list). struct tls_rec starts with its list_head, so rec points into the
middle of the kmalloc'ed offload context; sk_msg_free() then walks an
sk_msg built out of the neighbouring rekey key/IV/rec_seq bytes and
kfree(rec) frees an interior pointer.

tls_sw_drain_tx() -> tls_tx_records() has the same list_first_entry()
assumption on the completion path.

Should tls_set_device_offload_rekey() also defer on
tls_is_partially_sent_record(), and should start_rekey() drain the device
partial record before publishing rekey.sw_ctx?

[ ... ]

> @@ -718,8 +789,13 @@ EXPORT_SYMBOL(tls_get_record);
>  
>  static int tls_device_push_pending_record(struct sock *sk, int flags)
>  {
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
>  	struct iov_iter iter;
>  
> +	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) ||
> +	    test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags))
> +		return tls_sw_push_pending_record(sk, flags);
> +
>  	iov_iter_kvec(&iter, ITER_SOURCE, NULL, 0, 0);
>  	return tls_push_data(sk, &iter, 0, flags, TLS_RECORD_TYPE_DATA);
>  }

[Severity: High]
sendmsg, splice_eof and push_pending_record are all made rekey aware, but
tls_write_space() is not, and tx_conf stays TLS_HW for the whole rekey:

net/tls/tls_main.c:tls_write_space() {
#ifdef CONFIG_TLS_DEVICE
	if (ctx->tx_conf == TLS_HW)
		tls_device_write_space(sk, ctx);
	else
#endif
		tls_sw_write_space(sk, ctx);
}

So while TLS_TX_REKEY_PENDING is set and all data is produced by
tls_sw_sendmsg_locked(), the device handler runs instead of the SW one.

Does that mean the SW tx_work is never rescheduled when send buffer space
frees up?  tls_sw_write_space() is the only place doing:

	if (tls_is_tx_ready(tx_ctx) &&
	    !test_and_set_bit(BIT_TX_SCHEDULED, &tx_ctx->tx_bitmask))
		schedule_delayed_work(&tx_ctx->tx_work.work, 0);

which would leave encrypted records sitting in
offload_ctx->rekey.sw.tx_list after an -EAGAIN from tls_push_sg(), and
tls_sw_drain_tx() returning -EAGAIN so the rekey never completes.

Can the WARN in tls_device_write_space() also fire now?  It has
WARN_ON_ONCE(sk->sk_write_pending), and tls_sw_sendmsg_locked() raises
sk_write_pending in sk_stream_wait_memory() with a SW partial record
outstanding.

Finally, tls_device_write_space() calls tls_push_partial_record() directly
on tls_ctx->partially_sent_record, which during the rekey belongs to the
SW tx_list.  Completing the push there clears partially_sent_record
without removing the owning head tls_rec, so the next tls_tx_records()
re-pushes the same record from msg_en->sg.data[msg_en->sg.curr].  Would
that duplicate ciphertext in the stream and put_page() the record pages a
second time?

> @@ -1105,6 +1181,334 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
>  	return offload_ctx;
>  }
>  

[ ... ]

> +static int tls_device_start_rekey(struct sock *sk,
> +				  struct tls_context *ctx,
> +				  struct tls_offload_context_tx *offload_ctx,
> +				  struct tls_crypto_info *new_crypto_info)
> +{
> +	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);

[ ... ]

> +	if (rekey_pending || rekey_failed) {
> +		/* Wait for in-flight async encryptions submitted to this tfm
> +		 * with the previous key before changing it.
> +		 */
> +		rc = tls_encrypt_async_wait(&offload_ctx->rekey.sw);
> +		if (rc)
> +			return rc;

[ ... ]

> +		old_aead = offload_ctx->rekey.sw.aead_send;
> +		offload_ctx->rekey.sw.aead_send = new_aead;
> +		crypto_free_aead(old_aead);
> +
> +		memcpy(offload_ctx->rekey.tx.iv, salt, cipher_desc->salt);
> +		memcpy(offload_ctx->rekey.tx.iv + cipher_desc->salt, iv,
> +		       cipher_desc->iv);
> +		memcpy(offload_ctx->rekey.tx.rec_seq, rec_seq,
> +		       cipher_desc->rec_seq);

[Severity: Medium]
The other branch below flushes a pending open record before switching
keys:

		/* Flush any HW open_record before switching to SW */
		if (tls_is_pending_open_record(ctx)) {
			rc = ctx->push_pending_record(sk, 0);

This branch swaps aead_send and rewrites rekey.tx.iv / rekey.tx.rec_seq
with no equivalent flush of offload_ctx->rekey.sw.open_rec.
tls_encrypt_async_wait() only waits for requests already submitted to the
tfm; compare the new tls_sw_drain_tx(), which pushes the pending open
record first:

	if (tls_is_pending_open_record(ctx))
		tls_sw_push_pending_record(sk, 0);
	tls_encrypt_async_wait(sw_ctx);

If a preceding sendmsg with MSG_MORE left plaintext in
offload_ctx->rekey.sw.open_rec, is that record then encrypted under the
newest key and newest rec_seq, instead of the key that was current when
the bytes were accepted?

> +
> +		if (rekey_failed) {
> +			set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +			clear_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> +			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
> +			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
> +		}

[Severity: High]
This re-arms the boundary based validator and the READY logic without
refreshing ctx->rekey.boundary_seq; only the else branch below writes it:

		WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->write_seq);

While TLS_TX_REKEY_FAILED is set the socket stays in SW mode and can send
an unbounded amount of data, so by the time a second KeyUpdate arrives
boundary_seq can be arbitrarily far behind write_seq.  Since before() is a
signed 32-bit comparison, once more than 2 GiB has been written past the
stale boundary:

net/tls/tls_device_fallback.c:tls_validate_xmit_skb_rekey() {
	boundary_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
	if (!before(tcp_seq, boundary_seq))
		return skb;

	return tls_sw_fallback(sk, skb);
}

would brand new, already SW-encrypted packets be handed to
tls_sw_fallback() and encrypted a second time?

And symmetrically in tls_tcp_clean_acked():

		if (!before(acked_seq, boundary_seq))
			set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);

with acked_seq more than 2 GiB past the stale boundary the READY bit stops
being set, so the second rekey can never complete.  Should the
rekey_failed path also update boundary_seq to the current write_seq?

> +	} else {
> +		/* Flush any HW open_record before switching to SW */
> +		if (tls_is_pending_open_record(ctx)) {
> +			rc = ctx->push_pending_record(sk, 0);
> +			if (rc < 0)
> +				return rc;
> +		}

[ ... ]

> +static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx,
> +				     bool deferred)
> +{

[ ... ]

> +	rc = tls_device_dev_add_tx(sk, netdev, &offload_ctx->rekey.crypto_send.info,
> +				   tcp_sk(sk)->write_seq);
> +	if (rc) {
> +		crypto_free_aead(new_aead);
> +		goto release_lock;
> +	}
> +
> +	/* Point of no return: HW is live with the new key. Swap in the new
> +	 * fallback tfm and drop the old one; the remaining steps cannot fail.
> +	 */
> +	old_aead = offload_ctx->aead_send;
> +	offload_ctx->aead_send = new_aead;
> +	crypto_free_aead(old_aead);
> +	clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);

[Severity: High]
Is old_aead guaranteed to be unused at this point?  During the whole
PENDING window the installed validator routes every pre-boundary segment
into tls_sw_fallback(), which reads offload_ctx->aead_send locklessly from
qdisc dequeue on any CPU:

net/tls/tls_device_fallback.c:tls_enc_skb() {
	aead_req = tls_alloc_aead_request(ctx->aead_send, GFP_ATOMIC);
	...
	salt = crypto_info_salt(&tls_ctx->crypto_send.info, cipher_desc);
	...
	if (tls_enc_records(tls_ctx, aead_req, ctx->aead_send, sg_in, sg_out,

The memcpys just below overwrite ctx->tx.iv, ctx->tx.rec_seq and
ctx->crypto_send.info, which the same function reads.  There is no
synchronize_net(), RCU section or refcount between the free and those
readers, whereas tls_device_down() does exactly that before tearing TX
state down:

		rcu_assign_pointer(ctx->netdev, NULL);
		...
		/* Sync with inflight packets. ... */
		synchronize_net();

Can a fallback that already loaded old_aead (a queued pre-boundary
retransmission dequeued on another CPU) end up using a freed
crypto_aead, or re-encrypt an old record with the new key and salt?

> +
> +release_lock:
> +	up_read(&device_offload_lock);
> +
> +	if (rc)
> +		goto rekey_fail;
> +
> +	spin_lock_irqsave(&offload_ctx->lock, flags);
> +	memcpy(&rcd_sn, offload_ctx->rekey.tx.rec_seq, sizeof(rcd_sn));
> +	offload_ctx->unacked_record_sn = be64_to_cpu(rcd_sn) - 1;
> +	spin_unlock_irqrestore(&offload_ctx->lock, flags);

[Severity: High]
The "- 1" here encodes the invariant documented in alloc_offload_ctx_tx():

	/* start at rec_seq - 1 to account for the start marker record */
	memcpy(&rcd_sn, ctx->tx.rec_seq, sizeof(rcd_sn));
	offload_ctx->unacked_record_sn = be64_to_cpu(rcd_sn) - 1;

that is, exactly one start marker sits at the head of records_list.  On
the inline (non-deferred) path, can the previous start marker still be
linked?  tls_has_unacked_records() deliberately skips markers:

	list_for_each_entry(info, &offload_ctx->records_list, list) {
		if (!tls_record_is_start_marker(info)) {
			has_unacked = true;
			break;
		}
	}

so with records_list == [old_marker] the rekey is not deferred, and
tls_device_commit_start_marker() then does list_add_tail_rcu(), giving
[old_marker, new_marker, R1, ...] while the counter was rebased as if one
marker existed.  tls_get_record() increments record_sn per list entry, so
would every subsequent record report SN + 1, and would the skew become
permanent once tls_tcp_clean_acked() deletes both markers and adds
deleted_records on top of the rebased value?

The rebase and the records_list update are also in two separate critical
sections, so tls_tcp_clean_acked() can run in between and apply
ctx->unacked_record_sn += deleted_records to the freshly rebased value.

That SN is what drivers program into the NIC on TX resync and what
tls_enc_skb() uses to build the record nonce, so a mismatch means
retransmissions authenticated under the wrong sequence number.

> +
> +	memcpy(ctx->tx.iv, offload_ctx->rekey.tx.iv,
> +	       cipher_desc->salt + cipher_desc->iv);

[ ... ]

> +static int tls_set_device_offload_rekey(struct sock *sk,
> +					struct tls_context *ctx,
> +					struct net_device *netdev,
> +					struct tls_crypto_info *new_crypto_info)
> +{
> +	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
> +	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> +	bool defer = true;
> +	int rc;
> +
> +	if (!rekey_pending && !rekey_failed)
> +		defer = tls_has_unacked_records(offload_ctx) ||
> +			tls_is_pending_open_record(ctx);

[ ... ]

> @@ -1354,7 +1769,10 @@ static int tls_device_down(struct net_device *netdev)
>  		/* Stop offloaded TX and switch to the fallback.
>  		 * tls_is_skb_tx_device_offloaded will return false.
>  		 */
> -		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
> +		if (!test_bit(TLS_TX_REKEY_PENDING, &ctx->flags) &&
> +		    !test_bit(TLS_TX_REKEY_FAILED, &ctx->flags))
> +			WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
> +				   tls_validate_xmit_skb_sw);

[Severity: Medium]
This reads the rekey flags and writes sk_validate_xmit_skb under
down_write(&device_offload_lock), but tls_device_complete_rekey() clears
those flags and publishes the validator *after* up_read():

release_lock:
	up_read(&device_offload_lock);
	...
	clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
	...
	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);

Can this decision be undone right after it is made?  CPU0 finishes
tls_device_dev_add_tx() and calls up_read(); CPU1 (NETDEV_DOWN) takes
down_write(), decides here, sets ctx->netdev = NULL, synchronize_net() and
tls_dev_del(); CPU0 then stores tls_validate_xmit_skb, overwriting CPU1's
choice.

The socket then reports HW TX offload again after the device context was
deleted, since tls_is_skb_tx_device_offloaded() is defined as
smp_load_acquire(&sk->sk_validate_xmit_skb) == &tls_validate_xmit_skb,
which is what the comment above is trying to avoid.

Should the flag clear and the validator store happen while
device_offload_lock is still held?

> diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
> index 1110f7ac6bcb..64ac4ef4012b 100644
> --- a/net/tls/tls_device_fallback.c
> +++ b/net/tls/tls_device_fallback.c
> @@ -435,6 +435,30 @@ struct sk_buff *tls_validate_xmit_skb_sw(struct sock *sk,
>  	return tls_sw_fallback(sk, skb);
>  }
>  
> +struct sk_buff *tls_validate_xmit_skb_rekey(struct sock *sk,
> +					    struct net_device *dev,
> +					    struct sk_buff *skb)
> +{
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +	u32 tcp_seq = ntohl(tcp_hdr(skb)->seq);
> +	u32 boundary_seq;
> +
> +	if (test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags))
> +		return skb;

[Severity: High]
This returns every packet unmodified, including pre-boundary ones, which
seems to contradict both the comment three lines below ("Packet before
boundary means retransmit of old data, use SW fallback with the old key")
and the flag's own documentation in include/net/tls.h ("HW rekey failed,
permanently stay in SW encrypt mode").

Pre-boundary packets are HW-era records carrying plaintext plus a
placeholder tag, and the NIC can no longer encrypt them because
tls_device_complete_rekey() already ran tls_dev_del() and set
TLS_TX_DEV_CLOSED before falling into rekey_fail.  On that path the newly
allocated tfm is freed and offload_ctx->aead_send still holds the usable
old key, so tls_sw_fallback() would work.

If an skb below boundary_seq is validated at qdisc dequeue just after
TLS_TX_REKEY_FAILED becomes visible, is it emitted in cleartext?  Should
the FAILED check come after the boundary comparison?

> +
> +	/* If this packet is at or after the rekey boundary, it's already
> +	 * SW-encrypted with the new key, pass through unchanged
> +	 */
> +	boundary_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
> +	if (!before(tcp_seq, boundary_seq))
> +		return skb;
> +
> +	/* Packet before boundary means retransmit of old data,
> +	 * use SW fallback with the old key
> +	 */
> +	return tls_sw_fallback(sk, skb);
> +}
> +
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index a62e94508c8b..536f26d68d9d 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -445,8 +453,16 @@ static int do_tls_getsockopt_conf(struct sock *sk, sockopt_t *opt, int tx)
>  
>  	/* get user crypto info */
>  	if (tx) {
> -		crypto_info = &ctx->crypto_send.info;
> -		cctx = &ctx->tx;
> +		if (ctx->rekey.cipher_ctx) {
> +			struct tls_offload_context_tx *offload_ctx =
> +				tls_offload_ctx_tx(ctx);
> +
> +			crypto_info = &offload_ctx->rekey.crypto_send.info;
> +			cctx = &offload_ctx->rekey.tx;
> +		} else {
> +			crypto_info = &ctx->crypto_send.info;
> +			cctx = &ctx->tx;
> +		}
>  	} else {
>  		crypto_info = &ctx->crypto_recv.info;
>  		cctx = &ctx->rx;

[ ... ]

> @@ -881,12 +897,34 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>  
>  	switch (optname) {
>  	case TLS_TX:
> -	case TLS_RX:
> +	case TLS_RX: {

[ ... ]

> +		bool tx = optname == TLS_TX;
> +
> +		if (tx)
> +			mutex_lock(&tls_get_ctx(sk)->tx_lock);
>  		lock_sock(sk);
> -		rc = do_tls_setsockopt_conf(sk, optval, optlen,
> -					    optname == TLS_TX);
> +		rc = do_tls_setsockopt_conf(sk, optval, optlen, tx);
>  		release_sock(sk);
> +		if (tx)
> +			mutex_unlock(&tls_get_ctx(sk)->tx_lock);
>  		break;
> +	}

[Severity: Medium]
The changelog describes only the TX rekey state machine, but two changes
here affect sockets that never do a KeyUpdate.

tx_lock is now taken for every TLS_TX setsockopt, including the initial
key installation and SW-only sockets, adding a tx_lock -> lock_sock
ordering on a path that previously took only lock_sock.  The reasoning
exists only as the comment in this hunk.

do_tls_getsockopt_conf() above now reports the *pending* key's
crypto_info, IV and rec_seq from tls_offload_ctx_tx(ctx)->rekey whenever
ctx->rekey.cipher_ctx is set, so getsockopt(SOL_TLS, TLS_TX) returns
different data than before while a rekey is pending.

Could the commit message mention both of these behaviour changes?

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 7b6ab992c86e..89f60cedb142 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2411,6 +2410,23 @@ void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx)
>  	sw_ctx->tx_work.sk = sk;
>  }
>  
> +int tls_sw_drain_tx(struct sock *sk, struct tls_context *ctx)
> +{
> +	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
> +	int rc;
> +
> +	if (tls_is_pending_open_record(ctx))
> +		tls_sw_push_pending_record(sk, 0);
> +	tls_encrypt_async_wait(sw_ctx);
> +	rc = tls_tx_records(sk, -1);
> +	if (rc < 0 || tls_is_partially_sent_record(ctx) ||
> +	    tls_is_pending_open_record(ctx))
> +		return rc < 0 ? rc : -EAGAIN;
> +
> +	cancel_delayed_work_sync(&sw_ctx->tx_work.work);
> +	return 0;
> +}

[Severity: Medium]
Can this return 0 with records still linked on sw_ctx->tx_list?  The
return values of tls_sw_push_pending_record() and
tls_encrypt_async_wait() are discarded and list_empty(&sw_ctx->tx_list) is
never checked.

On an async encryption error (or sk->sk_err already set),
tls_encrypt_done() takes the error branch, sets rec = NULL and therefore
never marks the record tx_ready nor unlinks it:

	if (err || sk->sk_err) {
		rec = NULL;
		...
	}

	if (rec) {
		smp_store_mb(rec->tx_ready, true);

tls_tx_records() then hits the non-ready head, breaks and returns 0, so
tls_device_complete_rekey() proceeds and ends with:

	memzero_explicit(&offload_ctx->rekey, sizeof(offload_ctx->rekey));

wiping the tx_list head while the tls_rec is still linked to it.  Does
that leak the rec together with its msg_plaintext / msg_encrypted pages
and their sk_mem charges, and silently drop a record that sendmsg already
accepted?

The same applies to an orphaned open_rec: tls_push_record() clears
pending_open_record_frags before encryption, so tls_is_pending_open_record()
reads false while open_rec is still set.
