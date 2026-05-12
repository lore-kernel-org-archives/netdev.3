Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C73955C1;
	Tue, 12 May 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608023; cv=none; b=kEnjB06KtG9cBma88VGueqIRzB/6kPfx3v8rdsobKkvrsyo4v21dSArGJzSRCSBxv3xSdEVxPUhTBFXs0tf+jp88QnTax0x4WpQnAsY1jHF7KzIm49Fdjia3j/fPOEcogpS5XFxwCgyWzRRovcxm5LayVandm8JT9OdRTsRBE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608023; c=relaxed/simple;
	bh=sGtAqQQeqjqCfMs2ZebjBxH4W0XIyIR5fx+veFR/U9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhjHL5uBmYmi8yuZ8luzX/Tz8WhISJxpbtnnUXW15hvF7sOsGNQ+ZfWqftcbqsLhMjxyO13XVsElyqyK7ZeKYm1NERnM9maDnPK4KC8hS1FpoHIkqLJoztt2GUiyUHJRBj5/4YcM9xcBoGT+hCgbQ05/ikFODaNHVJY3v7Y55Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJA4dmu1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJA4dmu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B76C32781;
	Tue, 12 May 2026 17:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778608023;
	bh=sGtAqQQeqjqCfMs2ZebjBxH4W0XIyIR5fx+veFR/U9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJA4dmu1dI8UNXfvJxMOgOwWuhSZMq3IALeh4DrOPXLUaZn8Mq3Aj54lm3e5Xl89R
	 p+yWPJcyWBIJATRayCVaevBI52vl2GIk+n1b3jgSFNhrnVnt5dyPoRTqJZe5zrMaSJ
	 MCe8Oq9roFAgbaktcYqK+W/gUK0DFCmeHdtmaZOOJ9t7dzlUM5u3ZhhPBCn759dVRJ
	 cJdhUEzfAv6LEw+AFZnYzNZ5KNu3LjG7qZOuRvVT1hMXZTuvinKujRMweH+Pc4GdY6
	 4k0irN21Kkf3sN+XpAJuUArOYkwjGctOVSmq8NpZfIwFHz2S5qxSKfE7vwMBoPMgEd
	 J7j0kqcuvhRuw==
Date: Tue, 12 May 2026 18:46:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Ali Rouhi <rouhi.ali@gmail.com>
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cjubran@nvidia.com,
	Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ali Rouhi <arouhi@sitime.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Message-ID: <20260512-superbowl-throwing-7bf5d5f6fc14@spud>
References: <20260511211143.19792-1-arouhi@sitime.com>
 <20260511211143.19792-2-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="08Hp85XJnEm2J6xW"
Content-Disposition: inline
In-Reply-To: <20260511211143.19792-2-arouhi@sitime.com>


--08Hp85XJnEm2J6xW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--08Hp85XJnEm2J6xW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagNnkgAKCRB4tDGHoIJi
0lcsAQDdyyal1Gv7glGAoksHgOrFCNt6yB3qx2lzBAx1hUVSQAD9EuDdpP3+RVt7
T89M4/TLwsuSm1cDZ+JPvgiB6SMr/As=
=m15i
-----END PGP SIGNATURE-----

--08Hp85XJnEm2J6xW--
