Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF965334C39;
	Mon, 12 Oct 2026 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832722; cv=none; b=YlV1HUieSw/9O5XSqQpSRXyG9K1eLsyxqYpxHJ6J70NISf2SMNTdrFvF8nY2y34vU+3vzGU38rq3uhUOewfyOpPx0IpTPu1qnNQrEdwj1osw06pVB320Y8bLpLvN/ML+seiiN6kA0s3mEZbCBSM2TsE/e1uU5C1SWdbzijuGLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832722; c=relaxed/simple;
	bh=EdGSXan2vFNReiLol5ph81ITQbqexdPyGuVbHaJySHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyjaPu6LB8H67nlMYyaditjLmNDLBq83ttB8pVW6sXI116d7dq3p9A/j0WqWuIlElrpYIwzt99F7awLAU8DXX/TuTnKsJmR4fQQ8sCSfX4immTKIetJOqShTfCVxjymBjo7p1gv4bLj5raNosJiWd6mqiPZnRUQ+vHeNraEDgNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2ldyTvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2ldyTvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3B31F008A1;
	Mon, 12 Oct 2026 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791832721;
	bh=Lh0EeRUmPO/n2sz7aHLajpNlc62AqgBNQDWR/Mouc3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i2ldyTvkySETYb0S2alZFc5d8JjDLNPi+DhBhyG6YldX02eACwPkuXssIqIMYugyN
	 ZZvT5P6OQ1N9Xadzg3OZhntvoRQ0kf+6PUxFkMDiltOdaaMNN95J5inV2wSlUtnxSH
	 4HU76tzVlXnPfFBTErIYAxTMK757kcnh0d7SErAJNvbEPoGIQPRTNeQ51HcNAC2mg4
	 RUd81Q1pZatSeQk7opR7zRlP3xKcvmXdK45GcZmcr0pMEEAMa86QL5jUVn5Hew9Id9
	 kthkILYOTIOMW089oC9iPcmkTGHR3GaM8IMALDRnowS8BYJzwCU6Fw2GphqcvG22EO
	 kRF1rYYfMR9/A==
Date: Mon, 12 Oct 2026 20:18:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] dt-bindings: net: ethernet-controller: tabulate
 who adds the RGMII delays
Message-ID: <20261012-suds-karaoke-efc4acf056af@spud>
References: <20261010105900.247342-1-tanure@linux.com>
 <20261010105900.247342-9-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZyeABZ831vo0PBfB"
Content-Disposition: inline
In-Reply-To: <20261010105900.247342-9-tanure@linux.com>

--ZyeABZ831vo0PBfB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 11:59:00AM +0100, Lucas Tanure wrote:
> The informative section explains in prose how phy-mode, the delay
> properties in the MAC node and the mode handed to the PHY fit together,
> and says itself that developers often get this wrong. A reader has to
> work through several paragraphs before answering the one question they
> usually have: for this phy-mode and these properties, which part adds
> which delay.
>=20
> Add a table that answers it at a glance, with one row for every
> combination the properties allow.
>=20
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>

If the net guys think this is valuable,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

(although for something like this, us acking probably ain't needed,
ehh?)

> ---
>  .../bindings/net/ethernet-controller.yaml      | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.ya=
ml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 1bafd687dcb1..bba27a9feb61 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -339,6 +339,24 @@ additionalProperties: true
>  # has added. Failure to remove the delay will result in a
>  # non-functioning link.
>  #
> +# Put together, with the two properties in the MAC node, this is who
> +# adds each delay:
> +#
> +#   phy-mode    tx-internal-delay-ps  rx-internal-delay-ps  TX delay    =
RX delay
> +#   rgmii       -                     -                     PCB trace   =
PCB trace
> +#   rgmii-id    -                     -                     PHY         =
PHY
> +#   rgmii-id    present               -                     MAC         =
PHY
> +#   rgmii-id    -                     present               PHY         =
MAC
> +#   rgmii-id    present               present               MAC         =
MAC
> +#   rgmii-txid  -                     -                     PHY         =
PCB trace
> +#   rgmii-txid  present               -                     MAC         =
PCB trace
> +#   rgmii-rxid  -                     -                     PCB trace   =
PHY
> +#   rgmii-rxid  -                     present               PCB trace   =
MAC
> +#
> +# A property for a clock the PCB already delays is not in this table.
> +# It is either the fine tuning described next, or a mistake the MAC
> +# should report as a fatal error.
> +#
>  # Sometimes there is a need to fine tune the delays. Often the MAC or
>  # PHY can perform this fine tuning. In the MAC node, the Device Tree
>  # properties 'rx-internal-delay-ps' and 'tx-internal-delay-ps' should
> --=20
> 2.56.0
>=20

--ZyeABZ831vo0PBfB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0yiwAKCRB4tDGHoIJi
0pqvAPsGoQ0dZuqznMzflFnrJJONMATY3If2+uw3QIz/GHgDxAEA6x8lm1tyHUeS
J/yJwvaHqlB8POud4yNTEmA/S8/ccQs=
=6vsf
-----END PGP SIGNATURE-----

--ZyeABZ831vo0PBfB--
