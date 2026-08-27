Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD53B9617;
	Thu, 27 Aug 2026 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817867; cv=none; b=t1lh55Hq/R2xGyf8t75GEVsR7pMz/9XlCtTn5sCdoBrzBVb75bGiTLGq7K7CYoXtVMpnv1223ZG7qmEWP4HeZw+5vJetrTann4Wu1ixd8bjz6U5T/at7ulr1ntSF7oh3ZmPX6pP12xEF/1FuJIbLw9r6ttylGH2AGPk85BBzxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817867; c=relaxed/simple;
	bh=SNyRT5rxQCCe6lGK+DFiDOerNMLATPQpc/CAw0TIWBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vDpq37WTosnJxhR355OGyDpob1E+d+0+kOJWoBH6coydrT3TxRoU5ezxys2OW2ctlZMjnSdDN08aHo4sRWnhz8wV4Q8aEaBzcc11mJz7Wt1k+ybscBX6bdaqEfwO8vFeOlYJSzYSKaUljjXbvq7wl+KO7/utxwpG7Zv7kww8kb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 13989202200;
	Thu, 27 Aug 2026 10:04:12 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1wzV5n-003ZJW-32;
	Thu, 27 Aug 2026 10:04:12 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Andrew Davis <afd@ti.com>,  Andrew Lunn
 <andrew@lunn.ch>,  Heiner Kallweit <hkallweit1@gmail.com>,  Russell King
 <linux@armlinux.org.uk>,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: dp83867: add binding for
 output-impedance
In-Reply-To: <20260826-salutary-skype-524c69932dc2@spud> (Conor Dooley's
	message of "Wed, 26 Aug 2026 17:01:26 +0100")
References: <20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de>
	<20260826-v7-2-topic-dp83867-v2-2-a97b4cec6e93@pengutronix.de>
	<20260826-salutary-skype-524c69932dc2@spud>
User-Agent: mu4e 1.14.3; emacs 30.2
Date: Thu, 27 Aug 2026 10:04:07 +0200
Message-ID: <87ik4wgfbc.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed

On 2026-08-26 at 17:01 +01, Conor Dooley <conor@kernel.org> wrote:

> On Wed, Aug 26, 2026 at 02:48:40PM +0200, Steffen Trumtrar wrote:
> > Currently, the output-impedance can only be set to default, minimum or
> > maximum or via a nvmem cell.
> > In cases where there is no backend for a nvmem cell, a value can not be
> > set.
> > 
> > Add a DT binding, 'ti,output-impedance-ohms', for specifying the
> > output-impedance via a fixed value. The existing boolean values for
> > minimum and maximum still take precedence over the new value.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/net/ti,dp83867.yaml | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > index 7a6fe516bab27..49fafe3ce6f47 100644
> > --- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > +++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > @@ -38,6 +38,16 @@ properties:
> >      items:
> >        - const: io_impedance_ctrl
> >  
> > +  ti,output-impedance-ohms:
> > +    description: |
> > +      MAC Interface Impedance control to set the programmable output impedance.
> > +      Valid range is 0x00 to 0x1f (32 steps).
> > +      - 0x1f = 35 ohms (minimum impedance)
> > +      - 0x00 = 70 ohms (maximum impedance)
> > +      - Step size varies with process.
> > +    minimum: 0
> > +    maximum: 31
> 
> Your property is named in ohms, but not implemented in ohms.

So without the -ohms?

> pw-bot: changes-requested
> 
> Can't you just achieve the same result using the existing max property?

The max property is a boolean which just says "use 70ohms".

> I don't get the use case where you specify a max, but then don't want to
> use that max. Just set the max to what you actually want?

That's why I added the exclusion in the binding, because having nvmem-cells and/or any of the other output-impedance bindings doesn't make any sense.

Best regards,
Steffen

-- 
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJAEARYKADgWIQQkoXgOFUjwSVmWFAoavSByCl5WIgUCao/vdxoccy50cnVtdHJh
ckBwZW5ndXRyb25peC5kZQAKCRAavSByCl5WItC/AQD1VMwEkHhE52B58HmnCX+b
wCkD46VgGZCu2CgbHn2j2wEA8NSy176kK7DWYdHnOtnWGgxAiFb0WzEbthvpscfI
/Ak=
=VG6h
-----END PGP SIGNATURE-----
--=-=-=--
