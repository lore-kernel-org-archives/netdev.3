Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A846F480;
	Wed,  5 Aug 2026 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935022; cv=none; b=KZnRqUmZMp9jlrsGHam8xKp9R7pGPwN/OMfeiJ/eTcwk80HtWKbAOYvd+bGbs6tyU3/9kORWxWEsA6YhYwZhf5yIxpB2iypsFOl2To8yk1FpHe6n9BUCAdkdl50VRmzJmHd8Rgy3U9ITGitmZL74mFlqdSTZ3z5YX0jugXBLdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935022; c=relaxed/simple;
	bh=CmhzK8f7jTERlsXgrosoh4Xxb6XQlUqSzOcfz493/2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ijqi7uU7M/UMvsc4UarMigpYdoRVflK1TLUvC9F3PqMj0l4ITzMfCum8wc0xogSAEtNb2+yrLIpOtoAf+dz/T5OlmG1H18lQkP/AxPiUQYTV8fWr30OsoZwpsQor9NzXXyEe8rICXO2JlRR536LXv3yd6K6qlrSivBZ98fzGkR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hF0qV4na; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eOeijInh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hF0qV4na";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eOeijInh"
Message-ID: <852a08e0723b03977b8ab255671b2fb52f643c50.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785935013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzUMMreM0sLkjDQl7tX4hz6OauOIvWzk9kEl6byrcjA=;
	b=hF0qV4naZUp/eNTZYld5+YX0wi4hkwpdHU1jLFb+6MRx/kJHVxCxbOZkz5Vrs9Q2As7Fg5
	bxxu7Pxd2JpJ9wROAmTioCfyaRC1SVuHgFVH+C2EJwOOCqFaXrDIvVzZanOij542e0mEP3
	ks+zHTVIiLPWst1tlNOOxN5h/Y3J6XNlTPZHAhahe9wIN0xpURYkjFpWfllxFb3xvmhbj6
	1lovXnSC3loxWmr3cqgjQh7Xpn1j3hbD3eI1JEQFy80j4Fq9y7vjXer4y6KbrhL6W0YHOf
	0y5d959I1JAnUVgKM7mFH5bnZ+3tjZWzqdTh2VhD8679/zhtcGxpCF8vvGAkpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785935013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzUMMreM0sLkjDQl7tX4hz6OauOIvWzk9kEl6byrcjA=;
	b=eOeijInhhFZnSyl3faK1XIxD7WJM4L4MqT8keSy4PkDz8HsvSRp6r7f20/OGKNv6wcCe7S
	5yLx36ByY3g1ylBQ==
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>
Date: Wed, 05 Aug 2026 15:03:32 +0200
In-Reply-To: <60ef0086-6137-4e8c-b61b-64e3c833893d@kernel.org>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	 <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
	 <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
	 <60ef0086-6137-4e8c-b61b-64e3c833893d@kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 08:25 +0200, Krzysztof Kozlowski wrote:
> On 03/08/2026 18:15, Vasilij Strassheim wrote:
> > On Thu, 2026-07-30 at 10:56 +0200, Krzysztof Kozlowski wrote:
> > > On Wed, Jul 29, 2026 at 06:36:55PM +0200, Vasilij Strassheim wrote:
> > > > Add DT schema documentation for SoC-e FPGA switch devices.
> > > > The binding is split into:
> > > >  - a switch IP node describing the MMIO register block
> > > >  - a DSA MDIO node describing the DSA-facing switch instance
> > > > Both nodes are linked through the soce,switch-ip phandle.
> > > >=20
> > > > Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> > > > ---
> > > >  .../bindings/net/dsa/soce,switch-dsa.yaml          | 195 +++++++++=
++++++++++++
> > > >  .../bindings/net/dsa/soce,switch-ip.yaml           |  54 ++++++
> > > >  2 files changed, 249 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/net/dsa/soce,switch-=
dsa.yaml b/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml
> > > > new file mode 100644
> > > > index 000000000000..a04e2838d14e
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yam=
l
> > >=20
[...]
> > > > +
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
>=20
> Compatible must not be generic, as expressed hundreds times and
> documented in writing bindings.

I probably misunderstood a few concepts around bindings, and I apologize
for that. For the next version, I would base it on the existing SoC-e IP
core families. Single DT binding file should then be sufficient.

I think a suitable filename would be something like soce,switch.yaml. That'=
s
roughly in line with the existing nxp,netc-switch.yaml.
Or soce,swip.yaml, as in lantiq,gswip.yaml.

>=20
> > I'm not sure what kind of guarantee I'm supposed to provide here regard=
ing
> > SoCe. If switch-dsa is already mainline in the future, then a different
> > compatible will be needed for incompatible new models.
>=20
> I also don't know what guarantee you must provide, it's you who wants to
> add an exception.

Okay, there's no need to make an exception for this case, I will change
the compatible to something suitable.

I also understand now, that the DT bindings are not necessarily used
only in Linux. However, I would like to use them for the DSA driver of the
Soft IP Core Switch. The driver can be adapted so that it reads a
wide variety of configurations and versions from the synthesized switch
and deal with them without any additional properties.

Would =E2=80=9Csoce,mrs=E2=80=9D be suitable as =E2=80=9Ccompatible=E2=80=
=9D in this case? If that's
still too generic maybe =E2=80=9Csoce,mrs-switch-v1.0=E2=80=9D
I will think more about it in the next few weeks, before I submit the
new version. Would be happy to hear any better suggestions that you, or
someone else, might have.

> ...
>=20
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    switch_ip: switch@80020000 {
> > >=20
> > > ethernet-switch
> > >=20
> > > And drop unused label.
> >=20
> > I will adjust it.
> >=20
> > >=20
> > > Considering this wasn't tested I should not even give here review...
> > >=20
> > Thank you very much for the review!
> > I'm not sure what you mean by not tested. I ran make dt_binding_check` =
few
> > times, but forgot to do it after making the latest adjustments.
>=20
> Untested as it has an obvious failure as reported by bot.

I know better now, that should not happen again in the future.

>=20
> Best regards,
> Krzysztof

Thanks,
Vasilij

