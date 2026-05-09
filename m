Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E837AA95;
	Sat,  9 May 2026 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778328883; cv=none; b=NN8yMXbTwTu5Gm2GQNc2P7ccLjmVOQk7E17f8EPjIODmqxbUpEOKyshIoIiPeYazkuCmLm+1hO5fS4vDMvYe52wNei0faPJC5HAXYdXXG1tsC9+30/5h50s7+pd1k1Hut9V423nymvyVcxk8slqVO1sn3jTTOJJJrwpwtove0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778328883; c=relaxed/simple;
	bh=xj1s+XiVzibKt5JThT5BjIAfNH4K/exIMVrw7lkq7Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/T5tmYmtvpEUE5Q2jrbShZFm2uzLqvzzitN1df93C8DuwE6mj0Wfp/3hknTQ9PNVbArAdtMDRNk8OR8OFiB5Jys8dXh4Uo4btx0+10a5ECRwhQ+/pamQPv4uMqLCr7TaKRTOGUHxtEAZcOwEuia1v/17inpvbuWgpq9S+pnBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOydprbm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOydprbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65612C2BCB2;
	Sat,  9 May 2026 12:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778328882;
	bh=xj1s+XiVzibKt5JThT5BjIAfNH4K/exIMVrw7lkq7Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOydprbmmHNpTrs2kadBB+xtXNydmin8y+17xDV64Pds46PVGSRpHmrfZ/8XLNnKj
	 E0RONhj7qoQeYVIrwK+T6Y7fcnAthSjKWLlJK9BfXR+LFT1RT/CXSmDXKIuu2AIZPu
	 0oTQcfIb0dwJcDqQHGQUc9vbEfecwYh+X5R+jTGRzuXS1fSpdHgMMnJC3jCm4uje0I
	 O9lpfP4T+7wiiIPPiOLsU8WnpEnf/Dr+qA+MSKK2O8e9qI50b56skog6l1Z3Ne89pT
	 fahlgAoUIZZs3V1bJgA8yOl7qWZMf8KryApigv9EpRN7JZkHcgu43eVRquXXldSIFw
	 A5rhQ0I9VIXRw==
Date: Sat, 9 May 2026 14:14:40 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 06/10] net: airoha: Move {cpu,fwd}_tx_packets
 in airoha_qdma struct
Message-ID: <af8lMLkovQOx3oON@lore-desk>
References: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
 <20260507-airoha-eth-multi-serdes-v4-6-af613b61ae02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dcGy5oBbTgHiXKG5"
Content-Disposition: inline
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-6-af613b61ae02@kernel.org>


--dcGy5oBbTgHiXKG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 07, Lorenzo Bianconi wrote:
> Since now multiple net_devices connected to different QDMA blocks can
> share the same GDM port, cpu_tx_packets and fwd_tx_packets fields can
> be overwritten with the value from a different QDMA block. In order to
> fix the issue move cpu_tx_packets and fwd_tx_packets fields from
> airoha_gdm_port struct to airoha_qdma one.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 15 +++++++--------
>  drivers/net/ethernet/airoha/airoha_eth.h |  8 ++++----
>  2 files changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 69a4c2e0d58b..786bc677af3c 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2306,19 +2306,18 @@ static int airoha_qdma_get_tx_ets_stats(struct ne=
t_device *netdev, int channel,
>  					struct tc_ets_qopt_offload *opt)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> -	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_qdma *qdma =3D dev->qdma;
> =20
> -	u64 cpu_tx_packets =3D airoha_qdma_rr(dev->qdma,
> -					    REG_CNTR_VAL(channel << 1));
> -	u64 fwd_tx_packets =3D airoha_qdma_rr(dev->qdma,
> +	u64 cpu_tx_packets =3D airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
> +	u64 fwd_tx_packets =3D airoha_qdma_rr(qdma,
>  					    REG_CNTR_VAL((channel << 1) + 1));
> -	u64 tx_packets =3D (cpu_tx_packets - port->cpu_tx_packets) +
> -			 (fwd_tx_packets - port->fwd_tx_packets);
> +	u64 tx_packets =3D (cpu_tx_packets - qdma->cpu_tx_packets) +
> +			 (fwd_tx_packets - qdma->fwd_tx_packets);
> =20
>  	_bstats_update(opt->stats.bstats, 0, tx_packets);
> =20
> -	port->cpu_tx_packets =3D cpu_tx_packets;
> -	port->fwd_tx_packets =3D fwd_tx_packets;
> +	qdma->cpu_tx_packets =3D cpu_tx_packets;
> +	qdma->fwd_tx_packets =3D fwd_tx_packets;
> =20
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 34f1fef51640..3e93919a175c 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -533,6 +533,10 @@ struct airoha_qdma {
>  	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
> =20
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> +
> +	/* qos stats counters */
> +	u64 cpu_tx_packets;
> +	u64 fwd_tx_packets;
>  };
> =20
>  struct airoha_gdm_dev {
> @@ -549,10 +553,6 @@ struct airoha_gdm_port {
> =20
>  	struct airoha_hw_stats stats;
> =20
> -	/* qos stats counters */
> -	u64 cpu_tx_packets;
> -	u64 fwd_tx_packets;
> -
>  	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
>  };
> =20
>=20
> --=20
> 2.54.0

commenting on sashiko report:
https://sashiko.dev/#/patchset/20260507-airoha-eth-multi-serdes-v4-0-af613b=
61ae02%40kernel.org

- Will this cause statistics to be stolen between net_devices sharing the s=
ame QDMA block?
  - I will fix it in v5 moving counters in airoha_gdm_dev

>=20

--dcGy5oBbTgHiXKG5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaf8lMAAKCRA6cBh0uS2t
rKLpAQCAJYOh+Mq2Abqk5Pe0IM5zZpEk/MH8fwb8ynVYiecPmQD+OvZdUWTvev/6
MkfsRGvBE/RJ2OweRxfSJSv4uCI2WQU=
=cxAJ
-----END PGP SIGNATURE-----

--dcGy5oBbTgHiXKG5--
