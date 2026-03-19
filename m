Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D52D4B40;
	Thu, 19 Mar 2026 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931054; cv=none; b=VIlxOq5A9PsWyVnHLxbFgXyPbkHYEAqbIFZqe3Q5yccd5EFPLyS+u00/s51zMgWBvhLe1W+brtN2skQg0JMy4mZUJmkFOy3lJYpEb/g0Mg2AFlXdEcLrEA7v8sDXUfD8pJmruQ8dfY2zFOfRn0DI4kQ7crjkgxFFCvaJElS87SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931054; c=relaxed/simple;
	bh=KLDhtxsHsK8rztqKAtAqMROmIfFr0P5kwaXY6DoAmsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbLrG/UpC3alPPj+5IHAnqZqB+RHJwW23mC5yfK/Mukv/Uj+LbDGOPVKnm4vNyO9h9+EGE9zAqOW5mK9qOwttTXSLpP1UTBlyEiNr1PajKu68L39/IgrZGUxfj0k8Go4DUxpjcUXInW3CdB57Ov/6f9IAkQvCXeGg8SgK6vYU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpRLQu8l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpRLQu8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C01C19424;
	Thu, 19 Mar 2026 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773931054;
	bh=KLDhtxsHsK8rztqKAtAqMROmIfFr0P5kwaXY6DoAmsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpRLQu8lLh5mgVxrGIq5qNOsH7ANyRHYIRnYo1YmESCVUnnBBcCR9Mi0p/tf7XxNs
	 D3LrNInZhWa7j6aLAOqDUqy0HseKeaXPXOASXsuDPisTzcxtZyofvkZHNUWZgfkSvJ
	 PBh23kpF9RDHhRtqv+t4kHkCH7sOtzU4U8dPesWJWHlu66+UjWwAOwYlDz2SHhmI4S
	 qGeKyjJhfMUqpfghEcpQ/qzz3vZFdle7At8qkf9LFCZKRxheQamD6zFkIBD8VViVi1
	 seG/T87aAQWxehb6O3OfoFmaRSvuGiPYGphZd3+5wjxai0kBgrTp7Qe8TiKzmHQU2m
	 YRZN1lMY069Lw==
Date: Thu, 19 Mar 2026 14:37:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH 3/7] dt-bindings: net: ti: k3-am654-cpsw-nuss: Add
 ti,j722s-cpsw-nuss compatible
Message-ID: <20260319-embroider-cloud-0f8b7ea975eb@spud>
References: <cover.1773751309.git.nora.schiffer@ew.tq-group.com>
 <1382fed198246f1563dea091478757aebc4e4948.1773751309.git.nora.schiffer@ew.tq-group.com>
 <20260318-sustained-reshuffle-eaf180729a9c@spud>
 <37396c094c7124169ca376cf6aea5350971aec54.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xd7J1FUbMSfddi+G"
Content-Disposition: inline
In-Reply-To: <37396c094c7124169ca376cf6aea5350971aec54.camel@ew.tq-group.com>


--xd7J1FUbMSfddi+G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 09:55:24AM +0100, Nora Schiffer wrote:
> On Wed, 2026-03-18 at 17:35 +0000, Conor Dooley wrote:
> > On Wed, Mar 18, 2026 at 03:05:25PM +0100, Nora Schiffer wrote:
> > > The J722S CPSW3G is mostly identical to the AM64's, but additionally
> > > supports SGMII.
> > >=20
> > > Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> > > ---
> > >  Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml | 1=
 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-n=
uss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> > > index a959c1d7e643a..9ab8237c7f79e 100644
> > > --- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> > > +++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> > > @@ -59,6 +59,7 @@ properties:
> > >        - ti,j7200-cpswxg-nuss
> > >        - ti,j721e-cpsw-nuss
> > >        - ti,j721e-cpswxg-nuss
> > > +      - ti,j722s-cpsw-nuss
> >=20
> > For all these bindings, why is a fallback not suitable? Seems like it'd
> > be possible here, since there's just a new feature. Is there some other
> > programming model difference?
>=20
> I think a fallback makes sense, I didn't add one because other variants d=
erived
> from the AM64 don't have one either. I can include a fallback in v2 (for =
all 3
> bindings in this series).

Unless someones got a good reason not to, I think you should do so.

--xd7J1FUbMSfddi+G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabwKJwAKCRB4tDGHoIJi
0mZPAQDOmTS3hQH1+4EWz3iVgYp6/DejsN7lwqlJyuo0AsAX4AEApNRPLGqBM0jO
szx8cd91ntJY8h7pt4Fw5f8sH3YbFA8=
=r2h7
-----END PGP SIGNATURE-----

--xd7J1FUbMSfddi+G--
