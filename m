Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022843803EF
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786595973; cv=pass; b=Svs67tsoa6uDIIH7Y4bQhyo0tZUQ2QsnVu0nRzx6dbnPVBhyqcY2OVfYXh1uZKAktCFBaeP2OyhqY/nz63H4zyMvec0W5e9/nbKrEnaCjpAiSC1OIgSQPr3PUFeLmTPTt88obr+f/1kQiMVIBf5yJLOJnpWCwEolsoiKMc0nonc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786595973; c=relaxed/simple;
	bh=oBTXkIyW/x69BIszhhxVkGO8m2A+9FMDWX94Rsdqpc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+jrTiivGsFC5C0AlBDxbC8kp1JuPz6rK1zCuZVC+UHaH3qo9JBg2ZKDTgfOusdD24MBo7i/Hs7P+MD0JJt1tsKmEhcQuV8QA47evYs/mbRteWk284YX+hFixzOhrTOw2OndXJUYCmt3sJQHNuNsTazIKwyKdP1iLHNT2Frux90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQcMGrdl; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQcMGrdl"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e85499ffbso138672185a.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 21:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786595971; cv=none;
        d=google.com; s=arc-20260327;
        b=hw1lum/66LLhn2IFI7LGbIOYRZ3kGQuo0VrXM1346XDHgU4jmUAPy4Svww9aaAiIAL
         ePDu0ELJWf5vvmHbtuTAKCf+M1Dfo6Do5rsLPRmy425ePmpE7hfo1d7XpFrUsQR2Riom
         S+jVkj2dZGr0OHC39P8CHHCt/qKA22mPaeq43KTeLx9ZCJ6cNJoksR9N47eXyZyTsfYV
         aKUVD1HNm4bq8JWpLogFmWi8W5KPVv3fHOPTNVbKRdwFcCNZa/PGM2DeYcs/n8O4DGVT
         63ibzeFd1U384MXVu4oGxAW8sEsCacVb/iu0/r5kzLPW/XDONEYC/MX6BZkvEPw7WDjp
         qt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YqW0lECmBeov0VOe50IhsjYJf8eJ2UEB66aY2Bgt9Ew=;
        fh=fvlOvtGk0uz5k3mgUduJhgRmWvAGLkZztTQY+O4nPQ4=;
        b=YaW0TWzBZ4CxCG87k07S4dBcwsc2iBF4TkkydsOB3isspmGlhhciu7cU8z/suE8VU4
         otR2LUryg0KJuNXfX8oHpaGIdQtixm2H7ixBqA1YhHZHOWVUHSirLobIw4ppUv1HxJCq
         RtovmQPsAjavUME20gk109CZuRk9jYw5nEEAy0Z9br4TxE6EqxZj+t9gVJ7CrK45OvNE
         DjTjZEYH38CLeCOLr7+MgsKIeNxfK8/RSN4TQONeLVEuuCyU+mZXJeHJnY0lB7HlkMAA
         cM24XOUSTFKPltSGHwW6+18ETHGVKY82FUWnFpEhBPeI7ADBo6zZrev4qGbGgTGNEi/X
         RnCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786595971; x=1787200771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YqW0lECmBeov0VOe50IhsjYJf8eJ2UEB66aY2Bgt9Ew=;
        b=SQcMGrdlnCK76xhOCNIAFVCQRScyExpwW6hX6iCuIB1WxwIHbuDwc/WunTInrTbBgc
         8tDhFZD5qzdX7PdguYzJyHI3BGiiYf9101DELuy08t1XBh7BNfcGuLXN2pOrlaD3fjkp
         i8vY0HmwYHLflmWEWovLGXQJAAZ4yZZNFp+glmUtv1TAytCwTTxC2klzV314cdIL91Ql
         1oOkH0Kk6wZ/nu7y/WLqn6RZSeff7rcE5ox7xVOH2YldUasQFt01zccv/GBDP7U1/57l
         2ErlwyW3a2crlf0368lDqwXn5PfP4nL2p5aPJiaGtMSRTpBoqpng+AMTJTIoXYCSr11u
         qb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786595971; x=1787200771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YqW0lECmBeov0VOe50IhsjYJf8eJ2UEB66aY2Bgt9Ew=;
        b=ZepSaRZmcWSXOn5qeE3OjZHQR20YGF1IFjSsWJ16RhHZZc5eHbwcRrjA+ikBYcsURH
         9hOfzB/u12rkQLNT4al8dQMqZHL9k8qZTkvmBfJ3ixEy4LB6fdQMOzMumzG0yLXk61dX
         nQJFZtmt6ui1nSaUCkkel1qUnPsfP9Cp45SQUZdsmeEMYuTEZbv7avhs75txsABYYGWf
         XKDkpsuNpOdApmn9IBO8Aqteo8kkEBLDZvXrTxt7nzE3SDYPkoubH6oa38V0dJGxB1Nw
         mPfadDy8tu8LMa6UbO2dTg9yqKwSDV01h0eQ1rzfsD+NGqocL8vnA1XNt5ZljCahqDNM
         brcQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHHOfH+Gg+r07w4LqhVowvq3x/rmQc+DnKCxG1RVwQvKq8/8Jh8VwXzX1NkhtXx9EU2pmPX9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQDJbdJRebaJJendzyEKYfdL4bqk0a9M0LOrVH0Rmn8X+AW2c
	/zbb0sGYB07/NJ39eGn0sFX0tF5JS3gtfkaDnY91JbK8QgpVb7LnpuyZCKvpdhFR82zyEZj78Ro
	bktpB/4pNJGUHr4pHrziX35QwnSrzIBqPULRa9wqG
X-Gm-Gg: AR+sD10ggM3dnoWttFhYnUN/WLUvnQAL+WARcBe+OmClCfojaW+kYuLEO8YYgkq2/Zv
	IasM3UzopUM39o1d/+BsUNSZMEkmoeLZdyyl2g/6SsiVD0R07AqbVhNZyo+KuCntFz/JNWuoL8T
	inwfEgUZTPQSJy73VVi2OqsAoVdG0gyeU4UC2/e4K5oNlOowuFffVIRHSWZD+Rqk8dap9sCb6QR
	nYp1NODNAujEbfxvd0ZLSlC9UnKGVlvt9A1DEEPhWAdZMHFFRb9d2HL6p24hzkfKM2XuDlRRznY
	tHrTvW3SoYpo/htq0EjJZLa0BpqKJjuZsk/k5sK3oimpzQVpVUNMKnPYDSd50uwq0XjVZcFhW8x
	EpHaypQF3cAWDWP4Sm/oesx34ggJXQ7B9novjkC765E9KCkifr28Yb7pe7DLq1LqkFamOrkJnlp
	/k53s0PEG8x/ufBRV1apUmseyEjA==
X-Received: by 2002:a05:620a:913:b0:931:5fce:46ba with SMTP id
 af79cd13be357-936bf8ece30mr253340885a.19.1786595970113; Wed, 12 Aug 2026
 21:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813033855.3372172-1-dongchenchen2@huawei.com>
In-Reply-To: <20260813033855.3372172-1-dongchenchen2@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Aug 2026 06:39:13 +0200
X-Gm-Features: AUfX_myydVtRfzw8QcKg41uCNK9IWuP-PExClnBkDLWP6NkiC064pbzUlXfGkak
Message-ID: <CANn89iLCrzmOfUVwa0yeROpkZxWmVsAkbH7=SBA3XuVxkmTfKA@mail.gmail.com>
Subject: Re: [PATCH net] net: iptunnel: fix stale transport header during
 tunnel decapsulation
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org, horms@kernel.org, 
	herbert@gondor.apana.org.au, kuniyu@google.com, idosch@nvidia.com, 
	andrew+netdev@lunn.ch, ap420073@gmail.com, steffen.klassert@secunet.com, 
	laforge@gnumonks.org, jiayuan.chen@linux.dev, jhs@mojatatu.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 5:30=E2=80=AFAM Dong Chenchen <dongchenchen2@huawei=
.com> wrote:
>
> Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
> transport_header offset after tunnel decapsulation.
>
> BUG: unable to handle page fault for address: ffffed102091a42e
> Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-rc4-00061-=
g248951ddc14d #256 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> RIP: 0010:__asan_load2
> <IRQ>
> qdisc_pkt_len_segs_init (net/core/dev.c:4145)
> __dev_queue_xmit (net/core/dev.c:4787)
> br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
> br_handle_frame_finish (net/bridge/br_input.c:229)
> br_handle_frame (net/bridge/br_input.c:315)
> __netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
> __netif_receive_skb_list_core (net/core/dev.c:6287)
> netif_receive_skb_list_internal (net/core/dev.c:6445)
> napi_complete_done (net/core/dev.c:6813)
> gro_cell_poll (net/core/gro_cells.c:74)
> __napi_poll (net/core/dev.c:7735)
> net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
> handle_softirqs (kernel/softirq.c:622)
> do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
> __local_bh_enable_ip (kernel/softirq.c:450)
> tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
> tun_chr_write_iter (drivers/net/tun.c:2032)
>
> The crash requires four conditions to line up:
>
> 1. The incoming packet is encapsulated and carries GSO metadata.  The out=
er
>    transport header offset is stored in skb->transport_header while the
>    packet is still in the outer tunnel context.
> 2. The tunnel receiver strips the outer headers.  skb->data is advanced t=
o
>    the inner frame, but skb->transport_header is left pointing to the
>    now-removed outer L4 header, so it becomes a negative offset relative =
to
>    the new data.
> 3. The inner frame is not delivered to the local IP stack.  Instead, it
>    is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never runs and
>    the transport header is not reset to the inner L4 offset.
> 4. The forwarding path calls __dev_queue_xmit(), which enters
>    qdisc_pkt_len_segs_init().  That function computes the GSO header leng=
th
>    from skb_transport_offset(skb).  Because the offset is negative, the
>    unsigned cast overflows and pskb_may_pull(skb, hdr_len +
>    sizeof(struct tcphdr)) reads past the end of the skb, triggering a
>    KASAN fault or page fault.
>
> Fix this by clearing skb->transport_header to the ~0U sentinel at the
> tunnel decapsulation boundary, after each tunnel receive function has
> finished all processing that needs the outer L4 header and before the skb
> is handed to GRO or the stack. The IP/GRO receive paths then set the
> transport header correctly when they parse the inner packet.
>
> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")

This Fixes: tag seems pretty random to me. Issue was present long
before that commit.
Next time, please be precise with the `Fixes:` tag; it's not decoration.

Also, calling skb_unset_transport_header(skb) directly from
gro_cells_receive() would make more sense and
your patch would be less intrusive.

pw-bot: cr
