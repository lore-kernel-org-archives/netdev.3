Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792926408;
	b=pzRFO95o+4N6mOzwNKICBea+ISDkVCFbWhAKOY+eTeWvy2DK7Liex9IhPQwR/+NsHKSx
	 /Gl9JT1d1jjSOJ4LVOX0ghCx53ipsb/NBmnefE9c0r825+MCeAUzK3NHYYmbibQIAf7AX
	 Ulv8InGMncJrEeuJJ6HQW5MVg+YOrwhrG2jhOGlSiFo0YvKlp3GBR94uQmDiWU58aTw9h
	 VmXPUuwv0qcxsZl3NQGjouaxCa2WuDeQFfTbrA3rwqpN93xL0sAliDVVyqE0ShUP+CGtk
	 W6XuG62GbD1N7F6QfwgyrzAt7+Czy5BsyUz8uvBNRucS3PEtz6SRNwesZ8DZj/ViSqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792926408;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=q8QFqFVU2TIq+fRj7XEFcJOFqOFfCbmK26EbqaytbZc=;
	b=AAGRbhjw0LTbT0u1oST//NbVWRR71oDtmoIkGNbLswPcXBZufmJJ0ohWcDpPjJY7x+H4
	 HV3rVfEOHk6wXVI43PeZWnQiYDf307z3+7QFRmF1/ol8bUVkPtJXI+EdOIVeiCIl6MaXW
	 wjj8m4+Ufb7xWb6VZv/a48IBzB8iJ4n74HgcaKcnFI7OE+xQDu9pWCX5b9owCvJdE4iVM
	 8pkz/5k9WHddoz6F+Lonv/dA8cJ8BAAyS8AAE4ctxn4m7M3PHzpVSdgcNJ0Sn6mY8KsQF
	 ZD+h4r8YE4089GKNzUxfFWKBURtiWu4Zr93DZiZ1aWw+qhLAyxagKDQH0gSluiuelwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctFufPld;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96B606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctFufPld
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B901F01828
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 11:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792926407;
	bh=q8QFqFVU2TIq+fRj7XEFcJOFqOFfCbmK26EbqaytbZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ctFufPldIruaHYiWgdHTA5LmSb7iUT/0vfe8lVzHfGPl6G/rePby6RXhigTLFTamR
	 JxZGMwG8q9/qpn4uxYac4pKfNJqwWNW+W41C0vV+1JCcn7pdP7tBtGGk32TSo5kfV9
	 bN+ZGHsUQeF68nXx/flAFyVYhSJ2fpwt/zByNO28ekZyOkBakjU9S3SicdOoP1UjrU
	 ooFj8gIxyETO2jmRhdTEbLHEcdroXLN59nGfLqJqYSdgrfcOZNk3fec0YudCu7lbR9
	 GeC3OAPYVwte4xb/vMiGm8XAvAdOVsVY6h/Ex9KQvMxmO9TFSWU5JoJuOLFWeivs6W
	 WmozWGFoKeYmg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4911df1e196so1103383fac.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 04:06:47 -0700 (PDT)
X-Gm-Message-State: AFq9FYJDTsuq0RbMsrpPN0FTYhT3Z9/8qTNbmUoo3IRS2cAOSuUVeQ9r
	03cgDkOc8UHNH3/CqHYB5EsKD4VUf7VJT2l5Wm5bB5cfprJrqoO4JblpaqyIu7ysPZzLwE+rOtD
	ISfZVObVbCfytWxx/bLNZDClKRhvLow4=
X-Received: by 2002:a05:6870:6711:b0:448:9d5b:6393 with SMTP id
 586e51a60fabf-4a83f4e6266mr2614503fac.14.1792926407085; Sun, 25 Oct 2026
 04:06:47 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025090048.27870-1-yzwlhm@gmail.com> <20261025090048.27870-2-yzwlhm@gmail.com>
In-Reply-To: <20261025090048.27870-2-yzwlhm@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 25 Oct 2026 12:06:34 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqZM-DJWva1+aKz04ie+XTF0eN0Bym=-HGnDeJEf2d90w@mail.gmail.com>
X-Gm-Features: AclHuK8MoOn_s4LcJ_Eje-MumSnu3vJ4q5oreeQo1DV6EIvk8EtAP0yZLxdlRnk
Message-ID: <CAL4WiiqZM-DJWva1+aKz04ie+XTF0eN0Bym=-HGnDeJEf2d90w@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: Fix fastreuse cache initialization on first bind
To: Zhewei Yuan <yzwlhm@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 25 oct. 2026 =C3=A0 10:01, Zhewei Yuan <yzwlhm@gmail.com> a =C3=A9c=
rit :
>
> inet_csk_update_fastreuse() initializes the reuse caches only when
> tb->bhash2 is empty. Both inet_csk_get_port() and __inet_inherit_port()
> link tb2 before calling it, so this condition is never met.
>
> Fresh buckets therefore miss fastreuse=3D1 for SO_REUSEADDR, forcing
> repeated binds to scan existing owners. SO_REUSEPORT starts in STRICT
> instead of ANY, causing repeated fast-path misses with alternating
> addresses.
>
> Initialize the caches when tb2 is the sole entry in tb->bhash2 and has
> no owners. Both checks prevent reinitializing an already-used bucket.
>
> On historical net f4377bf85887, 16000 SO_REUSEADDR binds to one IPv4
> address/port take 4256.956 ms before and 20.004 ms after the fix in a
> one-vCPU KVM guest (bind-only means of 3 boots x 3 rounds).
>
> Found by manual inspection and GDB tracing. Codex assisted with
> analysis, validation and wording; test/benchmark assistance is
> described in the cover letter.
>
> Fixes: 8002d44fe84d ("tcp: Check hlist_empty(&tb->bhash2) instead of hlis=
t_empty(&tb->owners).")
> Signed-off-by: Zhewei Yuan <yzwlhm@gmail.com>
>
> ---
>  net/ipv4/inet_connection_sock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 8151c638a24..93b306d91b6 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -446,7 +446,8 @@ void inet_csk_update_fastreuse(const struct sock *sk,
>  {
>         bool reuse =3D sk->sk_reuse && sk->sk_state !=3D TCP_LISTEN;
>
> -       if (hlist_empty(&tb->bhash2)) {
> +       if (hlist_is_singular_node(&tb2->bhash_node, &tb->bhash2) &&
> +           hlist_empty(&tb2->owners)) {
>                 tb->fastreuse =3D reuse;
>                 if (sk->sk_reuseport) {
>                         tb->fastreuseport =3D FASTREUSEPORT_ANY;
> --
> 2.52.0
>

Indeed, inet_bind2_bucket_init() adds tb2 to tb->bhash2, so the
first-bind branch has been dead since 8002d44fe84d.

Since timewait sockets are also linked on tb2->owners, this is
equivalent to the old hlist_empty(&tb->owners) test.

Reviewed-by: Eric Dumazet <edumazet@edumazet@kernel.org>

Please send this patch alone (no cover letter). Patch 2 is not net
material, I doubt we want it
(see my separate feedback on it)
