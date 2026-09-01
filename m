Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF635E1BC;
	Tue,  1 Sep 2026 03:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232774; cv=none; b=YjlIlPVv1AsKo/2Q1Cna62fvYcK7CuNXgXLiZm00sN/9REYMIjRwH8C8r7N2zYu7ohkr2qxGBQ1ffsiBfGDjGy9oFWJL+h6kjTMSocVCcUixJitfE9pML2IJ+IZ36lHxZjhCEaodnzFAif8kdx32Vzqkri0DuIYgIPoiWcIBaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232774; c=relaxed/simple;
	bh=RhwQGauGUHP11xbppaMXraitbUJEn804pviFbnUcZKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frs+qrfGGkXZT+NXrTRzPrnEEE9yuqJADH7GHtx2zQlb089PRWaKYNU9vWHUxjxu5l3GJ7L77NjEKRWtlESs7Q0mcOcb1UnpJZB320BywiNOLEoTYRvg7t5DaUMcBcWDZjRGlnvBwH4W432pM5JVNg/V/J5ZN2FcMBiH+EwrvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9GA7KCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9GA7KCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ACF1F000E9;
	Tue,  1 Sep 2026 03:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232773;
	bh=WG3XF7Kw0LabU5DuitR2Zj4YR6z32AQ/YJ3tPqdXMWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I9GA7KCsXSam4+UW9drNTSEeYGvKiETi7QjZ68G+0x1DouxKYZMikQKpLpNQLpx1Z
	 wkivMwUOaYOrfWr1gdbYL6BUYfabc0pMq/u8H3nwyeB5PNrC5+goJ+nOwcDBGkLysS
	 eUFYO0zQTEB5GFm1JQ+2zLTGce6usU6tAQuqGOkEM6LWkXeGFXzfeGvozTmRkrU47k
	 prBt2llramvWx0/60qBOCzm676+mqwBBUo751TQ7dKwLe+kaqn8RDj/qUrKJanl+8t
	 VFC0OD59YZKcZEPJy245gH3q/PWv8wrY64u/zB/Voc8gtwJFHeXWwfMou4bcljv1wt
	 OOckOkyDufU+w==
From: Jakub Kicinski <kuba@kernel.org>
To: jiayuan.chen@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	wilfred.mallawa@wdc.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tls: fix TX context confusion in the max payload size setsockopt
Date: Mon, 31 Aug 2026 20:19:31 -0700
Message-ID: <20260901031931.1636980-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831025607.62927-1-jiayuan.chen@linux.dev>
References: <20260831025607.62927-1-jiayuan.chen@linux.dev>
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
    tls: fix TX context confusion in the max payload size setsockopt

The patch replaces the unchecked tls_sw_ctx_tx() dereference in
do_tls_setsockopt_tx_payload_len() with a new helper,
tls_tx_record_is_open(), that dispatches on ctx->tx_conf so the TLS_HW
path looks at tls_offload_ctx_tx(ctx)->open_record instead of a field of
the wrong structure.  The rest of the option handling is unchanged.

> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index fbb274287aa5..e4f288c1fa34 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -833,15 +833,29 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
>  	return rc;
>  }
>
> +/* priv_ctx_tx holds a different structure on each TX path, so tx_conf has to
> + * say which open record to look at.
> + */
> +static bool tls_tx_record_is_open(struct tls_context *ctx)
> +{
> +	switch (ctx->tx_conf) {
> +	case TLS_SW:
> +		return !!tls_sw_ctx_tx(ctx)->open_rec;
> +	case TLS_HW:
> +		return !!tls_offload_ctx_tx(ctx)->open_record;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
>  					    unsigned int optlen)
>  {
>  	struct tls_context *ctx = tls_get_ctx(sk);
> -	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
>  	u16 value;
>  	bool tls_13 = ctx->prot_info.version == TLS_1_3_VERSION;
>
> -	if (sw_ctx && sw_ctx->open_rec)
> +	if (tls_tx_record_is_open(ctx))
>  		return -EBUSY;

[Severity: High]
For the TLS_HW arm, is open_record enough to tell that no record is being
built?  do_tls_setsockopt() calls this helper with only the socket lock
held:

net/tls/tls_main.c:do_tls_setsockopt() {
	case TLS_TX_MAX_PAYLOAD_LEN:
		lock_sock(sk);
		rc = do_tls_setsockopt_tx_payload_len(sk, optval, optlen);
		release_sock(sk);
}

but the offload TX path is serialized by ctx->tx_lock, and it drops the
socket lock at a point where open_record is already NULL:

net/tls/tls_device.c:tls_push_record() {
	offload_ctx->open_record = NULL;
	...
	return tls_push_sg(sk, ctx, offload_ctx->sg_tx_data, 0, flags);
}

tls_push_sg() calls tcp_sendmsg_locked(), which for a blocking sendmsg()
with a full send buffer waits in sk_stream_wait_memory() and releases the
socket lock there.  tls_push_data() has a second such wait on the
tls_do_allocation() failure path.

So can a concurrent setsockopt() see open_record == NULL, take the "not
open" branch and publish a smaller ctx->tx_max_payload_len while a sender
is parked mid-sendmsg holding tx_lock?

If so, does the offload path then keep using the old limit for the rest of
that sendmsg?  tls_push_data() latches it once, before the loop, and never
refreshes it:

net/tls/tls_device.c:tls_push_data() {
	max_open_record_len = tls_ctx->tx_max_payload_len +
			      prot->prepend_size;
	do {
		...
		copy = min_t(size_t, size, max_open_record_len - record->len);
}

That would mean setsockopt returns 0 while records larger than the new
limit continue to go out, which does not match what
Documentation/networking/tls.rst says about TLS_TX_MAX_PAYLOAD_LEN ("the
kernel enforces the specified limit on all outgoing TLS records.  No
plaintext fragment will exceed this size").

There is a follow-on question about the next call.  If the sender leaves a
record open across the syscall (MSG_MORE with record->num_frags <
MAX_SKB_FRAGS - 1), the next tls_push_data() latches the new, smaller
max_open_record_len while record->len is still the old, larger value.
max_open_record_len is u32 and record->len is int, so does

	copy = min_t(size_t, size, max_open_record_len - record->len);

wrap around here and drop the record-size clamp entirely, letting
tls_append_frag() grow the record past the 2^14 plaintext maximum before
"record->len >= max_open_record_len" closes it?

Note that tls_sw_sendmsg_locked() re-reads the limit on every iteration:

net/tls/tls_sw.c:tls_sw_sendmsg_locked() {
		record_room = tls_ctx->tx_max_payload_len - msg_pl->sg.size;
}

so the latched offload value looks like the odd one out.

Would it be better to serialize the check and the store against the lock
that actually protects record building?  Since tls_device_sendmsg() takes
tx_lock before lock_sock:

net/tls/tls_device.c:tls_device_sendmsg() {
	mutex_lock(&tls_ctx->tx_lock);
	lock_sock(sk);
}

tx_lock is the outer lock, so taking it inside the already socket-locked
helper is not an option; the acquisition in do_tls_setsockopt() would have
to be reordered (or the helper made to wait for in-flight senders, as
tls_sk_proto_cleanup() does on sk_write_pending).

One smaller point: the plain read of tls_ctx->tx_max_payload_len in
tls_push_data() against the plain write in
do_tls_setsockopt_tx_payload_len() is an unannotated data race that KCSAN
would flag.
-- 
pw-bot: cr
