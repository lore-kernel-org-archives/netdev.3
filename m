Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605354;
	b=jYXStGR/aEXM6CYiLyNfHsLUuYaUiDvmZ3UVmhWAFHJ68YiRnVA0QTWaQbA7NxF4jcY5
	 6zXkaRR3SJ4C/ZK8NQQh4PKSWtcausPM/+1GIUMYopaNPpUU7e7lNKM6gk/+wFeFmmuc6
	 nTQACalJL7xHYv7WtJjxO/EgmEp6+c3uO891IOGzoRfUxuFVx4847Fg/iy7woNbGVV6Iz
	 oubF/c7/iK2NHbZ6bj7X0uHkt2whSNhjYguvTtZPyCu+kDzUVljYK1JQVRYI4Bn03adVH
	 M41TZYphUsJLEwuQ058j/f1/WqypkWYUE5lMyn+w6Pl4/XRQsDEoOmq/ZSUSx130hcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605354;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GX7t2+rzhC36CUFljRoCQC6FXVLVHmjq/gaYHLsA5tY=;
	b=uCufVQFfZ+YL0YZLVVosJsacoSjijjGwbk7CanLibi2nlX57yGH8hH8M2gy2H/imFzK1
	 D1DvwOQJAXQvq17svNlYyvJxYND3qIXNkKDVJlSMLWveUCxHh4fJSAeIiH2wVWGQiTXxW
	 wDc/oaAubuUpIUiqOqolSYHAsvEn0RGsnEyVzUFTLL942mFwoX4AnOuJIpROOOxrGp+fj
	 7ogWPee0VaeLpQYqvsE58i4vgEq5oDy8ooDRYRi6Oe9LCSgtET7gNNUyHl1xIH1grhaK7
	 O5OjoPey4XIOY8RtxrYXleWS6DbkvRLGItNfYYp5w/LvpkDGbcXowVQEuUjaiC4vR3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZbOALAr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB289606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZbOALAr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BFE1F000C8
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792605353;
	bh=GX7t2+rzhC36CUFljRoCQC6FXVLVHmjq/gaYHLsA5tY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GZbOALArO+E73lqVEGZdu0mugIdOedXGxIsqd2gdWg10F1/jdv5fE+vcyl7DZFdvD
	 lY4PJDXyTdd4OU5IaLND6ZoLKvvUkFh4fNPp5f3u/CfOIzJwdck7McSvgQ6e6qTOdg
	 oLAU92+/j9QqK/1/EWpc3ObypsJB5j0/LjYHIkcBQMn7WcE+Xh7VRkCuw7k/wru0BJ
	 ORciyG1YXX4LDfsNhh6MblZ6w7Yaz+5ZLprSNyc7/v1jWR+gsmBJyRX02pKK7ZqmGZ
	 uyWmd0uE5kdTkr51q2ZQQ8uBwl/66F04gpIqBVezCdEyS7gKk2zx3fI5JD7dmAbzAt
	 51vVgUpmLe+Uw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4a76d86a3e9so422871fac.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:55:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByrRL+MfKv1jokFBtPh9MOfDIPIsPJoAeCJzgFlIBgFA2QqUsJdwcO/2DnhQzHic+skAg986b4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzR48DAX+4zFA+nBg8o7840iKT3+SOrRujWWUAThIOCfZCAWJM
	IBeEkr671LwTeIRQwYjBR5XPGD/II6Y2Mv/lpYpk2cYhugIP5WpGaHViTXMTrntEkFNpXGiWEq1
	VJP1xJqwLq9iQWlCeOxVeZNJ1VoHedgg=
X-Received: by 2002:a05:6871:4045:b0:494:7d13:7a5c with SMTP id
 586e51a60fabf-4a7dc1b092emr1616137fac.30.1792605352760; Wed, 21 Oct 2026
 10:55:52 -0700 (PDT)
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
 <51ccddcc-53b0-47cd-9526-ccd825f0f6d9@linux.dev>
In-Reply-To: <51ccddcc-53b0-47cd-9526-ccd825f0f6d9@linux.dev>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 21 Oct 2026 19:55:40 +0200
X-Gmail-Original-Message-ID: <CAL4Wiip2F59XO3BrjUHVrFqYMuD-LxNmZXhtftkV-JG0Ya84Yg@mail.gmail.com>
X-Gm-Features: AclHuK-8olJtlfn_X0E97Dd5-TyqwSFatGSZBBSxpWG1Y-iSJJgCbCPIvp7Vs8A
Message-ID: <CAL4Wiip2F59XO3BrjUHVrFqYMuD-LxNmZXhtftkV-JG0Ya84Yg@mail.gmail.com>
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

Le mer. 21 oct. 2026 =C3=A0 19:04, Qingfang Deng <qingfang.deng@linux.dev> =
a =C3=A9crit :
>
> On 10/22/2026 12:31 AM, Eric Dumazet wrote:
> > Le mer. 21 oct. 2026 =C3=A0 12:27, Qingfang Deng <qingfang.deng@linux.d=
ev> a =C3=A9crit :
> >>> +       case PPP_IP:
> >>> +               skb->protocol =3D htons(ETH_P_IP);
> >>> +               break;
> >>> +       case PPP_IPV6:
> >>> +               skb->protocol =3D htons(ETH_P_IPV6);
> >>> +               break;
> >>> +       default:
> >>> +               goto drop;
> >>> +       }
> >>> +       skb_set_network_header(skb, PPP_PROTO_LEN);
> >>> +
> >>> +       segs =3D skb_gso_segment(skb, 0);
> >>
> >> Passing zero features to skb_gso_segment will linearize every segment
> >> prematurely.
> >
> > Good point, PPTP and L2TP do not need linear packets.
> > I will pass NETIF_F_SG: checksums are still computed in software by
> > skb_segment(), as openvswitch does, and ppp_bridge_xmit() linearizes
> > segments only for channels without direct_xmit.
>
> What about NETIF_F_FRAGLIST?

I do not see your point. Can you elaborate?

There=E2=80=99s also nothing left to gain on fraglist packets.

SKB_GSO_FRAGLIST packets already go through skb_segment_list(),
which just unchains the original skbs without copying, as the fraglist
test run showed.

Frag_list skbs that aren=E2=80=99t fraglist GRO go through skb_segment(),
which with NETIF_F_SG already shares the pages of the chained skbs
instead of copying them.
