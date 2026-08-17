Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EEE3DDB02
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004704; cv=none; b=lpQyUDjHnvE7OSys9NmQmJR9Qy2pg4bLonQr9GuBL0pAQftzEGWpwpvVIjhSYiHEC4XZ58k+Xxldpp+JbswxMEBN7HK6asYHAF/EN4Kju5fLtSg4YQdnQb8UgCfbzsRJ/NLmo6gFZSboUpMpMWBXDlbLKpBTOuf81KFzyvbrIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004704; c=relaxed/simple;
	bh=LfcD1xOdWoArDfJRQvC3qiiPgP+vpshA05IVE1/JM5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOHzZzxCz93ieT4qLeub/92kiCYMvnPfUFVSp4d0Bed+ESPfsNKnimmWYYiQZ7d8AEq864CMX55lklxt/mLcOFg3aEE6/dZpzgaG4vBVSzkmanEAIg2ZpeTIQfM4NioviH3hX/aIUGk7BXtB18f+Z6wm8L8l0iEk9k1eSlfia0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiWgG2wr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiWgG2wr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ECA1F00A3A;
	Mon, 17 Aug 2026 22:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787004702;
	bh=yheXWrloqJDBR2AhKcV0a6/uPpwkjuRNWry7jPNoMqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YiWgG2wrwoe7Xi4rGeSobwOi5cRx7MNpCq1b/FjEq65VcvmQpX+1wkxCgHYBYMXsY
	 kpK86NGKPJEK+xAISUOcJnVps2BoRMT67cKqf177/gomA+yrbipaIraq6d3+V+4sNF
	 44HSFvlXBV4JE3ozo06hiv9F2nBq0RxHgfskuz/KI27jgdK/D42GSJLxp/E65C4gaO
	 iIvXhdnQHRM7vXE1gLU71CQCM9ZtnIkxqDPap6XVVxfoAjklia6dvD0eGH+cKo9VmN
	 9y5bwt9CoZju2XWHNUI7avzAIdvgriyabz5AG9JxaIP8V1T0DrMb2YNkLvLdBEUiig
	 cC8cTiPRvwntQ==
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
Subject: Re: [PATCH v16 05/10] tls: split tls_set_sw_offload into init and finalize stages
Date: Mon, 17 Aug 2026 15:11:41 -0700
Message-ID: <20260817221141.3666393-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807183853.2288959-6-rjethwani@purestorage.com>
References: <20260807183853.2288959-6-rjethwani@purestorage.com>
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
tls: split tls_set_sw_offload into init and finalize stages

This splits tls_set_sw_offload() into tls_sw_ctx_init(), which allocates
the SW contexts and sets up the AEAD transform, and tls_sw_ctx_finalize(),
which copies the salt/IV/record sequence into the live cipher context.
tls_set_device_offload_rx() is converted to call the two halves separately.

A couple of questions below.

> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index 60a37bdaaa25..5a6ee1ea00f8 100644
> --- a/net/tls/tls.h
> +++ b/net/tls/tls.h
> @@ -147,6 +147,10 @@ void tls_strp_abort_strp(struct tls_strparser *strp, int err);
>  int init_prot_info(struct tls_prot_info *prot,
>  		   const struct tls_crypto_info *crypto_info,
>  		   const struct tls_cipher_desc *cipher_desc);
> +int tls_sw_ctx_init(struct sock *sk, int tx,
> +		    struct tls_crypto_info *new_crypto_info);
> +void tls_sw_ctx_finalize(struct sock *sk, int tx,
> +			 struct tls_crypto_info *new_crypto_info);

[Severity: Low]
Would it be worth documenting the pairing contract of these two helpers
here?  As written, tls_sw_ctx_finalize() may only be called after a
tls_sw_ctx_init() that returned 0, with the same tx value, the same
new_crypto_info pointer, and an unchanged crypto_info->cipher_type.  Since
finalize() returns void it cannot report a violation, and the tx /
new_crypto_info selection logic is now duplicated in both halves.

>  int tls_set_sw_offload(struct sock *sk, int tx,
>  		       struct tls_crypto_info *new_crypto_info);
>  void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index bbb1aa733500..cf67e1f6c5f4 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -1235,7 +1235,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
>  	context->resync_nh_reset = 1;
>  
>  	ctx->priv_ctx_rx = context;
> -	rc = tls_set_sw_offload(sk, 0, NULL);
> +	rc = tls_sw_ctx_init(sk, 0, NULL);
>  	if (rc)
>  		goto release_ctx;
>  
> @@ -1249,6 +1249,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
>  		goto free_sw_resources;
>  
>  	tls_device_attach(ctx, sk, netdev);
> +	tls_sw_ctx_finalize(sk, 0, NULL);

[Severity: Low]
The commit message describes this as separating "cipher context
initialization from key material finalization", but this hunk also changes
the order of operations in tls_set_device_offload_rx().

Before the patch, tls_set_sw_offload(sk, 0, NULL) filled in ctx->rx.iv and
ctx->rx.rec_seq before netdev->tlsdev_ops->tls_dev_add() programmed the NIC
and before tls_device_attach() published the context on tls_device_list and
swapped sk->sk_destruct.  Now ctx->rx stays zeroed across both of those
calls and is only committed afterwards.

The split by itself could have been done with tls_sw_ctx_finalize() invoked
at exactly the point where the old copy happened, so the new ordering looks
like a deliberate choice.  Could the commit message say why finalize() has
to run after tls_dev_add() and tls_device_attach()?

For what it is worth, the window looks harmless at this commit: the whole
function runs under lock_sock() and down_read(&device_offload_lock), the RX
data path is only armed later by tls_sw_strparser_arm(), the RX tls_dev_add()
call is passed &ctx->crypto_recv.info rather than ctx->rx, and no in-tree
tls_dev_add() implementation reads the SW cipher_context.  A note in the
changelog would still help reviewers and anyone backporting this.

>  	up_read(&device_offload_lock);
>  
>  	dev_put(netdev);
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 62d46736e24b..63c83247f9a3 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -2650,3 +2631,55 @@ int tls_set_sw_offload(struct sock *sk, int tx,
>  out:
>  	return rc;
>  }
> +
> +void tls_sw_ctx_finalize(struct sock *sk, int tx,
> +			 struct tls_crypto_info *new_crypto_info)
> +{
> +	struct tls_crypto_info *crypto_info, *src_crypto_info;
> +	const struct tls_cipher_desc *cipher_desc;
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	struct cipher_context *cctx;
> +	char *iv, *salt, *rec_seq;
> +
> +	if (tx) {
> +		crypto_info = &ctx->crypto_send.info;
> +		cctx = &ctx->tx;
> +	} else {
> +		crypto_info = &ctx->crypto_recv.info;
> +		cctx = &ctx->rx;
> +	}
> +
> +	src_crypto_info = new_crypto_info ?: crypto_info;
> +	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
> +
> +	iv = crypto_info_iv(src_crypto_info, cipher_desc);
> +	salt = crypto_info_salt(src_crypto_info, cipher_desc);
> +	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
> +
> +	memcpy(cctx->iv, salt, cipher_desc->salt);
> +	memcpy(cctx->iv + cipher_desc->salt, iv, cipher_desc->iv);
> +	memcpy(cctx->rec_seq, rec_seq, cipher_desc->rec_seq);

[Severity: Low]
Should this repeated get_cipher_desc() lookup be NULL checked?

get_cipher_desc() returns NULL for a cipher_type outside
[TLS_CIPHER_MIN, TLS_CIPHER_MAX], and here the result is dereferenced
straight away by crypto_info_iv() / crypto_info_salt() /
crypto_info_rec_seq() (which read cipher_desc->*_offset) and by
cipher_desc->salt / ->iv / ->rec_seq in the memcpy() calls.

The sibling stage still guards the identical lookup:

net/tls/tls_sw.c:tls_sw_ctx_init() {
	...
	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
	if (!cipher_desc) {
		rc = -EINVAL;
		goto free_priv;
	}
	...
}

Today both callers reach finalize() only after an init() that validated the
same cipher_type (tls_set_sw_offload() returns early on error, and
tls_set_device_offload_rx() checks rc from tls_sw_ctx_init()), and
do_tls_setsockopt_conf() rejects unknown cipher_type before that, so this
does not look reachable.  Since the helper is now exported module-wide as
void, though, would re-checking cipher_desc (or at least a comment stating
the assumption) be preferable?

> +
> +	if (new_crypto_info) {
> +		unsafe_memcpy(crypto_info, new_crypto_info,
> +			      cipher_desc->crypto_info,
> +			      /* size was checked in do_tls_setsockopt_conf */);

[Severity: Low]
The retained justification comment names only do_tls_setsockopt_conf(), but
tls_set_device_offload_rx() is now also a caller of this code.  Should the
comment be extended to cover the device path as well?

Separately, finalize() commits crypto_info, the IV and the record sequence
into the live socket context, and calls tls_finish_key_update() for RX,
without any indication that the crypto_aead_setkey() in the init stage
succeeded.  Is the caller expected to guarantee that ordering?

> +		memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
> +
> +		if (!tx)
> +			tls_finish_key_update(sk, ctx);
> +	}
> +}
