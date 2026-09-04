Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003E37C106;
	Fri,  4 Sep 2026 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788562116; cv=none; b=i0cqch9Qx5vfH73FUAN2GYdFAh5FAyuD8ufW2mhdiw9hd9/pGoukx7ryjiYjxkUTRoV7HwWuwDAbLBoyklGPaglr1v5/qj5mM6nQ5Q0RVGtftcR/ryBUlhSsn8RQ1lJ2SgYXfE1zIe0WypA/NODZPJFe8dpV4qyTctzYHqVqAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788562116; c=relaxed/simple;
	bh=4OscWOtY7/qQx35eJEkFKvh7VtXbR+s+D5mjmlmhvno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thfMubZ617QGTAwWJXntM6cdGd9tPzyOgS+yJfzBI9vRt59HmbpSHp9A+axXq8WFFAMXOoJ+Wc3NCpwUtL7Ywfc91cLQnw2DfucvaBoDD6pv9pDqQNTudA1j1XwB50xpk0bRrUkahFtAEd6WdQoIVXO3oIcygq04PJS074XkmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRDYKMM/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRDYKMM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905461F00A3D;
	Fri,  4 Sep 2026 22:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788562114;
	bh=dcMMpzKXk+4o4v8gygfCDQkrDpaxLX3I2e0qXzonfoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NRDYKMM//3VhuBVR7nJ52fgqTXjcANw8+wJtAYy54+VxihLZjS/F/3keENWqi3tZK
	 z/QpLxYqrmW833xPSXfZk/cLdRuhsnoG9g5Zjbta7fPUbMyn+NKUqOOCnet4zl4IMD
	 3vMONNlCKg2fvB+C4krYHmZg+EZrp+k3d14TevXy+hX/Eb8xO4PEU9qfXr+QKg6Upj
	 oFne4KGK6g7Td/6QR2Gk4d9Gv4UaSUy9LnuiwNjfSyODBCZE+U7f9EWjA7m855OAWM
	 HbjmmeyvP/cWyuzoOK0BrNQ37ITS7gUgj/54W+/61BLVVWDkQNTYfUzQeBftsFykro
	 xr2lnywr+h5gQ==
Date: Fri, 4 Sep 2026 15:48:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev-bot+sashiko@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
 <hkelam@marvell.com>
Subject: Re: [PATCH net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
Message-ID: <20260904154833.3b32ea6a@kernel.org>
In-Reply-To: <apqI44Y5ooLOPeij@rkannoth-OptiPlex-7090>
References: <20260901045857.2779326-1-rkannoth@marvell.com>
	<178850876430.4131868.17635457333077226877@kernel.org>
	<apqI44Y5ooLOPeij@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Sep 2026 14:31:23 +0530 Ratheesh Kannoth wrote:
> > - [Medium] otx2_get_link_ksettings()
> >   (drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:1235)=E2=
=80=A6
> >
> > --
> >
> > octeontx2-pf: report port connector type in ethtool link ksettings =20
>=20
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20260901045857.2779326-1-rkannoth%40marvell.com =20
>=20
> i think, below sole issue can be ignored.

No, the bot is right drivers should not blindly pass values between uAPI
and the FW.
--=20
pw-bot: cr
