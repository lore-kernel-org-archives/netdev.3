Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793021256;
	b=Mjd0FkdUu9eqcGcrXRZZBg8ALcBvGfbmAqxd+5WwEyK7BUR1W/uQlCMbnlXVT5WgI5e/
	 EeEPowkUHj2EccvThn3gVgGtKeDgJn1KMrHNM00UdBquR9ZNggmHbtaqeDdPxGbaKiEww
	 qZkJtKLAGL1m9q4PV0CZWAsETL+Pg+w3+rcVJrtlfDgoxgEfzw2nMrHCtzsxLI67dgaMj
	 VGThmDhUzAa3OMRVFSSFa01vJc2vuT554hUf5+fOGqFuX5H3ST0slKuNnkxMMbh1xXJoa
	 1GnGlfAVULrwwePA2SBN5BQ70C0B+I4Ka8+Fh95ekrSeVIWxaro8hSphIoujgwxh/bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=nHqLvj8Lae2DmWkzf4tbdqzHokUVVq51GUhntGgEEB0=;
	b=L2mSu/u0sd0ilXfyEvxb7+2VH8hiWzrRmEa1BxZsBjOL566qXPOvcdu6B6LiuoUkoHEx
	 dobMv+Lq6IcTx0qSQf9DntqdHv5z0MgqVCP94sqt1+rw3wXd0JBq8bOqBwlHm/dmumjvx
	 5t9v3WZJB8gJxqOhjTkraaV2OM27KbyrqgUU9LRX7POSC3b6a6aH+2/fBtx7fCScfhz0u
	 0gsyuRs0MmuV+pMm1I1iORnJb2URvcRHxrtONojjEDxEv6URZPYnG/eUqldSKsSItnLUR
	 MyhOKDokUu8gwgqY5UUqe2oAs8td1KEO7gqvK+8bfnoE2L5K2hn6LKB5N5ueIwmNidA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kBQBTONZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB3606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 13:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADBB3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kBQBTONZ
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5383c97c8cfso350541cf.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 06:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793021255; cv=none;
        d=google.com; s=arc-20260327;
        b=YmVQrNJEtLAk2/GGme8iMHK/1qq7MFMwxy/nXGx282H7kwBqAizuo+XP/Y049su8gU
         W8jeXy+FQz01c6MnQ/UYtH90tBo0lYpMXA/hr3+mZFsMd4eUKuivsOgq0lYpzdtUu8rV
         hY/SX6sxnKawxWsGHeG9WMPXXskmvyxzD9OM7aufpe/dtrv9zejTgqckXHgOimrhd52z
         ayCp16QjMv7INzrqVFIQd94im9oST97wp7x1eA221N09UFES+1S6VVqidvpyU/gd8sMO
         zPEYFJWDbJvvbbIWaBVWIO88+SIpeqKIdAOoBk3K/iBIKAWORsDuRUoiNzDieC5l98nY
         k9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nHqLvj8Lae2DmWkzf4tbdqzHokUVVq51GUhntGgEEB0=;
        fh=WT/ihHHfRGOAYAUf9FDf7k6UVguHgQrpaITPqfYK89Q=;
        b=RfHPavbcLugAWEh9UpAzWS/fqNRo6qaI1LmzEIVgY2SLrz7k3ryLPrbElie2pR7jQE
         a4Q/NUqHe1MtxAeHZZ6u7H2FqBHeOOsejugdEaIGnqlVVc3u2Q2ODPMVk2zMsQ7b5Anc
         3lWuifUI5q3rjmGnhV4Num1WeWD+SidG8bm6guPNfhFwUdXc4ltetxqQQfpZQx3Fqmja
         27eyAiEF1S7MmDoPiZPR6cqCGAGsEl3fB39Tylc0pLYuzVIPkCUreCxpn7sHncoYb0d2
         CsVQsb2tC+sV04EWq4vE42I4JlHd2rjmYhBTGLLeD7hI3VWsNupqoc+uxG1FXnm+HNGB
         oSSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793021255; x=1793626055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nHqLvj8Lae2DmWkzf4tbdqzHokUVVq51GUhntGgEEB0=;
        b=kBQBTONZNE4dAN5GZDIY3MRRu+hPcBJmpC8mXtv0J2VaamZnfxyXU6sfs5pXnAxXpv
         eq/kSaD2KPruOaGhuXu4t8T2tzlPAS29P/7bE6pPGThxLEQZPXtHUubZegxSs/2h2ifi
         puB6YwZXKu16VmvoZzvW5i0Hgi+MCZRnFC4+1tXLHFnB8Xa4G0+rWDtpn2nQ87NqeU2f
         pi7hJEkvmbZdRV/H3D3lrc1YbLPSqoIp3HNiD6vfrzhVoHTwTbz8XrVS9rzmYZHNoK/P
         zKvnzQ4nAQEiJ5XdoIhpHu2RqB5+v8/PMqtBB29a0LCcq6voixiKGW/9wyiIM2YuuHeP
         336A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021255; x=1793626055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nHqLvj8Lae2DmWkzf4tbdqzHokUVVq51GUhntGgEEB0=;
        b=ahAw9D0rKmglOJIeRjsgs4q+LyHH9eJvu3HZ06fIx4beEhTLcomd97JI/ZiAkxrtCR
         X/Hn6OBbljuOevKkkjAbOePGiJrrHPUszqi81SnBqsS7OGe03foTlJT0GYltimu9R5hM
         yypC6RLUkXvIdF9KImnXeMYsN0fe13qQTvy68XsOXz+jM6QZsQkfgiy0EXWCKiZQDsMU
         zWwiC6/ICcemFomRl1lweK2IexQSyMOuN0MWTLgqzIsJRAOXNa+BMrW7zDu6Z49DhuNa
         2qVORSOD6g3XQ6t2H0kOdPgkExtSuXBU4gH3M5B2fLK2Fk7TcxRhfMfK1fM4K0fGTJ/3
         H7yw==
X-Gm-Message-State: AFq9FYKAhYxTWHh7sikdb2WoUqsUGFdu9beMI2JOdZWOg45jhY4JEXue
	VHl3a/lgnRSsibS6peIJ3fySh9CeJEa1P3HgDdRq6DG4PgYXRd4K8tvMm3RuXxncKC4dPUuflQf
	Y9RVF68NLgo+/+7kpuvd1zmQGDMCHdTUH+GlOScEv
X-Gm-Gg: AYBFou3YDBTACQGSl8NPOnEYxpWifuyBaMO6+ZOcbUYR8fAJoq0HodIBNSEkCBGcT0H
	rsuoQLfl3zupsSNhsI3lnbZvin+HMR9hdTYa6kUGu4Jy1ez51O+Pwr9ecT4caS/QYXpM61DnEvt
	R0x3A55onyuHAI/zfCCuWbKBc5TyM4/fu1q8b1CNQnBC838kLbC0BilBbiKm4PMXf9X7KkOlbK1
	dp5nq+4CIJKzkWEC87NHRf3iTGNvNUwufSgPqhMs+3n6TevF7ZFyAOb1kPjFgt0Xh1swSGNnI9z
	+EjoywxEAz2rM3NgYDT0WheG481mvgR6FmBDdsymg+wxPRAGSIzmJHEUrP6aDzlHfy+COWe8Zb1
	e9jgNr5fll9RLGgEEtf/+u1PAMiYjFDmgbAzEDv1eDJIoUvmsbPD+7wzt1oFRk5AS7Zhfrr0yO4
	c0pRz3PPu1S5kdv3goQ6URAKQmPEw=
X-Received: by 2002:a05:622a:17ce:b0:536:353e:8d2a with SMTP id
 d75a77b69052e-5383b334525mr33163801cf.1.1793021253663; Mon, 26 Oct 2026
 06:27:33 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026123244.239766-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261026123244.239766-1-jiayuan.chen@linux.dev>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 26 Oct 2026 09:27:16 -0400
X-Gm-Features: AclHuK9xXY2sfDTTRDFEqgc-QLnjFc7Mr6f06K7c4ldWWLoFtzMF4Hg3hrOtA5o
Message-ID: <CADVnQy=ZQ8VEdwSB6gcC=67aD+OJkMvu-tbhgwEn0YEZCyVw6g@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: fix shift-out-of-bounds in SYN-ACK
 retransmit timers
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Kuniyuki Iwashima <kuniyu@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 8:32=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> req->num_timeout counts the SYN-ACK timeouts of a request and is used as
> a shift amount:
>
>         /* tcp_reqsk_timeout() */
>         u64 timeout =3D (u64)req->timeout << req->num_timeout;
>         /* tcp_fastopen_synack_timer() */
>         req->timeout << req->num_timeout
>
> Once it climbs past the width of the shifted type the shift is UB. Seen
> with tcp_synack_retries=3D255 and a peer that never completes the
> handshake:
>
>   UBSAN: shift-out-of-bounds in ./include/net/tcp.h:917:34
>   shift exponent 64 is too large for 64-bit type 'long long unsigned int'
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0xc1/0xf0
>    dump_stack+0x10/0x20
>    __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>    reqsk_timer_handler.cold+0x1c/0x5d
>    call_timer_fn+0x17d/0x510
>    __run_timers+0x662/0xab0
>    run_timer_softirq+0xdf/0x260
>    handle_softirqs+0x204/0x9b0
>    __irq_exit_rcu+0x13c/0x220
>    irq_exit_rcu+0xe/0x20
>    sysvec_apic_timer_interrupt+0x40/0xd0
>    asm_sysvec_apic_timer_interrupt+0x1b/0x20
>
> num_timeout is a 7-bit field. Once a retransmit limit is above 127 the
> "num_timeout >=3D limit" check can never be true, the request is never
> expired by that limit, and after the field wraps to 0
> reqsk_timer_handler() decrements queue->young again on the next expiry.
>
>  - split tcp_reqsk_timeout() into tcp_reqsk_timeout_sk() and bound the
>    shift there; a num_timeout well under 30 already saturates the
>    tcp_rto_max() clamp, so nothing reachable changes for the u64 path.
>  - cap max_retries / max_syn_ack_retries at 127, the largest value the
>    field can hold, instead of narrowing the sysctl; 128..255 are still
>    accepted and act as 127.
>  - cap the TCP_DEFER_ACCEPT conversion in secs_to_retrans() at 127 too;
>    larger values kept an acked request from ever expiring. getsockopt()
>    now reports at most 14527 instead of 29887 seconds.
>  - route the TFO path through the same helper; its u32 shift could also
>    wrap to 0 before reaching UB.
>  - document that tcp_synack_retries values above 127 act as 127.
>
> Fixes: e6c022a4fa2d ("tcp: better retrans tracking for defer-accept")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v1 -> v2: reworded the commit message, no code change.
> v1: https://lore.kernel.org/netdev/20261023064915.401112-1-jiayuan.chen@l=
inux.dev/
> ---
>  Documentation/networking/ip-sysctl.rst |  4 +++-
>  include/net/tcp.h                      | 16 ++++++++++++----
>  net/ipv4/inet_connection_sock.c        |  2 ++
>  net/ipv4/tcp.c                         |  2 +-
>  net/ipv4/tcp_timer.c                   |  3 ++-
>  5 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 4b19c8d3efda..eac33072be2d 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -956,7 +956,9 @@ tcp_stdurg - BOOLEAN
>
>  tcp_synack_retries - INTEGER
>         Number of times SYNACKs for a passive TCP connection attempt will
> -       be retransmitted. Should not be higher than 255. Default value
> +       be retransmitted. The sysctl accepts 0-255, but values above 127 =
are
> +       silently capped by the SYN-ACK timers to match the 7-bit
> +       request_sock::num_timeout field. Default value
>         is 5, which corresponds to 31seconds till the last retransmission
>         with the current initial RTO of 1second. With this the final time=
out
>         for a passive TCP connection will happen after 63seconds.
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0265c27a5fd7..986b7ea05e4a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -183,6 +183,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
>  #define MAX_TCP_KEEPINTVL      32767
>  #define MAX_TCP_KEEPCNT                127
>  #define MAX_TCP_SYNCNT         127
> +/* request_sock::num_timeout is a 7-bit field. */
> +#define MAX_TCP_SYNACK_RETRIES 127
>
>  /* Ensure that TCP PAWS checks are relaxed after ~2147 seconds
>   * to avoid overflows. This assumes a clock smaller than 1 Mhz.
> @@ -912,12 +914,18 @@ static inline u32 __tcp_set_rto(const struct tcp_so=
ck *tp)
>         return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
>  }
>
> -static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
> +static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk,
> +                                                const struct request_soc=
k *req)
>  {
> -       u64 timeout =3D (u64)req->timeout << req->num_timeout;
> +       u64 timeout =3D (u64)READ_ONCE(req->timeout) <<
> +                     min_t(u8, req->num_timeout, 30);
> +
> +       return (unsigned long)min_t(u64, timeout, tcp_rto_max(sk));
> +}
>
> -       return (unsigned long)min_t(u64, timeout,
> -                                   tcp_rto_max(req->rsk_listener));
> +static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
> +{
> +       return tcp_reqsk_timeout_sk(req->rsk_listener, req);
>  }
>
>  u32 tcp_delack_max(const struct sock *sk);
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 8151c638a24c..ee7b64f3141c 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1072,6 +1072,8 @@ static void reqsk_timer_handler(struct timer_list *=
t)
>         net =3D sock_net(sk_listener);
>         max_syn_ack_retries =3D READ_ONCE(icsk->icsk_syn_retries) ? :
>                 READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
> +       max_syn_ack_retries =3D min_t(int, max_syn_ack_retries,
> +                                   MAX_TCP_SYNACK_RETRIES);
>         /* Normally all the openreqs are young and become mature
>          * (i.e. converted to established socket) for first timeout.
>          * If synack was not acknowledged for 1 second, it means
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 99d7237a623d..a309fd45ad42 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -358,7 +358,7 @@ static u8 secs_to_retrans(int seconds, int timeout, i=
nt rto_max)
>                 int period =3D timeout;
>
>                 res =3D 1;
> -               while (seconds > period && res < 255) {
> +               while (seconds > period && res < MAX_TCP_SYNACK_RETRIES) =
{
>                         res++;
>                         timeout <<=3D 1;
>                         if (timeout > rto_max)
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index e56eae4bc341..f7b100334a89 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -469,6 +469,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk=
, struct request_sock *req)
>          */
>         max_retries =3D READ_ONCE(icsk->icsk_syn_retries) ? :
>                 READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) +=
 1;
> +       max_retries =3D min_t(int, max_retries, MAX_TCP_SYNACK_RETRIES);
>
>         if (req->num_timeout >=3D max_retries) {
>                 tcp_write_err(sk);
> @@ -490,7 +491,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk=
, struct request_sock *req)
>         if (!tp->retrans_stamp)
>                 tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
>         tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
> -                         req->timeout << req->num_timeout, false);
> +                            tcp_reqsk_timeout_sk(sk, req), false);
>  }
>
>  static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
> --
> 2.43.0

The following review comments are from an LLM, look legitimate, and
IMHO are worth addressing.

Please either incorporate each piece of feedback or respond to
indicate why you think it's not appropriate.

---

Thanks for the fix. The logic looks right to me, and I could reproduce
both splats and confirm the patch fixes them. A few comments:

1) The changelog suggests tcp_synack_retries (or TCP_DEFER_ACCEPT) must be
   raised. But a listener can also set TCP_SYNCNT up to MAX_TCP_SYNCNT
   (127), and that also bounds its SYN-ACK retries. So num_timeout reaches
   the UB range with default sysctls. With TCP_SYNCNT=3D127 plus
   TCP_RTO_MAX_MS=3D1000 on the listener, the tcp.h:917 splat (shift
   exponent 64) shows up after about 64 seconds. For TFO it fires already
   at num_timeout 32, because "req->timeout << req->num_timeout" is a
   32-bit shift (req->timeout is u32). Please mention TCP_SYNCNT. It also
   shows the shift clamp is needed independently of the 0..255 sysctl
   range.

2) Before the shift amount goes out of range, the shifted value already
   wraps. With HZ=3D1000 and req->timeout =3D 1000:
     (u64)1000 << 61..63 =3D=3D 0, and (u32)1000 << 29..31 =3D=3D 0.
   Both give zero-length timers. On an unpatched kernel I see bursts of
   three back-to-back SYN-ACK retransmits about 1 ms apart:
     - regular path: at num_timeout 61-63, and again at 125-127 once x86
       masks the shift count;
     - TFO path: at num_timeout 29-31, 61-63, 93-95 and 125-127.
   That is user-visible on production (non-UBSAN) kernels and is also
   fixed by your clamp. It may be worth a sentence in the changelog.

3) READ_ONCE(req->timeout): as far as I can see, req->timeout is only
   written in reqsk_queue_hash_req() and tcp_fastopen_create_child(),
   both before the request is visible to other CPUs. If this is meant as
   a data-race annotation, please explain it in the changelog (and pair
   it with WRITE_ONCE()). Otherwise I would drop it from this fix.

4) Nit: this patch caps the shift at 30 and patch 2 caps it at 32, for the
   same reason. Maybe use one bound in both, plus a one-line comment on
   why it cannot change the clamped result. 32 also works here, since
   (u64)U32_MAX << 32 still fits in a u64.

5) Nit: MAX_TCP_SYNACK_RETRIES duplicates MAX_TCP_SYNCNT (127), which
   already limits the listener's SYN-ACK retries via TCP_SYNCNT. Maybe
   reuse it, or define one in terms of the other, with the 7-bit
   num_timeout comment.

6) Have you considered limiting the sysctl itself, as 651e92716aaa
   ("sysctl net: Keep tcp_syn_retries inside the boundary") did for
   tcp_syn_retries? That would make the limit visible to admins instead
   of silently capping it. The consumer-side caps would still be needed
   for TCP_DEFER_ACCEPT and for the TFO "+ 1" (128 can never be reached
   by a 7-bit counter), so your approach is reasonable. It would be good
   to say in the changelog why the silent cap was preferred.

7) Minor: once num_timeout wraps to 0, the
   "if (req->num_timeout++ =3D=3D 0) atomic_dec(&queue->young)" in
   reqsk_timer_handler() and reqsk_queue_removed() decrement queue->young
   again. That is one more symptom fixed by making the request expire at
   127.

8) The documentation text exposes an internal field name
   ("request_sock::num_timeout"). Maybe simply: "Values larger than 127
   are treated as 127."

9) Small user-visible change worth a note in the changelog: for large
   values, getsockopt(TCP_DEFER_ACCEPT) now reports at most
   retrans_to_secs(127) =3D 14527 seconds instead of 29887.

10) Per Documentation/process/maintainer-netdev.rst ("Bug fixes"), please
    state how the issue was found, how it was validated (the reproducer
    steps are short enough to include), and how the fix was tested.

---

Thanks,
neal
