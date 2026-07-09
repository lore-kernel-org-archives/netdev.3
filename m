Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3954D98EC;
	Thu,  9 Jul 2026 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620522; cv=none; b=b/9ZLGulFkqbcSbDS2HYa8M0r1znK8zHGjkT5fB2mBxJSRAKASBsBzN4JI8uIFMkeAF8JR+JwVb3cwIKCTQRt7gkCYDv51KcjPLH9V/CF8mTjX3CrUw0HkIOhaRJp6XSqXb1/e47auqYfJCwBbAgOzRcr6Bib0c4hZzcC9oOF78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620522; c=relaxed/simple;
	bh=KpMdBg0t63EKF4kzfIo6lKo7mjyYlKdkf1BbKyjJjb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMe2mNCsTQ6DMATn/A3PaymB+ZlIkrgOqwr6oFVCeq+NlrcJGWIAWlVP7lGwbWlIoJt9V/aW79iJ95r5ImQNJgTaEZRk9pSjnagYsMmoXfU09x+32HNj1HwtnNQKKfep+sPRrxrjRvmSjarOAsBt5sxy9lne9GU2fCRWO1GDUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+rj1TPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+rj1TPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4251E1F000E9;
	Thu,  9 Jul 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620520;
	bh=KpMdBg0t63EKF4kzfIo6lKo7mjyYlKdkf1BbKyjJjb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W+rj1TPl91K7+119FECevuFLOiRbrgcbVQD1s8twt7KW/GO0lKiBkvYEousnXc1CH
	 2BPxvEkex3/kJOMcmj0NcXYj1VOdezrGOM/Wgjdln1/mr7g0lsc6UKbU6UnqfeQFx3
	 5z37Xx+RQ1lZE+fy+YO0TK9EkwyZI6jy32DHCygpHAPvGA+BayCRBkVOSshjnDQ7r7
	 IQs8Wymii7Zp/DQsdIM59T4ONrZ6K8gZzAuqyXO8Jv34Q//fv7hTJsb+1Cemp0m7zx
	 1Kb64Z0hcOgX9vP+T7dt4TsIqHXoEYFzEYmohHPp6TjxOQaS3A0EU95l3dinq2Ed12
	 2jfZjqTyrHlGg==
Date: Thu, 9 Jul 2026 19:08:35 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Richard Cochran <richardcochran@gmail.com>, kernel@collabora.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 01/18] dt-bindings: clock: mediatek: Make
 '#clock-cells' required for MT8186
Message-ID: <20260709-clean-sphere-fd769ca48015@spud>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-1-2926da3db6cf@collabora.com>
 <fe7dee8d-afe9-441e-898b-695aacf1aa04@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5zJo2XKDUk4B95UI"
Content-Disposition: inline
In-Reply-To: <fe7dee8d-afe9-441e-898b-695aacf1aa04@collabora.com>

--5zJo2XKDUk4B95UI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 04:01:49PM +0200, AngeloGioacchino Del Regno wrote:
> On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> > Both MT8186 clock controllers dt-bindings (clock and sys-clock)
> > document the '#clock-cells' property but do not enforce it as required
> > property.
> > As clock provider nodes should define this property in devicetrees, add
> > it to the required property list in both its dt-bindings files.
> >=20
> > Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
>=20
> Though you could've done that in one commit, or just skipped the addition=
s in all
> of mt8186/92/95 and went directly for the new one... IMO, it's ok as you'=
re showing
> that there was an actual mistake on the bindings for clock controllers.
>=20
> Same comment applies for patch 2 and 3, btw.
>=20
> Anyway:
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>=20

Prob should have a fixes tag too.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

(sorry if you got this twice, mutt crashed while sending)

--5zJo2XKDUk4B95UI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/jowAKCRB4tDGHoIJi
0qNOAP91iKKhhpgXrRCzsFjML5ImnHOnuqLMoyVV1+9USVf15gEAvSTTG5ZigGyY
hQKGPjuMwYYafVzdOOBrJIzylQJvigw=
=4HEP
-----END PGP SIGNATURE-----

--5zJo2XKDUk4B95UI--
