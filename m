Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1209C2D0602
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788110500; cv=pass; b=kjqyoVZbmOLmi65E1ViFP/3NO0DzS44aCSrlb3cjVXZYX15DXz+V+IqYEZel3a9eOBfovYKYAO9IoHcVfEX/tVpnZfVXLpkdehDityiYUtvaG3bTVFIKOPRyf+UK//jmAqyfDldJQMkwbXxldkanCpbnXmcl9HSCEtUGXss9Xh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788110500; c=relaxed/simple;
	bh=rc2awGjfnIUiaTQDZSJVBQl0ApTrUMSoFAt6Grr06sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFoEmI8nQ5nozlJijS+VfZZ7sNy7M/lOxvCIVDfD0TGnPcEVJy9sXrdt7rgJbARixafh1PgGv7sXj7YC5KWbGQlT4TM9cK1F9yKhMjaTqocmf9kzVuCi6Luk8xsIvJe5hwyNiMAvtDZ0IvKphvqnjPlYaLj+IGQSGI6hm6PAUuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YY28dlXv; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YY28dlXv"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52eaeddc837so19028271cf.2
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 10:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788110498; cv=none;
        d=google.com; s=arc-20260327;
        b=JGniQxMRE+jfSXKb31Esfjs/n2hUdFT+s5+bCdzVF00vy8Ml8jbKm60oyMVcl8kxYu
         r5yb6YrY474TzzwIg5W98YQ4xkyeQ2rjPxkXAm4OI8NTSnmH9C10t951ng8hIzLlPdcy
         2WvH/2QAbmMKFOw+mDYOVu3XWAvcx0lYaKYvlXYN6FuE1OWl5erCqDVCiCiZ8WlpOYUK
         AjuN6eBouekTYh7naN0TOgkkpXNKZ+N/BHVz9l42QCAtfckHR92bkRm/A5jRYzkPVuKu
         xXWhLFOe9jRDzdvYS/CpNo5jqiMWzI6NPz14dQzP3dEWEp+5N/eckZtNKUzFpXMI9O0Z
         UQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d9l5qjCbxp2b2AbJBSOMN07vxCyH9AiUVcnCoSPaxqs=;
        fh=ewaFLL0+CzhAHnakTqR3pAayIjcFrd/AHG5c9rAiTVg=;
        b=jxLleV72jmFOEDNOQpewB9CJ+diSilzJ7N94TrXR79azQs9177UPA+Y1/B3LUaU8Up
         cwYFbFSYHYK2PwmQGas4wRgMzXFlho5TAqpd2fYYqUe0sMOW20bk/30sr8p0bOAL0/0w
         pQsnkvrTz2pTuuX5zzzJgfQd4JPwK2iuU6kfCPT+xtHGONQ+jq9FQ5aa4601Q94ZnTt0
         aLT+0Ntf05NUR8YmkFZq8YrqddTqsPDzrGpF/RZTCmVgRTqYk8BK4VzXsWeEeb2Oqs8W
         8oMdbfrTb4VTHmQwY4B0NPE0K0yyNy30OgQnAr9oONnR4GJGKVDngCGa+b71r8c5sIgV
         Fn4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788110498; x=1788715298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d9l5qjCbxp2b2AbJBSOMN07vxCyH9AiUVcnCoSPaxqs=;
        b=YY28dlXvlE9gBgl1pnVBLngIko74nQAwhHbzN7TpMa3rLduD/b1kc2fO58ei82/fyG
         iRFkNFgBLOorVGlm8s04figXYqocaj0Pdw/7w9IlDkpdJqoOC9bCEy+vHesoQ1VU0Ewh
         nV95kCk0Po6sIk7LkTf8l3AjKpNQChBAcLvlKcUeFSf1ts+tlwTSVQJkuQwOP1IPsLGP
         wZkbmUWIS4BK52bR6UplbnTGNjNS6pzN1KG/Z5i8K7gYeWpV5gyEmP9//2G6sgTzH882
         wz0uaPI35h+gPRk5O25ayRntxj/Tw1ygmVmOV2WugEfBEwzG6d11MaHiNoMaBcdGanlG
         wZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788110498; x=1788715298;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9l5qjCbxp2b2AbJBSOMN07vxCyH9AiUVcnCoSPaxqs=;
        b=OvE448S27NbnhHr3JEvgiUbNP0rxIf0HcCMWO7Ep8drKNfHAHSSUyCpbVG3CNH6S9X
         s73NpDRfbIcvKl/11CKpw8W0foINbT+pluxIWLQ7PAMoRm8Vnc/qkI5JswdVtlOAQuYI
         uACQCgeRk99BSXjGG5/EkpKLcs+PuyWpF8Z3+efnFS51H/+4F2lAhzNLKLfagPG+NyUr
         0PWci09eB6jxuWjkWfyql8+cP401442O2x6PPueh6XAVMSKKW9NQwRS47R0Y2pTnMklb
         GrIJyIbg954vqtcaD9zJDuXIO/ClS2oTggXbyNgvu2YIjzfzI75JJEAA5IGt2n0ZV9/z
         k5lA==
X-Gm-Message-State: AFuF++koBIHxkIIDPsuVZ7JTt5WlNPdhEt8k6jQUPtt8oPoC7/yP17Bc
	/0e4/UfD+y4lUDcwqngKxfPtc15bUPuK1qpzxTrk+9EGavX4IqM6i07H7v+Hcq2SWT342zXHmXZ
	rr06NBo5GLRkKwliS6q5YB+3Cze3/pQ6mIh+cSAS8
X-Gm-Gg: AR+sD122/1ccZTxmyON5tyn6N6L7iiIEPkd07liiQYO5faAtnpC4SuzoDDziKFhaaFT
	Yo9ODIDdA1qWu515/bxtZFmqIrfUrzlpspLvNOnHCvrq6r5U46wS2+ez5QVRGre/0EzzszfAn/w
	tuwGpKmDoVv2nw2sgRaPWPjSWgKfFjElZ1aSlDjdLf8IZPLgAmfIasqSCJfdX8sqWhTm7wgVLxZ
	cO4ShHHSNrPMKrACMWIQe6mLtKKW3gFs53kMYX8XKTF3JWT0b/uNPw+CUHhxxOKrTPvhv77/trU
	zLLhCUr4oBkwn96k3kulP5/KDlX5cSVgl0Bx4WrnmTe3LgkTRxXeG7Mfsis4ZmDciBGH9BP1In5
	uSBe09kkiqVQDaZYY1lhq9nSvJEf5TYwviv9DEaOj6fpm7vAJ6PEhC5zP2m/YLGz3klFWQg==
X-Received: by 2002:a05:622a:c15:b0:52d:82bf:d4cf with SMTP id
 d75a77b69052e-52fb94edecdmr263430201cf.16.1788110497192; Sun, 30 Aug 2026
 10:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829132021.2096728-1-michael.cohen3@mail.huji.ac.il>
In-Reply-To: <20260829132021.2096728-1-michael.cohen3@mail.huji.ac.il>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 30 Aug 2026 19:21:25 +0200
X-Gm-Features: AcwNN1W6s1uE9MS_t7fNCyrorkyRYUBUhwzxmB4h-Fq3Y91o37CMSqTeZsbgjLw
Message-ID: <CANn89iKip93AwhiXfhfaPszvP=t7Eaer=yHqQYcSWs-P2TYXUw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: reject completely old segments during
 sequence validation
To: Michael Cohen <michael.cohen3@mail.huji.ac.il>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	Tamir Shahar <tamir.shahar1@gmail.com>, Amit Klein <amit.klein@mail.huji.ac.il>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 3:20=E2=80=AFPM Michael Cohen
<michael.cohen3@mail.huji.ac.il> wrote:
>
> tcp_sequence() rejects an incoming segment when end_seq is before
> rcv_wup. Since end_seq is one past the last sequence number consumed by
> the segment, this misses the boundary case where end_seq is equal to
> rcv_wup.
>
> A segment that consumes sequence space and has end_seq equal to rcv_wup
> is therefore allowed to reach later processing, including ACK handling,
> even though it should be rejected as a completely old segment.
>
> Reject this boundary case for segments without SYN or FIN, while
> retaining the existing behavior for control segments and segments
> that consume no sequence space.
>
> One consequence of the early rejection is that, in some cases, a
> completely old duplicate data segment will no longer reach
> tcp_rcv_spurious_retrans(). For IPv6, this may prevent a retransmission
> with a different flow label from triggering transmit-path rehashing.
>
> We accept this trade-off because the segment is completely old and
> outside the receive window, and therefore should be rejected before
> normal ACK processing.
>
> We consider preserving the RFC 793 and RFC 9293 sequence-acceptability
> boundary for such data segments more important than preserving this
> side effect of processing an otherwise unacceptable segment.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Michael Cohen <michael.cohen3@mail.huji.ac.il>
> Reported-by: Tamir Shahar <tamir.shahar1@gmail.com>
> Reported-by: Amit Klein <amit.klein@mail.huji.ac.il>
> Signed-off-by: Michael Cohen <michael.cohen3@mail.huji.ac.il>
> ---
> Changes in v2:
> - Exclude SYN and FIN segments from the boundary-old check to preserve
>   existing SYN/FIN handling, including simultaneous connect
>   and retransmitted SYN+ACK AccECN processing.
>
> Packetdrill reproducer:
>
> // Off by one bug in tcp_sequence()
> // the negative test before(end_seq, tp->rcv_wup) has off by one error, s=
ince end_seq is SEG.SEQ+SEG.LEN,
> // whereas the RFCs require SEG.SEQ+SEG.LEN-1 (their positive test is RCV=
.NXT =3D< SEG.SEQ+SEG.LEN-1)
>
> 0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> +0 bind(3, ..., ...) =3D 0
> +0 listen(3, 1024) =3D 0
>
> +0 < S 0:0(0) win 12345
> +0 > S. 0:0(0) ack 1 <...>
> +0 < . 1:1(0) ack 1 win 12345
> +0 accept(3, ..., ...) =3D 4
>
> // This is not mandatory for the phenomenon, we just do this to increment=
 SND.NXT (set SND.NXT=3D101, retain SND.UNA=3D1) so we can show
> // later that the problematic segment is actually accepted (via the tcpi_=
accepted_bytes count).
> +0 send(4, ..., 100, 0) =3D 100
> +0 > P. 1:101(100) ack 1
>
> +0 < P. 1:1001(1000) ack 1 win 12345
> +0 > . 101:101(0) ack 1001
>
> // Now RCV.NXT=3D1001, so according to the RFC, a subsequent 1:1001 shoul=
d be discarded.
> // But in Linux, 1:1001 is accepted(!).
> // Note that bytes_acked is incremented to the packet's ack number, which=
 shows the packet is accepted.
>
> +0 < P. 1:1001(1000) ack 23 win 12345
> // +0 < P. 1:1000(999) ack 23 win 12345   // if you use this instead, you=
 get an assertion error, as expected.
>
> // this assert will succeed in the presence of the bug, but per the RFCs,=
 it should fail because the packet should have been discarded
> +0 %{ assert(tcpi_bytes_acked=3D=3D22) }%
>
>  net/ipv4/tcp_input.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index daff93d51..1991285aa 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4844,7 +4844,11 @@ static enum skb_drop_reason tcp_sequence(const str=
uct sock *sk,
>         const struct tcp_sock *tp =3D tcp_sk(sk);
>         u32 seq_limit;
>
> -       if (before(end_seq, tp->rcv_wup))
> +       if (before(end_seq, tp->rcv_wup) ||
> +           (end_seq =3D=3D tp->rcv_wup &&
> +            seq !=3D end_seq &&
> +            !th->syn &&
> +            !th->fin))
>                 return SKB_DROP_REASON_TCP_OLD_SEQUENCE;

This is a minor RFC compliance issue, so please be cautious about
added costs in TCP fast paths.

Please?

Something like the following, perhaps, because this is a very unlikely case=
,
we should have a single test capturing the unlikely checks.

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0f60a1dbf927468741f6f163e8d1b07687452c39..ebcb6d185443d49165a8a15672e=
73bdef358a59a
100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4844,9 +4844,12 @@ static enum skb_drop_reason tcp_sequence(const
struct sock *sk,
        const struct tcp_sock *tp =3D tcp_sk(sk);
        u32 seq_limit;

-       if (before(end_seq, tp->rcv_wup))
-               return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
-
+       if (unlikely(!after(end_seq, tp->rcv_wup))) {
+               if (before(end_seq, tp->rcv_wup) ||
+                   (seq !=3D end_seq &&
+                    !(tcp_flag_byte(th) & (TCPHDR_SYN | TCPHDR_FIN))))
+                       return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
+       }
        seq_limit =3D tp->rcv_nxt + tcp_max_receive_window(tp);
        if (unlikely(after(end_seq, seq_limit))) {
                /* Some stacks are known to handle FIN incorrectly; allow t=
he
