Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005E372EEA
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195167; cv=none; b=nvJNX0BPJUT70/V1msfuVBXuAHRBqaBuKNVPrfGCvdE0f3WRQiPbMP21TP7bEdhfokb/JnduuqhxLs4uSJA184k/YVfFu+3TJlCWWCVDRfdq2lqPq//GySAYsHDX1oR82zBQFE4TU89aTlcQEeiKVHkvyYnRpnUdtbfP5fZLm1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195167; c=relaxed/simple;
	bh=agw/3OLr01OI9Z2AEsHW5hxgs4yTiSEeIQYnDEuxLqU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=pj4X87zclDIeJWkrORnc3PVnBLTJQNf7sVmitPdSZETccO22FZRlmfxySbSfJg22GJc2Z2EFxg8yZNlMpoVGAUSAn+JDFbJIHKlJd36O3NznT1F/545rPBpg5qSVNO2XmrqKcfAfoTTpubzoyboehe2/f1Vg3n6L6fdaOSOLmp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=HRpNt7eC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="HRpNt7eC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso36438955ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785195165; x=1785799965; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivKwF1e6mCQ4blVrL4UI4kl3EsorYCgE4iuB9QPACIg=;
        b=HRpNt7eChvdbqcFbJlPYkDgcaM+QA7gF7X4dvUGmR40BrVbbbzq67Cm2DZmZD7hEpo
         P6oGQYpG8kpBTNhnpP1Y6kZ77Jebx2TrYG638EP74pZOMAP8IpMbJlx7yVeAXVw6ekNi
         4v+MSCFR4MY3X8YMUQggoxGyCOQz1t/gj9I4+CvZeADvhrCyshdV8QMTJRwxDTtP1rBG
         vyw0NCaxHzYQnxX0+ktwu5nPdnYJ7lUPAbmAYY+nVx893UnhjxwqBKStvoPwdgKDqAZ1
         cz1ZSfLga6hBo0qRUveNiuBY89C4TEJsMSqhVSHb9PV/2NSGxvuURczqKiKMfoJuTpjY
         u+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785195165; x=1785799965;
        h=in-reply-to:references:subject:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ivKwF1e6mCQ4blVrL4UI4kl3EsorYCgE4iuB9QPACIg=;
        b=tAhjeJcBRbu9MzQv2n38jR1yLyuh/qR/zT6+m1iz2Ns0ueOO7R+6u+WpgQCnIT5sHv
         9NNe+TfISnHl2ZC0HjIRsWYtmS0Gw9u03m11nTTukFJn7IiIpx3XUEXS1nXFjwk11gCu
         g2BheSlESeBxEit8B0fwEcDFGwl2bdsFZUkUUeUTa1yaR+cyi+D7jQ2jwr7YYh7KHrjU
         qPbT0v3AaRcmJfXpinV+hem5jN+eU3wxx0V4X8FH/4SCYribW7jmGd242bVhjpNrXLP/
         hTKc2ZqsQZvCnc/LKgl/ezS+/SHjehMNl+9nb7lZnoqqhsJUm1PVa+nE9udz+aiFLE1/
         wq8w==
X-Forwarded-Encrypted: i=1; AHgh+RouqJS+GhKn2ciqC8paO+mSDL+NX1j0ZNBZhMgsaX16L/AaDl5DmKlHgMY33AKb36WdUZIKuRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2YUgTiT1tMiBC09wdhtt5pFc2pjpApiXnF6IWrlWLYN7CvG5A
	q1URjtfr3NJmbwzg4TXpBXDg3s0mEvaahRE+U39VgXr+JLrT4zHKXgHQpLHlkJhdTs0=
X-Gm-Gg: AR+sD10FwlJHC/Bsxjyz7PaIB7/0HUeAaGC/YTCMOnPCgdnd2nifLGgplXqrGyQhhqC
	f3OwYilJyklaWVe6UAGIA0Hzm+5VB2i96YYj7fy3yLp+KklQA6SXw1DLDUrR8yzCwVDadCseoSg
	tQJGmRyBzTF3EK8d/RLV3h4Zsuli842nbzubZg/xM44GYkl7eb+BgyLOAYamaDvXX34XABb4zzg
	nR+pBJ5LoIBdNnD2FL11FxZBepDr+NZXAhqWxtVx+0ieUVdF7+QQEMqH3tYAi2P/Z4ZUZh3hQaq
	6XqgG6lt5ojKjOG21XaOknUjBDwuDSwFBE/fqR4R+N/1vwm3IKFoCBEExe2VOczM6W2Ni7bbofh
	kFLJQwGlEozL1MUgsP6dbcMEEQwmgTsk7kWu6Q2yKaz8uSUYGwvkFyJq90lm6a+Gz7XJOO03CO7
	Ps4aNqo+xvF0f2UZI5gY7qX3tF5TGx4Ekc3fYb8USTjA==
X-Received: by 2002:a17:903:2f48:b0:2cc:777f:d67c with SMTP id d9443c01a7336-2d01576266amr492355ad.13.1785195164852;
        Mon, 27 Jul 2026 16:32:44 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bd03sm42380135ad.17.2026.07.27.16.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 16:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 19:32:42 -0400
Message-Id: <DK9QVC2YO30L.3TKTHLE7TXS0D@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <chia-yu.chang@nokia-bell-labs.com>, <jolsa@kernel.org>,
 <yonghong.song@linux.dev>, <song@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <memxor@gmail.com>, <shuah@kernel.org>,
 <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <horms@kernel.org>,
 <dsahern@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <jhs@mojatatu.com>, <kuba@kernel.org>,
 <stephen@networkplumber.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <andrew+netdev@lunn.ch>, <donald.hunter@gmail.com>, <kuniyu@google.com>,
 <ij@kernel.org>, <ncardwell@google.com>,
 <koen.de_schepper@nokia-bell-labs.com>, <g.white@cablelabs.com>,
 <ingemar.s.johansson@ericsson.com>, <mirja.kuehlewind@ericsson.com>,
 <cheshire@apple.com>, <rs.ietf@gmx.at>, <Jason_Livingood@comcast.com>,
 <vidhi_goel@apple.com>
Subject: Re: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>

On Tue Jun 30, 2026 at 8:01 AM EDT, chia-yu.chang wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> This patch replaces existing min_tso_segs() with tso_segs() CC callbak
> for CC algorithm to provides explicit tso segment number of each data
> burst and overrides tcp_tso_autosize().
>
> This change provides below impacts on BPF struct_ops users:
> - The callback is renamed from min_tso_segs to tso_segs
> - The signature gains an extra u32 mss_now argument
> - The return value semantics is changed from "floor value passed into
>   tcp_tso_autosize()" to "final tso_segs value", bypassing autosizing
>
> As a result, BPF programs shall be updated, beccause retuning a small
> constans will now directly limit tso_segs instead of the minimum.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

As mentioned in v4, from a BPF standpoint this is cleaner. Feel free to
add:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/net/tcp.h                                | 13 +++++++++++--
>  net/ipv4/bpf_tcp_ca.c                            |  8 +++++---
>  net/ipv4/tcp_bbr.c                               | 13 ++++++++++---
>  net/ipv4/tcp_output.c                            | 13 +++++++------
>  tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
>  5 files changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6d376ea4d1c0..7fb42a0ce7da 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -824,6 +824,9 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu);
>  unsigned int tcp_current_mss(struct sock *sk);
>  u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when);
> =20
> +u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> +		     int min_tso_segs);
> +
>  /* Bound MSS / TSO packet size with the half of the window */
>  static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize=
)
>  {
> @@ -1361,8 +1364,14 @@ struct tcp_congestion_ops {
>  	/* hook for packet ack accounting (optional) */
>  	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
> =20
> -	/* override sysctl_tcp_min_tso_segs (optional) */
> -	u32 (*min_tso_segs)(struct sock *sk);
> +	/*
> +	 * Override tcp_tso_autosize (optional)
> +	 *
> +	 * If provided, this callback returns the final TSO segment number
> +	 * and will bypass tcp_tso_autosize() entirely. The implementation
> +	 * must derive an appropriate value and ensure the result is valid.
> +	 */
> +	u32 (*tso_segs)(struct sock *sk, u32 mss_now);
> =20
>  	/* new value of cwnd after loss (required) */
>  	u32  (*undo_cwnd)(struct sock *sk);
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 791e15063237..27c4cdfd80a8 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -284,9 +284,11 @@ static void bpf_tcp_ca_pkts_acked(struct sock *sk, c=
onst struct ack_sample *samp
>  {
>  }
> =20
> -static u32 bpf_tcp_ca_min_tso_segs(struct sock *sk)
> +static u32 bpf_tcp_ca_tso_segs(struct sock *sk, u32 mss_now)
>  {
> -	return 0;
> +	if (unlikely(!mss_now))
> +		return U32_MAX;
> +	return tcp_tso_autosize(sk, mss_now, 0);
>  }
> =20
>  static void bpf_tcp_ca_cong_control(struct sock *sk, u32 ack, int flag,
> @@ -320,7 +322,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_conges=
tion_ops =3D {
>  	.cwnd_event_tx_start =3D bpf_tcp_ca_cwnd_event_tx_start,
>  	.in_ack_event =3D bpf_tcp_ca_in_ack_event,
>  	.pkts_acked =3D bpf_tcp_ca_pkts_acked,
> -	.min_tso_segs =3D bpf_tcp_ca_min_tso_segs,
> +	.tso_segs =3D bpf_tcp_ca_tso_segs,
>  	.cong_control =3D bpf_tcp_ca_cong_control,
>  	.undo_cwnd =3D bpf_tcp_ca_undo_cwnd,
>  	.sndbuf_expand =3D bpf_tcp_ca_sndbuf_expand,
> diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
> index 82378a2bfd1e..b63e77b14c65 100644
> --- a/net/ipv4/tcp_bbr.c
> +++ b/net/ipv4/tcp_bbr.c
> @@ -297,11 +297,18 @@ static void bbr_set_pacing_rate(struct sock *sk, u3=
2 bw, int gain)
>  }
> =20
>  /* override sysctl_tcp_min_tso_segs */
> -__bpf_kfunc static u32 bbr_min_tso_segs(struct sock *sk)
> +static u32 bbr_min_tso_segs(struct sock *sk)
>  {
>  	return READ_ONCE(sk->sk_pacing_rate) < (bbr_min_tso_rate >> 3) ? 1 : 2;
>  }
> =20
> +__bpf_kfunc static u32 bbr_tso_segs(struct sock *sk, u32 mss_now)
> +{
> +	if (unlikely(!mss_now))
> +		return U32_MAX;
> +	return tcp_tso_autosize(sk, mss_now, bbr_min_tso_segs(sk));
> +}
> +
>  static u32 bbr_tso_segs_goal(struct sock *sk)
>  {
>  	struct tcp_sock *tp =3D tcp_sk(sk);
> @@ -1151,7 +1158,7 @@ static struct tcp_congestion_ops tcp_bbr_cong_ops _=
_read_mostly =3D {
>  	.undo_cwnd	=3D bbr_undo_cwnd,
>  	.cwnd_event_tx_start	=3D bbr_cwnd_event_tx_start,
>  	.ssthresh	=3D bbr_ssthresh,
> -	.min_tso_segs	=3D bbr_min_tso_segs,
> +	.tso_segs	=3D bbr_tso_segs,
>  	.get_info	=3D bbr_get_info,
>  	.set_state	=3D bbr_set_state,
>  };
> @@ -1163,7 +1170,7 @@ BTF_ID_FLAGS(func, bbr_sndbuf_expand)
>  BTF_ID_FLAGS(func, bbr_undo_cwnd)
>  BTF_ID_FLAGS(func, bbr_cwnd_event_tx_start)
>  BTF_ID_FLAGS(func, bbr_ssthresh)
> -BTF_ID_FLAGS(func, bbr_min_tso_segs)
> +BTF_ID_FLAGS(func, bbr_tso_segs)
>  BTF_ID_FLAGS(func, bbr_set_state)
>  BTF_KFUNCS_END(tcp_bbr_check_kfunc_ids)
> =20
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 00ec4b5900f2..f3fc4b64e61d 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2253,8 +2253,8 @@ static bool tcp_nagle_check(bool partial, const str=
uct tcp_sock *tp,
>   * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allowan=
ce
>   * is below 1500 bytes after 6 * ~500 usec =3D 3ms.
>   */
> -static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> -			    int min_tso_segs)
> +u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> +		     int min_tso_segs)
>  {
>  	unsigned long bytes;
>  	u32 r;
> @@ -2269,6 +2269,7 @@ static u32 tcp_tso_autosize(const struct sock *sk, =
unsigned int mss_now,
> =20
>  	return max_t(u32, bytes / mss_now, min_tso_segs);
>  }
> +EXPORT_SYMBOL(tcp_tso_autosize);
> =20
>  /* Return the number of segments we want in the skb we are transmitting.
>   * See if congestion control module wants to decide; otherwise, autosize=
.
> @@ -2278,11 +2279,11 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned=
 int mss_now)
>  	const struct tcp_congestion_ops *ca_ops =3D inet_csk(sk)->icsk_ca_ops;
>  	u32 min_tso, tso_segs;
> =20
> -	min_tso =3D ca_ops->min_tso_segs ?
> -			ca_ops->min_tso_segs(sk) :
> -			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
> +	min_tso =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
> =20
> -	tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> +	tso_segs =3D ca_ops->tso_segs ?
> +			ca_ops->tso_segs(sk, mss_now) :
> +			tcp_tso_autosize(sk, mss_now, min_tso);
>  	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
>  }
> =20
> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c b/tools/tes=
ting/selftests/bpf/progs/tcp_ca_kfunc.c
> index 0a3e9d35bf6f..58262e490336 100644
> --- a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
> @@ -10,7 +10,7 @@ extern u32 bbr_sndbuf_expand(struct sock *sk) __ksym;
>  extern u32 bbr_undo_cwnd(struct sock *sk) __ksym;
>  extern void bbr_cwnd_event_tx_start(struct sock *sk) __ksym;
>  extern u32 bbr_ssthresh(struct sock *sk) __ksym;
> -extern u32 bbr_min_tso_segs(struct sock *sk) __ksym;
> +extern u32 bbr_tso_segs(struct sock *sk, u32 mss_now) __ksym;
>  extern void bbr_set_state(struct sock *sk, u8 new_state) __ksym;
> =20
>  extern void dctcp_init(struct sock *sk) __ksym;
> @@ -90,9 +90,9 @@ u32 BPF_PROG(ssthresh, struct sock *sk)
>  }
> =20
>  SEC("struct_ops")
> -u32 BPF_PROG(min_tso_segs, struct sock *sk)
> +u32 BPF_PROG(tso_segs, struct sock *sk, u32 mss_now)
>  {
> -	return bbr_min_tso_segs(sk);
> +	return bbr_tso_segs(sk, mss_now);
>  }
> =20
>  SEC("struct_ops")
> @@ -120,7 +120,7 @@ struct tcp_congestion_ops tcp_ca_kfunc =3D {
>  	.cwnd_event	=3D (void *)cwnd_event,
>  	.cwnd_event_tx_start =3D (void *)cwnd_event_tx_start,
>  	.ssthresh	=3D (void *)ssthresh,
> -	.min_tso_segs	=3D (void *)min_tso_segs,
> +	.tso_segs	=3D (void *)tso_segs,
>  	.set_state	=3D (void *)set_state,
>  	.pkts_acked     =3D (void *)pkts_acked,
>  	.name		=3D "tcp_ca_kfunc",

