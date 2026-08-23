Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA91AA797
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787474873; cv=pass; b=uaa8yhiaxZSf4u4IkIjbgtMZ4AcDpaIFx9uAnIpC86gGkyB31pjurq94ki9c5NkHf3g+N8+Ph7TDjGJPQu9SzGp+VedsYNeaPeD/l5q2i1LXolBh/chE5Ut0EESH8mV3i8DFfEp6fE2zHTRwtPTyD/wsiYMEvd0YlgW3yN/Qn14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787474873; c=relaxed/simple;
	bh=Y1/afvLx2kRz3J+SyO2kMSJEXmW9kpWtinbmUWAdskc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnxCN/b2NEMnBn3cZR9e3DF2ur4BypooxO0QwlDSHh3gr7vzNjwNvu82yoJhnCBwWIxjMQjfMt5fzYdDyuGoIr0w1gz87m3a8U4w0lYTkJbJQ3NYyY71BOO8kaAL52dLK/uRtUT34gtRGeZEJwkoJgs3pd3o1BM22YRvFTu3WXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=HyaqH8et; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="HyaqH8et"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39f91ba1ef7so18392671fa.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 01:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787474869; cv=none;
        d=google.com; s=arc-20260327;
        b=X2CmkcXNb1ptuceTfCswSenTioQhuwjm3AUAE5H6yorj3Tj/zd6XYtk8bugdBONRk/
         TW7lt/AkFaGFqpERMHxTHLqc+LvZS3K6DkeIvWf0RCRkCRCFmmcKrJctd99+LQzS6GBh
         Ji8mdz1SPloMUMCe15Z/9nk1aAYTGmlCvOzibCPyM4aJCU8aOnC8MfXa+Wg6OJZWbDlV
         1snKipw0409+emNnQKetu2ZiqHYdSwP3Gw/DKURaYkED1HdFoQLZJA7CbYC77Fuzbnyj
         fKXbnS5sXP1Oc7S8QQBN8FZJ9hfEflQxhWk80vhWInyFUXTBVlPDg5+txGMHZ9elouFP
         XMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x3R4OugVoYKHzOmYMA7aoJPGAJav8Y7iXXbkDPaJur0=;
        fh=MbAxHnZFd8OLCi+NhS0e21sVgR5c6gU93HZKdGMXE3c=;
        b=oPblXXQNqWEj3RAxyPlN+ccXHelxiUwHa8PfeBmLak/NURMhdZr6/RJHIRMV9AOoau
         Ya87Y4GJcnoAkIl57N0F+g2AcLSOAYSJHsNAjrhJnd61CbQI7hP19p5Oi67W7JmlcCBs
         5Tsyu+vKtYGGVSkMVs8pWvgcCdpIUUj319UvrNqHqkmtU9vmtKICgXfFenhsCWfZ9IZi
         zNhI2kJLXUC2qyYIWMvW+p3cVY1DovtEmc6TWs6IPylahlri5bExfB5RigAOex2wBKBn
         BCL5UTYccpbt0nspatOcVlWHg+IkJXunHUhk6gftHqTa9uRwXzQbpRcd8iL9OqnhWoBv
         aY6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787474869; x=1788079669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x3R4OugVoYKHzOmYMA7aoJPGAJav8Y7iXXbkDPaJur0=;
        b=HyaqH8et/v/ogBNShACOVG8KO52nMnmZQP3/xMQseWWQC3y+/90DAO3gup76IOYBDt
         EKDdSiZjc9iNACU/Q8wNHT5evRF4A+Ft2RUe6aUNHXBtmlAih0EZsFGUJtpdkZKZwoiB
         7Nylds1NN1Wrjn3cRKgiBa7wEIgjwaL20MEQLUDZpWyw6lN+rMwj28Ohy4cynQMgVocP
         8b0wi9YJCWBT7zrb13Jh40J3KSwX7Hh+KYtKVZ0ZXpH6IlWVaMCL7Srk7G6j1fDIpJ7D
         k7NLDGSGlQbVyUJou3jQsOAV5emXKTg+vuQXC9a8D2GXLjWr0RuadinDp0fYtqEavC5Z
         J9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787474869; x=1788079669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3R4OugVoYKHzOmYMA7aoJPGAJav8Y7iXXbkDPaJur0=;
        b=NHdYMfTuKf9wQhOfS4CzFjUViVPV0NgEVduTDsDS17V7v5PaXnLvvrmYytp5kHQlNw
         PAihMWyCYasRFtYs6LpHfrUFHeCmk6+EQ4mLDXaTbcIs6etrd55HUbnnFYwawYucbwzk
         ssbmCCVhCmPKrhexn2e3INJYXCm7iJRG5FIE8Tdh7oz4mBjacU3k49zxetAC+KHQTvmh
         f30ZkiKrnyA8VQjCue5cPkRNSkovucitp/AapAebogqnHizd+ygzBd1cD89iL6sJBY+r
         p9IP1Vt/jvd3r0xOAY9rbbN+0eONAXezyJMgGyFErKPNSC2/SntgybNj5hD2lAGjKQGv
         JaUA==
X-Forwarded-Encrypted: i=1; AHgh+RrkuHcXmoCHNLn4qmtEulun/5lfYDCbKAHACjtXdRTFIOLtIJf8QeKybkWP9+JV/kBRYiU1ZAU=@vger.kernel.org
X-Gm-Message-State: AFuF++lxPG1MARSZLWrk20Nv0pGReLe35I7LSdbuRXPr2hYarQZiIHo9
	UClz/L/8XLjDqqYjxAAcmqqE8sVIksSfOi3pYHlp3IAvcjsntMjZA577/N3a+pDRfTCxPkqFgWM
	KsNSNx5GwO/BGncHzCvv99L+YDsvUW5wnjliZwPcYDbnQtibfdnDbWcxIBGE=
X-Gm-Gg: AR+sD10haep67/B9dwquehQ5FJ3mSxTeMiFPVW55rNgA09utF3pPJZ2Gdkkp7mZL2f4
	pDvN1RUnKQD2D7+XS6N5nTy19Qo7Na06dcoFtpKEo6fo8PYiK6fJto0DQZYA87KBf1RMfViEyEJ
	sF6px4w2Bf/hff0dLrSp9lo4jX+8Jzb/QoDKgjN0ldrmwxU4HpwOzt0cnWbrhsJ5X57qUjMtvIe
	pTPXWteFljjeR7rpbnfMI6PmVB1MzxZqInrIosuY2NwvwrXWGJRB5qs5mywqq2rkckIuaN9aMpj
	otIAbKXJ6rQ+KFhAPbeXPm8exrmMiRt4HsRUKpaydRI=
X-Received: by 2002:a2e:a98b:0:b0:3a1:1181:b2e with SMTP id
 38308e7fff4ca-3a1c1ea836amr21648231fa.12.1787474868237; Sun, 23 Aug 2026
 01:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787382800.git.zhilinz@nebusec.ai> <ba3cd75e76ef82b0ff5b393ff9e54056c00e90eb.1787382800.git.zhilinz@nebusec.ai>
In-Reply-To: <ba3cd75e76ef82b0ff5b393ff9e54056c00e90eb.1787382800.git.zhilinz@nebusec.ai>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Sun, 23 Aug 2026 16:47:34 +0800
X-Gm-Features: AcwNN1U8nsadkciuy-Bwon1FGXairQ2fdX4-my8yPnUD4UMQ0gDf-gFp_iutqiM
Message-ID: <CANB6i5zHr8nk6GDHWRqpjuUV3cBVO9KHeNMtD+pMfEu+_tD0oA@mail.gmail.com>
Subject: Re: [PATCH net v6 1/1] tcp: bound SYN-ACK timers to reqsk timeout range
To: pabeni@redhat.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, ncardwell@google.com, kuniyu@google.com, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 4:20=E2=80=AFPM Zhiling Zou <zhilinz@nebusec.ai> wr=
ote:
>
> From: Zhiling Zou <zhilinz@nebusec.ai>
>
> request_sock::num_timeout is a 7-bit counter. Commit e6c022a4fa2d
> ("tcp: better retrans tracking for defer-accept") split this counter
> out of an 8-bit field, but tcp_synack_retries still accepts an 8-bit
> value and TCP_DEFER_ACCEPT can still derive a retry count up to 255.
>
> If these settings exceed 127, the regular request timer cannot reach
> its expiration threshold and num_timeout wraps to zero. After the wrap,
> the request can keep timing out instead of expiring, and the next
> zero-to-one transition repeats the young-queue accounting decrement.
>
> Both request timer paths can also shift req->timeout by 64 or more while
> calculating the next RTO. UBSAN reports that invalid shift, and systems
> with panic_on_warn=3D1 panic before the later cap can take effect.
>
> Keep the tcp_synack_retries sysctl range unchanged, but cap its effective
> value in both SYN-ACK timer paths. Cap the TCP_DEFER_ACCEPT conversion at
> the same range so its timer and bare-ACK consumers agree. Saturate the RT=
O
> calculation before shifting, and cap the Fast Open extra retry as well.
>
> Snapshot the request timeout and num_timeout once before the bounds check
> and shift. num_timeout is a bitfield, so add a raw view of its existing
> storage byte for a compile-safe READ_ONCE() snapshot. This keeps the chec=
k
> and shift consistent when the timer concurrently increments num_timeout.
>
> Fixes: e6c022a4fa2d ("tcp: better retrans tracking for defer-accept")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v6:
> - Keep the tcp_synack_retries sysctl range unchanged and cap the effectiv=
e
>   retry count only in the regular and Fast Open timer paths.
> - Snapshot num_timeout and timeout once before the bounds check and shift=
.
> - Use a raw view of num_timeout's bitfield storage for the compile-safe
>   READ_ONCE() snapshot.
> - v5 Link: https://lore.kernel.org/all/9ec8921d81d6218946e07e8542b1ac41b6=
e2d205.1786540242.git.zhilinz@nebusec.ai/
>
> changes in v5:
> - Limit tcp_synack_retries and TCP_DEFER_ACCEPT at their configuration
>   paths, so all users of each value see the same 7-bit range.
> - Use 127, matching request_sock::num_timeout, instead of the previous
>   runtime limit of 63, and document the sysctl limit.
> - Spell out the 7-bit range mismatch, the repeated young-queue accounting=
,
>   and the UBSAN panic_on_warn failure mode in the commit message.
> - Keep the timeout calculation saturating before either SYN-ACK timer
>   shifts it.
> - Drop a no-op reqsk_timer_handler() formatting hunk.
> - Correct the Fixes tag and update the reporter and sign-off trailers.
> - v4 Link: https://lore.kernel.org/all/891a220c362e3266efdf6b1aa9dc3e52f6=
825c00.1784735392.git.zhilinz@nebusec.ai/
>
> Changes in v4:
>   - Drop the tcp_synack_retries sysctl maximum to preserve existing
>     user-space behavior, and keep the runtime clamps at the timer usage
>     sites.
>   - v3 Link: https://lore.kernel.org/all/20260702095324.2995243-1-n05ec@l=
zu.edu.cn/
>
> Changes in v3:
>   - Order local variables in tcp_reqsk_timeout_sk() by reverse Christmas
>     tree.
>   - v2 Link: https://lore.kernel.org/all/20260630035009.55201-1-n05ec@lzu=
.edu.cn/
>
> Changes in v2:
>   - Keep the existing max_retries calculation in
>     tcp_fastopen_synack_timer() and only add the clamp, avoiding code
>     churn.
>   - v1 Link: https://lore.kernel.org/all/02e24eb83639e9d7ecc623f000c60254=
bb5c40a5.1782643946.git.roxy520tt@gmail.com/
>
>  Documentation/networking/ip-sysctl.rst |  2 +-
>  include/net/request_sock.h             | 20 ++++++++++++++++++--
>  include/net/tcp.h                      | 21 +++++++++++++++++----
>  net/ipv4/inet_connection_sock.c        |  2 ++
>  net/ipv4/tcp.c                         |  2 +-
>  net/ipv4/tcp_timer.c                   |  6 ++++--
>  6 files changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 208f46967ee59..fd5038b6cab9f 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -954,7 +954,7 @@ tcp_stdurg - BOOLEAN
>

Hi Sashiko,

Thanks for the review.

>  tcp_synack_retries - INTEGER
>         Number of times SYNACKs for a passive TCP connection attempt will
> -       be retransmitted. Should not be higher than 255. Default value
> +       be retransmitted. Should not be higher than 127. Default value

The observation about the sysctl readback is correct. Values above 127
remain accepted and stored intentionally to preserve the existing
user-space behavior, following Paolo's feedback. Adding an .extra2 limit
would make previously accepted writes fail, so I will not add it.

I agree that the current documentation is ambiguous. I will update it to
state explicitly that values above 127 are accepted and reported back,
but are treated as 127 by the SYN-ACK timer paths.

>         is 5, which corresponds to 31seconds till the last retransmission
>         with the current initial RTO of 1second. With this the final time=
out
>         for a passive TCP connection will happen after 63seconds.
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 5a9c826a7092d..a9781fab774aa 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -58,12 +58,17 @@ struct request_sock {
>         struct request_sock             *dl_next;
>         u16                             mss;
>         u8                              num_retrans; /* number of retrans=
mits */
> -       u8                              syncookie:1; /* True if
> +       union {
> +               struct {
> +                       u8              syncookie:1; /* True if
>                                                       * 1) tcpopts needs =
to be encoded in
>                                                       *    TS of SYN+ACK
>                                                       * 2) ACK is validat=
ed by BPF kfunc.
>                                                       */
> -       u8                              num_timeout:7; /* number of timeo=
uts */
> +                       u8              num_timeout:7; /* number of timeo=
uts */
> +               };
> +               u8              num_timeout_syncookie;
> +       };
>         u32                             ts_recent;
>         struct timer_list               rsk_timer;
>         const struct request_sock_ops   *rsk_ops;
> @@ -74,6 +79,17 @@ struct request_sock {
>         u32                             timeout;
>  };
>
> +static inline u8 reqsk_num_timeout(const struct request_sock *req)
> +{
> +       u8 num_timeout =3D READ_ONCE(req->num_timeout_syncookie);
> +
> +#if defined(__LITTLE_ENDIAN_BITFIELD)
> +       return num_timeout >> 1;
> +#else
> +       return num_timeout & 0x7f;
> +#endif
> +}
> +
>  static inline struct request_sock *inet_reqsk(const struct sock *sk)
>  {
>         return (struct request_sock *)sk;
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2c5b889530b55..b4054aa53b7c7 100644
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
> @@ -882,12 +884,23 @@ static inline u32 __tcp_set_rto(const struct tcp_so=
ck *tp)
>         return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
>  }
>
> -static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
> +static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk,
> +                                                struct request_sock *req=
)
>  {
> -       u64 timeout =3D (u64)req->timeout << req->num_timeout;
> +       u64 timeout =3D READ_ONCE(req->timeout);
> +       u32 rto_max =3D tcp_rto_max(sk);
> +       u8 num_timeout =3D reqsk_num_timeout(req);
> +
> +       if (num_timeout >=3D BITS_PER_TYPE(timeout) ||
> +           timeout > U64_MAX >> num_timeout)
> +               return rto_max;
> +
> +       return (unsigned long)min_t(u64, timeout << num_timeout, rto_max)=
;
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
> index 56902bba54838..a5f6ad0f0ea1f 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1085,6 +1085,8 @@ static void reqsk_timer_handler(struct timer_list *=
t)
>                         young <<=3D 1;
>                 }
>         }
> +       max_syn_ack_retries =3D min_t(int, max_syn_ack_retries,
> +                                   MAX_TCP_SYNACK_RETRIES);
>

The finding about the clamp placement is also correct. Applying the clamp
after the queue-pressure reduction can hide that reduction when the
tcp_synack_retries sysctl is above 127. I will move the clamp to
immediately after selecting the per-socket or sysctl value, before the
reduction loop.

TCP_SYNCNT cannot set icsk_syn_retries above 127 because
tcp_sock_set_syncnt() already enforces MAX_TCP_SYNCNT, but the sysctl case
is sufficient to expose the ordering issue.

I will address both points in the next revision.

Thanks,
Zhiling

>         syn_ack_recalc(req, max_syn_ack_retries, READ_ONCE(queue->rskq_de=
fer_accept),
>                        &expire, &resend);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 455441f1b6949..24896fa08a5d8 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -357,7 +357,7 @@ static u8 secs_to_retrans(int seconds, int timeout, i=
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
> index bf171b5e1eb30..daa4eac072dd9 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -462,11 +462,13 @@ static void tcp_fastopen_synack_timer(struct sock *=
sk, struct request_sock *req)
>
>         tcp_syn_ack_timeout(req);
>
> -       /* Add one more retry for fastopen.
> +       /* Add one more retry for fastopen when the timeout counter can
> +        * represent it.
>          * Paired with WRITE_ONCE() in tcp_sock_set_syncnt()
>          */
>         max_retries =3D READ_ONCE(icsk->icsk_syn_retries) ? :
>                 READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) +=
 1;
> +       max_retries =3D min_t(int, max_retries, MAX_TCP_SYNACK_RETRIES);
>
>         if (req->num_timeout >=3D max_retries) {
>                 tcp_write_err(sk);
> @@ -488,7 +490,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk=
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
