Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80936196A
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949483; cv=pass; b=dWeP/H0e2GFlc9wgtu+UOWZ1VvHnFghp6Sxu4CyMsnSNKRNmD5fBWS4AWtl7py7ks1BDfnO7rCc56hVkW7h8+Dcp1gxfI3tsEKMESpHyfuidinabK99yBLIg6HUzJGEFAEmBOv/bvIt6sR59Msg0hxWlxY6SrJPpcdAYnOlPZMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949483; c=relaxed/simple;
	bh=hEaMNJ9Xh7CC3r72jXWLy5D2DhPAfOAofizWpuMULBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sI1avF/dCgTq/gAmev954HR3gamVItIuBFyKF8uFXTGoSGdRaPvZKqBm949Mw4IsWwYyiupA35c/urw++Fq0zy+ckey2hSLbjxXbdzH7QR34KGPWdX+0iVi7dzBQTqzTxf1VX5xKnOtQVVFDS+GD15ZMoLh9lkIWnbHRPJN6K6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njk2AJCJ; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njk2AJCJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8487088510aso1705680b3a.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 10:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785949481; cv=none;
        d=google.com; s=arc-20260327;
        b=M4NjxWpLGdY1n0W3DjXeqhMX6op4dUkJkKKDo6GPqEBbbt4aEnp2gmoamKa7jRdViR
         yycKRnHo5zFmKcLRjZvJAoa4K3ALJvlpTZCVfS9kULyVCgm1Yr/Zf8XUzQMFS6LAapJS
         U47Gi52zjA+5dZWcSFrGJK3i2Gi9v8OgdQBfqOA6BzV3AVbK7N5xfxnUxuAhVYQLtkor
         6GXDhuWN0NYFC1SkgTGlj2wDgGuJdjIxSHiIzRwGIe9vu79CjRVtvKjf7Ys5zg3W5DhZ
         bDOOWKxzDOx8qUBbHq3nOavnJBe8AK/pjSs7cfuROSH/PIIsMm6YQWlFLiDRhMTc/o46
         l8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NJOvIGrSb5wJVdwnJ7v6vOCU6Ncw91UV9YASCJk36Pg=;
        fh=oLJUBoLeaCOIW1r707ZKh7+DNyVjyd8Nzfhd3TPyZMo=;
        b=m9psO/+Iqv/Q/AXkzbWhNHjUy8tGRSIKA9od6lTg0wNNSOlSokUA7sc4shnPpscLDY
         /1Y96vKyDiQ4warPvT3fJxK+oVcG0dFTW/XD06ISXRbxPe8xA4Fv9fQDzFPl8nQZYWmN
         56Isyn1ZwQC2O1IdqIVviDPMOWg7aYuJyIRPqqVd71cFQyG86T2ZRCpluY321ZF6DF9/
         wi0+/DrPqWkzpWrSsk2PVhuqK2Bp2/0Hr8/bJLx1xep0W/v0DVVIiKqFjWllYLzUwyfc
         BLjXYaIXSzz1Kf+K2CcKqFVbsqdkkDofLG1qow4R+kE+m0RS0Oujgyt+WtU34ReveR3B
         mjSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785949481; x=1786554281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NJOvIGrSb5wJVdwnJ7v6vOCU6Ncw91UV9YASCJk36Pg=;
        b=njk2AJCJuJxqNHpNWr+eKwBHwCojHx+PBKZlMUVZ7JO9hl/9fgcT32AExm6kilu47L
         DimNDAxI67Ou6rj2Dpmfl0bIENUEjuMjE1vXMg2K5UtBzUCUN0/0NmTTbDRVeJP+93Pb
         ODqrD6Byt2bfM2l1xkRCP9fXoSfQ/W2dKgAt77KlDZjNyZp7I0Q10Xc1zN0CY1Lw2RJq
         wQvjCB5ZoQMTkps1CfNJXAboNxf3m+F5GkyH7WbTOZoCXrXNrQiky8WvHXIpRPEC8avC
         RrHnDdb34jeG5WP4F0ZuUWO4wXVGpw6XfpKiFd2viE7t2BKM6lKJflMtnUKYCWozbrlf
         8F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785949481; x=1786554281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NJOvIGrSb5wJVdwnJ7v6vOCU6Ncw91UV9YASCJk36Pg=;
        b=fkqYJBrwXNUMk+TH0ncxxzh5RnwWkY8+SejmRWuAQsq2nl0WFracvgpl6nRaSIJi4Q
         AOGEwUQtYCG0fkRRhjubhy97leu4mzY/42ueIfhajeo0BuHswX/BbcDXLddMXoD75OFk
         9nIMJQaiY61azSimFdoOndAQd8W2B5louQu+3dmyertnXDplyjJfCml2aQjKqH7/CSOc
         2mU5oXtWy2/j9roXx5g17f9bjO+4XLrVr60YamKv1uIwqa4kBobCK1Rkc5o7PfrMhlHR
         gvMhKtQW1ewWzFqYNlHlDYz/Vv0CrAkLIhINkZxSZBQkciOuVzVPT6CaQNiV6qb9ATKs
         HE2A==
X-Gm-Message-State: AOJu0Yx1AvrSU6Y2NM15A4xOnqOOkysmfWfrD9TP7mNvd4FYfGAO19o4
	vrGvxHYbRa8Az3Lc9rV7+62aTwnQrqQ05LwIgv/eWmizG3KDVEaxJhhX2Gve1R4M+Z9y6qIQReL
	yh7M/XJy9AunERSdfPkZpIKaIS502gLk=
X-Gm-Gg: AR+sD10J7tLI8MaoxRzT6y2o5Po+waI2chLQP8EkZynbRbztSkgvHXuwH9tZj1Ab+Cd
	lBnfWqYTWuTuv9DGJiY27FOTJkukIens5xlOkUSRnqAHN0xgfNJNfejRy0eVvfdCYaQ0rc/X1aN
	WUkjGeU+adcNn0PxowJ9stdiqMVOWERqWtjjw/VKangKY1cKXVA5PAWu5jrDXj9MwJvvDYdkhb0
	9gEg2HUsM3utFo0iApknOLJ2c5hwBpvAGvmzdMzluMAtp8Xknt5Ls2O1cxBsTQ5XbxJLuz8KB5J
	NqLSyl2r0Bx64xbZSYdHlBkBlrjvbVjVlzeDM+rHtdGuYUz4idLxI67V2D8kPV0hACd7c/ndaBE
	FjnQR1TVHY/5fXPqJCkNndv8gDFxAw+F4x4YxqThx0L3/E1V+ouAA5pEZN/RBfmorS5/T3BWp3o
	7s
X-Received: by 2002:a05:6a00:4b48:b0:847:8910:ad76 with SMTP id
 d2e1a72fcca58-84f2e12cd46mr8895774b3a.37.1785949481124; Wed, 05 Aug 2026
 10:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804113705.45754-1-juny24602@gmail.com>
In-Reply-To: <20260804113705.45754-1-juny24602@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 5 Aug 2026 13:04:29 -0400
X-Gm-Features: AUfX_mxtust7OUQLeeLV0KcfKTIV_UXzI2qx_uHcr75hmLv6Y6k_XrpQkenvoBk
Message-ID: <CADvbK_fUdKDT11-H44yhKxv8_hgToRUnjggjm71HbFZ5A+HeeQ@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: re-point retained control chunks on
 association migration
To: Jun Yang <juny24602@gmail.com>
Cc: netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>, stable@kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 7:37=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrote=
:
>
> From: Jun Yang <junvyyang@tencent.com>
>
> sctp_control_set_owner_w() records the owning socket in a control chunk's
> skb->sk.  sctp_sock_migrate() re-owns the association's DATA chunks via
> sctp_for_each_tx_datachunk(), but that walk keys off chunk->msg and so
> skips control chunks: any control chunk the association still holds (for
> example the saved stream-reset request asoc->strreset_chunk, the ASCONF
> request/ack lists, or asoc->addip_last_asconf) keeps pointing at the old
> socket after the association is moved to the new one.
>
> Once the old socket is freed, a later retransmit reaches
> sctp_packet_transmit() -> skb_set_owner_w(head, chunk->skb->sk) and
> operates on the freed socket -- refcount_add() on its sk_wmem_alloc,
> then sk->sk_write_space() from sock_wfree() -- a use-after-free of
> struct sock.
>
> Rename sctp_for_each_tx_datachunk() to sctp_for_each_tx_chunk() and walk
> the control chunks the association retains there as well, so migration
> re-owns them with the same clear/set bracketing already used for DATA
> chunks.  sctp_set_owner_w_migrate() picks the right owner helper by
> testing chunk->msg, which is NULL for control chunks.
>
> The per-chunk owner test that traverse_and_process() already applies is
> split out into sctp_process_tx_chunk() and reused for the control lists.
> A chunk can sit on two of them at once -- asoc->strreset_chunk and
> asoc->addip_last_asconf both stay queued on outqueue.control_chunk_list
> until they are flushed -- and the test keeps such a chunk from being
> cleared or re-owned twice, which would otherwise leak an shkey reference.
>
> sctp_control_set_owner_w() re-reads chunk->shkey from asoc->shkey, so
> sctp_set_owner_w_migrate() releases the reference sctp_clear_owner_w()
> took by value instead of re-reading chunk->shkey, which would drop the
> wrong key if the active key changed while the chunk was queued.
>
> Fixes: d04adf1b3551 ("sctp: reset owner sk for data chunks on out queues =
when migrating a sock")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:kimi-k3
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> This is based on David Lee's
>
>   [PATCH] sctp: hold shkey across socket migration
>   https://lore.kernel.org/netdev/20260731120558.558957-1-david.lee@trailo=
fbits.com/
>
> which adds sctp_set_owner_w_migrate()
>
> v2:
>  - Rename sctp_for_each_tx_datachunk() to sctp_for_each_tx_chunk() and
>    move the control-chunk traversal into it, rather than adding a
>    separate sctp_for_each_tx_ctrlchunk() helper (Xin Long).
>  - Handle control chunks in sctp_set_owner_w_migrate() by testing
>    chunk->msg, dropping the sctp_ctrl_set_owner_w() helper (Xin Long).
>    Control chunks now go through the full clear/set bracketing instead of
>    a bare skb->sk store, so sctp_control_set_owner_w() is no longer
>    static.
>  - Factor the existing owner test out of traverse_and_process() into
>    sctp_process_tx_chunk() so the control lists get it too.
>
> v1: https://lore.kernel.org/netdev/20260730090537.27629-1-juny24602@gmail=
.com/
>
>  include/net/sctp/sm.h    |  1 +
>  net/sctp/sm_make_chunk.c |  2 +-
>  net/sctp/socket.c        | 53 ++++++++++++++++++++++++++++++----------
>  3 files changed, 42 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/sctp/sm.h b/include/net/sctp/sm.h
> index 3bfd261a53cc..76605d1ee839 100644
> --- a/include/net/sctp/sm.h
> +++ b/include/net/sctp/sm.h
> @@ -252,6 +252,7 @@ struct sctp_chunk *sctp_make_fwdtsn(const struct sctp=
_association *asoc,
>                                     struct sctp_fwdtsn_skip *skiplist);
>  struct sctp_chunk *sctp_make_auth(const struct sctp_association *asoc,
>                                   __u16 key_id);
> +void sctp_control_set_owner_w(struct sctp_chunk *chunk);
>  struct sctp_chunk *sctp_make_strreset_req(const struct sctp_association =
*asoc,
>                                           __u16 stream_num, __be16 *strea=
m_list,
>                                           bool out, bool in);
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 0ae30c3c8913..7684686798cf 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -94,7 +94,7 @@ static void sctp_control_release_owner(struct sk_buff *=
skb)
>         }
>  }
>
> -static void sctp_control_set_owner_w(struct sctp_chunk *chunk)
> +void sctp_control_set_owner_w(struct sctp_chunk *chunk)
>  {
>         struct sctp_association *asoc =3D chunk->asoc;
>         struct sk_buff *skb =3D chunk->skb;
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 4a08023d52aa..d09b9f139070 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -155,9 +155,24 @@ static void sctp_clear_owner_w(struct sctp_chunk *ch=
unk)
>
>  static void sctp_set_owner_w_migrate(struct sctp_chunk *chunk)
>  {
> -       sctp_set_owner_w(chunk);
> -       if (chunk->shkey)
> -               sctp_auth_shkey_release(chunk->shkey);
> +       struct sctp_shared_key *shkey =3D chunk->shkey;
> +
> +       if (chunk->msg)
> +               sctp_set_owner_w(chunk);
> +       else
> +               sctp_control_set_owner_w(chunk);
> +
> +       if (shkey)
> +               sctp_auth_shkey_release(shkey);
> +}
> +
> +static void sctp_process_tx_chunk(struct sctp_association *asoc,
> +                                 struct sctp_chunk *chunk, bool clear,
> +                                 void (*cb)(struct sctp_chunk *))
> +{
> +       if ((clear && asoc->base.sk =3D=3D chunk->skb->sk) ||
> +           (!clear && asoc->base.sk !=3D chunk->skb->sk))
> +               cb(chunk);
>  }
>
>  #define traverse_and_process() \
> @@ -165,17 +180,14 @@ do {                              \
>         msg =3D chunk->msg;       \
>         if (msg =3D=3D prev_msg)    \
>                 continue;       \
> -       list_for_each_entry(c, &msg->chunks, frag_list) {       \
> -               if ((clear && asoc->base.sk =3D=3D c->skb->sk) ||   \
> -                   (!clear && asoc->base.sk !=3D c->skb->sk))    \
> -                       cb(c);  \
> -       }                       \
> +       list_for_each_entry(c, &msg->chunks, frag_list) \
> +               sctp_process_tx_chunk(asoc, c, clear, cb);      \
>         prev_msg =3D msg;         \
>  } while (0)
>
> -static void sctp_for_each_tx_datachunk(struct sctp_association *asoc,
> -                                      bool clear,
> -                                      void (*cb)(struct sctp_chunk *))
> +static void sctp_for_each_tx_chunk(struct sctp_association *asoc,
> +                                  bool clear,
> +                                  void (*cb)(struct sctp_chunk *))
>
>  {
>         struct sctp_datamsg *msg, *prev_msg =3D NULL;
> @@ -198,6 +210,21 @@ static void sctp_for_each_tx_datachunk(struct sctp_a=
ssociation *asoc,
>
>         list_for_each_entry(chunk, &q->out_chunk_list, list)
>                 traverse_and_process();
> +
> +       list_for_each_entry(chunk, &q->control_chunk_list, list)
> +               sctp_process_tx_chunk(asoc, chunk, clear, cb);
> +
> +       list_for_each_entry(chunk, &asoc->asconf_ack_list, transmitted_li=
st)
> +               sctp_process_tx_chunk(asoc, chunk, clear, cb);
> +
> +       list_for_each_entry(chunk, &asoc->addip_chunk_list, list)
> +               sctp_process_tx_chunk(asoc, chunk, clear, cb);
> +
> +       if (asoc->strreset_chunk)
> +               sctp_process_tx_chunk(asoc, asoc->strreset_chunk, clear, =
cb);
> +
> +       if (asoc->addip_last_asconf)
> +               sctp_process_tx_chunk(asoc, asoc->addip_last_asconf, clea=
r, cb);
>  }
You can just use cb(...) here, no need to extract sctp_process_tx_chunk().

These checks of clear and asoc->base.sk were introduced by:

5c3e82fe1596 ("sctp: fix refcount bug in sctp_wfree")

The issue only existed on DATA chunks.

Also, please hold this patch until upstream applies the dependence:

https://lore.kernel.org/netdev/20260731120558.558957-1-david.lee@trailofbit=
s.com/

Otherwise, your patch will fail on these sashiko reviews as "Failed To Appl=
y".

Thanks.

>
>  static void sctp_for_each_rx_skb(struct sctp_association *asoc, struct s=
ock *sk,
> @@ -9640,9 +9667,9 @@ static int sctp_sock_migrate(struct sock *oldsk, st=
ruct sock *newsk,
>          * paths won't try to lock it and then oldsk.
>          */
>         lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
> -       sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
> +       sctp_for_each_tx_chunk(assoc, true, sctp_clear_owner_w);
>         sctp_assoc_migrate(assoc, newsk);
> -       sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w_migrate=
);
> +       sctp_for_each_tx_chunk(assoc, false, sctp_set_owner_w_migrate);
>
>         /* If the association on the newsk is already closed before accep=
t()
>          * is called, set RCV_SHUTDOWN flag.
> --
> 2.55.0
>
