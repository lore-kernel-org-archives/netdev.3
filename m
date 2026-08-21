Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7707A423794
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326104; cv=pass; b=AaoQLecZqHTSTdGa3t/mTU3k4ky3bP0lkdq4xM6p3jcjIabTJb87mITmaaTmoiYtUx+hpxGz0K/PefClKnKA+lYa2IXYK8JpRQt4epRV8QFmmdrZuyLFO32rwLwqhcR/mD0jEQ4+Rj7C6os8iVh4fkY4V4Fl+h1EndY1z0+6Jdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326104; c=relaxed/simple;
	bh=aO2N8q0Q35fQWhEOu/usLOdYao6zCWFoNMCa62VLzWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q29/jNddQ3QHXex/ZIZVycNxaHnItkOseWlOq9bcv9FU8N8EmwUl/o/n41Ttmmxv4+/oLBXXfchexisleC8XY30xPoZ6TH3KnthFyIJ1EoaZAW879FyPx4OZF7IucJm1C9RHAbF9TzFYBAfcMO9b2OZYFCQxhmxIT5aI3okDHzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n246E7PT; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n246E7PT"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848593533cbso288229b3a.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 08:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787326101; cv=none;
        d=google.com; s=arc-20260327;
        b=ENGw5KRksae/FORMTG1/a+sobyu8vOXo7H5RfKq3kg91puw4t8+2ePLclaefkNZDQd
         mtaLl8lU5d9eypuWqJJe1oNo30dy05BoRJGHAaMud9nztqnOb2ROWAGiNdkHsew/ugv2
         qqtnja+9ibnB6XIN03l+fQUl+0/68w2vfZCXjnh7gXE8umV5zANdkSTQ/K0IGcGKO7RA
         ZdW3gBrUuWG4haC+Xtzngqm/ynBjCmB/sC2aZhsDl3kkHQWQxrxSXFUg6pLwvQMhgmQp
         4VBDd0ISVZI6J3/5zNipALCTYw7lw4/3vxvcNWouYEfrJm4O8VCxazSen8LYuK1cqPG6
         rBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k7uiZrvZnYmQNQRmUHNAo1Fr+zNWc8uQD+Fv871H7h8=;
        fh=WvWCxuJ/tu2P0tpr8YFlUv22GxSRNRnSobvq78yBvYM=;
        b=TNiB4zy+VRTSseB+UaT2xUr0AGi20igl4X+R0r65Kz9sHz2X/s/ko44SUpRDV+s8Hd
         xKC7swdKG15WcmkWyxL6GJUYddsaWkhlPnbPBLQfS8IzAMUEnU0pKoH77JCuyXEWiUFT
         9a61appPh59xM+d2XB7CXtPSU/89X+8hwHDXnHRf0yxtauzwLXGm5jsP8gMUabgH/aVv
         ht/eZdKyYPPR0v819jKh+wMv5qrQc+h3qg8XYm0XCxxC69Dt17Cj43xrEB5oz5X3GmRw
         GNn/X8d00aZ1juO8xFlpnD9xyzUw4awOqtCZBpNZ8GOCkwVu2H+YaVVspFo4+ef2tSyJ
         rLRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326101; x=1787930901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k7uiZrvZnYmQNQRmUHNAo1Fr+zNWc8uQD+Fv871H7h8=;
        b=n246E7PTM5z2mMKK6PWxcv1aqnC91L+ktcu3zcWAloiqX/7wRbhdE3+N8IFlgS+SpJ
         oYDPHBkpEULmZuuRV9bwmEUzaX26OEbgNdbdQYQRMqg0JL6obmAehhITRsSBXDKPX2F7
         2ads44Hpe5KQPbLPscp1fX9GANVU21E1of8oLr3R9j1ztbpEPNm9qYmyJCYYXwaMJVbX
         J0OewI34eb9hPOp17xaJZJUjmG3QD3bwElc0UZfooZh8DMEMm9YLhkHDaOgqfmPdzFpq
         VY/9IYFicLAl+sRUgbfLwzz8EBMhZ40imLwvorTiGppIz3t+dbhzbkD041VFA+WbkS1G
         ZyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326101; x=1787930901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k7uiZrvZnYmQNQRmUHNAo1Fr+zNWc8uQD+Fv871H7h8=;
        b=htVs7RaA/bccif+ed+NFn8eHakSy+mk+fyCnEazWZA0+OJ3tBkgObUaURNssjnJHOU
         ofeB9O+3mt4ZNE+BYoJgtkkWzvaPOC4QSjZMqEyndKT2u/CeQ063QCsAkf16rB/Fkq1l
         DM4kkrBWl0hFIHEhONmCyM/bTVC8ggHMHp0k8b6+3K5zzPUZRGO9pkgo+cARbkJ1BW6e
         RDXY7TI0+cyd/ORy7d0zS+BcOlSIhQ4Uvz3GmQW2b7XYZIXBt/ttLIM/25eEWtIUGljD
         4PhSE2X/imfjBYFBdDrERZabcAaAPkHYl9FqLptnqT+agPEZuSKyvNsar/60umbCwa+r
         radQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIAVC/lHInj2UE4sOYwl+6cTao9IeG6/OIVTdRE/jXQgNpSRTEowzMFtt9lBbPPVTUpNc/KQg=@vger.kernel.org
X-Gm-Message-State: AFuF++nX0ar2z1ExSbcSGulO9I+QiD2Bv5vB0cCO6B2y0Hge6Q6r4UUH
	uqQ40FFK7ULiAKpAbgMFSL9QF5l4EF8Tzlh1YvI84B4kZcqyAnSCDysz7L/pEIDNfGR28+JPt3H
	0C2iE3r4aJRroWMDZ5VLq+tyM+yBfraQ=
X-Gm-Gg: AR+sD11q/drVj7kRs0oe5eekE0BbY9v29uuBIsKpUWyf3wVU7zlPTeGz2GaVtQr3Bdr
	3wG9paj+dez4ZRBTDWrxFJt15qjnbMGjhKlm1+pSAiosmeMRqf5/20VS7VWLr9ucco2a95Y2Fg6
	5lKGzjzP15koRKfoPsB4e68PMMELADxh3Y8Rne/p6Ux59FdFkkilnFrhW9Eu2awAg/P/+IcXitv
	wdM5fW1Xq3Qx1gOfw7nZaEe9YWeLeoXyEYWuxETDZXjDiDK0UAqH2iD+qix4GrmMqydRRzvej5O
	lICYh2HL7HeysQPN6lYqFEa7JKPCd/pSO8Y4GBf0vUUnrgdnlU6KQJLdhlhxHXTFj+FRG6h1w6M
	R4hIxraHlHFPhg4X3Jy+bZVpn2uHRN+9vym2Daw/TNZZGgFoTUjDMSuFpoiHRWYkIoV0vQNkhFw
	ZO
X-Received: by 2002:a05:6a00:2e19:b0:84c:4b58:2cec with SMTP id
 d2e1a72fcca58-851fa071eccmr11065029b3a.15.1787326100663; Fri, 21 Aug 2026
 08:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820162235.2668698-2-bestswngs@gmail.com>
In-Reply-To: <20260820162235.2668698-2-bestswngs@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 21 Aug 2026 11:28:08 -0400
X-Gm-Features: AcwNN1UHjVHC0nrat9gCj5-HdAaF9SV-qu5rB8IwX-X2vzEVe-Gsi4pJ6NsHqH4
Message-ID: <CADvbK_cC8A3vjV0mweyBX_RyHFk_-ruyQ-Wp6UDmWpeAvNMvTQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix NULL deref on untransmitted RECONF completion
To: bestswngs@gmail.com
Cc: marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, horms@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, xmei5@asu.edu, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 12:23=E2=80=AFPM <bestswngs@gmail.com> wrote:
>
> From: Weiming Shi <bestswngs@gmail.com>
>
> sctp_process_strreset_outreq(), sctp_process_strreset_addstrm_out() and
> sctp_process_strreset_resp() finish a pending stream reconfiguration
> request by stopping the reconf timer on the transport the request was
> sent on:
>
>         t =3D asoc->strreset_chunk->transport;
>         if (timer_delete(&t->reconf_timer))
>                 sctp_transport_put(t);
>
> On the transmit path chunk->transport is assigned by
> __sctp_packet_append_chunk(), that is, when the chunk is actually
> appended to an outbound packet. A RECONF chunk that was queued but never
> transmitted keeps transport =3D=3D NULL, and its reconf timer is never ar=
med
> either, since that too only happens once the chunk has been appended.
>
> sctp_outq_flush_ctrl() skips every non-ASCONF control chunk while
> asoc->src_out_of_asoc_ok is set and leaves it on control_chunk_list, so
> in that state a RECONF is never put on the wire. The sender side has
> already published the chunk in asoc->strreset_chunk and armed
> asoc->strreset_outstanding, so an incoming RECONF that drives
> strreset_outstanding down to 0 dereferences the NULL transport.
>
> sctp_send_asconf_del_ip() reaches that state without any peer
> interaction: when the address being removed is the association's last
> one it stashes the address in asoc->asconf_addr_del_pending, sets
> src_out_of_asoc_ok and skips chunk creation and transmission
> ("stored =3D 1; goto skip_mkasconf"). As only sctp_process_asconf_ack()
> clears the flag, it stays set until a later bindx() ADD picks the pending
> delete up. An unprivileged process that removes the last address of an
> ASCONF-enabled association and then asks for a stream reset panics the
> kernel from softirq:
>
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc000000003d: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x00000000000001e8-0x00000000000001ef]
>   RIP: 0010:timer_delete+0x67/0x110
>   Call Trace:
>    <IRQ>
>    sctp_process_strreset_addstrm_out (net/sctp/stream.c:832)
>    sctp_sf_do_reconf (net/sctp/sm_statefuns.c:4212)
>    sctp_do_sm (net/sctp/sm_sideeffect.c:1172)
>    sctp_assoc_bh_rcv (net/sctp/associola.c:1044)
>    sctp_rcv (net/sctp/input.c:243)
>    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
>    ip_local_deliver (net/ipv4/ip_input.c:262)
>    ip_rcv (net/ipv4/ip_input.c:612)
>    process_backlog (net/core/dev.c:6680)
>    net_rx_action (net/core/dev.c:7959)
>    handle_softirqs (kernel/softirq.c:622)
>    </IRQ>
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Skip the timer deletion when the RECONF chunk never reached a packet:
> there is no armed reconf timer and no transport reference to drop.
>
> Fixes: 810544764536 ("sctp: implement receiver-side procedures for the Ou=
tgoing SSN Reset Request Parameter")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Note to reviewers: this only stops the crash, and I want to be upfront th=
at it
> does not remove the state that produces it.
>
> That state has exactly one producer. sctp_send_asconf_del_ip() latches
> src_out_of_asoc_ok on the branch that stashes the association's last addr=
ess
> without building or sending an ASCONF, and sctp_process_asconf_ack() is t=
he
> only place that clears it -- so the flag survives until the application i=
ssues
> the follow-up bindx() ADD that sctp_make_asconf_update_ip()'s del_pickup =
needs.
> 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host") desc=
ribes
> this as a transient state ("the other chunks cannot be transmitted in thi=
s
> state"), but nothing bounds how long it lasts: an application that never =
adds a
> replacement address leaves the association unable to send any DATA or
> non-ASCONF control chunk for the rest of its life, with the RECONF sittin=
g on
> control_chunk_list and strreset_outstanding armed.
>
> I kept this patch to the dereference because it is what the rest of net/s=
ctp
> already does -- every other chunk->transport dereference is NULL-checked =
-- and
> because it backports cleanly. But would you prefer the latch itself to be
> addressed, or the reconf request to be abandoned here rather than complet=
ed
> against a chunk that never went out? Happy to follow up with either for
> net-next. net/sctp/stream.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index 34ffe6c945a4..1cb30def2eb9 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -577,7 +577,7 @@ struct sctp_chunk *sctp_process_strreset_outreq(
>                         struct sctp_transport *t;
>
>                         t =3D asoc->strreset_chunk->transport;
> -                       if (timer_delete(&t->reconf_timer))
> +                       if (t && timer_delete(&t->reconf_timer))
>                                 sctp_transport_put(t);
>
>                         sctp_chunk_put(asoc->strreset_chunk);
> @@ -829,7 +829,7 @@ struct sctp_chunk *sctp_process_strreset_addstrm_out(
>                         struct sctp_transport *t;
>
>                         t =3D asoc->strreset_chunk->transport;
> -                       if (timer_delete(&t->reconf_timer))
> +                       if (t && timer_delete(&t->reconf_timer))
>                                 sctp_transport_put(t);
>
>                         sctp_chunk_put(asoc->strreset_chunk);
> @@ -1084,7 +1084,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
>         /* remove everything for this reconf request */
>         if (!asoc->strreset_outstanding) {
>                 t =3D asoc->strreset_chunk->transport;
> -               if (timer_delete(&t->reconf_timer))
> +               if (t && timer_delete(&t->reconf_timer))
>                         sctp_transport_put(t);
>
>                 sctp_chunk_put(asoc->strreset_chunk);
> --
> 2.55.0
>
If the STRRESET chunk has never been sent, we should NOT allow an incoming
chunk to =E2=80=9CACK=E2=80=9D it.

Could you try fixing this by returning NULL from
sctp_chunk_lookup_strreset_param() if the STRRESET chunk has not been
transmitted yet? like:

@@ -488,7 +488,7 @@ static struct sctp_paramhdr
*sctp_chunk_lookup_strreset_param(
        struct sctp_reconf_chunk *hdr;
        union sctp_params param;

-       if (!chunk)
+       if (!chunk || !chunk->transport)
                return NULL;

Please also share the PoC with the maintainers, if there is one.

Thanks.
