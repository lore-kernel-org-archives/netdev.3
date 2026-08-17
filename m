Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1E3E49FF
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004708; cv=none; b=oCspBd1HxxyGhFTrX7p0DAfmjNzU94aM8Yubftwa/5vR+wFKB1HgdtPURrNnxEK/1SO3RhQkcem9jKnin4b9YmbIlo5JRN0TBavCwkpQHLdoKMjXqVXMOWZHfHPZsjXw4Ur8AK5mhDHTp/6iN0uC4Ejf+MCaz9jsw/84jT08Tg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004708; c=relaxed/simple;
	bh=zvlt8h17ANsRa10teyGAyeGWZD7EkOvt0irQKxchVmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEkd4YeYSFZJal+kmYvYwC2oGgedMVA/ePkCmHn87uJVMxkgtUPzBk7+nnTXWKzs57PJ5vFNRm6C9ZtoA84DJis7VI0H3ScDimxnwx7n6AG1RBAr77A4pFmW3U4b5xnzzN0CORA3nZUvnZcrI1gcT53dl5O89+tVu5Ji6VJ9J2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNv4O0RE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNv4O0RE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6FD1F000E9;
	Mon, 17 Aug 2026 22:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787004706;
	bh=0tUAkzzgmR505gcLFWBx0+ZtZqR819rVWVCWhBX2yss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TNv4O0REDd8F5jwWEyiK1VnHgbtl97MPqZtXIEvchvHblS3p7CQDfxJZK1m5CvJa+
	 0ruGVLPG+KICfcwTcBR0eF0uohRGaD2QlnnyTEPkADf7kISfXuAPhQ4hKn5E3S2r0r
	 dHdWsbRXg063dHDF9yoYsRfEM+X5u5zGlnvZB+Uhi38gvSGa79X2AklD1klavEt50a
	 Z4Xm9hJtu3VOE5w7v4DG0uonvNnzJjlhT7cDb4q/yGB9cRbKeX7SjOgjg+exQPb0FL
	 PKGsG0iNkcWvBdxBC57Uj0b+3aFZTVkwQXKQk+0LQNLGf/O01A4/5jTQk967dLyPSO
	 OnSXQcRU5qJ9A==
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
Subject: Re: [PATCH v16 08/10] tls: device: add RX KeyUpdate support
Date: Mon, 17 Aug 2026 15:11:45 -0700
Message-ID: <20260817221145.3666490-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807183853.2288959-9-rjethwani@purestorage.com>
References: <20260807183853.2288959-9-rjethwani@purestorage.com>
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
tls: device: add RX KeyUpdate support

This adds RX KeyUpdate handling for TLS device offload by retaining the old
AEAD/IV/rec_seq on tls_offload_context_rx and classifying records against a
TCP sequence boundary, with the new key's tls_dev_add deferred until the old
key is drained. It also adds a new tls_dev_rx_rekey_fixup driver callback
(implemented for mlx5e) and three RX rekey statistics.

A few questions on the new paths below.

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

[Severity: High]
Should this be restricted to the fragments the device actually transformed?

tls_device_decrypted() invokes the callback for any pre-boundary record that
is neither fully encrypted nor fully decrypted, that is, for genuinely mixed
records:

	if (!is_decrypted && ctx->rekey.rekey_fixup)
		ctx->rekey.rekey_fixup(skb);

	return tls_device_reencrypt_old_key(sk, ctx, sw_ctx, tls_ctx);

and tls_device_reencrypt() decides per fragment whether to write the
transformed buffer back:

	if (skb_iter->decrypted) {
		err = skb_store_bits(skb_iter, frag_pos, buf, copy);

In mlx5e_ktls_handle_rx_skb() a cleared skb->decrypted is ambiguous: it is
left clear for CQE_TLS_OFFLOAD_ERROR (payload transformed, auth failed) and
also for CQE_TLS_OFFLOAD_RESYNC and non-offloaded packets (payload
untouched).

Since the new tls_device_rx_del_key() destroys the NIC RX context mid-stream
at KeyUpdate parse time, a record can straddle that point with leading
fragments transformed by the device and trailing fragments still carrying
wire ciphertext.

Does setting decrypted = 1 on the head skb and every fragment then make
tls_device_reencrypt() overwrite untouched ciphertext, so the following SW
AEAD decrypt of that record fails and tls_rx_one_record() aborts the
connection with -EBADMSG?

>  static const struct tlsdev_ops mlx5e_ktls_ops = {
>  	.tls_dev_add = mlx5e_ktls_add,
>  	.tls_dev_del = mlx5e_ktls_del,
>  	.tls_dev_resync = mlx5e_ktls_resync,
> +	.tls_dev_rx_rekey_fixup = mlx5e_ktls_rx_rekey_fixup,
>  };
>  
>  bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
> diff --git a/include/net/tls.h b/include/net/tls.h
> index 7c2cf51dc887..de4e25b034d6 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -211,10 +211,11 @@ enum tls_context_flags {
>  	 * to be atomic.
>  	 */
>  	TLS_TX_SYNC_SCHED = 1,
> -	/* tls_dev_del was called for the RX side, device state was released,
> -	 * but tls_ctx->netdev might still be kept, because TX-side driver
> -	 * resources might not be released yet. Used to prevent the second
> -	 * tls_dev_del call in tls_device_down if it happens simultaneously.
> +	/* tls_dev_del was called for the RX side: the NIC currently holds no
> +	 * RX offload context. Set whenever that context is released (socket
> +	 * teardown, tls_device_down, or during a rekey before re-add) and
> +	 * cleared when tls_dev_add re-establishes it. Readers use it to avoid
> +	 * a double tls_dev_del and to suppress resync while the NIC has no key.
>  	 */
>  	TLS_RX_DEV_CLOSED = 2,

[Severity: Low]
The reworded comment says the bit is set whenever the RX context is released,
including socket teardown, but tls_device_offload_cleanup_rx() still sets it
only in the tx_conf == TLS_HW branch:

	if (tls_ctx->tx_conf != TLS_HW) {
		dev_put(netdev);
		rcu_assign_pointer(tls_ctx->netdev, NULL);
	} else {
		set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
	}

On the common tx_conf != TLS_HW teardown the RX context is released with the
flag left clear. Should the comment or the code be adjusted so readers of the
flag get the documented invariant?

>  	/* Flag for TX HW context deleted during failed rekey.
> @@ -321,6 +322,7 @@ struct tlsdev_ops {
>  	int (*tls_dev_resync)(struct net_device *netdev,
>  			      struct sock *sk, u32 seq, u8 *rcd_sn,
>  			      enum tls_offload_ctx_dir direction);
> +	void (*tls_dev_rx_rekey_fixup)(struct sk_buff *skb);
>  };

[Severity: Low]
This isn't a bug, but a new member of a driver-facing ops table is added with
no kernel-doc describing when the core calls it or what the driver must
guarantee, and mlx5e is the only implementer.

No other driver is reachable here today (nfp_net_tls_add() returns
-EOPNOTSUPP unless crypto_info->version == TLS_1_2_VERSION, and rekey is only
permitted for TLS 1.3, while chcr_ktls, cxgb4 and funeth are TX-only), so
could a short comment be added describing the expected semantics for future
RX-offload drivers?

>  
>  enum tls_offload_sync_type {

[ ... ]

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 85c74d0816b7..c34268cd9531 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c

[ ... ]

> @@ -186,6 +196,82 @@ static void tls_device_commit_start_marker(struct sock *sk,
>  	tcp_write_collapse_fence(sk);
>  }
>  
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
> +	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
> +	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_RX,
> +				     cur_seq, rec_seq, rc);
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
> +
> +static void tls_device_deferred_dev_add_rx(struct sock *sk,
> +					   struct tls_context *tls_ctx,
> +					   struct tls_offload_context_rx *ctx)
> +{
> +	struct net_device *netdev;
> +
> +	ctx->dev_add_pending = 0;
> +
> +	down_read(&device_offload_lock);
> +	netdev = rcu_dereference_protected(tls_ctx->netdev,
> +					   lockdep_is_held(&device_offload_lock));
> +	if (netdev)
> +		tls_device_dev_add_rx(sk, tls_ctx, netdev,
> +				      &tls_ctx->crypto_recv.info,
> +				      tcp_sk(sk)->copied_seq, true);

[Severity: High]
Is the record number handed to the device here still valid?

crypto_recv.info holds the rec_seq userspace supplied at setsockopt time,
which is 0 for a TLS 1.3 KeyUpdate, and tls_sw_ctx_finalize() copies it in
once. The live counter is tls_ctx->rx.rec_seq, advanced per record by
tls_rx_one_record():

	tls_advance_record_sn(sk, prot, &tls_ctx->rx);

This deferred add only runs once the first post-boundary record is
classified, so at least one record has already been drained with the new key,
while cur_seq is the current tcp_sk(sk)->copied_seq.

On the driver side fill_static_params() does:

	initial_rn  = MLX5_ADDR_OF(tls_static_params, ctx, initial_record_number);
	memcpy(initial_rn,  rec_seq, rec_seq_sz);

and fill_progress_params() sets next_record_tcp_sn = start_offload_tcp_sn, so
the (TCP seq, record number) pair programmed into the NIC looks inconsistent
by the number of records already consumed. Should tls_ctx->rx.rec_seq be
passed instead? In copy_mode copied_seq is also already past the end of the
record just classified, which would add a further one-record skew.

> +	else
> +		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK);
> +	up_read(&device_offload_lock);
> +	TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
> +}
> +
> +void tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx)
> +{
> +	struct net_device *netdev;
> +
> +	if (ctx->rx_conf != TLS_HW)
> +		return;
> +	if (test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
> +		return;
> +
> +	down_read(&device_offload_lock);
> +	netdev = rcu_dereference_protected(ctx->netdev,
> +					   lockdep_is_held(&device_offload_lock));
> +	if (!netdev) {
> +		up_read(&device_offload_lock);
> +		return;
> +	}
> +
> +	set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
> +	synchronize_net();
> +	netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> +					TLS_OFFLOAD_CTX_DIR_RX);
> +	up_read(&device_offload_lock);
> +}

[Severity: Medium]
This now runs from the per-record receive path:

tls_rx_one_record() -> tls_check_pending_rekey() -> tls_device_rx_del_key()

with lock_sock(sk) and the TLS RX reader lock held. Here we do
synchronize_net() and then ->tls_dev_del(), and mlx5e_ktls_del_rx() does a
second synchronize_net(), cancel_work_sync() and, when the cancel fails,
wait_for_completion(&priv_rx->add_ctx) waiting on NAPI.

Is holding the socket lock across two RCU grace periods plus an unbounded
wait acceptable in the receive path? A peer only has to send a handshake
record whose first byte is TLS_HANDSHAKE_KEYUPDATE, and the cost applies per
offloaded connection while softirq receive can only append to the
size-limited sk_backlog.

Related: device_offload_lock is now taken for read from the RX data path both
here and in tls_device_deferred_dev_add_rx() (which calls ->tls_dev_add()),
while tls_device_down() holds the same rwsem for write across a per-socket
teardown loop that itself does synchronize_net() and tls_dev_del() per
socket. Was that contention considered?

[Severity: Low]
Documentation/networking/tls-offload.rst still states that tls_dev_del is
called "When the offloaded connection is destroyed" and that "The third TLS
device callback is tls_dev_resync".

After this patch tls_dev_del runs on a live connection (from
tls_check_pending_rekey() and from tls_set_device_offload_rx() before
re-add), tls_dev_add is called again for the same socket and direction, and
there is now a fourth callback. Should that document be updated in the same
series so driver authors don't free per-socket state on tls_dev_del?

> +
>  static void destroy_record(struct tls_record_info *record)
>  {
>  	int i;

[ ... ]

> @@ -1093,13 +1181,56 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
>  	return err;
>  }
>  
> +/*
> + * Temporarily swap in the old key, run
> + * tls_device_reencrypt(), then restore the current key.
> + */
> +static int tls_device_reencrypt_old_key(struct sock *sk,
> +					struct tls_offload_context_rx *ctx,
> +					struct tls_sw_context_rx *sw_ctx,
> +					struct tls_context *tls_ctx)
> +{
> +	struct crypto_aead *saved_aead = sw_ctx->aead_recv;
> +	char saved_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
> +	char saved_rec_seq[TLS_MAX_REC_SEQ_SIZE];
> +	int ret;
> +
> +	memcpy(saved_iv, tls_ctx->rx.iv, sizeof(saved_iv));
> +	memcpy(saved_rec_seq, tls_ctx->rx.rec_seq, sizeof(saved_rec_seq));

[Severity: Low]
saved_iv holds the salt plus implicit IV and saved_rec_seq the record
sequence, and both are left resident on the kernel stack when the function
returns through either exit.

The rest of net/tls scrubs equivalent material with memzero_explicit()
(tls_ctx_free(), tls_sw_ctx_finalize(), tls_device_free_ctx()). Should these
two buffers be zeroized before returning?

> +
> +	sw_ctx->aead_recv = ctx->rekey.old_aead_recv;
> +	memcpy(tls_ctx->rx.iv, ctx->rekey.old_iv, sizeof(ctx->rekey.old_iv));
> +	memcpy(tls_ctx->rx.rec_seq, ctx->rekey.old_rec_seq,
> +	       sizeof(ctx->rekey.old_rec_seq));
> +
> +	ret = tls_device_reencrypt(sk, tls_ctx);
> +
> +	memcpy(ctx->rekey.old_rec_seq, tls_ctx->rx.rec_seq,
> +	       sizeof(ctx->rekey.old_rec_seq));
> +
> +	sw_ctx->aead_recv = saved_aead;
> +	memcpy(tls_ctx->rx.iv, saved_iv, sizeof(saved_iv));
> +	memcpy(tls_ctx->rx.rec_seq, saved_rec_seq, sizeof(saved_rec_seq));
> +
> +	if (ret)
> +		return ret;
> +
> +	tls_bigint_increment(ctx->rekey.old_rec_seq,
> +			     tls_ctx->prot_info.rec_seq_size);
> +	ctx->resync_nh_reset = 1;
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -1109,10 +1240,50 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
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
>  
> +	if (unlikely(ctx->rekey.old_aead_recv)) {
> +		bool before_nic_boundary =
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
> +			/* rekey_fixup sets decrypted flags in case the NIC clears
> +			 * decrypted flags on auth failure
> +			 */
> +			if (!is_decrypted && ctx->rekey.rekey_fixup)
> +				ctx->rekey.rekey_fixup(skb);
> +
> +			return tls_device_reencrypt_old_key(sk, ctx,
> +							    sw_ctx, tls_ctx);
> +		}
> +
> +		crypto_free_aead(ctx->rekey.old_aead_recv);
> +		ctx->rekey.old_aead_recv = NULL;
> +
> +		if (ctx->dev_add_pending)
> +			tls_device_deferred_dev_add_rx(sk, tls_ctx, ctx);
> +	}
> +
>  	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags))) {
>  		if (likely(is_encrypted || is_decrypted))
>  			return is_decrypted;

[ ... ]

> @@ -1643,13 +1814,31 @@ int tls_set_device_offload(struct sock *sk,
>  	return rc;
>  }
>  
> -int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
> +int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
> +			      struct tls_crypto_info *new_crypto_info)
>  {
> -	struct tls12_crypto_info_aes_gcm_128 *info;
> +	struct tls_crypto_info *crypto_info, *src_crypto_info;
> +	const struct tls_cipher_desc *cipher_desc;
> +	u32 copied_seq = tcp_sk(sk)->copied_seq;
>  	struct tls_offload_context_rx *context;
>  	struct net_device *netdev;
> +	bool was_dev_add_pending;
> +	bool moved_aead_recv = false;
>  	int rc = 0;
>  
> +	/* Rekey is only supported for connections that are already
> +	 * using HW offload. For SW offload connections, the caller
> +	 * should fall back to tls_set_sw_offload() for rekey.
> +	 */
> +	if (new_crypto_info && ctx->rx_conf != TLS_HW)
> +		return -EINVAL;
> +
> +	crypto_info = &ctx->crypto_recv.info;
> +	src_crypto_info = new_crypto_info ?: crypto_info;
> +	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
> +	if (!cipher_desc || !cipher_desc->offloadable)
> +		return -EINVAL;
> +
>  	netdev = get_netdev_for_sock(sk);
>  	if (!netdev) {
>  		pr_err_ratelimited("%s: netdev not found\n", __func__);
> @@ -1675,29 +1864,88 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
>  		goto release_lock;
>  	}
>  
> -	context = kzalloc_obj(*context);
> -	if (!context) {
> -		rc = -ENOMEM;
> -		goto release_lock;
> +	if (!new_crypto_info) {
> +		context = kzalloc_obj(*context);
> +		if (!context) {
> +			rc = -ENOMEM;
> +			goto release_lock;
> +		}
> +		ctx->priv_ctx_rx = context;
> +	} else {
> +		context = tls_offload_ctx_rx(ctx);
>  	}
> +	was_dev_add_pending = context->dev_add_pending;
>  	context->resync_nh_reset = 1;
>  
> -	ctx->priv_ctx_rx = context;
> -	rc = tls_sw_ctx_init(sk, 0, NULL);
> +	if (new_crypto_info) {
> +		struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(ctx);
> +
> +		if (!test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
> +			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
> +			synchronize_net();
> +			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> +							TLS_OFFLOAD_CTX_DIR_RX);
> +		}

[Severity: Medium]
netdev here comes from get_netdev_for_sock(sk), which resolves
__sk_dst_get(sk) -> netdev_sk_get_lowest_dev(), not from
rcu_dereference_protected(ctx->netdev).

For an already-offloaded socket those can differ after a route change or a
bond/team failover, and tls_device_attach() is deliberately skipped on the
rekey path, so ctx->netdev is never updated and no reference is taken for the
device that ends up holding the HW context.

Can this call tls_dev_del() on a device that never held this socket's
context? mlx5e_ktls_del_rx() does priv = netdev_priv(netdev) and then
mlx5_ktls_destroy_key(priv->tls->dek_pool, priv_rx->dek) using the priv_rx
that a different device stored in ctx->driver_state.

And if the following tls_device_dev_add_rx() then succeeds on that other
device, is the context ever released? tls_device_offload_cleanup_rx() does
"if (!netdev) goto out;" on ctx->netdev and tls_device_down() matches
contexts by ctx->netdev.

Both tls_device_rx_del_key() and tls_device_deferred_dev_add_rx() use
rcu_dereference_protected(ctx->netdev) - should this path use the same
source?

> +
> +		if (context->rekey.old_aead_recv &&
> +		    before(copied_seq, context->rekey.old_nic_boundary)) {

[ ... ]

> +			context->dev_add_pending = 1;
> +		} else {
> +			u32 rcv_nxt;
> +
> +			if (context->rekey.old_aead_recv) {
> +				crypto_free_aead(context->rekey.old_aead_recv);
> +				context->rekey.old_aead_recv = NULL;
> +			}
> +
> +			/* flush the backlog so rcv_nxt is accurate */
> +			__sk_flush_backlog(sk);
> +			rcv_nxt = tcp_sk(sk)->rcv_nxt;
> +
> +			if (before(copied_seq, rcv_nxt)) {

[Severity: Medium]
This else branch frees rekey.old_aead_recv and sets it to NULL, and only sets
dev_add_pending inside "if (before(copied_seq, rcv_nxt))".

If a previous rekey already left dev_add_pending == 1 and there is no queued
data now, doesn't the function continue with dev_add_pending == 1 and
old_aead_recv == NULL? "if (!context->dev_add_pending)" below then skips
tls_device_dev_add_rx(), and the deferred completion is only reachable from
inside the old-key block of tls_device_decrypted():

	if (unlikely(ctx->rekey.old_aead_recv)) {
		...
		if (ctx->dev_add_pending)
			tls_device_deferred_dev_add_rx(sk, tls_ctx, ctx);
	}

Is the NIC RX key then never re-installed for the rest of the socket's
lifetime, with TLS_RX_DEV_CLOSED left set, TLSRXREKEYOK counted anyway and
TLSRXREKEYINPROGRESS elevated until close? Should this branch also clear
dev_add_pending?

The sequence looks reachable from peer timing alone: the first rekey with
queued data sets old_nic_boundary = rcv_nxt and dev_add_pending = 1, the
record straddling the boundary is classified by its start so it takes the
reencrypt path without running the deferred add, and if that record carries
the next KeyUpdate the second rekey lands in this else branch.

> +				context->rekey.old_aead_recv = sw_ctx->aead_recv;
> +				sw_ctx->aead_recv = NULL;
> +				moved_aead_recv = true;
> +				memcpy(context->rekey.old_iv, ctx->rx.iv,
> +				       sizeof(context->rekey.old_iv));
> +				memcpy(context->rekey.old_rec_seq, ctx->rx.rec_seq,
> +				       sizeof(context->rekey.old_rec_seq));
> +				context->rekey.old_nic_boundary = rcv_nxt;
> +				context->rekey.rekey_fixup =
> +					netdev->tlsdev_ops->tls_dev_rx_rekey_fixup;

[Severity: High]
This caches a driver function pointer, whose text lifetime is tied to the
driver module, into state that outlives the netdev reference.
tls_device_down() drops that reference without clearing it:

		rcu_assign_pointer(ctx->netdev, NULL);
		set_bit(TLS_RX_DEV_DEGRADED, &ctx->flags);
		synchronize_net();
		...
		dev_put(netdev);

rx_conf stays TLS_HW, so tls_device_decrypted() keeps running for records
already queued and calls ctx->rekey.rekey_fixup(skb) inside the
"if (unlikely(ctx->rekey.old_aead_recv))" block, which is before the
TLS_RX_DEV_DEGRADED bail-out.

If the driver module is unloaded while an RX rekey drain is still pending
(rmmod -> unregister_netdevice -> NETDEV_DOWN -> tls_device_down()), does
this indirect call land in freed module text? Should the pointer be cleared
when the netdev goes away, or fetched from ctx->netdev at call time instead?

> +				context->dev_add_pending = 1;
> +			}
> +		}
> +	}
> +
> +	rc = tls_sw_ctx_init(sk, 0, new_crypto_info);
>  	if (rc)
>  		goto release_ctx;

[Severity: Medium]
On the rekey path tls_dev_del(RX) has already run above, but this is the step
that can still fail: when the old AEAD was moved into rekey.old_aead_recv,
sw_ctx->aead_recv is NULL, so tls_sw_ctx_init() calls crypto_alloc_aead(),
which can fail with -ENOMEM (setauthsize/setkey can fail too).

The release_ctx path restores dev_add_pending and the old AEAD but performs
no hardware rollback, while mlx5e_ktls_del_rx() has already destroyed the
steering rule, the TIR and the DEK:

	if (priv_rx->rule.rule)
		mlx5e_accel_fs_del_sk(priv_rx->rule.rule);
	mlx5e_tir_destroy(&priv_rx->tir);
	mlx5_ktls_destroy_key(priv->tls->dek_pool, priv_rx->dek);

Does the socket then lose RX offload permanently while setsockopt returns an
error implying nothing changed? TLS_RX_DEV_CLOSED stays set, so later
tls_device_rx_del_key(), tls_device_offload_cleanup_rx() and
tls_device_down() all short-circuit and nothing calls tls_dev_add() again,
and no TLSRXREKEYFALLBACK is accounted. Would doing the teardown after the
last failable software step, or re-adding on this error path, work better?

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
>  
> -	tls_device_attach(ctx, sk, netdev);
> -	tls_sw_ctx_finalize(sk, 0, NULL);
>  	up_read(&device_offload_lock);
>  
>  	dev_put(netdev);
> @@ -1709,7 +1957,18 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
>  	tls_sw_free_resources_rx(sk);
>  	down_read(&device_offload_lock);
>  release_ctx:
> -	ctx->priv_ctx_rx = NULL;
> +	if (!new_crypto_info) {
> +		ctx->priv_ctx_rx = NULL;
> +	} else {
> +		context->dev_add_pending = was_dev_add_pending;
> +		if (moved_aead_recv) {
> +			struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(ctx);
> +
> +			crypto_free_aead(sw_ctx->aead_recv);
> +			sw_ctx->aead_recv = context->rekey.old_aead_recv;
> +			context->rekey.old_aead_recv = NULL;
> +		}
> +	}
>  release_lock:
>  	up_read(&device_offload_lock);
>  release_netdev:

[ ... ]

> diff --git a/net/tls/tls_proc.c b/net/tls/tls_proc.c
> index adca8561c7da..ae2322481c71 100644
> --- a/net/tls/tls_proc.c
> +++ b/net/tls/tls_proc.c
> @@ -28,8 +28,11 @@ static const struct snmp_mib tls_mib_list[] = {
>  	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
>  	SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED),
>  	SNMP_MIB_ITEM("TlsTxRekeyFallback", LINUX_MIB_TLSTXREKEYFALLBACK),
> +	SNMP_MIB_ITEM("TlsRxRekeyFallback", LINUX_MIB_TLSRXREKEYFALLBACK),
>  	SNMP_MIB_ITEM("TlsTxRekeyInProgress", LINUX_MIB_TLSTXREKEYINPROGRESS),
> +	SNMP_MIB_ITEM("TlsRxRekeyInProgress", LINUX_MIB_TLSRXREKEYINPROGRESS),
>  	SNMP_MIB_ITEM("TlsTxRekeyAborted", LINUX_MIB_TLSTXREKEYABORTED),
> +	SNMP_MIB_ITEM("TlsRxRekeyAborted", LINUX_MIB_TLSRXREKEYABORTED),
>  };

[Severity: Low]
These three names become visible in /proc/net/tls_stat, but the "Statistics"
section of Documentation/networking/tls.rst, which enumerates every field of
that file, still ends at TlsRxRekeyReceived. Could the new counters be
documented there, including when TlsRxRekeyAborted and TlsRxRekeyFallback
increment? The TX-side siblings added earlier in this series are missing from
that list as well.

>  
>  static int tls_statistics_seq_show(struct seq_file *seq, void *v)

[ ... ]

Cross-instance finding from sashiko-gemini (af143e51c70a6781742cb38aa44153feb2fdbfb052af92dccb83139af70282d4):
[Severity: High]
Single-packet records bypass XOR-undo logic during KeyUpdate.
