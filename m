Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612854;
	b=f2E+SgZewrevnkENgOM45cYQlaZXgknkybLZ4VneEH/n435G+/cP/SEK6uen13JZcGux
	 a3Th4gzfcHy9G/IdQRlz3jHpjTwOiSmUO+TOQ454tmlVJn702vP2/81AYjNItSZZ69CGN
	 a/ZqgrFIjohRjTc076Qtgy2qJjy3nZOGn+9cNZZ7PMXeAsdLkhwddWOSpAh4ZqrMlmN2Y
	 7yqrxIIf35984EMCeHHPt+WKPwhsqYUrlr1QanHsx5WfpPTFig/ANdIY5cau8J3NZRiCO
	 LplPpLNvx8tULISB7LZb8SFTtfmzBqSVUeZhNQmfO/kVmCIEcZduZlWpEIr7L3S7r/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612854;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HWE9qB5/FYd66wghp0lgQgQG3+G/Uk8xX47Q6AQKNFk=;
	b=Ulw/OAaXU5PjqEawEguLdkQwjQiHtlgWUtVlEVye9i6lxba2u0reweVW/Ip4icATAWR0
	 A79Y5RgUvPpMs8fJa03NopQJurocv3WXKeIs8izAeUqr+G8pux2P7DVxUH9MYRpNgKitd
	 8ihUv1w6JD3iEDd28sjDDTzyKQfAQ8Wp/870LwRPuULaj1Ci854wQ8YMnJXY13KI1ZB6X
	 EPh2EoPqyS38m3ZnsnUb01QWCYLfW0OFfPNXzag4PXxqZzEw0dZfZCQJ+LOhWwAnuNRcS
	 Jakj8L31AVtY/GuJQAHpBPQICk7dQyp8Mbp2jdSXFXSk2dPVy0IKftZ46AZrv/4X/jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bv9X+um5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7A606A891;
	Fri, 13 Nov 2026 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bv9X+um5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4781F000CB;
	Fri, 13 Nov 2026 23:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794612854;
	bh=HWE9qB5/FYd66wghp0lgQgQG3+G/Uk8xX47Q6AQKNFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bv9X+um5+bmN9SEwaiFNvbeFWjChgBczKEprYxEvtQWzjn04uQlwOCJ4u15aqDT4q
	 C7YdIQr360Vr69Ct5bJLE6PsrzVwqtuKF47tUsqYSFzvS6ajMsh/jczMBfW9cCcLjZ
	 vimi4EO23Yh8XoX/IjI5lpzEYAl+XHmvLlWWirSJkiZdhOy2btCMnv2h2ayGsAUxwi
	 WFE2L+p22NEkGnLn+gLNJ1Ya2Dh8eN1NNULpdVDXqWfW5lGAMmkK4BdtE8OlJuuMQj
	 O2i1MKuAn75WUkp0NK/RNFcbq08+H/Ths9qyf8QuJ112BTnLjrVYGLxzunx6gQEpsA
	 8IpmnQY9z5tvQ==
Date: Fri, 13 Nov 2026 15:34:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: "Harry Yoo (Meta)" <harry@kernel.org>, David Arinzon
 <darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>,
 <kernel-team@meta.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ena: reuse the whole RX page on 64kB page
 kernels
Message-ID: <20261113153413.541945b6@kernel.org>
In-Reply-To: <179460571746.22458.2892088316099736810.b4-reply@b4>
References: <20261106-ena-rx-reuse-64k-page-v1-1-ac75b20c5de8@kernel.org>
	<20261111164751.5ac643fa@kernel.org>
	<179460571746.22458.2892088316099736810.b4-reply@b4>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Nov 2026 21:35:17 +0000 Arthur Kiyanovski wrote:
> On 2026-11-11 16:47:51-08:00, Jakub Kicinski wrote:
> > On Fri, 06 Nov 2026 03:17:11 +0000 Harry Yoo (Meta) wrote:
> >  =20
> > > This shows up when RX data stays in socket receive queues, as each
> > > queued skb keeps the whole 64kB page alive while at most 16kB of it
> > > holds data. On an EC2 t4g.large instance (64kB pages, 8GB memory) with
> > > 519MB left unread across 64 TCP sockets, RX pages pinned 2869MB of
> > > memory while the socket layer accounted only 687MB. =20
> >=20
> > I'm not sure you're actually fixing the problem you're describing?
> > You optimize the memory use but the (unused) tail of the buffer is
> > still not charged to any skb, is it? Or does it now fit perfectly?
> >=20
> > Normally when the page can no longer be chunked up we should charge
> > the tail to whoever happened to use it last (see the page pool code
> > which does that).
> >=20
> > Either way, you have to respin this on top of Breno's fix which
> > was applied earlier today. =20
>=20
>=20
> Jakub,
>=20
> If I understand correctly what you are saying, you are correct.
> skb->truesize is still not reported correctly.
>=20
> The focus in this patch is different. It is about using the whole
> 64KB page instead of only the first 16KB.
>=20
> Harry's own figures show most of it is recovered =E2=80=94 497MB pinned f=
or
> 519MB unread, against 2869MB before =E2=80=94 so the remaining gap is the
> final tail of each page, not the 48kB.
>=20
> So I agree the commit message needs to be more precise.
>=20
> The skb->truesize fix can come as a separate fix after this one.

You sent it twice? Some LLM automation gone wrong judging by the
m-dashes in your reply? :/

Making more efficient use of allocated pages is not a fix, and
will not be accepted to net or stable. Not accounting truesize=20
correctly can be considered a fix. IOW the truesize accounting=20
change has to come _first_. Then we can optimize the memory use=20
w/ 64kB pages. They can both go to net-next, but the cannot both
go to net.

Hope spelling out practical implications of what I said earlier
makes it clear to everyone..
