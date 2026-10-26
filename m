Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793050795;
	b=XzkISXLasPVB9W1Tu1+OtWIrH6k18Brm1yry8j+rarylparAgIPgbzSi13/NVzCv3477
	 BLTz1IJuIT4a5NJSLo8BfC8+d/VSZMoM8sJZGdZla87eVzNDR923+fpcy/J5y1oo6eiGp
	 zR2KaYqBrw4i5fKcXGEgcQd55Yfmh8ZnshOFG3FE5A5ybpyJFpXIuUPEjARdjHAT7Kps0
	 nNv9Xer/Mpdi0rGlbkqRYK530EosuWbCRkzp81l5vmh/2l1mXnD4Kq+DtDkgRVYVxt1B9
	 TrmkYNUH85ctF5UEQSukWyaS7sghgxt5jNvuOVVFtiCOqqzDFbcTWyFJINhnCHq9wXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xSeNS65qus3GCZvtaI28SVIcrlO1tnD2OBxNeWc37ko=;
	b=xHu00yRxgQCta4TrPUtLeGxUqg6wsHvRbWhbCVGec8rQqkh9A1dJo+5FMwKhPemrxS7F
	 O+mEDqeXhYMJZn4VYEK42J+4p5K7u7mvtqZN6a4MRRPc8IIZtCTKyVUD9nQJOCbwGv/PQ
	 xjQC6QFA7iII3wKw0D87FYPFN5tcbK7ZeUqgysxLiQ9CLaMC8py0NfqMfoiq+FrerwDoR
	 zhhXnXmSRf09vlVNRtzUp62+NgiZG1tJAuZmPIaRLq5jRoJwD6e7uIixvSheOEC3IQHo0
	 Ya6r6yOItYQ16+6tloPj5/uMaSTQNoxVS5sxdJkHlVHjNf+dNhw7xlOLg9Ur2VxKoLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AkhoyGEF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45A606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C45A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AkhoyGEF
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a20d7a8984so4995e9.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793050793; cv=none;
        d=google.com; s=arc-20260327;
        b=YJpAY+BKQKMElT6HBsJ0V083Bv7H787AJxd84px78h2wB34ikMa2S7cGC1ThZCKxHj
         kfmTOERMElSnsr1B5anDnadA7YEQl522DTz/aHdy5v3fWcTlgASHnF8+Q56tlhcI4QTf
         rC0jzRlvl2ynglY2xgDCQMCuYA3P3jkYDanta7lAE1GOEVxFWJk1AhwhVXAnZ157xOt2
         jxxENTXRX/g4lyZXSWbQGK9BFbma7SEvCRYrj40b/1+D704+4QB/j5mYAUmqaHte6Nn4
         oCz0paDICnmgEBK0PdZIgBbCjF8gHlB5Q0+qnKEzPEZCZrxPaF0N/3RdYckSlrmReW1D
         Q8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xSeNS65qus3GCZvtaI28SVIcrlO1tnD2OBxNeWc37ko=;
        fh=mnE5kYmZqdUV4zNDHDENGdm/TJtx/OaB2i4XVGnTV5I=;
        b=TsmRYTvRil1BkYtC/UeLABSygEa1vhctN+xW83hySFbaKlvDwApPlg/VI78oq4e4BB
         O046UJp7jiWP6vma09SI4JE8ELkagfWDsqAm3PYjbehcUGhUp/vwWcIR5NxYVnv9C1Xl
         51wbpvppKE1wH2BxNt71KQOvP0oV70hgBL8zuuAnwRTDHCr1e1W3D6RuxovOlXRlTqQo
         3/EE/m69m9W4A7jFsOYyKIZdE8/hs7fkwrk3R8Cygh8qFxCRqxQGjzapC5Q+GAsotxSj
         bMJjMJrtRcQak1V+yTmMavE7aFdk5ctCl0Cnnjoeyd+FgmP2vZjCEH3AiORSRFeJHgf4
         A21w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793050793; x=1793655593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xSeNS65qus3GCZvtaI28SVIcrlO1tnD2OBxNeWc37ko=;
        b=AkhoyGEFiwKTk6zjNVHjA9wc5L29B3d4uC+l6tR9TiHokqM1l9x8YloeaTQoe+TL/y
         kwrsnlTSWVWicofnjo1Fm/ovL230erCkc4hJPiVRmMgtcWfncEiEODc0wW4mO+of6zE/
         cV7Nott2DlVcEZ47FiHNXWsiR6L5Cu4yUMpYwLG05dgCQPlYWeypQH2VTwSBCXBW6n8e
         heMl81P3WDEMbow1b+7JrTri8EkvGFqPPDdN7kn8PvrPy0+LJ+1ONuk3POd7oIwnfmyJ
         +ObSPx2K2cjbtJO7LQ8gtI6EBGTxAaMbKtqGJKv5RhoGVvGgEIxHhM2f0JSmHvrZWUF9
         HlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793050793; x=1793655593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xSeNS65qus3GCZvtaI28SVIcrlO1tnD2OBxNeWc37ko=;
        b=r8mU9Xpn8GOCeV4cKkgYLIF2/evPMLfaO2hfEHURYs7ShnCYGdehD6NJfkoP6ZWpAZ
         smxqwwzPdJU3NpoK2lV155lsqypw1r/dtZnjL5M6U8WPmS/qtsKvjf/q+ZSXhaTuMTIh
         k6ly+cqKBRXqWUaOS/nAqB5tyrOzTtj/8LdHPUYx4fBm5EXtot92BS6uPTSI656Z6r2o
         qLOeTtYmK6wHwGosE2cvqShdFwcRBFrIxYsaiuftlRxj0tNXT1w3nZLTJlR2blZa4ghc
         xHpEAmSCqyJWr4jb/Q5g5bfH1ILxxAE188KMzvledHaPue/MjsTPjz3PFbOrp644CJ3e
         Xz2A==
X-Forwarded-Encrypted: i=1; AKwUvBzb52KtkrKLDLnoO2vayOa690nCO37+78fzIbRAGVvkJUvmldYqyjM0ldsMX5BdqNsiS+rkY7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKP3AW8XPA+G/HdiHIWfTPujzC1Stkm5CSx5PWO99aZlHfxDx1Q
	7LRdF+h/Az414E7KpC1cbSR0DiPn0XPPCJElT1tYJggjJDO71EDw9iz7owILVciunurr6Zc/vCH
	FEWYcrvnZ5dL3wxS99nkcRtrtXBtMDiSxOsLPNwd8
X-Gm-Gg: AYBFou1zM/2aI55LwyJUzjGd7Sh4fvllAO0Ts29gOZ8aOmJgzVD0GHG914eGk/bqHiw
	IVmcaSbxOTWrzypelvI2iwBKbi7f08rGwlE5Yu478FnUFxAPWv+0bnXmAY/oJU3TRSkyNH4u60S
	gk5NK/agncudU3RgTGmfdmFzJ0I03/6SUAjItyuestX7HugmeRhZeq1+Qka6v14IKaP+epNXS1m
	5e8ezvcUPG8MpuVENFE3DHNbmedp1hl5sP6jlRpIFpsH/S35goWQcOho1AQYddr8vDqa9T1+dTd
	6CLj3ohNSTS2i53f95bHRzTDA44yp2mSPKaZsN0MlV7KEqkamI610ckAgBPTkotmacamMKlAzy1
	JYM9qMQHgZ4Gir4GQMOdVaGIG9jd4tWbUabZhDhic3ibnHkAzZwH8+TgxkYaaZ/91L9U=
X-Received: by 2002:a05:600c:6385:b0:4a2:1053:8854 with SMTP id
 5b1f17b1804b1-4a7fa6d7103mr133845e9.7.1793050793074; Mon, 26 Oct 2026
 14:39:53 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024030401.852598-1-almasrymina@google.com> <179289749460.3134.17105687099040790537@kernel.org>
In-Reply-To: <179289749460.3134.17105687099040790537@kernel.org>
From: Naman Gulati <namangulati@google.com>
Date: Mon, 26 Oct 2026 14:39:40 -0700
X-Gm-Features: AclHuK-532-QF-vwACr9a_MraviT-0vIBoDHd00aDqRCqW9_XeV6vsyv8HKpu8M
Message-ID: <CAMP57yUindVWCLV4O=Qki61VmZ2y8hjMPVJ51UnODz3D0LKwXw@mail.gmail.com>
Subject: Re: [PATCH net] idpf: free the skb on TX DMA mapping errors
To: netdev-bot+sashiko@kernel.org
Cc: almasrymina@google.com, aleksander.lobakin@intel.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 8:04=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix leaves the skb leak in place for HW-timestamped packets,
>   and the Tx timestamp latch they hold is also never released.

Both issues are pre-existing. This patch does not introduce any leaks
and these should handled separately in the tx tstamp and FLOW_SCH_EN
code paths.

>
> Pre-existing issues:
> - [Medium] This bug was not introduced by this patch, but in FLOW_SCH_EN
>   mode idpf_tx_splitq_frame() increments=E2=80=A6
>
> --
>
> idpf: free the skb on TX DMA mapping errors
>
> This commit frees the skb at the end of the TX DMA mapping error unwind
> in idpf_tx_splitq_pkt_err_unmap() and idpf_tx_singleq_dma_map_error().
> At that point the first buffer is not yet typed LIBETH_SQE_SKB, so
> libeth_tx_complete() only unmaps it, and before this change the skb
> leaked.
>
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/=
ethernet/intel/idpf/idpf_txrx.c
> > index 885df6294ad94..a92e2457781e6 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -2606,6 +2606,7 @@ static void idpf_tx_splitq_pkt_err_unmap(struct i=
dpf_tx_queue *txq,
> >       struct idpf_sw_queue *refillq =3D txq->refillq;
> >       struct libeth_sq_napi_stats ss =3D { };
> >       struct idpf_tx_buf *tx_buf =3D first;
> > +     struct sk_buff *skb =3D first->skb;
> >       struct libeth_cq_pp cp =3D {
> >               .dev    =3D txq->dev,
> >               .ss     =3D &ss,
> > @@ -2621,6 +2622,8 @@ static void idpf_tx_splitq_pkt_err_unmap(struct i=
dpf_tx_queue *txq,
> >               libeth_tx_complete(tx_buf, &cp);
> >       }
> >
> > +     dev_kfree_skb_any(skb);
>
> [Severity: High]
> Does this still leak the skb for packets that asked for a HW Tx
> timestamp?
>
> idpf_tx_splitq_frame() reserves a timestamp latch before it maps the
> packet:
>
> idpf_tx_splitq_frame() {
>     ...
>         idx =3D idpf_tx_tstamp(tx_q, skb, &tx_params.offload);
>         if (idx !=3D -1) {
>                 ctx_desc =3D idpf_tx_splitq_get_ctx_desc(tx_q);
>                 idpf_tx_set_tstamp_desc(ctx_desc, idx);
>         }
>     ...
>         idpf_tx_splitq_map(tx_q, &tx_params, first);
> }
>
> idpf_tx_tstamp()->idpf_ptp_request_ts() then takes a second reference
> on the skb and moves the latch to latches_in_use:
>
> idpf_ptp_request_ts() {
>     ...
>         ptp_tx_tstamp->skb =3D skb_get(skb);
>         skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
>
>         /* Move the element to the used latches list */
>         list_add(&ptp_tx_tstamp->list_member,
>                  &tx_q->cached_tstamp_caps->latches_in_use);
>     ...
> }
>
> idpf_tx_splitq_map() can then fail in two ways: dma_mapping_error(),
> or idpf_tx_get_free_buf_id() failing between fragments in FLOW_SCH_EN
> mode. In either case this dev_kfree_skb_any() drops only the xmit
> reference. The tail is rewound to params->prev_ntu, so the hardware
> never fetches the TSYN context descriptor.
>
> Normally a latch is retired only through the completion path.
> idpf_tx_clean_bufs() sees a LIBETH_SQE_SKB buffer with
> SKBTX_IN_PROGRESS set and calls idpf_tx_read_tstamp(). After that,
> idpf_ptp_get_tx_tstamp() asks firmware about latches in the
> IDPF_PTP_REQUEST state.
>
> A packet that went through this unwind never reaches that path. The
> only other cleanup is idpf_ptp_release_vport_tstamp() at vport
> teardown.
>
> Wouldn't the skb then stay pinned until teardown, along with the socket
> wmem charged to it, and one hardware latch per failure? Once every latch
> is used up this way, it looks like all later HW Tx timestamp requests
> would fail with -ENOBUFS until the vport is torn down.
>
> The refillq exhaustion drop path in idpf_tx_splitq_frame() also runs
> after the latch has been reserved. It seems to be missing the same
> rollback:
>
>         if (unlikely(!idpf_tx_get_free_buf_id(tx_q->refillq,
>                                               &buf_id))) {
>                 ...
>                 tx_q->next_to_use =3D tx_params.prev_ntu;
>                 return idpf_tx_drop_skb(tx_q, skb);
>         }
>
> Should the unwind also move the latch back to latches_free, clear
> SKBTX_IN_PROGRESS, and drop the latch's skb reference?
>
> > +
> >       /* Update tail in case netdev_xmit_more was previously true. */
> >       idpf_tx_buf_hw_update(txq, params->prev_ntu, false);
>
> [Severity: Medium]
> This is a pre-existing issue that was not introduced by this patch, but
> does this unwind leave num_completions_pending too high?
>
> In FLOW_SCH_EN mode, idpf_tx_splitq_frame() increments the counter and
> sets last_re before calling idpf_tx_splitq_map():
>
>         if (idpf_tx_splitq_need_re(tx_q)) {
>                 tx_params.eop_cmd |=3D IDPF_TXD_FLEX_FLOW_CMD_RE;
>                 tx_q->txq_grp->num_completions_pending++;
>                 tx_q->last_re =3D tx_q->next_to_use;
>         }
>
> When mapping fails, the tail is rewound to prev_ntu. The RE descriptor
> is never posted, so its completion never arrives. This unwind restores
> neither num_completions_pending nor last_re.
>
> When a context descriptor was used, the stale last_re can also make
> idpf_tx_splitq_need_re() return true again for the retried packet.
>
> Once IDPF_TX_COMPLQ_PENDING() exceeds IDPF_TX_COMPLQ_OVERFLOW_THRESH(),
> idpf_txq_has_room() returns 0:
>
>         if (IDPF_DESC_UNUSED(tx_q) < descs_needed ||
>             IDPF_TX_COMPLQ_PENDING(tx_q->txq_grp) >
>                 IDPF_TX_COMPLQ_OVERFLOW_THRESH(tx_q->txq_grp->complq) ||
>         ...
>
> idpf_tx_clean_complq() also sets complq_ok =3D false, so the queue is
> never woken.
>
> Could enough of these failures stall the Tx queue until the tx timeout
> reset reinitializes the counter?
>
> >
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261024030401.852598-1-almasrymina%40google.com
