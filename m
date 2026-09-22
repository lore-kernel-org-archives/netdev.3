Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67038239A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042177; cv=none; b=VusG15MxKkDMgBw5UFHOgl/y7ZCIdgDniwwN9qlVvPQN1YRdDDigZiuW5d+mRKNL/1iBf4QOQqO1Y+cOortcIulD2m9js/+lCeUVXWMT84PyQf0tNj8kmNcws1ruuMK/vxJWVGu8kmSafAv65pVytUSnBJM/G7dGC1KjvwrRuKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042177; c=relaxed/simple;
	bh=wLnS/wAqz49lSmQRrANRfOcayB/1efKNEfd44XKaKnM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6fR5nOO3AaQo4xplUKxp4UIkmYFq0OiXvvNL0cngDrBeYjY7JjO1t+fpusu+hZFDN8oTLzqcKTo5t1shfn86RnTlb25ycRuJRaYppQFklTg9tffD6tA6H3S7J+XmO3Yu5n8ako/FU0aDYdZq6GJehKdeve8P2kauEYAlD7ntEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4txfyML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4txfyML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC28D1F000FF;
	Tue, 22 Sep 2026 01:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042175;
	bh=Z43hxQoafDhiTArwYE/PqpN/CocKW4/k+n5GmmgQtTk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T4txfyML6T2wt05sP05ARPuYeakoo61ye7Rns1PmWmJ3QTofxrwCDb3a0VGXOVw8g
	 aa+tFX6mArjamJXbUfdC8ypVRaiCa8sbo+WpjSK0J2zbPX41y25NV38+4rElOOgUmM
	 HqT0al6pEZSqcthHszO3AwZXCRL3A6rQonhbul4zs6esfD4+tWQ81M9Txnzt+P0/wg
	 It37TrFHP0CLtsY6onNF/bi2ucJGFel9MG2WZiPxrLZ1DuexE/MB6f+80hHp922/ip
	 HMhtNMBMiT5jli65VigMP1I+IrTmGlsXR8RkU4F3U6rTu/ByWfS3HyZvQKdc6pHA0g
	 YvxbKDz0YBC4g==
Subject: Re: [PATCH net-next v17 15/15] tls: document TLS 1.3 hardware offload
 rekey handling
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:56:14 +0000
Message-ID: <179004217436.2160803.11657719647528178553@kernel.org>
In-Reply-To: <20260917224355.2288021-16-rjethwani@purestorage.com>
References: <20260917224355.2288021-16-rjethwani@purestorage.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new decrypt_failed contract states, for a record none of
  whose segments carry `decrypted`, that "The stack passes such a record…
- [Medium] The newly documented decrypt_failed contract requires the
  driver to know whether the device transformed (XORed) the failed…
- [Medium] The new documentation permits coalescing of decrypt_failed
  segments with unmarked ones ("Coalescing (GRO, socket layer) and…
- [Low] The documented meanings of the rekey counters in
  Documentation/networking/tls.rst do not match their…
- [Low] The rewritten, exhaustively worded description of when
  tls_dev_del is called ("either when the offloaded connection is…
- [Low] In the "Error handling" section, the retained blanket statement
  "The Linux networking stack does not provide a way of reporting per-…
- [Low] tls-offload.rst states the TX switch "completes inline during
  setsockopt" if "no hardware-offloaded records remain unacknowledged".

--

tls: document TLS 1.3 hardware offload rekey handling

This replaces the stale "offload does not support TLS 1.3" note in
Documentation/networking/tls-offload.rst with a description of KeyUpdate
handling on TX and RX, including the skb->decrypt_failed driver contract,
and documents the new rekey counters in Documentation/networking/tls.rst.

No Link: tags are present in the commit header.

A few questions about the new text where it does not seem to line up with
net/tls/tls_device.c and the only in-tree producer of the new mark.

> diff --git a/Documentation/networking/tls-offload.rst b/Documentation/networking/tls-offload.rst
> index e5802bcd4d22..cdf84f4b817a 100644
> --- a/Documentation/networking/tls-offload.rst
> +++ b/Documentation/networking/tls-offload.rst

[ ... ]

> @@ -109,7 +108,14 @@ state:
>  			    struct tls_context *ctx,
>  			    enum tls_offload_ctx_dir direction);
>  
> -``tls_dev_del`` is mandatory whenever ``tls_dev_add`` is provided.
> +``tls_dev_del`` is called either when the offloaded connection is destroyed or,
> +for a TLS 1.3 connection, when the old key is retired during a rekey (see the
> +`Rekey`_ section). It operates on a single ``direction``, so the driver must

[Severity: Low]

This reads as an exhaustive "either ... or" list of the call sites. Is the
device teardown case missing? tls_device_down() calls the callback for each
live direction of every offloaded socket on the disappearing netdev:

	if (ctx->tx_conf == TLS_HW &&
	    !test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
						TLS_OFFLOAD_CTX_DIR_TX);
	...
	if (ctx->rx_conf == TLS_HW &&
	    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
						TLS_OFFLOAD_CTX_DIR_RX);

Those connections are neither being destroyed nor rekeying, so should the
NETDEV_DOWN path be mentioned alongside the other two?

> +release only the state for that direction and must not free state shared
> +between directions or the socket as a whole. After a rekey ``tls_dev_del``,
> +``tls_dev_add`` may be called again for the same socket and direction to
> +install the new key. ``tls_dev_del`` is mandatory whenever ``tls_dev_add`` is
> +provided.

[ ... ]

> @@ -404,8 +413,121 @@ records, then after 4 records, after 8, after 16... up until every
>  Rekey
>  =====
>  
> -Offload does not currently support TLS 1.3, therefore key rotation
> -is not a concern for offloaded connections at this point.
> +TLS 1.3 allows traffic keys to be updated mid-connection using the
> +KeyUpdate message. Offloaded TLS 1.3 connections must therefore switch
> +keys without tearing down the offload. The device cannot simply be given
> +the new key because records encrypted (TX) or transformed (RX) with the
> +old key may still be in flight. The stack retains the necessary old-key
> +state and bridges the transition in software.
> +
> +TX
> +--
> +
> +On TX, the new key is installed in a temporary software context, and
> +sendmsg is routed through the software path. If no hardware-offloaded
> +records remain unacknowledged, the switch completes inline during
> +setsockopt. Otherwise the rekey is left pending and is completed later,

[Severity: Low]

Is unacknowledged old-key data really the only reason for deferring?
tls_set_device_offload_rekey() starts from defer = true and only narrows it
in one case:

	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
	bool defer = true;
	...
	if (!rekey_pending && !rekey_failed)
		defer = tls_has_unacked_records(offload_ctx) ||
			tls_is_pending_open_record(ctx);

So a socket with a buffered open hardware record (MSG_MORE / cork) but
nothing unacknowledged also takes the deferred path, and a socket that is
already pending or has previously failed always does. Should those two
cases be listed here?

Relatedly, the new TlsCurrTxRekey text in tls.rst says such sessions are
"waiting for in-flight records to drain". In the re-armed case after a
hardware fallback, tls_device_start_rekey() does:

			WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->snd_una);
			set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);

which leaves nothing draining, yet the session is counted in the gauge.

[ ... ]

>  
>  Error handling
>  ==============
> @@ -442,8 +564,43 @@ to the host's stack as it was on the wire (recovering original packet in the
>  driver if device provides precise error is sufficient).
>  
>  The Linux networking stack does not provide a way of reporting per-packet
> -decryption and authentication errors, packets with errors must simply not
> -have the :c:member:`decrypted` mark set.
> +decryption and authentication errors. A packet with errors must not have
> +the :c:member:`decrypted` mark set. In addition, the driver may set the
> +:c:member:`decrypt_failed` mark on a segment the device matched to an
> +offloaded connection and processed but could not authenticate. The two
> +marks are mutually exclusive.

[Severity: Low]

These two sentences seem to contradict each other. The first says there is
no way to report per-packet decryption and authentication errors, and the
next one introduces decrypt_failed, which include/linux/skbuff.h describes
as "hardware could not authenticate this skb's TLS payload", i.e. exactly a
per-segment authentication failure indication.

Could the text spell out the distinction it intends, for instance that
decrypt_failed is an internal hint about what the device did to the payload
rather than an error reported to the application?

> +
> +The stack interprets :c:member:`decrypt_failed` per record, relative to the
> +:c:member:`decrypted` mark of the other segments making up the same record.
> +Coalescing (GRO, socket layer) and record classification are keyed on
> +:c:member:`decrypted` alone, so :c:member:`decrypt_failed` segments may be
> +merged with unmarked ones. A driver setting the mark must therefore honour
> +the following contract:

[Severity: Medium]

If a decrypt_failed segment can be merged with an unmarked one, how does the
per-segment contract survive the merge?

skb_cmp_decrypted() compares only the decrypted bit:

include/linux/skbuff.h:
	return skb2->decrypted - skb1->decrypted;

and both coalescing paths gate on it alone:

net/ipv4/tcp_offload.c:tcp_gro_receive()
	flush |= skb_cmp_decrypted(p, skb);

include/net/tcp.h:tcp_skb_can_collapse_rx()
	return likely(mptcp_skb_can_collapse(to, from) &&
		      !skb_cmp_decrypted(to, from));

used by tcp_try_coalesce() -> skb_try_coalesce(), which copies the payload
without carrying the source skb's decrypt_failed bit.

After such a merge one skb can hold both device-XORed bytes and untouched
wire ciphertext, while tls_device_reencrypt() decides per head skb and per
fraglist entry:

		if (skb->decrypted || skb->decrypt_failed) {
			err = skb_store_bits(skb, offset, buf, copy);
	...
		if (skb_iter->decrypted || skb_iter->decrypt_failed) {
			err = skb_store_bits(skb_iter, frag_pos, buf, copy);

Would the merged payload then be either entirely re-encrypted or entirely
skipped, so the record fails software authentication even though the driver
followed the documented contract?

> +
> + * In a record none of whose segments carry :c:member:`decrypted`, every
> +   segment, including one with :c:member:`decrypt_failed` set, must hold
> +   the payload exactly as it was on the wire. This is the general rule
> +   above: if the device did not successfully decrypt any part of a record
> +   it must hand the whole record over untouched. The stack passes such a
> +   record to software decryption directly and does not consult
> +   :c:member:`decrypt_failed`.

[Severity: Medium]

Is "does not consult :c:member:`decrypt_failed`" accurate for this case?
tls_device_decrypted() reads the mark whenever the old RX AEAD is still
held, including when the record is fully encrypted:

net/tls/tls_device.c:tls_device_decrypted()
	if (unlikely(ctx->rekey.old_aead_recv)) {
		bool nic_touched = !is_encrypted || skb->decrypt_failed;
	...
		if (nic_touched &&
		    !before(rec_start_seq, ctx->rekey.old_nic_boundary))
			ctx->rekey.old_nic_boundary = rec_start_seq + rxm->full_len;

Each such record slides old_nic_boundary past itself, so the
crypto_free_aead(ctx->rekey.old_aead_recv) arm and the deferred
tls_dev_add() of the new RX key are not reached while records with the mark
keep arriving.

Does that mean a driver which follows this bullet and sets the mark on
untransformed records can keep an RX socket in software decryption
indefinitely? The record itself still decrypts, but offload is never
reinstalled.

> +
> + * In a record where some segments carry :c:member:`decrypted` (a mixed
> +   record), a segment with :c:member:`decrypt_failed` set must hold payload
> +   the device has already transformed (XORed with the cipher keystream) but
> +   failed to authenticate, and a segment with neither mark must hold the
> +   payload as it was on the wire. The stack re-encrypts the
> +   :c:member:`decrypted` and :c:member:`decrypt_failed` segments to restore
> +   the ciphertext, leaves the unmarked segments intact, and authenticates
> +   the whole record in software.
> +
> +A transformed segment delivered without :c:member:`decrypt_failed`, or an
> +untransformed segment of a mixed record delivered with it, is restored
> +incorrectly and the record fails software authentication. A device which
> +cannot tell the driver whether a failed segment was transformed must
> +recover the original packet before handing it to the stack, as described
> +above, and leave both marks clear. During a TLS 1.3 rekey the mark also
> +tells the stack which key the device applied; see the `Rekey`_ section.

[Severity: Medium]

Can the only in-tree producer of the mark satisfy this contract? mlx5 sets
it for every TLS offload error CQE, and its own comment says the
transformation state is not known:

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c:
	case CQE_TLS_OFFLOAD_ERROR:
		/* The device could not authenticate the payload. Depending on
		 * where the failure occurred the bytes may have been transformed
		 * (XORed) or left as wire ciphertext. ...
		 */
		skb->decrypt_failed = 1;

That looks like the case this paragraph says must leave both marks clear.
For a non-mixed record the stack then treats the payload as untouched wire
ciphertext:

net/tls/tls_device.c:tls_device_decrypted()
			if (is_encrypted) {
				tls_bigint_increment(ctx->rekey.old_rec_seq,
						     tls_ctx->prot_info.rec_seq_size);
				return 0;
			}

and for a mixed record tls_device_reencrypt() rewrites the marked fragment.
Either way one of the two possibilities the mlx5 comment admits is restored
incorrectly.

Should the documented contract be relaxed to match what ConnectX error CQEs
actually express, or should the driver stop setting the mark?

>  
>  A packet should also not be handled by the TLS offload if it contains
>  incorrect checksums.
> diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
> index 980c442d7161..cf05543260d8 100644
> --- a/Documentation/networking/tls.rst
> +++ b/Documentation/networking/tls.rst
> @@ -314,6 +314,11 @@ TLS implementation exposes the following per-namespace statistics
>    number of TX and RX sessions currently installed where NIC handles
>    cryptography
>  
> +- ``TlsCurrTxRekey``, ``TlsCurrRxRekey`` -
> +  number of TX and RX sessions currently undergoing a deferred rekey,
> +  i.e. a rekey which could not be applied immediately and is waiting for
> +  in-flight records to drain before the new key is installed in hardware

[Severity: Low]

Two questions about how these descriptions match the increment and
decrement sites.

Does the TX gauge really only cover sessions waiting for in-flight records
to drain? When the boundary is acknowledged, tls_tcp_clean_acked() only
arms completion:

		if (!before(acked_seq, boundary_seq))
			set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);

TLS_TX_REKEY_PENDING and the gauge stay set until a later sendmsg() runs
tls_device_complete_rekey(), which is where the decrement lives:

	if (deferred)
		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXREKEY);
	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);

The re-armed-after-fallback case has nothing draining either, as noted
above. The tls-offload.rst text added by this patch says as much ("A
connection that stops sending after a KeyUpdate stays in the deferred state
until it is closed ... it is counted in ``TlsCurrTxRekey``"), which reads
differently from the wording here.

Second, should the unchanged TlsTxRekeyOk entry ("number of successful
rekeys on existing sessions for TX and RX") be updated as well?
tls_set_device_offload_rekey() bumps it when a new KeyUpdate supersedes a
still-pending deferred rekey:

	if (defer) {
		if (!rekey_pending)
			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXREKEY);
		else
			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
		return 0;
	}

In that branch no tls_dev_del()/tls_dev_add() ran for the superseded key.

> +
>  - ``TlsTxSw``, ``TlsRxSw`` -
>    number of TX and RX sessions opened with host cryptography
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
