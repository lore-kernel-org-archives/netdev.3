Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792604520;
	b=aS5Po9CHuXdn1IaAAhGyGDEYSIoTWTv6CHg7N6BjQ8Pp+8rhEKiy4haRD6HtZ8leUQXG
	 zAG/SW32CPXszdWtnUBBrnGcs7j2/YgR5iJCh+Rh4bwUbTkzrL0EIILB8YNjB4xOofU4e
	 /WBIq5G3hKsgUpRJDigUSRa5pPChvjxskniWl53jdmICKNBSbsPMyKJCzNeAN3zIg2JrV
	 jo0MZojzvx0WPr0+NA+0whBKC65oKzon8QfhS7iyXAS2YczdXJI5D+Lsvo5Mf7sV8HOMP
	 cI1kZMXSM3jlerVeFz5vuliosKgRWTvlj3YHr2KOtWHnWkO0KNmYqyLzgUtJW/iQB1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
	b=OFko8P+ERLyJMrcn7U6cF4pI05x886vL02SiVJy+H6nSWkbT2ujpmYnttASDs4agJvPX
	 iO4KQrdeqMLnrG0/u9ZummS/HBZpX3gYn6PENCaa3PoZ+F7VcxmVMwt21GGykiroQgTaj
	 ASpPHqF6L4PsQYOX6x3O6+DIRnbOTIO6OhYBbVFaZdMum29MkXw++rDOEuwjPg+J4xnzt
	 1wMTuuQWm+gzOq2CDLKfr+BvOmL6KmJDnHAXNstD/N+4WYcQFn10vmxYTO2TLd+Gk5TNE
	 tI/NNQoD9M+BCdUWynTye9F0fL8pxSp5VA+RZ/tQL0x9B4N13i2k+Vdrm+p4wdXwX6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GvAbxW8U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05A606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D05A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GvAbxW8U
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so395920a12.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792604520; cv=none;
        d=google.com; s=arc-20260327;
        b=Ql3zaJNnqBzNwM1LmZLXTEgYibTMxnkAE/zJF+IKQpn0QOpYdi1Nv2h8JcJUzb31Hv
         yytpMseNO7wUzjMWtu1empV56iHa3ukqrG+B2xLP7LCjRtIDEMaZDsANAN4COp+zY+HP
         XD5yo3JPGuLagOOqsKVE/r8p6K0C+m7PgnSUi5/GwCvvagccxZ2dT1thSoyisSa6EF/+
         vKfuLkpXHY258i4rG+q+JtdrdJ2j+8xTHN392vbyd1l7QsPP3AWTb1bPageMxow0G+C9
         WG3sYErojbBFCPlti7AxR01B3kYGmAIFDK9FsKh4S3Y1qei6FKYrNWGYs/vWy9aAqFWG
         1Ufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
        fh=X6bWAECIvQm3nMd6kEDShT4nHfEC3sJAF3U4QFkDcP0=;
        b=U6Gb0itlWw8kTOKSka0UnpgfENLiBvmGptme9uFD2QQ8MxSGT0LflaZa4Fp5/Jkp6J
         qfH4qcH4/u9nPOMUx/GZJhPw0pP1P/OtDyTXoo3UfnlojhRwep6RxKDoWr+sE2hhu/h0
         Gz2487oazZX0O/iIzMh5QRGg0Q2xUHagQjH/FWT/1J9cZUrlffd94o7eTEpIAmnK/hjN
         QV6+h4qYth0fFL+z+N3QXJgqmY7JE49PTN2zkaIUppjgjZJKrPWo915+vhOZkNMWvfV9
         rEpSjRdq9uzxffZpv7VsXp8Mu3QfdghmVhTpHtVA0mnmEwtaIXDbluRrVvaGP0rZziOT
         bwWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792604520; x=1793209320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
        b=GvAbxW8UXtF+sRo9OMu4rbiOvh/ZUVz/YIvz0PscUkArcnkkSoHXjx90jpuxuMfVj+
         gvaXcIpvK/50UG3alQJ1Dp+2g0gdqjTAy5dm37l86wOcXJrukh709bQOUA+kBnTyfJi8
         qZtNnpMZsfDYyI6WIxZvhBlQZbClbbWY0qrp2jd4DE/n1oA/K0IeB0+YkDIMXH+Xuj5T
         HPw+nY/bs4Z0G4Xi/rxh0plLMUug5NI98mr/u7qmV3y0SN6sva4+Duq9Bz9yHmm7Kk1d
         jtodxu+rnwuW5xb6SJB7Sri91KGj7ab04wNmbK0F7wLB2SDE9nwKdnQabNsQv+yJvzy9
         J5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604520; x=1793209320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
        b=uoLII+btO9OpnyMNKhRaUNbUdin90RHhhsVxCJNrTdOLoaWv+EcWs6ElueaNXMZ6p+
         7SlClm6T+OReDGYbCLD7D7wxC1Tc7k5MxWpNgO70wSGG+2kLLVg3v1cSjo3VGF3fWWez
         czSl3NOje+TLMG3aJkIN+kp7exZFmC10GiuTMInaaZa/sHH+rFybagCspO69njEVZqop
         esF8uq2/GsdYcks/lhW2vlo/qX/5Pwx6caTH9FzQTmClVyDpakJIrknZgjGwBANGM6db
         rhQEGnC2k2xREYyCWODPGtiwdtDH7fjk5NAwHeZORFeKcJg+Yd/gFew37OXZFfmNzwGZ
         8a8g==
X-Forwarded-Encrypted: i=1; AKwUvBwiAnxaw87sfdSU2xr6SQ6xuwkEjNgjGY47V6LvvychzQmh3eiPAXhZ6mnzdjrewY0Xw0bGNs8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0Y12UX+S2fFZCsRd4GdT2o8F6ROGy3KAhN8rkL/gbTEvy/qoQ
	W7tY+xGDyFIVsx6hJbKt6NlCm2dxrat78ugTxxfi0o2N7zcIBgmhxQigEWkE7jfIKFpQY1S5lsW
	b3Q/td66JXy1gs+nCtVwI3VsVHNjPqHY=
X-Gm-Gg: AYBFou35hviwn9n6f4DIrSpn1YAra0oWsGs7o/M4b454dKzdtMGuc8MmB4StgkqJBsP
	8gqLB1HMiCdrxC6MraFbU69SP9/coxZxS8upTRNgkSCyd9Aw2YAdYml8Jx81MgkLC6669pj3Oqo
	W1MmRrZGxpHm87VXh05ovHOebfPkXKIyxxTTat9pDnhXFKGfgSp316sqxmlbl1X/k8v533Ts/33
	5imOY1MFLrEKHm3dqBqAll3zwdtzC1YjjqUV0OeuTkdPO6HNxRT+za8lYXYBuYARzwhY1a3ks9B
	DFTIKMGGzlQnM9562SvUMRzA3QsPaKoLgxTX+2+tQ+S5yabxh8DPKwMpFgMK9/9Ak78ojc7EogS
	mQlC2PHu+MFC0XqswlHR2h40A7JG5VbCORmZdBIWRO0HbN8OZBAjx5nFqYMKkZDmRRwhiiS2wXS
	L6txJoSaaZMuE3RweIag==
X-Received: by 2002:a17:90b:258c:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3ad86ca45acmr2134722a91.0.1792604519654; Wed, 21 Oct 2026
 10:41:59 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019153628.15912-1-leon.hwang@linux.dev> <20261019153628.15912-6-leon.hwang@linux.dev>
 <CAEf4Bzbr46UkiE1sbb+Zwcs0S1ejpKmtTGjNCAkWD-J6FRcPGQ@mail.gmail.com> <d4fc4fcd-3691-4122-8b3e-a75447956255@linux.dev>
In-Reply-To: <d4fc4fcd-3691-4122-8b3e-a75447956255@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Oct 2026 10:41:43 -0700
X-Gm-Features: AclHuK8euPDDrPLcZ78w73yg4ZplR7FA7dJCpvboj2MZKSFYtjKIdYl4Mw0-_4w
Message-ID: <CAEf4BzY13x1skc6XSnXGyoLwaFoOtENGokUX7XHiakEyw+eQEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] libbpf: Add bpf_link_create_log API
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Masashi Honma <masashi.honma@gmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 8:27=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 2026/10/21 07:25, Andrii Nakryiko wrote:
> > On Mon, Oct 19, 2026 at 8:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
>
> [...]
>
> >> --- a/tools/lib/bpf/bpf.h
> >> +++ b/tools/lib/bpf/bpf.h
> >> @@ -484,6 +484,11 @@ LIBBPF_API int bpf_link_create(int prog_fd, int t=
arget_fd,
> >>                                enum bpf_attach_type attach_type,
> >>                                const struct bpf_link_create_opts *opts=
);
> >>
> >> +LIBBPF_API int bpf_link_create_log(int prog_fd, int target_fd,
> >> +                                  enum bpf_attach_type attach_type,
> >> +                                  const struct bpf_link_create_opts *=
opts,
> >> +                                  struct bpf_log_opts *log_opts);
> >
> > Leon,
> >
> > how about instead of adding this new API, we try to repurpose
> > bpf_link_create_opts' iter_info to be used as log opts? we have this
> > right now:
> >
> > union bpf_iter_link_info; /* defined in up-to-date linux/bpf.h */
> > struct bpf_link_create_opts {
> >         size_t sz; /* size of this struct for forward/backward compatib=
ility */
> >         __u32 flags;
> >         union bpf_iter_link_info *iter_info;
> >         __u32 iter_info_len;
> >         __u32 target_btf_id;
> >         union {
> >
> >
> > that iter_info/iter_info_len is a bit of a legacy before we had
> > per-attach type union, what if we add iter section into the union,
> > wrap iter_info with union and put log_opts there, mark iter_info
> > deprecated or something.
> >
> > I'm not sure anyone is actually using iter_info (I didn't find any
> > uses in Meta code base, for instance), but we can detect its use by
> > checking iter_info_len: if it's non-zero, then iter_info must be a
> > real bpf_iter_link_info. so we should be able to detect this just
> > fine, the only downside is that you can't use log_opts and iter_info
> > simultaneously, but I think that's fine: you can update your code to
> > use new iter.info fields instead, if you need log_opts + iter_info.
> >
> > WDYT?
> >
>
> IIUC, the struct bpf_link_create_opts will be changed to
>
> struct bpf_link_create_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>         __u32 flags;
>         union {
>                 union bpf_iter_link_info *iter_info;
>                 struct bpf_log_opts *log_opts;
>         };
>         __u32 iter_info_len;
>         __u32 target_btf_id;
>         union {
>                 /* ... */
>                 struct {
>                         union bpf_iter_link_info *info;
>                         __u32 len;
>                 } iter;
>         };
> };
>
> Thereafter, iter.info is preferred against iter_info. And to keep
> backward compatibility, iter_info is used only when iter_info_len is
> set. But iter_info_len and iter.len are not allowed to be set at the
> same time.
>
> With this change, the bpf_link_create_log API can be dropped.
>
> I'd like to drop the bpf_link_create_log API first, then add iter.info
> in the series of log support for iter link_create in the future.

up to you, but I don't see the problem of dropping bpf_link_create_log
API and moving iter.info in the same series

>
> Thanks,
> Leon
>
