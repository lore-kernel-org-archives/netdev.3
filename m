Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482633;
	b=fkmdp6qZU3eNrUdtCvJS7jZ83EADIejB/GYXR9mwQqnGsj5WM79L2vfO9BR0LYqIlgKo
	 +gx3crRKifDOXFKQAKt/wsjYBTB/dckM+NF0JA+JjXTHdDFlNCHMhCiBWjldPg2+Yro9v
	 M/Zna01oj7WrAyF3MzHo3Va6OVqSwFMpVzPav/z0Iulcjk8McS7L9NRjwXawolGBFKW7P
	 JmT4npyCG54c1FixsjDc6FpYONry3T3n7zn7L0SPpCjLkR9lzD0X0ivlKd/b93Gg8/uDJ
	 7du2je4KuhfjNKLMqaxXQEzIv2cfCiPSSn7FUyn9/LhRYL3+JyKE0yJr3OQ2lLtjjhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482633;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lkDIuBRDwBt9QuWfP6v+tNbF2hM2OFlcCRYMmL+zaDM=;
	b=sr+32jpLZ9HU1wAFtQ62v+XmDv6x74aGOxmUfZ7SkEetAlATt6ipVZxdikSgYSjLniCY
	 7WcLp9iJcQIUo1E4+R7FiWxLxiWkr6Jtb+l0+bPcWdpcgIfoBxMzh/et2Yu0Dh+dkmpN8
	 IMzPkoFjfsUpE2CNwdHYfMFjnQoLiAwwgIrBvzbQOsFCSUjAo0s49RBFblgmsrktqJuy3
	 gpO8zo8QBB3qpwfiCuvpZWYHCl4vcIU6gSXrKic3TKNXnAP89TlqG9WVAH5CYrpQdC+vg
	 2DFXXQOop4JkpQF49vIY27ZGvZnD5wILmiPiJazrAGX1FCeuN1xh9QQ64AwxWD/9Oew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuzyxS6y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC3606A322
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuzyxS6y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B2E1F000C6
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792482632;
	bh=lkDIuBRDwBt9QuWfP6v+tNbF2hM2OFlcCRYMmL+zaDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RuzyxS6yuH/4Q5MVXucuFLmtlMumhDZiAXBvUR0cF36R1uAeAvcsefXJUuvAYYkBF
	 tQDHMAZzY3bL6TTkIfqK/KY5KqzjJygt5rgS0gnXh/fZljUXlVR/nMA+wffGbfp6Z8
	 HZMBCdgLIKcGDyfL2/EUTVfMTfqiiQTS1ZKghZ7hZzSiW8SEGgPrFJIRe1IJYht3Cy
	 NSRSI4UlFeV3dRrIX9KxURXuiPKyrKU4DRjrAr3TI/a61EHGjK/2IinGOFCcUBscS7
	 0imMl3aJtqJXfzA08BRrNpzJbF9eB0PxcDL3vGOOI8kFGzabE5OM/thgWgrrOGlRXl
	 fqvUlZXHmig+w==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-499f20c7054so1577419fac.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:50:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxX/xHFyLkg8hOrv0jDJunrD284vrtCY/dfbIKNgqj49FsNBV3mRb8+pnpc2Sg6sUmgWU0K+WU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUNw4Elz9CzfWr+h9dtzWpRyY4JBtWrMgGnHq1u8xcJKufdE0s
	dZPF0IpJbM+4iRcvNZS0C863qCCZX6mb25BnP5gszq0kRS6BQZFDNHzUZ2m7SeIh9wU6cY7Ilv9
	daY3WdjWIvT8RcHDUP+/CkkHdvRRNMuQ=
X-Received: by 2002:a05:6870:ac20:b0:475:a1ec:9616 with SMTP id
 586e51a60fabf-4a75795be3emr8911747fac.24.1792482632305; Tue, 20 Oct 2026
 00:50:32 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019082214.102398-1-dmantipov@yandex.ru> <CAL+tcoAyM0uL8UWqYMH9=bCrLwtqorAKHqm=v1tQ95p2y5AqBw@mail.gmail.com>
In-Reply-To: <CAL+tcoAyM0uL8UWqYMH9=bCrLwtqorAKHqm=v1tQ95p2y5AqBw@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 20 Oct 2026 09:50:19 +0200
X-Gmail-Original-Message-ID: <CAL4WiipY6wmLFLAYFixj153jSBTG=3QrK-KHeUj80hqeyMoZ5A@mail.gmail.com>
X-Gm-Features: AclHuK9QC9cuFZdOl573QWNYzlljhHxBTaYVBVby7uu1YXb47yqDbTTaJfdCnc4
Message-ID: <CAL4WiipY6wmLFLAYFixj153jSBTG=3QrK-KHeUj80hqeyMoZ5A@mail.gmail.com>
Subject: Re: [PATCH v2] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Kicinski <kuba@kernel.org>, Levi Zim <rsworktech@outlook.com>, 
	Denis Yarapov <yarapov_d@mcst.ru>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	lvc-project@linuxtesting.org, Sashiko <shodan.ai@mcst.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 20 oct. 2026 =C3=A0 08:23, Jason Xing <kerneljasonxing@gmail.com> a=
 =C3=A9crit :
>
> On Mon, Oct 19, 2026 at 4:27=E2=80=AFPM Dmitry Antipov <dmantipov@yandex.=
ru> wrote:
> >
> > In tcp_bpf_sendmsg(), the value returned by sk_msg_memcopy_from_iter()
> > is checked for error but not propagated to 'out_err' label, so error
> > handling may not work as expected. Fix this by assigning error value
> > to 'err', thus making sure that error won't be silently ignored.
> >
> > Reported-by: Sashiko <shodan.ai@mcst.ru>
> > Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
> > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
