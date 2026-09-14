Received: from nabal.armitage.org.uk (unknown [92.27.6.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD644606D
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.27.6.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408388; cv=none; b=TcZDsJ1x10yKIylJ2wBFwhZd0G9CowQVa4Z34HrijV24jrxPAoUzb6xuRXFfXS8dFRiSXvf9Q/0lPPJHUpe4Us3PF2yE1g/OZ6Pa+Ix0m1muuPYoRYo44MXGmH085pFf3NJq5PtqhKOtHjP0OK66oaZcvFH3FB2YGzrFKC5Qw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408388; c=relaxed/simple;
	bh=jm2nsgExLAk04fJJpRUezGWd6xhWxuyZeuE0XpoKZU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=luJK1Ga4D3yg2JoYla0OMndr4LaOyBSsT1qxBMdRN33PoGv74U+3kd7B2EZv3KMwFxJjdQSxrPl97FJJ7hbssn6IhSSbya+sZ1PvZ0N/ds9yUIQANSEreS33lrs/tjA+k4sdDxlencvTVMOcYXmdXk4EvfNrQbhhbcFu4LEariI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk; spf=pass smtp.mailfrom=armitage.org.uk; dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b=Q2+7n9H5; arc=none smtp.client-ip=92.27.6.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b="Q2+7n9H5"
Received: from localhost (nabal.armitage.org.uk [127.0.0.1])
	by nabal.armitage.org.uk (Postfix) with ESMTP id DAAD02E5DBC;
	Mon, 14 Sep 2026 18:52:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=armitage.org.uk;
	 h=mime-version:user-agent:content-transfer-encoding
	:content-type:content-type:references:in-reply-to:date:date:from
	:from:subject:subject:message-id:received; s=20200110; t=
	1789408362; x=1790272363; bh=jm2nsgExLAk04fJJpRUezGWd6xhWxuyZeuE
	0XpoKZU8=; b=Q2+7n9H5frVNvaU++vFE9bgIAgrGilG6xrg81m53uwEFCNu5J9R
	3ROXWk+IUHctk+hsWgFYptbtEQHHu5gL7LpxH3Fd8+3gjXXrc0sGyv6l9+VURFOS
	KeqtweOHPS9p/5ONyOCJQkwL58wo31dAYPISykWblOZPSlBNVV/QfUkI=
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from zarepheth.armitage.org.uk (zarepheth.armitage.org.uk [IPv6:2001:470:69dd:35::124])
	by nabal.armitage.org.uk (Postfix) with ESMTPSA id 276392E5B06;
	Mon, 14 Sep 2026 18:52:41 +0100 (BST)
Message-ID: <2059d329137db2850f3f303a1b787ee7f2defa13.camel@armitage.org.uk>
Subject: Re: net: parsing IFLA_INET_CONF broken since 7.1 if NLA_F_NESTED
 not set
From: Quentin Armitage <quentin@armitage.org.uk>
To: Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Date: Mon, 14 Sep 2026 18:52:41 +0100
In-Reply-To: <20260914174307.GA450786@shredder>
References: <49f5ad9f2a4c1f2178f64383b4f05c21106fce7b.camel@armitage.org.uk>
	 <20260914102108.788e700f@kernel.org> <20260914174307.GA450786@shredder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 20:43 +0300, Ido Schimmel wrote:
> On Mon, Sep 14, 2026 at 10:21:08AM -0700, Jakub Kicinski wrote:
> > On Mon, 14 Sep 2026 15:21:59 +0100 Quentin Armitage wrote:
> > > Commit fa8fca88714c - "ipv4: validate IPV4_DEVCONF attributes properl=
y"
> > > changed
> > > inet_validate_link_af() to call nla_parse_nested() rather than
> > > nla_for_each_nested() for IFLA_INET_CONF. A side effect of this chang=
e is
> > > that
> > > the code now checks that NLA_F_NESTED is set for IFLA_INET_CONF, and
> > > rejects the
> > > message if it is not, whereas previously there was no check for
> > > NLA_F_NESTED
> > > being set.
> > >=20
> > > The consequence of this is that code which worked prior to Linux 7.1,
> > > albeit
> > > erroneously not setting NLA_F_NESTED now fails.
> > >=20
> > > In order to maintain backward compatibility, rather than calling
> > > nla_parse_nested(), nla_parse_nested_deprecated() should be called, a=
s it
> > > is
> > > earlier in the function.
> >=20
> > Please explain how you discovered the problem.
> > Is there some open source or closed source SW you're aware of which
> > breaks?
>=20
> FWIW, I sent a patch to keepalived in the past and I remember Quentin
> from there. It seems to be affected:
>=20
> https://github.com/acassen/keepalived/blob/6d6194307e11a3d55870633fe00a50=
b56db7e3b8/keepalived/vrrp/vrrp_if_config.c#L172
> https://github.com/acassen/keepalived/blob/6d6194307e11a3d55870633fe00a50=
b56db7e3b8/keepalived/vrrp/vrrp_if_config.c#L210

Yes, that is spot on. I noticed that keepalived
(https://github.com/acassen/keepalived) was reporting an error when it was
configuring macvlan interfaces on v7.1 that hadn't been occurring on earlie=
r
kernels.

I will merge a patch for keepalived later today, so that nest_start() in
vrrp_if_config.c sets the NFA_F_NESTED flag. I have verified that this reso=
lves
the problem.

If it is thought better not to modify the kernel but just update keepalived=
,
then so be it. However, it will mean that all existing versions of keepaliv=
ed
will fail to function correctly on v7.1+ kernels.
