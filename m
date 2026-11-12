Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794498981;
	b=h3BJRErD87l/DejIyIUsGDFvPru5Mr+57pcPAVlQYifttPd9/CFC+ONcNojds5YkaZUa
	 NjZzf9dlIVq/giS9cldJDCp5DVbPVQi9fQLxDoozw2KAvqcVCL4hwN/67PAbsq4VC4KOC
	 uC5Tdc8kue1FMa1N5uPmOX827gxoIy3vbAsxVufeanYymqAb2IuN61PwYz4pWb1EDgITV
	 M1ALPg//IkYFXPZe/n/ezCG1SDl1oo9O+abIh5RbZodd5+65bmBtWJkUKTO8UYAHgYJ82
	 jAYqQG4eAyli7guHMN97loGsw/LROC01ZjnHZvAsPmlxHCGrG726/hEIzSz5jJFINKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Q6vCcmO9UnueyWU0efgozjB5WIAOqxMCCYGcp8pVZSk=;
	b=dWfaslKK+Bf8iSuEtbE6mqjsc5N7nhNiQL2ctcvPnZvttbpA4p+C+wV4ByM2uiOC6Iy+
	 0KWEJc3d96WbrEukKDxXoIftXDaf3CkwZaiX90qDGLRlR/ljuw1BISziX/K+ibCLrEOAU
	 FXfhHS+WQh91U1RYRTNxiNh/JAMdeWBB1gyRS9QpCu1zLYyquA9X5O/WPjzohJjnxU59o
	 XRjPYVWm1gKM5mshrflHaEphSYba/plRvsszei4mx9zZZenyXJkzL2C44HloU92ecw6Na
	 D83J+a4cx7PeeGEwOGX5YHRwdtb3aMbcbboXB1xPQMNC+XqNn/efg5QR6HyL16D6JGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMMQwfxn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05816606A336
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05816606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMMQwfxn
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so1020043b3a.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 07:56:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794498979; cv=none;
        d=google.com; s=arc-20260327;
        b=hbdq4wrJde/wowyOzrhXkCt/hRimT2C5+sr/q8ETvQSvun6ZDTtM9feUODHi+RRCB+
         mpL4bMUd/X/6Sn8Cy2UXCuTswoMUJjbgkHyfWS/fKOXKd5SldDU5AcKGQa4meK9unxS6
         QfcjseaK0rSO7qC0FljbrIOKDDsH9gHErMyaLzQfdSjyr+cXbYkTqxgJ6pmr8UztZ/dR
         nvZ1S3hRXRrngZfIKgjzJxnxdfK8Mn83fm8/UJSFerkiEhoxQNHO9U0SV53FdMZ2gIac
         4KtNn3nXb7a8hNkMX+pee4QHS2FddGYQL6VxUSYP9oTtd8AUrSK+eFK81eB/aXTdOP6u
         uLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q6vCcmO9UnueyWU0efgozjB5WIAOqxMCCYGcp8pVZSk=;
        fh=OLCzRwTvdNMLz1DVFlPvmANHbFAegdC4idJNbE6a/VM=;
        b=cluatx5imTKOj29H2LF99AhUYvp+Phgu4khMKmHmVLOBdgP4RGEIjvaIs+f0X1BRRv
         ePsoMAXVs/AxF7Xl0flkmkfxOngWvoRDp8789tLSAZyssqX2kJmb0QNi3BhDx1C2972N
         xT1sch3swpAzOFdwybJc6U71wo/zmEqO3j/je8zd0LQxhQ6wj+boMVT7OkDObRDMVUNr
         NyTZfeP9iwYPqS4bUaerw5iWnlb+UDqES7CBdgajHjsLkXeD75d6F/oKXEjIY+ePPVLR
         ht/wO1Phf4J4hP/U8v0Hbi0r7FfhN/WrdBgT9NJzbJSsrQapPbKscsrBxA04gAENfLJy
         1mjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498979; x=1795103779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q6vCcmO9UnueyWU0efgozjB5WIAOqxMCCYGcp8pVZSk=;
        b=FMMQwfxnGhQl73SmXTmz3Uz/fR5DEkmGqGslOlDNHRgRQuERn1ilxuNemrRhzkBGqJ
         TC/nbvr3M/UlfSDu0l0pmWhaGHUZQekv6rpZTy/rK6iz00ZHta13GKrHNvKh5xfPuT5g
         I838dUJLIEB3vfrekuxhJlBI1FAwzgFDwVDPJ2h5ZKy4tpyqQv4/yAHUkstGe39jCV+H
         hIZKrD8EB+m1u4yeOLlXftBg2cduPxnDRmRczR9bKcrC8XSO++rYLTPEaF6he/OOqXBJ
         PudvFY1qdb4BbH/1pp3C/xdGCdyusJ5RrMhGcpEQ8k+UxMN+2bJLYbHbn1Nz3ew5b/e0
         8qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498979; x=1795103779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6vCcmO9UnueyWU0efgozjB5WIAOqxMCCYGcp8pVZSk=;
        b=p7CzWYu3+P8QBCGztPbuzGlSMQx4XMxc3ZClycIEdq3FkZ5VtKfJ/ICogSoz2QM0hm
         5K9MN8HP35BjGEgA5JbnwdotwgbJengi/hK0gedxtnH+DPie1s+puBias3T22J7T0Cn8
         O22+lLEt83sja1kMoinaBb5nEJ77RbaEM4lhADU3bMrxCEyWNhN2VY1acc1YBQpYrGCR
         f5hsuGosBsJuxyDPqqskyIJyTOrZ0NOBrZHiGX89gpMSREJ9zmLJm4lqCQ5ES+Nv4d/u
         kH8hTxaVIZjQjkKbi9j5X88lieuyGVwXqh976dhJD7BV3ZNiJS94EJdHnXnU4uD1gHfx
         ebJw==
X-Forwarded-Encrypted: i=1; AL+hErGThdKGX/BFEf9K5+K7w8kT8+K1WvwQY02+ZPlu1JyqC6zwKRhnnQyppdCYzdwdOpo4A3M0VBE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9u7eb6Xh1XbWciwWkekJXi9T0Wr+TeZG9lEOtH6bVqCTaPIPki
	SKsWrAc4SVo6gLn2vDYqjVmq5AqyNwuurkP1yH7eSHg2JcT7pcG8gaZZhBPatKofIzI4dztNR3R
	o+pWeyvjdE/wh8rIajxalN9WHtptAiTND3oY6hOA=
X-Gm-Gg: AYBFou34z4KKIE9MUqzSaAphjI5n+pEwq/QCdIc+m8GuQePmKyWNibNLw6wn0tCIDzW
	usAZOuQAkAZQVgzsXEi/oGsua1Y3wb+49NK7MDJzA3vLR/taVDdKKNAmblwQcuknjDKQdPuK/vK
	vl7WQtE7HXoFPfQmmyweXYUKPG5x7t+6LGYTAoj0VnpAkfNQx7OCRWVVZkZUCMq9tALHNzOCXDA
	vc9fowcdCD/PBQ3nwhfdfvXz96qh5fdnyNhXvktEfJH+Ajcdn11y4tSI9sZvyfmpLmxzz2pjfMC
	m3zUhKJl210reLA/jpL9U1nfQ4iFEc1qZnuB/uHjeRlqPQYCJAW7+rquIAMgxBFHLiGm34zRc8a
	S0zNv3FhCuyag8Hm98H1yHr/ixpvQJTXJPBpNuf4ZQlO8yn7PrbQkOWn//jYK9rG7Bc/esDeWG6
	s5Ipt4Cd4gRtgE61wJDyBE3KwLecUMs8Z+RtlUuQ==
X-Received: by 2002:a05:6a00:13a9:b0:8a5:7006:1ecf with SMTP id
 d2e1a72fcca58-8bc1ca74f3dmr6405399b3a.39.1794498979018; Thu, 12 Nov 2026
 07:56:19 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110224233.82977-1-yves.bieri@theori.io>
In-Reply-To: <20261110224233.82977-1-yves.bieri@theori.io>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 12 Nov 2026 10:56:07 -0500
X-Gm-Features: AclHuK-WWnb_Avs24C603cZWJLj9kdWOrIpfiyA-Mg7U4Ik96B8IwVtXOHQS-lI
Message-ID: <CADvbK_edbUYvFXPGJzRspdG+RpV4ZnfP_WwuS4e4_sS2kbDAZw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: do not free a new asoc peeled off while sendmsg slept
To: Yves Bieri <yves.bieri@theori.io>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 5:42=E2=80=AFPM Yves Bieri <yves.bieri@theori.io> w=
rote:
>
> When sctp_sendmsg() creates a new association and sending on it fails
> with anything but -ESRCH, it frees the association. The send can
> sleep in sctp_wait_for_sndbuf(), which releases the socket lock, and
> meanwhile another thread can peel the new association off to a new
> socket. The wait then returns -EPIPE, and sctp_sendmsg() frees an
> association that now belongs to the peeled-off socket, without holding
> that socket's lock.
>
> If the peeled-off socket frees the association first, e.g. on close(),
> sctp_sendmsg() frees it a second time. Otherwise a syscall running
> concurrently on the peeled-off socket can use it after sctp_sendmsg()
> freed it. Both are reachable by an unprivileged user. The double free
> on net with KASAN:
>
>   BUG: KASAN: double-free in sctp_tsnmap_free+0x5c/0x80
>    sctp_association_free+0x1eb/0x750
>    sctp_sendmsg+0x15ff/0x2020
>   Freed by task 836:
>    sctp_association_free+0x1eb/0x750
>    sctp_primitive_ABORT+0x85/0xe0
>    sctp_close+0x22a/0x8d0
>
> Commit dfcb9f4f99f1 ("sctp: deny peeloff operation on asocs with threads
> sleeping on it") fixed this double free by denying the peeloff.
> Commit cea0cc80a677 ("sctp: use the right sk after waking up from
> wait_buf sleep") replaced that check, and commit a0ff660058b8 ("sctp:
> return error if the asoc has been peeled off in sctp_wait_for_sndbuf")
> reverted it to return -EPIPE, without restoring the check.
>
> Fix this by holding a reference on the new association while sending
> on it, and by freeing it on error only if this socket still owns it.
> asoc->base.sk only changes in sctp_sock_migrate(), which runs with this
> socket locked, so the ownership check is stable. The reference keeps
> the check safe if the new owner frees the association meanwhile.
> Userspace still gets -EPIPE, and the association stays with the socket
> it was peeled off to.
>
> This was found by Xint Code, an AI code review agent, and reproduced as
> an unprivileged user on net with KASAN (trace above), without modifying
> the kernel or using error injection. With this patch the sender gets
> -EPIPE and the association keeps working on the peeled-off socket.
> Without a peeloff, a failed send that created the association (EAGAIN,
> EINTR) still frees it, and a peer ABORT while the sender sleeps still
> frees it exactly once. The SCTP selftest sctp_vrf.sh passes. The
> reproducer is available on request.
>
> Fixes: a0ff660058b8 ("sctp: return error if the asoc has been peeled off =
in sctp_wait_for_sndbuf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yves Bieri <yves.bieri@theori.io>
> ---
> Tested on net at b71c101bbb98.
>
> The fix and this message were drafted with Claude, and reviewed and
> tested by me.
>
>  net/sctp/socket.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index b5a57f6..e7e14a0 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -2082,10 +2082,20 @@ static int sctp_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t msg_len)
>         /* Update snd_info with the asoc */
>         sctp_sendmsg_update_sinfo(asoc, sinfo, &cmsgs);
>
> +       /* sctp_sendmsg_to_asoc() may release the socket lock while waiti=
ng,
> +        * and a new asoc can be peeled off to another socket meanwhile. =
 Hold
> +        * it, and free it on error only if it is still owned by sk.
> +        */
> +       if (new)
> +               sctp_association_hold(asoc);
> +
It doesn't look nice to add another 'if (new)' check. Can you move
this 'sctp_association_hold(asoc);' to after new =3D true; line?

Thanks.


>         /* Send msg to the asoc */
>         err =3D sctp_sendmsg_to_asoc(asoc, msg, msg_len, transport, sinfo=
);
> -       if (err < 0 && err !=3D -ESRCH && new)
> -               sctp_association_free(asoc);
> +       if (new) {
> +               if (err < 0 && err !=3D -ESRCH && asoc->base.sk =3D=3D sk=
)
> +                       sctp_association_free(asoc);
> +               sctp_association_put(asoc);
> +       }
>
>  out_unlock:
>         release_sock(sk);
>
> base-commit: b71c101bbb9814d163c00234d43c41f0a17907d4
> --
> 2.43.0
