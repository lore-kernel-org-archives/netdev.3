Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793E390608
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023937; cv=pass; b=m9K2ir1ystVxZ3fnKFgB9UG0FgKviEOA+2xvYXPzbYbqv4YyxxWrlvjie2tVctegoOU1vWrwB5/A1JM9vPQ6vx13YLFgv1QYc/h+2QrhyctXjrKZ7J2HZDxRCegi1Yg6XpUHVDGR5K5Mn/XBNwarYifn+v1u6AAUH9LYhMnp5aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023937; c=relaxed/simple;
	bh=BKWJTReTdw+LMAVvVwFW5qLVtx7m6cVom+p9AYVg2D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBdkDDnuI9A8lGCse0P/crCkQLt7dcIodjoTc28yAFrYWTnNkImH1rmgc5GjG+xsZ+vCa4BiTGoZN0tZJ3qN7wcudH/XsbUG/o3j+lpBqikLrK9zZQDmdeOa7hfNHVq7J0srTB/eFulYRaGNTCs7Fioa85+zyCQ8hdeA8ls4WLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DRpjGRsK; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRpjGRsK"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92ea24a2dbfso173036785a.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 06:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786023934; cv=none;
        d=google.com; s=arc-20260327;
        b=m0YhO3yHdwGrkHg3u0J5SS87qwpk10ONRMiBJf/ekkhKP4UGoxDLw0LagijH9prUEi
         N9OjcVFYQaUgO+QnlvkkQwRExB/aS4iWRtzV6hyJMgee3hQqhJbIcIxr5gU/+WdgRsqV
         fijmRT12QD+K8CGyjAwcAsmR6JZjMOmgyYgaPg5ovyvJgT6xQHznZgIyrIah4m8Zc9rt
         sL6qtNbhv/5DHMjg217va49aFndkNo1hmzaW3a9BsH1f3wC83AjZzV1Wm2wsp7SxNqPe
         AINo5eftG0IYQaaQlrRiLltGlxqhRbJX6AnIgOR4GAXleoF/+GQZ9POptI0EOz+k4+FG
         3ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BSeHeIOsrbYVt/cFGZ3Mudq1FYtZux95e0DZcHfkyoA=;
        fh=1KLD+Hi9wxbkDb7L2kYioj/K7qshoNqjlOdF6txTMPw=;
        b=kvSN+m1/SVUgfn/Th1hlhzjQh3jG3t6yMUPD/ybU5FTGiVhb3fyTaG3nU0hn24WNBM
         6kpY4TlvnzXFYFgRWA3l6clzia+ksug8wWcnfYngC+rovv7X+39egK62/ruRGT/ajZqs
         nv+4y0rWV2ZiK+dlFBrnNSfqe1evNqiisa1LajeuEbd3ALNDhp4wjzhOtYrQ3rmLtQCs
         T90K4r4YqJ4MVRkTqJyadUEkRSwGa6k6+SvopJNSF9orbJj6r4eJyCo79y7wMm/InSic
         0Jz7K6sSYroKuSa3byNsnPI1JvWpUbvhzFwIfrn5Kzaf0xXj4te00puU78ecexl1NHq2
         KbBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786023934; x=1786628734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BSeHeIOsrbYVt/cFGZ3Mudq1FYtZux95e0DZcHfkyoA=;
        b=DRpjGRsKij1Zv2TOXICX2Y+jS+L5ix3n4dYYEsYImr1ukZxDBFbEmbKNPXE2ZI3CGN
         dkjK0bTdyF4OUOoE8FIeaYMdqEJs0lDCpajZ3WgfdtZOlazw24lDQHa4CRkOVKWkKCjX
         FFZSXYx+Z1Zd9s1ZFBgcH7u69rgLj7xpjwGsEnGNNWOVCsUWo4RbMU89N7jcx8nbl8Aq
         pWcLSzV+hpVBahbHr7H2+fb4BphXtGvuBStbNBZbUHcO1+/eIkSKmY6IZsNaaHdCLjWg
         VmomLM99AexCJWdTA5jLpjamiL3xxbwI1V1cIQ4AVI4VoWZZa0+oSA/rCh+JFwd8Bd3D
         Ccew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023934; x=1786628734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSeHeIOsrbYVt/cFGZ3Mudq1FYtZux95e0DZcHfkyoA=;
        b=YaARJRQF0aqbrdZxR+zuG1EDBEfd3YcFlMrQgmOuiEsxur/funXDShfwegtu18IsXn
         /o/K1mJ7e48hbbXqpHbBKLqEImcwz6Yu8N/tWYfaihHL7Y3D1Qt7BR39M7NEagydBp49
         QR1blkqj9fIGIAT+AJb5A5irhIWqjPoi65m3TR1C5C6+AOrDhwG2lu5mBkklGOTqkNGy
         AUJJws/9mxgIAt0xf0G0K8YVS8xoM4mBA74SSQiqFKwyqp/+hoOHr00/kPZeN1VR9je/
         8iEWne/iZxZl/a3pWUsssBKOGzCjkjeCo1LJxVvT0m6/JIN2vEtmyWLxjJ6SJWH9NEAy
         n3/A==
X-Forwarded-Encrypted: i=1; AHgh+Rp6nE8aK4j8hVl6ZIj4j2Pr6hphho58T0N5hunj2bAQoE7AEeQ5N7HFrifzf4WInXKgncKpdkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUUkpXWZIMOrkDYBtYQRPS0aXPy565Qy05g2yviPBnEoTBMG3
	WyTaX5vDxj8A/gvCX/eN7wEBLymNYyyPzXGxZKRDAIFRQuhCgAfWNY9ZOG7a5JHTM3aa7FYuqjb
	M+YAfI2lk0hXB4X+FKUnmqCGiQ3RaldpqfX0A+WeK
X-Gm-Gg: AR+sD11ThtjubV/EScjhoUiNY8nuhw95JrtOg2NbGi+NniVp2JpYaeDJ+MHX8nLEKVI
	hv3JFiWDKX39Sm4qc6Lr4sKuuFdlTDL0RObgxKTumCuA+x2SMch05vpEaJLGJVHX25JpGBg4jru
	KhvbJ38PK8p3+ZNyDIvbs0+DU3yK31cypcZaQv8e6kdcq/hh3oV5f2aMzLQiyX95yN1bSfIOsRy
	9xuBUVFCu5th77fNEWO8LZd9KF0+FeH+if80nSgzBzcD/Y4l+r3A2ViPRPCwK690hrhrDuv8yYB
	eAKBSmQYgAxxDLPRXJoQe/IT8ttFmF1EOajbNMuUQ2lZoQzfhBN0ZbNN8QzWjWKF/sFb8Xce9Qr
	eXr47F6uhSbtZB9iJ7677KAXVI2yUJ63m03+ZaPD6xNUwBZV3yaU+jSo=
X-Received: by 2002:a05:620a:8c89:b0:92e:541e:632b with SMTP id
 af79cd13be357-93649056dc5mr1186003185a.2.1786023933857; Thu, 06 Aug 2026
 06:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730220055.2946171-1-tejasbirajdar@meta.com>
 <20260731220124.B0C621F00AC4@smtp.kernel.org> <1f36d5be-906a-4ba5-8679-24cbcf899254@redhat.com>
In-Reply-To: <1f36d5be-906a-4ba5-8679-24cbcf899254@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Aug 2026 15:45:22 +0200
X-Gm-Features: AUfX_mwdvTEom7e3WZw1jtKlW4Jx4hI_DGQwZjfU5OQKTgLw-QKbrPG4mz7zWVg
Message-ID: <CANn89i+P6Y+uBSKa4S7CAqJWrZNqHOTKY2A2jaVs2iFG4_wRhA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on the
 active connect path
To: Paolo Abeni <pabeni@redhat.com>
Cc: Tejas Birajdar <tejasbirajdar@meta.com>, bpf@vger.kernel.org, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/1/26 12:01 AM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> >
> > Pre-existing issues:
> > - [Medium] The `SOCK_RCVBUF_LOCK` check executes before the BPF program=
 runs and before `full_space` is inflated, silently defeating BPF-requested=
 windows and bypassing dynamic `SO_RCVBUF` adjustments.
> > --
> >
> > --- Patch [1]: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on=
 the active connect path ---
> > commit 2cf5d1d17ae1c7488533ecaa0fcbb83ae4591ec8
> > Author: Tejas Birajdar <tejasbirajdar@meta.com>
> >
> > tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path
> >
> > This commit updates tcp_connect_init() to honor the initial TCP receive
> > window requested by a BPF_SOCK_OPS_RWND_INIT program on the active conn=
ect
> > path. It inflates full_space if the program returns a non-zero window,
> > matching the listener path's behavior, and uses u64 arithmetic to preve=
nt
> > overflows.
> >
> > Link: https://lore.kernel.org/netdev/20260723214208.3655474-1-tejasbira=
jdar@meta.com/
> > Link: https://lore.kernel.org/netdev/20260722170033.2763794-1-tejasbira=
jdar@meta.com/
> >
> >> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> >> index d7c1444b5e304..fcaa04e65189b 100644
> >> --- a/net/ipv4/tcp_output.c
> >> +++ b/net/ipv4/tcp_output.c
> >
> > [ ... ]
> >
> >> @@ -4137,10 +4138,13 @@ static void tcp_connect_init(struct sock *sk)
> >>              WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
> >>
> >>      rcv_wnd =3D tcp_rwnd_init_bpf(sk);
> >> +    full_space =3D tcp_full_space(sk);
> >>      if (rcv_wnd =3D=3D 0)
> >>              rcv_wnd =3D dst_metric(dst, RTAX_INITRWND);
> >> +    else if (full_space < (u64)rcv_wnd * tp->advmss)
> >> +            full_space =3D min_t(u64, (u64)rcv_wnd * tp->advmss, INT_=
MAX);
> >
> > [Severity: Medium]
> > This is a pre-existing issue, but does the SOCK_RCVBUF_LOCK check happe=
ning
> > before the BPF program runs defeat the purpose of allowing BPF to adjus=
t
> > the receive window?
> >
> > If an application sets SO_RCVBUF prior to connect(), SOCK_RCVBUF_LOCK i=
s
> > set. In tcp_connect_init(), this caps tp->window_clamp to the old
> > tcp_full_space() before tcp_rwnd_init_bpf() is invoked.
> >
> > When the BPF program returns a large requested window and full_space is
> > inflated, tcp_select_initial_window() bounds space by
> > min(window_clamp, space).
> >
> > This caps it right back to the pre-BPF full_space and discards the BPF
> > request.
> >
> > Conversely, if the application did not set SO_RCVBUF but the BPF progra=
m
> > adjusts it dynamically (which sets SOCK_RCVBUF_LOCK),
>
> I read the above alike: 'a badly written bpf program could be
> ineffective'; not much relevant.
>
> This version LGTM; Eric do you have some comments?

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
