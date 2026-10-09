Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8896521232;
	Fri,  9 Oct 2026 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571331; cv=none; b=sbTAe1SACCChsYSsKmWT6Yeru1ruosHAWpsRhYN17oBI5y8pAOvZFxiVJ4WELe2s9WLylqS/7S4X/2x8FRaB9CfeCvihJzh4WcV/JVG4V08ZbrGkwx1farhLgbKmSoaO3knOmFhtjduBdSKv2wkdekL+X+q0UQyqO651RhvFkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571331; c=relaxed/simple;
	bh=yhwOZtaZ2DmuYUnrRLMYBf6IDOEQdEF7UGiezAY+WR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0DaOHpukY25mM/N09iUS8gPVlhSxBaobvwlnqNKZfdbacPSPlvVIJlv32uiHmf2UUcK+vemDxNSul80UnLH7S8L5MLCmowm5pwgLBi6xXSb5t2HzGGmZ9G6QlSdqAoTwgsI8a0iZAgSVQzaKAdIqL0iA6VCfCAywE6bk7DUMDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrXBvdbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrXBvdbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3041F000FF;
	Fri,  9 Oct 2026 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791571322;
	bh=yhwOZtaZ2DmuYUnrRLMYBf6IDOEQdEF7UGiezAY+WR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZrXBvdbgjPSc+ivm5N+7fuhl/5O/08j5IfvYPfFBuW7NsXr/i3j1YfkMdHQ2YdYgK
	 zL/MdgudxTBC+/n8LiTIzix76A/6mrvx9T/i4VkwvTgWUZOUh2/gYF6pmnWhsAmjPk
	 t65A97qkswSsjeJ2Z1iteohA9VFcD/MJfiLDkobozcUFiYoGNAshu6HXi4bj+0RkJa
	 CVu9Lk9E2P72TufGD0gqFz5POHF9CCIi32RT06YOliTLGD7tTesV7QXChOxYaJ1hMv
	 PUxgsH8ZXvcLMNczL+RTXq0m8P4gJDH5R0kVmbkcefIVBbJ32D/ue3OMT/jKnAiIT3
	 oiXs4/MS8/XkA==
Date: Fri, 9 Oct 2026 19:41:52 +0100
From: Conor Dooley <conor@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: motorcomm: Add YT861x
 PHY compatible
Message-ID: <20261009-80ca08e94d08bf560a6cad30@squawk>
References: <20261009175936.428256-1-mmyangfl@gmail.com>
 <20261009175936.428256-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qLV4+j6lTkuRPTvw"
Content-Disposition: inline
In-Reply-To: <20261009175936.428256-2-mmyangfl@gmail.com>

--qLV4+j6lTkuRPTvw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--qLV4+j6lTkuRPTvw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCask1bQAKCRB4tDGHoIJi
0mwsAP9nunZB8H4JDlYMdQPHosLlZKU/jmwNirRQHBW9yUqEAwEAzEW/oFmAcjiU
wzJkdMkTup41+mi2JHxEPTAkg3SxzAo=
=UiJB
-----END PGP SIGNATURE-----

--qLV4+j6lTkuRPTvw--
