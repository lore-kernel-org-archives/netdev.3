Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE5473C60;
	Wed, 30 Sep 2026 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808022; cv=none; b=bX9kn4JifDQL1UHH0/SKmce11LOk+OsYDjPrkdwfHmmhCWNget5SPU00Rq809gq6bCMdeEFeiX8++H2SCcAB3ENDLixT0kupxwJzInF+8ZG/BgWWy9jgMlN9N/xnWCxdaqmZ6i0GOhLr6WvzERYKpfwd7HRmNIiWAKBnfOpIC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808022; c=relaxed/simple;
	bh=de84FNIBCt3VQVaPiCjca5xONe/TZfF5xZN0UR8iJT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWphTwmyRXGbmukEd3BL31NTFUnbLVClclljfrlWTuL5Ijl8eF1kW4sd/2NEmn/eK7BcYRgignTTk8mRDjAUDrEQXi89WZRCxJZoraakH/MXYkrkZYk2Lp0LNeoiYgEaUk/BObN+uoFwXjgbn2U0amYEYS8WQoLCn8KXLWV31Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjMY6exl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjMY6exl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C051F000FF;
	Wed, 30 Sep 2026 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790808021;
	bh=9kSzPMe2EcNGmvmostDctp3YOboQPfsBpzJAIf6L1L8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GjMY6exlfvr3kviv9wRoXucmqMNuDvX0FnWiG8HvHNT59NyGjrC8gJCbr/GxzaerI
	 oP3orUQxnScunWAIC1nBPbn0nL8xmE+8lZe06NlBIxtOgLZnPd/UrsFl5XIE0vSzKC
	 BE4oOOn4wO5PphgV/1YiSQFGZlxXmpV/Zga5zuUWijiehh8aObC9STXx1YVoDjPyJn
	 Le7f9QV671jpUiKRRFWibjVdMmpvyH3zJf7I1ZWhrzzVFnLehgpysBVhGKAPxHrEt0
	 dV/oj5kvrKoxlorpvu2acbPYX0IXbKiOz+svBuWhRkLVb4wvv9aKvbBBrOCnfoQUyE
	 epREcudxmQJ3Q==
Date: Wed, 30 Sep 2026 15:40:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, davem@davemloft.net, andrew@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev,
 p.ameruoso@live.it, f@lex.la
Subject: Re: [PATCH net-next v18 09/10] net: ethtool: Introduce ethtool
 command to list ports
Message-ID: <20260930154019.63726960@kernel.org>
In-Reply-To: <179064232552.3145.9027939570900472817@kernel.org>
References: <20260927133619.955236-10-maxime.chevallier@bootlin.com>
	<179064232552.3145.9027939570900472817@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Sep 2026 00:38:45 +0000 netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 3 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] ETHTOOL_A_PORT_SUPPORTED_INTERFACES is sent as an ethtool
>   bitset.

sounds legit, why not expose it?

> - [Medium] In the unfiltered PORT_GET dump, ctx->pos_portid is carried
>   from one dumpit() call to the next without recording which device it=E2=
=80=A6

Also right, we fixed it in other places. Off the top of my head fix
like this:

	int start_ifindex =3D ctx->pos_ifindex;

	...

	for..dump(&ctx->pos_ifindex) {
		...
		if (start_ifindex !=3D ctx->pos_ifindex)
			ctx->the_other_pos =3D 0;
		...
	}

> - [Medium] port_dump_one_dev() reads dev->link_topo twice (the NULL
>   check, then &dev->link_topo->ports) and walks the ports xarray with no=
=E2=80=A6

didn't look into this one but sounds legit-ish

> - [Low] The ETHTOOL_MSG_PORT_GET genl_ops entry in net/ethtool/netlink.c
>   uses ethnl_port_get_policy for both doit and dumpit.

That's right, please fix, IDK why AI thinks its low.
You can reject it in the code (start callback)
or have a separate policy.
