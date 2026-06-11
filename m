Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F9A371D14
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206718; cv=pass; b=TuX6EbZZq/viKr5Aj0LWk2rCbFXMfAuOtJKDkHXiMY+WDQYJzwSpQy/Z6b1LVOH0bQb/m7JE6RxoE13XAdEyNLWCm4z9B8f1lfg02yUGOGkyN5UPyM3rPK4bKImAzKvKsw3GujyJoNVJhc+fybOHqO9CTo/TLj76g+oZzGxp3is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206718; c=relaxed/simple;
	bh=TXQ9Q0AXLMcsu6soSrnyJebo3jB+Q8dJl2t6DbRHBEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJlwJP/kczDUccC6Q++2YS0jZi+0X4RmzFWPeFncsqnTcveGsAaU6hTM+Pad5urGl9dJYyMqtFd+S+8rZnUlqLD71YCj1zvuYYJnjwU/Lv2sHJx3DcQzqJOMUqWpNp4UDJ5jsS3voIC2Cm+Ns9FXOvHBjup7WetLCD9RUyj5OqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cqopTY5s; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cqopTY5s"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51761d27612so1632631cf.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781206714; cv=none;
        d=google.com; s=arc-20240605;
        b=au2xqEp/S7xEg8jZ/uzTcLQq8fMpUCL6oYUOzxgGkQ0+GjxgOmHQmkxoJM+Ez6439C
         NAcPxQaAjkyuNFrqIdl0Ku9tpXsnliA2+2wYSMdHE5GTFARUsEQ3m/lQZtaa3ul1zpI8
         elyMnt7s2eOriGYWksgelK4a1nQxGnzzql6hcNoAO8kLEHmWsfO08jHfajxy6T6qbWOK
         9m+/7IkYjI559z4Mackx1fQcdCuHkVKQuVgpAkv3ne6yCW/VMeu7YSxFJobmzD4Z8lIG
         alxgLCzyWa1dxOmJS0rHQs/AIvLEEaDsvjb5MJQVv+yWwH3+FsKUHHd2INeLImbndAiZ
         KOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xCB9Yx4jM3FP2NFVOcL/EBwC0kyy5VsznsqCTvi1d1Q=;
        fh=AfoSANETEXaS0TmeXSQ4d7Hbgxi+pbQCeowU17gAfac=;
        b=b7qow4WmalQduDxhDKVXgP1VkWCOp58fW5ur0/IGTah66dtA23RnEb4AKciRqgp9vF
         iS/V/JUEVJetPohJ3I10xb9sIMUKn2tT5uFWL/lOatd1fW12sQ/DBVRUNaaD5K4OGSVF
         oaXTl5gpuJivf3HYnxvkb5bLODrEIiT8q+nGPdmUwXXFT3E0fKZ0xpENJ2fzwXW03fvM
         O4xQvBgiezKlX5yp8oCjkAxBoolOdjai00XSvYyixfTHMG+5HvZz8bjMuAhKdvuimSvo
         A7OQysM39ckA9g7wxt4cni8PE3KOT8c4CUikp3DVoPgb7PGBSV+wBBvBPOXWZ6NOV8IZ
         WxYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781206714; x=1781811514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCB9Yx4jM3FP2NFVOcL/EBwC0kyy5VsznsqCTvi1d1Q=;
        b=cqopTY5s4/LoZ05b/FMCPc/72A2AL17OqMzbZhp9MR+abJMjqTTdmKMl3YbkFQySeU
         6tVMISJVFRFqR+hH1irpos/8NVaTETC3oFho3KUkUKSsxNR4P5bKdpwWnZbHMR6UB6R0
         Mjk5P6KgfwKhn1riMAgGshH1AVsWCr3TskyAUHoVOzztdBqeFLPfXlQox3dm9WsbABRK
         mrEC/6IMmGA6bOEUeaGLMlFVwu1+LGPstpWxxJXt7w8bIWOmAg8wtE0t9DeyGOrnefzF
         uwYiI4+SmMWFZ55WFDzr/os7k+9yJKot68H0JC3bl1UCKwlsYhRqs169I4G9KmeGgezd
         qZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781206714; x=1781811514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xCB9Yx4jM3FP2NFVOcL/EBwC0kyy5VsznsqCTvi1d1Q=;
        b=Ek62dB3Xu7pcd9SJMRFGWNYoJaEPmPOOviuXCPaJjP7j5tsZtxV1QOHJG2xqGuz28T
         N+vQxITpOF8GR/IlgKGmbhBx1LGqx8H8+6SoiGlUc/jUiu1ClTomQymerOBVO+vnvM44
         cADyj3Y//w6lXuryJpT9XCxqgmNyHq/cXOOnG6g5jWbcwIKxswpaZ7803uINwJ37MWmY
         pyrryS4KdLJc2YUniA8z8vXcJ+dWSRGJKp9fTV8ABapFWrmDoik7z5zIL1zd1nImuhtb
         fWebJ9eBejhR5rxuc/EAEHhAwIMReO7JNlmzMBXjJBMdNhJ7SEaSjLLI7EHYGTWPlxiT
         LZug==
X-Forwarded-Encrypted: i=1; AFNElJ9ZJUquTi8TX1szVKKtotJql3tsSWzEili71vXFD1xY2WzeepvEgZqaWUoQk+vzrgW+IeL4fl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSH9vt4ybTYPit1yVRQAGcLfVmnmoiib3WRXjsIP1Xr3rr6Rz
	UpGjSto/XUs6dG5NvGB9y2Z38ITdKLunZFJi6tqh2QPwCBPGqwyPj6koLNzxNRbYnAB92K8NGwj
	i4H5rn/RSqPg0/BTNoZG2RAfc+wKCrnlCep7Yf1Rg
X-Gm-Gg: Acq92OHtTyCr3b7Qyz8kH/jpAmpl38JFoyodi5pzTG8GEey4YhRItMJXzNy/UN9ypw3
	uW4HmqFuqe6lVPZk1ZEIVy4d6jHf/opPefyYO7cK1L08soKcZay0boBmHxnFfBvYqpu354DxSag
	eTTfWWCfSTcqEAvQXGArNMF7S4v56gdsSGhR9ir2gH3FHuW8gGDQv3K03EZbSo8Jqe2HDmUe7TD
	GdeRw9OpTU4S7c9dGd+GjLBS+UIcmNUfMnRDK/kJMBTfol19sqM/g9V7Yr9ELDxyEtbobz0wmSP
	yNE7sIKqBraOPLdEp3HUkn8Dvs4UumTzGovoVTY316ugBCfuU5jywJWepUk7v6Rm7ckSMWmg9iR
	tHY5J1iLLT0mgR9mqMbc=
X-Received: by 2002:a05:622a:1ba9:b0:517:96f0:5663 with SMTP id
 d75a77b69052e-517ee1c3dfamr60249151cf.36.1781206713473; Thu, 11 Jun 2026
 12:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
 <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
 <CADVnQyk+sOAKU_WtPja7_hgiXw8he9U1g6AY7iEm5q3F3R-Hag@mail.gmail.com> <PAXPR07MB7984D14DA66C0E4B89BA1D4BA31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984D14DA66C0E4B89BA1D4BA31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 12:38:21 -0700
X-Gm-Features: AVVi8CdU_EG-yCXFA-WFp-6T8-9IGsEt-wVTqw-kDS_eUrm1C9Lm6n8n5lfLMZY
Message-ID: <CANn89i+dS_h8_FH9KdO4NPu46VSi3uFZ3yGnA6AKD1UzMzySKg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback for TCP Prague
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Neal Cardwell <ncardwell@google.com>, "horms@kernel.org" <horms@kernel.org>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
	"kuniyu@google.com" <kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 12:33=E2=80=AFPM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
> > -----Original Message-----
> > From: Neal Cardwell <ncardwell@google.com>
> > Sent: Thursday, June 11, 2026 9:27 PM
> > To: Eric Dumazet <edumazet@google.com>
> > Cc: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; horms@ke=
rnel.org; dsahern@kernel.org; bpf@vger.kernel.org; netdev@vger.kernel.org; =
pabeni@redhat.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumbe=
r.org; davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com;=
 kuniyu@google.com; ij@kernel.org; Koen De Schepper (Nokia) <koen.de_schepp=
er@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsso=
n.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; J=
ason_Livingood@comcast.com; vidhi_goel@apple.com
> > Subject: Re: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback fo=
r TCP Prague
> >
> >
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >
> >
> >
> > On Thu, Jun 11, 2026 at 1:01=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Jun 11, 2026 at 9:15=E2=80=AFAM <chia-yu.chang@nokia-bell-lab=
s.com> wrote:
> > > >
> > > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > >
> > > > This patch adds tso_segs() CC callbak for CC algorithm to provides
> > > > explicit tso segment number of each data burst and overrides
> > > > tcp_tso_autosize().
> > > >
> > > > No functional change.
> > > >
> > > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > > ---
> > > >  include/net/tcp.h     | 3 +++
> > > >  net/ipv4/tcp_output.c | 4 +++-
> > > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/net/tcp.h b/include/net/tcp.h index
> > > > e8090f542f7c..3b415c9dcc54 100644
> > > > --- a/include/net/tcp.h
> > > > +++ b/include/net/tcp.h
> > > > @@ -1366,6 +1366,9 @@ struct tcp_congestion_ops {
> > > >         /* override sysctl_tcp_min_tso_segs (optional) */
> > > >         u32 (*min_tso_segs)(struct sock *sk);
> > > >
> > > > +       /* override tcp_tso_autosize */
> > > > +       u32 (*tso_segs)(struct sock *sk, u32 mss_now);
> > > > +
> > > >         /* new value of cwnd after loss (required) */
> > > >         u32  (*undo_cwnd)(struct sock *sk);
> > > >         /* returns the multiplier used in tcp_sndbuf_expand
> > > > (optional) */ diff --git a/net/ipv4/tcp_output.c
> > > > b/net/ipv4/tcp_output.c index fe725d94a225..a7206fa61957 100644
> > > > --- a/net/ipv4/tcp_output.c
> > > > +++ b/net/ipv4/tcp_output.c
> > > > @@ -2274,7 +2274,9 @@ static u32 tcp_tso_segs(struct sock *sk, unsi=
gned int mss_now)
> > > >                         ca_ops->min_tso_segs(sk) :
> > > >
> > > > READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
> > > >
> > > > -       tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> > > > +       tso_segs =3D ca_ops->tso_segs ?
> > > > +                       ca_ops->tso_segs(sk, mss_now) :
> > > > +                       tcp_tso_autosize(sk, mss_now, min_tso);
> > > >         return min_t(u32, tso_segs, sk->sk_gso_max_segs);  }
> > >
> > > Can you explain why min_tso_segs() is not enough?
> > >
> > > We do not need two different mechanisms.
> >
> > I'm pretty sure this was proposed to meet Prague's goal of having TSO b=
ursts be sized to be at most 250 usec worth packets, rather than the defaul=
t Linux TCP TSO autosizing approach of 1ms worth of packets:
> >
> > https://datatracker.ietf.org/doc/html/draft-briscoe-iccrg-prague-conges=
tion-control-04#name-segmentation-offload
> >
> > Where "MAX_BURST_DELAY" is defined as "Maximum allowed bottleneck queui=
ng delay due to segmentation offload bursts [s] (default 0.25 ms for the pu=
blic Internet)".
> >
> > AFAICT this proposed patch is no longer needed now that
> > tcp_tso_autosize() uses a parameterized approach for :
> >
> >    bytes =3D READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_s=
hift);
> >
> > AFAICT tcp_prague can simply set sk->sk_pacing_shift to be 12 for its p=
urposes, looking at:
> >
> >    https://github.com/L4STeam/linux/blob/8ac01b97ffd993b1fed93a015ec30d=
d085857e8b/net/ipv4/tcp_prague.c#L144
> >
> >    static u32 prague_burst_shift __read_mostly =3D 12; /* 1/2^12 sec ~=
=3D.25ms */
> >
> > Then probably this patch is not needed.
> >
> > neal
>
> Hi Neal and Eric,
>
> IMO, we still need Prague to maintain its pacing rate, because AFAIK tcp_=
tso_autosize also based on min_rtt to decide the bytes to fill in.
> And it tends to create large packets when min_RTT is very small via `byte=
s +=3D sk->sk_gso_max_size >> min_rtt;`
>
> While, in TCP Prague, we do not bsaed on min_rtt to further enlarge TSO s=
ize.

You will have to remove min_tso_segs() and replace it with tso_segs()
which seems enough (stronger)
