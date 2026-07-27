Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7BD1EF36E;
	Mon, 27 Jul 2026 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183498; cv=none; b=e1V+GzGe663/luMJ5jcdXyOcnbBPyerSbfuNuP8KUCRM1LtoFCtc+jnc2w2R+ToD6LR5RFE3ylNwaThsOTPQahdHcp+n5pih4X1KKm0iv/lrxKnnsMUeFlcc5yGg5DM6DlRoyUEbzRztBfB8xxPd9HgjtVhK3Znj10qpY51SM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183498; c=relaxed/simple;
	bh=OyZj/ONRG+egh0yHwE7tIaiXgJG3qrDSVWWLu9ja6ag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fr8Ru3QUwLIJ/V9iBjtU0EZoRgtGWdbrxmr0lgk22C/Gi2xFrBWzsWw1RrAg4DLH6OJh8Q2VuiGRhu6pO5AZ1U48zEJe2jFWCPF3cBsqa+ehVNaWeJlrFjNuNdVMf8wrfw09QE3NjqKEWQCz8LnFYaVNtlgLp4Bjc5K0DlZA8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxOUqduC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxOUqduC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686F21F000E9;
	Mon, 27 Jul 2026 20:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785183496;
	bh=TH5btLtsdzynlq0mS3tGP3AaHGFbiL62+K0Auf+4mbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JxOUqduC4Qt4IjQwMvdftB93pWeXoO7vIqYAIoNniRnDLz8FwPK6i2gLj3cOAeHD1
	 Nm11Kb2nrxyigva2J9EeGV+CMXnKeRkw+R3zbVWcN9n6THongIvDwQRmAJuiogWyYU
	 sce/QX893ELdrF1PIqNbntmLkZE9imc6uOzcHPQbwbOj3mib47ezRGH3XdoLkeca7m
	 plRz/u1NtCjs5M7xKZnGFRj4PWxuIImRK3fJlmlLwdwhxMqV4E+cVXOhwlxhDsVRM9
	 g4h7VsuySsxReqCEsZf6mr+KXZ8WNpKYUKP+vR4q+3LIZ/z8TSHR33usIu74+9E0/S
	 LT9da3WVPphPw==
Date: Mon, 27 Jul 2026 13:18:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Luke Howard <lukeh@padl.com>, Richard Cochran
 <richardcochran@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, Cedric Jehasse
 <cedric.jehasse@gmail.com>, Kieran Tyrrell <kieran@sienda.com>, Max
 Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, Christoph
 Mellauner <christoph.mellauner@joyned.at>, Simon Gapp
 <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/3] net: dsa: mv88e6xxx: various hwstamp
 fixes
Message-ID: <20260727131815.0403cbb3@kernel.org>
In-Reply-To: <d46fcc62-b032-4bf4-9397-a11f1b523125@lunn.ch>
References: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
	<20260724165207.6a03c9db@kernel.org>
	<d46fcc62-b032-4bf4-9397-a11f1b523125@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 17:54:53 +0200 Andrew Lunn wrote:
> On Fri, Jul 24, 2026 at 04:52:07PM -0700, Jakub Kicinski wrote:
> > On Sun, 19 Jul 2026 15:30:52 +1000 Luke Howard wrote:  
> > > Three fixes for improving the reliably of hardware timestamp acquisition
> > > on Marvell switches. In our tests this eliminated missed timestamps in
> > > ptp4l, whilst also preserving PTP event and general message ordering on
> > > switches that support embedded timestamps.  
> > 
> > Do you know if there's any precedent in the existing upstream drivers
> > for overriding the reserved bytes? It's not normal for devices to modify
> > the ingress frames. Perhaps there's some precedent, but if not I think
> > we should gate this (eg with a devlink param?)
> > 
> > Andrew, do you have any opinion? Or perhaps Richard?  
> 
> I have a dim memory of PHYs who change the packet by adding time
> stamps. There are definitely DSA switches which can put the stamps in
> the DSA header/trailer.

Ack, thanks! To clarify I of course don't mind modification one-step
timestamping style (Tx). But here we're overriding reserved protocol
fields to carry local metadata (Rx).

Let's see v4..
