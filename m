Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59F5369D69;
	Tue,  2 Jun 2026 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417791; cv=none; b=e9b0Z1LqgOZfYYtbY68nCi1iPZDZOYmVuiOnZugKwQJs195+3l0w6bKHc/2n2SkNoi4bjVONY15qWBTWCPgQD8fbTW9FcX0RLVJexvqqzTnuUH6Yd0dNIF23jbClEJoZUFJAj1TrN4C/Mah58J9Zv6YIuYNNIhnURL/tJjxwvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417791; c=relaxed/simple;
	bh=Iwwa+VVmvyGiVwh31hEABrFsx1NgdOVJoM7W/jBxKWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQXeZZjE+A9PvZV7xmpmaqHb94x5HB7Nm3stnsu+aTPFkzyTXDABBIYFSANajhZdXfc7GEG5+kPjM121aBY/6Kv7oJO0TO38AfzP0NpBTJWgCct02SCVW+ppCQy3b8Yzl5DuPlIx6ZMZP3Wf6o/7HILiuuysDXn0M3uKuI2dcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpmrazF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpmrazF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59F11F00893;
	Tue,  2 Jun 2026 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417789;
	bh=Iwwa+VVmvyGiVwh31hEABrFsx1NgdOVJoM7W/jBxKWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QpmrazF1jwr8/KnKU+kSTacId2nPTytKe59qSPt1dD0lXlthmmXc63t+ITAfdT6oM
	 2fZ5V1Zczhv3wc5wouy5SqpLnFIxHXrfiBDTrtdfyd6yl5G0u7zf6wIXEpzRC58NXy
	 TPdmj+2Ji8FiJlim21BpeR1upRjvlYQmrjo0kTDAXatX/t3T/7J2ExE3WP8/dqKqas
	 z6QSotokAqsrO9c46MiGCaHyCt9TvdMiujMtZZxGtVE47uIvPgJLNziFodSpYvo7Op
	 VtLMzrJXZDLECElkaCl7pwySa/pAs9oWpAdEUwRn1ffCm8XON9uH5gTlxV93lLdKkX
	 Q/yw6U7+Jw9Vw==
Date: Tue, 2 Jun 2026 17:29:43 +0100
From: Conor Dooley <conor@kernel.org>
To: george.moussalem@outlook.com
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: net: qca,ar803x: Add clocks property
 for IPQ5018 PHY
Message-ID: <20260602-simple-ongoing-7b9c1e165069@spud>
References: <20260602-ipq5018-gephy-clocks-v2-0-65a1f1d881f3@outlook.com>
 <20260602-ipq5018-gephy-clocks-v2-2-65a1f1d881f3@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MrTrKkv+tb5wveiy"
Content-Disposition: inline
In-Reply-To: <20260602-ipq5018-gephy-clocks-v2-2-65a1f1d881f3@outlook.com>


--MrTrKkv+tb5wveiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--MrTrKkv+tb5wveiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCah8E9wAKCRB4tDGHoIJi
0p8TAQCg769BCTvN7BEWM9LEtADeTQozojiirVnmZ/O+rn1GFgD/f/gtJf/1fO3g
7KDtK/Gz20EKNlXFs22zWAtCj1ZHnQk=
=ugG+
-----END PGP SIGNATURE-----

--MrTrKkv+tb5wveiy--
