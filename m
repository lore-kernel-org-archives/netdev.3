Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB073C4B81;
	Wed,  5 Aug 2026 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935847; cv=none; b=cL1fVD+nsOPsovRZzucAaC4ET/GDMwCZhI0mCDly4GomXUaT8vCtPmOdUvp8dZiYhFyRKlFUMD1UXRr7q8hJmbNj770r9gMnajqheCMHKEYcta4DyhJlU5i6C4RsDrtIaojZXUeoA1ffUyksLkXO8QxfRZMlAQ/40NeY01VXgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935847; c=relaxed/simple;
	bh=KgrRgFuxpHuc+XuNh03ymokTyYvaItWQnD2grhApHUQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MpYrGYdMvcwdrmrpXyLSlK2Qho1GDcZGpMJ9p3FOuOTJs4XN4WBKjh7fj9//jvI7ElVzdXKwN8CatUODX3awrVE+78MpUV7jCKRZ+tdD1rjI483k/IBiwQQmSsOMu0Y1WEUs12yQjVO0M8913jYEeLY2v7jjCCk2rAQ2/k4OmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QO1n8ZhF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7mtACkWV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QO1n8ZhF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7mtACkWV"
Message-ID: <f8508a90ef48a95ccd8ece00a096d56587b3292c.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785935844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+KRRDq0JofvNEGAN8O3OnxkHjDh7F2TElpmp0ocVXE=;
	b=QO1n8ZhFYSwLa9+D/PP2lBcH1F3555OKSuQgHGU0gqtYoocb1A5k/pRmb9TWprPrzwXgeN
	W5TCvIG4lsF0DBXsGgxNw8MOoYeUjRrfbhkXmR0MxZjN82aOLvAK+4JuCPeBT1Q65kTx7m
	zb19ud2htwxC+AFSjoZeQ9qucEP8en2w6VB9W/N68dntwmR9UfwjJOevjpfFBwukPglCtE
	rQDJR0SvTtuVe93E0Az2ta86dJ1SGlMTplDrleZCrFeeu46PXiDONEw4QyWI4UxOXy4Bgr
	dJZJADcsHJTNcAXAZdeRJmuUKLmpJMvwhYUTulM8LOV3jbQj21+T3mCUW4pNDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785935844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+KRRDq0JofvNEGAN8O3OnxkHjDh7F2TElpmp0ocVXE=;
	b=7mtACkWVp1vQseLBZCypYAdp7zIEj+1K8lmNeSnqijFH1wd2CAwxw41rTIXggVn6YVj5ko
	5rHTi5oVfsrEdiBw==
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
Date: Wed, 05 Aug 2026 15:17:23 +0200
In-Reply-To: <a60a207e-51ff-4332-b578-fbf032b8adfc@lunn.ch>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	 <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
	 <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
	 <590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
	 <54035cef2167d81b43cbdd076b481db31d74e5d4.camel@linutronix.de>
	 <a60a207e-51ff-4332-b578-fbf032b8adfc@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 14:53 +0200, Andrew Lunn wrote:
> On Wed, Aug 05, 2026 at 02:40:53PM +0200, Vasilij Strassheim wrote:
> > On Mon, 2026-08-03 at 18:43 +0200, Andrew Lunn wrote:
> > > > > > +  compatible:
> > > > > > +    const: soce,switch-dsa
> > > > >=20
> > > > > Way too generic. I understand that SoCe will NEVER - and you cert=
ify
> > > > > that - develop a second, different "switch-dsa" model and they ca=
ll this
> > > > > one like this?
> > > >=20
> > > > It is intentionally generic to cover the common basics of all varia=
nts and
> > > > configurations of the synthesized switch in DSA.
> > > > I'm not sure what kind of guarantee I'm supposed to provide here re=
garding
> > > > SoCe. If switch-dsa is already mainline in the future, then a diffe=
rent
> > > > compatible will be needed for incompatible new models.
> > >=20
> > > If it is not compatible, it needs a different compatible.
> > >=20
> > > It gets interesting with something you synthesizer, something where
> > > there are a number of different synthesise options. How do you define
> > > compatible? You might want a very specific compatible, for your
> > > synthesise configuration, and a more generic compatible which might
> > > work for other synthesise configurations, but maybe not?
> > >=20
> > Yes, that's not really satisfying.
>=20
> That is the problem with FPGAs and jellyware.
>=20
> > I will tweak the driver so that it reads as much as possible from
> > registers. Currently, I'm considering adopting SoC-e IP Core families a=
s
> > the compatible option.
>=20
> I would probably make that the fallback.
>=20
> Maybe look around at how IP licensed from Synopsys and other vendors
> of IP cores work. It is slightly different use case in that these are
> generally integrated into silicon, so are fixed, but the chip vendor
> often puts logic around the licensed core which needs driving, and
> they sometimes integrate the core wrongly, so need workarounds. So you
> often have a compatible for the specific vendors overall integration,
> and a fallback compatible for the IP core version.
>=20
> I would suggest something similar here, compatibles for each SoC-e IP
> core version, plus a compatible for your specific device.

I've seen something similar on Cadence macb as well. =E2=80=9Ccdns,gem=E2=
=80=9D is
commented as #Generic there, but I wasn't sure where that came from. In
this case, it must be such a fallback. Thanks for the explanation, I
will take that into account for the new version.


Vasilij
