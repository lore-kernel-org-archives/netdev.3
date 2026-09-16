Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E054B0E5C;
	Wed, 16 Sep 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576308; cv=none; b=FxpQskEFBgZ2qB4JjIC1bG8jeZQjzySkKvbBpUA/mey7nRibeq3LudyDHrKYT3N/p8vRZah7xCaUCczjeFxQk9WfOavF6eh1Hjy/gapE/4fUH4ljVC+/jt1awfH1hFBaMXmHOZ9jmLjSUxchuxahEfCUQq+gU4oTBMGdqijOKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576308; c=relaxed/simple;
	bh=CTbEL7ibtIjohujGx4TcudNt1JPX5O+OKTGx5KXh9Hs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZXCfGWlN3C2o7WU4LTd3iZwbTsxoUPgDt5TzWoJwcJJH0jC4+BbJxb6H7fRV5/eRiTFKFGmQFC9Z5BezLVrF99zjc9Rbh9Qecj8JdEL8kolKqa0IUJH+6kdw9rDifcwYmU1ci0TEA3ECK3qDwcR28DjDS6hyFS8YHs54gQBTrMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ps9FzI1r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g11KRm2F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ps9FzI1r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g11KRm2F"
Message-ID: <ffec9201db3d12944dbd350010560f6234262bbe.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789576292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPa06aPl29CoMqM4aUjsPzJu/eemi4sk0IvMnx3stDg=;
	b=Ps9FzI1rPqjIhTYi7YqBdiN2/XBqSM3AkgV2cKvMidd60hyp+kulkB+GMfOLLwzp0QcBmg
	QIxyhNbY7TK0m8T0JLHRmFmP9s3o5G5lOTJdpoIkA6O5tDCTQYj+EJG2k4KyrewZQC8qMK
	nITpaWQ5TDN/xBXWnoxIWMcWxGAMocL8StJoj+JgRejI5+HzEpBzuc5yRovoBRFW3PdSue
	5It3tKJF/pWs8o/YgEhmrICFfMw6kHPdGRuVyO6KQwEMJOtSxk0IDPMo2+/YofdVx1VPZZ
	BqwV3MlXRekdj6eY/dWvCH3KtElhSJA3zlKQl/iPL5OCNyt95vUQS36t/VvzbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789576292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPa06aPl29CoMqM4aUjsPzJu/eemi4sk0IvMnx3stDg=;
	b=g11KRm2FnNNF9CtE1gnHOxYt0Jlk0DHY97Ufon9OLzU7hzT6+bkO3CoGuvn775rFf/hK+j
	WRCasrTd+88aGwAQ==
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Wed, 16 Sep 2026 18:31:31 +0200
In-Reply-To: <2346e6ee-4075-4d64-8e3e-8fbd1ce81cd6@lunn.ch>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
	 <3c2c5b39-6a7d-4cb2-af1c-b5015b6bf1e8@lunn.ch>
	 <db26d5c9262069a11e5cbe00e176b81e40baebeb.camel@linutronix.de>
	 <5c955c96-7883-4e59-97ef-9fc3b63abf58@lunn.ch>
	 <ab7e4eeed1b8296188355413cce1aa2b2aa5c670.camel@linutronix.de>
	 <b7fdbd43-d069-40e1-aff4-30197371739d@lunn.ch>
	 <3007fddf91fb4260538073482f5148ce8ac6a6ba.camel@linutronix.de>
	 <2346e6ee-4075-4d64-8e3e-8fbd1ce81cd6@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 14:52 +0200, Andrew Lunn wrote:
> > Although mdio-mux-mmioreg might work, I have realized that it is not
> > suitable here.
> >=20
> > According to the switch documentation, the bus selector occupies bits
> > 26:16 of the MDIO control register, while bit 0 is the transaction
> > start/busy bit. A partial write might trigger an operation before the
> > other fields have been updated.
>=20
> Maybe. I can see at minimum it is a bit messy.  The mux would need to
> write the upper bits, but set the lower start/busy to 0. The MDIO
> driver would then need to read back the register, OR in the bits it
> wants to set, and set the start bit.
>=20
> This start bit is pretty common, and generally, writes without it set
> are safe. But you need to test it on this particular hardware.
>=20

Yes, it works.

> > Also accessing this register without checking the controller state
> > could interfere with an active or failed transaction and introduce
> > races (as noted by Netdev-Sashiko).
>=20
> The mdio mux framework should take care of all the locking for you.
> Take a look a mdio_mux_read(). It takes the lock of the real MDIO bus
> controller, sets the mux, performs the read, and then releases the
> lock.
>=20
> The only thing you need to be careful of is write must wait around for
> the write to complete before returning. Some MDIO bus implementations
> don't wait, they leave it running, and do a check the bus is idle
> before doing the next operation.
>=20

I would like to do both. Check at the beginning and wait for the
operation to complete. However, this final wait should not last forever.
If a timeout occurs, something is completely broken and an error is
reported accordingly.

I still had concerns about the following call to set the mux with
mdio_mux_mmioreg_switch_fn() if the previous operation ended in such an
error and released the lock. However, in that case, we are already in a
faulty state and it can not get any worse. The following operation
checks the state and aborts anyway. An alternative switch_fn() with the
overhead of an extra driver is not worth it just to preserve a bitfield
in undefined error state.

So I will implement this as suggested at the beginning using
mdio-mux-mmioreg.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Andrew

Thanks,
Vasilij

