Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639877;
	b=x3HtUCkIz7fTf+lkp46DWVwiQd83Efdidok4EgLyXNa0tnUHiTELDgTObifqliC3GScT
	 +MaOWTJJM0sMVl/sU97DCAvmq+v9QDvAypxwSZLiYirnplE0ZsGY1k1hQ3yQTcLcxR4QP
	 Wg4bjTOMsL4jT7o0M9d5oDHtB2rRA+w8L2XKNYOoBOr4XHv72loKmX4Wkcn9nBu8gFlUu
	 35o9FieSVdpugOO8Ktn1VV6VyeUfxfGW2z/LiB3An0UMM48eiflL+iBfnuQUHa5CuKXMO
	 phnDcAlI0g7UPwEMK0P682kaWVIWYIpGNkLzjT3qEQ5QCqf+YZzuPNpVQNSCw6X+OZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639877;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aKfmugFQcdQfKq2rBXVcKW52f/GeBKw1ntgsMPNYREA=;
	b=s22AYEuIsQThmW8Q0Y9uKs6UwYnzH0g4J5Cn+ozh7tQDuzDCWUNktKYTSHHBuVz4Mc7y
	 rb5bhDTmsyTBP3tIBxgB47IQFXZkkNni6n5rQlmPS2wp8c9KMdAE6gpSKvz/sHEqPvdkw
	 tc6lYDbhJIOLTU+HMAHzqti2nHPpJBTx2Wg77BqaNKcryY2VikoZ/KmJXsfZRf+kpymmE
	 YFlhx5zGppW+cms/zh3d2DW6/SZNchQ0coy19IxAsTzYGjUpS67Dgdg3sk2zWJ8O+b9oV
	 tWHBZHIXyWaK3py999s0d9XkGN2buL0rRbds377A4ZdrODsPkf8ZKPVtaJjvx+VK+VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3BY9ONb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED33606A927
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3BY9ONb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7E21F00A16;
	Mon,  2 Nov 2026 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793639876;
	bh=aKfmugFQcdQfKq2rBXVcKW52f/GeBKw1ntgsMPNYREA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b3BY9ONbW78Vb6d1EDmJwXOV8kVU6I7Mn3NAtZ4YR9opHCHtr+vBmahBqNXZ6dIpQ
	 RG9suAa35D3eBPjfjrQg0vhBZ2pl+wsNOZ/jq5MD0PPrDRuk2oCbWGAxzPpK2yfJYM
	 eWplZYOHTVjYXbJ8ixURa8Szqh/4gtU/C7cR9paNt29P7vZX+UiJwV1TeacXQpXmPM
	 CfOmxIDvqU5tJxrWUwOAdrA7B3tjS4BBL5xki0Jvz5E1yM/8+FyIXoy1L7piSwHQqO
	 ujJHGvkxhuvEECpxLeMsCIIjCvqJG8wyOGGA/UxSVW+GR6vJGjiIgft/AOSZiql9Me
	 FAau9CS52pWxA==
Subject: Re: [PATCH v2 net] tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, mason@kernel.org
Date: Mon, 02 Nov 2026 17:17:55 +0000
Message-ID: <179363987528.3131.2987776489427079887@kernel.org>
In-Reply-To: <20261030111528.2850082-1-edumazet@kernel.org>
References: <20261030111528.2850082-1-edumazet@kernel.org>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] BPF struct_ops congestion control programs can still store any
  u32 into snd_cwnd and snd_ssthresh, skipping both snd_cwnd_clamp and…
- [Low] Some CC u32 arithmetic can still overflow with cwnd at or below
  TCP_MAX_SND_CWND, which contradicts the new tcp.h comment saying CC…

--

tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND

This patch gives snd_cwnd_clamp a finite default of TCP_MAX_SND_CWND
(2^20 packets) instead of ~0. It also caps the locked RTAX_CWND metric
and the TCP_BPF_IW and TCP_BPF_SNDCWND_CLAMP setsockopt paths. The goal
is to keep the u32 cwnd arithmetic in congestion control modules from
wrapping.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 3560adddf8215..5c9203aae8341 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1554,6 +1554,15 @@ static inline unsigned int tcp_packets_in_flight(const struct tcp_sock *tp)
>  
>  #define TCP_INFINITE_SSTHRESH	0x7fffffff
>  
> +/* Default and maximum snd_cwnd_clamp, in packets.
> + * A peer can not advertise more than 65535 << 14 bytes, so a larger
> + * cwnd is useless with any MSS of 1024 bytes or more.
> + * Congestion control modules multiply cwnd by u32 factors up to 2047
> + * (cwnd * (BICTCP_BETA_SCALE + beta) in CUBIC), and CUBIC's
> + * bictcp_update() expects cwnd to stay below about one million packets.
> + */
> +#define TCP_MAX_SND_CWND	(1U << 20)

[Severity: Low]
Does the "factors up to 2047" sizing hold for CUBIC's bictcp_update()
with valid beta values?

cubictcp_register() in net/ipv4/tcp_cubic.c accepts beta in [0, 1023],
then computes:

	beta_scale = 8 * (BICTCP_BETA_SCALE + b) / 3
		/ (BICTCP_BETA_SCALE - b);

For beta=1023 this gives beta_scale = 5458. bictcp_update() then does
this in u32:

		delta = (cwnd * scale) >> 3;

With that scale, the product wraps for cwnd above about 786,906, which
is below TCP_MAX_SND_CWND. For cwnd = 800000, delta comes out as
8,929,088 instead of 545,800,000. The ack_cnt loop then inflates
ca->tcp_cwnd and pushes ca->cnt down toward 2, so cwnd grows too fast
near the clamp.

beta is also module_param(beta, int, 0644) in both tcp_cubic.c and
tcp_bic.c, and a write at runtime is not validated. If beta > 1023 is
written later, cwnd * (BICTCP_BETA_SCALE + beta) in
cubictcp_recalc_ssthresh() can wrap at cwnd = 2^20.

In BIC, beta=4096 makes cwnd * beta in bictcp_recalc_ssthresh() wrap to
0 at cwnd = 2^20, which returns an ssthresh of 2. That beta value makes
no sense anyway, though.

All of these need privileged module tuning, and the effect stays within
CC behaviour.

> +
>  static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
>  {
>  	return tp->snd_cwnd;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 09c60a58c82ab..96f9ba67095a2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5590,11 +5590,12 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
>  	case TCP_BPF_IW:
>  		if (val <= 0 || tp->data_segs_out > tp->syn_data)
>  			return -EINVAL;
> -		tcp_snd_cwnd_set(tp, val);
> +		tcp_snd_cwnd_set(tp, min_t(u32, val, tp->snd_cwnd_clamp));
>  		break;
>  	case TCP_BPF_SNDCWND_CLAMP:
>  		if (val <= 0)
>  			return -EINVAL;
> +		val = min_t(u32, val, TCP_MAX_SND_CWND);
>  		tp->snd_cwnd_clamp = val;
>  		WRITE_ONCE(tp->snd_ssthresh, val);
>  		break;

[Severity: Medium]
The commit message says the patch will "cap the metric and BPF paths
that set it or set cwnd directly". Does that also cover struct_ops
congestion control programs?

bpf_tcp_ca_btf_struct_access() in net/ipv4/bpf_tcp_ca.c only checks
that the store stays inside the field:

	case offsetof(struct tcp_sock, snd_cwnd):
		end = offsetofend(struct tcp_sock, snd_cwnd);
		break;
	...
	case offsetof(struct tcp_sock, snd_ssthresh):
		end = offsetofend(struct tcp_sock, snd_ssthresh);
		break;

So a BPF CC can still store any u32 into snd_cwnd and snd_ssthresh.
Those stores skip both snd_cwnd_clamp and TCP_MAX_SND_CWND.

The native functions named in the commit message are exported as kfuncs
to BPF_PROG_TYPE_STRUCT_OPS: cubictcp_recalc_ssthresh(),
cubictcp_cong_avoid() and dctcp_ssthresh(). Take snd_cwnd = 1 << 24 and
the default dctcp_alpha of 1024. In dctcp_ssthresh(), cwnd * dctcp_alpha
wraps to 0 and ssthresh == cwnd, which is the failure the commit message
describes.

tcp_reinit_congestion_control() doesn't reset snd_cwnd either. Switching
from a BPF CC to native CUBIC, DCTCP or BIC would carry an oversized
cwnd into their ->ssthresh() handlers.

There is a worse case in bictcp_update(). With the default beta_scale of
15 and snd_cwnd = 0x88888889, cwnd * 15 wraps to 7, so delta is 0:

		delta = (cwnd * scale) >> 3;
		while (ca->ack_cnt > delta) {
			ca->ack_cnt -= delta;
			ca->tcp_cwnd++;
		}

Can this loop spin forever? A struct_ops CC could reach it by writing
snd_cwnd and setting snd_ssthresh = 1. It would then call the
cubictcp_cong_avoid() kfunc with acked >= 1 while the flow is cwnd
limited. The CPU would then spin in native code during ACK processing,
where the verifier's loop limits do not apply.

Loading a struct_ops program needs CAP_BPF plus CAP_PERFMON, or a
delegated BPF token. A cwnd of 0 can also reach the kfunc hang, and an
upper cap would not fix that.

Should the bound also be enforced on the struct_ops write path, or in
these kfuncs?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030111528.2850082-1-edumazet%40kernel.org
