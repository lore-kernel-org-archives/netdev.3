Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B737B41E
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042166; cv=none; b=pV3PRkuRWhl+S14nH6a0ou3Kl55uQ9r+9JvnqY2UeMzrxnEBa0pQ7tmjFyqdiGlJuLJApf139y4Icqb4dSBt6a/32pWKAI8Eh7jGNWPGE/sqvG5nWA3F+W1Bdhj8I03QCiLUvjtF3DWnPQIaredA18H6qtB5F5bl6MYMaMdv298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042166; c=relaxed/simple;
	bh=ybaRGpdEHCglldmBuwF3uKgUMPz7iBdBwUAx9s9ZEjM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6NWDVK0Cdevlv/Yl4Zrf0wYXmaCZye6N7tAHslT79Z1Vp3NdEjJ4gXoyXLVD5dZCPnKP/9kDgy1pIhMSH55P5SMFPgoyEGiM224O1fBllXG+CP4TZ2wocsOZ+qK+QDB+BXO3hImDN8CiFZOKqfGHU6+bK6AXanrfTZZC1g+32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COgoq6mu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COgoq6mu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC551F00898;
	Tue, 22 Sep 2026 01:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042164;
	bh=5VIff7767WQvwLMgafg+JpWW3AD7NzLrBeac6m2DkKo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=COgoq6muE5Ji9FnnJxWRK0AChCjPob05EutDypiZjzrcOhhCJF6NIdGAC6ITBT1DD
	 8YjCojuF0QYJJWxfyGMNNCinEG9xrBa91Ud2T9Z5QSBwZXtGRB3d0iNW3VK8AkcHEV
	 /LCytOMrH6w7vSMWNwmvIWZr5VtSNRS7NWAQhEHOyDbvFyQQ1uX7KmhH4ueym5/Lxe
	 O+k0vJ0jJeDYqRDgGNJDc8L7pblDKNasLO7aV98lRLONI4bWTFTVI0frvS4CI8lN3i
	 FAc+xM49ZgdwyUIDtt77pBJZGK/B3UeLYu1q4Vzs7QhvUsngD35tlF3RU2Kwbjvwut
	 PQPxdckBSoyFw==
Subject: Re: [PATCH net-next v17 07/15] net: sched: re-validate parked
 decrypted skbs on requeue
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:56:03 +0000
Message-ID: <179004216348.2160803.5502816628598528755@kernel.org>
In-Reply-To: <20260917224355.2288021-8-rjethwani@purestorage.com>
References: <20260917224355.2288021-8-rjethwani@purestorage.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net/sched/sch_generic.c:dequeue_skb() — the new `if
  (skb_is_decrypted(skb)) *validate = true;` is not idempotent for kTLS…
- [Medium] net/sched/sch_generic.c:dequeue_skb() — the patch is presented
  purely as "a prerequisite for TLS 1.3 device-offload KeyUpdate…

--

net: sched: re-validate parked decrypted skbs on requeue

The patch forces *validate = true in dequeue_skb() for skbs sitting on
q->gso_skb when skb_is_decrypted(skb) is set, so the socket's current
sk_validate_xmit_skb callback is consulted again after a requeue. It is
described as a prerequisite for TLS 1.3 device-offload KeyUpdate support.

> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 6f6a6f0d5eb0..fc8ef0d13f5e 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -285,6 +285,15 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
>  		*validate = false;
>  		if (xfrm_offload(skb))
>  			*validate = true;
> +		/* A still-cleartext skb of a crypto-offloaded socket was validated
> +		 * against that socket's offload state at the time. That state
> +		 * (sk->sk_validate_xmit_skb) can change while the skb is parked here
> +		 * e.g. a TLS key update or offload teardown, so re-validate it,
> +		 * letting the current callback decide how it reaches the wire instead
> +		 * of emitting now-unencrypted plaintext.
> +		 */
> +		if (skb_is_decrypted(skb))
> +			*validate = true;

[Severity: High]
Is skb_is_decrypted() a reliable test for "still cleartext" here?  For kTLS
TX, the software fallback's output skb appears to inherit the bit from the
plaintext original:

net/tls/tls_device_fallback.c:complete_skb() {
	skb_copy_header(nskb, skb);
	...
}

and skb_copy_header() -> __copy_skb_header() copies the whole headers group:

net/core/skbuff.c:__copy_skb_header() {
	memcpy(&new->headers, &old->headers, sizeof(new->headers));
}

decrypted:1 is a member of struct_group(headers, ...) in struct sk_buff, and
nothing in complete_skb() clears it at this commit, so the ciphertext skb
also has skb->decrypted == 1.

Can that ciphertext skb reach this new gate?  sch_direct_xmit() validates
before transmit and requeues onto q->gso_skb on back-pressure:

net/sched/sch_generic.c:sch_direct_xmit() {
	if (validate)
		skb = validate_xmit_skb_list(skb, dev, &again);
	...
		dev_requeue_skb(skb, q);
}

which is why the existing code sets *validate = false with the comment "skb
in gso_skb were already validated".

If so, what stops a second tls_sw_fallback() pass over the already-encrypted
payload?  Unlike the neighbouring xfrm_offload() case, which is guarded by
XFRM_XMIT, tls_validate_xmit_skb_sw() has no "already encrypted" check:

net/tls/tls_device_fallback.c {
struct sk_buff *tls_validate_xmit_skb_sw(...)
{
	return tls_sw_fallback(sk, skb);
}
}

and fill_sg_in() re-resolves the record from the unchanged TCP sequence:

net/tls/tls_device_fallback.c:fill_sg_in() {
	u32 tcp_seq = ntohl(tcp_hdr(skb)->seq);
	record = tls_get_record(ctx, tcp_seq, rcd_sn);
	if (!record) {
		spin_unlock_irqrestore(&ctx->lock, flags);
		return -EINVAL;
	}
}

Does that mean the same record sequence number, and therefore the same AEAD
nonce and keystream, is used a second time with the previous ciphertext as
input?  For the CTR-based AEADs used by the offload this would put
C1 XOR KS, i.e. the plaintext, on the wire, which is the outcome the
changelog says it is preventing.  And when the record has already been
freed, fill_sg_in() returns -EINVAL, tls_sw_fallback() does kfree_skb() and
returns NULL, so a mid-stream segment that has already been removed from the
qdisc accounting is dropped silently.

For reference, a later commit in the same series, 3f66fe17313fe ("tls:
device: add TX KeyUpdate support"), adds nskb->decrypted = 0 in
complete_skb() with a comment describing this exact failure mode.  Could
that clearing be moved into this patch, or ahead of it, so the tree is not
left in this state for several commits?

[Severity: Medium]
Should this carry a Fixes: tag?  The changelog presents the change purely as
"a prerequisite for TLS 1.3 device-offload KeyUpdate support", but it also
changes behaviour for offload users already in the tree, since before this
patch sk->sk_validate_xmit_skb was never consulted again for anything parked
on q->gso_skb.

Two in-tree writers can change that state while the skb is parked:

net/tls/tls_device.c:tls_device_down() {
		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
}

which also clears ctx->netdev, and:

net/psp/psp_sock.c:psp_validate_xmit() {
	pas = psp_skb_get_assoc_rcu(skb);
	good = !pas || rcu_access_pointer(dev->psp_dev) == pas->psd;
}

where the dev->psp_dev relation can change under psp device teardown.  If
either path is reachable today, this is a confidentiality fix for current
users and backporters get no signal from the changelog.  The transition in
tls_device_down() came in c55dcdd435aa6, which would be the Fixes: candidate.

The other direction is also unmentioned: forcing *validate = true on requeue
introduces new drop paths for skbs already accounted out of the qdisc.
psp_validate_xmit() can now consume a requeued skb with
SKB_DROP_REASON_PSP_OUTPUT, and an orphaned socket hits:

net/core/dev.c:sk_validate_xmit_skb() {
	} else if (unlikely(skb_is_decrypted(skb))) {
		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
		kfree_skb(skb);
		skb = NULL;
	}
}

Could the changelog mention that requeued decrypted skbs can now be dropped
rather than transmitted?  Alternatively, if none of the above paths turns out
to be reachable in-tree, the "emitting now-unencrypted plaintext" wording in
both the changelog and the new in-code comment overstates the present risk
and could be reworded.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
