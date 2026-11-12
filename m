Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481468;
	b=kTsRCThvU94SQibi2+GOIkRm1XqM+HasDOblWn79/qs5rFRfYnAYVJWQKZac0GBHMXlJ
	 klW65McIayS0wDWtUXum4pXMBjzoNbIkrXaCu7L1lXJZxK8YIjfZAhQBFLokucvKCOIov
	 8kWed8owruRjxYYf1jkCoCZNvabGt3rCHUnC6ldp2JKS/z2gXAcN6BFrVOq9EGQoSUaYG
	 iZpKRfgQEmq4ywIEG6jW1QRoU1V5x11yu3Y5z+uHX/sf1Yiic0bVLZBu23DAOReXKggcj
	 yTWMTE/HPqEhSZXoZGgK2eUzbOxnrytPt3huwuyKLjuaQIVzRLC4gG+NNCRiQWe5GwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481468;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H4M2KIRE5a8Yduva+gW2HsKpcDmtHsDzLl02OQNHYTY=;
	b=HcFsTfx5kCedxY5iXS/g9dX06ipXKKHHszZ8ZCe1v6GQBaQyA8c6mUjjrbpV2QFbVgqY
	 MK33wrhDMqiJ4G2PmpYaCMjLtrv05H47SczUB/lRVHQ/VtLqGhgdQMmPQElJFsg17MqKu
	 9f73+W7rrbK16AK9e+9ZQEVme7fQyFcdPzjS91u1ZJRFhDNSdfugYH6o9fU120suHhhYJ
	 SC+YNOBmfqkiebp+C/+SUPybsGQer2yUK99Nt3BZs5HmTSlG0LASlRigSmeMGS4VWrrmD
	 IWt/yxqYEPADypZG2UWC7ozDNcFDysKsjEDuQSadBsx/8v4+qbGcLb56BDrjsk8Ez/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0Y7Bx5i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F1606A31C;
	Thu, 12 Nov 2026 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0Y7Bx5i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255D61F00A06;
	Thu, 12 Nov 2026 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481467;
	bh=H4M2KIRE5a8Yduva+gW2HsKpcDmtHsDzLl02OQNHYTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U0Y7Bx5igfoFnsIhBYRHENpnKYi05KKx6zHBnvw+ACFNWO11KFwbKuabv5br+W48c
	 iqDGJyALqgkjnzD5pUVTxcNuXAOTlv1wxjcnCGH8r9I1rqaJpDRQPksU4g8vGRcAK8
	 jka04pke2L3Cjh4gCWGMwax/QCxs+oCwQndbR/vBK5JC0wwEL1+X2J+zSv0oyxaM/s
	 LW2+duB+GPWIbu2OKFHY7h7jzBZuVTEaXtSYqBuxY3bR5wpkx/kh+WfD2jamyzNnSk
	 4yWvIQCTZ+KfuXYyJweAEU0HQwOc+awml6peyn0yxPpyRmHDM/kT3lR3ZAdKEpWcLh
	 3Awb3TkOIymuQ==
Date: Thu, 12 Nov 2026 12:04:25 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Xia Yan <yanxia@cmss.chinamobile.com>, netdev@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yanqing Wang <ot_yanqing.wang@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, yana06070@163.com
Subject: Re: [PATCH net-next v2] net: ethernet: mtk-star-emac: fix
 device_node leak in mtk_star_probe()
Message-ID: <avWdOWzBtEynoi7t@lore-desk>
References: <1794455490000.585551.2561101329908158128@cmss.chinamobile.com>
 <u6jz3rgrlwhlbhqwgi26lsa2knkwgjws6scbb6e3dq6bkjmudi@hiulukf72wrr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M+g60A+VzcHE/eYH"
Content-Disposition: inline
In-Reply-To: <u6jz3rgrlwhlbhqwgi26lsa2knkwgjws6scbb6e3dq6bkjmudi@hiulukf72wrr>

--M+g60A+VzcHE/eYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Nov 12, 2026 at 11:51:30AM +0800, Xia Yan wrote:
> > mtk_star_probe() gets the PHY node from the "phy-handle" property
> > with of_parse_phandle(). The helper takes a reference on the node it
> > returns. The node is used by of_phy_connect() each time the netdevice
> > is opened.
> >=20
> > That reference is never dropped. Every error return after the lookup
> > leaks it. Unbind leaks it as well: the driver is devm-only and has no
> > remove callback.
> >=20
> > Release it with a devm action, registered right after the lookup.
> > The error paths and the unbind path then drop the node through the
> > devm cleanup.
> >=20
> > Found during a code review of the OF node handling in ethernet drivers.
> >=20
> > Fixes: 8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
> > Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
> > ---
>=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>=
=20

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>

--M+g60A+VzcHE/eYH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavWdOQAKCRA6cBh0uS2t
rLnFAP4t87cBlMJ+fUJahaPjJi8B3GWxyaVfmrXmlILfRGb5qQEAsjrfcpkk5YhG
7DqsExQBjxDfj0q+vBkDdWDJRPn3NQ0=
=yqVZ
-----END PGP SIGNATURE-----

--M+g60A+VzcHE/eYH--
