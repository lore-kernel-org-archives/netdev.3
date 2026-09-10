Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80E351C11;
	Thu, 10 Sep 2026 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002905; cv=none; b=Eah+X96q5+WHUw0NXFzXmFwrBkTD1BDsxhVU5aGoLRTP/haSxqHb/2sla6XEiTTQdnvaYvyR+XK8daxaU1gWOK2rT6TQrsHR4eRw/wWGGE4RJPPlpxdhHqxcWSyqZv4cADwuvuAogt3Wj9KjoXtu7YgV05fH2Li+uOoduQLgvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002905; c=relaxed/simple;
	bh=H4KAk2OI9vx4Ejsvu6uZx+0XmH3mKqd6aVKkIO3ORkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N28g/K51HXQRXx2+FmcHUqbPEL9dUCqB9v86ZYJJHLZlOI/Jh2+GhBndmYuLmhT31X32awjagjyIMHS10H33fl5wD/WzzCQgB+FWrkfkGTJvWFjU8JgpIVFBIS14sSE1hhjyhuGa52Ur14yL/F32jh3YbZQJX27fvdN+IBFEMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGwj2IOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGwj2IOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C417D1F000FF;
	Thu, 10 Sep 2026 01:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002901;
	bh=POAGP82gM7lMlJLn+k7WgWMlUNgaXlnuvGb7PmLT8IQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MGwj2IOwbNJmoV58Y8cQKgZ2XJL9npU2BHghUzlPYUUbh7/xWNpj4Bdf1XEHfwxxn
	 PlXAkuNdEJ9PkzNTlA4fpvVblLEvxIzokyjIq2QzNC+tnSYwhrE77g+CIQx4RlxtsF
	 tWHCFTyWkLwH4dmx/saUmCAzVlFDlgL3Cz5T3FdHqEk6BrCocsD4MU+JL0glfr6UrZ
	 Ko1B5KMn5yahEYSLU0Ul4btgscbvJpxu89u+rlOUCv6VmD1sgP56Go65LtKe/jjaA6
	 9hszJKojw1p3G0FM+N012Btr1c9UT1LqTrZkffTUIo8POAsuYvpwKTvUw3Eh+h5GSW
	 HXJqRMqr7NX5A==
Date: Wed, 9 Sep 2026 18:15:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: gustavold@gmail.com, leitao@debian.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/7] netconsole: reject a target mixing IPv4
 and IPv6 addresses
Message-ID: <20260909181500.2e527cc7@kernel.org>
In-Reply-To: <178889577610.219967.4235436069044930159@kernel.org>
References: <20260903-netcons_ipv6-v4-4-bdd183c844d3@gmail.com>
	<178889577610.219967.4235436069044930159@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Sep 2026 19:29:36 +0000 netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> - [Medium] The new family-equality check in netcons_netpoll_setup()
>   (drivers/net/netconsole.c:491-495) cannot distinguish a user-=E2=80=A6

This one looks semi-legit, if you think switching address families
is worth supporting please follow up.
