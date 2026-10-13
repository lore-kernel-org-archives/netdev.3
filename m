Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714D349CF0
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876971; cv=none; b=hMsUm0SY75bFA5gch4mJ2jU5YJXzTmYmaVjNy5K2pmdJgCM4fFYOS8oGhjbh8EJNkWyiRIUu/I+T8wMPepmpoXaOeEkLCLynDR4naZ4KKcwcT59gmLqOJaEUghcvaI5uxJ1jhKYu9ljcUlsM/oAGgEhl7BuIVO66ksSEVw7pPo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876971; c=relaxed/simple;
	bh=uJNr8MuDmtKlslzBqHB35803Z4VAdOFssu8DXaY7GkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9obyW40Xo+vQq5MWorZuHgxLCYyNmztlMqHNDR8tKIDtmM/l8oPjVVToc0YafFAelyg1ZXm0g4WLlPgaJvow6itNZnRf44PAiFouKjWfIr6z0NXJ9EM7naDqKS730IVZ/NKWfK/f6fPZXA5q8brKemxn1UMh7X9znhcAXl+LMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0Zdq6gF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0Zdq6gF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37671F000FF;
	Tue, 13 Oct 2026 07:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791876970;
	bh=UKe/K2SFz3cYwqVg3k3/7PTTaraKAqNtSe8pGFak5HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b0Zdq6gFncODMxuvCb00Ksvk98CswTE8ORGdJbNA+AsqstxOu8Gsb7TWeN/0mq42Z
	 uztm3Muh1JZoTZqqO6Vt2TV8E3r1hwjd4tQ4ERxruUdXJfsTqM1KVYElQwI2Uu6z1D
	 eVqJUbot57OLAlaJlQSBscBMLb6f+kirrkRKvgdJclHpxqy3pJqX+odHouKsKjvV3W
	 RTp8ygnLKhxbJxogmAacEp1biB6Gcp1cnIoDMKEnqnkYt4b4dfpGOgyclCSFboxoep
	 IFY4oXBKNYsnAofOZlI6/RtkZqQXTFjAwysrPeb2VOo8k5MyMpwQDWYPtSc8YZITL2
	 EtEWvSuUbjqCQ==
Date: Tue, 13 Oct 2026 09:36:08 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: =?utf-8?B?6ZmI6ICA5piO?= <cc201008@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: Keep UPDMEM egress MAC in sync for
 offloaded IPv6 flows
Message-ID: <as3faB96PFSnC-qP@lore-desk>
References: <CAPZ+gd9d1P+xDSrxxZkGJr32zjubP=KfQegeGkWykKGvEH0=oA@mail.gmail.com>
 <CAPZ+gd8TPNnvEDOv_H=fdvy2ysG63uBD0MvmEMjhkMa8i-y1NA@mail.gmail.com>
 <as0DO7n5SCr2j3Z2@lore-desk>
 <CAPZ+gd_1JsNyhQbEAWiE1stom+T_jgvt4F2=tb68YoSvPCnFag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TsY4h+RbU0p15xnQ"
Content-Disposition: inline
In-Reply-To: <CAPZ+gd_1JsNyhQbEAWiE1stom+T_jgvt4F2=tb68YoSvPCnFag@mail.gmail.com>

--TsY4h+RbU0p15xnQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Ooo,  the new patch should be a dedicated leaf lock inside
> airoha_ppe_init_upd_mem().
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -416,6 +416,19 @@
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

Is the issue occurring just with PON or are you able to trigger the issue e=
ven
in the upstream codebase? I guess you should not post a fix for some code t=
hat
is not upstream yet. Moreover, in the PON setup, I guess the approach is st=
ill
broken if the user change the device mac address.

> + */
> + if (type >=3D PPE_PKT_TYPE_IPV6_ROUTE_3T)
> + airoha_ppe_init_upd_mem(dev,
> + data->eth.h_source);
>   }
>   }
>=20
> @@ -1529,10 +1542,21 @@
>=20
>  void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, const u8 *addr)
>  {
> + static DEFINE_MUTEX(updmem_lock);
> +
>   struct airoha_gdm_port *port =3D dev->port;
>   struct airoha_eth *eth =3D dev->eth;
>   u32 val;
>=20
> + /*
> + * Routed IPv6 entries resolve the egress source MAC through the
> + * UPDMEM table indexed by smac_id; the ndo_open/ndo_set_mac_address
> + * writers hold flow_offload_mutex (QoS paths re-lock via
> + * airoha_set_macaddr()), so this lock also serializes the leaf
> + * against them.
> + */
> + mutex_lock(&updmem_lock);

This is only required adding the above configuration since in the current
codebase airoha_ppe_init_upd_mem() is always running holding RTNL.

Regards,
Lorenzo

> +
>   val =3D (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];
>   airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
>   airoha_fe_wr(eth, REG_UPDMEM_CTRL(0),
> @@ -1545,6 +1569,8 @@
>       FIELD_PREP(PPE_UPDMEM_ADDR_MASK, port->id) |
>       FIELD_PREP(PPE_UPDMEM_OFFSET_MASK, 1) |
>       PPE_UPDMEM_WR_MASK | PPE_UPDMEM_REQ_MASK);
> +
> + mutex_unlock(&updmem_lock);
>  }
>=20
>  struct airoha_ppe_dev *airoha_ppe_get_dev(struct device *dev)

--TsY4h+RbU0p15xnQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas3faAAKCRA6cBh0uS2t
rBzUAQCL/fb8smdTz5MWaZqzvmSS5tTGd94zzSEJp/E/0DMNXQD/ecISkztvJeO7
lNdqhT63wJKz2zXCWEru2qKfnsV6EQA=
=YGK5
-----END PGP SIGNATURE-----

--TsY4h+RbU0p15xnQ--
