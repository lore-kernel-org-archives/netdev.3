Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F426FA60
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287222; cv=none; b=MVncT7LAPun/6bCMxtRmi6GL13j2W7lrGKqqutQTS6zG6oWNwSFShvqEsjZtQq2JF9QjlCXtl2Cj+z0ss0nySpnbHF8RGsNBzKhlNbxH/PQrQ3vvOwFNTsvFbjnasg4RLYmVVnxHvsiLqDA+GNxAkK6YwWWaCmSJWk5Sa+7urR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287222; c=relaxed/simple;
	bh=kB3Moae5CFmTuaSA5mj8k7tNdfHTKZ7MHzwmbBQLCNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJzPaBKtDwMraY1RImfEwkvNtaWXm7/BUUfNEt4QZ8mtjTTNKcceMFdWmHvhSPtw9Ta1cMksixIj/1ynUvutyZIWLsRaG3q4XISOZEgwDsNBhxeXU4MDYa8dwat9xuTYzIFUycIEumNjb/ivvNwZGDbbsaLyI90KnkNuCeV+5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBTzIe6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBTzIe6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369621F000E9;
	Fri, 17 Jul 2026 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287220;
	bh=tELoBG5OKG9/+DOeMkHZuGsmy1n3mciJef9SVNvGdLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PBTzIe6XHPA3q0htvADSHdg/xV35sBnEm5cfX8PJpp4u/8AFOZ4dU+KuHXg+JMbn1
	 0+XPR+s6EvnS8ER3ga4BdPyEEQ+SbO2YtqP0eg8LtjoCj8+wLE0Sw2unFcbDTeFUlj
	 VnPa8aYJCJlsxRvMTNJmBiW/EatEAlnY1O46ltfNguVpmoJhW7Om0w0uCEiL2gHUtZ
	 BtXvwUe+nP/HNrkUjTj5dqEZecBpyR91vFSd0/ltlgnMBjF91bZRB56i+gOxvtIJuR
	 QI1lHLAVRG9iX3mH7NiYwsvEJMXY9zQJ9rgEwxETaxK00SkSAl77YXINNqEUz65Utx
	 DqXmRyvWgXzUw==
Date: Fri, 17 Jul 2026 13:20:18 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v8 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Message-ID: <aloP8n-EVtAHnl-l@lore-desk>
References: <20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hz6h8/yWol2iBSX6"
Content-Disposition: inline
In-Reply-To: <20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org>

--hz6h8/yWol2iBSX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
> offload is created or destroyed.
> Make dev->qdma an RCU pointer so the TX path can safely dereference it
> without holding RTNL.
> Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.
>=20
> ---
> Changes in v8:
> - Rebase on top of next-next to fix conflicts.
> - Link to v7: https://lore.kernel.org/r/20260701-airoha-ethtool-priv_flag=
s-v7-0-b4153bd44428@kernel.org
>=20
> Changes in v7:
> - Fix ETS stats accounting in patch 2/3
> - Reset ETS stats accounting in airoha_dev_set_qdma().
> - Link to v6: https://lore.kernel.org/r/20260629-airoha-ethtool-priv_flag=
s-v6-0-86bc600d31bc@kernel.org
>=20
> Changes in v6:
> - Rebase on top of next-next
> - Add patch 1/3: "rename airoha_priv_flags to airoha_dev_flags"
> - Drop patch 2/3: "refactor QDMA start/stop into reusable helpers"
> - Link to v5: https://lore.kernel.org/r/20260611-airoha-ethtool-priv_flag=
s-v5-0-c11de08486d1@kernel.org
>=20
> Changes in v5:
> - Add patch 1/3: use int instead of atomic_t for qdma users counter
> - Protect dev->flags with flow_offload_mutex mutex.
> - Introduce AIROHA_PRIV_F_QOS in order to handle better WAN/LAN
>   switching.
> - Link to v4: https://lore.kernel.org/r/20260610-airoha-ethtool-priv_flag=
s-v4-0-60e89cf28fea@kernel.org
>=20
> Changes in v4:
> - Move back QDMA TX/RX DMA enable to airoha_dev_open()/airoha_dev_stop().
> - Configure GDM3/4 as WAN if GDM2 is not available in ndo_init()
>   callback.
> - Protect qdma pointer in airoha_gdm_dev struct using RCU.
> - Rely on rtnl_dereference() to access qdma pointer in the control path.
> - Add airoha_qdma_start() and airoha_qdma_stop() utility routines in
>   patch 1/2
> - Link to v3: https://lore.kernel.org/r/20260608-airoha-ethtool-priv_flag=
s-v3-1-3e8e3dc3f715@kernel.org
>=20
> Changes in v3:
> - Do not introduce ethtool private flags support to configure LAN/WAN
>   for GDM3/4 and rely on tc qdisc offload for it instead.
> - Set GDM3/4 ports as LAN by default.
> - Move QDMA TX/RX DMA enable from airoha_dev_open() to airoha_probe()
>   and the corresponding disable from airoha_dev_stop() to airoha_qdma_cle=
anup().
> - Link to v2: https://lore.kernel.org/r/20260607-airoha-ethtool-priv_flag=
s-v2-1-742c7aa1e182@kernel.org
>=20
> Changes in v2:
> - Rework airoha_dev_set_wan_flag routine
> - Enable GDM_STRIP_CRC_MASK in airoha_disable_gdm2_loopback()
> - Do not always reset REG_SRC_PORT_FC_MAP6 in
>   airoha_disable_gdm2_loopback() but use the same condition used in
>   airoha_enable_gdm2_loopback().
> - Link to v1: https://lore.kernel.org/r/20260606-airoha-ethtool-priv_flag=
s-v1-1-401b2c9fe9f1@kernel.org

Hi all,

I noticied this series, even if it is properly acked/reviewed, it is marked=
 as
'New, archived' in patchwork:

https://patchwork.kernel.org/project/netdevbpf/cover/20260703-airoha-ethtoo=
l-priv_flags-v8-0-015ba5ac89ee@kernel.org/

I'm not entirely sure what the next steps should be for this series.
Thanks in advance.

Regards,
Lorenzo

>=20
> ---
> Lorenzo Bianconi (3):
>       net: airoha: rename airoha_priv_flags to airoha_dev_flags
>       net: airoha: fix ETS QoS stats counter underflow and cross-channel =
corruption
>       net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offl=
oad
>=20
>  drivers/net/ethernet/airoha/airoha_eth.c  | 253 ++++++++++++++++++++++++=
++----
>  drivers/net/ethernet/airoha/airoha_eth.h  |  26 ++-
>  drivers/net/ethernet/airoha/airoha_ppe.c  |   9 +-
>  drivers/net/ethernet/airoha/airoha_regs.h |   1 +
>  4 files changed, 246 insertions(+), 43 deletions(-)
> ---
> base-commit: 6fb33632323a396c9dc2bb9bea483e013e547d57
> change-id: 20260606-airoha-ethtool-priv_flags-b6aa70caa780
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--hz6h8/yWol2iBSX6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaloP8gAKCRA6cBh0uS2t
rChMAPoC66tsGBHWVimsBu9sMQxeBChbTqZ+vPnbOXG4zs8LlgEAtbkYzJAf+aMN
h+MIIrI2xHh0XCfXdoIcj1xcuT0uXgA=
=f9FL
-----END PGP SIGNATURE-----

--hz6h8/yWol2iBSX6--
