Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141A3594A;
	Tue, 11 Aug 2026 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406940; cv=none; b=V9SbPG3cs0T3P90lLe91STyjMt4FiopyeCdV2Dw/vNgKdPPmzVfBefdeHfCNkBc4+C6BpcHqeEH+/mrwGM2T2eSPHkgOXDVWUafKMhtFipoSmCAKc7JlJnwBlad7nZlN9rBO3rWFdIMF/LyKrd9Nq+PZ7lRb5gIOlNpLgSTlAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406940; c=relaxed/simple;
	bh=W0yLkhPdiuoFVcEXSAmbdVSR6znUc7of3JVvaxKIOWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EITJ/0E5EhGnWXx6B0Y33uX2r/0daFpS3u3iSX7G/MbgzkTJQYVw2qJRamDDOpDCGJQJJNQo/r1OLoGDOpODVZWKQ8kpuMApk1/rMrQZEDA9H6Ie1Qp3BfYHyW6sZH0H+R+4VtXLHDCgRhHFD9tSQMck2jPioi4/JCUAlbgf3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA82HdU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA82HdU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8971F00A3A;
	Tue, 11 Aug 2026 00:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406938;
	bh=fNiqgzoCjoE3FdB8S3pSDrxUABp5E01BJyVwZLJ2dR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YA82HdU/G0fE1JM4pbKIcnvkA949c1MHe5Bac770Vnp2U6WZijg4CxBREgbD30cQ2
	 33ez1g5ZXKJetw0jX0IjNMjlP9L/384Nt3DLCl5uJxmABFbyoRBXFUyn2ty74MD3Ds
	 CqSSEVUyemaxrb2J87xrNlqoXSEdmOCgSdE4gaI7LvxFT86QWhk0ZLBwYbEXpZ8my3
	 pyhMmyK1cWTFMlmt79uAgCphMz8qUnasYC+Mc662KRhMZd6BW5bjK9lBmHBHTBdtbH
	 Eob1jJj6gzSqyWzcL93xmvGVpZ2EzpP2AuFrrvWXVFFm5h0TuVg7cLiAEZ+lmv9WZH
	 ztrmkPt985+0A==
Date: Mon, 10 Aug 2026 17:08:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 14/17] net: macb: move printk() calls out of
 bp->lock critical section
Message-ID: <20260810170857.697df2e0@kernel.org>
In-Reply-To: <20260805-macb-context-v8-14-bc302ffd1174@bootlin.com>
References: <20260805-macb-context-v8-0-bc302ffd1174@bootlin.com>
	<20260805-macb-context-v8-14-bc302ffd1174@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 05 Aug 2026 19:42:43 +0200 Th=C3=A9o Lebrun wrote:
> printk() while bp->lock is acquired is dangerous if netconsole is active
> on the interface. In that setup, we might land in macb_poll_controller()
> -> macb_interrupt() -> spin_lock(&bp->lock) but bp->lock is already =20
> acquired.

Reportedly this patch adds:

drivers/net/ethernet/cadence/macb_main.c: In function =E2=80=98macb_interru=
pt_misc=E2=80=99:
drivers/net/ethernet/cadence/macb_main.c:2130:28: warning: variable =E2=80=
=98netdev=E2=80=99 set but not used [-Wunused-but-set-variable=3D]
 2130 |         struct net_device *netdev;
      |                            ^~~~~~

which persists after the series.
--=20
pw-bot: cr
