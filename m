Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793735023;
	b=im0UxoKZJcvx5lEimjeqnl6DKm0JJakMlXqEto1osKHJSoqYop4oJshke7tCXvZIM7Xx
	 utG73domlUdcVcOfGYRUcX1KuMNThhy8POHuIfzWsP5bunNaM7m3Z831/FAv2yL7BVa7e
	 Ue7i9pIy5yBoLxcHggnPhm1y12KPnHxa4I1Vr/PkCH7wx1jLGPo04/wtEQaDBAkDyr+2r
	 k9mzty+TcnT4JUwgurSrdrumYNy1/uhS2tIqbdFTCkS1VKkckmoG9tbj93kK8lBwkwA3a
	 VO87fINlo22TB9VkgqZBrg30CGwWUjVsdlp2pTfl6aXhgiNyT6lOkhCB1CT05FjYhDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HXiF5Hkq0HzdjVstuqtN1MMqL7UJCviIzr82cLK6HWc=;
	b=eADkNKo4n1u6grkJJdPkJRC7OIkw+ackTxiPa3OxGRP1JYt2HnmOYiIktbW3ECZ8xv/s
	 mDN84CV9YMOzuAplffQAuU6XSmq+0SXghnCrABh4MQmHvDAFxt8+Hfq1yAymtkyuEwxBU
	 uM82DhidNF1Zv8jtSIhTQBURv1i9TNoHTEgGF1C8phh/2RsxWSJJK4IoSjh25+P/414EI
	 FQZQqvzWl1cxWv1Cea48xdT0cKouuRjWCkNnJTHnUvWPwd33v0VgmJRbe3TTTWNGgez7f
	 5fyWmtFuRgvN4tgRVuZvPpnla8skKayU8GyMBml9ne0J6nUxlToSBCeTu3QWs8Q9VsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BxKVG8Jo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD659606A332
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD659606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BxKVG8Jo
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8ac1f2ff78dso548368b3a.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:43:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793735022; cv=none;
        d=google.com; s=arc-20260327;
        b=SpWRunoua2FEL/b0DutHA3tc5/ZxvN2Llqo7DZrCkuGMjH1eStNJERSKHMOsVGX1+M
         vJvO0cVMfrRyGnolOPf3PSRVTsICw/Wpnbuq1i0aSPBztG0y4IhzTt7kTzpqOUYxve2Q
         ZDh5iRP5CGZk+jtdokL9pZOig0inFXxGPv+lxZiTdw7/7ROp6+IOpcdSYvTAa6rXfznm
         ci9KZWV+7EBnEahlMCemEypR3Y6dA6EUp5BM1ccJIpyBdq8C1DOGSHp7s8KKnlmkzG0e
         B8UCBL6xJlNv9v9247QapLiQVuPMCONrsKI8jZHEsej52TIIzh9FAUyNEg4HMbT444nK
         pdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HXiF5Hkq0HzdjVstuqtN1MMqL7UJCviIzr82cLK6HWc=;
        fh=6Qcd+Wk8nlR9vD3YvEqDT/bvHKG7RTLZXtgJAI2OCH8=;
        b=cKKJm1zqYI11MuMbygTy/wy1zucROPOuGKo6dr7dvqj8M/f0Skzik+Sbh97f5U4Ik8
         IKb/+A0MEhERWeAfCD/7Y0ullEIL/icSQuxhgCb0wAwQvFNc0dAXmq5B2kYsYr/lJE/2
         plicl1skO3lE8Xuf/P3Rb3I+ry+GLiPlBAKzumSn5U2aEDhFuuRqweg/DE7I3OEWaK1w
         qCpK1QRWhlW4ehpPeg2Xu59rZTOmDGcIovA3t04xld7hQnzvqoSKjZKPDu6JyEqrk4m4
         NIlPUYHoYxCPFUeBYRc96W/M+7FLMRSXF7YwEbB//zfSA+K61wfwJydyep1yUa3XptKc
         hlfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793735022; x=1794339822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HXiF5Hkq0HzdjVstuqtN1MMqL7UJCviIzr82cLK6HWc=;
        b=BxKVG8JoCv/iLQwtckK7tTHB16bZFUqtRztlGqJbBM/qwXqrVU8gxVckUULIHgtRwe
         eAVu1569YSe66F2TCCr8LjC4QzC3JhASOec0GtGkb5ebpm1Qo2E++YCHjminyHPTdK5X
         wBE5RwowM8xsbD56ydU7k8LxUZ2B8rHVPg8n5t+3wYFEyXrdY9qGu52DT1t41PnSPXvE
         Uc9gCXRa1ZtUGFzNSbajQgIHcrbpYASURIPtYKhmtssCGSbc9ZpOio6dC0e88MKez5kF
         2DjxVghz+PDpBd2UmSRKvYzOfk/PP197DE87udZ5Sd087x6FyCvp30CyaxCbFsLLcBZP
         CeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735022; x=1794339822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HXiF5Hkq0HzdjVstuqtN1MMqL7UJCviIzr82cLK6HWc=;
        b=UaSvzrnc6KfrCUTYYtaXZUF2kVSUipOBE/Ye9v+Fk4TCc+UamXn9U0Gn1ABw1jPVvO
         5Z6p0itg7qc/kGcf0IOfRweO+LK8OKTOKsND02jYY+phWSeDuL2AgkUgRCDC8UFvDoQi
         fXypnKHVG2VfLMcCyrwtjJqRSbgLm54hEJWCO5X6755aAb6ltzKzyYNEzPXzJ0Mf0Bbo
         xaQxzxRmm8SQCzeeffTR5TckJKr8jXk7GAZdtRhPCFdfZat99ATlth0dMfPhPpEofuZ2
         Jup0I0vxoY1tqFOAht4TjMwWF8EeF7VLxRhmWouoeQuAwzNZLdZizeqcKkkg5MW7ExA1
         FsHw==
X-Forwarded-Encrypted: i=1; AKwUvBytIRHuJZeXfNH2POlycRCX0xjG+TIEsgcR7fQ9AyOctlkC4uHvgcMLV39xXTUbsRrqsROc9vg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pV0sBDpycoRoZU9WlW0/jl176n9yOnsFwr2BdhVSjfSf252yV
	+98Y+/4dKO/7q1wvUjLLqJ81cCjYJOWQHqA6rJUaqSsQ46K50XXU9/ysFigIBjF4X4YmUB7Qwbd
	nf/q85pKkPpmKRsFcR5oXKuxu/+G9Ahc=
X-Gm-Gg: AYBFou1d4tiLjiu1bhLmcGFB9tcbl5qpfPdAXCzZCLrcE+7lJ+Dhze63GgW87AhuMHl
	NF5Z3MLziM8oC8DkaHHmabyjfhLzSI3D/HNjnDE/2rqlR/TPoWYRH9OeBhTKMtlOyvnNH2hntmk
	h/HHRkf88XidFX26aocTSNvM+omi7cWxru6GSM/a+g8tqTp0IDZIU1QHzDUPbZueslU6cJbRYv4
	12wZjXy90LoWmyS0o+EkrHCrLU1wuuxJWfEcoMIde1xLq3/w2yz1JOM8Gd6aNmRnS/jIhwcX5Ct
	4D8MTulUGUUKQSvIUIWD/xdNlu9s2d/6BDx0KfyPtPOPqgi+BLNRLi5CZrXhLdr20lqvt9hEI7V
	MokWtXdz9p5Jtf7iKZ6GQLxS5C1Y9PgjG3/CXDcrPVGtaR7Cu/BsXY/t5Ufc5QfeMcK8icJpjeE
	mCHSToLas5BMt9myM5voATBVzecKPwJU7UrCygmrmAZeHGbkwH62APOxfdog==
X-Received: by 2002:a05:6a21:9105:b0:3e2:2459:b774 with SMTP id
 adf61e73a8af0-3e928914359mr7729030637.16.1793735022129; Tue, 03 Nov 2026
 11:43:42 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103192606.92502-1-kylebot@openai.com>
In-Reply-To: <20261103192606.92502-1-kylebot@openai.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 3 Nov 2026 14:43:30 -0500
X-Gm-Features: AclHuK-Ntnjfy2V4XSDVEY_hZLHadBX9iYXfJBbZvbiqYzD0aYF-YvCMv_txPg8
Message-ID: <CADvbK_d3k8GsgjdHUZ0a2LDs-Y0jd3mxoFvLSnnz3WqCTbBbHA@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: avoid requeueing pending control chunks
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 2:26=E2=80=AFPM Kyle Zeng <kylebot@openai.com> wrote=
:
>
> The T4 and RE-CONFIG timeout handlers take a reference to their cached
> control chunk and submit it through SCTP_CMD_REPLY. A previous
> transmission can still be on the control outqueue when output is corked
> or suppressed, or when sctp_packet_transmit_chunk() could not append the
> chunk.
>
> sctp_outq_tail() then adds the same list node a second time. Re-adding a
> non-tail entry can corrupt the list without being caught by the
> insertion-time list checks. A subsequent flush or association teardown
> can access an already freed chunk. The ASCONF path is reproducible by an
> unprivileged SCTP socket owner in a user/network namespace, with KASAN
> reporting a use-after-free in __sctp_outq_teardown().
>
> Check sctp_chunk_pending() in both timeout handlers before taking the
> extra reference and issuing SCTP_CMD_REPLY. When the chunk is already
> linked, request a deferred outqueue flush instead. Simply omitting the
> reply would also omit its uncork at the end of the timeout event. T4
> would no longer retry the queued ASCONF, and a migrated, pending
> RE-CONFIG could lose its timer until unrelated output flushes the queue.
>
> The flush command acquires a local cork only when the caller has not
> already corked the queue. This preserves the existing flush ordering,
> transport/error accounting and timer handling without changing the
> common enqueue path.
>
> The issue was found by an LLM.
>
> Fixes: 2e3216cd54b1 ("sctp: Follow security requirement of responding wit=
h 1 packet")
> Fixes: 7b9438de0cd4 ("sctp: add stream reconf timer")
> Cc: stable@kernel.org
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> v1: https://lore.kernel.org/netdev/20261030042321.74407-1-kylebot@openai.=
com/
> v2: Check pending chunks in the T4 and RE-CONFIG timeout handlers, as
> requested. Preserve their deferred output flush with a state-machine
> command so pending requests can progress without unrelated traffic.
> The common sctp_outq_tail() path is unchanged.
>
> I have a reproducer for this issue and can share by DM.
>
>  include/net/sctp/command.h |  1 +
>  net/sctp/sm_sideeffect.c   |  8 ++++++++
>  net/sctp/sm_statefuns.c    | 20 ++++++++++++++------
>  3 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/sctp/command.h b/include/net/sctp/command.h
> index 2058fabffbf6..abd6cc509183 100644
> --- a/include/net/sctp/command.h
> +++ b/include/net/sctp/command.h
> @@ -39,6 +39,7 @@ enum sctp_verb {
>         SCTP_CMD_CHUNK_ULP,     /* Send a chunk to the sockets layer.  */
>         SCTP_CMD_EVENT_ULP,     /* Send a notification to the sockets lay=
er. */
>         SCTP_CMD_REPLY,         /* Send a chunk to our peer.  */
> +       SCTP_CMD_OUTQ_FLUSH,    /* Flush pending output when uncorked. */
>         SCTP_CMD_SEND_PKT,      /* Send a full packet to our peer.  */
>         SCTP_CMD_RETRAN,        /* Mark a transport for retransmission.  =
*/
>         SCTP_CMD_ECN_CE,        /* Do delayed CE processing.   */
> diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
> index 35f540fb15fc..6f19ac78749d 100644
> --- a/net/sctp/sm_sideeffect.c
> +++ b/net/sctp/sm_sideeffect.c
> @@ -1498,6 +1498,14 @@ static int sctp_cmd_interpreter(enum sctp_event_ty=
pe event_type,
>                         sctp_outq_tail(&asoc->outqueue, cmd->obj.chunk, g=
fp);
>                         break;
>
> +               case SCTP_CMD_OUTQ_FLUSH:
> +                       /* Request a flush without taking over an outer c=
ork. */
> +                       if (!asoc->outqueue.cork) {
> +                               sctp_outq_cork(&asoc->outqueue);
> +                               local_cork =3D 1;
> +                       }
> +                       break;
> +
>                 case SCTP_CMD_SEND_PKT:
>                         /* Send a full packet to our peer.  */
>                         packet =3D cmd->obj.packet;
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index b2f609f177fb..8b76b7e28504 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -1122,9 +1122,13 @@ enum sctp_disposition sctp_sf_send_reconf(struct n=
et *net,
>                 return SCTP_DISPOSITION_DELETE_TCB;
>         }
>
> -       sctp_chunk_hold(asoc->strreset_chunk);
> -       sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
> -                       SCTP_CHUNK(asoc->strreset_chunk));
> +       if (!sctp_chunk_pending(asoc->strreset_chunk)) {
> +               sctp_chunk_hold(asoc->strreset_chunk);
> +               sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
> +                               SCTP_CHUNK(asoc->strreset_chunk));
> +       } else {
> +               sctp_add_cmd_sf(commands, SCTP_CMD_OUTQ_FLUSH, SCTP_NULL(=
));
> +       }
>         sctp_add_cmd_sf(commands, SCTP_CMD_STRIKE, SCTP_TRANSPORT(transpo=
rt));
>
>         return SCTP_DISPOSITION_CONSUME;
> @@ -6197,9 +6201,13 @@ enum sctp_disposition sctp_sf_t4_timer_expire(
>          * chunk, it MUST be the same (including its serial number) as th=
e last
>          * ASCONF sent.
>          */
> -       sctp_chunk_hold(asoc->addip_last_asconf);
> -       sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
> -                       SCTP_CHUNK(asoc->addip_last_asconf));
> +       if (!sctp_chunk_pending(asoc->addip_last_asconf)) {
> +               sctp_chunk_hold(asoc->addip_last_asconf);
> +               sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
> +                               SCTP_CHUNK(asoc->addip_last_asconf));
> +       } else {
> +               sctp_add_cmd_sf(commands, SCTP_CMD_OUTQ_FLUSH, SCTP_NULL(=
));
> +       }
>
>         /* ADDIP 4.1 B5) Restart the T-4 RTO timer. Note that if a differ=
ent
>          * destination is selected, then the RTO used will be that of the=
 new
>
I don't really understand why OUTQ_FLUSH is needed if the chunk
was not enqueued by this timeout.

Can you share the reproducer to help understand what caused the
chunk to not be transmitted on time?

Thanks.
