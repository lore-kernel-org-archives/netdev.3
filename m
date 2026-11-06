Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793995123;
	b=O2Y7aXscQaQIFm72h3SqJ1PCsyDd6+FPquXiuC9GoFRpE53W4DEeuFWU2QCe5vo0evEY
	 WcMkMR0PsMHPsMVcpnqAxTvqopy8AZqAt50iPvdn587FqtSUJapWrHf78zUuVwWyf4xGq
	 833KK21axteB2+1KChN8OpV14M1N1QLzHbMm103f6sDnX6shTFV2DP+qQ/7lNUjYYL0n+
	 akKOgrH8zZMznz2NLd3o+fCpkz4/o6aDbU9rJwpPOZgNa2aXvX0JA9Mg1KcCGDa7s5AxG
	 X5jgaIe7Ch/tNU8NOouQyMMz/6kvEI3IRUg0MgTqn1zLXFXkCSGMVLzcqJLdACIgSqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=skcINL+3UKtpExibaN+zBdKWWm8B7/WmkTxSalXTw6M=;
	b=in+zL82iPPgJiH8kBakAM+F6GA9n9f+U4d/A5CrTh7VxSrhgtP5Vpw91lZIsvoQWtP/L
	 //kD+sB9jXyD1+PInqNHjS3D3q/UZpmfv5Ye7IVRltXsWa+iugF+LVOoBnGAfRUxdka83
	 fr65ryBc2jjjXTSH5zgE3OutQs7rceWjHeYqMl8zfubBNR5bpXQVTaNVCJnzbFC5gYbl/
	 jWDuk0mnoLJsXDeS3LmWjBxVKBBgX9iLENod+IKQEr1xoykDwG4CiR7IODI4SHIc2geNC
	 68Y6N1NOZ1bDysbeEWeBDfOyOHaJYckc86Jcfsz8Bpm91Sgr1vPS57e77qgBEheI4lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=EWxeiJsY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9A606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE9A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=EWxeiJsY
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9906870a9baso494315241.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:58:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793995121; cv=none;
        d=google.com; s=arc-20260327;
        b=M4grQfhEAc3vtsQQoxKwU/oMTLFxobIHssJOGK5IPPx/4Z0UXLEcMcsfaop5ZwhmVj
         XAurWUu5sgxX1ZoHcOg7eRhD2nWg5Wip17P3+Ceh0jUMebiDttsEAzjpcWdtLJbI/JQ5
         0l4/15G/mRsxUoB9CdvVXHkSw5qMaN4HWq0EmJMFy7DcyN73a9ThBEk5Z3bIPu9yoPM9
         fu1dKK18S+v1XklPXbyg4QIfj6u6X9eCC7rI8L8R35E7IFkxIdCpcOT4ls84zwW1qZH2
         zZwkqUC0yXnhy7RAthYAw9R71YRtiaylVo5f/nQd9YYeqj7M2t03id1vf64IVqGUP3Nc
         O2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=skcINL+3UKtpExibaN+zBdKWWm8B7/WmkTxSalXTw6M=;
        fh=hbwyUVrdM7cXL+UQOzR25H4X0U66Ee3voRCne/mgfKc=;
        b=PL+qtllXU0725ndlco7zjQzx9YpnOGPB+SK10at7lmKu7mCJbuLSpFlwHAcsqPIM1M
         Tp9rat7cZJcYfsKVNrRxmFzuwlFhsl+GGLIFz85aFhaFWkkqtUAwQejDgz/jFDgzSC9w
         jIagOV4UPPMHBRQX3kGuPb9lTid3VVWUEvCI3G66nnYWMkyJr9lucZYCuIJ5TqFh2eJT
         0A9ecRWXdGZKQ4S84QT8Mgui0w/6yymc8ojd2O8aeswV9EvBiM/JuB7YvgBXxiCfozyT
         NN0qqqjKkdVuBQiftHbNKOkARQX2A/aQexx6kZanJ4n08eCujSrd0uzinZrjkY1Mp9dW
         ZxVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793995121; x=1794599921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=skcINL+3UKtpExibaN+zBdKWWm8B7/WmkTxSalXTw6M=;
        b=EWxeiJsYFHPQYfkqkqBUdoGpydy5deeuG19OepoZaKY8sy8m3pWE6iLxjEvNCVZpfG
         E1G9F60VpRPUjguLZ+bQjrFQWVIyjXzOrmvWm7FfYpnaFocuE+WfK11CUBPLmX0vFXBE
         LbJmkamCVYh4jefQvkINNhz49zFHjAi8Q/grJqTbR9FntPLsZx3wgP9kkluSTtCM9+ad
         KwoRdSSLEqlpbrBOaJ0J34NwykiYYeWLyJQwclsBEjC8NBScGdyhjnPHF3KaCwmtSN78
         30kN4kpiszyhAyn7W1IwM6LMOPQT7Y+SD6AE0jXIqWW6pVZRAyzILxKpFvFNOiHC/VZN
         IByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995121; x=1794599921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skcINL+3UKtpExibaN+zBdKWWm8B7/WmkTxSalXTw6M=;
        b=LjInb6WINpds48h+/c1KVFgBkkvOP0xfUGVJZHQWA8sa5F9VJtOAKbsjZo5oWlIYxK
         J0XoZZZqy7c2Zm65OgpmCfCJmjFaZX6/4cFgb2tuj2JbNqnxbxQa4Acy62StPylAUUqO
         d2rEKHaQnQxE/ujbiiIiCYEhJhgTVLY1uW6OjbHtQuOjzKW3vxGPJgxQ+lHxXSAr7ktI
         87IvvvRhzWaaEZqj/yo9bYWKspOf3PPNU7+Y1FemUPFaCDF8ozV397yMlhS/LQ00qFW5
         /c1r/WD5TUh03ONYfUUN5Il9lRyVD5DKkRdUwl88P3JptrlcZywfBymDGVFk6t7bTyZs
         m62A==
X-Forwarded-Encrypted: i=1; AL+hErHAE3BXUhNY78OJdevXL4iuQO8UMR9WJJsai0sZtW5/FDAgogUKUmiidhyh/YNVx/GUq+oNbnI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XdkkD/74FHo+p2QK8l8hQ47uvCZKy3oqnqUy5KbFiI7wSjO5+
	Sf1L2SuRpqjZVB0ov0Fcjg3AB7JH+A5BSS/PLilJdE9SUX/XJvy7VeAWqHU8xC9mux3Xw/GjTG4
	bW802Z+IeeVrN7P1UngQcRRf5e9BKIZno4Ro32vrM3w==
X-Gm-Gg: AYBFou0SScKsxP03WEazHv5tvQGbJN1z8KoqNBJatkaUpyr+Sl9JcJQa9LT2BwuxFKK
	oyzvOUYL6ExBwO4lCZNFj3aYbfkqqZ2lvMogJXBVljPaN7JqXU9f/E2f1ddo1b1B77yhlAdHVcW
	6dmgJ+ZCPYz10jTArWk9cg6PKW5b4qITUlQGLndzCxT5cQkyHo+In1K3V5QOtxMz2j2PQPzdCj+
	4RudkCgZW3NDJzc54zWpKZCti3mBmFd6K/Gvx3XctCuxEgobxbBKOwZDmOg/H2TgjtNwPBMVDEO
	jliqYU4OwJpU5ZzoEPJKpzLbSPoUuSo9iU6LtWuvfJRQkBIYGkxgVDm9zO/wq3et16GfGZv9x9t
	zL8caREZrLJArBvHLQ9cszOGtbRk+OzQH0jK41qbpt8cD08kt4gL7i/15ZZrkWTeRJXxGJ4MYNn
	et/hTqfzPSxB3H/0g9fDrrz4UDYOHM+fD7gmdDMjIsium+DZdCZaeXmm/E9KxIHkHDpGMmRwJvp
	9ahXaYOaMPfonkxrRuQPdJA
X-Received: by 2002:a05:6102:6051:b0:7d2:7654:86ac with SMTP id
 ada2fe7eead31-7d2a12dfdfdmr1845416137.4.1793995120435; Fri, 06 Nov 2026
 11:58:40 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022181751.1349984-1-rjethwani@purestorage.com>
 <fc0da060-5bf5-4289-8814-d25e6c422673@nvidia.com> <CAKaoeS1hj9XuM7ojLBCjGA=EXc2M-b+eRjC2Sk=8L_8XYeJ18w@mail.gmail.com>
 <4796023b-10ae-4172-afa8-9c7541844314@nvidia.com>
In-Reply-To: <4796023b-10ae-4172-afa8-9c7541844314@nvidia.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Fri, 6 Nov 2026 11:58:29 -0800
X-Gm-Features: AclHuK9ZF4o2DVJ2xs-flA_e4ceEcwoOQscgigP-yX5X5M0tie_y5xxLFwZjvT8
Message-ID: <CAKaoeS3hDE5q7XGtPy4XKmGL54-+7Y-H9JyMcdz94FiQW2_ffw@mail.gmail.com>
Subject: Re: Question: net/mlx5e kTLS TX TIS reuse vs in-flight WQEs
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 1:26=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> wro=
te:
>
>
> On 04/11/2026 7:01, Rishikesh Jethwani wrote:
>  > Thanks, this answers the cross-SQ ordering question. Short version:
>  > I agree with (1), and (3a) fits the series; I prefer it. For (2), I
>  > agree with the goal, but wmem-gated reselection alone does not keep a
>  > connection's work on one SQ in mlx5e; the holes are listed below,
>  > with two ways to close them, and I'd like your preference.
>
> Hi Rishikesh,
Hi Tariq,

Thanks. Agreed on (3a), (i) and the net fixes, with one condition on
(i) below. Answers to your two questions are below, plus what rekey
needs from the fixes before I build on them.

> Thanks, very thorough again. Short version from my side: I'd go with
> (i), closing the holes, rather than (ii), and with (3a) along the lines
> of your contract. As the queue moves corrupt records today, regardless
> of rekey, I'd send (2) and the mlx5e side of (i) to net as fixes; I
> could reproduce the corruption on ConnectX-6 Dx. Details inline.
> Feedback is welcome, especially where it touches your series.
>
>  > Two hardware questions here, and a third on initial setup under (1):
>  >
>  >  - Does a completed DESTROY_SQ, or finding an SQ in ERR, guarantee
>  >    that none of its WQEs can still access a TIS or DEK? And can
>  >    DESTROY_SQ fail while the function is healthy?
> [...]
>  >  - DEK release in mlx5_crypto_dek_destroy() has two paths. Without
> [...]
>  >    After all WQEs referencing a DEK have retired, is either path,
>  >    including reuse of a pooled id by another connection, safe while
>  >    an idle TIS still names that DEK, before replacement static
>  >    parameters are posted? Or is today's release only safe because
>  >    of the destruct-time ordering?
>
> Good questions. I'll take them to our HW/FW folks, and get back to you
> once I have answers I can back up. Meanwhile, what I propose below
> relies only on what the close path already relies on today: a CQE
> retires all earlier WQEs of its SQ, and once an SQ is destroyed, none
> of its WQEs executes.

Thanks. Until then, the two hardware questions remain open, including
whether DESTROY_SQ can fail; the destroy wrapper discards the status.
One correction to my last mail: recovery clears RECOVERING even on a
flush timeout, so the queue can wake once stop_room frees.

>  >> 1. Pre-existing, independent of rekey: the stranded WQEs above.
> [...]
>  > Agreed. Three spots for it: on SEND DMA failure, mlx5e_sq_xmit_wqe() a=
nd
>  > mlx5e_sq_xmit_mpwqe() already post a NOP through mlx5e_tx_flush() but
>  > free the skb first, so the skb should be held instead; that NOP asks f=
or
>  > a completion because mlx5e_notify_hw() sets MLX5_WQE_CTRL_CQ_UPDATE, n=
ot
>  > mlx5e_post_nop(). mlx5e_ktls_handle_tx_skb()'s err_out needs the same
>  > hold-NOP and a doorbell, since it can leave parameter/DUMP WQEs posted
>  > without one. The MPWQE case is reachable too: when TX MPWQE is enabled=
,
>  > mlx5e_sq_xmit_mpwqe() takes any linear, untagged, non-GSO skb with
>  > inline mode NONE, which includes a pass-through skb that posted pendin=
g
>  > parameters and took SKIP_NO_DATA, since it leaves with no TISN.
>
> Right, the patch covers the same three spots: mlx5e_tx_flush() takes
> the skb and attaches it to its NOP, which requests a completion through
> mlx5e_notify_hw(), and both SEND error paths hand it the skbs of kTLS
> sockets, MPWQE included.
>
>  > One correction to "SQ error/reset is covered": error-CQE recovery neve=
r
>  > runs mlx5e_free_txqsq_descs(). mlx5e_tx_reporter_err_cqe_recover()
>  > waits in mlx5e_wait_for_sq_flush() for cc to reach pc, then zeroes bot=
h
>  > counters, so on success every WQE has been retired by an error CQE and
>  > the held skb is released normally.
> [...]
>
> Correct, thanks.
>
>  > A related recovery gap exists today without rekey: if a connection's
>  > initial static parameters are flushed without executing, recovery does
>  > not re-arm ctx_post_pending. A retransmit of the same record can also
>  > skip static parameters, so software does not guarantee that the new
>  > context gets installed. What does the hardware do with a SEND naming a
>  > TIS whose static parameters never executed, recycled or freshly create=
d?
>  > The rekey contract below handles the corresponding replacement case;
>  > initial setup may need the same treatment.
>
> Agreed, and it is wider than the static params: any lost WQE leaves the
> TIS state off from what the driver tracks. WQEs are lost when an skb is
> dropped after its kTLS WQEs were posted (or after expected_seq advanced
> past it), when an SQ error flushes them, and when an SQ is closed with
> WQEs pending. The driver holds the skb in each of these, so I'd mark
> its connection right there, and have the next skb of a marked
> connection resync fully: static params regardless of rec_seq, progress
> params, and a DUMP of the record prefix. That covers initial setup, and
> the replacement case of your contract, with no rekey-specific code. I'd
> send it to net together with (1).

Agreed. What rekey needs from that resync fix: a lost initialization
or replacement always triggers a full resync on the next skb that
needs the TLS context, and a connection marked again while the driver
is consuming an earlier mark stays marked (test-and-clear, not
clear-after).

>  > When do you expect to post (1)? I'll base the series on it and can
>  > test on ConnectX-6 Dx before you post.
>
> After internal review and testing; I can share the patches as RFCs in
> the meantime. (1) goes to net together with the resync fix above and
> the fixes for (2) below: the stack part, the mlx5e queue pin, the
> channel replacement overlap, and the pass-through skbs. I tested them
> on ConnectX-6 Dx, and testing on your side is very welcome, especially
> with your series on top.
>
>  >> 2. Pre-existing, and a dependency of rekey: TX queue stability. I'd
> [...]
>  > Gating ooo_okay, the dst-reset queue clear and txq_reselection_ms
>  > on wmem covers every path through sk_tx_queue_mapping. In mlx5e the
>  > SQ can still change while that mapping stays put, or bypass it:
>  >
>  >  - Channel replacement with tis_tir_td_order destroys the old
>  >    channels only after the new ones are active (3b88a535a8e1).
>  >    mlx5e_deactivate_txqsq() posts a final NOP, but nothing waits for
>  >    its CQE, and mlx5e_poll_tx_cq() returns early once ENABLED is
>  >    cleared. The deactivated SQ can still hold old-key WQEs (e.g.
>  >    under PFC pause) while the same txq index already names the new
>  >    SQ, so (3a)'s "same SQ as all old-key WQEs" holds only once the
>  >    old SQ is destroyed, which is the DESTROY_SQ question above.
>
> Right, and that overlap is a bug of 3b88a535a8e1 on its own. I'd fix it
> by draining the old SQs before activating the new channels: their NAPI
> is already disabled, so the switch reaps their completions directly,
> and the old channels are still closed after the activation, which keeps
> the downtime saving. If they don't drain in time (e.g. under a long
> pause), it warns and falls back to closing them first. No kTLS-specific
> count is needed.
>
>  >  - With num_tcs > 1, mlx5e_select_queue() adds a priority offset
>  >    after netdev_pick_tx() (DSCP under MLX5_QPTS_TRUST_DSCP, else VLAN
>  >    prio; HTB by skb->priority), so IP_TOS/IPV6_TCLASS or SO_PRIORITY
>  >    changes move the SQ.
>
> mlx5e_select_queue() can keep the final queue of such sockets: cache it
> in sk_tx_queue_mapping, and reuse it as long as ooo_okay is clear. A
> priority change then takes effect once the connection has nothing in
> flight, which for a busy bulk flow can take a while; that's the price
> of keeping the order.
>
>  >  - Egress skbedit queue_mapping bypasses ndo_select_queue(), and
>  >    SKBEDIT_F_TXQ_SKBHASH can move a flow after a txhash rethink.
>
> I'd document it as not supported with this kind of offload, and have
> the driver count it (see below).
>
>  >  - A queue-count change: netdev_pick_tx() ignores a cached index
>  >    >=3D real_num_tx_queues whatever wmem says.
>
> In mlx5e that comes only with a channel replacement, which the drain
> covers, or with an HTB leaf deletion, which closes the leaf SQ before
> its queue is removed.
>
>  > Separately, "a drained wmem means that no work referencing the
>  > connection state is pending on any SQ" has a pre-existing hole:
>  > netem with delay, jitter or rate calls skb_orphan_partial(), which
>  > keeps skb->sk but swaps tcp_wfree for sock_efree, releasing the wmem
>  > charge while the skb is parked.
> [...]
>  > Both kinds of skb above can be handled in the driver alone: mlx5e can
>  > skip the context WQEs for an skb with skb->destructor !=3D tcp_wfree (=
the
>  > test tcp_gso_segment() already uses), which covers the pre-install
>  > plaintext, whose orphan decision netem_enqueue() made before the socke=
t
>  > was offloaded, and the parked rekey ciphertext alike.
> [...]
>
> Agreed that it belongs in the driver. Rather than keying on the
> destructor, I wrote it so that nothing is posted for an skb that
> doesn't use the context: the pending params are posted only once the
> skb is known to need them (in order, or resynced, where they fold into
> the full resync), and stay pending on SKIP_NO_DATA. A pass-through skb
> then touches nothing, wherever it was parked. Does that cover both of
> your cases?

Within the sequence window, yes. Outside it, a partially orphaned
pass-through skb can be held past half the sequence space and alias
expected_seq or a live record. An explicit bypass right after the
datalen check in mlx5e_ktls_handle_tx_skb() closes that without a
sequence comparison:

        if (!skb_is_decrypted(skb))
                return true;

All kTLS HW data is sent with MSG_SENDPAGE_DECRYPTED, and decrypted
skbs can't be partially orphaned, so every skb that reaches the
context then holds wmem.

>  > So (2) as proposed is a good stability hint, but not proof. I see
>  > two ways to get correctness:
>  >
>  >  i. Close the holes individually, without a new per-packet lock: the
> [...]
>  > ii. A driver-side owner check where WQEs are posted: priv_tx
> [...]
>  > I lean towards (ii) for robustness, with (2) as the hint that keeps
>  > it off the slow path, but I'd rather hear your view on the hot-path
>  > cost first.
>
> I'd prefer (i). With the drain, it no longer needs to close channels
> first or to count connections, and the rest is small and local. (ii)
> adds a lock and a SW encryption fallback to the mlx5e xmit path, for a
> case that shouldn't happen once the holes are closed; a fallback that
> hardly ever runs is also hard to keep correct.
>
> And as these moves corrupt records today, without rekey, I'd send (2)
> and the mlx5e queue pin to net as fixes. On ConnectX-6 Dx with many
> channels, kTLS TX records already fail decryption at the receiver with
> the default txq_reselection_ms, and forcing moves breaks most
> connections; with the net fixes, the same runs are clean.
>
> As for a future path silently breaking the invariant, the driver can
> catch that cheaply: it remembers the SQ that a connection last posted
> on, and when the next skb arrives on another SQ while ooo_okay is clear
> and the old SQ is still live, it bumps a counter and warns once. That
> is a pointer compare per skb, and it turns a silent corruption into a
> visible one.

I'm happy to use (i), but warning/counting alone does not cover the
forced-queue case: a detected conflict has to prevent the conflicting
hardware access, since old TIS accesses must have retired before
another SQ can modify the context. Dropping before any TLS WQE or
context-state change would preserve safety without SW crypto. TCP
can recover unacknowledged data through retransmission; conflicting
retransmits keep being dropped until the old accesses have retired.
I'll leave the mechanism to your patches. Points they need to cover:

1. Egress skbedit never calls ndo_select_queue(), so a counter and a
   warning still let conflicting WQEs reach two SQs.

2. sk_tx_queue_mapping is shared by every device on the route: if
   the route passes through another device for a while, its
   netdev_pick_tx() can overwrite the cached queue, and back on mlx5e
   the flow moves while the old SQ still has work. ooo_okay alone
   isn't proof either: TCP also sets it when the rtx queue is empty,
   and on a bond the stamp can be stale by the time the lower device
   selects. bond_select_queue() ignores sk_tx_queue_mapping, and the
   slave's netdev_pick_tx() runs only after the bond's qdisc dequeues,
   so an ooo_okay skb that was overtaken (e.g. by a later skb in a
   higher prio band after an SO_PRIORITY change) can re-pick while
   that later skb is still outstanding on the old SQ. For this bond
   example, re-check wmem at selection: allow the move only if
   sk_wmem_alloc_get(sk) <=3D skb->truesize while the skb still holds
   its own charge, and only at zero wmem for an uncharged one.
   Across transmit paths, the migration check and queue publication
   also need serialization.

3. The drain has to cover the QoS/HTB SQs too, and reap deactivated
   SQs although mlx5e_poll_tx_cq() returns early once ENABLED is
   clear; a missing or replaced txq2sq entry isn't evidence of
   retirement. On a drain timeout, the fallback must close the old
   SQs first (which keeps the guarantee, modulo DESTROY_SQ), never
   activate with them alive.

On the price you mention for priority changes, agreed. Please
document in Documentation/networking/tls-offload.rst that pinning
delays priority/DSCP/HTB-driven TX queue changes until migration is
safe, potentially indefinitely under sustained traffic.

>  > (3a) fits, and I prefer it. sendmsg keeps sending SW ciphertext during
>  > rekey, which holds wmem, so (3b) can wait indefinitely unless the
>  > sender stalls. With this series, mlx5e is the only in-tree driver
>  > accepting TLS 1.3 crypto_info, so the core can require the new op for
>  > TX rekey and leave other devices in SW.
>  >
>  > Proposed contract:
>  >
>  >   int (*tls_dev_rekey)(struct net_device *netdev, struct sock *sk,
>  >                        enum tls_offload_ctx_dir direction,
>  >                        struct tls_crypto_info *crypto_info,
>  >                        u32 start_offload_tcp_sn);
>
> Looks good to me.
>
>  >  - The old DEK is freed from process context once a successful
>  >    CQE covers the fenced replacement, subject to your answer to the
>  >    second question above.
>
> Agreed, and it's simpler than I first thought: the driver doesn't need
> to track completions per connection. When it posts the fenced
> replacement, it can hand the old DEK to that WQE's descriptor, the way
> DUMP WQEs hold their page refs today, and release it once the SQ
> retires that WQE. Completions being in order, that covers every old-key
> WQE posted before it on the SQ. A flush or an SQ close retires it too;
> the TIS may then still name the old DEK until the resync installs the
> new one, which is your second question again, and the same as an idle
> TIS in the pool today. The release runs from NAPI, so the destroy
> itself would be deferred to a work item.

Nice, that's simpler. On the core side, the op's contract: the
callback prepares the new key and pending parameters but posts no TLS
WQEs for this connection. After it returns success, the core commits
the new fallback AEAD and start marker, then restores the HW
validator, as v18's del+add path already does. Replacement parameters
are posted when the next skb needing the TLS context reaches the
driver. On failure, the callback releases its new allocations and
preserves the existing context for outstanding work and eventual
tls_dev_del(); the core commits nothing and TX stays in software.

Callbacks are serialized per connection, but another may arrive
before the previous replacement is posted. On success, the driver
must clean up any superseded, never-posted key.

On the driver side, the DEK lifetime requirement: the old DEK stays
alive until a completion proves old-key work has retired; a successful
CQE covering the fenced replacement does that. Whether a flush, an SQ
close, or deletion back to the TIS pool may release a DEK the TIS
still names depends on your hardware answers; if not, retention has to
extend through the pool, which is pre-existing and not rekey specific.

>  >  - Retirement of the SQ only proves the old work stopped, not that
>  >    the replacement took effect. If the SQ errors or closes before
>  >    a successful CQE covers the replacement, the driver forces a
>  >    resync on the next offloaded skb regardless of expected_seq:
> [...]
>
> That's the resync fix above, which isn't specific to rekey.
>
> One question on the core side: once the HW validator is restored, can
> a decrypted old-key skb still be queued, e.g. a spurious retransmit
> parked in a qdisc, and reach the driver? It would end before the new
> marker, so mlx5e would take SKIP_NO_DATA with a decrypted skb, which
> today hits WARN_ON_ONCE() and drops it.

It can be queued, but within the sequence window the core drops it
first, in two v18 patches that aren't upstream yet. "tls: device: add
TX KeyUpdate support" sets TLS_TX_REKEY_FLOOR before restoring
tls_validate_xmit_skb(), which then drops any payload skb whose
end_seq is not after snd_una; completion runs only once every old-key
record is ACKed. "net: sched: re-validate decrypted skbs on requeue"
makes an skb parked on the requeue list go through the current
validator again.

Outside that window, the floor does not reliably identify old-key
clones. Once snd_una advances at least 2^31 bytes past a parked
clone's end_seq, the comparison can reverse; that progress can begin
before rekey completion. Later traffic must overtake the parked
clone, for example if a classful qdisc lets a newly selected priority
class run ahead. Record lookup also uses 32-bit TCP sequence numbers
today without rekey, so a sufficiently delayed clone can alias a live
record there too. The floor catches old-key clones within its
comparison window, but does not remove that ambiguity. I'll look at
closing this in the core separately.

>  > If this direction works for you, I'll write mlx5e_ktls_rekey_tx()
>  > and whichever (2) option you prefer on top of your fix, and test
>  > them on the same hardware.
>
> Sounds good. (2) is covered by the net fixes, so please go ahead with
> the op and mlx5e_ktls_rekey_tx() on top of them, and I'll review. The
> RFCs mentioned above should let you start before the fixes land.

Please Cc me on the RFCs, and let me know which fixes the rekey
patches should depend on. I'll implement the core op, its contract,
the v18 integration and mlx5e_ktls_rekey_tx() on top of them, and post
the patches together as an RFC for your review. I'll keep the
flush/close DEK release and pool-lifetime questions explicit until
your HW/FW answers settle them. Devices without the callback keep TX
in software after a KeyUpdate.

> Thanks,
> Tariq

Thanks,
Rishikesh
