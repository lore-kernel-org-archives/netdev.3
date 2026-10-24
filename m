Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879339;
	b=NEdo0ccrUEHPB3Zxqov3TIoxlOMEobUOKanfY+vkGPvyoCx+izbWSinkztpHH0mu+jNj
	 +mNSn5NN7cI2kR+j6v18sB44DCURwaXapew4J95ppgKp2+Edjg9ZAzikwbvzZOYUxEU/y
	 /H1uXbRHH9qzxWzBHvqbG72OWKB6//rHcKrJhA8P8dvaINIlkjANwJa4WscytQQ96nYnk
	 HB17yTznfdnxxakNSocMkVS7ZQL7v8eknndLnnLHfOpuUXWf8QTJZCun8ISOWygblWFK4
	 iBqm7XttMsOpZs5jBHirFjY9s+6FYtUmAYSWOIduci/QlZwGMArUr/HQDLadz2d64fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879339;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sia3q9+4NG/D0pyHeAoqQkOv62xgWS+3D097ZDTA1Nw=;
	b=oC4x9I0TMPaR19EjT5eJiCX/8PfbnX1d+X4DgFyqOCCys1143T4M95g36RS/ij7qlGc/
	 JhIu0MTDtjYa2p4enFMywOBlllLre0aeULuK0d2On38M0o05wJcHmZqTWrbuNFo3MOcRD
	 KaqZwVive5Lq7bwC/htxm+ziVfUppiMRgTVcPLPmc8UqUOjBgCf/2Tlu01Quobqt8u4XH
	 WuMbSOZW5uCdJzb3pbYzNZP2sWW6v84FwoxhC/Uvxn3EKabRJhZikuaqzObr953oYlHcM
	 JkVH8nzE8epVe+5jgqvEUdPr6u+r6sm80RHNBOusBAeF2/OCnk2pYOKGk03UHIs//UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiZrToBU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FFB606A31A;
	Sat, 24 Oct 2026 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiZrToBU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE1F1F01825;
	Sat, 24 Oct 2026 22:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792879338;
	bh=sia3q9+4NG/D0pyHeAoqQkOv62xgWS+3D097ZDTA1Nw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JiZrToBUh3fiC7FHds/yQFmv7oc93QouaS0PSPV3QCZscBgmOdGzTVv7Qc0Qw3mpL
	 dPiBcKOlW5hu6jWpuGiopXnmwmytjiPXkxc5Jpwrq7Fjd+PLsx9rMcQ3WE1jzz0OIm
	 9cLusgU8aP0tOeCTM+Q5VEIJsuclVJLmqvqlb+UDGTnMpfmJNQj6KC9QSYiudqaLj1
	 eir5uOugtanszTwYQ6lJY4hmpGer6cbsuzgvvHn9Fw66mXufFFEVVRSm78Ss8yjFwE
	 WTQYpnoJjGYYWwujGXrCQ8MmIy1unXlvsMQdrG3sI4u2sOldhOuq7imF/o2LqxtkfC
	 KfyGGAP5GC0JQ==
Subject:
 Re: [PATCH net v2] tls: keep TX and RX hardware offload on the same device
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, borisp@mellanox.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 24 Oct 2026 22:02:17 +0000
Message-ID: <179287933702.3134.9880453017789029456@kernel.org>
In-Reply-To: <20261020214500.972308-1-rjethwani@purestorage.com>
References: <20261020214500.972308-1-rjethwani@purestorage.com>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 1 · High: 0 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] tls: type confusion and UAF in tls_device_down() when TX is
  not TLS_HW

Pre-existing issues:
- [High] tls_set_sw_offload() (net/tls/tls_sw.c:2594) sets the shared
  ctx->push_pending_record = tls_sw_push_pending_record unconditionally,…

--

tls: keep TX and RX hardware offload on the same device

This patch adds tls_device_can_attach(), which is checked under
device_offload_lock before each tls_dev_add() in tls_set_device_offload()
and tls_set_device_offload_rx(). A second direction is only offloaded if
it resolves to the netdev already bound to the context; otherwise setup
falls back to software for that direction.

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index f11d0528fc431..9df183d0dd972 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c

[ ... ]

> @@ -1227,6 +1246,11 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
>  		goto release_lock;
>  	}
>  
> +	if (!tls_device_can_attach(ctx, sk, netdev)) {
> +		rc = -EOPNOTSUPP;
> +		goto release_lock;
> +	}
> +

[Severity: Critical]
This isn't introduced by this patch, but the patch now deliberately
steers sockets into the state that hits it, so it seems worth raising
here.

When RX is on hardware and TX is declined by tls_device_can_attach(),
do_tls_setsockopt_conf() falls back to TLS_SW for TX (or TX is simply
never configured and stays TLS_BASE), while ctx stays on
tls_device_list bound to the RX device. If that device later goes down,
tls_device_down() does this for every matching ctx:

	WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
		   tls_validate_xmit_skb_sw);

without looking at ctx->tx_conf. The tls_dev_del() calls further down
are guarded by tx_conf == TLS_HW and rx_conf == TLS_HW, but this store
is not.

>From then on every skb with TCP payload on the socket goes through
validate_xmit_skb() -> tls_validate_xmit_skb_sw() -> tls_sw_fallback(),
which casts tls_ctx->priv_ctx_tx with tls_offload_ctx_tx() and passes
the result to fill_sg_in(), which takes ctx->lock and walks
ctx->records_list through tls_get_record().

With tx_conf == TLS_BASE, priv_ctx_tx is NULL. Isn't this a NULL
pointer dereference on the first data segment sent after the device
goes down? With tx_conf == TLS_SW, priv_ctx_tx is the struct
tls_sw_context_tx from init_ctx_tx(), so fill_sg_in() would take a
spinlock and walk a list that are really unrelated fields of that
structure.

Close looks worse still. tls_sk_proto_close() frees priv_ctx_tx via
tls_sw_free_ctx_tx() before calling ctx->sk_proto->close(), but with
rx_conf == TLS_HW the tls_context and the sk_validate_xmit_skb hook stay
around until tls_device_sk_destruct(). Data pushed out by tcp_close()
or retransmitted afterwards would run tls_sw_fallback() on freed
memory.

The updated tls-offload.rst says a declined direction "uses software
instead", and NETDEV_DOWN clearing the binding is now an explicit
reason to decline TX, so the patch relies on this combination working.

Should tls_device_down() only switch sk_validate_xmit_skb when TX is
really device offloaded? ctx->tx_conf is only set by
do_tls_setsockopt_conf() after tls_set_device_offload() has dropped
device_offload_lock, so I'm not sure tx_conf alone is a reliable test
there. Would comparing against tls_validate_xmit_skb, or having
tls_validate_xmit_skb_sw() bail out when TX is not TLS_HW, work better?

[Severity: High]
This isn't a bug introduced by this patch, but it is related to the new
tls-offload.rst wording that a declined direction "is handled in software
as if offload had never been tried".

Suppose TX is already on hardware and RX is rejected here. Then
do_tls_setsockopt_conf() falls back to tls_set_sw_offload(sk, 0, ...),
and that function sets the shared TX callback whatever the direction:

net/tls/tls_sw.c:tls_set_sw_offload() {
    ...
	ctx->push_pending_record = tls_sw_push_pending_record;
    ...
}

This replaces the callback that tls_set_device_offload() installed:

	ctx->push_pending_record = tls_device_push_pending_record;

The hardware RX success path also calls tls_set_sw_offload(sk, 0, NULL),
so this could already happen before this patch.

Now suppose device TX leaves an open record, for example because
sendmsg() with MSG_MORE set pending_open_record_frags. A later sendmsg()
with a TLS_SET_RECORD_TYPE cmsg then takes this path:

tls_device_sendmsg()
  tls_process_cmsg()
    tls_handle_open_record()
      ctx->push_pending_record() -> tls_sw_push_pending_record()

tls_sk_proto_cleanup() reaches the same callback on close when
sk_write_pending is set. tls_sw_push_pending_record() does:

	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
	struct tls_rec *rec = ctx->open_rec;

but priv_ctx_tx is really a struct tls_offload_context_tx here.

Doesn't this read an unrelated field of tls_offload_context_tx as a
struct tls_rec pointer?

If that field is NULL, the open device record is not flushed before the
record type changes. Data that is already buffered then goes out under
the new record type. If the field is non-NULL, rec->msg_plaintext is
read through a garbage pointer.

This seems to go back to 3c4d7559159b (2017). Could tls_set_sw_offload()
set push_pending_record only when tx is set? Then RX setup, hardware or
software fallback, would leave the device TX callback in place.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020214500.972308-1-rjethwani%40purestorage.com
