Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E730EF97
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788708090; cv=pass; b=R9DVbKv+RHksOFhV6lGSEP00ZeCPBw5RgmVG+w9Fzku0f5cKkmImNgE3MG0HISxUz+C6X6SqaX2sKLdK8/PQQf9YAZbnmdkK526xurAYGquVPaDLeBWrW0oynia9dbjIZH4GHez4efHdD3LZcBjl/cg+tKFk5G4A33NH6yBQzvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788708090; c=relaxed/simple;
	bh=LFOwrLkyPBKyNRbuTjUWsGqIJC+VDeAwPu6b+AJEr+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5+xkwG+htKY+bhsNr9J1lNyDNdueb/GBVTQQv+k8RGGJ7ByTKuylJ5vpHWOdrVThfJA1NJb+7Ti/3GeBUH6PW0DOJTAC5UbYYeQUB8qJRe0eWP4vV1Vxu8Eq+AbAhv7q+bWE097im88zDg95DSHKnBGY7d7Yi+rf6C/6xo22UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MLaCtnwn; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLaCtnwn"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5306baf6b53so19643631cf.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 08:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788708087; cv=none;
        d=google.com; s=arc-20260327;
        b=rIJHicmGQttqWPFf/cbCwQSZ3XIJx2hZSGSIrTYQcocATyI9TLUt3Yek94biS7YgFE
         Nve/I4XDRY9Ogaryt95uUWzjQ10bXycExgLhcOzCp2jK/IvaFu4ryeTJm+wW2UftwlqQ
         VjdNzBk5UZsU+pEHZKHBsRAwFXzduakk9bei+fgIbtaxf+9LbOrH/KtWAW/VDlOCWl0G
         WcV2/kmQBngLOXyozhxpBloZgUOrR/DSJS8yBuGWXLzXo4mjI6Z4h1IIPkR3XmTMmYac
         q8/CgjJg44e834igiLc49qGQ7YvXFRqnyoZIWOmtru9FW4Uj7QBnbon6tB8k/cuJaWO7
         n5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fs6XUMvGp+baARz1Qk60hvLbKLNjQnZThXQfdcJnmLw=;
        fh=FPuMdgAyt7Oe25yEdEqr0NY+y/jzlUxqu45/cGAU0sc=;
        b=gabD4FdDERGOj5mvK4sLHpaw83GnbIloUbY0fQrUQ2Lq4SVMKsMx3/QXC+cpATAwNj
         YV1QObO+1Acwnu4r06XMiOHfeSvVrIKpCOzx28moRZ+7f4SW2yULKwXNXqI6eZNyd8oO
         OcQ8bSo4QwOau5ZqO8aeb7zF200sq0OTbhSJmMTmkq4VVIxjbUI0vSOa4jHVbIaD8J3V
         Xi8CJjo+PIJB5hLDGYzd8LRg6G9t0PeFUayuIATuI64+4VoaQcjaREVQJCj8rfCCUiZT
         4BM9SCoRZ1/mcgsCMq0qnyfBWlkQaC8wvVrdE4IdyuXa8+tUAbqgkwt9iEoPZ6d6jhGX
         Q/7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788708087; x=1789312887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fs6XUMvGp+baARz1Qk60hvLbKLNjQnZThXQfdcJnmLw=;
        b=MLaCtnwnqOmU6GacYdE+OkbSaZdxo5b9/wpp5UWKAd78Fbje14If7g35Dm2JpZfFzN
         icdVYFnbj1Ig0/mNt5cClzj8p7BYyMX3KYLgBx5l7x9QtOs1fNHVwil2FkbMitF+c7cK
         9H3q31BgZotWB4s/qgt5KN0sZyFb5mKHs2/DX/l8zk0gd+wRulYdyHV30YpmHtG3tGXq
         W6O6TcRLCRZEicRRDbfqhg7FEHrh0zbG5Rgknb6MijiyaMdlUjEG05XCaXF0iagU5Ru0
         I08F9JS518I3//gmvEAQwPxvL7RUZI8IeJvPfmjSZAt2lFdFLXRnPKnV82qcassUvl6U
         zu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788708087; x=1789312887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fs6XUMvGp+baARz1Qk60hvLbKLNjQnZThXQfdcJnmLw=;
        b=i1rI4BK0+4oPf9PHxHsCwx/ANnuzwUc04QPXKU75xYy/ZsYwcg7aYK7wwxBxAAM9ez
         MfmBwA5SAx8z+vkpCRYprmTQwxZVXrGjr3aDBpyOY0P2Kbtc6HjJEIIDjnMradr2PeZf
         0GnDIiVqnRGfI3XWugrsGvLA6ZfEVPHlX00pM1Bs9l9KmOyWExFz2s3j+92wP9GECYV/
         N0bojKR8WjkCiV9Ai/yEueQVPOb1Fgqx2ocL/2Ir1RS28bMJuCPmtd/2BPiuYQag+quX
         KAx4dRy21XoLMiWncH6TX7Q4wYSqto2Gri9DLAXgO/uVY37ZHbZmZiv7HnemUqIpI2Ep
         ZMgg==
X-Forwarded-Encrypted: i=1; AKwUvBz34om2uSQl2K3D9jg7qF3/FsKPC4qUF7wM19osxioy3ze8WUaVvVmeth8at7rf3ZE38au5poo=@vger.kernel.org
X-Gm-Message-State: AFuF++kTHtlNt1i1scyWLoAp7Khh+pFrtYCIBbTdG91xkdABL8R1aosN
	wyOUR4ldvExxQiIsSemZPNhLDvDoyAj1OiI40Pnm40A+os951FQ78WJy7D7s/LP6fw0P2yQrXvZ
	gc3mOhwyw611bpH2Kuis69/JM+82jxYTKEtHeI7+q
X-Gm-Gg: AYBFou1UBwhymdj5Pxl8fr6WqOzaDjaCGStV/aWQUWg3rrQ5xc78uFQrLXKLRm96qpB
	a18LJKVKnV3V3v9LKxWKJPeZVC8VsZl0kTgbewkKGgmIS3nU0/r7dD5U6zw5OLsHURVG7h3Ku0H
	XMDswJiWNs3HYnUP8niTivlp1VrNdoOEPS5xQaCY7ffFjEvEZEolx4EeXBhYKPwmXYaFjdiC4WT
	zMFRLjJdPTiRU2Nn341mVDtHfSfd66A95KqaTk8xqVAqU3/wRpLW+tptbFaeDOpMiXimkqpOD9R
	AFZmYAp/vLXqPaWSJ8ysWwRDWnbM3MsMaFeo7rKcRBgmXkT5PmdvnOzVd6YmLIAzdWKAlOHWIui
	7dAw6Kp7nN6JOGNQ8IIpbQnN8xhydKGkEluzszSn/Imxeqefd0aBYI8OW2IpTMOgiKk7f
X-Received: by 2002:ac8:5fc8:0:b0:51b:ec6c:766c with SMTP id
 d75a77b69052e-530546a82admr168582461cf.12.1788708086577; Sun, 06 Sep 2026
 08:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906123151.1391349-1-inbal.lipshtat@mail.huji.ac.il>
In-Reply-To: <20260906123151.1391349-1-inbal.lipshtat@mail.huji.ac.il>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 6 Sep 2026 17:21:14 +0200
X-Gm-Features: AcwNN1WQXnyvmj9l2_bsUIwHuwiFXu_9bQaNcLrHVCLBPE8dwq4euhetf9-yCEQ
Message-ID: <CANn89iLLWbqTk4zCaa3cB9BJAC1MmUjVBMXXPJGgzw37u+s_Lg@mail.gmail.com>
Subject: Re: [PATCH] tcp: validate old ACKs before fast path data processing
To: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
Cc: ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, Amit Klein <amit.klein@mail.huji.ac.il>, 
	Tamir Shahar <tamir.shahar1@mail.huji.ac.il>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 2:32=E2=80=AFPM Inbal Schussheim
<inbal.lipshtat@mail.huji.ac.il> wrote:
>
> For incoming TCP segments processed in the fast path,
> Linux does not enforce the RFC5961 requirement:
>
>    The ACK value is considered acceptable only if
>    it is in the range of ((SND.UNA - MAX.SND.WND) <=3D SEG.ACK <=3D
>    SND.NXT).  All incoming segments whose ACK value doesn't satisfy the
>    above condition MUST be discarded and an ACK sent back.
>
> Meaning the ack of incoming segments is no earlier than a window back
> from the first unacknowledged sent byte.
>
> Later work showed that the condition (SND.UNA - MAX.SND.WND) <=3D SEG.ACK
> can be further tightened, eliminating some demonstrated TCP data
> injection attacks, resulting in CVE-2023-52881 assigned by Linux and
> the 2023 patch:
> Commit 3d501dd326fb1c7 ("tcp: do not accept ACK of bytes we never sent")
> that rejects ACKs for bytes so far back that were never sent.
>
> Link: https://www.cve.org/CVERecord?id=3DCVE-2023-52881
>
> Both RFC5961 and the later patch were only applied to the slow path,
> leaving the fast path vulnerable and noncompliant with RFC5961.
>
> Enforce a validation test for the SEG.ACK in the fast path, before the da=
ta
> is processed. Failure to pass the validation will result in a challenge A=
CK
> and the packet will be discarded in compliance with RFC5961.
>
> Some details:
> RFC5961 (and the 2023 patch) is enforced in tcp_ack()
> (./net/ipv4/tcp_input.c).
> Incoming segments to a socket in ESTABLISHED state are processed in
> tcp_rcv_established() (./net/ipv4/tcp_input.c).
> Consider a packet that violates RFC5961 (meaning the SEG.ACK is too early=
).
> In the slow path (starting at the label "slow_path"), tcp_ack() is invoke=
d,
> well before processing the segment data.
> A challenge ACK is sent there, tcp_ack() returns
> -SKB_DROP_REASON_TCP_TOO_OLD_ACK,
> and slow path discards the segment as expected.
> In the fast path, tcp_ack() is also called,
> but only after the data from the segment is processed.
> Furthermore, the return value from tcp_ack() is not checked.
> De-facto, the data from the segment is accepted
> (and an ACK is generated), even though the segment violates RFC5961.
>
> The following packetdrill script shows the issue at hand.
> Linux (as a server) accepts data segment processed in the fast path with
> an ack that is far too low.
>
> // BASED ON PACKETDRILL SCRIPT FROM:
> // Commit 3d501dd326fb1c7 ("tcp: do not accept ACK of bytes we never sent=
")
> 0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> +0 bind(3, ..., ...) =3D 0
> +0 listen(3, 1024) =3D 0
>
> // ---------------- Handshake ------------------- //
> +0 < S 0:0(0) win 65535
> +0 > S. 0:0(0) ack 1 <...>
> +0 < . 1:1(0) ack 1 win 65535
> +0 accept(3, ..., ...) =3D 4
>
> // Data must be first sent/received on the socket
> // so that memory is allocated (sk_forward_alloc should be > 0)
> // and later data will be proccessed in the fast path
> +0 < P. 1:501(500) ack 1 win 65535 //valid packet forcing memory allocati=
on
> +0 > . 1:1(0) ack 501
>
> // incoming segment, ack way in the past... (101 + 2^32 - 1500000000)
> // Oops, unpatched kernels happily accept this packet
> +0 < P. 501:1501(1000) ack 2794967397 win 65535
>
> // On unpatched kernels, this ACK will match,
> // showing that the segment is accepted
> +0 > . 1:1(0) ack 1501
>
> Reported-by: Amit Klein <amit.klein@mail.huji.ac.il>
> Reported-by: Tamir Shahar <tamir.shahar1@mail.huji.ac.il>
> Reported-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
> Signed-off-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
> ---
>  net/ipv4/tcp_input.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index daff93d51342..2474871e80ec 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4272,6 +4272,17 @@ static void tcp_rack_update_reo_wnd(struct sock *s=
k, struct rate_sample *rs)
>         }
>  }
>
> +/* Validates that the ACK is older than the acceptable historical ACK wi=
ndow*/
> +static inline bool tcp_ack_too_old(const struct tcp_sock *tp, u32 ack,
> +                                  u32 snd_una)
> +{
> +       u32 max_window;
> +
> +       max_window =3D min_t(u64, tp->max_window, tp->bytes_acked);
> +
> +       return before(ack, snd_una - max_window);
> +}
> +
>  /* This routine deals with incoming acks, but not outgoing ones. */
>  static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>  {
> @@ -4303,12 +4314,8 @@ static int tcp_ack(struct sock *sk, const struct s=
k_buff *skb, int flag)
>          * then we can probably ignore it.
>          */
>         if (before(ack, prior_snd_una)) {
> -               u32 max_window;
> -
> -               /* do not accept ACK for bytes we never sent. */
> -               max_window =3D min_t(u64, tp->max_window, tp->bytes_acked=
);
>                 /* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation=
] */
> -               if (before(ack, prior_snd_una - max_window)) {
> +               if (tcp_ack_too_old(tp, ack, prior_snd_una)) {
>                         if (!(flag & FLAG_NO_CHALLENGE_ACK))
>                                 tcp_send_challenge_ack(sk, false);
>                         return -SKB_DROP_REASON_TCP_TOO_OLD_ACK;
> @@ -6614,6 +6621,15 @@ void tcp_rcv_established(struct sock *sk, struct s=
k_buff *skb)
>                         if ((int)skb->truesize > sk->sk_forward_alloc)
>                                 goto step5;
>
> +                       if (unlikely(before(TCP_SKB_CB(skb)->ack_seq, tp-=
>snd_una))) {
> +                               if (tcp_ack_too_old(tp, TCP_SKB_CB(skb)->=
ack_seq,
> +                                                   tp->snd_una)) {
> +                                       tcp_send_challenge_ack(sk, false)=
;
> +                                       reason =3D SKB_DROP_REASON_TCP_TO=
O_OLD_ACK;
> +                                       goto discard;
> +                               }
> +                       }
> +


Hi Inbal

I would suggest :

1) reduce the changelog to the problem at hand, not the old ones. You
do not have to tell a story.

2) Add a selftests (in a separate patch) instead of including it in a chang=
elog.

3) Make sure to handle pure ACK as well so that we avoid another CVE
in ~3 years, presumably from your team.

Segments with old ACKs (ack_seq < tp->snd_una) do not belong in the
fast path in the first place,
whether they carry payload or are pure ACKs.
In the pure ACK fast path, an ancient ACK would also bypass drop
accounting and update
timestamps/state before tcp_ack() returns an error.

Instead of duplicating the challenge ACK and drop logic in
tcp_rcv_established(),
we can simply tighten the header prediction check.

The so-called 'slow-path' is already taking care of this.

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0f60a1dbf927468741f6f163e8d1b07687452c39..89f9f3913b52ff468f3bd4b098c=
b5d0f3c45a9d2
100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6539,7 +6539,7 @@ void tcp_rcv_established(struct sock *sk, struct
sk_buff *skb)

        if ((tcp_flag_word(th) & TCP_HP_BITS) =3D=3D tp->pred_flags &&
            TCP_SKB_CB(skb)->seq =3D=3D tp->rcv_nxt &&
-           !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
+           between(TCP_SKB_CB(skb)->ack_seq, tp->snd_una, tp->snd_nxt)) {
                int tcp_header_len =3D tp->tcp_header_len;
                s32 delta =3D 0;
                int flag =3D 0;


Thanks!

pw-bot: cr
