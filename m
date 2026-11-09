Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242274;
	b=C51Tqfu1e3kJtwa+KWw0QJefFfxXPsn7vy+VuYbreiO7ut175Kj/7iQ6yM8m74YH79Aw
	 nEZ4TtHVrElqMvxaDII8pX9tsljz007x8ImYMLwQ0DJHAy6ei76tgNPpFSdCcxeoFcyFY
	 I3HRQU2AoWi4FA13rGQcBUeP6RajgyCwF8JgfKmbIw0WnMnxjsn0e5gjQfUDDJegumJ3v
	 fgMLvotbFCqqrqEpyqG3F8CrLtKGLfTBpWJy2y70yKYSCjL5hZeTb88FnYCoTxch2dZ5j
	 mCqFxfwBpqCIc2QzXUoWWEL+Z3tuI9ZB9uULaL6hkKLls4jLO++nT4lHOtWCu/AvVWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242274;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bIU3Mj/IAJqHbBELve/38EhXKfQfk1PYpCsA920W0Qg=;
	b=upVplNf/yFmWPn8+VtH5WCTXbrjxFue5GLnA/Jtl0BEBYThkKaMDyHOYFaPZD4lJRhNf
	 J197GROu6XfyQAjPT6C6KZWx9o3dMkUL9yfEoJGkhOjdP7l///3mGkXJQLihS/YRyDlhp
	 KOFcs5chPFP8F99uzcbf1CRrShdVh5AImIOrIGkDGXV/Ck0UpRdqa4mzNHaa1Kc/7dbCY
	 jWWuJ6HivVOTbRF0pmquNE8uHWqwoP/uRavcqnJRGUDac4WCjn9OZ+Gpj8eD/BY7Udm+7
	 yEhe+ghxZ3CSFO28nNge4Pe6O4+b14MPMjoHlI0M4EGvJ54Y9jAMVgj/mA2T5ZgXDiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGE3dYQG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B4606A78B
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGE3dYQG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992DB1F008A2
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242273;
	bh=bIU3Mj/IAJqHbBELve/38EhXKfQfk1PYpCsA920W0Qg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KGE3dYQGaP4tq0Lujstfz3RDFwn4K/JeViE3T0p+sIxOE/yz5420bvYlxoepV1huB
	 PGlxDmf30XulUo1ffzLYchy3cN0xokEfkScTlxXep2n10/CUA6TR0mW6SrOa83aBEN
	 P6VyvKvsH5vKgwV8VeWSix0Tv6D+V80L1569pqdZAfbQvKQ5x51HZmJZ+4Vpthd4me
	 UoNwXQCzd4dNsrVZtwScJUG8CBX0PCQovJtkezRCF67HmIXtYcnA8TonQ1Oz/SwN3g
	 sf73TLlags+akjBkkA50AauW0R+Ppb707axzdxrrBTaGH8V+zV/NAwoO5DzwheFvN0
	 J6bJAYwgLGzlA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43bf9548df4so1262537fac.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:37:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFDQE6/LIJhj1LlVryB2q4orEktItA4gR74ul1+2DhS4qS+0Zi/cOkMOZYaLd8dRAIKXtu0UHI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tZFem4mRZiogA8z++YTKsTcUCRphGV0ZbG1tEuhGo1FWPs7GZ
	L2Gm+X7BaLSnz8gKL+OSegwOVT5EDkTOSZIRLYq5U5od5sU8Dh03Ggn6+GrKpH2GIWSipyMhaTQ
	EK2OQYz9xOKxVr770X6i3Chtby26KGDA=
X-Received: by 2002:a05:6871:1ce:b0:4ad:a95c:ff14 with SMTP id
 586e51a60fabf-4adec9956c8mr2210588fac.11.1794242272919; Mon, 09 Nov 2026
 08:37:52 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106195136.2496777-1-edumazet@kernel.org> <179408330415.994134.10254341408188333393@kernel.org>
In-Reply-To: <179408330415.994134.10254341408188333393@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 9 Nov 2026 17:37:40 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiq5UzXyv+=q73R_FXCoFFcRi4BxtgGDoByQd0dVcPUL+Q@mail.gmail.com>
X-Gm-Features: AclHuK9ttQvYmxwcBLA0pkNpIyy2fFd9eskyCj6iYxRzl5tt5zzftxne6Z6Gxjk
Message-ID: <CAL4Wiiq5UzXyv+=q73R_FXCoFFcRi4BxtgGDoByQd0dVcPUL+Q@mail.gmail.com>
Subject: Re: [PATCH net] net: gro: compare skb->protocol in gro_list_prepare()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, 
	willemb@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	kylebot@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 7 nov. 2026 =C3=A0 21:28, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix is incomplete.
> - [Low] The Signed-off-by trailer does not match the commit author.
>
> --
>
> net: gro: compare skb->protocol in gro_list_prepare()
>
> This commit adds a skb->protocol comparison to gro_list_prepare(). Held
> packets with a different outer protocol are then no longer treated as
> part of the same flow. It targets devices with hard_header_len =3D=3D 0, =
such
> as L3 GRE tunnels, where none of the compared link-layer bytes carry the
> protocol.
>
> > Fixes: 60769a5dcd87 ("ipv4: gre: add GRO capability")
> > Reported-by: Kyle Zeng <kylebot@openai.com>
> > Signed-off-by: Eric Dumaze <edumazet@kernel.org>
>
> [Severity: Low]
> This isn't a bug, but the name in the Signed-off-by is missing its final
> "t", so it doesn't match the Author line (Eric Dumazet). checkpatch.pl
> reports this as a From:/Signed-off-by: mismatch.
>

Right, will fix in v2.

> > diff --git a/net/core/gro.c b/net/core/gro.c
> > index 1b033855a20db..08e4731ddb7e6 100644
> > --- a/net/core/gro.c
> > +++ b/net/core/gro.c
> > @@ -374,6 +374,7 @@ static void gro_list_prepare(const struct list_head=
 *head,
> >               }
> >
> >               diffs =3D (unsigned long)p->dev ^ (unsigned long)skb->dev=
;
> > +             diffs |=3D p->protocol !=3D skb->protocol;
>
> [Severity: High]
> Is this enough to close the bug class?

The GUE direct IP case is a separate bug: both packets have the same
outer protocol, so no gro_list_prepare() check can catch it. It is
fixed separately by "fou: gue: check IP version of held packets for
direct IP encapsulation", which clears same_flow for held packets
whose first nibble does not match the incoming IP version. This covers
both held GUE v0 packets and held v1 packets of the other family.

I will clarify this in the changelog.

pw-bot: cr
