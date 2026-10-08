Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266E49EC4C;
	Thu,  8 Oct 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463960; cv=none; b=ZxUCGBq611O3/8wLTW1brSAU+pxeKy7XDgdua8wA0nze66+PcDSDefI3SZxaGJin0PuXV5Nc1XJtJ+TikFJ5oudGULYFuGIRJUZHzMgORiJfztQimlFczf3cwXe5de8j21A1JFpWjP3tNeWDldDRL4yHQZ94LyYRrZps2eflumI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463960; c=relaxed/simple;
	bh=a9tixkSEbQcz1N0tJztSGfSHp3SspvI4PTu4QJubKAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H+QGu60iHxrAsJiB9SontfBBaXhKvDS7ByrcG+ffKoLMLgvpTPTaQgR7xgcVkKWeOIscdHaGVJD+PHcNIkOZBrVrc0LOqv6z3zKlkcgApukdn0Mgizs3+NfESlEPZQnIBZ47FcqDauEDLhD4RTDnPppEEJKIA1nVfR/MGLsKBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LezdWyze; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=19mp8iB+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LezdWyze";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="19mp8iB+"
Message-ID: <738f542b8fb8c9f0049eeec22d274220122cbf83.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791463955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbTt1TRumgeXsEYG0vYMDuwQmHjjWndJPQcaxFsEc9E=;
	b=LezdWyzeL8uN1xlLT2QZAaJdTvEhLPv/CXWEjPcudyjNaKrdjLiDfq0/P/sEIDC9fRCmO4
	EJJcaXXSUT/JIX2wpMriwwsHKXQQpgG8dCJRlxHkFHrybWRxQoOitz+1jHrOVBuDQ4RfGs
	uKxngICBJW3X9PL0D2T0v2RTDK9Ps2ZU9j0Ro4zCyPLePywY1McQxGYNbYK72V3HRbC5BC
	swIDP4b5v8T0L+nr5mKRJL6KdPDXG2LR32FetMIAUx8a83teLWFeRKIBziw5prbCZ9LPQC
	Fgeh8cctS61+GWca5OlzemtSFe5nbgZVJ7KyxmOWiSaKYKaMDh1T6QbtpFqhtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791463955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbTt1TRumgeXsEYG0vYMDuwQmHjjWndJPQcaxFsEc9E=;
	b=19mp8iB+GPsbsYLttXHBybc9uTo1dRcHmiuUW449LgWNZx6yEYWljrTZJ5ejyBA0/rHdNP
	UeM91q64LZqQbZBg==
Subject: Re: [PATCH net-next v3 3/8] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Thu, 08 Oct 2026 14:52:34 +0200
In-Reply-To: <c9f76173-5ff3-421e-a18a-ef9240324e43@lunn.ch>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-3-ddebafcb9ba7@linutronix.de>
	 <20261007205457.GA244932-robh@kernel.org>
	 <35b4bc5dcd6a6340e98361570d304fedb099ae86.camel@linutronix.de>
	 <c9f76173-5ff3-421e-a18a-ef9240324e43@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-08 at 14:05 +0200, Andrew Lunn wrote:
> > > > +properties:
> > > > +  compatible:
> > > > +    const: soce,swip-00-04-0c-10
> > > > +    description:
> > > > +      Register layout with the core version register at offset 0x0=
0 and
> > > > +      feature identification registers at offsets 0x04, 0x0c, and =
0x10.
> > >=20
> > > Do you expect these to change? Kind of an odd compatible, but okay...
> >=20
> > No, I don't expect them to change. But since this is FPGA IP which is
> > easy to be changed, I would not rely on them either.
>=20
> The description talks about "what" this compatible is, but does not
> say anything about "why?" Adding a comment explaining the why? might
> help avoid questions.

That's true. I will update the description.

Thanks for the heads up,
Vasilij
