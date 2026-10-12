Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACC49E5FE
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820607; cv=none; b=pW1nqcN7b9643+CitY487MbXIs0RAdO/7DDXQhayCHk1rm+xdaLHFcXrMOEzEHFaVV7bxdwpbQWPurAWhzB2sJ/xVc0ZUU2K8GB+mVcYHtTHR7e75mG2WsP+17/6HdYdOF3EEnXZ3hauiYjQHAWsV4YYgze39VvqMkgG7ZFc6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820607; c=relaxed/simple;
	bh=x+II2C4NzEp/tgLOxIxV6XDF9wkhlBsS7NDjudONlTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV15EW0hLC5KhIfZIy3yXwgT9rUfaDJa1wMzprkw1W3PH9cmIkOVjGfBXuoxN4vhmyKfHPlpt9/dMICXEz/aBPeHj0OW63v0EsMzl1ZlIIVieQh0Y/My+3elLLaUswnBsuPVL4/izhMtfcnflxj9zaTe44g4CB2g9uA5jn7u8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKF2J721; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKF2J721"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1679D1F0089B;
	Mon, 12 Oct 2026 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791820605;
	bh=SLHzIePtUtQg66m5nrwYqo88M3o3A1elf8s8U3DZucw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PKF2J721gleu2jMI4dW+07EWVthufc4abF+3N4bdWtQIJg+0R5I1t9vEcM9T1sUaw
	 dpEf8YscK3Aw/wuyy+NKyIHRM5hibmifdGOmlPfphrdvvft1yEdKzpwy6T9OVOpCjZ
	 tuO2YMi7dIajKkmPVtl+DrFXUHrgK17zjNjh1ZC4V6gC0/xo/JLHNnVVb2rAuJ2YBi
	 TcvuK/JffqeO/m8f6mLhpdqreDTvDX0mda5Ked8aK8V8LwQOh07R5P2nVMCgyakwaG
	 Wms75F6g3flf7RKZTjjEAmlWmkO+NMVKLBieRlNRuwvvAkRyBJbZTAjQY/dw0rNxP/
	 nM5irFimaPDVg==
Date: Mon, 12 Oct 2026 17:56:43 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: =?utf-8?B?6ZmI6ICA5piO?= <cc201008@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: Keep UPDMEM egress MAC in sync for
 offloaded IPv6 flows
Message-ID: <as0DO7n5SCr2j3Z2@lore-desk>
References: <CAPZ+gd9d1P+xDSrxxZkGJr32zjubP=KfQegeGkWykKGvEH0=oA@mail.gmail.com>
 <CAPZ+gd8TPNnvEDOv_H=fdvy2ysG63uBD0MvmEMjhkMa8i-y1NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7loBx0NG4ClbL5mp"
Content-Disposition: inline
In-Reply-To: <CAPZ+gd8TPNnvEDOv_H=fdvy2ysG63uBD0MvmEMjhkMa8i-y1NA@mail.gmail.com>

--7loBx0NG4ClbL5mp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> PPE routed IPv6 FOE entries do not carry the egress source MAC inline;
> they store an SMAC id and the hardware resolves the address through the
> UPDMEM table, which airoha_ppe_init_upd_mem() only programs with the GDM
> port own dev_addr at probe time.
>=20
> The netdev the flow actually egresses can legally carry a different
> address: on PON setups the authentication MAC belongs to the pon device
> while each service VLAN routes with its own address, so offloaded IPv6
> frames left the port with a stale source MAC and were silently dropped
> upstream. IPv4 was unaffected since HNAPT entries embed the MAC inline,
> which made the failure hard to diagnose: TCP handshake and TLS completed
> over the slow path and the transfer stalled exactly when the flow got
> offloaded.
>=20
> Before writing smac_id for routed IPv6 entries, program the UPDMEM slot
> with the source address of this flow.
>=20
> airoha_set_macaddr() writes the same slot from the ndo_open and
> ndo_set_mac_address paths: take flow_offload_mutex there too so the two
> UPDMEM writers cannot interleave their two-step DATA/CTRL sequence and
> leave a stale address behind.
>=20
> Tested on a Nokia XG-040G-MD (AN7581, GPON WAN, PPPoE over a service
> VLAN carrying its own MAC address): IPv6 HTTPS transfers went from
> stalling at the 15 s curl cap with partial bytes to completing at line
> rate with hardware offloading enabled, matching IPv4 throughput.
>=20
> Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Yaoming Chen <cc201008@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  |  8 ++++++++
>  drivers/net/ethernet/airoha/airoha_ppe.c | 13 +++++++++++++
>  2 files changed, 21 insertions(+)
>=20
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -138,7 +138,15 @@ airoha_set_macaddr(struct airoha_gdm_dev *dev,
>   airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), lmin);
>   airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), lmax);
>=20
> + /*
> + * Serialize with the flowtable offload path: both writers program the
> + * same UPDMEM slot with a two-step DATA/CTRL sequence and concurrent
> + * updates would interleave, leaving a stale source MAC under already
> + * bound IPv6 entries.
> + */
> + mutex_lock(&flow_offload_mutex);
>   airoha_ppe_init_upd_mem(dev, addr);
> + mutex_unlock(&flow_offload_mutex);

This seems a deadlock to me since airoha_set_macaddr() is running holding
flow_offload_mutex mutex in airoha_enable_qos_for_gdm34().

>=20
>   return 0;
>  }
>=20
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -414,6 +414,19 @@ airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
>    dsa_port);
>=20
>   smac_id =3D port->id;
> + /*
> + * Routed IPv6 entries resolve the egress source MAC
> + * through the UPDMEM table indexed by smac_id. The
> + * egress netdev can legally carry a different address
> + * than the GDM port itself: on PON setups the
> + * authentication MAC lives on the pon device while
> + * each service VLAN routes with its own address. Keep
> + * the table entry in sync with the source address this
> + * flow is actually going to use.
> + */
> + if (type >=3D PPE_PKT_TYPE_IPV6_ROUTE_3T)
> + airoha_ppe_init_upd_mem(dev,
> + data->eth.h_source);

I do not think you used checkpatch here.

Regards,
Lorenzo

>   }
>   }

--7loBx0NG4ClbL5mp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas0DOwAKCRA6cBh0uS2t
rK9aAP9PNyueczLuKOh6HqOy9UG4JJo/Y70ApaV7gfwe/UqkKQEAg1vnuG8yRZy7
CSfsA8crmPEQSI4RS1bv4G6GvRjz7QE=
=I85x
-----END PGP SIGNATURE-----

--7loBx0NG4ClbL5mp--
