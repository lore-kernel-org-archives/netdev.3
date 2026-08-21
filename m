Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ED0490BF2
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317757; cv=pass; b=biuIIAsj/KQ7fwWGo9WhDD42Q96gh+qn9IPH0gCgxoLCT9XOx38CnRRW28UTo/MBVg6Y/Io5jqzy0/qL1tqtcKPI37cfbiRRgcNhEmC5kYwvW48sGwlvFNxATNFopGdi2vh4JTWgZ0BAlafGf0CLo8gWIbPMZPK2ur0P6FB4lUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317757; c=relaxed/simple;
	bh=+0F6PcToW+m2E+AaF8BNx864QnUp7MiVAjmxOVsJ7UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpFvQqZ7U0ZifI9ANvTLHDrkOJRKLrQ3fjVzTG1tXUdzNggNtZZ2hca+GVhI7H7r6j6vtk0j5znBfOLscrZYEAwMqmHEhtPoICRZE8YihCcp8Y9xwJSGhYo7K/hfsUkS8gREIjjoibb8jU7hxCvdgNC31ycCechH9b44LKd66JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=bBSstUyA; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="bBSstUyA"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c8dbf4f38so9885981fa.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 06:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787317734; cv=none;
        d=google.com; s=arc-20260327;
        b=clsifjJJxJbky5vd8ke+RTcqvVDRQdEifkLogF27C42Z+gEEIS3newGn+vI+zERcgS
         MpTwMhJtEvhdYPLdbBDnmzIBGYdyPs73/gO+8DJaENW+brtHtLk5G8RKeDYH+PeHDpGo
         vJQrBmEt/EblUNiRdb5CsuTiakbdtlYlIEVbyH75jgsQPH6KoPvH2DegpMKnq5DzmKom
         z/S7cH+wnLyvWaT82QZJRQ4XK3VEdQYGiNVSIAdCh32FvKRXozRMaedhvw7e/WxD+BE5
         8cNIB+QDinfxrbTd4oPyvdQPzK3+uqXBLU1F1uHoTYDQgZrdb1Q1GBZS87wujcJL5jA6
         6Wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6WDYpc/SUiaxFp6adq0YxxeUgPMzlxAaQA3nJ2sZyP0=;
        fh=qZ678ogIEKTHtEIacE6eR917gu0pRie1TFFX55/PZ3Y=;
        b=EqM2Ad7YniUsW519Cc6NUTIM196VNkVda2Hg19TqNpbmNoRYOfR9BEh7Wjv9h7bMyA
         yvG1v2RLdSBp2VuJxRuBaIWcFFXYaHhiT2zagwLzKokT5vtAsIoPInDn8sCmdOeZuz41
         O0PkOEQPlWY2T/UXxJBKHPxk6e5UXHk/w4rkw7rOovd2YGIg4pXkfwq7rLOc6Siq9EkG
         0FUXw4SoGL/i9pwVGunYrstT9AhrAEHZlq0NC13DWEXz+29P4SFwX+qSaf1ln9y0EjmH
         F9wxSo4PA32ydAPAgQIKI8ywwz35q2UF7FY+DtTdokDb+ece/3wmpY9LahhkDT76xtMA
         1TuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787317734; x=1787922534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6WDYpc/SUiaxFp6adq0YxxeUgPMzlxAaQA3nJ2sZyP0=;
        b=bBSstUyAzyU8eY//I9X+Cqr7BJqT3AlN0sBjDvtnHQyBThaJB7cJXqxwBB5r2uaW8M
         ALxwD3R9jJBbC7+wNlNevEjCZKtZfCpf4Andb0BFxkCRNppG9rJpYcdTyMM/ZGiF3syr
         Ulfjx2B681c+z0b2LW+qg6G/uNNO+VDPkIu+zer4mcx+HBgzLhJk3EC3pZrRcMThmz/V
         vI2KpJcES2I8dL9ftdTbs8pp88iRJ3h+xHVBS38OglyG0k/KKira02rMg4mDygB4eI94
         hDNX1n/M3hH6rOondkNb6p6LD8l7LchHC4bt0xDd1BtV+aBItWjZUDPL7juDLF9gjAG9
         A23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787317734; x=1787922534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6WDYpc/SUiaxFp6adq0YxxeUgPMzlxAaQA3nJ2sZyP0=;
        b=buI3VNYCtZSgrKFuiebaQFBb9rgPMMgt5/7+so02IPVlcb489xEyO5bZrjBmrsYSoB
         tWbHGtzXSwCwR6bOiSIC3BdY8ZV4zoDnFtCBhH7IEPvogzNDDLnhThtT7WZ9Vub5BoNN
         BygmmiQEhU224I6X5umIrjD4lic/UrKa40AP8Lx/nNlpx3qU04fE+/eYwKpjTuGEVoMU
         piuIuUZhD0HqZ0wolnSo2PDlZobryCXbf+Jtv2K7DUTcL2pfMZ6KBJn7+WIF+AQroner
         b4fprtDCw2OibHQq+On1HdSnXxwnApT2FnUH3gt5bPXWBgci67Sfi3TckiE1RL/6/A3S
         /F3Q==
X-Gm-Message-State: AFuF++mwmN33fhDCXiKpIIu7SIyrUuolmaSmqMWnITS+9/iH9tm3Ck/Z
	gkStqv9rAtle0AQeHlO9BUL87bv8vay954sJjsN3jM4+FPSi7ACNOWFRYDbqa5w0HkjpNajKvS2
	cD/MAo6CxkEMnXVDRajKRW4HDPEoHi0JNNkMzvmtfdcw=
X-Gm-Gg: AR+sD11cKyv6XeFuL/YBlo6gNqcB32xmDHiuUEJ2KONm5mIP3taPiXmRKb9cYTLe/Xo
	xj1+4GerR0uBNIgab6Bo7P67BHgUWuStBPyfNrk8mvGXDe5cMDMHxdX263nejQoM6R2nhV11l9n
	ZHwVni9vHdEuFj0lmNOM/Pd2LyNgkJrdVLmuYzM7UXKhjU4wr9neBxAGBwd6S3l0UlTD0VpRjYB
	m6zB/Z2n/yNywuMhaV+f4T/gFxMMoKtDV0DWsVPCReKUVoXE9v13SxGQQFqJ/OF9wIRZr1CzplG
	TI1rF7lBn3XxUHEplXZkRyihD9lj9tozx0UBG2caqBh53D71IkDa7GfB7Q==
X-Received: by 2002:a05:651c:556:b0:399:9436:15c8 with SMTP id
 38308e7fff4ca-3a1aeb79b97mr13416671fa.2.1787317733747; Fri, 21 Aug 2026
 06:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786540242.git.zhilinz@nebusec.ai> <9ec8921d81d6218946e07e8542b1ac41b6e2d205.1786540242.git.zhilinz@nebusec.ai>
 <9ab7df63-dcbd-496c-a997-4218e2ab272b@redhat.com>
In-Reply-To: <9ab7df63-dcbd-496c-a997-4218e2ab272b@redhat.com>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Fri, 21 Aug 2026 21:08:39 +0800
X-Gm-Features: AcwNN1XZm-E_jW0MDxFtqQnE6hWPtXlUcnb0_nhE79y2ObVKSDXNqW6OafLIJmc
Message-ID: <CANB6i5xLD1HRGkUmoXuSmf9CGrnPwhbWv5w76Uw1_5jhFv05AA@mail.gmail.com>
Subject: Re: [PATCH net v5 1/1] tcp: bound SYN-ACK timers to reqsk timeout range
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, ncardwell@google.com, kuniyu@google.com, 
	chia-yu.chang@nokia-bell-labs.com, ij@kernel.org, fmancera@suse.de, 
	bronzed_45_vested@icloud.com, idosch@nvidia.com, yuuchihsu@gmail.com, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 6:21=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/12/26 3:38 PM, Zhiling Zou wrote:
> > request_sock::num_timeout is a 7-bit counter. Commit e6c022a4fa2d
> > ("tcp: better retrans tracking for defer-accept") split this counter
> > out of an 8-bit field, but tcp_synack_retries still accepts an 8-bit
> > value and TCP_DEFER_ACCEPT can still derive a retry count up to 255.
> >
> > If these settings exceed 127, the regular request timer cannot reach
> > its expiration threshold and num_timeout wraps to zero. After the wrap,
> > the request can keep timing out instead of expiring, and the next
> > zero-to-one transition repeats the young-queue accounting decrement.
> >
> > Both request timer paths can also shift req->timeout by 64 or more whil=
e
> > calculating the next RTO. UBSAN reports that invalid shift, and systems
> > with panic_on_warn=3D1 panic before the later cap can take effect.
> >
> > Limit tcp_synack_retries and the TCP_DEFER_ACCEPT conversion to the
> > range represented by num_timeout, preserving the same defer-accept valu=
e
> > for its timer and bare-ACK consumers. Saturate RTO calculation before
> > the shift, and cap the Fast Open extra retry to the same range.
> >
> > Fixes: e6c022a4fa2d ("tcp: better retrans tracking for defer-accept")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> > ---
> > changes in v5:
> > - Limit tcp_synack_retries and TCP_DEFER_ACCEPT at their configuration
> >   paths, so all users of each value see the same 7-bit range.
> > - Use 127, matching request_sock::num_timeout, instead of the previous
> >   runtime limit of 63, and document the sysctl limit.
> > - Spell out the 7-bit range mismatch, the repeated young-queue accounti=
ng,
> >   and the UBSAN panic_on_warn failure mode in the commit message.
> > - Keep the timeout calculation saturating before either SYN-ACK timer
> >   shifts it.
> > - Drop a no-op reqsk_timer_handler() formatting hunk.
> > - Correct the Fixes tag and update the reporter and sign-off trailers.
> > - v4 Link: https://lore.kernel.org/all/891a220c362e3266efdf6b1aa9dc3e52=
f6825c00.1784735392.git.zhilinz@nebusec.ai/
> >
> > Changes in v4:
> >   - Drop the tcp_synack_retries sysctl maximum to preserve existing
> >     user-space behavior, and keep the runtime clamps at the timer usage
> >     sites.
> >   - v3 Link: https://lore.kernel.org/all/20260702095324.2995243-1-n05ec=
@lzu.edu.cn/
> >
> > Changes in v3:
> >   - Order local variables in tcp_reqsk_timeout_sk() by reverse Christma=
s
> >     tree.
> >   - v2 Link: https://lore.kernel.org/all/20260630035009.55201-1-n05ec@l=
zu.edu.cn/
> >
> > Changes in v2:
> >   - Keep the existing max_retries calculation in
> >     tcp_fastopen_synack_timer() and only add the clamp, avoiding code
> >     churn.
> >   - v1 Link: https://lore.kernel.org/all/02e24eb83639e9d7ecc623f000c602=
54bb5c40a5.1782643946.git.roxy520tt@gmail.com/
> >
> >  Documentation/networking/ip-sysctl.rst |  2 +-
> >  include/net/tcp.h                      | 20 ++++++++++++++++----
> >  net/ipv4/sysctl_net_ipv4.c             |  2 ++
> >  net/ipv4/tcp.c                         |  2 +-
> >  net/ipv4/tcp_timer.c                   |  6 ++++--
> >  5 files changed, 24 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/net=
working/ip-sysctl.rst
> > index 208f46967ee59..fd5038b6cab9f 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -954,7 +954,7 @@ tcp_stdurg - BOOLEAN
> >
> >  tcp_synack_retries - INTEGER
> >       Number of times SYNACKs for a passive TCP connection attempt will
> > -     be retransmitted. Should not be higher than 255. Default value
> > +     be retransmitted. Should not be higher than 127. Default value
> >       is 5, which corresponds to 31seconds till the last retransmission
> >       with the current initial RTO of 1second. With this the final time=
out
> >       for a passive TCP connection will happen after 63seconds.
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 2c5b889530b55..8ab2fd368ed3b 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -183,6 +183,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
> >  #define MAX_TCP_KEEPINTVL    32767
> >  #define MAX_TCP_KEEPCNT              127
> >  #define MAX_TCP_SYNCNT               127
> > +/* request_sock::num_timeout is a 7-bit field. */
> > +#define MAX_TCP_SYNACK_RETRIES       127
> >
> >  /* Ensure that TCP PAWS checks are relaxed after ~2147 seconds
> >   * to avoid overflows. This assumes a clock smaller than 1 Mhz.
> > @@ -882,12 +884,22 @@ static inline u32 __tcp_set_rto(const struct tcp_=
sock *tp)
> >       return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
> >  }
> >
> > -static inline unsigned long tcp_reqsk_timeout(struct request_sock *req=
)
> > +static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk=
,
> > +                                              struct request_sock *req=
)
> >  {
> > -     u64 timeout =3D (u64)req->timeout << req->num_timeout;
> > +     u32 rto_max =3D tcp_rto_max(sk);
> > +     u64 timeout =3D req->timeout;
> > +
> > +     if (req->num_timeout >=3D BITS_PER_TYPE(timeout) ||
> > +         timeout > U64_MAX >> req->num_timeout)
> > +             return rto_max;
>
> Sashiko notes the above is racy, and basically makes this patch not
> effective:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/9ec8921d81d6218946e07=
e8542b1ac41b6e2d205.1786540242.git.zhilinz%40nebusec.ai
>
> note that the solution provided there does not even compile, you
> will need something slightly different.
>
> > @@ -1034,6 +1035,7 @@ static struct ctl_table ipv4_net_table[] =3D {
> >               .maxlen         =3D sizeof(u8),
> >               .mode           =3D 0644,
> >               .proc_handler   =3D proc_dou8vec_minmax,
> > +             .extra2         =3D &tcp_synack_retries_max,
>
> I explicitly asked to avoid this in v3. Sashiko suggested updating the
> doc. Why do you add this back?
>

Hi Paolo,

Thanks for the review and for pointing me to the Sashiko report.

I agree that the check/use race in tcp_reqsk_timeout_sk() is valid.
req->num_timeout is a 7-bit bitfield and may be updated by
reqsk_timer_handler() while the receive path is reading it. I will
take a single snapshot of the field and use that value for both the
bounds check and the shift. I will not use READ_ONCE() directly on the
bitfield, since that does not compile; I will use a compile-safe
equivalent and verify it with a build.

I also agree that adding .extra2 changes the accepted sysctl range and
goes against your earlier v3 feedback. I will remove
tcp_synack_retries_max and the .extra2 assignment. The 127 limit will
instead be enforced at the regular and Fast Open SYN-ACK timer use
sites, preserving the existing sysctl behavior.

I will keep the TCP_DEFER_ACCEPT conversion capped at 127, since
rskq_defer_accept is consumed by both the timer and bare-ACK paths and
must have the same representable range.

I will send a v6 with these changes and update the commit message according=
ly.

Thanks,
Zhiling

> /P
>
