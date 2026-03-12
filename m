Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5093FE36C;
	Thu, 12 Mar 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336906; cv=none; b=MHLv7bDRfiyT/g/6C0wM9xRZ/FAPI5mCRgxVIUENloxZZePaH/sdaY1NDhvZIMpCrV+4ty6CXwFdR5+mLe9WrR+N3hUaiSJjG/riePGbauHz9rGIJMKzKEnO0ruP6i1POmNF4LALHhL+TyumrJLaWGTCeGEBtql3SHEHDLnmGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336906; c=relaxed/simple;
	bh=Q1PPWllutRPLk8fzHPK3uPvbMq4Tk5Wm5Q43B0WL0Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YthotIMdGaI3O0urltr+XgZcvxgh1ze25jGYmb9T3KqGwfKOimbkB9HRBROJIWWLt3+NlDT2vluB7jzk8JWq0K7NYSg+JUJa0Tiowm/10KONswsve+gln8jRWueSKZ4BuIycGobU/JNJnHnDgI3fPqY1VCU5rracBZ6kRLb7cz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6AOXd19; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6AOXd19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C127C4CEF7;
	Thu, 12 Mar 2026 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773336906;
	bh=Q1PPWllutRPLk8fzHPK3uPvbMq4Tk5Wm5Q43B0WL0Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6AOXd192XlW6z+cCcSLLumgi/pGNge61UuSDckIBo2ZllyvUe6aZ30aHxZYiBndf
	 oLe6VMymY0KlzpxntwxliJ8qR+PROLnU1eMrbbjflNbedWCA4T0Mb/pnqXK+jFWHPq
	 gnQwLDOY7BXWlMI4mOuKChUTrr3hwI8CMeAU75Fl95G6gWX7uB0GRM9fNTk1WnZMDj
	 lQCGC99j1zAjf3pPAuQyStd4dzuzbv7+NIv7CxIEf+c469TZL3JHHAFWkAcrugQGir
	 HIRDpc/NG/W9ChY9809cGkRg/5NCjzHJweFAHgNmFrFWnrbeQyAFzpFVvjTKs4gjcv
	 cqH2mzQOdNZ9g==
Date: Thu, 12 Mar 2026 17:35:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Stefan Eichenberger <eichest@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: micrel: Sort lists
Message-ID: <20260312-audacious-sarcastic-2b3a1e168f47@spud>
References: <cover.1773321267.git.geert+renesas@glider.be>
 <013afe74bef9a4d4af8b5a204cb4891518f7274d.1773321267.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1CbzxN7yfQRuiYPv"
Content-Disposition: inline
In-Reply-To: <013afe74bef9a4d4af8b5a204cb4891518f7274d.1773321267.git.geert+renesas@glider.be>


--1CbzxN7yfQRuiYPv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--1CbzxN7yfQRuiYPv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabL5RQAKCRB4tDGHoIJi
0jGKAP9gk68Hzp1CrArAUtK59vYBPfVTqI0kIcsXvnYZChh/9wD+IFlgPfd5Z3Eg
y+ENfvwWY+OegWiDkW/DsmkG5mXdEwQ=
=1iYl
-----END PGP SIGNATURE-----

--1CbzxN7yfQRuiYPv--
