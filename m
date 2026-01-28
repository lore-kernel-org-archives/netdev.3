Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD931579B;
	Wed, 28 Jan 2026 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622102; cv=none; b=c4RUOIF5pMU8mERlXH7OhmtWS6sH5eg7nVc/fCFOxaB20NyemjwgBU69EJfaO64iq3klCLxH7OqJW9E2Aks7xY9tvcGO7faWuTSjUt6ml024wH1MnRixWGKEjfnR44GJ6DZE+a80ssP3+rXd40txfwY34ECeU1iKo81OHi2JcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622102; c=relaxed/simple;
	bh=yicTku+0xijP+/i8rpmgTX9qyCIqdmQbVUEhKv4zS9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSF92R6ecTuff310bkSxaY8HDWzRf7cYyEHpVhhbDQme6Xmq3v4l0ZQKjt8uErKoJwGi1HbTYyA67UitLgDuY7uCNyljsO/Z3eJ+7qvbFKVHoeUJ2JnTJuY60zquorcMY6ES0Bs/8GzO43iidlOZryGIPi5dtqckEGULd256Ckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if0ez0lA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if0ez0lA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FADC4CEF1;
	Wed, 28 Jan 2026 17:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622102;
	bh=yicTku+0xijP+/i8rpmgTX9qyCIqdmQbVUEhKv4zS9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=if0ez0lAXCAI+9ynKkExRSH1FKsKmyNj7kvfVTpurPceIo9iTpY0WuvQbbj+HMqKw
	 RoD83Q7xfGcM3B/9k7CEU4eFOUqs9/2PO+Z59nfhUydC1H7w8QJuKT5GKoAGMbHT2F
	 KrF2tgciL2Uu+nU8BKhpr2QeDDLolTooJyLUurmJ9zzik1HdGx7Ubpv1trGzTwa0Zx
	 qioN/9z/OADJqOuBSjMMQfIwn+JquwLzsDX/kCmn95NSjkPQdLyRME4CYtalOe/vaU
	 pO1BQMG290D78XATuNW2tjpx+96yDDpWAFNUNYv5XiKZwYH6E/ZGGVkNIAsJ9EYAI8
	 UBgE/ZZXJpf6g==
Date: Wed, 28 Jan 2026 17:41:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] dt-bindings: net: renesas,rzv2h-gbeth:
 Document Renesas RZ/G3L SoC
Message-ID: <20260128-tray-traction-32d37382574d@spud>
References: <20260128125850.425264-1-biju.das.jz@bp.renesas.com>
 <20260128125850.425264-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MMVXKdr/e7i/N5rC"
Content-Disposition: inline
In-Reply-To: <20260128125850.425264-2-biju.das.jz@bp.renesas.com>


--MMVXKdr/e7i/N5rC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--MMVXKdr/e7i/N5rC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXpKUAAKCRB4tDGHoIJi
0nZHAP93EdvEuoVukyNcu681qREwEtfp9PZZ0O/cOcCkkV+g5AEA/C/Zu7wOzmNS
s36cdbhXv9jNyMPH7O7hBw3W8RoH1QU=
=4hgu
-----END PGP SIGNATURE-----

--MMVXKdr/e7i/N5rC--
