Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923F4EE842;
	Tue,  8 Sep 2026 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862179; cv=none; b=iyt7H5VNVSTwqoe5yhsxeXdBPyhGbcbXShk5cu7JQLOhVRIuKkbc1LfZrUcSGTISc97w1uu4o+V4reJTdJ/o6FhkqjjbNvDdEMB+WDElUBvXX+RcVT27HP4ELpDdEXBgorqD2WdmZ/NjKmpEckvZ+ycIaOdmsSMP8Sox9EUFgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862179; c=relaxed/simple;
	bh=jSh5+jm3H/Jo4Rqy338g389lcdURdakU3FgkslXJk7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UB1wsL/O7dZesKuExBQR7xxpJACqHM/hDsqxW6pj3N85DreuB8Y9tQi+JOCPVLiMKkJIVAuEQJK8qsSK+n851tpznFQXtSnf2FWv1bjoXcPD6tVgR7Hjw1IPKHZy86XqmkeFW/2t+hIsfukhbMYztPb3gUFMKcuFDfy4KJhcJgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o7IZ1hrJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6orGnAmv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o7IZ1hrJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6orGnAmv"
Message-ID: <fffb09cb0368c3bfba971e30d6ed7d852f808f8f.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788862175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLNIi7aDAfqwDaE8H7quXfQJ3kQz2tNUviBQgdf9gzI=;
	b=o7IZ1hrJjDQugeaWmV0W5iSnFsQtWs4GD2ChBI2A+YBKz24h/ks5MbWv8WYBkCLO6BgWsx
	hH2xXlhF2c/0CkGE4KA1dqKICWs1vwTaJJEXXG1LSEE8grAVKQzEzDh2yOx/xHgTEfvcFo
	j1/Y+CEukGRI4VHr5N7hMa82SQOjY6nDrEkY+vWtn/XNPRLgeTA/Bf1iTFDSVW/4YwaLyJ
	fIqihCPOFuLCU2ZaZMqnE2HZcqQ0KbcwqlkABfCgbz1FOXXpubRv6Nb1OGgtdsvK2UslKt
	6I56hwB0Bm3A3n3bbXmefeNvuCe0sbzdFK5IBCF0sJ92hxLRcNt+NGRya1mBwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788862175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLNIi7aDAfqwDaE8H7quXfQJ3kQz2tNUviBQgdf9gzI=;
	b=6orGnAmvw/C60K9YVRkePlL+87NYbY6AycYjLpa8zmczL9HERqSl0+i7vXypCPOroLHH0U
	8IvSEs820Mdv0VCw==
Subject: Re: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Tue, 08 Sep 2026 12:09:34 +0200
In-Reply-To: <20260908-psychedelic-jolly-kestrel-a743af@quoll>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
	 <20260907-petite-pillbug-from-atlantis-dd3ea4@quoll>
	 <9751fadc03ab555327f5baf1d2adc10821f13b1e.camel@linutronix.de>
	 <20260908-psychedelic-jolly-kestrel-a743af@quoll>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-08 at 11:14 +0200, Krzysztof Kozlowski wrote:
> On Mon, Sep 07, 2026 at 04:01:26PM +0200, Vasilij Strassheim wrote:
> > > > +patternProperties:
> > > > +  '^(ethernet-)?ports$':
> > >=20
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
> dsa.yaml lists ethernet-ports and port.
>=20
> > which permits both ports/port@N and ethernet-ports/ethernet-port@N. The
> > device-specific pattern is needed here to apply the SoC-e port
> > constraints to both accepted node naming variants.
>=20
> ports is legacy (because it conflicts with graph ports), for existing
> users, so why insisting on this pattern? If legacy is being added to new
> schemas, when are we going to be able to remove that legacy? Never.
>=20

I will use ethernet-ports and ethernet-port@N instead.

Thanks for the clarification!
I was not insisting on the pattern, just wanted to understand the
reasoning behind it. I had missed that ports is legacy and followed the
generic DSA pattern and the same 10-month-old pattern in Lantiq binding.
Now I see that it is used for compatibility there and should not be
introduced in new bindings.

Best regards,
Vasilij

