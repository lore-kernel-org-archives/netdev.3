Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750F954763;
	Sun, 30 Aug 2026 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099894; cv=none; b=DnJYQL5L0ZpE1aPJDpa7UGdzCkeEGGe1EcwoKgYoij51Rqs3zgfo71HRtXOlMbr7zVa0LB0mmLo6UC01EiEoAuqEMiq4ID6kUf9ydHhdfGM0ZN37qYIFhszWWofUAD2xh7U6A6LpaQSutOuK2eraAnJCRogH/qrB6vbhaKeEwSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099894; c=relaxed/simple;
	bh=mQS1zaguvzAEEepaY5abguRABQxidR0wnbZCjh3/728=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrEQRj3bvK/INVIRPf+SQ06ete06T2DWWC2dcB0WPrXCPGGYvBXBGGa4MhkQCoR0h6lH8fbs/5PiYWG/tD3AL6LIInv+A/0YWEvEod08IMUeQ7XGFRrRUUmGp2QPhc2CXbn704XjPOmN051gQeeb1Js7JLy8nop4LYspWyk5AAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLsulbk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLsulbk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD81F000E9;
	Sun, 30 Aug 2026 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788099890;
	bh=mqEbBnLXoNwaBEWPaO2q0zQzfK0jpS+p/vOgbxYYs/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LLsulbk2oar40fID4XXO4xBcAP845FYaGiQG0dLtUea4yehFsWcVnAXCsJVYnbTaj
	 suacRwAR/OtcA7vrq71ZDagQPpZBhbvjlEFClPsZsq3eJFOMiWc3qhTF6Ni4YsEoij
	 lRGiZ1t1CKwss0ZunDyELGW9NEvoQTsDI/IKSWRnped/CRsxYGOw1TAdQ/WZdjMBO3
	 TvqfTTD+xTiCV6YlYNdLWkB1kIHYbw1Lh0auNGWTHkU3ObozLMvaZuqOXDpKxDO8N6
	 5AbgaMgdm0JZ4GkQO+TL1OlrquUomLwgEm50WNKIJtdPaoAcC3eqlFEKxUJ0caMySL
	 ZsMKrTeOx+sMQ==
Date: Sun, 30 Aug 2026 16:24:47 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: airoha: grow RX ring 4 to 128
 descriptors
Message-ID: <apQ9L3D3Kvj2b7T-@lore-desk>
References: <20260830095717.37218-1-sochnev.v.74@gmail.com>
 <20260830095717.37218-5-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TFdZvCNJZ0cB9Z77"
Content-Disposition: inline
In-Reply-To: <20260830095717.37218-5-sochnev.v.74@gmail.com>

--TFdZvCNJZ0cB9Z77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Ring 4 is the shared "force to CPU" ring for a wide set of protocols
> (BOOTP, PPPoE Discovery, PPP LCP/IPCP/CHAP/IPv6CP/PAP, ISAKMP, DHCPv6,
> SIP, LLDP, ...) and currently falls into the 16-descriptor default in
> RX_DSCP_NUM(), same as most other non-hashed rings. The hw completion
> race recovered by airoha_qdma_rx_check_stall()/rx_recover_work() in
> the previous commits appears strongly correlated with a ring going
> from idle to receiving its first frame(s) - exactly the access pattern
> this shared ring sees under protocol negotiation bursts. Give it the
> same 128-descriptor allowance already used for rings 2/11/15, matching
> the other rings that see bursty, non-hashed traffic, to reduce how
> often that condition is hit in the first place.
>=20
> Ring 4 and the VIP classification that forces these protocols onto it
> are shared driver-wide, with no DT/hardware property distinguishing
> one chip variant's ring 4 from another's, so this isn't scoped to
> AN7583 specifically even though that's where the race was found and
> reproduced. 24h+ stress runs forcing repeated PPPoE/DHCP renegotiation
> on an AN7581 board, both with and without the two preceding fixes,
> completed 570+ forced reconnect cycles each with no regressions from
> the larger ring.

If you set RX_DSCP_NUM to 128 on AN7583 for rx queue 4, are you able to
trigger the issue?

>=20
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index d6591a779743..cd75c16d8d0c 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -41,6 +41,7 @@
>  #define TX_DSCP_NUM			1024
>  #define RX_DSCP_NUM(_n)			\
>  	((_n) =3D=3D  2 ? 128 :		\
> +	 (_n) =3D=3D  4 ? 128 :		\
>  	 (_n) =3D=3D 11 ? 128 :		\
>  	 (_n) =3D=3D 15 ? 128 :		\
>  	 (_n) =3D=3D  0 ? 1024 : 16)

Can you please change the default from 16 to 32? This is the default value =
used
in the vendor sdk.

Regards,
Lorenzo

> --=20
> 2.55.0
>=20

--TFdZvCNJZ0cB9Z77
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapQ9LwAKCRA6cBh0uS2t
rM13AP4wkYGuLzW+WVctf1OtsZrpVodXKZgBv2utkiyeq25FaQEA2SaUS/5l8UPs
HVO0eRtFu4TXJtmo25S219Df4cIi+gI=
=BFzh
-----END PGP SIGNATURE-----

--TFdZvCNJZ0cB9Z77--
