Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C03002AB
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773211; cv=none; b=enQdiyBauLUdMQjIb9YZfB5409GKsF5J2PM+gmNnH9qCnp37yLcdS+H+N+a5IxmUIfGOFc8dvzbyxNgc5hMb2fILglFpY47Ejdi9pA9bz5kOivM49y36RcRlCsoj6wbwRf5lEGag2bLewZM5Fu5zU4IOnoJqC53qSnwI7QROueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773211; c=relaxed/simple;
	bh=JtLxpu9fbBvtyh2aI2Eeu66+EpbwIhn4ei9Ouw7jJRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNpz5HirRC0e/NEYZ/xILkIN+9rdV2gtOOH+LlRXSNluKWnFrBN7WLooq4QGAk+ge1wCIcpBGsvF6HJFK9oXf3q3pRwCRUX5P5tCZNPefu7U6tmUfGqYdyE6z9jTi0YyeoBa1JhBlHIjnVKFltFmOrjm6Ts1ZrjUp9elHozVo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW6xAJm9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW6xAJm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9241F000E9;
	Mon, 29 Jun 2026 22:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782773210;
	bh=swWiW2uRgQTzJsfwmUEBV2cvAQhA4pVCCEkepioqNTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JW6xAJm94dR66SXnG/XGkDqqpwCeivuxIwxU5eMc8H5eIudx2mmp7+Rp/3p9qvYAP
	 kPzAj9D5on/FgTpnGkWlfiXCa8EnMgEntw6l/YJlSL3O7phEyzAi3DDgaNiPiLZhoY
	 +ZvCPevDeEcrcca3gzfwtwlXd6CnAkstFgCdSRQzqMqgGkg8f1xJrCsT1WyzuCSRgT
	 oad+g70wYBWz4piHSh1LOOH3j7ldxuKs8Vuk7xzHkfv+jtU+QlNb3aKe4Oh9tpev7i
	 zrfqydLT9d4kthjTLQkzdNn9lXS2UaMUaQa+KgV1z9537IArw/OfG9fgpl89J5GN9y
	 EY9QD/XvTXYdg==
Date: Mon, 29 Jun 2026 15:46:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chenguang Zhao <chenguang.zhao@linux.dev>, Chenguang Zhao
 <zhaochenguang@kylinos.cn>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, dsahern@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] ipv6: honor per-interface proxy_ndp in
 forward and NA paths
Message-ID: <20260629154649.1a7b7f2a@kernel.org>
In-Reply-To: <dd26c96a-8c9b-4dc3-8eb8-a1c6a8842aab@6wind.com>
References: <20260623085600.396401-1-zhaochenguang@kylinos.cn>
	<20260629061831.1211922-1-chenguang.zhao@linux.dev>
	<dd26c96a-8c9b-4dc3-8eb8-a1c6a8842aab@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2026 15:59:00 +0200 Nicolas Dichtel wrote:
> Le 29/06/2026 =C3=A0 08:18, Chenguang Zhao a =C3=A9crit=C2=A0:
> > ndisc_recv_ns() has always checked both devconf_all and idev->cnf for
> > proxy_ndp, but ip6_forward() and ndisc_recv_na() only looked at the
> > global setting. The original commit left XXX comments in these paths
> > likely because idev was not available there at the time; ip6_forward()
> > now obtains idev from IP6CB(skb)->iif.
> >=20
> > Honor per-interface proxy_ndp in both places to match the NS path and
> > allow setups that only enable proxy_ndp on specific interfaces.
> >=20
> > In ip6_forward(), idev is looked up via the ingress interface (iif) whi=
le
> > pneigh_lookup() uses skb->dev. For ND packets this is correct because
> > vrf_ip6_rcv() does not modify skb->dev for neighbour discovery frames,
> > so both refer to the ingress interface.
> >=20
> > Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> > ---
> > v2:
> >  Per Ido's review, the following changes were made in v2:
> >  - Target net-next instead of net
> >  - Drop Fixes tag
> >  - Expand commit message: XXX comment history, idev vs skb->dev for ND =
packets
> >  - Fix subject prefix
> >=20
> > v1:
> >  - https://lore.kernel.org/all/20260623085600.396401-1-zhaochenguang@ky=
linos.cn/
> >=20
> >  net/ipv6/ip6_output.c | 4 ++--
> >  net/ipv6/ndisc.c      | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > index 368e4fa3b43c..c4ca4a813479 100644
> > --- a/net/ipv6/ip6_output.c
> > +++ b/net/ipv6/ip6_output.c
> > @@ -579,8 +579,8 @@ int ip6_forward(struct sk_buff *skb)
> >  		return -ETIMEDOUT;
> >  	}
> > =20
> > -	/* XXX: idev->cnf.proxy_ndp? */
> > -	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> > +	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
> > +	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) && =20
> As stated by Ido, this changes a 20 years old user-visible behavior. It s=
uddenly
> may enable proxy NDP on a system.
> I was thinking that this kind of change was prohibited.

Chenguang Zhao, is this a change you find useful or are you just
acting on an AI-generated port about inconsistency in behavior?
Could you please explain your use case / deployment scenario?
