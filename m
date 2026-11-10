Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342257;
	b=YaRYferVGujbm01O6WubThiWnGZErpqazTysrIoh6fUlaozkzqGlIcu1XtRK9y01hPRT
	 N0VQA0LAkUW2/ETtjka452g1nuadJfCCDrrV7V17NDfHv+SNUAgM2dNnzSebV5nDWaYvV
	 uoics06X8O3fbm2LFnnQZGsdmgPyfok91vKwwjHHanTvOmUEuhhrdwtLAsDIraOSHOcpU
	 /sxq11XSviX+LEP4GJMcV30qn970yQ2YgygmH2WO6FspYELIyADu7sBCNPi/vx1dYTZH0
	 6+SrpMHBTVaaZ3usr7gwyPSvwbxTRKew7WnNLe6xQWk6h/CcaNNeRrsDbyTM0zDjVvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342257;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WXnKr1hj5Sb6AzUQW1f1VYYXx371bE27a+KWHBaQ1eA=;
	b=m+oXvAOsUeax52CuokA0djdX+rGVWjn77/wWBehV6yiN7M/VKpEdH+dbBQ5/dLfzjams
	 kCNLX5Pj3zw7ftyU8KbO6WSU22lnP1Guwz1r6+jXZ2RkwgqnuYexMiea2KzQOJKgj1K3L
	 H+BZoaDEQqZs+AWpsuR69MeVCiCbup/h84hnTAKU68cdUJ5YRpp0WvN/Ak1Nvig3vFGlZ
	 9H2avT2hLTxd4qYLyX6bmrPsJ3eEOxqzekXgIe/9S8PRvXdV+aiYTt97USE5tC0Z1K6nd
	 HncOV0qDMEZZC1cb3t9HSGyTHjglAqz53TIOsxabYWp6aB7VqpVt5wUS5CS555FHYgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bg+Myafv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC94606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bg+Myafv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4D21F008A1;
	Tue, 10 Nov 2026 20:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342257;
	bh=WXnKr1hj5Sb6AzUQW1f1VYYXx371bE27a+KWHBaQ1eA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bg+MyafvwBOztt5CEJf6oZ8ei7A250rOXmxa4RpVIYwHC7oVb2L7BqLiFc6DSjWJC
	 qvAz8AGaEF8viiO27CftqYTOi1HWTna7tpcU0CSBOJp8wU8wa3Unp73pYpZset/Q4L
	 AGZ2328mIZHxAiZKJhjSUZtxLr67fCoRhDSI6/bLCkA2VmjOMwqpxlF7z8NyYWfn4l
	 DtB6jLuYdtCoQU5VEyUHnoc7x+Os5Jn5Jsn0MGipYrflDvuoI1An2jPZrSfkCN32rq
	 vBBNQT7OX416OOZg/UdFKumxFRbqcvq0WswjQFDfNMpYCO9hbMjWuyFQtchmhDqMzR
	 ETmg6hrJM/FYg==
Subject: Re: [PATCH v2 net] tcp: cubic: avoid looping in bictcp_update() TCP
 friendliness code
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, sashiko-bot@kernel.org
Date: Tue, 10 Nov 2026 20:24:16 +0000
Message-ID: <179434225619.994134.848424997770273753@kernel.org>
In-Reply-To: <20261109172356.3113732-1-edumazet@kernel.org>
References: <20261109172356.3113732-1-edumazet@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] tcp_cong_avoid_ai() (net/ipv4/tcp_cong.c:480) runs `u32 delta =
  tp->snd_cwnd_cnt / w;` and never checks that w is non-zero.
- [Medium] net/ipv4/tcp_roccet.c has its own copy of bictcp_update(),
  derived from CUBIC, with the same TCP-friendliness loop this patch…
- [Low] cubictcp_register() (net/ipv4/tcp_cubic.c:527-528) has the
  comment `/* bictcp_update() needs (cwnd * beta_scale) >> 3 to be >= 1…

--

tcp: cubic: avoid looping in bictcp_update() TCP friendliness code

This commit replaces the subtract-and-increment loop in the TCP
friendliness part of bictcp_update() with one division, and clamps delta
to at least 1. It addresses a CPU hang that happens when a BPF congestion
control stores arbitrary values in snd_cwnd and icsk_ca_priv and then
calls cubictcp_cong_avoid() or switches the socket to CUBIC.

Link: https://lore.kernel.org/netdev/179363987528.3131.2987776489427079887@kernel.org/

> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index a88e4bf86150f..e74dabde34324 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -298,10 +298,16 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
>  	if (tcp_friendliness) {
>  		u32 scale = beta_scale;
>  
> -		delta = (cwnd * scale) >> 3;
> -		while (ca->ack_cnt > delta) {		/* update tcp cwnd */
> -			ca->ack_cnt -= delta;
> -			ca->tcp_cwnd++;

[Severity: Medium]
net/ipv4/tcp_roccet.c has its own CUBIC-derived bictcp_update(), and it
still has the same loop:

net/ipv4/tcp_roccet.c:bictcp_update() {
	...
		delta = (cwnd * scale) >> 3;
		if (delta > 0) {
			while (ca->ack_cnt > delta) { /* update tcp cwnd */
				ca->ack_cnt -= delta;
				ca->tcp_cwnd++;
			}
		}
	...
}

The delta > 0 check rules out a zero delta. Does the huge ack_cnt case
from the commit message still apply there?

sol_tcp_sockopt_congestion() in net/core/filter.c blocks only "cdg". A
BPF CC can therefore call bpf_setsockopt(TCP_CONGESTION, "roccet") and
then overwrite icsk_ca_priv with epoch_start != 0 and
ack_cnt = 0xFFFFFFFF. With the default beta, beta_scale is 15, so
snd_cwnd = 1 gives delta == 1.

The next ACK reaches roccettcp_cong_avoid()->bictcp_update(), and the loop
runs about 2^32 times in ACK processing context.

Should the same max(..., 1U) plus division change go into the ROCCET copy,
perhaps as a companion patch?

> +		/* BPF congestion controls can call us with any cwnd
> +		 * and ack_cnt: cwnd * scale can wrap and give a zero delta,
> +		 * and a loop could run up to 2^32 times.
> +		 */
> +		delta = max((cwnd * scale) >> 3, 1U);

[Severity: Low]
This isn't a bug, but now that delta is clamped here, is the comment in
cubictcp_register() still accurate?

net/ipv4/tcp_cubic.c:cubictcp_register() {
	...
	/* bictcp_update() needs (cwnd * beta_scale) >> 3 to be >= 1 */
	beta_scale = max(beta_scale, 8U);
	...
}

bictcp_update() now guarantees delta >= 1 on its own. The new comment also
says cwnd * scale can wrap to zero anyway.

The registration clamp is no longer needed for loop safety. It still
overrides the beta module parameter when beta < 512, which changes the
Reno emulation rate.

Could the clamp and its comment be dropped or reworded, or mentioned in
the new comment here?

> +		if (ca->ack_cnt > delta) {		/* update tcp cwnd */
> +			u32 n = (ca->ack_cnt - 1) / delta;
> +
> +			ca->ack_cnt -= n * delta;
> +			ca->tcp_cwnd += n;
>  		}
>  
>  		if (ca->tcp_cwnd > cwnd) {	/* if bic is slower than tcp */

[Severity: High]
Under the threat model in the commit message, can this still divide by
zero in tcp_cong_avoid_ai()? In that model, a BPF congestion control
writes arbitrary values into icsk_ca_priv and snd_cwnd and then calls the
cubictcp_cong_avoid() kfunc.

The early return in bictcp_update() skips the final clamp on ca->cnt:

net/ipv4/tcp_cubic.c:bictcp_update() {
	...
	if (ca->last_cwnd == cwnd &&
	    (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
		return;
	...
	ca->cnt = max(ca->cnt, 2U);
}

A BPF CC can set ca->cnt = 0, ca->last_cwnd = snd_cwnd and ca->last_time
to a future jiffies value. It can do this in its own priv area before
calling the kfunc, or after bpf_setsockopt(TCP_CONGESTION, "cubic").
cubictcp_cong_avoid() then passes the unclamped value as the divisor:

	bictcp_update(ca, tcp_snd_cwnd(tp), acked);
	tcp_cong_avoid_ai(tp, ca->cnt, acked);

tcp_cong_avoid_ai() divides by w without checking it:

net/ipv4/tcp_cong.c:tcp_cong_avoid_ai() {
	...
	tp->snd_cwnd_cnt += acked;
	if (tp->snd_cwnd_cnt >= w) {
		u32 delta = tp->snd_cwnd_cnt / w;
	...
}

With w == 0, both snd_cwnd_cnt >= w tests are always true, so the
division runs for any acked value. In NET_RX softirq context, would this
oops and end in a panic?

The ROCCET code already guards the same call:

net/ipv4/tcp_roccet.c:roccettcp_cong_avoid() {
	...
	tcp_cong_avoid_ai(tp, max(1, ca->cnt), acked);
}

There are also more direct routes to the same division:

- The tcp_cong_avoid_ai kfunc is registered in
  bpf_tcp_ca_check_kfunc_ids, so it can be called directly with w = 0.
  The verifier only checks that w is a scalar.
- tcp_reno_cong_avoid() passes the BPF-writable tcp_snd_cwnd(tp) as w.

Would a guard such as max(ca->cnt, 1U) in cubictcp_cong_avoid(), or a
clamp on w inside tcp_cong_avoid_ai(), be needed to fully close this bug
class?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109172356.3113732-1-edumazet%40kernel.org
