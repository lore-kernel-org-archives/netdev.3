Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598368;
	b=u9Nk6U/P5r/Y7/PMUfOUvZTJhFRXf6+s+Rz4e4TV8a75yEjG854wI5wPR8VFvRVUy+XK
	 MQqcNhwiJ6hJLI+DwuEx7sY3uhrK98KDeXSmemIl6l8n7iVYXskR1jpqm2koZJEsp9PYr
	 2Knov5sr79Y6+qOn4EBNEJuIqz2Eg4XbnebDurR9xAm1pdF2YEFqvG06HCSiMBfyz1nnI
	 afSDIVBMtFbr9DfD6FdtySzRhuytkEZjz4qlpXJYIN/eJhrcKnFEN/f0n+jxZYN3+gmoq
	 9yqVJK0seGWGGyOWgmueYoIjxqgC2RfvbbF7GDfNSR1T6BJ+b6/vBsultGeLw4Pgp/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598368;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2BQn0eKB89bn2AsAmi6ydE5TlLgCqTpsqvIon7kf9sM=;
	b=j0klVFbmxLyTPS64PWIfDsPJD4NxXt59qNhgCpW9NxRXjJxpgBf6U0+mQPB/Gm7xuC0H
	 4d0diNVyx8j3Fi+6DaI5FJKG3wE0ETSSItkMEiZnsPkzn34+LNxpkM42DirLkj0f9AMkL
	 9WgIb202FJMxcjzqAbkl5MUCpWXodPa6oyWI2PeaxSCgXBKiP5a2cuDilrOroJbx2OnSc
	 ainPnaKgb/SseFSN6PYBXew8SgVGoEXK1koCkjNDFt4O4kaeVBMI2EPHF4B7w16X+jmdt
	 8hE8gN13xFBmnyn/4HlnOTlD2WdHy0TpzallvU8OOTy9lEkKNYMdDwpZIMX7qFlxFfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTqe5o9z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE2606A324
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTqe5o9z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BCB1F000C3
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598367;
	bh=2BQn0eKB89bn2AsAmi6ydE5TlLgCqTpsqvIon7kf9sM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WTqe5o9z2SHw07GfrJdOTLni4EGp8lhLF6A3hbDk0E+hJdTTh4kqPSvRw+rRr0Hgx
	 PTNbWzUz4dBi4oLwhL4aMrkAnzyMtAjkwD4sliBIiCj52f7wxwHB9C34jYCdqnC9OW
	 k4njKCkWBiUZFija6iNKWNUQFuJE9Fa5stzuyMM4TInmRYYgu3WY3I5O8GkKZhSWH1
	 4ZNakoxlUS//niTskKIakPxEe34xcKpZDKHSTwE1+OcvAT8xQ/+SDmlGrjR/lgvgTC
	 AgwIKYfv2Z9OQFQbQts2VTJvPpqDY6Xb15SRZIEIdWK1zCNntGuzH+JrauS19K/tXl
	 OgxhzhDBOgMZA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bfa686881fso48253e87.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:59:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzbzRYnhWZgWQvYlYkmrlR1nqfqOvnKvXMSJ64NcppDEcfR0Nh8GpU/Oow3kabHevne2iX+i7A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhTZm5lT2HpZGIgUT92HS0TsyZhAcm6WMEQP6GVYfozuZBPSdv
	oZElBs1Dxqf5n9QwRPZSsjDUrnN4O1d/79qJO46t3q9njqkWdKlCgvgawl6GesrW9UIaHrAOUYG
	X+5zJf/i3MCmbE2sCPi72BpkD18rGzWg=
X-Received: by 2002:a05:6512:1152:b0:5bf:a4e5:7266 with SMTP id
 2adb3069b0e04-5bfa4e573b5mr233787e87.41.1792598366157; Wed, 21 Oct 2026
 08:59:26 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020151954.22953-1-edumazet@kernel.org> <179259610296.3135.5083998587535514838@kernel.org>
In-Reply-To: <179259610296.3135.5083998587535514838@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 21 Oct 2026 17:59:10 +0200
X-Gmail-Original-Message-ID: <CAL4Wiiq+++igFUEuWjznMZYDshBEocD8+JnGx0c2NU9GwBsqYw@mail.gmail.com>
X-Gm-Features: AclHuK8-17ZnhwZ3KUYwYg6zpdPE1zaadxvyZrxcLPZHmjKLsHV6_wP9UQsvEMk
Message-ID: <CAL4Wiiq+++igFUEuWjznMZYDshBEocD8+JnGx0c2NU9GwBsqYw@mail.gmail.com>
Subject: Re: [PATCH net] net: shrink the payload-only part of skb dataref to
 one bit
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Stephan@adalogics.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 17:21, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch raises the wrap point of the shared-head reference
>   count from 2^16 to 2^30, but it adds no bound or saturation.
> - [Low] After the patch, the 'DOC: dataref and headerless skbs' block in
>   include/linux/skbuff.h contradicts itself.

Clones queued by packet_rcv() are charged to the receiving socket with
skb_set_owner_r(), after the sk_rmem_alloc vs sk_rcvbuf check.
Each socket can therefore hold only a bounded number of clones.
Reaching 2^30 clones would need a huge number of sockets
plus hundreds of GB of memory, outside of any reasonable memcg setup.

It took 20 years for someone to reach 2^16 clones. 2^30 is far beyond
practical reach, and I do not want to add a check in the clone fast path fo=
r it.

Instead we plan (in net-nex) to limit the number of AF_PACKET sockets
per netns or per device,
since a large number of taps already causes soft lockups in the data path.
We also plan similar limits for RAW sockets per netns and for UDP
multicast receivers.
These will bound clone fan-out at the source.

The DOC comment nit can be addressed in a net-next cleanup.
