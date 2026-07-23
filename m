Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126D419303
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798168; cv=none; b=Uv5K5XrwwBWjsd0Z9m33eeC7NZJBNSO3EcKpuEgTpLyE5FlHYe9FhnMPWKfcWfcB24An/hWqiQflUr7uqng0kgoXm7lu7TmUstcPss/JMKCmaiJqcEZT9aXHs3z/wUXZoR+K7tVDlEaem62rL/x+pceUoAdJ0BS0ZN4nD0Vtz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798168; c=relaxed/simple;
	bh=IAS3rkPhFItvs6WNQrsmvl9DFHLaa8OvWWh4Iw3vKEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8b/0/vdNkHSSPXpweFBeFiddCxZln5ru/UFgEQq+f+JXLVj2kPH7/UhGeb0AILNjJUqQhXu+FhuuvbtPgj0C5cM/ne/UABqHnDIwAZiZYb6gY0fGP6ZW3i7v8e8GcADNjrLnfhUYG356MmoX3pJLxoIcJl81AgOuXKwG+6mQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iebx7fia; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iebx7fia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784798161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UvrMFAqt8HSQ6zg2OyDVSHD5D+HABYdkK0EzGKaROQ=;
	b=iebx7fiaHZSAf/CHqwgwVIqds8HFRJ0Bdc6uRJ7C4vlmUXNBI8QSfXTjNYSRRhWFBp9+7+
	GSkBjZ8gPGr2Ai6t+MQZEROdpgyn3S01ypbbGg7s78j4o8Ps4GdB3bKj9gZ0zpd6aNrzej
	DzANHqlJXp+SG/kEGY5ql8ld7xCcC3g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-PVIEtjN2NRuuRETw62YXDw-1; Thu,
 23 Jul 2026 05:15:57 -0400
X-MC-Unique: PVIEtjN2NRuuRETw62YXDw-1
X-Mimecast-MFC-AGG-ID: PVIEtjN2NRuuRETw62YXDw_1784798156
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92AB919541B2;
	Thu, 23 Jul 2026 09:15:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.105])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 410BD1956054;
	Thu, 23 Jul 2026 09:15:51 +0000 (UTC)
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
Subject: Re: [PATCH v15 7/9] tls: device: add RX KeyUpdate support
Date: Thu, 23 Jul 2026 11:15:46 +0200
Message-ID: <20260723091548.68912-1-pabeni@redhat.com>
In-Reply-To: <20260709205325.1591196-8-rjethwani@purestorage.com>
References: <20260709205325.1591196-8-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
tls: device: add RX KeyUpdate support

Adds RX KeyUpdate support for TLS device offload, retaining the old
AEAD/IV/rec_seq on tls_offload_context_rx so in-flight records that the
NIC already decrypted with the old key can still be processed, and
deferring installation of the new key until copied_seq crosses
old_nic_boundary.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> index 337201f12895..71c9d3ca947d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> @@ -86,10 +86,20 @@ static int mlx5e_ktls_resync(struct net_device *netdev,
>  	return 0;
>  }
>  
> +static void mlx5e_ktls_rx_rekey_fixup(struct sk_buff *skb)
> +{
> +	struct sk_buff *frag_iter;
> +
> +	skb->decrypted = 1;
> +	skb_walk_frags(skb, frag_iter)
> +		frag_iter->decrypted = 1;
> +}
> +
>  static const struct tlsdev_ops mlx5e_ktls_ops = {
>  	.tls_dev_add = mlx5e_ktls_add,
>  	.tls_dev_del = mlx5e_ktls_del,
>  	.tls_dev_resync = mlx5e_ktls_resync,
> +	.tls_dev_rx_rekey_fixup = mlx5e_ktls_rx_rekey_fixup,
>  };

[Medium]
Is this RX rekey infrastructure safe to enable unconditionally for every
HW-offloaded TLS RX socket?  Only mlx5 implements tls_dev_rx_rekey_fixup
here.  Other in-tree drivers that advertise NETIF_F_HW_TLS_RX (for
example nfp) will still enter the rekey state machine with a NULL
fixup pointer, so the whole-record-mangled-by-NIC scenario the fixup
was introduced to handle would be uncovered on those NICs.

Would gating RX rekey on explicit driver opt-in (a capability flag or
the presence of tls_dev_rx_rekey_fixup) be more appropriate than
assuming all NICs behave like ConnectX-6 Dx?

[ ... ]

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index ef837bbd9560..74583433b593 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -66,8 +66,14 @@ static void tls_device_free_ctx(struct tls_context *ctx)
>  		kfree(offload_ctx);
>  	}
>  
> -	if (ctx->rx_conf == TLS_HW)
> -		kfree(tls_offload_ctx_rx(ctx));
> +	if (ctx->rx_conf == TLS_HW) {
> +		struct tls_offload_context_rx *offload_ctx =
> +			tls_offload_ctx_rx(ctx);
> +
> +		memzero_explicit(&offload_ctx->rekey,
> +				 sizeof(offload_ctx->rekey));
> +		kfree(offload_ctx);
> +	}

[Medium]
Can this silently overwrite offload_ctx->rekey.old_aead_recv without
first freeing it?

memzero_explicit() clears the field but does not call crypto_free_aead(),
so if any path reaches tls_device_free_ctx() with old_aead_recv still
non-NULL, the crypto_aead transform and the AEAD key material it holds
are leaked, and the explicit-zero intent is defeated for that material.

Current callers appear to free old_aead_recv earlier in
tls_device_offload_cleanup_rx(), so no leak fires today.  Would it be
safer to call crypto_free_aead(offload_ctx->rekey.old_aead_recv)
before the memzero_explicit(), to make this robust against future
paths (for example races between tls_device_down and sk_destruct)?

[ ... ]

> +static int tls_device_dev_add_rx(struct sock *sk, struct tls_context *tls_ctx,
> +				 struct net_device *netdev,
> +				 struct tls_crypto_info *crypto_info,
> +				 u32 cur_seq, bool is_rekey)
> +{
[ ... ]
> +	if (!rc) {
> +		clear_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
> +		clear_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
> +		if (is_rekey)
> +			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
> +	} else if (is_rekey) {
> +		set_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
> +		set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
> +		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK);
> +	}
> +	return rc;
> +}

[Medium]
Is TLS_RX_DEV_CLOSED being repurposed in a way that could confuse
existing consumers?

Previously the bit denoted permanent teardown, used by tls_device_down()
and tls_device_offload_cleanup_rx() to avoid a double tls_dev_del.  This
patch also sets/clears it as a transient state during rekey (set before
tls_dev_del in the rekey path, cleared inside tls_device_dev_add_rx() on
success, and toggled by tls_device_rx_del_key() when a KeyUpdate record
is parsed), while other checks (tls_device_rx_resync_new_rec early
return, tls_device_offload_cleanup_rx skip-dev_del logic) still treat it
as terminal.

Would splitting the transient rekey state into a separate bit make the
semantics less error-prone for future changes?

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

[ ... ]

> +static int tls_device_reencrypt_old_key(struct sock *sk,
> +					struct tls_offload_context_rx *ctx,
> +					struct tls_sw_context_rx *sw_ctx,
> +					struct tls_context *tls_ctx)
> +{
> +	struct crypto_aead *saved_aead = sw_ctx->aead_recv;
> +	char saved_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
> +	char saved_rec_seq[TLS_MAX_REC_SEQ_SIZE];
> +	int ret;
[ ... ]
> +	sw_ctx->aead_recv = saved_aead;
> +	memcpy(tls_ctx->rx.iv, saved_iv, sizeof(saved_iv));
> +	memcpy(tls_ctx->rx.rec_seq, saved_rec_seq, sizeof(saved_rec_seq));
> +
> +	if (ret)
> +		return ret;
[ ... ]
> +	return 0;
> +}

[Low]
Should saved_iv[] and saved_rec_seq[] be scrubbed with
memzero_explicit() before this function returns?

They hold TLS 1.3 traffic-secret-derived IV material copied from
tls_ctx->rx.iv and rx.rec_seq.  Elsewhere in this subsystem
memzero_explicit() is used consistently to scrub such material
(tls_ctx_free, tls_sw_ctx_finalize, and the new memzero on
offload_ctx->rekey in tls_device_free_ctx).  Leaving the buffers
un-scrubbed on the stack seems inconsistent with the surrounding
hygiene.

> +
>  int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
>  {
>  	struct tls_offload_context_rx *ctx = tls_offload_ctx_rx(tls_ctx);
>  	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
>  	struct sk_buff *skb = tls_strp_msg(sw_ctx);
> +	u32 copied_seq = tcp_sk(sk)->copied_seq;
>  	struct strp_msg *rxm = strp_msg(skb);
>  	int is_decrypted, is_encrypted;
> +	u32 rec_start_seq;
>  
>  	if (!tls_strp_msg_mixed_decrypted(sw_ctx)) {
>  		is_decrypted = skb->decrypted;
> @@ -1098,10 +1225,42 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
>  		is_encrypted = 0;
>  	}
>  
> -	trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full_len,
> +	rec_start_seq = sw_ctx->strp.copy_mode
> +		? copied_seq - rxm->full_len
> +		: copied_seq;
> +
> +	trace_tls_device_decrypted(sk, rec_start_seq,
>  				   tls_ctx->rx.rec_seq, rxm->full_len,
>  				   is_encrypted, is_decrypted);

[Medium]
Is this an intentional silent change to the first argument of the
trace_tls_device_decrypted() tracepoint?

The previous expression was unconditionally copied_seq - rxm->full_len;
the new form is copied_seq for the non-copy_mode case.  Observability
tools consuming this tracepoint may see a different value for the same
record boundary.

The same rec_start_seq is also fed into the classification below via
before(rec_start_seq, ctx->rekey.old_nic_boundary).  If either branch of
the ternary is off by one full record, the record would be routed to
the wrong rekey path (drop-and-increment-old-seq vs reencrypt-with-old
-key).  Could the commit message describe why the two modes use
different formulas, and how the choice was validated?

>  
> +	if (unlikely(ctx->rekey.old_aead_recv)) {
> +		bool before_nic_boundary =
> +			before(rec_start_seq, ctx->rekey.old_nic_boundary);
> +
> +		if (before_nic_boundary) {
> +			if (is_encrypted) {
> +				tls_bigint_increment(ctx->rekey.old_rec_seq,
> +						     tls_ctx->prot_info.rec_seq_size);
> +				return 0;
> +			}
> +
> +			/* rekey_fixup sets decrypted flags in case if NIC clears
> +			 * decrypted flags on auth failure
> +			 */
> +			if (!is_decrypted && ctx->rekey.rekey_fixup)
> +				ctx->rekey.rekey_fixup(skb);
> +
> +			return tls_device_reencrypt_old_key(sk, ctx,
> +							    sw_ctx, tls_ctx);
> +		}

[High]
Does the classification here miss the whole-record NIC-auth-failure
case?

The comment and the mlx5e_ktls_rx_rekey_fixup callback state that the
NIC may clear skb->decrypted on auth failure.  If the NIC has already
XORed the payload with the old key's keystream and then cleared
skb->decrypted on every fragment (not mixed), is_encrypted computes as
1 in the !tls_strp_msg_mixed_decrypted branch:

    if (!tls_strp_msg_mixed_decrypted(sw_ctx)) {
        is_decrypted = skb->decrypted;   /* 0 */
        is_encrypted = !is_decrypted;    /* 1 */
    }

The code then advances old_rec_seq and returns 0, feeding the record to
SW which will attempt decryption with the new key and fail AEAD
verification.  Only the mixed sub-case reaches ctx->rekey.rekey_fixup.
Should the whole-record path also invoke rekey_fixup and
reencrypt-with-old-key?

[Medium]
Can old_rec_seq drift after tls_device_rx_del_key() has already torn
down the NIC key?

Sequence:

  1. KeyUpdate is parsed by SW; tls_check_pending_rekey() ->
     tls_device_rx_del_key() calls tls_dev_del, so the NIC no longer
     holds any key.

  2. Records that arrive next are wire-encrypted with the peer's new
     key and reach tls_device_decrypted() with is_encrypted == 1 while
     rec_start_seq is still before old_nic_boundary.

  3. This code increments ctx->rekey.old_rec_seq for each such record.

If any later record in the same window turns out to be mixed
(!is_encrypted && !is_decrypted), tls_device_reencrypt_old_key() will
use the inflated old_rec_seq as the AES-GCM nonce input.  Would that
produce ciphertext that does not match what the NIC actually XORed with
the old key?

> +
> +		crypto_free_aead(ctx->rekey.old_aead_recv);
> +		ctx->rekey.old_aead_recv = NULL;
> +
> +		if (ctx->dev_add_pending)
> +			tls_device_deferred_dev_add_rx(sk, tls_ctx, ctx);
> +	}
> +

[ ... ]

> @@ -1612,29 +1789,88 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
[ ... ]
> +	rc = tls_sw_ctx_init(sk, 0, new_crypto_info);
>  	if (rc)
>  		goto release_ctx;
>  
> -	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_RX,
> -					     &ctx->crypto_recv.info,
> -					     tcp_sk(sk)->copied_seq);
> -	info = (void *)&ctx->crypto_recv.info;
> -	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_RX,
> -				     tcp_sk(sk)->copied_seq, info->rec_seq, rc);
> -	if (rc)
> -		goto free_sw_resources;
> +	if (!context->dev_add_pending) {
> +		rc = tls_device_dev_add_rx(sk, ctx, netdev, src_crypto_info,
> +					   copied_seq, !!new_crypto_info);
> +		if (!new_crypto_info) {
> +			if (rc)
> +				goto free_sw_resources;
> +			tls_device_attach(ctx, sk, netdev);
> +		}
> +	} else if (!was_dev_add_pending) {
> +		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
> +	} else {
> +		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
> +	}
> +
> +	tls_sw_ctx_finalize(sk, 0, new_crypto_info);

[High]
Does this path silently swallow a real HW rekey failure?

When new_crypto_info != NULL and dev_add_pending is 0,
tls_device_dev_add_rx() is called and rc is stored, but the immediate
error handling is guarded by if (!new_crypto_info).  On the rekey path
control falls through to tls_sw_ctx_finalize() and eventually the
return 0 at the end of the success block.

Meanwhile tls_device_dev_add_rx() has already bumped
LINUX_MIB_TLSRXREKEYFALLBACK and set TLS_RX_DEV_DEGRADED /
TLS_RX_DEV_CLOSED, and the NIC-side context has been torn down.

In do_tls_setsockopt_conf() the intended contract is:

    } else if (update && ctx->rx_conf == TLS_HW) {
        /* HW rekey failed - return the actual error.
         * Cannot fall back to SW for an existing HW connection.
         */
        goto err_crypto_info;
    }

But because rc is effectively discarded, that branch is never taken —
setsockopt() returns 0, rx_conf stays TLS_HW, and telemetry, return
code and state are all inconsistent.  Should the rekey branch also
propagate rc (for example goto release_ctx / err_crypto_info) when
tls_device_dev_add_rx() fails?

[Medium]
Can TLSRXREKEYOK be double-counted, and TLSRXREKEYINPROGRESS leak?

When was_dev_add_pending is true and dev_add_pending remains 1
(a second rekey arrives while the first is still deferred), this
branch runs:

    } else {
        TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
    }

No NIC add has occurred yet.  Later, when copied_seq crosses
old_nic_boundary, tls_device_deferred_dev_add_rx() calls
tls_device_dev_add_rx(..., is_rekey=true), which on success increments
TLSRXREKEYOK again.

The superseded first rekey's TLSRXREKEYINPROGRESS also does not appear
to be decremented in this chained-rekey path.  Is the accounting
intended to work that way?

[ ... ]

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
[ ... ]
> @@ -1098,10 +1225,42 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
[ ... ]
> +			/* rekey_fixup sets decrypted flags in case if NIC clears
> +			 * decrypted flags on auth failure
> +			 */

[Low]
The phrase "in case if" reads as either "in case" or "if" but not both.
-- 
This is an AI-generated review.

