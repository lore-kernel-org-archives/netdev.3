Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214505;
	b=rqRAH2nc/QL/St8Vv37a4Hkf9pBDLMqKjPkNLDP8GVm6xM3duuVARepbb2ahKj8wHN1z
	 RmHVNjxE3uMaN7LXGGCUcY83plsJM0/2LLRtXtWAV0sFG98WnlZSUTlm1xjnKG6Xce7fx
	 NMjOLCJPUCxRPDPZakTYZikJyg/tP4UhGZfeSqVJjDJhfgmbvZMj1eAXwf85Mb2njqH5f
	 bSrh7Eqm6+2zUfUVBLP/6G8Cqx2KUqTjQPErxZvR02Kyb7a4tojPk04s85QCTJLkkAslv
	 ztmzSYVesrDVE2prSn/1oULZMxSEkXdCjYDgisxbyYDk5EAYy+WrKJDvW3Vk4JMidSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214505;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ay42DW5gDi19b0/kytVI8QPTW6jidQRZcuUkzRDznx4=;
	b=HQOOs2ZCSRjAI/0DBJHgRF73hL1e7gSZGERIa6pJGqcKJJ6FxaK2qcd1oyBejUvOUs4L
	 Eh8Kex/zSJLnJP8kBKbdbFUO1yFcqhvsfToQnRpaFXb9oW4/7ZVJ/n8S811PQiMuvpSD/
	 /z1M00JdY7c2Dm6Si3wqptHSz9CxcSIy0JWwbaouICzMrf0wDSaV0qCNKyYGkhao7cxrS
	 jTDVt9dhoTfSKpmFVhq3hBLBTS658tTKnY80H42LY/yv9SbJtliBdftnuQfSUbi4iu6v3
	 bg+w9hRA4yvoycsibf0nsnxF1L2CCtmWmWghe9Y681JLwMCzssigJU97SAfGyr9XeRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QqRqTf+s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08A606BFA7
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QqRqTf+s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3561F031E6;
	Wed, 28 Oct 2026 19:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214504;
	bh=ay42DW5gDi19b0/kytVI8QPTW6jidQRZcuUkzRDznx4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QqRqTf+sYEsWJArpEMEMr6WZSSdaHQnuDle98ZgRUdK+jDbls/ngH9HAf1n1j59wM
	 PbZwCnKepWsoOgSF/vFhDtkqSuJaoLLGpKhchJorDpN/wE1tNtiSu8V6TTcyzg4Cm+
	 mGybpIWFGGHE7zFmpR7NfT+tX7lea2mnl/+7WsXZVpb3viGO8EyeY9nmaIRV1DNhAm
	 WRwhvtXpGhLR1GI1D8uEJmQqyVV94Wh8Ek7PG1haB4/+N0z6jakoM7AE16rLT2g+gH
	 U6sgDeYy1dP46nbS0xxWc+zo+i+BLu3Ef56yKHUrXj80+N15fokzBc9h7QAhd3ezUw
	 l2/u9iq6qT7NA==
Subject: Re: [PATCH net] tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, mason@kernel.org
Date: Wed, 28 Oct 2026 19:08:23 +0000
Message-ID: <179321450338.3134.9348301510643981873@kernel.org>
In-Reply-To: <20261027130617.1550253-1-edumazet@kernel.org>
References: <20261027130617.1550253-1-edumazet@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch sets TCP_MAX_SND_CWND to 1U << 24 (16,777,216).

--

tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND

This patch changes the default snd_cwnd_clamp from ~0 to a finite
TCP_MAX_SND_CWND of 2^24 packets. It also caps the locked RTAX_CWND
metric, TCP_BPF_SNDCWND_CLAMP and TCP_BPF_IW at that value. The stated
goal is to stop congestion control u32 arithmetic from misbehaving when
cwnd gets very large.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0265c27a5fd77..be1609cd78840 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1553,6 +1553,12 @@ static inline unsigned int tcp_packets_in_flight(const struct tcp_sock *tp)
>  
>  #define TCP_INFINITE_SSTHRESH	0x7fffffff
>  
> +/* Default and maximum snd_cwnd_clamp, in packets.
> + * Far above any usable BDP, but low enough that congestion control
> + * arithmetic such as 100 * cwnd in CUBIC cannot overflow a u32.
> + */
> +#define TCP_MAX_SND_CWND	(1U << 24)

[Severity: High]
Is 2^24 small enough for the claim in this comment? 100 * cwnd fits, but
CUBIC has larger u32 products on cwnd:

net/ipv4/tcp_cubic.c:cubictcp_recalc_ssthresh() {
    ...
	if (tcp_snd_cwnd(tp) < ca->last_max_cwnd && fast_convergence)
		ca->last_max_cwnd = (tcp_snd_cwnd(tp) * (BICTCP_BETA_SCALE + beta))
			/ (2 * BICTCP_BETA_SCALE);
    ...
	return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
}

With beta = 717:

  cwnd * 1741 wraps once cwnd is above about 2.47M.
  cwnd * 717 wraps once cwnd is above about 5.99M.

Both points are below 2^24.

At cwnd = 2^24, ssthresh comes out as 3,358,720 instead of 11,747,328.
last_max_cwnd comes out as 1,679,360 instead of about 14.3M.

Just above each wrap point the product is close to zero, so ssthresh
would drop to a few thousand or to the 2U floor. The wrong Wmax then
reaches bictcp_update(), and the comment there says that code is only
overflow-free for cwnd below 1 million packets.

Other in-tree modules have the same pattern:

  dctcp_ssthresh():          cwnd * dctcp_alpha (up to 1024, also the
                             default), wraps at 2^22
  bictcp_recalc_ssthresh():  cwnd * 1843 and cwnd * 819
  tcp_cdg_ssthresh():        cwnd * min(1024U, backoff_beta)
  tcpnv_recalc_ssthresh():   cwnd * nv_loss_dec_factor (default 819)
  tcp_roccet.c:              cwnd * beta and cwnd * (1024 + beta)

DCTCP at cwnd = 2^24 is the clearest case:

	return max(tcp_snd_cwnd(tp) - ((tcp_snd_cwnd(tp) * ca->dctcp_alpha) >> 11U), 2U);

Here 2^24 * 1024 wraps to 0. ssthresh then equals cwnd, so the ECN
window reduction never happens.

The inputs named in the commit message can still put cwnd at the clamp
directly. That skips any real growth in flight:

  tcp_init_cwnd() returns min_t(__u32, cwnd, tp->snd_cwnd_clamp)
  for RTAX_INITCWND
  TCP_BPF_IW now sets min_t(u32, val, tp->snd_cwnd_clamp)

Either path can set cwnd to 2^24. The next RTO or recovery then calls
the CC ssthresh callback with that cwnd:

  tcp_enter_loss()->icsk_ca_ops->ssthresh()
  tcp_init_cwnd_reduction()->icsk_ca_ops->ssthresh()

The sk_sndbuf argument in the commit message limits packets_out. These
callbacks read snd_cwnd, not packets_out.

The generic stack has a similar product as well:

net/ipv4/tcp_output.c:tcp_tso_should_defer() {
    ...
	u32 chunk = min(tp->snd_wnd, tcp_snd_cwnd(tp) * tp->mss_cache);
    ...
}

With a 1448 byte MSS, this wraps above about 2.97M packets.

Would a lower bound work here, around 2^21 or less to cover multipliers
up to 2048? The other option is widening these products to u64.

> +
>  static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
>  {
>  	return tp->snd_cwnd;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027130617.1550253-1-edumazet%40kernel.org
