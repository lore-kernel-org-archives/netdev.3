Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E0CB67E;
	Tue, 18 Aug 2026 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787012651; cv=none; b=SRgG0qqd7KFOsqRAuworgTqMgvvBWUH0aTOBzxdkX7Q0le54NQjeAkuVxRoMVxxionpP2YAvAlYR6yvzUCkwQ3bL2OcaJ8o0xR2GpvHQLCNX5R5AbgjU1dDxZYLtzbUHKkZNkWNJm1v8RjRG7Xd65MxXGIk904Bej+NDimgcqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787012651; c=relaxed/simple;
	bh=Eh7JYhJ5k7jW/9spn8a/WG7Aw/9xhw3Nqr93E/NUFYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6FiFZkBxjTVv4rS08udFBg5fMtC0eBILCL2Do9vdGTFSHkO7MsoIHLf2NKxjtzUWbh5Sw+kLH7y5r1RqCjFQ3arbqbKUEG9H85qw0qCKLKGdPh4FWG9gIJtWrTUnsqO9eJZQazg7jVbRHlSpmsKC+Czum/WKIwXQ4gAbO5nVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFRMhoPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFRMhoPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9F41F000E9;
	Tue, 18 Aug 2026 00:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787012649;
	bh=Eh7JYhJ5k7jW/9spn8a/WG7Aw/9xhw3Nqr93E/NUFYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MFRMhoPW1w1D72FrZqdBgYQJFKOmw55Gxzxne846s2krIi8seD7UCozC0hoSUDPGZ
	 KH/ofmLWyI0fhUGvpVvanThW4xzn++YWdUnF9bussAmVJLBa1Q6SNyKiUewgmYNyiY
	 2rMPrZOyuSKte9KfE3BAoOgj6P3awTezQAMz0yTJ7neIOKBs9WQtQ/6Z3dNhOj+M4G
	 fp0VHo15DK/PwtZei4YkEOTw/KLQHWWuhQi8ZLvbXUkBfAMfpRt7+lZUcN72lxb5Y0
	 hMAPTYdffhKe2UFIRw+lmw1+f9WcgiyVeLo4RA7U4aNRT1mHn6Fl33DZMb616fhUBY
	 kal9n0FFHYusA==
Date: Mon, 17 Aug 2026 17:24:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v9 00/17] net: macb: implement context swapping
Message-ID: <20260817172408.70fd9497@kernel.org>
In-Reply-To: <DKPEVAUSS07G.39Z7NX3WYHZ5H@bootlin.com>
References: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
	<DKPEVAUSS07G.39Z7NX3WYHZ5H@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 15 Aug 2026 11:31:06 +0200 Th=C3=A9o Lebrun wrote:
> Sorry for the insistence, but do we have a chance of seeing this merged
> before the next merge window? Context swapping is a nice feature to get
> into v7.3 and it would allow us to send XDP (& XSK) series that are
> dependent on context swapping.

Clashiko reports a number of races with the Tx reset handler.
I think they are legit and should be addressed.
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812-macb-context-v=
9-0-7ddbf5f715e0@bootlin.com

More trivial issue on patch 14 with your SoB being cut off.

I will *exceptionally* take the first 7 patches. Please try
to avoid making the series this large.
