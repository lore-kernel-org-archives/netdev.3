Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1159274B3B
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733213; cv=none; b=Ud1N+fOxgoUpnKwEErNjFMNe7zBq/WV8Kn9FJua9lVz6gFVPj3UPQWq8URR+GCDQ/mfq09dV/9KAA2XD86U/ARq/vwAqVflIg9gW3pR2ovQN1S5r/eQL9KqQjHDtnM/vk6hCaXqWoQ7j/NW8cgNr/FIC7PQQE7PGv8rgTjF8Mng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733213; c=relaxed/simple;
	bh=Kn4dKo1Rheo90pPzWQDmQ12IwNK9PCSCeKh60AVviww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yl2Vv7Ggq2q8l7XmX713D1O5RfNxfOEOvpgdkRdP6OkX6ESR7THBujvvYngXK75kBkgZrmLnzSS5SCGwSugt1z879omfkwK1vYliRRh9C/ptg5E+1qGCRPPmOnX2u+dYwi4NPEYCQUZGSJ5XEKfxM+PjOcvhdBfLZYRu6u5YpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB3ou9hw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB3ou9hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BB31F000E9;
	Mon, 25 May 2026 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779733212;
	bh=Kn4dKo1Rheo90pPzWQDmQ12IwNK9PCSCeKh60AVviww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WB3ou9hwcJ4z/uKmDeY/t5Ipbt94KB/cAaBPMC9cv+eSleOQDJWFqeYxX2T9GDtC+
	 fk0wyGAykigvvvXGsZnOMvQTBALtf8CbHxxdhkJ+68ncGBrshueLKQL91g0tFJtrb9
	 2wrzp3lsDaP7p4ThFwB5XsRi660riJFViPmQaGMVAJ60nDepMA5R4w5qPLqWizfhBX
	 8xLjldEFBFE9b2caSU9lqr9RQ3bY4oCZhRFSy2tqngUzjpwmeH6aL/de1T07xEYTfL
	 oADDq9ZZBwwpvOTBdV3tx6brHVQ24nAh/uCewQWxyZCfw6WP+eqUvQS0cBR1hlpDTg
	 WJQnvmumj5wQA==
Date: Mon, 25 May 2026 11:20:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Damiano Melotti
 <melotti@google.com>
Subject: Re: [PATCH net] tunnels: do not assume transport header in
 iptunnel_pmtud_check_icmp()
Message-ID: <20260525112011.38a93f49@kernel.org>
In-Reply-To: <CAAVpQUA=kJ-Ne0zDniRehpebv51MuBnvKcAL5DpT2ofk8Ad12A@mail.gmail.com>
References: <20260522115512.1519110-1-edumazet@google.com>
	<CAAVpQUA=kJ-Ne0zDniRehpebv51MuBnvKcAL5DpT2ofk8Ad12A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 May 2026 19:55:50 -0700 Kuniyuki Iwashima wrote:
> On Fri, May 22, 2026 at 4:55=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > In some cases, iptunnel_pmtud_check_icmp() can be called while
> > skb transport header is not set.
> >
> > This triggers an out-of-bound access, because
> > (typeof(skb->transport_header))~0U is 65535.
> >
> > Access the icmp header based on IPv4 network header,
> > after making sure icmp->type is present in skb linear part.
> >
> > Note that iptunnel_pmtud_check_icmpv6()) is fine.
> >
> > Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly brid=
ged IP packets")
> > Reported-by: Damiano Melotti <melotti@google.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com> =20
>=20
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Are we okay with what sashiko is reporting?
If it's legit it may be better to fix in one series
