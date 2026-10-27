Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117851;
	b=tAsYt31ad1Hgd9Mxo1K/Z1JsV7IbgoY5+/kOBMKTtlLlQvTBsuuXduuCjydLeNKme1WT
	 J1Kp+rk3XGnymgBkLf65h0GM0B6NsqbdmjaNLeWBm3hiPN5iRLFE9EFk5v7B+38ssiWSg
	 tXNyXLvhsPfdfwsDPWxcUuf2hN+XpgKPBoIZBwVKkn4wcZcZkHL0DlUjE+IX53SH1JxrB
	 R+l8bDtm4GV0IXzzTuv2DOEHkYfNvpVbixjVgidvvcvYlZGWGYsC0ULGCQQTlRZW93nTC
	 2dxBqMCb3ZHOMKAZobuvDRTMLKedSrHKjJPQqpopvVgO0AEw+bUzNjFSJIuqefWgn1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117851;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4+5GjA9xcyojbBFlKgNz6N+IXdxCy/xs/OXr6GA6okg=;
	b=AHxwgyIfcdZaCHDi/2Dv+mbvjxvR8uZaAgBtCYHYIGEaK6qH3wup/wBX8lzMvZM2Ytoq
	 o9epNetQLlTnIEA4l/Y+BWop859yuUHyhCYyWDhRsnApXzGbMrMdvWjs5uo/0ecDTeViO
	 nLnyFYVQCLpCGsJeTifUJGpWccU8DnTvn8VsbMVDZ9hKeMFgLUgY7DgihHbHB3EYT2gjp
	 cCG48rLEo3gHLCEtSC0d0IZhvRiiSJSY1qCQVQFJtYtHbBkHRTkuheQ5bWcyycHcbZY85
	 2KjCGR4Ky76vK5x2XR3vdWjlU8V7pE0i5DELE/34PZQ0TOfmSemG/U/nlR1DcLAghdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKQjrsVJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B81606A327
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKQjrsVJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBAB1F031E1
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117850;
	bh=4+5GjA9xcyojbBFlKgNz6N+IXdxCy/xs/OXr6GA6okg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YKQjrsVJMOkTMVqbR0ZtC/1j9AQxIjawdY/VHCViS6+cWLYYtciat/HvrXwXHS/OX
	 OaJ85fQsJzARtCpYmpPSykEMUI+W0keFd7lzkHMAfQPWviGlEN7Il+w/xuyskh1rpH
	 D357fuaEJrhJUV5r2eqviJWIOUQxnoM/U14o/cxXdrvPQS1/PIFns3kOoY60/YXtTB
	 k0n2cjt3qvtJvEsAYda5zTC4ZzdBXIzn6+kO3Qa00by0M34KoJIkhyeHehbGcICCO7
	 7DLs+QQxMPysQtpxaM0zFqFo5RqUI7O9+MvFpZH2enDkLzop78C1BvISm1cf3jucUo
	 /KCt9znlG6B8Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be3ea5a7adso103337e87.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:17:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz8H0M88LoaW0r/nYOyeNvqGJzANbRY2SCWKoCuuP3fZaFctBp4R7Kyly7QON/jlgRr0CW2oqY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtmj3BYZSfL5fP4afTTgKstoSPmkTQev/UV7ECBj93I9iy+o7Q
	qINw+eiPNbBPC1r0VoUwHcIPrrC2IEkHPjG3ONE2dEgupQS7oVP0B++lOBvcd8Qvc8cO1sGYSzN
	PPLT29MU+f1m8SArboAe5l3G4sxOtiC4=
X-Received: by 2002:a05:6512:33c7:b0:5be:54ec:67bc with SMTP id
 2adb3069b0e04-5bfb716df84mr3863890e87.1.1793117849540; Tue, 27 Oct 2026
 09:17:29 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-netlink-dump-livelock-v2-0-c4bb05352a33@gmail.com> <20261027-netlink-dump-livelock-v2-1-c4bb05352a33@gmail.com>
In-Reply-To: <20261027-netlink-dump-livelock-v2-1-c4bb05352a33@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 17:17:16 +0100
X-Gmail-Original-Message-ID: <CAL4Wiio4tt8aCP7u55nusQBO25=nWkysVA-Qy3woPuByE0=pug@mail.gmail.com>
X-Gm-Features: AclHuK8Cngv15UoUB5IJUWV2oDcpXFoB6P2PPN_P-Gvk6dnv9iQE6eKqsWbk1us
Message-ID: <CAL4Wiio4tt8aCP7u55nusQBO25=nWkysVA-Qy3woPuByE0=pug@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] netlink: check sk_rcvbuf before charging the
 dump skb
To: jhonata.poma@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 15:04, Jhonata Poma-Hansen via B4 Relay
<devnull+jhonata.poma.gmail.com@kernel.org> a =C3=A9crit :
>
> From: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
>
> Since commit ae8f160e7eb2 ("netlink: Fix wraparounds of
> sk->sk_rmem_alloc."), netlink_dump() charges the dump skb first and
> queues it only if sk_rmem_alloc is still below sk_rcvbuf. Commit
> a215b5723922 ("netlink: make sure we allow at least one dump skb")
> added an exception for an empty socket.
>
> A dump that starts while something else is still charged to a socket
> with a small receive buffer fails with ENOBUFS and stays running.
> Every recvmsg() retries it, fails again and sets sk_err, so a reader
> that peeks before reading, as libnl does, gets ENOBUFS on the read
> after each peek, never consumes the message at the head of the queue
> and spins forever.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
