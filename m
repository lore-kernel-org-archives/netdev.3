Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446841A4E0
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798161; cv=none; b=khrC1JpNKDxDfdsVbCdxpaZo6SWF/0/ZYvmmwI/SzPeUJBOL5S4Mm12HhB9pkO98DPTEkko3KwP/FIvhUSggyASVke9EF5nlHDMJW6yIZF30OOftJ7s5BZSmop0ZijJdJ9uGfw7Ke0xkJlaaPtMpVlQZAeXhs8r1LZ049N2vkDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798161; c=relaxed/simple;
	bh=/IPsOvfz36IaoLMPEVDkzzTkSobJqEsMpM8GFXdXB40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ap7t3iU/4KSnoWgFk5IQcELusmPTDBIDPayje6s9G7erGDYMfkzlYBFyxbTCOjmhrIhJi0E9PvAyHUaeyKipRVW58CRtJU5Mo4Vq09vm0cwBXJfLaLeTt5erng+qghGTOpwKPpgEyUYiqScQHXemE5eKAdApI3oPJp+hEoPkqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJl1ns89; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJl1ns89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784798153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DmEfYp4ZDPnA0dZV/wfmlaH7UM97cw4u0hQUOg5VMBU=;
	b=DJl1ns891yper+IrABC/gDgOdnl3GOTe+JuEBNhSXLEkXgSK4g6PzjYNFZyQ3SAYD1UQ+u
	epP49CLg76vfoPTs/QrdVR0NeC96Tf1AQHgEplYkgaAVT/Ou9ZR6NM52InSJSSHylvpGWe
	qQYR3vwOhX88geXWbdPXTJj16OOmi5Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-pbBZ51nTNh6s-6_qB3xMyA-1; Thu,
 23 Jul 2026 05:15:48 -0400
X-MC-Unique: pbBZ51nTNh6s-6_qB3xMyA-1
X-Mimecast-MFC-AGG-ID: pbBZ51nTNh6s-6_qB3xMyA_1784798146
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ACD61805F36;
	Thu, 23 Jul 2026 09:15:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.105])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05156190DB02;
	Thu, 23 Jul 2026 09:15:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v15 6/9] tls: device: add TX KeyUpdate support
Date: Thu, 23 Jul 2026 11:15:36 +0200
Message-ID: <20260723091538.68897-1-pabeni@redhat.com>
In-Reply-To: <20260709205325.1591196-7-rjethwani@purestorage.com>
References: <20260709205325.1591196-7-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
tls: device: add TX KeyUpdate support

This patch adds TX KeyUpdate support for TLS device offload by installing
a temporary SW context with the new key while HW keeps encrypting old-key
retransmits, then swapping HW back in once all old records are ACKed.

> diff --git a/include/net/tls.h b/include/net/tls.h
> index eb258bcd62bc..2c6e314355fd 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -389,12 +422,18 @@ static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
>  static inline struct tls_sw_context_tx *tls_sw_ctx_tx(
>  		const struct tls_context *tls_ctx)
>  {
> +	if (unlikely(tls_ctx->rekey.sw_ctx))
> +		return tls_ctx->rekey.sw_ctx;
> +
>  	return (struct tls_sw_context_tx *)tls_ctx->priv_ctx_tx;
>  }
>  
>  static inline struct cipher_context *tls_tx_cipher_ctx(
>  		const struct tls_context *tls_ctx)
>  {
> +	if (unlikely(tls_ctx->rekey.cipher_ctx))
> +		return tls_ctx->rekey.cipher_ctx;
> +
>  	return (struct cipher_context *)&tls_ctx->tx;
>  }

[High]
These helpers are inline hot-path accessors that dereference
tls_ctx->rekey.sw_ctx / tls_ctx->rekey.cipher_ctx using plain loads.

Writers in tls_device_start_rekey() and tls_device_complete_rekey() set
and clear those pointers with plain stores outside offload_ctx->lock,
and readers include tls_encrypt_done() (async crypto completion, may
run in softirq) and tx_work_handler() (workqueue), neither of which
hold lock_sock.

Should these use READ_ONCE / WRITE_ONCE (and a smp_store_release on
publish paired with a smp_load_acquire on consume) so a reader on a
weakly-ordered architecture cannot observe rekey.sw_ctx transitioning
inconsistently with the TLS_TX_REKEY_PENDING flag, and so the compiler
cannot fold or reorder these loads against the flag manipulations?

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 7a98d2f6cbd3..ef837bbd9560 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -222,6 +252,19 @@ static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
>  	}
>  
>  	ctx->unacked_record_sn += deleted_records;
> +
> +	/* Once all old-key HW records are ACKed, set REKEY_READY to
> +	 * let sendmsg know it can finish the rekey and switch back
> +	 * to HW offload.
> +	 */
> +	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) &&
> +	    !test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
> +		u32 boundary_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
> +
> +		if (!before(acked_seq, boundary_seq))
> +			set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
> +	}

> @@ -253,6 +296,14 @@ void tls_device_free_resources_tx(struct sock *sk)
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);
>  
>  	tls_free_partial_record(sk, tls_ctx);
> +
> +	if (unlikely(tls_ctx->rekey.sw_ctx))
> +		tls_sw_release_resources_tx(sk);

[High]
tls_free_partial_record() is called before tls_sw_release_resources_tx().

tls_sw_release_resources_tx() has a special block gated on
if (tls_ctx->partially_sent_record) that avoids re-freeing the
msg_encrypted pages of a partially sent record — pages that were
already put_page'd by tls_free_partial_record().

Since tls_free_partial_record() first clears tls_ctx->partially_sent_record,
that special block is skipped and the generic list_for_each_entry_safe
path calls sk_msg_free(&rec->msg_encrypted), producing a double put_page
on pages already released.

Can this be triggered when rekey.sw_ctx != NULL, the SW send path hit
EAGAIN mid-send leaving a partially-sent record, and the socket is then
closed? Would swapping the order (release sw resources first, free the
partial record last, following the SW close path in tls_sk_proto_cleanup())
avoid the double free?

> +
> +	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags)) {
> +		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYABORTED);
> +		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
> +	}
>  }

> @@ -624,6 +678,19 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  			goto out;
>  	}
>  
> +	/* Old-key records all ACKed; switch back to HW. */
> +	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
> +		tls_device_complete_rekey(sk, tls_ctx, true);

[High]
The return value from tls_device_complete_rekey() is discarded here.

tls_device_complete_rekey() has early returns before rekey_fail:

    rc = tls_sw_drain_tx(sk, ctx);
    if (rc)
            return rc;

    start_marker_record = kmalloc_obj(*start_marker_record);
    if (!start_marker_record)
            return -ENOMEM;

Neither of those paths clears TLS_TX_REKEY_READY / TLS_TX_REKEY_PENDING
and neither sets TLS_TX_REKEY_FAILED.

Does this mean that under sustained memory pressure (-ENOMEM) or
repeated -EAGAIN from tls_sw_drain_tx(), every subsequent sendmsg pays
a full drain + kmalloc + drain retry cost forever, since REKEY_READY
stays set and this branch fires on every entry?

> +
> +	/* Use SW path if rekey is in progress (PENDING) or if HW rekey
> +	 * failed (FAILED).
> +	 */
> +	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) ||
> +	    test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
> +		rc = tls_sw_sendmsg_locked(sk, msg, size);
> +		goto out;
> +	}

[High]
tls_process_cmsg() runs above this block, before the rekey-state check.

tls_process_cmsg() -> tls_handle_open_record() dispatches through
ctx->push_pending_record, which is still tls_device_push_pending_record
(never rewired for rekey) and pushes via tls_push_data() on the HW
offload_ctx.

If a previous tls_sw_sendmsg_locked() left a SW open_rec with
pending_open_record_frags=true and the next sendmsg carries a cmsg
TLS_SET_RECORD_TYPE, does the HW push path run on a HW context whose
open_record is NULL while the SW open_rec is what actually needed
flushing?

Similarly, tls_device_splice_eof is installed as the splice_eof op for
TLS_HW protos and calls tls_push_data() unconditionally with no
rekey-state check. Should that entry point also route to the SW path
while REKEY_PENDING or REKEY_FAILED is set?

> @@ -1103,6 +1170,282 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c

> +static int tls_device_start_rekey(struct sock *sk,
> +				  struct tls_context *ctx,
> +				  struct tls_offload_context_tx *offload_ctx,
> +				  struct tls_crypto_info *new_crypto_info)
> +{
> +	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> +	const struct tls_cipher_desc *cipher_desc;
> +	char *key, *iv, *rec_seq, *salt;
> +	unsigned long flags;
> +	int rc;
> +
> +	cipher_desc = get_cipher_desc(new_crypto_info->cipher_type);
> +	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
> +
> +	key = crypto_info_key(new_crypto_info, cipher_desc);
> +	iv = crypto_info_iv(new_crypto_info, cipher_desc);
> +	rec_seq = crypto_info_rec_seq(new_crypto_info, cipher_desc);
> +	salt = crypto_info_salt(new_crypto_info, cipher_desc);
> +
> +	if (rekey_pending || rekey_failed) {
> +		/* Wait for in-flight async encryptions submitted to this tfm
> +		 * with the previous key before changing it.
> +		 */
> +		rc = tls_encrypt_async_wait(&offload_ctx->rekey.sw);
> +		if (rc)
> +			return rc;
> +
> +		rc = crypto_aead_setkey(offload_ctx->rekey.sw.aead_send,
> +					key, cipher_desc->key);
> +		if (rc)
> +			return rc;

[High]
On an error return from tls_encrypt_async_wait() or crypto_aead_setkey()
here, TLS_TX_REKEY_PENDING remains set, ctx->rekey.sw_ctx still points
at the SW context, and offload_ctx->rekey.sw.aead_send may have
CRYPTO_TFM_NEED_KEY set (a failed setkey sets that flag).

Subsequent tls_device_sendmsg() calls then route to
tls_sw_sendmsg_locked() using a sw_ctx that cannot encrypt.

The socket never transitions to REKEY_FAILED, so tls_tcp_clean_acked()
will eventually still set REKEY_READY, and tls_device_complete_rekey()
will attempt to install HW using offload_ctx->rekey.tx — but the
memcpy of new IV/rec_seq below has not run on this failure path, so
HW is programmed from whatever offload_ctx->rekey.tx held from a
previous rekey attempt.

Should this partial-failure path either set REKEY_FAILED or roll back
sw_ctx / PENDING?

> +
> +		memcpy(offload_ctx->rekey.tx.iv, salt, cipher_desc->salt);
> +		memcpy(offload_ctx->rekey.tx.iv + cipher_desc->salt, iv,
> +		       cipher_desc->iv);
> +		memcpy(offload_ctx->rekey.tx.rec_seq, rec_seq,
> +		       cipher_desc->rec_seq);
> +
> +		if (rekey_failed) {
> +			set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +			clear_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> +			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
> +			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
> +		}

[High]
When transitioning from FAILED back to PENDING here, boundary_seq is
not refreshed. The stale boundary_seq from the earlier failed rekey
attempt is preserved.

tls_tcp_clean_acked() uses boundary_seq to decide when to set
REKEY_READY, and tls_validate_xmit_skb_rekey() uses it to split HW
pass-through vs SW fallback for retransmits.

With a stale (much earlier) boundary_seq:

    if (!before(acked_seq, boundary_seq))
            set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);

REKEY_READY likely fires immediately on the very next ACK, and
complete_rekey installs HW at the current write_seq. Bytes in
[old_boundary_seq, current_write_seq) that were SW-encrypted with the
intermediate key would then, on retransmit, take the tls_validate_xmit_skb_rekey
'above boundary, pass through HW' branch, where HW now holds the newest
key.

Should the failed→pending path also WRITE_ONCE a new
tls_ctx->rekey.boundary_seq = tcp_sk(sk)->write_seq under
offload_ctx->lock like the initial branch does?

> +	} else {

> +		spin_lock_irqsave(&offload_ctx->lock, flags);
> +		WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->write_seq);
> +		set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +		spin_unlock_irqrestore(&offload_ctx->lock, flags);
> +
> +		/* Switch to rekey validator; new sends won't use HW offload */
> +		smp_store_release(&sk->sk_validate_xmit_skb,
> +				  tls_validate_xmit_skb_rekey);
> +	}

> +static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx,
> +				     bool deferred)
> +{
> +	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
> +	struct tls_record_info *start_marker_record;
> +	const struct tls_cipher_desc *cipher_desc;
> +	struct net_device *netdev;
> +	unsigned long flags;
> +	__be64 rcd_sn;
> +	char *key;
> +	int rc;

> +	if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
> +		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> +						TLS_OFFLOAD_CTX_DIR_TX);
> +		set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
> +	}
> +
> +	memcpy(crypto_info_rec_seq(&offload_ctx->rekey.crypto_send.info, cipher_desc),
> +	       offload_ctx->rekey.tx.rec_seq, cipher_desc->rec_seq);
> +
> +	rc = tls_device_dev_add_tx(sk, netdev, &offload_ctx->rekey.crypto_send.info,
> +				   tcp_sk(sk)->write_seq);
> +	if (!rc)
> +		clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);

[High, High]
Two concerns here about the tls_dev_del + tls_dev_add sequence:

Unlike tls_device_down(), which uses synchronize_net() before
tls_dev_del() to fence in-flight packets, this path replaces the NIC
context with no such fence. Packets already handed to the driver TX
queue may still be traversing the NIC's TLS engine when tls_dev_del
removes the old context and tls_dev_add installs the new one at the
current write_seq. Can that lead to in-flight SW-encrypted segments
being double-encrypted, or to old-context in-flight packets being
corrupted, depending on driver semantics?

Second, this changes the tlsdev_ops contract by calling tls_dev_add on
a tls_context that already had tls_dev_add + tls_dev_del called on it
(mid-lifetime replace). The in-tree offload drivers (mlx5, chcr, cxgb4,
nfp, funeth) were written under the single-add/single-del assumption
and may allocate per-socket state keyed on sk/ctx assuming no prior
state exists on entry. The commit notes it was tested only on
ConnectX-6 Dx. Should this be gated on a new driver capability, or the
other drivers audited and updated in the same series?

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
> +
> +	memcpy(ctx->tx.iv, offload_ctx->rekey.tx.iv,
> +	       cipher_desc->salt + cipher_desc->iv);
> +	memcpy(ctx->tx.rec_seq, offload_ctx->rekey.tx.rec_seq,
> +	       cipher_desc->rec_seq);
> +	unsafe_memcpy(&ctx->crypto_send.info,
> +		      &offload_ctx->rekey.crypto_send.info,
> +		      cipher_desc->crypto_info,
> +		      /* checked during rekey setup */);
> +
> +	key = crypto_info_key(&offload_ctx->rekey.crypto_send.info, cipher_desc);
> +	rc = crypto_aead_setkey(offload_ctx->aead_send, key, cipher_desc->key);
> +	if (rc)
> +		goto rekey_fail;

[Critical]
By this point, tls_device_dev_add_tx() has already succeeded (HW is
programmed with the new key, TLS_TX_DEV_CLOSED cleared), and
ctx->tx.iv, ctx->tx.rec_seq, ctx->crypto_send.info, and
unacked_record_sn have all been overwritten with new-key material.

A subsequent failure of crypto_aead_setkey(offload_ctx->aead_send, ...)
jumps to rekey_fail. rekey_fail only sets TLS_TX_REKEY_FAILED and
returns 0.

It does not tear down the just-installed HW context, does not restore
ctx->tx / ctx->crypto_send, does not restore unacked_record_sn, does
not re-set TLS_TX_DEV_CLOSED, and does not switch sk_validate_xmit_skb
back to tls_validate_xmit_skb_sw.

offload_ctx->aead_send is left in CRYPTO_TFM_NEED_KEY state, so
tls_sw_fallback() will fail encryption on any retransmit — and since
the validator is still tls_validate_xmit_skb_rekey with the FAILED bit
set, the very first check in that validator passes such retransmits
through unchanged. Can this send plaintext TLS records on the wire?

Should this failure path roll back the HW install (and the ctx->tx /
crypto_send / unacked_record_sn state), and should rekey_fail return
the actual error to the caller rather than 0?

> +
> +	/* Start marker: the NIC passes through everything before
> +	 * write_seq unencrypted (already SW-encrypted during rekey),
> +	 * same as during initial offload setup.
> +	 */
> +	tls_device_commit_start_marker(sk, offload_ctx, start_marker_record);

> +	crypto_free_aead(tls_sw_ctx_tx(ctx)->aead_send);
> +	ctx->rekey.sw_ctx = NULL;
> +	ctx->rekey.cipher_ctx = NULL;
> +	memzero_explicit(&offload_ctx->rekey, sizeof(offload_ctx->rekey));

[Critical]
tls_sw_drain_tx() further down does cancel_delayed_work_sync() but does
not set BIT_TX_CLOSING first.

tx_work_handler is designed to reschedule itself via
schedule_delayed_work when its mutex_trylock(&tls_ctx->tx_lock) fails.
tls_device_complete_rekey() is invoked while tx_lock is held (its
caller tls_device_sendmsg holds tx_lock across the whole path), so any
concurrently running tx_work_handler is guaranteed to trylock-fail and
reschedule itself.

After cancel_delayed_work_sync() returns, this code path clears
ctx->rekey.sw_ctx = NULL and then memzero_explicit's
offload_ctx->rekey — which contains the delayed_work embedded in
offload_ctx->rekey.sw.tx_work.work (including work.func).

When the workqueue timer fires later, is the work item that gets run
one whose containing memory has been zeroed?

Compare with tls_sw_cancel_work_tx() which sets BIT_TX_CLOSING and uses
disable_delayed_work_sync() precisely to prevent this re-queue.

> +
> +	if (deferred)
> +		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
> +	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
> +	return 0;
> +
> +rekey_fail:
> +	kfree(start_marker_record);
> +	spin_lock_irqsave(&offload_ctx->lock, flags);
> +	set_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> +	clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
> +	clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +	spin_unlock_irqrestore(&offload_ctx->lock, flags);

[High]
On any tls_dev_add failure inside this function, TLS_TX_DEV_CLOSED
stays set for the lifetime of the socket, because the clear_bit only
runs on success. Both tls_device_tx_del_task() and tls_device_down()
skip tls_dev_del when TLS_TX_DEV_CLOSED is set.

If the driver's tls_dev_add failure path leaves partial per-connection
HW state (partially programmed TCB, allocated key buffers, or in-flight
PSV), does the driver ever get a chance to reclaim those resources?
Is this relying on every driver's tls_dev_add error path fully cleaning
up on internal failure?

> diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
> index 1110f7ac6bcb..64ac4ef4012b 100644
> --- a/net/tls/tls_device_fallback.c
> +++ b/net/tls/tls_device_fallback.c
> @@ -435,6 +435,30 @@ struct sk_buff *tls_validate_xmit_skb_sw(struct sock *sk,
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

[Critical]
When TLS_TX_REKEY_FAILED is set, this returns the skb unmodified for
every packet, including TCP retransmits of records below boundary_seq
that were SW-encrypted with the old key.

Consider the failure path in tls_device_complete_rekey() where
tls_dev_del() has succeeded (TLS_TX_DEV_CLOSED set) and then
tls_device_dev_add_tx() fails: HW offload is entirely gone, yet this
validator bypasses tls_sw_fallback() and lets the record go out on the
wire unencrypted.

Consider the second failure path where tls_device_dev_add_tx() succeeds
but the later crypto_aead_setkey(offload_ctx->aead_send) fails: HW is
now programmed with the new key, but retransmits of TCP segments below
boundary_seq skip SW fallback here and are handed to HW, which will
encrypt them with the wrong key.

Either way, does the commit-message assertion "if the HW reinstall
fails the socket stays in SW mode (REKEY_FAILED)" actually hold, or
are old-data retransmits corrupted or transmitted in plaintext when
REKEY_FAILED is set?

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

> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index c4c15c0e731a..b51f9ea1ed6c 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -449,8 +457,16 @@ static int do_tls_getsockopt_conf(struct sock *sk, char __user *optval,
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

[Medium]
Before this change, TLS_TX getsockopt could only expose the current
in-use key. This branch now returns offload_ctx->rekey.crypto_send.info
during the rekey window — a key that has not yet taken effect on the
wire.

On the rekey_fail path, offload_ctx->rekey is not zeroed (only the
final success path memzero_explicit's it), so this raw new-key material
remains observable via getsockopt until tls_device_free_ctx()
eventually clears it at socket destruction.

Is exposing the not-yet-active key (and leaving the material
observable across REKEY_FAILED) intentional, and should rekey_fail also
memzero_explicit offload_ctx->rekey?

> @@ -714,32 +730,32 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
>  	if (tx) {
> -		if (update && ctx->tx_conf == TLS_HW) {
> -			rc = -EOPNOTSUPP;
> -			goto err_crypto_info;
> -		}
> -
> -		if (!update) {
> -			rc = tls_set_device_offload(sk);
> -			conf = TLS_HW;
> -			if (!rc) {
> +		rc = tls_set_device_offload(sk, update ? crypto_info : NULL);
> +		conf = TLS_HW;
> +		if (!rc) {
> +			if (!update) {
>  				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
>  				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
> -				goto out;
>  			}
> -		}
> -
> -		rc = tls_set_sw_offload(sk, 1, update ? crypto_info : NULL);
> -		if (rc)
> +		} else if (update && ctx->tx_conf == TLS_HW) {
> +			/* HW rekey failed - return the actual error.
> +			 * Cannot fall back to SW for an existing HW connection.
> +			 */
>  			goto err_crypto_info;
> -
> -		if (update) {
> -			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
>  		} else {
> -			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
> -			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
> +			rc = tls_set_sw_offload(sk, 1,
> +						update ? crypto_info : NULL);

> @@ -885,12 +901,29 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>  	switch (optname) {
>  	case TLS_TX:
> -	case TLS_RX:
> +	case TLS_RX: {
> +		struct tls_context *ctx = tls_get_ctx(sk);
> +		/* A HW-offload TX rekey arrives mid-stream and races with an
> +		 * in-flight tls_device_sendmsg(), which holds tx_lock across
> +		 * the lock_sock drop in sk_stream_wait_memory() while an
> +		 * open_record is half built. start_rekey() would flush that
> +		 * record and flip the SW/HW boundary under the sender,
> +		 * corrupting record framing. Serialize against the data path
> +		 * with tx_lock. Only the HW TX path reaches start_rekey, and
> +		 * initial setup (tx_conf == BASE) has no concurrent sender.
> +		 */
> +		bool tx_rekey = optname == TLS_TX && ctx->tx_conf == TLS_HW;
> +
> +		if (tx_rekey)
> +			mutex_lock(&ctx->tx_lock);
>  		lock_sock(sk);

[Medium]
The comment above explicitly cites the race between rekey and in-flight
tls_device_sendmsg() as the motivation for tx_lock, but the decision to
acquire tx_lock is based on an unlocked read of ctx->tx_conf — the very
field that transitions concurrently:

    bool tx_rekey = optname == TLS_TX && ctx->tx_conf == TLS_HW;
    if (tx_rekey)
            mutex_lock(&ctx->tx_lock);
    lock_sock(sk);

If a concurrent initial-setup path is completing on the same socket and
flipping tx_conf to TLS_HW between this read and lock_sock(), this
thread skips tx_lock while a subsequent tls_device_sendmsg() starts
running. Does this reintroduce the TOCTOU the tx_lock is meant to
close? Would always taking tx_lock for TLS_TX (or deciding under
lock_sock and then acquiring tx_lock with the correct ordering) be
safer?

>  		rc = do_tls_setsockopt_conf(sk, optval, optlen,
>  					    optname == TLS_TX);
>  		release_sock(sk);
> +		if (tx_rekey)
> +			mutex_unlock(&ctx->tx_lock);
>  		break;
> +	}

[Medium]
Separately, LINUX_MIB_TLSTXREKEYOK looks like it can be incremented
twice for a single user-visible KeyUpdate. When a second KeyUpdate
arrives while the first is still pending, tls_set_device_offload_rekey()'s
defer path bumps TLSTXREKEYOK immediately:

    if (defer) {
            if (!rekey_pending)
                    TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
            else
                    TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
            return 0;
    }

and later tls_device_complete_rekey()'s success path bumps
TLSTXREKEYOK again for the same rekey.

Additionally, tls_device_free_resources_tx() unconditionally decrements
TLSTXREKEYINPROGRESS when REKEY_PENDING is set, while
tls_device_complete_rekey() also decrements it on the deferred path.
Can these counters go negative or over-count depending on the
FAILED/PENDING/READY transition sequence?
-- 
This is an AI-generated review.

