Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D81503BD3;
	Tue,  8 Sep 2026 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862600; cv=none; b=VigAGZWNVwFtZDNUb5xgGpAac+96m5Rzj3m1xpe3eb7CRHCuC2Eb2dep702LT6BCxad9fJT37umn8O+1eJv6VNnSD3jwyrd5pM7XT47kwR7Zd8iQos7/wjbovZvvPn4AF3IrCE4gkmNKFXifWXK9E2W1ND3DdQ6HBN63i3C6a5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862600; c=relaxed/simple;
	bh=DjboxyyhcZpTbpDaKMgn5L7lBy9Q6jXJE2/Ais/0SX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZK8Wiy9Q55pHHJvemzkkpsPZ4z90oEnYTnMzxz00rX/P0QnGYh88lNDmHgdPesFJysDbiOWjG75diE0vcAvMK4FJJr5zy4w/u3bSkMTBYrxfLYyIpF7Rv3J0bT/BVddzaA7YK7tdOpf5+/GrAm/N6osF5E8p5b0Bd1T3IKWu7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kqq9KQ8R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EkshkgsY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kqq9KQ8R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EkshkgsY"
Message-ID: <4096c8ea58f0ab600b991d8742ed565ab84fb24c.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788862597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67xHPOdRg6Md3IYmYXDCVQ2pUGm9kQLicmtON3YiCpY=;
	b=kqq9KQ8RaeCFpW6Gqyy+RWggJUqmqAwIjhKZVmpeWgLQKIDKXjKe/KtxHfxfI4bpee05jP
	DMyuGAWcuSM5S23LStBlVrN+zGJXrTAJM5bNsx5Wlyvh8MzGtDbmizf6DFnJPyOPBj9mwZ
	/6eB0TgvRWj4rk67Y8GX0/g3P/Bx+WpdB5jraa4HyLI0au0Do0sJDYzotd0fi8YCLSUi9e
	5Y5ObsylCciYP7G6nlosHAkoLiX5RioFQhqDdnxmtfMHKUANSa8zQX0+YHXH/FXW29b59o
	0HWF9/au2Hju3AkOSZKvtyjnlk/rE/LQO6sAmX9W4RezqG3HRwYC0lHQYt4lsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788862597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67xHPOdRg6Md3IYmYXDCVQ2pUGm9kQLicmtON3YiCpY=;
	b=EkshkgsYjeEIHpzUPdBmGY6rSRNKdM9CDsI8tK8lemoCAMIeB34IdxXGRPZJDsyxWmA3zB
	DqFD7aqDIemutCAw==
Subject: Re: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>,
 Benedikt Spranger <b.spranger@linutronix.de>
Date: Tue, 08 Sep 2026 12:16:36 +0200
In-Reply-To: <85b4b052-e97c-40b8-b434-de1b6e3af1b5@lunn.ch>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
	 <20260907-petite-pillbug-from-atlantis-dd3ea4@quoll>
	 <9751fadc03ab555327f5baf1d2adc10821f13b1e.camel@linutronix.de>
	 <85b4b052-e97c-40b8-b434-de1b6e3af1b5@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-07 at 20:56 +0200, Andrew Lunn wrote:
> > > ethernet-ports
> > >=20
> > > > +    patternProperties:
> > > > +      '^(ethernet-)?port@[0-9a-f]+$':
> > >=20
> > > ethernet-port
> > >=20
> >=20
> > Is there a reason for such a restriction?
> > The pattern intentionally follows the generic DSA binding in dsa.yaml,
>=20
> You need to be careful with the DSA binding. It is old, and uses some
> things which are not considered best practices today. But they cannot
> be removed because of backwards compatibility.
>=20

Got it. Technically, it makes no difference, so I will just fix it.

Thanks,
Vasilij
