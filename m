Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A892868AB
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787506606; cv=pass; b=EZPnqchZMy5+LI+Rm8l/yjdQBBPM9OKlMoiwGoOZ9Cm+ZpJd+ZoVOTmzAU4fpL4jl5wgOtf6ugCjKbk1Y/quO/JZDhQ2uq4iPmrVzBaRjdO6l1alip+cgvaoTXsKYS9+04CS0rKQkrE2EUFqFHyOMtuy4rEJv8C6vqqAMlSqh/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787506606; c=relaxed/simple;
	bh=ZTG7jVjcTi86l5dazmQruPuJYLfOT+grKua4hiNOklI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoT9ga5b0uJmEw2GOJpv2nGHNegjQa+mDsf4tQebdchJdvB725K//ASNh1bHw+M0Mf/tP7kP5oqrTuwXsEVa0oZOAQt5uggJSeIoCf4Kw08O54mFaLmBrKmZekM6giUuPGjaVc34bv7uJZaRITU/nW/YmR2uWzGU+agnpcLMNZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXbUKvpV; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXbUKvpV"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-836f34a0ceaso41955117b3.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 10:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787506604; cv=none;
        d=google.com; s=arc-20260327;
        b=B3bhxJhqMqxgGMFj5I9bT2YuWtfAjeWxX5BoBR8fgwDazq91/wmiSlyPfZJmqL/l7N
         TYXeBE/XEXcaihAaYnSBWCFC5MzURhIrDc4oRd9haTyUawdQNQWTyJk2No6y/Fhb8enQ
         B57KuxjcmBf416+gxflDEpfF5C7jkwS794jZ/uowZ5bT9CbT9O+iBUijqfwncp41lpOP
         V/bNN4GEPBp8gT+4n4Qi4NFjRyxUR7i0TiTtkADyfEkBXkhxnsezAQTQebfXXMgkmnCG
         frsvC+JPiKDeAoycLCjbiICw7KCYhPDZ8oUKWnsAVGHUx53vviFvVpCtXDHV+ekLqMH6
         WCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZFaM240eicHlNZGsa1WgcDYHiUAJ1fjLwFBjJU8YruQ=;
        fh=6rtlFwcI08lNloA1r7sXoFAAUg1l6ustR2+6ZMAqPoI=;
        b=FROP+bKZCS8ZA6yN/J4MxMUHXrk2NU9tKbvuoQa0+z2AdO8jKH7zy8arzd09uDPCzR
         I57KVZklvuvuC0hPteAwEsq4O8bXN7f8riIFIBDwdzHecRjNbE99rinJL3qOWhv8n0pP
         4xbzHmp6UHkY8d8fKKbATk+8cTOMOcMoPZ0tIirNzMajaiVHy/QqaiXyrYvHaCOHUN8o
         a2fE9Uzc+XkJS44lLdbcLqk5fE15OqzEOmqwoDm0wtoCdSQ86qze9p8HzaILfWDDpTp5
         EtEiqb99j42TMSMOMPXfxyzdw8daX1GjKeV+QPOWr4OcWmgZ6GRmB9vdD16Zthji4Sic
         bMkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787506604; x=1788111404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZFaM240eicHlNZGsa1WgcDYHiUAJ1fjLwFBjJU8YruQ=;
        b=BXbUKvpV/z6rXuQY3VQAy6sfXCLy1kHi+aXn/KYA7tPA8erh6cdD+DZfXV2HKtCjXh
         B5KS5By+XLiyYrdzpklJWKhBmf3EW3GIjWs16FAdaOqNkcvQVMM/T4lkdxZCc4Tnr7o6
         9CCg2WHPHWFHZ77BLtLwLy2+BtNEe/IUNrj8sv6RQ40WhAB8B3bnf32085EvfeGI7IDV
         UcypRMHgq4/BMBxAMoVOVuhJAsVy4t1wFGi6c2dr/q/yz4o9/IxVU0emAIut7CNQTPJi
         Myph8ZIQiCU//TNtQkDqz0VLvr3H5BeEFm2Az6eHyjdfx6xkAMSgfldTVQGgKlnPLLYS
         VNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787506604; x=1788111404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFaM240eicHlNZGsa1WgcDYHiUAJ1fjLwFBjJU8YruQ=;
        b=SaLztNqgzZMNc6wJ9MqwKKa5305DQ1W8+ayoi+wnR5anF6n2CqlMqkHIOghYhOteHL
         zZXbBdBZuucsznR/9gly5NdKGkq0JiMFE+1AKcezK4GJ8Ds84OzjZ0Q0a+lFZy0G/q1Q
         1D5dM099o6IL+GIxkSFRIQLZIY5+0TXK+JBXjQIRZDChjMreXIBAU6SdPuRKpCONeI9L
         ap1TGRyetIi+E5pMlgwPuvPJvUXBwT84/bINdhAzRmjfdH03eZH3q8M4gkYVIrsuOfUt
         dkHjhqIEq2emBTcMl8mBHSMIyu+gQG1n+U/AmNOQQ6NOwFqY/zBgL3woWlf+/pR8ZaqA
         Vf/A==
X-Forwarded-Encrypted: i=1; AHgh+Rr9+eyi0u8Nfk9eZMLcN3JGj7qCh29l+sZd1ANae/a0pta+VFLNOyr/dKaajo3+gRbzeQqBB1A=@vger.kernel.org
X-Gm-Message-State: AFuF++kBBMxLDsLoLaniLE41/NLM8I1+nqrlK6RLKDbZKo9RrwmDAawD
	HKgGte+ELnvkB2CDd6H7JfYa3b80u8eLa/O6cqrSc+0qjyeCI1Ez5rTwhozbBHEDl6q/NWwGgIC
	UoPNZ1kyiq7klyt75DxOG2EOX/h5wasA=
X-Gm-Gg: AR+sD12pEiL+4TyicHJbHRfSNWajlgdXTl1850dZqap4/MsUwlGTcAcjCsJcxwaW1WC
	yKuvXc3m4orE+AiEGwue+jnfs5hz0TAsXus6xE7EVhKLFY/uVIRLSZrc4KFj1+1ba6KW9Z2xlTC
	X4I3PrTcO2BVUtUi81mPVy6blAszH2SfI7CvK2dQQjFX/5+zZvfd0Pmqw/8IKUIWrt50JUb+3b3
	wDPP1G9E22aw1vtjgghJMxtrT6Wh1xzZjqRiS6/xKQ52dmmCdOqhGtSYPuWpEkz+iXzWFAsiq7U
	SQIfvywAebgNzpYhSJoFjVvsNqg3uknhM7fMYojjrRzdYkNJ7DVPADv5coijNdaIztJ8pYw2vJI
	=
X-Received: by 2002:a05:690c:e1c6:10b0:826:f78b:8462 with SMTP id
 00721157ae682-847091daa5amr80352677b3.7.1787506604304; Sun, 23 Aug 2026
 10:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820162235.2668698-2-bestswngs@gmail.com> <CADvbK_cC8A3vjV0mweyBX_RyHFk_-ruyQ-Wp6UDmWpeAvNMvTQ@mail.gmail.com>
In-Reply-To: <CADvbK_cC8A3vjV0mweyBX_RyHFk_-ruyQ-Wp6UDmWpeAvNMvTQ@mail.gmail.com>
From: Weiming Shi <thebestswings@gmail.com>
Date: Mon, 24 Aug 2026 01:36:05 +0800
X-Gm-Features: AcwNN1WIN7ZamSxeHE9CfMftmz0TsLLVundqqXQL6dY4xi55zsOABCO5R4pkbyQ
Message-ID: <CANgPUi1KkHNn=BeEG32B6kbYNArn0XV1rgeF3A6-wR7+oELpyA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix NULL deref on untransmitted RECONF completion
To: Xin Long <lucien.xin@gmail.com>
Cc: marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, horms@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, xmei5@asu.edu, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Xin Long <lucien.xin@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=BA=94 23:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Aug 20, 2026 at 12:23=E2=80=AFPM <bestswngs@gmail.com> wrote:
> >
> > From: Weiming Shi <bestswngs@gmail.com>
> >
> > sctp_process_strreset_outreq(), sctp_process_strreset_addstrm_out() and
> > sctp_process_strreset_resp() finish a pending stream reconfiguration
> > request by stopping the reconf timer on the transport the request was
> > sent on:
> >
> >         t =3D asoc->strreset_chunk->transport;
> >         if (timer_delete(&t->reconf_timer))
> >                 sctp_transport_put(t);
> >
> > On the transmit path chunk->transport is assigned by
> > __sctp_packet_append_chunk(), that is, when the chunk is actually
> > appended to an outbound packet. A RECONF chunk that was queued but neve=
r
> > transmitted keeps transport =3D=3D NULL, and its reconf timer is never =
armed
> > either, since that too only happens once the chunk has been appended.
> >
> > sctp_outq_flush_ctrl() skips every non-ASCONF control chunk while
> > asoc->src_out_of_asoc_ok is set and leaves it on control_chunk_list, so
> > in that state a RECONF is never put on the wire. The sender side has
> > already published the chunk in asoc->strreset_chunk and armed
> > asoc->strreset_outstanding, so an incoming RECONF that drives
> > strreset_outstanding down to 0 dereferences the NULL transport.
> >
> > sctp_send_asconf_del_ip() reaches that state without any peer
> > interaction: when the address being removed is the association's last
> > one it stashes the address in asoc->asconf_addr_del_pending, sets
> > src_out_of_asoc_ok and skips chunk creation and transmission
> > ("stored =3D 1; goto skip_mkasconf"). As only sctp_process_asconf_ack()
> > clears the flag, it stays set until a later bindx() ADD picks the pendi=
ng
> > delete up. An unprivileged process that removes the last address of an
> > ASCONF-enabled association and then asks for a stream reset panics the
> > kernel from softirq:
> >
> >   Oops: general protection fault, probably for non-canonical address
> >   0xdffffc000000003d: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: null-ptr-deref in range [0x00000000000001e8-0x00000000000001ef=
]
> >   RIP: 0010:timer_delete+0x67/0x110
> >   Call Trace:
> >    <IRQ>
> >    sctp_process_strreset_addstrm_out (net/sctp/stream.c:832)
> >    sctp_sf_do_reconf (net/sctp/sm_statefuns.c:4212)
> >    sctp_do_sm (net/sctp/sm_sideeffect.c:1172)
> >    sctp_assoc_bh_rcv (net/sctp/associola.c:1044)
> >    sctp_rcv (net/sctp/input.c:243)
> >    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
> >    ip_local_deliver (net/ipv4/ip_input.c:262)
> >    ip_rcv (net/ipv4/ip_input.c:612)
> >    process_backlog (net/core/dev.c:6680)
> >    net_rx_action (net/core/dev.c:7959)
> >    handle_softirqs (kernel/softirq.c:622)
> >    </IRQ>
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Skip the timer deletion when the RECONF chunk never reached a packet:
> > there is no armed reconf timer and no transport reference to drop.
> >
> > Fixes: 810544764536 ("sctp: implement receiver-side procedures for the =
Outgoing SSN Reset Request Parameter")
> > Cc: stable@vger.kernel.org
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > Note to reviewers: this only stops the crash, and I want to be upfront =
that it
> > does not remove the state that produces it.
> >
> > That state has exactly one producer. sctp_send_asconf_del_ip() latches
> > src_out_of_asoc_ok on the branch that stashes the association's last ad=
dress
> > without building or sending an ASCONF, and sctp_process_asconf_ack() is=
 the
> > only place that clears it -- so the flag survives until the application=
 issues
> > the follow-up bindx() ADD that sctp_make_asconf_update_ip()'s del_picku=
p needs.
> > 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host") de=
scribes
> > this as a transient state ("the other chunks cannot be transmitted in t=
his
> > state"), but nothing bounds how long it lasts: an application that neve=
r adds a
> > replacement address leaves the association unable to send any DATA or
> > non-ASCONF control chunk for the rest of its life, with the RECONF sitt=
ing on
> > control_chunk_list and strreset_outstanding armed.
> >
> > I kept this patch to the dereference because it is what the rest of net=
/sctp
> > already does -- every other chunk->transport dereference is NULL-checke=
d -- and
> > because it backports cleanly. But would you prefer the latch itself to =
be
> > addressed, or the reconf request to be abandoned here rather than compl=
eted
> > against a chunk that never went out? Happy to follow up with either for
> > net-next. net/sctp/stream.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> > index 34ffe6c945a4..1cb30def2eb9 100644
> > --- a/net/sctp/stream.c
> > +++ b/net/sctp/stream.c
> > @@ -577,7 +577,7 @@ struct sctp_chunk *sctp_process_strreset_outreq(
> >                         struct sctp_transport *t;
> >
> >                         t =3D asoc->strreset_chunk->transport;
> > -                       if (timer_delete(&t->reconf_timer))
> > +                       if (t && timer_delete(&t->reconf_timer))
> >                                 sctp_transport_put(t);
> >
> >                         sctp_chunk_put(asoc->strreset_chunk);
> > @@ -829,7 +829,7 @@ struct sctp_chunk *sctp_process_strreset_addstrm_ou=
t(
> >                         struct sctp_transport *t;
> >
> >                         t =3D asoc->strreset_chunk->transport;
> > -                       if (timer_delete(&t->reconf_timer))
> > +                       if (t && timer_delete(&t->reconf_timer))
> >                                 sctp_transport_put(t);
> >
> >                         sctp_chunk_put(asoc->strreset_chunk);
> > @@ -1084,7 +1084,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
> >         /* remove everything for this reconf request */
> >         if (!asoc->strreset_outstanding) {
> >                 t =3D asoc->strreset_chunk->transport;
> > -               if (timer_delete(&t->reconf_timer))
> > +               if (t && timer_delete(&t->reconf_timer))
> >                         sctp_transport_put(t);
> >
> >                 sctp_chunk_put(asoc->strreset_chunk);
> > --
> > 2.55.0
> >
> If the STRRESETSTRRESET chunk has never been sent, we should NOT allow an=
 incoming
> chunk to =E2=80=9CACK=E2=80=9D it.
>
> Could you try fixing this by returning NULL from
> sctp_chunk_lookup_strreset_param() if the STRRESETSTRRESET chunk has not =
been
> transmitted yet? like:
>
> @@ -488,7 +488,7 @@ static struct sctp_paramhdr
> *sctp_chunk_lookup_strreset_param(
>         struct sctp_reconf_chunk *hdr;
>         union sctp_params param;
>
> -       if (!chunk)
> +       if (!chunk || !chunk->transport)
>                 return NULL;
>
> Please also share the PoC with the maintainers, if there is one.
>
> Thanks.

Hi,

Thanks for your review. Updated patch and PoC are sent.
