Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7FE3101DB;
	Wed, 18 Mar 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855317; cv=none; b=gN2eQd7Up7VSbC3sbTTLrXrnBjbR7Q9d8nFhfrSxBhVlBjKvQkkLeAJUeeVP1RP2tbtxbTT/AkXqHZNp3fAiV3l2FdVcwO06xlc8ax6yJ7Tc75440LvAwUAWkIZf47PlUX2BedpEzgadgynBx0z+60PLD46HDu3R02QtvgFUtXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855317; c=relaxed/simple;
	bh=XMV5inxjfKHIqVPnyCdwg/fTj3Azn9yJnNe7LuS48N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia5TPlwxOfWw/3+vkYHrpq/WjEv/A1uhMu/kDsE/8H5bd0HPS5lvKUEuRiGzXNQUJxou99LfuKRSF4p4aS9r0awwmujR+WazsO83UHa/TW6Ph/l9y0UuI72PYS1ZL9fVi0ODy7nvuQLWlLneoUJo0CpX7aN6EGVbbL5Bo0rnNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMDJvEc9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMDJvEc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D3CC19421;
	Wed, 18 Mar 2026 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773855317;
	bh=XMV5inxjfKHIqVPnyCdwg/fTj3Azn9yJnNe7LuS48N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMDJvEc9eneBZHrpi8WbIrwzhbzxDlOCCstXE7RyyPYs1c5T5VyVoa+8Ed1Trc+cE
	 NUTYzX3iQtw4Uxx1MQd+DP+PzNulWD/x4yqfsXby20opha9QC24sWJuLZViLBolZ9w
	 Ds7t1ra7dcWnr7kJdTfAkc1PqlOvj7YLe8sK5wGVnszwSlscl96oechPj4t4GVlEtl
	 jdKylRXkz2hk6FYz99wmcf/zgRm6rzSQzNPhxFDiLgYbnFOyw/Vdphf3ALYh3znw/r
	 dgH0beGYsJfLMjeLxNuGKLQhVPMFcZMgL8jA686EaCpMbfbH7ENDlvIC4ddjumHkZC
	 S4gfrkmLe3S5g==
Date: Wed, 18 Mar 2026 17:35:11 +0000
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
Message-ID: <20260318-sustained-reshuffle-eaf180729a9c@spud>
References: <cover.1773751309.git.nora.schiffer@ew.tq-group.com>
 <1382fed198246f1563dea091478757aebc4e4948.1773751309.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g8SSq65u6iP4ZaTS"
Content-Disposition: inline
In-Reply-To: <1382fed198246f1563dea091478757aebc4e4948.1773751309.git.nora.schiffer@ew.tq-group.com>


--g8SSq65u6iP4ZaTS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 03:05:25PM +0100, Nora Schiffer wrote:
> The J722S CPSW3G is mostly identical to the AM64's, but additionally
> supports SGMII.
>=20
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.=
yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> index a959c1d7e643a..9ab8237c7f79e 100644
> --- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> @@ -59,6 +59,7 @@ properties:
>        - ti,j7200-cpswxg-nuss
>        - ti,j721e-cpsw-nuss
>        - ti,j721e-cpswxg-nuss
> +      - ti,j722s-cpsw-nuss

For all these bindings, why is a fallback not suitable? Seems like it'd
be possible here, since there's just a new feature. Is there some other
programming model difference?

>        - ti,j784s4-cpswxg-nuss
> =20
>    reg:
> --=20
> TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht M=FCnchen, HRB 105018
> Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
>=20

--g8SSq65u6iP4ZaTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabriTwAKCRB4tDGHoIJi
0rmKAP4oA9ZLXSHHUbsFb5/219KbRXIiAAlbMACiaWPxfR6W7gEA+bHWo2zEutXo
hbEedSyQOaJ/t3Kn1ZHU72wiR4Qnswc=
=lTAy
-----END PGP SIGNATURE-----

--g8SSq65u6iP4ZaTS--
