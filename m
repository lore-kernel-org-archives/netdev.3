Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607357;
	b=fNMSqiKwnLows9UtTc6hcV2Ghip/ZKp+CGJ8zUsVg270GEwChTOx65XqXkrgNlfFORaY
	 +AL+n6gz22WZop799unSMFP8ebhO4ZB+bYZwJqS2k+SYTO5JNfaf6yrgQkYQaR9MPTPvg
	 wweyhyRuDxJZEkkCGNTUcIjX+YeST/NjMwxrhGtNrg44bcK0R+Xj6ZUrHbHtbEis55/I9
	 F1NyPry1TVsUxLpUWZzXeMAIKajBXZ8WFs51cxT+yaSKzimf7oiRK9oVFQthDkEeFKGol
	 C7Ph9mvJh3FHJLLRKCe1GgRijue+gQMDD6E+K1iY+Xnd+vMazVvgUB2AG7X4wIfHYgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607357;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ggVpSG/Q2EbzVO8MsL3OxAqR882doyE1OLiyat9CU3Q=;
	b=qXPG2VLtKVspzBAAIW3fHaAnoVeWDiLBrGs1QsM12yp5ZyWM7W9x/vVNKWUVVuOhgmN+
	 3q8IyhZxlZeoXSat/wNrF04nfkMeVtzM+yoURnYSwHIKMDJwuTLd0jvYw7vlkSRnt8HFZ
	 g11oj1RtB1B5ezds+O0hxajss9IQWa1jcFeRsBVHSxvXF4lbt2eOm3TiGRo2M7xze6IRM
	 HySPyM5nD4HB5AFgA6cZyin5zm3ZNh39guaR6veQrevysGYSyWIv4JFitRN3gu5Ouhtml
	 MoxgK7eKBrw6nrYu7HfVcETprSKNlY+CP3bkBE6sAvmU3EFQHYa7qNYY/4CzreOGolw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dooHytXa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E1606A32F
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dooHytXa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CC51F00A23
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793607356;
	bh=ggVpSG/Q2EbzVO8MsL3OxAqR882doyE1OLiyat9CU3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dooHytXaEmX5IvBrV6UTjQdMy8W56tpSkMndQrRdEvjEH5heTpQih4Uo/9f4PXxAZ
	 mVIRZVdXV0I7idNNg3K/SRuYyrUu/Y0UW8GAi0jQQZZc3Cp+96/3lWSpWu125Lfv9v
	 J3nzq/NxtEAgt4nYml95Se2JHyrQm6Gu0021Z9hGUxURoiIbDTllDvROjgcWcpSsLQ
	 71XTl9lTp0TlgnHuiTEIjc/T55hPXYF/U42yWk8NaXEW/8xZaale1pn8Z2UpWjp1la
	 ALOUrZQPh8nuhq7zc6CIUxSyVoKs7gIhlR8eeTrLiNQyUAYiP2TJ6Uh8X02CeGa1nt
	 HO5sM4udYbhhg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6df5e315bd1so2459342eaf.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 00:15:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwTpbN8cnWdd6YXiPfKbBaMnznoKcggBnWtzpWWfJc0NtpxVoZFTndmafzoRyO3blynr/b1qJ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKpZGcVeOwfG7+s04azXLLUmXJivehRhDXOKRR5a+FXjHhIB73
	EfHf/TAsAQJVJ4G44UmbpgsI2zb9mXHWrxObSE8AFUYtG6g7TvdGVzxIXbuGJkZpKWANGufr4pB
	W8mTz0Sivz9vIeJOGRYYdRvOYwaM1iKA=
X-Received: by 2002:a05:6820:1504:b0:713:de09:427c with SMTP id
 006d021491bc7-714f254b5bbmr5208069eaf.60.1793607355409; Mon, 02 Nov 2026
 00:15:55 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101075145.698399-1-sgzhang@google.com> <audwphXNeZhVItS0@google.com>
 <CAPqVEODgo=mr+3viog+bY1XOKHLcrEVhs4CtZ-SiSYT4Hh+gjg@mail.gmail.com>
In-Reply-To: <CAPqVEODgo=mr+3viog+bY1XOKHLcrEVhs4CtZ-SiSYT4Hh+gjg@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 2 Nov 2026 09:15:43 +0100
X-Gmail-Original-Message-ID: <CAL4WiioN5-eu3DExHHs75BaK77j+aR3CNr+9p11CRQDd4gpXhg@mail.gmail.com>
X-Gm-Features: AclHuK8YH8kivFCcxwhh3LmuTY3n9bSMVGRi64ndTBUddMQAOZY_6fQD74nptxU
Message-ID: <CAL4WiioN5-eu3DExHHs75BaK77j+aR3CNr+9p11CRQDd4gpXhg@mail.gmail.com>
Subject: Re: [PATCH net] net: count last skb of each sk_backlog pass in __release_sock()
To: Ray Zhang <sgzhang@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Decotigny <decot@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 06:35, Ray Zhang <sgzhang@google.com> a =C3=A9cr=
it :
>
> On Sun, Nov 1, 2026 at 9:15=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Sun, 01 Nov 2026 00:51:45 -0700, Ray Zhang wrote:
> > > Running 500 concurrent TCPv6 streams (neper "tcp_stream -6 -T 1 -F 50=
0")
> > > on a 2-core Cortex-A53 (CONFIG_PREEMPT_NONE=3Dy, HZ=3D1000, LATENCY_W=
ARN)
> >
> > I guess you tested it on 6.18, but note that CONFIG_PREEMPT_NONE
> > is no longer selectable on arm64 since 7dadeaa6e851.
>
> Right, we hit and tested this on 6.18 -- thanks for pointing out
> 7dadeaa6e851 and for the review!
>
> On mainline, cond_resched() in __release_sock() still applies to
> !ARCH_HAS_PREEMPT_LAZY configs (e.g. CONFIG_PREEMPT_VOLUNTARY on
> 32-bit arm/mips/sparc, or CONFIG_PREEMPT_NONE with ARCH_NO_PREEMPT),
> and landing it in net lets 6.18.y stable backport it cleanly.

SGTM, thanks!

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
