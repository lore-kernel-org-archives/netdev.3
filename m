Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB642314D
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305406; cv=none; b=KZpcF55qZctYkzV/0ZcAI3/qytlOa1MZYkXbamrmgv54HxyAZG9mBTaN6Y5PbKGEwD0gwBLVHJFQSBQf/YrgB2VLL7aKhq8U0uLZPRNm1R7dCw0Z6OAXhCrvTKujkZdWXB3+YQfLjTIC6Ubq1fjTKyUQYoNXFhNlRzX0tO/vKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305406; c=relaxed/simple;
	bh=8ICOAF+Csaod43QLvuGoAGK2P4g7zOrVzra21zr8IhA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HrPgBRDjzmmKngWN86e+kTHD+CzIp1BeW04YuwOjDWjiEVNSbSoIJOWJdWvY4tgNNHg9FEmiNXHBpsSHbXU6HpXNLFLM64UB9E4WO+bDzDC4O8Go4qCg6h570g9nz/kMASSBbfB9tHthTvnnAa6BIO264VMR9aCd6lCeK24hs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Na/jxiNJ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Na/jxiNJ"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770305404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pS4CwfUmLVVYEaGKTrnOmaVQ9A+Wa7bM5Pi55GufFW0=;
	b=Na/jxiNJtznifXn9ZUXypnXC16SRxV8wRbUzCvUBSUMKxbatRQGxCNjOjFhVKfWKL20nCK
	nm9ggxyOa7TyXniRaXq30ajaBKlCumyUFOReoRCMFdqTLMRJlFs5onok4QgJAYyaE80Y+9
	PJ1Fg+huopLWPqmI6BC1/sg8AYGxoIM=
Date: Thu, 05 Feb 2026 15:29:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <3864f233d228b86ea89f224e39ed77b05c298e54@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v3] xfrm: fix ip_rt_bug race in icmp_route_lookup
 reverse path
To: "David Ahern" <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 linux-kernel@vger.kernel.org
In-Reply-To: <62b51184-cc76-42cc-beea-91b6e815132f@kernel.org>
References: <20260205070203.61560-1-jiayuan.chen@linux.dev>
 <62b51184-cc76-42cc-beea-91b6e815132f@kernel.org>
X-Migadu-Flow: FLOW_OUT

2026/2/5 23:17, "David Ahern" <dsahern@kernel.org mailto:dsahern@kernel.o=
rg?to=3D%22David%20Ahern%22%20%3Cdsahern%40kernel.org%3E > =E5=86=99=E5=
=88=B0:


>=20
>=20On 2/5/26 12:02 AM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> >  index 4abbec2f47ef..35816ac749bc 100644
> >  --- a/net/ipv4/icmp.c
> >  +++ b/net/ipv4/icmp.c
> >  @@ -554,6 +554,22 @@ static struct rtable *icmp_route_lookup(struct =
net *net, struct flowi4 *fl4,
> >  /* steal dst entry from skb_in, don't drop refcnt */
> >  skb_dstref_steal(skb_in);
> >  skb_dstref_restore(skb_in, orefdst);
> >  +
> >  + /*
> >  + * At this point, fl4_dec.daddr should NOT be local (we
> >  + * checked fl4_dec.saddr above). However, a race condition
> >  + * may occur if the address is added to the interface
> >  + * concurrently. In that case, ip_route_input() returns a
> >  + * LOCAL route with dst.output=3Dip_rt_bug, which must not
> >  + * be used for output.
> >  + */
> >  + if (!err && rt2 && rt2->rt_type =3D=3D RTN_LOCAL) {
> >  + net_warn_ratelimited("detected local route for %pI4 "
> >  + "during ICMP sending, src %pI4\n",
> >  + &fl4_dec.daddr, &fl4_dec.saddr);
> >=20
>=20per Paolo comment on the previous revision of this patch, strings sho=
uld
> not be split across lines like this. It should be:
>=20
>=20net_warn_ratelimited("detected local route for %pI4 during ICMP sendi=
ng,
> src %pI4\n",


Sorry about that. I totally misunderstood Paolo's comment.

pw-bot: cr
> >=20
>=20> + dst_release(&rt2->dst);
> >  + err =3D -EINVAL;
> >  + }
> >  }
> >=20=20
>=20>  if (err)
> >
>
