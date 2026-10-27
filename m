Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123538;
	b=4lbBi56E7hMyBy4lnIKrRGriupEVC2Q/uJm29tkMnjdRqly+SUEm/YCDfsXBNd/gvea9
	 NdWJ4ouwNT1JvehXOOYet8SG8Rc3Unz/Nt3BPmvYZzbHw89zzhtLeTzQBf7wtwGNW7prG
	 C3MSQ/SuTn1oLaN7zzxtNJdNrSTm/2vX0FhKCZxv/SD2anIBR1c4wvDF2tJ/qe9EckLbx
	 ctTmcZDHXBN8E7AlyGN6wXMD+Uf2A7lY7bmi2bPo22ykxjhim7qdTphi1XN0PIyajIqSH
	 Rvl2EZq7fSUIqzpDm9cFD15sapv49cASK74+yGUfMOEHzpdDy0/T7p9mVCBR40qhTJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dL6uZz+6KxUJ8TWcCx6uTDraYfTXerakpqTM1EVitpE=;
	b=oPuSJczGfXEtM3Ka78Xc67qIlhh/Jrp37buqzj29SJoL722CGmrsQ7ZU7YPAMcDrFAxy
	 Bocn5BFKPBS3EU1ZFBfG40VGeUuIRwUOPU2+Evo5PnnR8pOPxaPq0qvh84IKE8Jh75ESj
	 XxvPd5v8nDWtc5fIwOWW1zHotgumBoTGH1XoRCOXc5nu39enS/FPxujLeT12j88SB08gR
	 UqfDc8nR/bo1iI4L7urGeULunE2vTFTKLDxNAV7YICKVQ/IQtKZmjjZrD+Na1B2AG6phU
	 s0wJTSXbjGuZGEPE4VETtadF2zRB2JBKXHWwl2sJbm5e8oKN1NFHKl19PJw8gZ146yA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=hXAvjJSE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ECF606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 17:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09ECF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=hXAvjJSE
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cc7938c5e9so509160137.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123537; cv=none;
        d=google.com; s=arc-20260327;
        b=cRZis+g6OkNpEkSvzncDDl46QV/FOmzMZ6q21zj6oT20anXqqfrZpG/CBGR9tESNUS
         zHdtqfB3e3/KWw5T7B5MZGXVvo3QGzAWitULAz3Ee2ndoKHKCuS2PfED5YUSDPDK5JzI
         +M604l5j6mmPV8e9t1bexWfqcw2tu4xkipMFhIoP5r2uZCrejIO8HZRYXLC5WDiidF/D
         jHFu8VdZQOs1aYPaiXs/mpIg10Ei5ptdf6VEusOIxc0rW3WoU4tnFV5BK86gs+ZEdLoi
         IAxBfwf1elEo8TsrJWZCUlWbv+OD9wRz98cu4XDh08hWSrN3ei8Nf1Qzz/AfQwc1PmB9
         e3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dL6uZz+6KxUJ8TWcCx6uTDraYfTXerakpqTM1EVitpE=;
        fh=MLzqdvxE1aPaRq3rsT6+f+kiP4t2/pNBPFS9WiP2Bm4=;
        b=eZfKK5Fn8fFwXJFMMfu62Lukke4h1iSYUjs2pYYtPisBvlEuvV3KXDU3wHAv+hfNo8
         RBvgkvum4nhHNTo/mVvgpSJy5u4LOTfK6FGfisPCR6CON+H35XIYf1RATSPawUli7M7f
         bpFD00sQAS4DPHYgee8AB2dlgL2jOLuMCGQWl1f9T9uzAYqlVJB+CzJQKao83AQnrEZE
         g0oQAJdIzOeL+QOuX8LmhgwrlgMKGhQsMDaMOPuAxB4NOjDV0WQK1cVG9HCA2j/IRSHa
         pkaRD49ptMJ/J6+oGWukU7ffLfbSTEePSwsM6Z3bN3v/swVOjOtnQ1wyk1RIsmlp70B8
         PpSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793123537; x=1793728337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dL6uZz+6KxUJ8TWcCx6uTDraYfTXerakpqTM1EVitpE=;
        b=hXAvjJSEr7HjYx4k4O41ydVChEjfzjawuvXoD2xLNZ7agCCpqkPmH/Q/AroyJe/rda
         aab6k55jLnuxMzWvrz70dJcxls9LgOAkWQZF4VkvEQNRC/MIV32V+E3rGDGS1DChRN6A
         e0fSGLDRf4NZ2iOTNgiDPZF6XWKEc7j4FaNDC7LGZl5D1RiVis9PoAm30qrSW+Krs4OE
         ArVTq7BchWA/SqD1EQUXrgnDirn79BzAep2a4GCXuhoWhnf+dEoVAzMk8ml8oEw/48Mi
         7MfAo0KyIbOtgGw960dDvi6MD0u3RQuGF7R0ZjTSYbWiTPCmfVDJ4EK8XcwFfJJ2Vkma
         b10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123537; x=1793728337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dL6uZz+6KxUJ8TWcCx6uTDraYfTXerakpqTM1EVitpE=;
        b=Cde2otonsCTI87rNQ67VrL0Yz+MikCkQD2PwWDA6BbBrTGKoSil2vl7YXrBoWutJ3n
         eMSfcE9pIE339kLdPwBTdgH5ovcueMilwGPekx4nNaRc9kGr6jnuG+uveNLNGd3xCtE5
         GejwK6qj4ch/m7TAl1uSw7YEvr+BsRrZB/DnfNtD+2ZBs6gYF/zWXXZeZuqjCVa3VFd8
         OpPqh4WHE8ZEQnrFteZyDwrZ2vDMc3kUgWO1XQvDgD6UtuewGfOMZ6SRMkaGbeiO3qaB
         +qW6UC8PaCBY9YG7crVi09G8PWQ9HM1SKOgNBvCjy3M8Bk7rmM33yIye+bjcihH0slTY
         noUw==
X-Gm-Message-State: AFq9FYKcs9eWPFABPyQ3BLppo0iXPRSljWufmv3+0N36OKTkWG02C2CH
	h7mKghbNk3vVeUHrRfFaUs404OkKYdCfdoKjs6bi4Z4K4B3Y/xwROJxz7FyH9ZZAOLUWqv9JKZI
	TrVHkMVb3+5EUoOPIk0oEw7tA+v4maDlVOPKliKfhYuP5hDSy/cE/kU+uVw==
X-Gm-Gg: AYBFou0VUX1qh48F7p27xTS821ryU+NP5wdaJpoLczy10Bv743dUE8WkwUZQ5+rk8Cw
	q8QfpnzXxpPsvQNCxmcYr/qnTfjyShX4/HFxUl0VgoqfbshA9ZmCQgWkJsqZgf3PuUs+JwJ9lpK
	iCuLE9EAzel7GoqvBDTJwpECpDhuxH6ysJFVrbJ3YKyfdA2CLXzHPu8i1ovQSJI00MmEfJ3sxFP
	mFUzIG/B6ZVsWH2szCv+YTj0HLqU45XSlqoeaVDbywaociHYwUp68snpVwLyLT3VOJ36oF5ARwF
	iSosX5UPLVTRlTu0lcuK78yQqd+l28ZHZLg4AeP7ZV/bDs/8xEcKo4W9qynB25/NRYPt28LWytS
	sdEVgeInyCJKKCK0evn/ORL3imQrKV8o2FabK/a7MQwAZ5B0qzsxNQ2FpWdZJ5y2xC/QsCLiMwy
	/BqJzhP/X1iR1UmgTZ3GVOv+XnXoDf/Hy4nf4LFV7TNHnhcd+09a4Uxa5yCa9x0YNgjNJaPBNeQ
	ZJVq0GZyhhu5D5JV0rp6JymlaObqB5FxZmJw5tTX7VvpFI=
X-Received: by 2002:a05:6102:4b19:b0:7c4:613b:2e22 with SMTP id
 ada2fe7eead31-7d03a5f8771mr1961137.10.1793123536756; Tue, 27 Oct 2026
 10:52:16 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022221732.1397620-3-rjethwani@purestorage.com> <179305490892.3134.14812552886616716829@kernel.org>
In-Reply-To: <179305490892.3134.14812552886616716829@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 27 Oct 2026 10:52:05 -0700
X-Gm-Features: AclHuK_GI2kdesJbsm2Ih7J1jAxRHaE8J5jLEktzrNOUVl_LrQ0CjoW16SOdTcQ
Message-ID: <CAKaoeS27sJpSoefbF1qaNNS1XrR_x5kHF8YNTCbeq85YFDqy7w@mail.gmail.com>
Subject: Re: [PATCH net v2 2/4] tls: device: fix next-record sequence in
 core-driven RX resync
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:48=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] In tls_device_core_ctrl_rx_resync() (net/tls/tls_device.c),
>   this patch makes the next-record sequence sent to the device=E2=80=A6
>
> Pre-existing issues:
> - [Medium] The other CORE_NEXT_HINT resync path, tls_rx_msg_size() ->
>   tls_device_rx_resync_new_rec() (net/tls/tls_sw.c:2234-2235 at this=E2=
=80=A6
>
> --
>
> tls: device: fix next-record sequence in core-driven RX resync
>
> tls_device_core_ctrl_rx_resync() used to pass tcp_sk(sk)->copied_seq to
> tls_device_resync_rx() as the TCP sequence of the next record. This patch
> passes tls_strp_msg_seq() + rxm->full_len instead. The commit message
> says the result is the start of the next record in both strparser modes.
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index fbfe6ec3df048..a6c4d0cc54c73 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
>
> [ ... ]
>
> > @@ -877,8 +878,9 @@ static void tls_device_core_ctrl_rx_resync(struct t=
ls_context *tls_ctx,
> >               memcpy(rcd_sn, tls_ctx->rx.rec_seq, prot->rec_seq_size);
> >               tls_bigint_increment(rcd_sn, prot->rec_seq_size);
> >
> > -             tls_device_resync_rx(tls_ctx, sk, tcp_sk(sk)->copied_seq,
> > -                                  rcd_sn);
> > +             tls_device_resync_rx(tls_ctx, sk,
> > +                                  tls_strp_msg_seq(sw_ctx) +
> > +                                  rxm->full_len, rcd_sn);
>
> [Severity: Medium]
> The sequence passed here no longer depends on the strparser mode. Does th=
e
> check that picks this branch still depend on it?
>
> Earlier in tls_device_core_ctrl_rx_resync():
>
>         /* head of next rec is already in, parser will sync for us */
>         if (tcp_inq(sk) > rxm->full_len) {
>                 trace_tls_device_rx_resync_nh_schedule(sk);
>                 ctx->resync_nh_do_now =3D 1;
>         } else {
>
> tcp_inq() counts from copied_seq. In copy mode, tls_strp_read_copy() has
> already moved copied_seq past the current record, so tcp_inq() counts onl=
y
> the bytes of the next record.
>
> Suppose between 1 and rxm->full_len bytes of the next record are already
> queued. The else branch runs, and tls_dev_resync() is called for a TCP
> position the device has already passed. resync_nh_do_now is never set, so
> tls_device_rx_resync_new_rec() also returns early:
>
>         case TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT:
>                 if (likely(!rx_ctx->resync_nh_do_now))
>                         return;
>
> Would this waste the resync attempt and keep the stream on software
> decryption until the backed-off retry?

Right, but that's pre-existing and not changed by this patch. In copy
mode copied_seq was already the next record's start, so the sequence
passed there is the same before and after; this patch only fixes the
normal mode, where the tcp_inq() check was correct but the sequence was
not.

The tcp_inq() check itself is wrong in copy mode independently of this
change (and since f953d33ba122 with the original strparser), which is
why it's a separate patch with its own Fixes: tag: patch 4/4
("tls: device: fix next-record queued checks in
core-driven RX resync") replaces it with after(rcv_nxt, next_seq).

> This tcp_inq() check was already there before this patch. The later commi=
t
> "tls: device: fix next-record queued checks in core-driven RX resync" in
> this series appears to fix it. That commit replaces the check with
> after(READ_ONCE(tcp_sk(sk)->rcv_nxt), next_seq).
>
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch. The
> commit message says the reported sequence "no longer depends on which mod=
e
> the strparser is in". Does that also hold for the other CORE_NEXT_HINT
> path?
>
> tls_rx_msg_size() in net/tls/tls_sw.c still computes the record start fro=
m
> the anchor skb:
>
>         tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE=
,
>                                      TCP_SKB_CB(skb)->seq + strp->stm.off=
set);
>
> In copy mode, tls_strp_read_copy() resets stm.offset to 0 but keeps the
> anchor's old cb. The value above can then be lower than the real record
> start, while tls_device_core_ctrl_rx_resync() now uses strp->seq.
>
> When tls_device_core_ctrl_rx_resync() sets resync_nh_do_now, it hands the
> resync to this path. tls_device_rx_resync_new_rec() also still assumes
> normal mode:
>
>                 /* head of next rec is already in, note that the sock_inq=
 will
>                  * include the currently parsed message when called from =
parser
>                  */
>                 sock_data =3D tcp_inq(sk);
>                 if (sock_data > rcd_len) {
>
> In copy mode, could the device then get the wrong next-record boundary fo=
r
> CORE_NEXT_HINT? Could the request sequence also fail to match for
> DRIVER_REQ and DRIVER_REQ_ASYNC?
>
> Two later commits in this series look like they fix this:
>
>   "tls: device: fix record start reported to RX resync in copy mode"
>   changes the argument to strp->seq.
>
>   "tls: device: fix next-record queued checks in core-driven RX resync"
>   changes the tcp_inq() check in tls_device_rx_resync_new_rec() to
>   READ_ONCE(tcp_sk(sk)->rcv_nxt) - seq.
>
> >       }
> >  }

The tls_rx_msg_size() path is pre-existing and handled separately:
patch 3/4 reports strp->seq instead of the anchor cb seq (covering
DRIVER_REQ / DRIVER_REQ_ASYNC as well as CORE_NEXT_HINT),

> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261022221732.1397620-1-rjethwani%40purestorage.com
