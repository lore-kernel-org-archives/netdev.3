Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EC9321420;
	Wed, 24 Jun 2026 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319105; cv=none; b=XwZU7qHeKBb8zgBeUN2pfCganrw7vTy7W7UlJOyCtS32cUZW9Bx4PcXMmOvUgzTZ9ZAklmVNXMQCeubWaB1icl7jzLYa3rd2npWmLGV2TVqiE5V6aIh/bcJHqRgu/XKXyRs2dMRXVJC3XGriO2vDZamVVb2lVUu+wgtxb8Xsk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319105; c=relaxed/simple;
	bh=jtzma8Eb9XfPXbe2dBVNBlyo14y6UPFgmAl2YrolG6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olr5e7Sa3pb6ZsMuEYZtZMc7L5nG5Vq23wJW6DpRw3SPzR7BsE7wROxQuXAzX/Lw88G5wlKerJ63PD+/MdBjxTXhxoR7L0HB//PkLsFbPbI58RjDejisrAwiLkFAZAy4yqDt6Jy4Ue82xNnPXvn57mZhKYnRYIpT7WJtqLBAdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3+RMsXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3+RMsXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D401F000E9;
	Wed, 24 Jun 2026 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782319104;
	bh=jtzma8Eb9XfPXbe2dBVNBlyo14y6UPFgmAl2YrolG6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M3+RMsXGxy9MfIN0styqm9nexv+nQcmVqezf5Mq+kMqmlynqSMWHpA8iazkIcp0pr
	 aeq/06oG4bOll5SXL/2oC9FfBZ4UY3iw+nqT41ox5bRL47TVGXctOVlzbJDza0HMa3
	 x9LPeUutiql+nvga5HEbwQs2VPOWiCZceecpy4v6AoNvKhSRp0W2yLdSTmCbFumebP
	 Dsx6HvuJbJSHZC9JwYUy0wfs1bLE67IRxRhHvlVWPE9JSL3zu7iCxrgCBr/HnLwic9
	 12cGMZR13B+PVEwnPEBBYaQdxXG28TjvHgTTbz+AZOtJ/rOBRT7ABYISczq3ZNUcXX
	 uwaa2ReysnKjw==
Date: Wed, 24 Jun 2026 17:38:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Yanan He <grumpycat921013@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/7] dt-bindings: vendor-prefixes: add alientek
Message-ID: <20260624-delicate-enlarged-3e4660bfcdde@spud>
References: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
 <20260624-rv1126-alientek-dlrv1126-v1-1-5aef608a3f64@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VpyKwcKucZTGoFI6"
Content-Disposition: inline
In-Reply-To: <20260624-rv1126-alientek-dlrv1126-v1-1-5aef608a3f64@gmail.com>


--VpyKwcKucZTGoFI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--VpyKwcKucZTGoFI6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajwH+gAKCRB4tDGHoIJi
0kWYAP4/aniXHpvabONsZUDIHprRVCgKdh+sVH35m94DxiuShAD8Djb6y9Q/yDl9
DzbdhdO2NLTp0CXnWQgslx556IuVlQA=
=Ptp6
-----END PGP SIGNATURE-----

--VpyKwcKucZTGoFI6--
