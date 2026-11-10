Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344651;
	b=Vopf/tEaqa6CfKwTeulJoG0mihzpQjTHRe82QBtTIOASZLRxMwtxDFwoWRvymy/GR79F
	 iZqwCK9dsiVRgQoBeZNIAsTiN2Jlm2HiaDBY0szAw33p5UmbhClqmqahXJDiFLyfSVj+j
	 vZj+8DuCZa4PjsByNnlZJ8oRo1LFXas6od4hsIC00kWDJqkxHGZBgzhzNu6UAqmpGAehs
	 l3nmoeaS3kaj7Xd/OWaU3q1ntUOGIXieUiwixbjioNrPSpS0u5y2Cm3hxXHANU2+OoQrk
	 /wHnQbKHgb9Fdi3bSi1pA/bJvPaVMGPsar25OFVje8ZdWu/dsqvYeaJPN90lZ0dif7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344651;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=57yYrHJT4ReFtVZrtxq8Bs7gyyivOrinDzfX1ixf2+o=;
	b=Epyq9v1Df4doG9zf3KQkHAUBWFYSwd7NGeRe25+qT5xjb8E7LRkAV+7PafOxEZwnl84/
	 UrtI0PrLy3xWxtXzaxUw7JWNd57Tz177SKsNn9tJCDBDa24PewhA+lw2T7Vd0RfOC1csd
	 XjmlKqgd1+P5CHBXaXyyp+NmyGcLmf0r0ro3q6aU1lWt+P0JAP68RVnZzMcAb9JASDo5z
	 pk8RzKPFE3XtkLHoA5wGEKqlFiSCL7bItEwAJAg6gFu1a9YrvPIme1j49/oERhUPYW8cC
	 WTHnjCMCKPCHYX6wBGm8BgnIFnv07Pk8pad2urLO6OR4NyV72/Vw4L22vazi5URyQIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dwes0ng5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8A606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dwes0ng5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B821F008A6
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344651;
	bh=57yYrHJT4ReFtVZrtxq8Bs7gyyivOrinDzfX1ixf2+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Dwes0ng5S1VZa6KM1I/LiMdtOloXbK/ou+5oLmL04FpxkWM2TnK34/vkTID4jZK39
	 aXyLEMzisitFexRK9le81fkkPZams0scmrvQOQkkICn6HefTWvvxy1TWzqNX17yChb
	 yWfA4v6OmbedYFKQJiwJWoakKcFzZSMwpSj/YSODjIJ/Ts7cTCh083++MPsx2K2u93
	 opbBZjyem8+9k1DaUzFNWaCfht4A0YiA5qIdyC8+Mj7c7hTax9Bk8Iqek+3XkFLsSQ
	 vNTQ0TIppU3LerWE5lIVbkjWmG0OXIVAtbDDtrHPCjvMHEcll7csOzDFV5HYEozueD
	 fVWG6tYuUXGtQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6fe4372c5f3so1399164eaf.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:04:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH2/vikLmcRF3iHYdAuyBuwGFDu5RGszdpZLKSekdscRKctAI/3n6EVNTeu2qDLdCTmfra2mN8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hUhbZE9k2u75iwPFPtv0q28oiVyFL+xecUafZ2y6a6cLTFX71
	5Vdz7rwfqVo7lgZgbFubFXYXG+FUWwfG73P24bRPj8up7sG/22ihNqCRH+/Ob1Djr50yju6+yDt
	TxBfn2X7vgc0I3Zzpm0a78U4lZ+D4AHA=
X-Received: by 2002:a05:6820:c0c9:10b0:719:150a:4368 with SMTP id
 006d021491bc7-7191788d824mr121716eaf.35.1794344650366; Tue, 10 Nov 2026
 13:04:10 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109172356.3113732-1-edumazet@kernel.org> <179434225619.994134.848424997770273753@kernel.org>
In-Reply-To: <179434225619.994134.848424997770273753@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 10 Nov 2026 22:03:59 +0100
X-Gmail-Original-Message-ID: <CAL4WiioRHu6gM+CePJeU=PyWoGrxuRj+QTn5p7rN6yTyHzBpaw@mail.gmail.com>
X-Gm-Features: AclHuK813gpUxuRX-1XNnmEX1hlOBA8XisEdP9lkqPRItM8xc1j7gLzKq6V0M7o
Message-ID: <CAL4WiioRHu6gM+CePJeU=PyWoGrxuRj+QTn5p7rN6yTyHzBpaw@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: cubic: avoid looping in bictcp_update() TCP
 friendliness code
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	ncardwell@google.com, kuniyu@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 10 nov. 2026 =C3=A0 21:24, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] tcp_cong_avoid_ai() (net/ipv4/tcp_cong.c:480) runs `u32 delta =
=3D
>   tp->snd_cwnd_cnt / w;` and never checks that w is non-zero.
> - [Medium] net/ipv4/tcp_roccet.c has its own copy of bictcp_update(),
>   derived from CUBIC, with the same TCP-friendliness loop this patch=E2=
=80=A6
> - [Low] cubictcp_register() (net/ipv4/tcp_cubic.c:527-528) has the
>   comment `/* bictcp_update() needs (cwnd * beta_scale) >> 3 to be >=3D 1=
=E2=80=A6
>
> --
>
> tcp: cubic: avoid looping in bictcp_update() TCP friendliness code
>
> This commit replaces the subtract-and-increment loop in the TCP
> friendliness part of bictcp_update() with one division, and clamps delta
> to at least 1. It addresses a CPU hang that happens when a BPF congestion
> control stores arbitrary values in snd_cwnd and icsk_ca_priv and then
> calls cubictcp_cong_avoid() or switches the socket to CUBIC.
>
> Link: https://lore.kernel.org/netdev/179363987528.3131.298777648942707988=
7@kernel.org/
>
> > diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> > index a88e4bf86150f..e74dabde34324 100644
> > --- a/net/ipv4/tcp_cubic.c
> > +++ b/net/ipv4/tcp_cubic.c
> > @@ -298,10 +298,16 @@ static inline void bictcp_update(struct bictcp *c=
a, u32 cwnd, u32 acked)
> >       if (tcp_friendliness) {
> >               u32 scale =3D beta_scale;
> >
> > -             delta =3D (cwnd * scale) >> 3;
> > -             while (ca->ack_cnt > delta) {           /* update tcp cwn=
d */
> > -                     ca->ack_cnt -=3D delta;
> > -                     ca->tcp_cwnd++;
>
> [Severity: Medium]
> net/ipv4/tcp_roccet.c has its own CUBIC-derived bictcp_update(), and it
> still has the same loop:
>
> net/ipv4/tcp_roccet.c:bictcp_update() {
>         ...
>                 delta =3D (cwnd * scale) >> 3;
>                 if (delta > 0) {
>                         while (ca->ack_cnt > delta) { /* update tcp cwnd =
*/
>                                 ca->ack_cnt -=3D delta;
>                                 ca->tcp_cwnd++;
>                         }
>                 }
>         ...
> }
>
> The delta > 0 check rules out a zero delta. Does the huge ack_cnt case
> from the commit message still apply there?
>
> sol_tcp_sockopt_congestion() in net/core/filter.c blocks only "cdg". A
> BPF CC can therefore call bpf_setsockopt(TCP_CONGESTION, "roccet") and
> then overwrite icsk_ca_priv with epoch_start !=3D 0 and
> ack_cnt =3D 0xFFFFFFFF. With the default beta, beta_scale is 15, so
> snd_cwnd =3D 1 gives delta =3D=3D 1.
>
> The next ACK reaches roccettcp_cong_avoid()->bictcp_update(), and the loo=
p
> runs about 2^32 times in ACK processing context.
>
> Should the same max(..., 1U) plus division change go into the ROCCET copy=
,
> perhaps as a companion patch?
>
> > +             /* BPF congestion controls can call us with any cwnd
> > +              * and ack_cnt: cwnd * scale can wrap and give a zero del=
ta,
> > +              * and a loop could run up to 2^32 times.
> > +              */
> > +             delta =3D max((cwnd * scale) >> 3, 1U);
>
> [Severity: Low]
> This isn't a bug, but now that delta is clamped here, is the comment in
> cubictcp_register() still accurate?
>
> net/ipv4/tcp_cubic.c:cubictcp_register() {
>         ...
>         /* bictcp_update() needs (cwnd * beta_scale) >> 3 to be >=3D 1 */
>         beta_scale =3D max(beta_scale, 8U);
>         ...
> }
>
> bictcp_update() now guarantees delta >=3D 1 on its own. The new comment a=
lso
> says cwnd * scale can wrap to zero anyway.
>
> The registration clamp is no longer needed for loop safety. It still
> overrides the beta module parameter when beta < 512, which changes the
> Reno emulation rate.
>
> Could the clamp and its comment be dropped or reworded, or mentioned in
> the new comment here?
>
> > +             if (ca->ack_cnt > delta) {              /* update tcp cwn=
d */
> > +                     u32 n =3D (ca->ack_cnt - 1) / delta;
> > +
> > +                     ca->ack_cnt -=3D n * delta;
> > +                     ca->tcp_cwnd +=3D n;
> >               }
> >
> >               if (ca->tcp_cwnd > cwnd) {      /* if bic is slower than =
tcp */
>
> [Severity: High]
> Under the threat model in the commit message, can this still divide by
> zero in tcp_cong_avoid_ai()? In that model, a BPF congestion control
> writes arbitrary values into icsk_ca_priv and snd_cwnd and then calls the
> cubictcp_cong_avoid() kfunc.
>
> The early return in bictcp_update() skips the final clamp on ca->cnt:
>
> net/ipv4/tcp_cubic.c:bictcp_update() {
>         ...
>         if (ca->last_cwnd =3D=3D cwnd &&
>             (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
>                 return;
>         ...
>         ca->cnt =3D max(ca->cnt, 2U);
> }
>
> A BPF CC can set ca->cnt =3D 0, ca->last_cwnd =3D snd_cwnd and ca->last_t=
ime
> to a future jiffies value. It can do this in its own priv area before
> calling the kfunc, or after bpf_setsockopt(TCP_CONGESTION, "cubic").
> cubictcp_cong_avoid() then passes the unclamped value as the divisor:
>
>         bictcp_update(ca, tcp_snd_cwnd(tp), acked);
>         tcp_cong_avoid_ai(tp, ca->cnt, acked);
>
> tcp_cong_avoid_ai() divides by w without checking it:
>
> net/ipv4/tcp_cong.c:tcp_cong_avoid_ai() {
>         ...
>         tp->snd_cwnd_cnt +=3D acked;
>         if (tp->snd_cwnd_cnt >=3D w) {
>                 u32 delta =3D tp->snd_cwnd_cnt / w;
>         ...
> }
>
> With w =3D=3D 0, both snd_cwnd_cnt >=3D w tests are always true, so the
> division runs for any acked value. In NET_RX softirq context, would this
> oops and end in a panic?
>
> The ROCCET code already guards the same call:
>
> net/ipv4/tcp_roccet.c:roccettcp_cong_avoid() {
>         ...
>         tcp_cong_avoid_ai(tp, max(1, ca->cnt), acked);
> }
>
> There are also more direct routes to the same division:
>
> - The tcp_cong_avoid_ai kfunc is registered in
>   bpf_tcp_ca_check_kfunc_ids, so it can be called directly with w =3D 0.
>   The verifier only checks that w is a scalar.
> - tcp_reno_cong_avoid() passes the BPF-writable tcp_snd_cwnd(tp) as w.
>
> Would a guard such as max(ca->cnt, 1U) in cubictcp_cong_avoid(), or a
> clamp on w inside tcp_cong_avoid_ai(), be needed to fully close this bug
> class?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261109172356.3113732-1-edumazet%40kernel.org

Ok, I do not think we can fix this then.

eBPF is what it is.

pw-bot: cr
