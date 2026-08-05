Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D33C4B81;
	Wed,  5 Aug 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933657; cv=none; b=GovwOeZIJ4QCLuzChMkle8256bPZ2y19xIzvn9fcctTFRibW7+esqSEEVlezCpmzn5ehQ37pgoJ4gqvRtfVbvgt8tvzJ+MYW6Bi4OZDcz2iHQ4HvpSHkIq/4Nb21oAtNmkYh3GNbRp+k4eHvu9JdZZ/isOnElfLgzlgzTNp0QfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933657; c=relaxed/simple;
	bh=/4JjdIUOqwSKdx2HRE2phUmAHqpH0OUge3ANnybe6Vg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mcrJa436AZ1Ie5rUEP5y4HFCTGyAt3+zJPrW3GJ+EJHyY8mIgl/urj4+qToml31kjBIDsU9kedYDZUCtRWIZlnIYmGkZAi32r8EGqzbzHW2oWL5eA7ybNCYXr7EzjDoa3n2SNUEXj+qQS+dN9/adVQqiEYKARkt5uF8qbN7m/gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EvzDUZ4R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jet6LarR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EvzDUZ4R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jet6LarR"
Message-ID: <54035cef2167d81b43cbdd076b481db31d74e5d4.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785933654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCa2DN71gkUbuF2W0kl1Aec0hZdxjs8p8/AF0f9z9Gs=;
	b=EvzDUZ4Rj6o6qO2MF8Xjx2gxIEdWzEMb/S2tNB6qJy5zzSMYhrFbxeDgbB8w4KEbgVH/x+
	ZQ6O67tWjYCNxryN4cpHOBn5CQdx/lVXjrs2ehnatH9umCDaRALr7I6jpcvmefvtL98PJR
	n0Lw4S2ADDMwHUYfHyZsTl7evuc8j0XvtcN6qf6vmmnRXGPeZfjgGbeZheAg7luSrGEAKx
	rCaREi1ef2LPRPyL4zKCtRrj96H5gCYfNP2vkfzH8CoewCec1aqVAu5Pyir4i/c8CdVp9n
	kiiPVwadQYVxLwFVekzhO7OtUxV4oOSaOVaA0ow8zajIR60SZziJsIS/njxe/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785933654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCa2DN71gkUbuF2W0kl1Aec0hZdxjs8p8/AF0f9z9Gs=;
	b=jet6LarRLAKZ28MC+nWn/CQScq2wBMRbaBxy3h8n7NPoLdACF6W5pqBa8tfiLm3mDFxDx6
	S1DXDtOHKtsG1PAQ==
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean
	 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
	 <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Martin Kaistra
	 <martin.kaistra@linutronix.de>
Date: Wed, 05 Aug 2026 14:40:53 +0200
In-Reply-To: <590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	 <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
	 <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
	 <590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 18:43 +0200, Andrew Lunn wrote:
> > > > +  compatible:
> > > > +    const: soce,switch-dsa
> > >=20
> > > Way too generic. I understand that SoCe will NEVER - and you certify
> > > that - develop a second, different "switch-dsa" model and they call t=
his
> > > one like this?
> >=20
> > It is intentionally generic to cover the common basics of all variants =
and
> > configurations of the synthesized switch in DSA.
> > I'm not sure what kind of guarantee I'm supposed to provide here regard=
ing
> > SoCe. If switch-dsa is already mainline in the future, then a different
> > compatible will be needed for incompatible new models.
>=20
> If it is not compatible, it needs a different compatible.
>=20
> It gets interesting with something you synthesizer, something where
> there are a number of different synthesise options. How do you define
> compatible? You might want a very specific compatible, for your
> synthesise configuration, and a more generic compatible which might
> work for other synthesise configurations, but maybe not?
>=20
Yes, that's not really satisfying.

I will tweak the driver so that it reads as much as possible from
registers. Currently, I'm considering adopting SoC-e IP Core families as
the compatible option. In my case, that would mean soce,mrs. Or if still
too generic something like mrs-switch-v1.0 or mrs-basic.

However, I won't be able to submit a v2 in the next few weeks. Maybe
I (or someone else) will come up with something better by then.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Andrew

Thanks
Vasilij
