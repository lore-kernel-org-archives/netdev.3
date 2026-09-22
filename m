Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7855637F8DD
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042170; cv=none; b=WD347WwA42SX4+ul7W0vBnoa5Giba0OLnjq6VClO7rGBbj+vQQHT5+v2inMYATRkdO9Zf9UDWNE3aI4w940Venzqf01u1/h1lId2IVeY0OpC8Kv9YY8Rnuao63a8lFptw9vhYAob7KgUfaB0oMnEd7vzohKVsFpoMFt74DwnSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042170; c=relaxed/simple;
	bh=pKtYkTu02QSj0E4JpnAVh0WgCP6Z9p0Mgig4yTlUaqU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sOsnAXzYHiDm8GkmxfF4cWYeGjlqY+SSFTapeMm0vPu9oc61lc55a8ZSMdwz6IGyqSPE2ZitKeuqqIebvbXQotdjjcQ+rXtoj4WhHQSY98a02gKPnE4x+BNQgABzqgNiPshsCwDpt5TNTzIlHo2P1NRCJ/vtFWrykwCj6jcGtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgWQPQIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgWQPQIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9591F000FF;
	Tue, 22 Sep 2026 01:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042168;
	bh=zx6/lXFlMcNAYX7/QGACa6GCCphkqimIkzwLnyBSKHI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lgWQPQICWtH1zTWp5CDumccVAvUD9dvR/0lavbGa+Fkxhbfnz2BDQffptYG5nfbD+
	 iOgIfOTDRPKCOxiu5rKC+nWqZrSrJPOqqKOVSwqc6yryV+pwTHbQ2dibM89dGoew0L
	 fA4zQC/9UlUEGzYIUI0FydfartR8BZwTGGmfkH/5wxqFoOTfOVZ8LbzdOYoqwmkm5+
	 Bu7PREI2fORchuxFltqXf/Q5tP4h0hQatIqIXCLjn/ucDq/1cLGUmk6BDIrVAq2SLA
	 RiK8d2XkspqtyiaHIU+cFY+BeSpwqao6kEqJFkdjYLxmhXL59tkAsv6nn6obJ6MQUu
	 lCoSyfUiXKQwQ==
Subject: Re: [PATCH net-next v17 10/15] net/mlx5e: flag TLS RX records that
 failed device decryption
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:56:07 +0000
Message-ID: <179004216751.2160803.17789350098621375031@kernel.org>
In-Reply-To: <20260917224355.2288021-11-rjethwani@purestorage.com>
References: <20260917224355.2288021-11-rjethwani@purestorage.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mlx5e_ktls_handle_rx_skb()
  (drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c:614) sets…

--

net/mlx5e: flag TLS RX records that failed device decryption

The patch splits CQE_TLS_OFFLOAD_ERROR out of the default case in
mlx5e_ktls_handle_rx_skb() and sets the new skb->decrypt_failed bit while
leaving skb->decrypted clear, then falls through to the existing tls_err
accounting. The bit is intended to be consumed by the TLS 1.3 device-offload
RX KeyUpdate support added later in the series.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> index bca45679e201..8ec40f5fd5b5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> @@ -602,7 +602,18 @@ void mlx5e_ktls_handle_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
>  		stats->tls_resync_req_pkt++;
>  		resync_update_sn(rq, skb);
>  		break;
> -	default: /* CQE_TLS_OFFLOAD_ERROR: */
> +	case CQE_TLS_OFFLOAD_ERROR:
> +		/* The device could not authenticate the payload. Depending on
> +		 * where the failure occurred the bytes may have been transformed
> +		 * (XORed) or left as wire ciphertext. Flag it so that, during a
> +		 * TLS 1.3 rekey transition, the re-encrypt path undoes the
> +		 * transform on any XORed frag of a mixed record while software
> +		 * re-authenticates; a non-mixed record stays wire ciphertext and
> +		 * is decrypted directly.
> +		 */
> +		skb->decrypt_failed = 1;

[Severity: High]

Can this per-skb distinction survive coalescing?  The bit is set here with
skb->decrypted left at 0, but the only comparator the stack uses to decide
whether two skbs may be merged still looks at decrypted alone:

include/linux/skbuff.h:skb_cmp_decrypted() {
	...
	return skb2->decrypted - skb1->decrypted;
	...
}

So a segment flagged here and a segment the device never touched compare
equal.  That comparator gates the merge in tcp_gro_receive():

	flush |= skb_cmp_decrypted(p, skb);

and in tcp_skb_can_collapse_rx(), used by tcp_try_coalesce(),
tcp_collapse() and tcp_add_backlog():

	return likely(mptcp_skb_can_collapse(to, from) &&
		      !skb_cmp_decrypted(to, from));

After such a merge only one flag value survives for bytes contributed by
several skbs, since tcp_collapse() copies it from the first skb only:

		skb_copy_decrypted(nskb, skb);

Note that the prerequisite patch extended skb_copy_decrypted() to propagate
decrypt_failed but left skb_cmp_decrypted() unchanged.  Is that asymmetry
intentional?

The same comparator feeds the mixed-record notion this commit message relies
on:

net/tls/tls_strp.c:tls_strp_copyin() {
	...
	strp->mixed_decrypted |= !!skb_cmp_decrypted(skb, in_skb);
	...
}

If two segments of one record differ only in decrypt_failed, the record is
never classified as mixed.  Does the consumer added later in the series then
act on the wrong value?  It restores a whole frag based on the single bit:

net/tls/tls_device.c:tls_device_reencrypt() {
	...
		if (skb_iter->decrypted || skb_iter->decrypt_failed) {
			err = skb_store_bits(skb_iter, frag_pos, buf, copy);
	...
}

For a merged skb covering both XORed bytes and untouched wire ciphertext,
does this either undo the transform on bytes the device never touched, or
leave the transform in place on bytes it did XOR, so that software AEAD
authentication fails with -EBADMSG?

A second consequence is in the rekey boundary tracking:

net/tls/tls_device.c:tls_device_decrypted() {
	...
		bool nic_touched = !is_encrypted || skb->decrypt_failed;
	...
}

If a record the device never processed inherits decrypt_failed from a
GRO- or collapse-merged neighbour, does ctx->rekey.old_nic_boundary slide
past that record, keeping the retired old AEAD alive and postponing the
deferred tls_dev_add()?

The series documentation appears to describe exactly this mismatch while at
the same time permitting the merge:

Documentation/networking/tls-offload.rst
	Coalescing (GRO, socket layer) and record classification are keyed on
	decrypted alone, so decrypt_failed segments may be merged with unmarked
	ones. ... A transformed segment delivered without decrypt_failed, or an
	untransformed segment of a mixed record delivered with it, is restored
	incorrectly and the record fails software authentication.

Since GRO and TCP coalescing run after mlx5e_ktls_handle_rx_skb() has set
the bit, can the driver honour that contract at all?  Would extending
skb_cmp_decrypted() to also compare decrypt_failed (and thus forbidding
coalescing across the new bit) be needed before this flag can be relied on?

The segmentation and arrival pattern is driven by peer traffic and a
peer-initiated KeyUpdate, so the merge condition is reachable from a remote
endpoint.

For reference, skb_cmp_decrypted() is unchanged at the end of the series, so
the gap does not appear to be closed by a later patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
