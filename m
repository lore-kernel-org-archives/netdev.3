Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242456;
	b=cWlSk/wXSFXTDc93nPPnPdTrefN6Igc8JQjeggEI1vU7/diorSQM41nOpu62YoXQj+Yr
	 IRXO05GbvEYxfjZESFmViz1KRXYPQkDBioD7bVKOlSHUD3kc9fdZgGpiqTP8GJiYJ6l4C
	 RsBRx834JhiyDiU40rBVJoSY75X51Y4nRPXxl9yZvfML3/e6lW621Zhx5gr5WEIjOPpHR
	 QmcGp/I7lyd7duXekU/6mQfIGQSMnUvg9cwHFOf4Zktuw1Fo2F9igweg1gp+l0tLd2lsq
	 cHPHwepPOK1MordcYv//sDjNRvZNK3TuqdRZJIFtKtuMp99ij4/hV7j8UsLwwPbqBvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242456;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AXQ9nvUHzQYWCOEKXII3Ha3nUpJK+O+CoDW93QUljIc=;
	b=ZjuVuCuw1wYTvLscg+2urpaXz5OSMgYjZhHoBVnLbkLSB25pkyDzi3zD5PhAWknBJOSD
	 jzj+nnFTfQgRRXcgC1MsgQmGdUVlK0+hUi7CEO/XlEaa+YAgLcVqkKdf4c8GTJC7biR6e
	 Mr/+unWk/hQ6CMQHamK5/bbjMyNk//hxDyqIcMn7LejrE2yse2Oz5F3AEOoht1IGi79Xm
	 YD3+3i0k0e7oKdbvlQrPxbYXArdRiEWcxhK67dF7nzPQ5thJLxynHlZcvnBZdWTX/FUM+
	 YY3rp3aZfaZBL/AiyJVFyKwzL1FhcHz9FYRxTenorIEPCBLDZqaieQP6ysn6GnzznDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpLoBuHt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51F606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpLoBuHt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33691F008A1;
	Mon,  9 Nov 2026 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242455;
	bh=AXQ9nvUHzQYWCOEKXII3Ha3nUpJK+O+CoDW93QUljIc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OpLoBuHt09dSqmP28kokDqNjja4N6hcGKnKBD6rKj7fs6Rqyt/lLgkCebn8XOhk72
	 edPkdFPBad5LGrjwhsS43+vGTrn7dXwjrAlJspB802EtYCOljlp9/+JFuUSviu1YRY
	 ENwCmZOTauD8LW28QANrJf810gPYDV621wb5B+xrvMl97nkdJMGMuo/5Mh6CNyfvYA
	 SES0ZsV5UQVK91Ny7Lo6cy+KnIzjlqwZzeSoQkh4NLGtxZHk9pM8kxaQkdyMYBG/rC
	 7FNHdfvgQ6l/1YtxQM1THmxs7r1nLZo6Rm2oz7J8UpDMGpZtZyDV9vqzoSN/eHAWVH
	 LD3JC3nt4293A==
Subject: Re: [PATCH net] tcp: cubic: do not trust snd_cwnd set by BPF
 congestion controls
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, sashiko-bot@kernel.org
Date: Mon, 09 Nov 2026 16:40:54 +0000
Message-ID: <179424245454.994134.13469440240015313651@kernel.org>
In-Reply-To: <20261106133748.2181133-1-edumazet@kernel.org>
References: <20261106133748.2181133-1-edumazet@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: a BPF congestion control can still stall
  the CPU in the TCP-friendliness loop of bictcp_update() through the…
- [High] tcp: unsanitized snd_ssthresh in tcp_reinit_congestion_control()
  hangs CUBIC
- [Medium] tcp: BPF CC can overwrite snd_cwnd after
  bpf_setsockopt(TCP_CONGESTION)
- [Low] The new comment above the cubictcp_cong_avoid() wrapper
  (net/ipv4/tcp_cubic.c) says bictcp_update() 'would loop forever ...…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is in the
  same 'BPF can store any value' threat model and is High severity.

--

tcp: cubic: do not trust snd_cwnd set by BPF congestion controls

This patch turns the cubictcp_cong_avoid() kfunc into a wrapper. The
wrapper ignores calls when snd_cwnd is outside [1, TCP_MAX_SND_CWND],
while native CUBIC calls __cubictcp_cong_avoid() directly. It also
clamps snd_cwnd to [1, snd_cwnd_clamp] in
tcp_reinit_congestion_control(), to stop the TCP friendliness loop in
bictcp_update() from hanging the CPU.

Link: https://lore.kernel.org/netdev/179363987528.3131.2987776489427079887@kernel.org/

> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index a88e4bf86150f..9595bdc9589c2 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -318,7 +318,7 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
>  	ca->cnt = max(ca->cnt, 2U);
>  }
>  
> -__bpf_kfunc static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
> +static noinline void __cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
>  {
>  	struct tcp_sock *tp = tcp_sk(sk);
>  	struct bictcp *ca = inet_csk_ca(sk);
> @@ -335,6 +335,20 @@ __bpf_kfunc static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
>  	tcp_cong_avoid_ai(tp, ca->cnt, acked);

[Severity: High]
Does clamping only snd_cwnd here still leave the same hang reachable
through tp->snd_ssthresh?

A BPF congestion control can write any u32 to tp->snd_ssthresh via
bpf_tcp_ca_btf_struct_access(). That includes its .release()
callback, which tcp_cleanup_congestion_control() runs just before
this clamp. It can also return any value from .ssthresh(), which
tcp_init_cwnd_reduction() and tcp_enter_loss() store into
tp->snd_ssthresh. A BPF .ssthresh() can simply return 0.

tcp_reinit_congestion_control() does not touch snd_ssthresh,
icsk_ca_state or tp->undo_marker. With the default hystart and
initial_ssthresh parameters, cubictcp_init() leaves snd_ssthresh
alone as well.

Suppose the socket is in TCP_CA_CWR or TCP_CA_Recovery when it is
moved to CUBIC. The next ACK that advances snd_una past high_seq then
goes through tcp_fastretrans_alert()->tcp_end_cwnd_reduction():

net/ipv4/tcp_input.c:tcp_end_cwnd_reduction() {
    ...
	if (tp->snd_ssthresh < TCP_INFINITE_SSTHRESH &&
	    (inet_csk(sk)->icsk_ca_state == TCP_CA_CWR || tp->undo_marker)) {
		tcp_snd_cwnd_set(tp, tp->snd_ssthresh);
		tp->snd_cwnd_stamp = tcp_jiffies32;
	}
    ...
}

This copies snd_ssthresh into snd_cwnd without any bound.
tcp_snd_cwnd_set() warns once on 0 but still stores it.

Later in the same tcp_ack(), tcp_cong_control() calls
__cubictcp_cong_avoid() with snd_cwnd == 0 and snd_ssthresh == 0.
tcp_in_slow_start() is false, so bictcp_update(ca, 0, acked)
computes delta = 0 and the TCP friendliness loop never terminates.

A snd_ssthresh between TCP_MAX_SND_CWND and TCP_INFINITE_SSTHRESH
would instead leave snd_cwnd above TCP_MAX_SND_CWND. There
cwnd * beta_scale wraps and the u32 multiplications in native
->ssthresh() handlers overflow, which is the state the commit message
says native congestion controls must not see.

Should tcp_reinit_congestion_control() also bound snd_ssthresh, for
example to snd_cwnd_clamp or by resetting it to
TCP_INFINITE_SSTHRESH? Or should it reset the CWR/Recovery state
when switching away from a BPF congestion control? Or is there
something that keeps tcp_end_cwnd_reduction() from running after
such a switch that I am missing?

[Severity: High]

This isn't a bug introduced by this patch, but it falls under the same
"BPF can store any value" threat model. tcp_cong_avoid_ai() is exposed as
a kfunc through bpf_tcp_ca_check_kfunc_ids. It divides by w without
checking for zero:

net/ipv4/tcp_cong.c:tcp_cong_avoid_ai() {
    ...
	tp->snd_cwnd_cnt += acked;
	if (tp->snd_cwnd_cnt >= w) {
		u32 delta = tp->snd_cwnd_cnt / w;
    ...
}

When w == 0 the guard is always true.

Can a BPF congestion control reach this division by zero in any of these
ways?

- Call tcp_cong_avoid_ai(tp, 0, acked) directly. The verifier does not
  range check scalar kfunc arguments.

- Store snd_cwnd = 0 and snd_ssthresh = 0, then call the
  tcp_reno_cong_avoid() kfunc. It passes tcp_snd_cwnd(tp) as w and does
  not check cwnd.

- Use the new cubictcp_cong_avoid() wrapper with a valid snd_cwnd, after
  writing ca->cnt = 0, ca->last_cwnd = snd_cwnd and ca->last_time = a
  recent tcp_jiffies32 value (readable from fields such as
  tp->lsndtime). bictcp_update() then returns early, before
  ca->cnt = max(ca->cnt, 2U), and __cubictcp_cong_avoid() calls
  tcp_cong_avoid_ai(tp, 0, acked).

On x86 this would raise a divide error during ACK processing, usually in
softirq context. Native callers never pass w == 0.

>  }
>  
> +/* BPF congestion controls can store any value in tp->snd_cwnd.
> + * bictcp_update() would loop forever with cwnd == 0, or with a cwnd
> + * large enough for cwnd * beta_scale to wrap.

[Severity: Low]

This isn't a bug, but is this comment accurate? It suggests that the
TCP_MAX_SND_CWND check rules out every cwnd for which cwnd * beta_scale
wraps.

cubictcp_register() accepts beta up to 1023, which gives
beta_scale = 8 * 2047 / 3 / 1 = 5458. With that value the u32 product
wraps for any cwnd above 786912. So every cwnd in [786913, 1048576]
passes the wrapper and still wraps.

In that range the product wraps only once and delta stays at least 482,
so the infinite loop is still prevented. The comment, though, treats
"wraps" as if it meant "loops forever", and the wrap still produces a
much smaller delta than intended.

The TCP_MAX_SND_CWND comment in include/net/tcp.h (from 475ff14ba558)
says multipliers go "up to 2047", which does not account for beta_scale
in bictcp_update().

> + * Native callers do not need this check.
> + */
> +__bpf_kfunc static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
> +{
> +	u32 cwnd = tcp_snd_cwnd(tcp_sk(sk));
> +
> +	if (unlikely(!cwnd || cwnd > TCP_MAX_SND_CWND))
> +		return;
> +	__cubictcp_cong_avoid(sk, ack, acked);

[Severity: High]

Does this wrapper fully close the hang in the bictcp_update() TCP
friendliness loop? It checks only snd_cwnd. The loop runs about
ack_cnt / delta times, and ack_cnt comes either from the acked argument,
which the BPF program chooses, or from struct bictcp state in
icsk_ca_priv. BPF is allowed to write that state:

net/ipv4/bpf_tcp_ca.c:bpf_tcp_ca_btf_struct_access() {
    ...
	case bpf_ctx_range(struct inet_connection_sock, icsk_ca_priv):
		end = offsetofend(struct inet_connection_sock, icsk_ca_priv);
    ...
}

snd_cwnd = 1 passes the check and gives delta = (1 * 15) >> 3 = 1 with
the default beta_scale. Suppose a struct_ops program stores
snd_cwnd = 1, snd_ssthresh <= 1 (so tcp_in_slow_start() is false and
acked is not consumed), ca->epoch_start = 0 and ca->last_cwnd != 1, and
then calls:

    cubictcp_cong_avoid(sk, 0, 0xffffffff);

The call chain is
cubictcp_cong_avoid()->__cubictcp_cong_avoid()->bictcp_update(ca, 1, 0xffffffff).
The epoch_start == 0 branch sets ca->ack_cnt = 0xffffffff, and then
this loop runs about 2^32 times during ACK processing with the socket
lock held:

		delta = (cwnd * scale) >> 3;
		while (ca->ack_cnt > delta) {
			ca->ack_cnt -= delta;
			ca->tcp_cwnd++;
		}

beta_scale is a runtime global, so the compiler is not expected to turn
this loop into a division.

The program can set up that state again and call the kfunc repeatedly,
either unrolled or through bpf_loop(). Would that keep the CPU stuck
past the soft lockup and RCU stall thresholds, which is the same hang
in ACK processing the commit message describes?

Could the kfunc wrapper also bound acked (and/or ca->ack_cnt), or could
the BPF path compute the friendliness update with a division instead of
the loop?

> +}
> +

[ ... ]

> @@ -475,7 +489,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock *sk, const struct ack_sample
>  static struct tcp_congestion_ops cubictcp __read_mostly = {
>  	.init		= cubictcp_init,
>  	.ssthresh	= cubictcp_recalc_ssthresh,
> -	.cong_avoid	= cubictcp_cong_avoid,
> +	.cong_avoid	= __cubictcp_cong_avoid,
>  	.set_state	= cubictcp_state,
>  	.undo_cwnd	= tcp_reno_undo_cwnd,
>  	.cwnd_event_tx_start = cubictcp_cwnd_event_tx_start,

[Severity: Medium]
Can a BPF congestion control still hand native CUBIC an invalid
snd_cwnd after the clamp in tcp_reinit_congestion_control() has run?

bpf_tcp_ca_get_func_proto() allows bpf_setsockopt() from every
tcp_congestion_ops callback except .release. So a BPF .cong_avoid,
.in_ack_event, .pkts_acked, .set_state or .undo_cwnd can call
bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION, "cubic", ...).

That call goes through sol_tcp_sockopt_congestion(),
do_tcp_setsockopt() and tcp_set_congestion_control() into
tcp_reinit_congestion_control(). That function clamps snd_cwnd and
switches icsk_ca_ops to cubictcp synchronously. Control then returns
to the BPF callback, which is still running.

The callback still has write access to tp->snd_cwnd and
tp->snd_ssthresh through bpf_tcp_ca_btf_struct_access(). It can
store snd_cwnd = 0 (or 0x88888889) and snd_ssthresh = 0 right after
bpf_setsockopt() returns. sol_tcp_sockopt_congestion() already
carries a comment about a similar after-the-switch hazard for cdg.

The .undo_cwnd case does not even need a direct write:

net/ipv4/tcp_input.c:tcp_undo_cwnd_reduction() {
    ...
		tcp_snd_cwnd_set(tp, icsk->icsk_ca_ops->undo_cwnd(sk));
    ...
}

The value returned by the BPF .undo_cwnd() is stored after that same
call has already switched icsk_ca_ops to cubictcp.

The hang then follows on the next ACK, or later in the same tcp_ack()
when the switch is done from .in_ack_event or .pkts_acked.
__cubictcp_cong_avoid() runs bictcp_update() with cwnd == 0 or
0x88888889, so delta is 0. The TCP friendliness loop then spins
forever in ACK processing, usually from softirq with the socket
spinlock held.

__cubictcp_cong_avoid() now relies on snd_cwnd being sane after
tcp_reinit_congestion_control(). Given this ordering, is that the
right place for the check? Would it be better to reject
TCP_CONGESTION from bpf_setsockopt() inside tcp_congestion_ops
callbacks, the way cdg is already rejected? Or to validate snd_cwnd
at a point the BPF program cannot run after?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106133748.2181133-1-edumazet%40kernel.org
