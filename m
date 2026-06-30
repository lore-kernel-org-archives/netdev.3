Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0888126F46F
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836348; cv=none; b=pIm3moaTk1Y15++DZlaC0B6tQVNO33WK+VKwO5SNlnjl0HeHYX8Dv7nIsyW1cPD/9W6PNnTrwEgASL97Mja5qTeyEVaKY4dxYMwtbrigOM9R/rcS2WVo3iJksHTvZ2+sIMmU0TO+JJB9gWPZXa9ccb47UMTS30B+REOvI3H73HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836348; c=relaxed/simple;
	bh=FDAfDvzy+acD3YqGoCYl3nzfWw0aFuZI5HDAO/z/8Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JseZQ0QfxP7HD0P5i+EBPMrhUKNENBYFSNJ5+SiizPa8xC38NIrspNxeXSrOBFvSfax+ecBqCv9zf3cJ4nCLDVZmle2uz3FL/WfouQf85LCeFEPP7IlrSp2dkJLyFe4ArkZoDu0U+opIS3pyfDyljEXdMG7HD8XWa98z1X2weYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFMxDZlM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFMxDZlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225DE1F000E9;
	Tue, 30 Jun 2026 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782836346;
	bh=FDAfDvzy+acD3YqGoCYl3nzfWw0aFuZI5HDAO/z/8Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dFMxDZlMqRC2l4zAdEBFqRtXe5dgSQad0ZKT667f+b5JkT936qjRqYBzNi8PGaV39
	 aga/92P65RtpH4zIWKsanhoEE3pnHuAKDbPvMUmteiE/UCNhKF59yDzSqe1/07CwgZ
	 OOUgyA6vRmD2dT+HidcZeXW5lKOQpPkLkJ8xyMjhmXNMNtFXfYu3YXwPrSt7XpHikM
	 JKggfQ8MrIQgX+OzxAjsZcP6s7CW4WswRhfWWG5U/Y99PP3o/TUrRTEagfAaU2iqwS
	 lXK/ofqL4AXYTOwQYoIsYCM+NmqXgowST3VyO4y/sOTgyefYpQDvpD9SlOWXRw2gKM
	 UvQTCTkMiQxsA==
Date: Tue, 30 Jun 2026 18:19:04 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net] net: airoha: fix max receive size configuration
Message-ID: <akPseKb8X7Q8nTg3@lore-desk>
References: <20260625-airoha-fix-rx-max-len-v1-1-45b9b827358d@kernel.org>
 <94901706-e7f3-4ff7-9b19-9965f593e228@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gbI4hZHtB9TsjBtv"
Content-Disposition: inline
In-Reply-To: <94901706-e7f3-4ff7-9b19-9965f593e228@redhat.com>


--gbI4hZHtB9TsjBtv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 30, Paolo Abeni wrote:
> On 6/25/26 8:49 AM, Lorenzo Bianconi wrote:
> > Set the GDM maximum receive size to AIROHA_MAX_RX_SIZE unconditionally
> > during hardware initialization instead of updating it according to the
> > configured MTU. This avoids dropping incoming frames that exceed the
> > current MTU but could still be processed by the networking stack, which
> > is able to fragment the reply on the TX side (e.g. ICMP echo requests).
> > Move the per-port MTU configuration to the PPE egress path where it
> > belongs, and set the tx frame size running airoha_ppe_set_xmit_frame_si=
ze()
> > to dynamically track the maximum MTU across running interfaces sharing
> > the same PPE instance.
> > Fix the PPE MTU register addressing to pack two port entries per
> > register word and add WAN_MTU0 configuration for non-LAN GDM devices.
> >=20
> > Fixes: 54d989d58d2a ("net: airoha: Move min/max packet len configuratio=
n in airoha_dev_open()")
> > Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> PW bot is on holiday, no automated notifications for a while.

It's too hot even for the bot :)

Regards,
Lorenzo

>=20
> Applied, thanks!
>=20
> /P
>=20

--gbI4hZHtB9TsjBtv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakPseAAKCRA6cBh0uS2t
rH1JAPoDbzhL1nA8oMVHk3V1xDwDjGNcTmfsB+ewrnQo6LhQHQD/RauHvWeHPwKj
BvwMcM9wg/++9wq6uGSMBPxT36uh1gM=
=LZi/
-----END PGP SIGNATURE-----

--gbI4hZHtB9TsjBtv--
