Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1312DC76A;
	Mon,  9 Mar 2026 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090944; cv=none; b=qTVh9QtJH4sPkCjJgoGUnHP/nAHIzKZexxx94l7qUSFOT0YgN6/aNT+0sjK1bRx45rfLTqudMfcXqy1B2P7h+IgNSOaoUF65KlzwO7a5RshmMwsxStOsM0z51hQBfIilaFIe5mJhEsEGQDISDVizGlhAr7eyda0gHTqLUFBR+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090944; c=relaxed/simple;
	bh=1SLWt3kNQVmBa0BAC0We3pmsqqPe9pEv9TGD/Shmn/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osV4iKjOcXgzg6nyoRnuVKAJ/krYIfvVr0aJCuZ2BWJi9VFEdbCx3+D7HTCQMqMvEnGrA14l/k03zVEMlvVOdUnJ+A5weEJGPpULz9i8aGPfjCNbLwz9TOSLjw1tmdFicMfV0+9Ul41zQvNRPocgDYPMYpjdOrcxx3OX02IrAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m96HXZe9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m96HXZe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8740FC4CEF7;
	Mon,  9 Mar 2026 21:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773090944;
	bh=1SLWt3kNQVmBa0BAC0We3pmsqqPe9pEv9TGD/Shmn/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m96HXZe99VZsI9lqK4m4KF2X9XEh+yeQyR+MOiEqx75XEax6b8+Hr+NTOwmNgaqmn
	 vq9BPMlWhar+u+SsZAHmuDJPjbmr7ZdSwytpGvR+nnZLSI0KcZbVPznFOh1lYas4CB
	 XSs3Syl23N09gpC4N9WPIn49Yzr63NCLWULeXMSSf3JGOppJehgUwH1K76v8YwjvN+
	 bGNo/4VSdiXiLNc75RmTtFHKGmVzwzlbRZFpcoV79l9yH15vOp1+7AM8BiGl1Ql77/
	 iYWzn/T3qgnLG4t/QqdWTEh2BHpbv4Lc1uSzlygh22ys3c44VDuv71i3LK1AlucFzY
	 C+gdWVwXM/l2g==
Date: Mon, 9 Mar 2026 14:15:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Paolo Valerio"
 <pvalerio@redhat.com>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH net-next 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Message-ID: <20260309141542.5a8403eb@kernel.org>
In-Reply-To: <DGYEXIY7VNHX.1IUJHFGOJ1B9S@bootlin.com>
References: <20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com>
	<20260305-macb-set-channels-v1-1-28e3a96a3dc3@bootlin.com>
	<20260306190948.44d23f8f@kernel.org>
	<DGYEXIY7VNHX.1IUJHFGOJ1B9S@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 09 Mar 2026 18:04:06 +0100 Th=C3=A9o Lebrun wrote:
> On Sat Mar 7, 2026 at 4:09 AM CET, Jakub Kicinski wrote:
> > On Thu, 05 Mar 2026 18:20:14 +0100 Th=C3=A9o Lebrun wrote: =20
> >> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
> >> +		return -EOPNOTSUPP; =20
> >
> > Why not set max to 1 in this case? =20
>=20
> With !QUEUE_DISABLE, we only know how to run with all queues enabled.
> It doesn't imply that max_num_queues =3D=3D 1.
>=20
> MACB_CAPS_QUEUE_DISABLE means that the field QUEUE_DISABLE (BIT0) in the
> per-queue register RBQP disables queue Rx. If we don't have that
> capability we can have multiple queues (if HW supports it) but we must
> always run with all enabled.

Oh, I see! Perhaps just a comment over the check to inform the reader
that the lack of capabilities means all rx queues must be enabled.

> >> +	if (running) {
> >> +		ret =3D macb_open(bp->dev);
> >> +		if (ret) {
> >> +			bp->num_queues =3D old_count;
> >> +			netif_set_real_num_queues(bp->dev, old_count, old_count);
> >> +			macb_open(bp->dev); =20
> >
> > both macb_open() calls may fail under memory pressure
> > For new functionality we ask drivers to allocate all necessary
> > resources upfront then just swap them in and reconfigure HW =20
>=20
> The main reason we want to set queue count is memory savings. If we take
> the Mobileye EyeQ5 SoC, it has a small 32MiB RAM alias usable for DMA.
> If we waste it on networking we have less available for the remaining
> peripherals. Is there some way we could avoid upfront allocations?

We've been asking everyone to follow the "pre-allocate resources
paradigm" for a few years now. It has huge benefits for system
reliability. If you don't want to complicate code at this stage
you can support configuring queue count only when the device is down.
But the ask will keep coming back, any time you try to do the close+open
