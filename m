Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080556;
	b=sxWid0KdtsAeccvK5TUcJwQfURapVfjDx53VTY0cckVscv5TtU9X85asOV40+UhTZh4k
	 2ZArvSKzSr7mSvSCQN9/XwslNRv3sMA+3J+GzKrXKcbe08oyP5oM4c/TfeDN0MWn2+o2p
	 oZ8Ahp3s21EPacvGwG0EpPZaK4NKSoOC4SQpV/EhxcGgus71SqTv3gTPgqaoIsiRbBkaa
	 ZIa33fAyZuxC4pU8UCnYn+wLY0ibG4wK2T3TlnM8yeVTvIOFzUyg9hFLvv0zMWCa5epNj
	 L4cf48vTCbZjkokedOn1pff/V4xFqW32iexIg580HKxZFSCSG1UxkHIwMcRZAVI7/Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080556;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BFmExUZNkeWrEtyH9eFzdslvWVHLBcuvWey6vYUf3mU=;
	b=kgrk5kBM+5do7BzxM9bXAvOsa+OB2h1bUAIyNiuCM5iamO397eWf/AcetfgKbUGvaeCq
	 eOYZJ6ZDVwjBdLevNmZeWJj7sYlTomKKzVIY+1lUxDJynhX7Par62/aHiJJxgCmmfJxbB
	 3WzLt4sfP0Lz3x8unG+VLXralFJW6fYlefmK3ilHtZY+n+EksHZRHUHpEwZzaPWOUiaS0
	 bRmqovaXk4WpyXWmexNjOCzWPGqZgrj//9q92dDo2qs3eIcLmiTqjyuQCIuw+emdH8+P2
	 oIxUNyjX8dz7vVhrBQEfANyDKrImnUiOkV4jmGfvlFnQEZ+NOw9aYaEeTgr9KyprqnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cI6JlBJb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C87606A326;
	Sat,  7 Nov 2026 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cI6JlBJb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E831F008A1;
	Sat,  7 Nov 2026 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080555;
	bh=BFmExUZNkeWrEtyH9eFzdslvWVHLBcuvWey6vYUf3mU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cI6JlBJboBmVnJ/BdTVHG8qMMG4HO4LW0O8t8Bn/cdTrdHoVMtz4z4dCGl/Ty+AmB
	 QRi6jnA5icDX0WHsYMwHw5fMNS0//w/7h4/9FZSpM9+L/viBz1pUdTQ79INR+P9V9S
	 UtWVz7Xty4UB8T2pBpi1UkR41/oAQW0s0TungqKwuQHSldGdmclC+ymQvuoVLq4R1b
	 HW+BFptOl0MboauE6eGzxZTwo9fwLBTZbmh47twElBMF8aPILY2lgNMjZPjvndTbc0
	 hdN1UMbvcdLDtr5zzawaowa0orSWbQ9GqKhgUt3yEreedOIIw5f6DR6UNoadN+JBQw
	 ai42ekxC1s3Ow==
Subject:
 Re: [PATCH net-next v2 2/2] tls: make the record number wrap abort final
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org,
 syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com, sd@queasysnail.net,
 john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, vakul.garg@nxp.com,
 linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 19:42:34 +0000
Message-ID: <179408055455.994134.12887172212869899418@kernel.org>
In-Reply-To: <20261106193210.1152577-2-rjethwani@purestorage.com>
References: <20261106193210.1152577-2-rjethwani@purestorage.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] With async encryption on the SW TX path, the record that uses
  the last record number is counted as sent and sendmsg() can return…
- [Medium] The new tls.rst text says, for an abort in either direction,
  that the error is not cleared when it is reported and that 'poll()…
- [Low] The handling of a KeyUpdate in the last record number differs
  between directions.
- [Low] The commit fixes behaviour reachable in the baseline: after a
  record number wraps, once sk_err has been consumed by SO_ERROR or…
- [Low] Documentation/networking/tls.rst limits the wrap exemption to 'A
  TLS 1.3 KeyUpdate ... receive ... continues once the new key is…
- [Low] The doc says that after the final abort 'every later send ...
  fails with EBADMSG'.
- [Low] On the sync SW TX path, whether the refused wrapped record is
  counted as sent still depends on a lockless read of `sk->sk_err ==…

--

tls: make the record number wrap abort final

The EBADMSG abort on a record number wrap now persists. It is recorded
in a new tls_context->final_err field that is never cleared. After a
wrap, RX delivers no more records unless the last one carried a
KeyUpdate, TX refuses to encrypt or push further records, poll()
reports EPOLLERR, and TLS 1.3 selftests are added.

> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index 60a37bdaaa250..517dcc452c67f 100644
> --- a/net/tls/tls.h
> +++ b/net/tls/tls.h

[ ... ]

> @@ -307,17 +308,30 @@ static inline void tls_bigint_subtract(unsigned char *seq, int  n)
>  	*p = cpu_to_be64(rcd_sn - n);
>  }
>  
> -static inline void
> -tls_advance_record_sn(struct sock *sk, struct tls_prot_info *prot,
> -		      struct cipher_context *ctx)
> +static inline bool
> +__tls_advance_record_sn(struct tls_prot_info *prot, struct cipher_context *ctx)
>  {
> -	if (tls_bigint_increment(ctx->rec_seq, prot->rec_seq_size))
> -		tls_err_abort(sk, -EBADMSG);

[Severity: Low]
The commit message describes behaviour that already exists in released
kernels. Once SO_ERROR or sock_error() has consumed sk_err after a wrap,
both RX and TX continue under the same key with record number 0.

Should this have a Fixes: tag for the commit that added the
tls_err_abort() wrap handling removed here? That would tell backporters
which trees are affected. If the patch is meant for net-next only, could
the commit message say so?

> +	bool wrapped = tls_bigint_increment(ctx->rec_seq, prot->rec_seq_size);

[ ... ]

> +static inline void
> +tls_advance_record_sn(struct sock *sk, struct tls_prot_info *prot,
> +		      struct cipher_context *ctx)
> +{
> +	if (__tls_advance_record_sn(prot, ctx))
> +		tls_err_abort_final(sk, -EBADMSG);
> +}

[Severity: Low]
On RX, tls_rx_one_record() exempts a KeyUpdate that uses the last record
number. There is no matching exemption on TX. Is that asymmetry
intended?

tls_advance_record_sn() runs after the record has been encrypted. That
is tls_do_encryption() on the SW path and tls_push_record() in
tls_device.c. It calls tls_err_abort_final() whatever the content type
is, and tls_push_sg() then refuses the record.

So a KeyUpdate that userspace sends via cmsg at rec_seq 2^64-1, which
RFC 8446 permits, is never sent. final_err is never cleared, so
installing the new key with setsockopt(TLS_TX) can't recover the
connection either.

The new KeyUpdate paragraph in tls.rst only covers the receive side.
Could it also describe the TX behaviour, or explain why kTLS refuses to
send what it accepts from the peer?

[ ... ]

> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index b8d5a843f7617..d5605df59334d 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c

[ ... ]

> @@ -414,8 +414,12 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
>  	tls_ctx = tls_get_ctx(sk);
>  	ctx = tls_sw_ctx_rx(tls_ctx);
>  
> +	/* the final abort outlives sk_err, only decrypted data is readable */
> +	if (unlikely(tls_final_err(tls_ctx)))
> +		mask |= EPOLLERR;

[Severity: Medium]
The new documentation says "poll() reports EPOLLERR" for an abort in
either direction, but this is the only place the persistent EPOLLERR is
set. Does that hold for TX-only kTLS sockets?

build_proto_ops() only installs tls_sk_poll for configurations with RX:

net/tls/tls_main.c:build_proto_ops() {
	ops[TLS_SW  ][TLS_BASE] = ops[TLS_BASE][TLS_BASE];
	ops[TLS_SW  ][TLS_BASE].splice_eof	= tls_sw_splice_eof;
    ...
	ops[TLS_BASE][TLS_SW  ].poll		= tls_sk_poll;
    ...
	ops[TLS_SW  ][TLS_SW  ].poll		= tls_sk_poll;
    ...
	ops[TLS_HW  ][TLS_BASE] = ops[TLS_BASE][TLS_BASE];
    ...
}

A socket with only TLS_TX configured, SW or HW, uses tcp_poll(). That
reports EPOLLERR only while sk_err is set, and a TX wrap is exactly the
case where these sockets matter.

Once SO_ERROR consumes sk_err, as the tx_wrap selftest does, poll() no
longer reports EPOLLERR, while send() still fails with EBADMSG.

Even when tls_sk_poll() is used, it can return before reaching the new
check:

	if (unlikely(state != TCP_ESTABLISHED || shutdown & RCV_SHUTDOWN))
		return mask;

Once sk_err is cleared, wouldn't the documented EPOLLERR also be missing
in those states?

[ ... ]

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index b4535139438ae..37ba09055220d 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -458,7 +470,9 @@ int tls_tx_records(struct sock *sk, int flags)
>  	}
>  
>  tx_err:
> -	if (rc < 0 && rc != -EAGAIN && rc != -EINTR && rc != -ERESTARTSYS)
> +	/* a final abort already reported its error */
> +	if (rc < 0 && rc != -EAGAIN && rc != -EINTR && rc != -ERESTARTSYS &&
> +	    !tls_final_err(tls_ctx))
>  		tls_err_abort(sk, rc);

[Severity: Low]
With this change, tls_tx_records() no longer sets sk_err again when
final_err is set. On the sync SW TX path, bpf_exec_tx_verdict() still
uses a lockless read of sk_err to decide whether to subtract the refused
wrapped record from copied:

net/tls/tls_sw.c:bpf_exec_tx_verdict() {
    ...
	err = tls_push_record(sk, flags, record_type);
	if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
		*copied -= sk_msg_free(sk, msg);
		tls_free_open_rec(sk);
		err = -sk->sk_err;
	}
    ...
}

Can a concurrent SO_ERROR reader defeat this check? For example:

CPU1 (sendmsg, holds lock_sock)
tls_do_encryption()
  tls_advance_record_sn()
    tls_err_abort_final()
      sk_err = EBADMSG; sk_error_report()

CPU2
getsockopt(SO_ERROR)
  sock_error()
    xchg(&sk->sk_err, 0)

CPU1
tls_tx_records()
  tls_push_sg() returns final_err (-EBADMSG)
  sk_err is not set again here
bpf_exec_tx_verdict()
  sk->sk_err == EBADMSG is false, copied is not reduced

sendmsg() would then return a copied count that includes the refused
record. If sk_err is cleared between the == EBADMSG test and the
err = -sk->sk_err assignment, err becomes 0 instead.

The device path uses tls_final_err() for the same decision. Would
checking tls_final_err(tls_ctx) here too, with a single snapshot of the
error, close the window?

[ ... ]

> @@ -628,6 +642,11 @@ static int tls_push_record(struct sock *sk, int flags,
>  	int rc;
>  	u32 i;
>  
> +	/* tls_push_sg() would refuse it, don't encrypt it */
> +	rc = tls_final_err(tls_ctx);
> +	if (unlikely(rc))
> +		return rc;
> +

[Severity: Medium]
With async encryption, is the refused record still counted as sent?

The commit message says "The device push doesn't count the refused
record as sent, like the SW path". tls.rst says "the send that completes
it doesn't count its data as sent".

tls_do_encryption() advances the record number, and so raises the final
abort, even when crypto_aead_encrypt() returns -EINPROGRESS:

net/tls/tls_sw.c:tls_do_encryption() {
    ...
	/* Unhook the record from context if encryption is not failure */
	ctx->open_rec = NULL;
	tls_advance_record_sn(sk, prot, &tls_ctx->tx);
	return rc;
}

tls_push_record() then returns -EINPROGRESS without reaching
tls_tx_records(). bpf_exec_tx_verdict() skips the un-count because of
its err != -EINPROGRESS condition. tls_sw_sendmsg_locked() increments
num_async and ends up at send_end:

send_end:
	...
		err = tls_encrypt_async_wait(ctx);
	...
	if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
		cancel_delayed_work(&ctx->tx_work.work);
		tls_tx_records(sk, msg->msg_flags);
	}

end:
	ret = sk_stream_error(sk, msg->msg_flags, ret);
	return copied > 0 ? copied : ret;

tls_encrypt_async_wait() returns 0 because the encryption succeeded.
The -EBADMSG that tls_tx_records() gets from tls_push_sg() is ignored.

So sendmsg() reports the record's bytes as sent. Later flushes from
tls_encrypt_done() and tx_work_handler() are refused, so the data is
never sent.

The same seems to happen when the wrapped record is encrypted
synchronously while an earlier record is still pending async.
tls_tx_records() stops at the first record that isn't tx_ready and
returns 0, so bpf_exec_tx_verdict() leaves the bytes in copied.

The selftests only use synchronous software GCM, so they don't cover
this.

> @@ -802,6 +821,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  	}
>  
>  	while (msg_data_left(msg)) {
> +		int err = tls_final_err(tls_ctx);
> +
> +		if (unlikely(err)) {
> +			ret = err;
> +			goto send_end;
> +		}

[Severity: Low]
final_err is only checked inside the while (msg_data_left(msg)) loop.
Does a zero-length send() still succeed after the abort?

With size 0 and no cmsg, the loop never runs and num_async is 0.
sk_stream_error(sk, flags, 0) returns 0, so send() returns 0.

tls_push_data() on the device path checks tls_final_err() on entry, so
the same call fails there with EBADMSG. tls.rst says "every later send
... fails with EBADMSG".

[ ... ]

> @@ -1582,9 +1613,14 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
>  	rxm = strp_msg(darg->skb);
>  	rxm->offset += prot->prepend_size;
>  	rxm->full_len -= prot->overhead_size;
> -	tls_advance_record_sn(sk, prot, &tls_ctx->rx);
>  
> -	return tls_check_pending_rekey(sk, tls_ctx, darg->skb);
> +	err = tls_check_pending_rekey(sk, tls_ctx, darg->skb);
> +	/* A KeyUpdate in the last record retires the key as usual */
> +	if (__tls_advance_record_sn(prot, &tls_ctx->rx) &&
> +	    !tls_sw_ctx_rx(tls_ctx)->key_update_pending)
> +		tls_err_abort_final(sk, -EBADMSG);

[Severity: Low]
tls.rst limits this exemption to "A TLS 1.3 KeyUpdate", but this check
only looks at key_update_pending. tls_check_pending_rekey() sets that
flag for any decrypted handshake record that starts with
TLS_HANDSHAKE_KEYUPDATE, whatever the version:

	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;

		WRITE_ONCE(rx_ctx->key_update_pending, true);

On TLS 1.2, a peer can put such a record at the last record number. Then
neither final_err nor sk_err is set. recv() returns EKEYEXPIRED forever,
SO_ERROR is 0, and poll() shows no EPOLLERR.

do_tls_setsockopt_conf() rejects a TLS 1.2 RX rekey with -EBUSY, so the
new key can never be installed.

Should the exemption also require prot->version == TLS_1_3_VERSION, so
TLS 1.2 gets the documented EBADMSG abort?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106193210.1152577-1-rjethwani%40purestorage.com
