Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792641949;
	b=NIzARM/NjxxwB9dXteLFsdzPhRUaaoqxKkpnt/m5RjCWuYoGRie1lWlMF+trsTr/Xf7N
	 o0UrTO39Z4tqQJqrDdGSDAhHYv8sDCuUDiEbMFX2JGhvbbUrAHGt/d36wef3VRE6Yge/q
	 CHJoxvKqfVKU1gf1edcIile8QxVUrHv4tNO1y8ddeEjVdgLv/kCKXO66UqRvlQ8dIqBNB
	 uBSQWhBefUs5IStYtx2hPqVrEEbYitfL8rgsyOUxZ4twC4YRd+v7VG1QyGUBHj6n2nWuH
	 5TcQNX0q/ZUcNCS5SZg+a+j9WvAz9kHjv00EE2qTqeGDypg8FPTSAcNGTYtFyE+ZBHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641949;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TiImOToCOTXq8bZ8fUxI8UXbwrtFjndQ9HG7GJvNlgM=;
	b=BPQGFqhr4TYxtvR+vyLHfNQHX3pOdRRwLJHEJ8/wWvuKgHxxluwP0MOAExxGLEf1Oz3o
	 klCKyO1k8A7P8+4+3kIJ0YHQs7xRK6d147VZtdQpYTFdCepaLZ5Y0OB5kHy0P199bJw8H
	 dG7/yIH9Tliaz3EGrGUazYrYOuF+gQ40JZp6yMj0QoXY+jrdHaIDuylhS3QfmzDppOVjf
	 iw3ZySA0I15hEkrGsHOmry87k8b4yzYzewSwqjICUuI/CnzfxaBtX2C4StW0I4/ivtzyL
	 1BAoCQPsJLlYW+FyfzwYedVsJ2HFNRDIhdGB1mEtOhet/7531vqBTLB+u21WNuLxGvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqA8ksLh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58823606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 04:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqA8ksLh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189BF1F000C2
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 04:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792641949;
	bh=TiImOToCOTXq8bZ8fUxI8UXbwrtFjndQ9HG7GJvNlgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aqA8ksLhKuHUbU6bZOKjQXxcXqn8Id8c1bUUvY9hat1DfTv9isV63FcmNeYv3wVL6
	 ic2KSePquJ+MxmtmazVKzTKqUxZ+5QzskEKV8mgmuQ15sHWHBhEH2kyIHNmr+/t+XP
	 KumYoYrhAXWkwPz2GlYD+LGufP1RbyFv7tX2qWsL1qeQhcV/cdO767Jcmbg49fL2L9
	 cbKfqofFFBIYxcuPPOn33DTxZ2WOOIO0cNVzSloP4spWj6QZRIsbdXKiexUjvBn5WO
	 hciWzcrhRzHHHgqUgttwrS3iv14ROzkrerFj6hduhU5Q74uueW26JViz98cMcBB4RS
	 nI4sv7LGpP9fw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4a76f63b243so358889fac.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 21:05:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByF2JOFLEZQVHYMUqRE66KJ8gj4evic7FxO/Hh9IHuLfAaHq00Ykbh5HDJhUvpQ+Fv1+SOL/AU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLv7ko1vp0AelxHcf+KAhrdF+o9dSt6AM+sOWBZ5KZzNpGr/Qmu
	3JVJ3tLHuJhA3AKu09HYBuOLyhdenonhyblB6oZqNx/CFm9RDpRo/GoCD38NzqPXtmRI2P+3m/C
	toFYulC9uI7FAiQRdxyN2eikKZj4Feug=
X-Received: by 2002:a05:6871:5212:b0:467:2b0b:d07d with SMTP id
 586e51a60fabf-4a7fbd19e5fmr799364fac.1.1792641948284; Wed, 21 Oct 2026
 21:05:48 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021023608.55867-1-qingfang.deng@linux.dev>
 <179255036282.3290.8488375760281728576@kernel.org> <c0f348bf-0e13-4cb1-8014-cd9b7787bfe6@linux.dev>
 <CAL4WiirRPnbSBgcoh8Aiq8zGVzsy34w9uaqAgSKQwpgJ0ht7aA@mail.gmail.com>
 <315a8794-db40-4d0f-9e4c-0cad66174bff@linux.dev> <CAL4WiiouaJ5QU24uKt=CuxpfgHmWHS5oxoE2E_C6KFCLbDh0+w@mail.gmail.com>
 <51ccddcc-53b0-47cd-9526-ccd825f0f6d9@linux.dev> <CAL4Wiip2F59XO3BrjUHVrFqYMuD-LxNmZXhtftkV-JG0Ya84Yg@mail.gmail.com>
 <b3091ab0-0e1b-4835-ae36-14978af46fa3@linux.dev>
In-Reply-To: <b3091ab0-0e1b-4835-ae36-14978af46fa3@linux.dev>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 06:05:37 +0200
X-Gmail-Original-Message-ID: <CAL4WiirdFXnCnDNFGvzWQWcao3mO28RtRUxW3SMQhA=5dytRMw@mail.gmail.com>
X-Gm-Features: AclHuK9wNLzQ4G2rAXhCVxnW_W1Zrh82nJcNVv3s2smPAoJUev7jcw2ED7nE4ms
Message-ID: <CAL4WiirdFXnCnDNFGvzWQWcao3mO28RtRUxW3SMQhA=5dytRMw@mail.gmail.com>
Subject: Re: [PATCH net] ppp: linearize bridged packets when required
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: netdev-bot+sinfo@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>, Taegu Ha <hataegu0826@gmail.com>, 
	Tom Parkin <tparkin@katalix.com>, linux-ppp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Chapman <jchapman@katalix.com>, 
	Sashiko <sashiko-bot@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 04:18, Qingfang Deng <qingfang.deng@linux.dev> =
a =C3=A9crit :
>
> On 2026/10/22 1:55, Eric Dumazet wrote:
> >> What about NETIF_F_FRAGLIST?
> > I do not see your point. Can you elaborate?
> >
> > There=E2=80=99s also nothing left to gain on fraglist packets.
> >
> > SKB_GSO_FRAGLIST packets already go through skb_segment_list(),
> > which just unchains the original skbs without copying, as the fraglist
> > test run showed.
> >
> > Frag_list skbs that aren=E2=80=99t fraglist GRO go through skb_segment(=
),
> > which with NETIF_F_SG already shares the pages of the chained skbs
> > instead of copying them.
>
> I've run selftests and confirmed that NETIF_F_FRAGLIST is unnecessary her=
e.
>
> One extra finding: passing NETIF_F_SG conditionally can avoid an extra
> reallocation in skb_linearize().
>
> segs =3D skb_gso_segment(skb, chan->direct_xmit ? NETIF_F_SG : 0);

Yep, I can do this, thanks.

I was hesitant to duplicate the logic for something that has never
worked in the past,
and at very low rates, unless in emulators/fuzzers perhaps.
