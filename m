Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244317;
	b=BxycAogtObtFZTnfeTdGFVxFUnxKygBMG3/h9PXPL+XMafB4HAe7sLuHQsSxpupCpjhK
	 BP7c32KfI17283xPdGht1Xyu9qC+uZuZeLRFg+fHF/PKMsULHYf+7IzR/XDFfLeKhytdg
	 /UJfCPqn+lmreolEToLTEIXwIHg5f11YWmUTHzFSk3kFCMfI7l5OJKjtX31QmJ0C1MvG7
	 VB0wSTuyFDZdDnt8pYU8J5uYsaN3ifaRiVyBQkxYI73h3kjb7lDwC616+aUW9QUHJXPs6
	 WDPQLoP/xINAU1n8V8jUUR/37IcSe/+SrRWLIe8w8Q/iXYhg9tXA4Bsds/vACEpVM3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244317;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lQHWAAx+O6YYZwHBHSehA8caj2rOj0b72/Og+FIObkA=;
	b=TptMQtKHRUDADN8onXqoHjdKF9YXFSlhT9qeuyCv3MlKDo37ixBuGE+n7y81JjrOGAKb
	 Q9hk5N/mqR3F/hYyx3WKrmVL4HH0B+qbeWUfzkpQxaJCV6YVdiE1a5vYb5wonNezbwMyB
	 rqsP1fgvfYOohaLKfLEeZChuvaksRCypap5jtAxbrrT1p5w1B+aJuY6OgoVUTU/XNfACQ
	 UDS9Od7yIlrYFJZDEBUW/xJMLLFvED1jEANNe8qwgrlkuZwarmGmUY1Bcyc22G3h3pcms
	 3hetsM/ycA07sQ/6UJcedZQVjEdLqt+7vWvo0IorypPthYHcqIiRAQ+odIvBVz5uwxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyGLxwNJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC77606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyGLxwNJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A281F008A3
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794244316;
	bh=lQHWAAx+O6YYZwHBHSehA8caj2rOj0b72/Og+FIObkA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lyGLxwNJF9CY5t4AbZfIJdpvIeCJMXeHCw4NainKZ8hgAhimApwERkMfC+ijMepPc
	 4AvPtJ9poxrUV+BWNlxgJT3S3V6sbZ0kaxxAM8ZXcFsD+dzpqLdlvvZ/KsIgkpXMhw
	 NN+kSAIw8XTRwIyoRt4NTojKsle+488SILg5cgN6mlXF6eE6PIfdUUvoHCR5zrZH2B
	 XBb9Xw3lXXN+ntwW8qaL3nihwgi+gNfCCNiRI7iGvBFMidZ6H6U3LFC46XauSD5HS0
	 9BKczsbXUVjljPxPkvLd/rYod2bGT94y2DTeignAHB9XcODyalHTHFO7UEYaUBNsMB
	 XDX2cZoAsKnHw==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-847ac7ccd85so654010a34.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 09:11:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGulHFawAcZ2HUXs1wQh1DFdeYiP5Loagqr+KbG0IAjwlSiXTESD0k/cL9j4bQpQEU2DsqEYiY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ykE2kb3qVSqYVkJwjYXeqLQb5HqC5WIoN9HfFrrCL5oi9X8+9
	xjJn5t6mcTI79TsMlMzAJCSqYo+3Z9qotY+BLgJ6zaF3tYYVEC6TDKK1o8MfhHDZaNE/859Hwvk
	PvCDebFY5b5ds3TI7g5hIXpIdEcmxbmQ=
X-Received: by 2002:a05:6820:83c5:20b0:709:fa95:9929 with SMTP id
 006d021491bc7-7170f2dbc08mr1850037eaf.62.1794244315702; Mon, 09 Nov 2026
 09:11:55 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106133748.2181133-1-edumazet@kernel.org> <179424245454.994134.13469440240015313651@kernel.org>
In-Reply-To: <179424245454.994134.13469440240015313651@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 9 Nov 2026 18:11:42 +0100
X-Gmail-Original-Message-ID: <CAL4WiipPJ2sM9KykK9VBNiT05XADMLBPAaLiNu7xaFPi30yC-A@mail.gmail.com>
X-Gm-Features: AclHuK811EkTKpzG0EYUUCVDB7TIKzjpUNdJ6SRVEAn_ZfQaqoIR72kp1Q_VADk
Message-ID: <CAL4WiipPJ2sM9KykK9VBNiT05XADMLBPAaLiNu7xaFPi30yC-A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: cubic: do not trust snd_cwnd set by BPF
 congestion controls
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	ncardwell@google.com, kuniyu@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 9 nov. 2026 =C3=A0 17:40, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 (1) =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix is incomplete: a BPF congestion control can still stall
>   the CPU in the TCP-friendliness loop of bictcp_update() through the=E2=
=80=A6
> - [High] tcp: unsanitized snd_ssthresh in tcp_reinit_congestion_control()
>   hangs CUBIC
> - [Medium] tcp: BPF CC can overwrite snd_cwnd after
>   bpf_setsockopt(TCP_CONGESTION)
> - [Low] The new comment above the cubictcp_cong_avoid() wrapper
>   (net/ipv4/tcp_cubic.c) says bictcp_update() 'would loop forever ...=E2=
=80=A6
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it is in the
>   same 'BPF can store any value' threat model and is High severity.
>
> --
>
> tcp: cubic: do not trust snd_cwnd set by BPF congestion controls
>
> This patch turns the cubictcp_cong_avoid() kfunc into a wrapper. The
> wrapper ignores calls when snd_cwnd is outside [1, TCP_MAX_SND_CWND],
> while native CUBIC calls __cubictcp_cong_avoid() directly. It also
> clamps snd_cwnd to [1, snd_cwnd_clamp] in
> tcp_reinit_congestion_control(), to stop the TCP friendliness loop in
> bictcp_update() from hanging the CPU.
>
> Link: https://lore.kernel.org/netdev/179363987528.3131.298777648942707988=
7@kernel.org/
>
> > diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> > index a88e4bf86150f..9595bdc9589c2 100644
> > --- a/net/ipv4/tcp_cubic.c
> > +++ b/net/ipv4/tcp_cubic.c
> > @@ -318,7 +318,7 @@ static inline void bictcp_update(struct bictcp *ca,=
 u32 cwnd, u32 acked)
> >       ca->cnt =3D max(ca->cnt, 2U);
> >  }
> >
> > -__bpf_kfunc static void cubictcp_cong_avoid(struct sock *sk, u32 ack, =
u32 acked)
> > +static noinline void __cubictcp_cong_avoid(struct sock *sk, u32 ack, u=
32 acked)
> >  {
> >       struct tcp_sock *tp =3D tcp_sk(sk);
> >       struct bictcp *ca =3D inet_csk_ca(sk);
> > @@ -335,6 +335,20 @@ __bpf_kfunc static void cubictcp_cong_avoid(struct=
 sock *sk, u32 ack, u32 acked)
> >       tcp_cong_avoid_ai(tp, ca->cnt, acked);
>
> [Severity: High]
> Does clamping only snd_cwnd here still leave the same hang reachable
> through tp->snd_ssthresh?

Yes, and the Medium issue below (writes done after
bpf_setsockopt(TCP_CONGESTION) from a BPF callback) shows that
sanitizing snd_cwnd at entry points can not be complete.

v2 will instead make the friendliness code in bictcp_update() safe
for any cwnd and ack_cnt values: delta is at least 1, and the loop
is replaced by a division, only done when ack_cnt > delta.

>
> A BPF congestion control can write any u32 to tp->snd_ssthresh via
> bpf_tcp_ca_btf_struct_access(). That includes its .release()
> callback, which tcp_cleanup_congestion_control() runs just before
> this clamp. It can also return any value from .ssthresh(), which
> tcp_init_cwnd_reduction() and tcp_enter_loss() store into
> tp->snd_ssthresh. A BPF .ssthresh() can simply return 0.
>
> tcp_reinit_congestion_control() does not touch snd_ssthresh,
> icsk_ca_state or tp->undo_marker. With the default hystart and
> initial_ssthresh parameters, cubictcp_init() leaves snd_ssthresh
> alone as well.
>
> Suppose the socket is in TCP_CA_CWR or TCP_CA_Recovery when it is
> moved to CUBIC. The next ACK that advances snd_una past high_seq then
> goes through tcp_fastretrans_alert()->tcp_end_cwnd_reduction():
>
> net/ipv4/tcp_input.c:tcp_end_cwnd_reduction() {
>     ...
>         if (tp->snd_ssthresh < TCP_INFINITE_SSTHRESH &&
>             (inet_csk(sk)->icsk_ca_state =3D=3D TCP_CA_CWR || tp->undo_ma=
rker)) {
>                 tcp_snd_cwnd_set(tp, tp->snd_ssthresh);
>                 tp->snd_cwnd_stamp =3D tcp_jiffies32;
>         }
>     ...
> }
>
> This copies snd_ssthresh into snd_cwnd without any bound.
> tcp_snd_cwnd_set() warns once on 0 but still stores it.
>
> Later in the same tcp_ack(), tcp_cong_control() calls
> __cubictcp_cong_avoid() with snd_cwnd =3D=3D 0 and snd_ssthresh =3D=3D 0.
> tcp_in_slow_start() is false, so bictcp_update(ca, 0, acked)
> computes delta =3D 0 and the TCP friendliness loop never terminates.
>
> A snd_ssthresh between TCP_MAX_SND_CWND and TCP_INFINITE_SSTHRESH
> would instead leave snd_cwnd above TCP_MAX_SND_CWND. There
> cwnd * beta_scale wraps and the u32 multiplications in native
> ->ssthresh() handlers overflow, which is the state the commit message
> says native congestion controls must not see.
>
> Should tcp_reinit_congestion_control() also bound snd_ssthresh, for
> example to snd_cwnd_clamp or by resetting it to
> TCP_INFINITE_SSTHRESH? Or should it reset the CWR/Recovery state
> when switching away from a BPF congestion control? Or is there
> something that keeps tcp_end_cwnd_reduction() from running after
> such a switch that I am missing?
>
> [Severity: High]
>
> This isn't a bug introduced by this patch, but it falls under the same
> "BPF can store any value" threat model. tcp_cong_avoid_ai() is exposed as
> a kfunc through bpf_tcp_ca_check_kfunc_ids. It divides by w without
> checking for zero:

Right, this is a separate issue, I will send a separate patch.

>
> net/ipv4/tcp_cong.c:tcp_cong_avoid_ai() {
>     ...
>         tp->snd_cwnd_cnt +=3D acked;
>         if (tp->snd_cwnd_cnt >=3D w) {
>                 u32 delta =3D tp->snd_cwnd_cnt / w;
>     ...
> }
>
> When w =3D=3D 0 the guard is always true.
>
> Can a BPF congestion control reach this division by zero in any of these
> ways?
>
> - Call tcp_cong_avoid_ai(tp, 0, acked) directly. The verifier does not
>   range check scalar kfunc arguments.
>
> - Store snd_cwnd =3D 0 and snd_ssthresh =3D 0, then call the
>   tcp_reno_cong_avoid() kfunc. It passes tcp_snd_cwnd(tp) as w and does
>   not check cwnd.
>
> - Use the new cubictcp_cong_avoid() wrapper with a valid snd_cwnd, after
>   writing ca->cnt =3D 0, ca->last_cwnd =3D snd_cwnd and ca->last_time =3D=
 a
>   recent tcp_jiffies32 value (readable from fields such as
>   tp->lsndtime). bictcp_update() then returns early, before
>   ca->cnt =3D max(ca->cnt, 2U), and __cubictcp_cong_avoid() calls
>   tcp_cong_avoid_ai(tp, 0, acked).
>
> On x86 this would raise a divide error during ACK processing, usually in
> softirq context. Native callers never pass w =3D=3D 0.
>
> >  }
> >
> > +/* BPF congestion controls can store any value in tp->snd_cwnd.
> > + * bictcp_update() would loop forever with cwnd =3D=3D 0, or with a cw=
nd
> > + * large enough for cwnd * beta_scale to wrap.
>
> [Severity: Low]
>

Comment gone in v2.

> This isn't a bug, but is this comment accurate? It suggests that the
> TCP_MAX_SND_CWND check rules out every cwnd for which cwnd * beta_scale
> wraps.
>
> cubictcp_register() accepts beta up to 1023, which gives
> beta_scale =3D 8 * 2047 / 3 / 1 =3D 5458. With that value the u32 product
> wraps for any cwnd above 786912. So every cwnd in [786913, 1048576]
> passes the wrapper and still wraps.
>
> In that range the product wraps only once and delta stays at least 482,
> so the infinite loop is still prevented. The comment, though, treats
> "wraps" as if it meant "loops forever", and the wrap still produces a
> much smaller delta than intended.
>
> The TCP_MAX_SND_CWND comment in include/net/tcp.h (from 475ff14ba558)
> says multipliers go "up to 2047", which does not account for beta_scale
> in bictcp_update().
>
> > + * Native callers do not need this check.
> > + */
> > +__bpf_kfunc static void cubictcp_cong_avoid(struct sock *sk, u32 ack, =
u32 acked)
> > +{
> > +     u32 cwnd =3D tcp_snd_cwnd(tcp_sk(sk));
> > +
> > +     if (unlikely(!cwnd || cwnd > TCP_MAX_SND_CWND))
> > +             return;
> > +     __cubictcp_cong_avoid(sk, ack, acked);
>
> [Severity: High]
>
> Does this wrapper fully close the hang in the bictcp_update() TCP
> friendliness loop? It checks only snd_cwnd.

Same answer: there is no loop anymore in v2.

The loop runs about
> ack_cnt / delta times, and ack_cnt comes either from the acked argument,
> which the BPF program chooses, or from struct bictcp state in
> icsk_ca_priv. BPF is allowed to write that state:
>
> net/ipv4/bpf_tcp_ca.c:bpf_tcp_ca_btf_struct_access() {
>     ...
>         case bpf_ctx_range(struct inet_connection_sock, icsk_ca_priv):
>                 end =3D offsetofend(struct inet_connection_sock, icsk_ca_=
priv);
>     ...
> }
>
> snd_cwnd =3D 1 passes the check and gives delta =3D (1 * 15) >> 3 =3D 1 w=
ith
> the default beta_scale. Suppose a struct_ops program stores
> snd_cwnd =3D 1, snd_ssthresh <=3D 1 (so tcp_in_slow_start() is false and
> acked is not consumed), ca->epoch_start =3D 0 and ca->last_cwnd !=3D 1, a=
nd
> then calls:
>
>     cubictcp_cong_avoid(sk, 0, 0xffffffff);
>
> The call chain is
> cubictcp_cong_avoid()->__cubictcp_cong_avoid()->bictcp_update(ca, 1, 0xff=
ffffff).
> The epoch_start =3D=3D 0 branch sets ca->ack_cnt =3D 0xffffffff, and then
> this loop runs about 2^32 times during ACK processing with the socket
> lock held:
>
>                 delta =3D (cwnd * scale) >> 3;
>                 while (ca->ack_cnt > delta) {
>                         ca->ack_cnt -=3D delta;
>                         ca->tcp_cwnd++;
>                 }
>
> beta_scale is a runtime global, so the compiler is not expected to turn
> this loop into a division.
>
> The program can set up that state again and call the kfunc repeatedly,
> either unrolled or through bpf_loop(). Would that keep the CPU stuck
> past the soft lockup and RCU stall thresholds, which is the same hang
> in ACK processing the commit message describes?
>
> Could the kfunc wrapper also bound acked (and/or ca->ack_cnt), or could
> the BPF path compute the friendliness update with a division instead of
> the loop?
>
> > +}
> > +
>
> [ ... ]
>
> > @@ -475,7 +489,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock =
*sk, const struct ack_sample
> >  static struct tcp_congestion_ops cubictcp __read_mostly =3D {
> >       .init           =3D cubictcp_init,
> >       .ssthresh       =3D cubictcp_recalc_ssthresh,
> > -     .cong_avoid     =3D cubictcp_cong_avoid,
> > +     .cong_avoid     =3D __cubictcp_cong_avoid,
> >       .set_state      =3D cubictcp_state,
> >       .undo_cwnd      =3D tcp_reno_undo_cwnd,
> >       .cwnd_event_tx_start =3D cubictcp_cwnd_event_tx_start,
>
> [Severity: Medium]
> Can a BPF congestion control still hand native CUBIC an invalid
> snd_cwnd after the clamp in tcp_reinit_congestion_control() has run?
>
> bpf_tcp_ca_get_func_proto() allows bpf_setsockopt() from every
> tcp_congestion_ops callback except .release. So a BPF .cong_avoid,
> .in_ack_event, .pkts_acked, .set_state or .undo_cwnd can call
> bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION, "cubic", ...).
>
> That call goes through sol_tcp_sockopt_congestion(),
> do_tcp_setsockopt() and tcp_set_congestion_control() into
> tcp_reinit_congestion_control(). That function clamps snd_cwnd and
> switches icsk_ca_ops to cubictcp synchronously. Control then returns
> to the BPF callback, which is still running.
>
> The callback still has write access to tp->snd_cwnd and
> tp->snd_ssthresh through bpf_tcp_ca_btf_struct_access(). It can
> store snd_cwnd =3D 0 (or 0x88888889) and snd_ssthresh =3D 0 right after
> bpf_setsockopt() returns. sol_tcp_sockopt_congestion() already
> carries a comment about a similar after-the-switch hazard for cdg.
>
> The .undo_cwnd case does not even need a direct write:
>
> net/ipv4/tcp_input.c:tcp_undo_cwnd_reduction() {
>     ...
>                 tcp_snd_cwnd_set(tp, icsk->icsk_ca_ops->undo_cwnd(sk));
>     ...
> }
>
> The value returned by the BPF .undo_cwnd() is stored after that same
> call has already switched icsk_ca_ops to cubictcp.
>
> The hang then follows on the next ACK, or later in the same tcp_ack()
> when the switch is done from .in_ack_event or .pkts_acked.
> __cubictcp_cong_avoid() runs bictcp_update() with cwnd =3D=3D 0 or
> 0x88888889, so delta is 0. The TCP friendliness loop then spins
> forever in ACK processing, usually from softirq with the socket
> spinlock held.
>
> __cubictcp_cong_avoid() now relies on snd_cwnd being sane after
> tcp_reinit_congestion_control(). Given this ordering, is that the
> right place for the check? Would it be better to reject
> TCP_CONGESTION from bpf_setsockopt() inside tcp_congestion_ops
> callbacks, the way cdg is already rejected? Or to validate snd_cwnd
> at a point the BPF program cannot run after?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261106133748.2181133-1-edumazet%40kernel.org


pw-bot: cr
