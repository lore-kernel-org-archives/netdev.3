Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0547A86C;
	Mon,  5 Oct 2026 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197987; cv=none; b=cs3YX0l9KfqSmCRlLWqVHMurweoVYq8PpOBqNwe4DuhuZIQF9g5H09Hpw/kg7lP4hUERotXU4bPk++UvGGBO0cuotcNiYGPudDYwv2wrnVvNZ/pf/njyNjghofBPga4iHWRf85lfO83LMXkp1UnIayzZG/XcATe0N1Py1mNKdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197987; c=relaxed/simple;
	bh=klHMTidyWvr950HWXgRt7Kc6LZdPfvDM6CKe1dvvDxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry7XbVaYxwGzpWdJ2iTYwwnj4VloRyXjdc2XcKqZ28d7u9kNnRGnR/gsE/Gp3j2yy69nOHO2XPAoRySHuuMhUtrGKET4TUzklMrjhfd8xGLikXMxxNGHyVnr6hs1pqekIl0MvpbLDrolqafQdM+SZLIDEDiELczNlsddFK0lNHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGf17yuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGf17yuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE351F00893;
	Mon,  5 Oct 2026 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197983;
	bh=klHMTidyWvr950HWXgRt7Kc6LZdPfvDM6CKe1dvvDxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VGf17yuC3a0HaKxZNxxPTpIzEZyBJv1QVV6onyirwO/UvLE7W2x0MR8f1v7n3hLr+
	 ziNbjjFciIsYQXqw7oVBGZ5qH0pGia9t87ZCeXvIbWhVMymVJkqFiU9ME4NpQfuKkK
	 ZK2VrbKEqsl3JAtYEBOluliO3szirGJkcop2xO/at0EGEEooLR2Qt1UHi4E1icr6mf
	 RvrPtmBmEDYaUJF8Hp5q34l9hLmXlPCBqCHLPoo+yo7wuoc7Ec8hn2ENcN+ugY25Xl
	 VMKdOOSd5KFafhMLken6sZE/BdR+ip04wcLRUnCAbG17DqtH/2uTHdHphiEa7KuOWU
	 ilDOwXQiD5dWQ==
Date: Mon, 5 Oct 2026 11:59:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/5] dt-bindings: net: realtek,rtl9301-mdio:
 add clock-frequency
Message-ID: <asODGg2OHG-GBe8D@squawk>
References: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
 <20261005074908.1273383-3-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VBRsa+9rO53ariL2"
Content-Disposition: inline
In-Reply-To: <20261005074908.1273383-3-markus.stockhausen@gmx.de>

--VBRsa+9rO53ariL2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--VBRsa+9rO53ariL2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasODGgAKCRB4tDGHoIJi
0pSKAP989QQATaBFuqndp6iaB7uoLjaY53BmQx9GaAFczMTqnAD/fv/NtRsyO06a
huXYsLagDBZUIOm8zagQ50ksyzkTJAQ=
=X98y
-----END PGP SIGNATURE-----

--VBRsa+9rO53ariL2--
