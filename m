Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793768497;
	b=IfMfJKuEOzt/RIZrMCEDMPW7a31KW1ZWmP4FdjBivhvuNEUgYgZsdOBYDOlqIXPaU9Sl
	 GhaUIZ3FJbpDK4TDDfryFxN2L/2p8VqLvf6rhsric90UP4I9WQ4jRUVu8OZ2LJ1UsRpzf
	 kbw17z/rANN2kbRaEP+Cm6aii9txlIXdJwVHV3nEj1ysJqbeXuVkZn7BI3DZZmP9Iawsq
	 1SRKYVJOVbVsgthsLRKVaYYajWbmbbr8p/G7iMKIUkb5PF5/KXGpxyXkAHWoKOdu9NnZ/
	 fn4fV80TxFDVc1AQj/Vu1BghQidJsh6kICu9MtkeD79fkHaf7XN2G7UilCVrq2XPM8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Y6GFwOmSSPvuEXTdIV5OiIaKeycxbYkgR84o+A5TEOw=;
	b=hrku8DxcGIDj0nf8rQyHwdWmhLAuxGvsuHtd/dmWe7c7gKeoymDsOF9nWHwQrB4447gP
	 NO2+P7MnfJE6qBmjt5S/Y0wFO9ouElCEYtUp5TlT6FPNt0UsZ75agPXo9Kn4rXHAg4VzE
	 dIFfjDUAr2p867/tAG4Wv1FeB7w+IE5as4nToZ8ze0aVvuir7XBGVZ6RfaCMQonYDDy0a
	 S+17345yQfPmJmGRAcavMXaO9a1xCXqGULuWO93gfm6SOIjmIfZHQx9CR3r0qJRdhfr0y
	 egEHH6ZEgNFat5I4e5iC3GBb8zme9q+hvUYQHx8RE4cJn7XBcFz1Ks9wjpOQJ5wa0fA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=PaDX+B+s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E76606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 05:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74E76606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=PaDX+B+s
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eab93a9862so49538e0c.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 21:01:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793768495; cv=none;
        d=google.com; s=arc-20260327;
        b=ksRCmhQn8AgeLfvmLSivMlMybsrCLKyfy200tMBU6MLK2Lzq1MwTE9BmZvlPmnKuUM
         7LkgYRapNkafScBDbDZlliTHTKytyVRAOTxFjpsPbAQHVWmTRg0SAYGoqmI6y1gf6NyQ
         JBPYLFmv+EdclrSPLlynv4ohjr4YH928wwzWk+9JwMDMxf3CPhgua5gxQUc4T1rw0LDJ
         eu51h9whsPYPJ0j5qTaZLtO7QdaqKce3YZ7rSnKWzb8hB0gjZesJ7FSbPbPxrk5ViLIT
         arXAsCct+bWphpbKDhnq0H31O4vYiZcpIqZAXoiPj3I4VyvBkD8xBh9NlKtiRfpVWyZX
         9cmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y6GFwOmSSPvuEXTdIV5OiIaKeycxbYkgR84o+A5TEOw=;
        fh=ZX36apEXfQVfYkb41Lu7Ax1cgjo8LDxiRkI2L+xKLGE=;
        b=EEc4ysoW/SmJ8zEZ5PV3mCO7MgBqOm3dqR5Sb/ka+zQ6AfApPa7A8nrwGHrCQg+yU/
         uQ0Fp0q1XTW1WxNqvPXN2cJL8I3aAD8u7aMyUHi8agt8ucpFutUwwVAjH7xx1vn5QMA7
         wtoDonJqA/j2WNqj4GR+EMx1A4GWIE8Zusho+c9kXA/PEhJYiJXrk30S6E5TZqVOx7Zf
         9eKvOgBNdnIB6kUSIFGagv4yEKAYM+VBbny3bsW9th0UFRQHyscyxjG0AORV4ZkX5I3U
         59qJ4l1pfnMSH2fM5iei+YVvvd7wHePQaCbUnvk7I2JIirC26f2BeMZT1VrLOrv0HWDM
         vvHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793768495; x=1794373295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y6GFwOmSSPvuEXTdIV5OiIaKeycxbYkgR84o+A5TEOw=;
        b=PaDX+B+sguJZZ7UqvzziOocnTSJFW+x9Upqf4wvohD6IJ8YrL4S+SSn/bbgWD5yCnx
         EOwbRN3xFFq9S8KFY6UnVYnMdPyvMevPpYI1oys7hWAVgS/00QjU3qkC7VSBzW36/2gV
         lGZmcTPA8NNjgS0/iW5MKSUe83/OpqGX0n+yTtnJ9CODP8vKtQWF3oqB/2DOOnQpxQut
         MEMuEp18q3VsJhXM3WJuZilM74yt4NsXS6iBVjdp1b4+Fr8lm0WB33Q+CTDsvcdn3md2
         rDRQ8WfZqBuMwslzjO94LXZg/pqpDYLyfiXeYdZjckuJfffzNs3l/j5ABmh1qK/4Nye0
         HCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793768495; x=1794373295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y6GFwOmSSPvuEXTdIV5OiIaKeycxbYkgR84o+A5TEOw=;
        b=V6/51l/2EXTSMBsPdYWREQJMcGgAFUM7PAii4uGWjNhsGTfHTc6qt6kJ0zULyDDIn7
         2sde/80keXj6D1IPtIV2G/Ub9u0Kg5A3xvJ2NqRgbP9BxCkso3s4OHqe28lRrKfChCsc
         iEKgaUdPPtpCAPsg8l684G6xBmfTnIHGJlpIWCqwKNBLtiN8KR0PxDY0Z+VAiBikBHc8
         TuzTZaesW6Y1Dd17RmHKO/VgAndDokDSYr75QJ9mSK4Bxhvm0W46MTxVWe4IIEBHMAN0
         M8gpcFqyBRJ5+W8YPde83/czhRnRr/TBeHJZ1v8Nvost9Z+B+imdzcMfnfzpKKgDBlap
         zk5A==
X-Forwarded-Encrypted: i=1; AKwUvBxhvsnci4DDWx2kchQXtx/O0cb2bvwjBLc+BhFCOFzP7u93LiRIUwnjJ+hphHLEdYCt7XT3/tk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eZzWdXAUN06XjQoTYxHEPAZlJlnhCHSGQPdbyzH5OdiRdnJ0R
	G9+3i+5MPM1zUMyEvlE+UO/OgcPiyZkhEh12XnEnuVJT9ocw5jA1Rs7um5MscRYNLS7v3T27zBz
	MmNzYJNaAOuRVoLSHOb16KnKqXjqyW3qzcPhLIzhv5w==
X-Gm-Gg: AYBFou2r0Vms2o67l2eiHH1NlCyN0WwsFE5LdGTwkTTTOQZUYFh1pO3QmAHJq7AfBuG
	UkE9anUn7+O4buomX+iR4bCVGyXgxaTuRyIkeUeLXZ92R7DX2UuaeLtXdXP3hWLXm3VOUEChe8S
	Hsh1Tr2+DlgMm0woKXL6Et4Gl46ghXJnX1PzC14Tk6BqIOM2kXn1ePjbeJXLaqJqEKjltR/0rZz
	xUe6OECV5zZuTYxZhHvMHl+yWbR1H8lyhDt0DT2CbjJF5zsQ/SwkDBFpZKICCPPAMy3a9Z6CkOC
	1jvsXDcihr1uqI1cwWqRIejNeEFUl2gs7RGD+u7NTousM8CRwAdMyUTskK9oCjzegxg/TqqvVbE
	v6up7xIkRJeEMI0AlDX971YW4JPEGZdXxYMB07+b2DhbjmCrkeNhACUvoye4ksuMN/mNqPlNBZC
	CaLskPxRbKVny3U0vG0+OvVx/nAqvxwCQLU82j9S1iuZMysWZx3PUIEojk6tMuy3BSp/I/twOHd
	u8kZAsO8siyfja9nq2cftc=
X-Received: by 2002:a05:6122:1d4d:b0:5ea:c9ab:bd86 with SMTP id
 71dfb90a1353d-5ec6897efbdmr6862015e0c.21.1793768494848; Tue, 03 Nov 2026
 21:01:34 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022181751.1349984-1-rjethwani@purestorage.com> <fc0da060-5bf5-4289-8814-d25e6c422673@nvidia.com>
In-Reply-To: <fc0da060-5bf5-4289-8814-d25e6c422673@nvidia.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 3 Nov 2026 21:01:23 -0800
X-Gm-Features: AclHuK_zW51ze1DqCLpfzecVGn2vgi2tvH6GhUjoXqDILtVr9XM9mIkD1VRiLzg
Message-ID: <CAKaoeS1hj9XuM7ojLBCjGA=EXc2M-b+eRjC2Sk=8L_8XYeJ18w@mail.gmail.com>
Subject: Re: Question: net/mlx5e kTLS TX TIS reuse vs in-flight WQEs
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 6:45=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> wro=
te:
>
>
>
> On 22/10/2026 21:17, Rishikesh Jethwani wrote:
> > Hi Tariq,
> >

Hi Tariq,

Thanks, this answers the cross-SQ ordering question. Short version:
I agree with (1), and (3a) fits the series; I prefer it. For (2), I
agree with the goal, but wmem-gated reselection alone does not keep a
connection's work on one SQ in mlx5e; the holes are listed below,
with two ways to close them, and I'd like your preference.

Two hardware questions here, and a third on initial setup under (1):

 - Does a completed DESTROY_SQ, or finding an SQ in ERR, guarantee
   that none of its WQEs can still access a TIS or DEK? And can
   DESTROY_SQ fail while the function is healthy?
   In mlx5e_close_txqsq(), the void mlx5e_destroy_sq() wrapper
   discards the destroy status, and mlx5e_free_txqsq_descs() then
   frees descriptors, advancing sq->cc without CQEs, so the "moved
   out of RDY" argument depends on the answer.
 - DEK release in mlx5_crypto_dek_destroy() has two paths. Without
   a DEK pool (dek_priv =3D=3D NULL) the object is destroyed right away;
   with one, the DEK is pushed back to the pool, its id can be
   handed to another connection after the batched SYNC_CRYPTO, and
   the object itself is destroyed later from destroy_work. After
   all WQEs referencing a DEK have retired, is either path, including
   reuse of a pooled id by another connection, safe while an idle
   TIS still names that DEK, before replacement static parameters
   are posted? Or is today's release only safe because of the
   destruct-time ordering?

> Hi Rishikesh,
>
> Good analysis, and thanks for the detailed write-up.
>
> > Could a DUMP/SEND WQE from an old owner on SQ A read or update TIS
> > state after SQ B has reinitialised that TIS for a new owner?
> >
>
> Short answer: Yes, in principle it could, once del runs on a live socket
> as in your series. Today, only parameter/DUMP WQEs of a dropped skb can
> be left behind (item 1 below): a pending SEND holds sk_wmem_alloc, so
> the socket is not destructed before it completes.
>
> The TIS is a function-global object, not bound to an SQ: a WQE that
> references its TISN reads/updates its state whenever that WQE executes,
> from whichever SQ it was posted on, and the hardware provides no
> cross-SQ ordering for such accesses. Details below, and at the end a
> proposal for the way forward, on which I'd appreciate your feedback.
>
> > The existing TIS pool predates live rekey. My TLS 1.3 TX KeyUpdate
> > series (v17 [1]; v18 in preparation) calls tls_dev_del() and then
> > tls_dev_add() on a live socket, and the question arises through this
> > sequence:
> >
> >    1. A spurious RTO retransmit of old-key data is posted on SQ A.
> >    2. While that data remains unacknowledged, setsockopt(TLS_TX) starts
> >       rekey and installs the rekey validator, which stops admitting new
> >       plaintext to hardware offload. An ACK covering all remaining
> >       old-key data marks rekey ready before the driver observes the
> >       retransmit's SQ completion. A subsequent sendmsg() enters rekey
> >       completion.
> >    3. Rekey completion calls synchronize_net(), which waits for CPU
> >       transmit paths, not SQ completions, so a WQE on a stalled or
> >       backlogged SQ A can still be pending. mlx5e_ktls_del_tx() then
> >       releases the DEK and immediately calls pool_push(). DEK
> >       reclamation uses batched SYNC_CRYPTO; returning the TIS does not
> >       wait for synchronization covering its old DEK.
> >    4. Before re-adding the offload, TLS allocates the new SW-fallback
> >       AEAD. In that interval another connection's mlx5e_ktls_add_tx()
> >       can pop the returned TIS and use it on SQ B. The same socket can
> >       also reach SQ B on re-add: with the retransmit queue empty, TCP
> >       sets ooo_okay even while the retransmitted skb still holds
> >       sk_wmem_alloc, so queue selection may move the flow.
> >       mlx5e_ktls_handle_tx_skb() posts the new owner's initial
> >       parameters with skip_static_post=3Dfalse, fence_first_post=3Dfals=
e:
> >       static parameters unfenced, progress parameters fenced, then a
> >       fence NOP.
> >
>
> Your reading of the driver is accurate on all points. In particular,
> mlx5e_ktls_del_tx() returns the TIS to the pool with no completion
> tracking. The same goes for the DEK: the batched SYNC_CRYPTO guards
> against stale cached keys when a DEK object is reused, but nothing
> waits for pending WQEs before that, and without bulk DEK support the
> DEK is destroyed right away. So the DEK needs the same lifetime
> guarantee as the TIS.
>
> The same-socket exposure is also broader than the ooo_okay disjunct:
> the RTO and PLB rehash paths reset the dst, which clears the cached
> TX queue, and txq_reselection_ms lets a busy flow re-pick its queue
> periodically, both regardless of ooo_okay. So one connection's WQEs
> can be in flight on two SQs today, even without rekey.
>
> > An unobserved completion does not by itself mean the WQE still accesses
> > the TIS; that is the hardware ordering question. The same question
> > applies on SQ A: resync fences its first parameter update, initial
> > setup does not, and I do not know what either guarantees against
> > earlier WQEs that reference the TIS.
> >
>
> The fence modes in the WQE ctrl segment (FM field; the parameter WQEs
> use Initiator_Small_Fence) are all defined in terms of previous WQEs
> on the same SQ: a fenced WQE waits until earlier WQEs on that SQ are
> no longer in execution. Even the strongest mode (Strong_Ordering)
> orders only against previous WQEs of the same SQ. No fence mode, and
> no other WQE-level primitive, orders against outstanding work on
> another SQ.
>
> So within one SQ, the fenced first parameter WQE of a resync does
> guarantee that earlier WQEs referencing the TIS are done executing
> before the context is modified. The unfenced static parameters of the
> initial setup are safe only because, under the current lifetime
> contract, the previous owner's WQEs are known to be complete by the
> time the TIS leaves the pool. Across SQs, nothing is ordered.
>
> > The normal close path has additional ordering. tls_dev_del() runs
> > from work queued by tls_device_sk_destruct(), which itself runs from
> > __sk_free(), i.e. only once sk_wmem_alloc reaches zero. For
> > transmitted mlx5 skbs, SQ completion calls napi_consume_skb(), which
> > invokes tcp_wfree() to release that accounting, and parameter and DUMP
> > WQEs preceding a posted SEND on the same SQ are retired by that SEND's
> > completion. For successful transmissions, this gives close-time
> > ordering without an explicit drain in del_tx. WQEs posted without a
> > subsequent SEND, and SQ error/reset paths, need separate lifetime
> > guarantees. Live rekey does not wait for socket destruction.
> >
>
> Correct, including the completion detail: parameter and DUMP WQEs do
> not request CQEs of their own, so they are retired only when a later
> CQE-generating WQE on the same SQ completes. And you have a point
> about WQEs posted without a subsequent SEND: the error paths of
> mlx5e_ktls_handle_tx_skb(), and a DMA mapping failure of the SEND
> itself in mlx5e_sq_xmit_wqe(), drop the skb after parameter/DUMP WQEs
> were posted for it. Its wmem is then released while those WQEs are
> still pending. That is a narrow, pre-existing hole in the
> destruct-time argument, independent of rekey. SQ error/reset is
> covered: mlx5e_free_txqsq_descs() runs only once the SQ was moved out
> of RDY, when the hardware is done with it.
>
> > Was the recycling fence relying on this socket-lifetime ordering, or
> > does it independently protect against outstanding work on another SQ?
> > c4dfe704f53f ("net/mlx5e: kTLS, Recycle objects of device-offloaded
> > TLS TX connections") says the fence ensures context modification does
> > not interfere with existing traffic. Does that cover old SEND, DUMP
> > and parameter WQEs on another SQ, including work the device has not
> > yet executed?
> >
>
> It relies on the socket-lifetime ordering. The fence in c4dfe704f53f
> addresses the same-SQ pipelining: the new owner's data must not be
> transmitted before the context update has completed, and the update
> must not interfere with WQEs in execution on that SQ. It does not, and
> cannot, cover WQEs pending on another SQ; those were assumed complete
> by the destruct-time contract you describe, or stopped by the channel
> teardown. Live rekey via del+add breaks that assumption.
>
> > If reuse must wait, would retaining the TIS and DEK until all
> > referencing work has completed or been definitively stopped suffice,
> > including during SQ error/reset?
> >
>
> Yes, that is the right condition: every WQE referencing the TIS (or
> the DEK) has either completed - a CQE of a later WQE on the same SQ
> retires it, as the completions of an SQ are in order - or its SQ was
> moved out of RDY and its descriptors were reclaimed in
> mlx5e_free_txqsq_descs(), which covers the error/recovery and
> teardown paths.
>
> As for how to get there, here is what I have in mind, in three parts.
> Feedback is welcome on all of them, and in particular on the third,
> as it affects your series.
>
> 1. Pre-existing, independent of rekey: the stranded WQEs above.
>     Rather than adding completion tracking for the TIS, I'd restore the
>     socket-lifetime contract in the driver: an skb dropped after WQEs
>     were posted for it is not freed right away, but held by a NOP that
>     requests a completion, so that the skb and its wmem are released
>     only once all WQEs posted ahead of it are retired (or the SQ is
>     reset). mlx5e_ktls_del_tx() stays as is. I intend to send this as a
>     fix to net.

Agreed. Three spots for it: on SEND DMA failure, mlx5e_sq_xmit_wqe() and
mlx5e_sq_xmit_mpwqe() already post a NOP through mlx5e_tx_flush() but
free the skb first, so the skb should be held instead; that NOP asks for
a completion because mlx5e_notify_hw() sets MLX5_WQE_CTRL_CQ_UPDATE, not
mlx5e_post_nop(). mlx5e_ktls_handle_tx_skb()'s err_out needs the same
hold-NOP and a doorbell, since it can leave parameter/DUMP WQEs posted
without one. The MPWQE case is reachable too: when TX MPWQE is enabled,
mlx5e_sq_xmit_mpwqe() takes any linear, untagged, non-GSO skb with
inline mode NONE, which includes a pass-through skb that posted pending
parameters and took SKIP_NO_DATA, since it leaves with no TISN.

One correction to "SQ error/reset is covered": error-CQE recovery never
runs mlx5e_free_txqsq_descs(). mlx5e_tx_reporter_err_cqe_recover()
waits in mlx5e_wait_for_sq_flush() for cc to reach pc, then zeroes both
counters, so on success every WQE has been retired by an error CQE and
the held skb is released normally. If that wait times out, the SQ stays
in ERR with its queue stopped but NAPI still polling, so unretired skbs
stay held until a later completion or close. Timeout recovery is
different: mlx5e_safe_reopen_channels() closes the old SQs and reclaims
their descriptors in mlx5e_free_txqsq_descs(). In all of them the
hold-NOP from (1) eventually gets its skb released; whether the device
has stopped touching the TIS by then is the first question above.

A related recovery gap exists today without rekey: if a connection's
initial static parameters are flushed without executing, recovery does
not re-arm ctx_post_pending. A retransmit of the same record can also
skip static parameters, so software does not guarantee that the new
context gets installed. What does the hardware do with a SEND naming a
TIS whose static parameters never executed, recycled or freshly created?
The rekey contract below handles the corresponding replacement case;
initial setup may need the same treatment.

When do you expect to post (1)? I'll base the series on it and can
test on ConnectX-6 Dx before you post.

> 2. Pre-existing, and a dependency of rekey: TX queue stability. I'd
>     like to address the queue moves above in the stack, opt-in: a
>     driver whose TX offload keeps per-connection state updated by queue
>     execution declares it with a tlsdev_ops flag, and for sockets
>     offloaded to it, the TX queue is re-selected only once
>     sk_wmem_alloc has drained. That is, ooo_okay keeps only its wmem
>     condition, and while wmem is held, a dst reset does not clear the
>     cached queue and txq_reselection_ms does not expire it. With (1), a
>     drained wmem means that no work referencing the connection state is
>     pending on any SQ. txhash rethink and PLB still fire, and their
>     network-level repathing (e.g. the IPv6 flowlabel) is unaffected;
>     only the local queue switch waits until the driver drains. Other
>     drivers, and non-offloaded sockets, keep today's behavior.

Gating ooo_okay, the dst-reset queue clear and txq_reselection_ms
on wmem covers every path through sk_tx_queue_mapping. In mlx5e the
SQ can still change while that mapping stays put, or bypass it:

 - Channel replacement with tis_tir_td_order destroys the old
   channels only after the new ones are active (3b88a535a8e1).
   mlx5e_deactivate_txqsq() posts a final NOP, but nothing waits for
   its CQE, and mlx5e_poll_tx_cq() returns early once ENABLED is
   cleared. The deactivated SQ can still hold old-key WQEs (e.g.
   under PFC pause) while the same txq index already names the new
   SQ, so (3a)'s "same SQ as all old-key WQEs" holds only once the
   old SQ is destroyed, which is the DESTROY_SQ question above.
 - With num_tcs > 1, mlx5e_select_queue() adds a priority offset
   after netdev_pick_tx() (DSCP under MLX5_QPTS_TRUST_DSCP, else VLAN
   prio; HTB by skb->priority), so IP_TOS/IPV6_TCLASS or SO_PRIORITY
   changes move the SQ.
 - Egress skbedit queue_mapping bypasses ndo_select_queue(), and
   SKBEDIT_F_TXQ_SKBHASH can move a flow after a txhash rethink.
 - A queue-count change: netdev_pick_tx() ignores a cached index
   >=3D real_num_tx_queues whatever wmem says.

Separately, "a drained wmem means that no work referencing the
connection state is pending on any SQ" has a pre-existing hole:
netem with delay, jitter or rate calls skb_orphan_partial(), which
keeps skb->sk but swaps tcp_wfree for sock_efree, releasing the wmem
charge while the skb is parked. can_skb_orphan_partial() refuses
decrypted skbs and anything not owned through sock_wfree/tcp_wfree,
so two kinds of tcp_wfree skb get through:

 - plain TCP data queued before setsockopt(TLS_TX); at dequeue it
   ends before the start marker, and mlx5e_ktls_handle_tx_skb()
   posts the pending parameter WQEs naming the new TIS and takes
   the MLX5E_KTLS_SYNC_SKIP_NO_DATA path;
 - new-key ciphertext the SW context sent during rekey, an ordinary
   tcp_wfree skb not marked decrypted; dequeued after rekey
   completion, it passes through tls_validate_xmit_skb() on the
   device or on a bond master, and ends before the completion's
   marker.

The socket reference held by skb_set_owner_sk_safe() still delays
destruct, so your destruct-time argument in (1) is unaffected; only
the wmem gate in (2) can open early. Both orphan paths release the
charge, but (2) reads a drained charge as no outstanding work; the
partial orphan keeps the reference and drops the charge, so the two
come apart.

Both kinds of skb above can be handled in the driver alone: mlx5e can
skip the context WQEs for an skb with skb->destructor !=3D tcp_wfree (the
test tcp_gso_segment() already uses), which covers the pre-install
plaintext, whose orphan decision netem_enqueue() made before the socket
was offloaded, and the parked rekey ciphertext alike. Both already go
out as they are; the pending parameters just wait for the next skb. No
record data awaiting HW encryption reaches that path: a decrypted skb
is never partially orphaned, and a fully orphaned decrypted one is
dropped in validate_xmit_skb() before any driver sees it. Refusing
partial orphan in can_skb_orphan_partial() would also close the rekey
case, but needs a core-to-TLS hook and still misses the pre-install
one.

So (2) as proposed is a good stability hint, but not proof. I see
two ways to get correctness:

 i. Close the holes individually, without a new per-packet lock: the
    driver check above, keeping the priority offset and skbedit on
    the pinned queue for offloaded sockets, and, while kTLS TX
    connections are live, closing the old channels before the
    switch; mlx5e can tell that today only by subtracting tx_tls_del
    from tx_tls_ctx, so it needs a proper count. That last part
    gives back the downtime 3b88a535a8e1 saved, and still relies on
    your answer to the first question; (i) only moves that
    dependency earlier. It also spreads the invariant across the
    stack and the driver, and a future queue-selection path can
    silently break it.

ii. A driver-side owner check where WQEs are posted: priv_tx
    records its owner SQ as (txq index, generation) and the last WQE
    counter it posted there; a post on another SQ is admitted only
    once the owner's completions cover that counter or its
    generation is retired (by a completed DESTROY_SQ or recovery,
    if the first question above confirms that suffices), and is
    otherwise SW-encrypted with tls_encrypt_skb(), as chcr, nfp and
    funeth do. Completion progress stays per SQ, so this is not
    per-connection completion accounting, but it does need a
    per-connection lock on the kTLS xmit path, which is uncontended
    unless the flow moves. I'd measure it before posting.

I lean towards (ii) for robustness, with (2) as the hint that keeps
it off the slow path, but I'd rather hear your view on the hot-path
cost first.

> 3. Rekey. Releasing the TIS of a live connection to the pool, as
>     del+add does, requires that no old-key work is still pending, which
>     the driver cannot cheaply tell. I see two directions:
>
>     a. Keep the TIS, and replace the key in place through a new tlsdev
>        op (say, tls_dev_rekey()). With (2), the new parameters are
>        posted on the same SQ as all old-key WQEs, fenced, so they take
>        effect only after them, and the pool is not involved. The driver
>        keeps the replaced key until it is no longer in use. For that,
>        the op would be called only once all data sent with the current
>        key was acknowledged, which, as I understand it, your rekey
>        completion already waits for, and which is needed anyway, as the
>        device cannot retransmit old-key data after the switch.
>
>     b. Keep del+add, and have the TLS core call tls_dev_del() only once
>        sk_wmem_alloc has drained. With (1), that guarantees no pending
>        work references the TIS or the DEK. The cost is a potentially
>        long wait on a backlogged or paused queue, during which new data
>        is held back or sent in SW.
>
>     Tracking SEND completions per connection in the driver would also
>     work, but means per-packet accounting for a rare event.
>
>     I lean towards (a). Would it fit your series, or do you see reasons
>     to keep del+add?

(3a) fits, and I prefer it. sendmsg keeps sending SW ciphertext during
rekey, which holds wmem, so (3b) can wait indefinitely unless the
sender stalls. With this series, mlx5e is the only in-tree driver
accepting TLS 1.3 crypto_info, so the core can require the new op for
TX rekey and leave other devices in SW.

Proposed contract:

  int (*tls_dev_rekey)(struct net_device *netdev, struct sock *sk,
                       enum tls_offload_ctx_dir direction,
                       struct tls_crypto_info *crypto_info,
                       u32 start_offload_tcp_sn);

 - direction is kept for symmetry with tls_dev_add()/tls_dev_del();
   only TX uses it for now, RX stays on del+add.
 - Called from tls_device_complete_rekey() in process context, under
   tx_lock, the socket lock and device_offload_lock (read), where
   tls_dev_del() is called today. All old-key records are ACKed and
   synchronize_net() has drained in-progress transmissions; skbs
   still in a qdisc are revalidated at dequeue by the rekey
   validator. crypto_info carries the new key and the live record
   sequence; start_offload_tcp_sn is write_seq.
 - The core builds the new fallback AEAD before the call (today it
   is built between del and add) and commits it, with the record
   marker, before restoring the HW validator. Until then the driver
   sees no new offload plaintext.
 - The driver keeps the TIS, allocates the new DEK and does all
   sleeping firmware work first, then publishes key, expected
   sequence and pending parameters. The re-post covers both static
   and progress parameters, with the fence on the first WQE (unlike
   today's initial post, where the static params go out unfenced).
 - The old DEK is freed from process context once a successful
   CQE covers the fenced replacement, subject to your answer to the
   second question above.
 - Retirement of the SQ only proves the old work stopped, not that
   the replacement took effect. If the SQ errors or closes before
   a successful CQE covers the replacement, the driver forces a
   resync on the next offloaded skb regardless of expected_seq:
   fenced static and progress params for that skb's record, with
   the skip-static shortcut bypassed, and a DUMP of any record
   prefix before the SEND. A plain repost is not enough, since
   expected_seq has already advanced and the next skb can match
   it while starting mid-record.
 - On failure, the old context and key stay intact, nothing is
   posted, and traffic stays in SW until teardown or a later KeyUpdate.

If this direction works for you, I'll write mlx5e_ktls_rekey_tx()
and whichever (2) option you prefer on top of your fix, and test
them on the same hardware.

Thanks,
Rishikesh

>
> > I have not reproduced a failure; the reuse is visible in the driver,
> > but I have not established the hardware ordering guarantee. A PRM
> > reference, or a statement of which completion must precede reuse,
> > would settle it.
> >
>
> Thanks,
> Tariq
>
> > Thanks,
> > Rishikesh
> >
> > [1] https://lore.kernel.org/netdev/20260917224355.2288021-1-rjethwani@p=
urestorage.com/
>
