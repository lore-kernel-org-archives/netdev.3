Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD737F00C;
	Thu, 20 Aug 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251225; cv=none; b=iqmAJ0OUk1Dg10U+dVBDq88/q9O7unIa8YDWvvH+talEroxueYyapOLlpSbAsFlLkIDI7JFTs7370Zpf2A32M8xQKqlPSQOjkWp9uISRGUYw6uCnJAAbrLIHOfanVBZIA0RvhusIgUXoAq2Rf8KJshhFmB3U/s0EnrMgpBTsDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251225; c=relaxed/simple;
	bh=eBajQQr3XtJUEIgMK8c6xu6wWHm6paE+2XWcF49N+oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2sN27V7X/kIBKbjugtkOrPMrbYlcEj1PVg6456v1agFjK46hbW9p3AQj6sEOl7mb7TqNoMYP01YgyJMsLU7fbuSbo/MiNbe18pFA/peaAq0SCxA9xr5YnnEEz+WjNI9pWly1wP4SNttwkPa0jjU+wU5V1+aDSGVcjfsEr3EgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cML5iR4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cML5iR4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C838E1F000E9;
	Thu, 20 Aug 2026 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787251224;
	bh=eBajQQr3XtJUEIgMK8c6xu6wWHm6paE+2XWcF49N+oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cML5iR4jgOvfS/zWAF1OfEjm4wGiOLMEzYjD/MLDQ1kB07DtfzV1gQUptbNMugiWE
	 EInHWfP89fFCxpDDZBUPGO4JuURR8ZJeTnlw0YH0fN+7dW3pYl69Qbr0Ng/Ap7a9CB
	 jQwnMbitCpiIVd4k53WNvWjg8y8h9g10mHGOSCq7eqVqaWr/Xlmk3pjPaphIiKQNg4
	 I4g890VN1sJtL9kmU/iSyWPWAUOTIKuJorWcQ0nQyJXjqmmY0IomoMvBlNo+gVfIKj
	 1mjQtGbsdPzdeJd9nwK/Wv+ZTQYID7JvOxs6kkEY9boXSTY3n9FseBUMn3h/ZPunbP
	 BPe7UPfZPSMqg==
Date: Thu, 20 Aug 2026 19:40:19 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Valerio <pvalerio@redhat.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net] net: macb: drop CONFIG_OF #if block
Message-ID: <20260820-frequency-tadpole-7731df57b8ce@spud>
References: <20260820-macb-fix-x86-v1-1-b2e7c902104e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="We1IMCXtK14c+UmL"
Content-Disposition: inline
In-Reply-To: <20260820-macb-fix-x86-v1-1-b2e7c902104e@bootlin.com>

--We1IMCXtK14c+UmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--We1IMCXtK14c+UmL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaodKEwAKCRB4tDGHoIJi
0kk8AQCnxjtaph+EjKLrV2fav4nWHdUo4KOK+GDRAWhu7Zi5/wEA5Wc0dlALHnLL
uC9bz7+RUlqLVuVkVqVD0dYPeN6yigM=
=IThJ
-----END PGP SIGNATURE-----

--We1IMCXtK14c+UmL--
