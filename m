Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4892D739B
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584894; cv=none; b=cC+gLo99BlSG2zXlo2ReGx777DdOgE/sE3T6LF33VGRo0K3PJgy2i/LGODxbDKp5TUQocehQONNfHl8K0zLz6A4IyKkI/v6pSJaNiS/96VQf+dK47CzIgAVBMgB0/ZnWhaWCPC5h8gRjMyR2m5q3jTOJlTgzPT9w14Yb9KMY5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584894; c=relaxed/simple;
	bh=8shEkl9bfUBm5chmZQFFesp2M/GuSCNTbnqyFJ47KZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFvbxzCeajW2mMNT/UtHIvYcY2IhI7HWqE/083YnBDkDwO6jQ6jrMg326xO+uOFPvZYmaYxPio/xmrgh1f4WccQg0MypOzKFSKNUEiTgmmlCoq3q0bM/ZcO5n1/IvTGK1tEG0TXGqQFp82g+1KVvhhV+kjUPPskM+jHA79OWcnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpuTzzCt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpuTzzCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EA41F000E9;
	Mon, 20 Jul 2026 22:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784584893;
	bh=8shEkl9bfUBm5chmZQFFesp2M/GuSCNTbnqyFJ47KZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TpuTzzCtdwyrM6qitqt4emn/cmErizKX5pgjsAO8dkEAzni/H5D+HcWiacDR3ef2Y
	 fslA460AD6nOE7WXh36+2xYoQP7RLSjZmwycfAKIDsfvbmyx+bvAyOw0XOkusT1RZ6
	 fbkH4/VwrRMzIafhwBXZ3Fnp7TPlYWc3e+PJIq/taQFzzgrJB0/w5rHurl7JE7F8zp
	 G9931HBstUO/amAaQIFHemvNXZPskb88dyQB5or6m/0Xqs13qRKivWOe4MKL7i1OZ8
	 SNXbJdA4OLfVbM7wnuNmzO6zp9vGojydljZnoQqRWaU8xZyKkzj5DKguVBdFLnhNTP
	 oP+TNHmEvsboQ==
Date: Tue, 21 Jul 2026 00:01:30 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v8 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Message-ID: <al6ausK3oaED0JQ9@lore-desk>
References: <20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org>
 <aloP8n-EVtAHnl-l@lore-desk>
 <20260720144816.4d32909b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Pkeet7k5saMLTzn"
Content-Disposition: inline
In-Reply-To: <20260720144816.4d32909b@kernel.org>

--3Pkeet7k5saMLTzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 17 Jul 2026 13:20:18 +0200 Lorenzo Bianconi wrote:
> > I'm not entirely sure what the next steps should be for this series.
> > Thanks in advance.
>=20
> You have to repost, once a patch is 2 weeks old korg patchwork bots
> insist on marking it as archived.

ack, thx for pointing this out.

Regards,
Lorenzo

--3Pkeet7k5saMLTzn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCal6augAKCRA6cBh0uS2t
rHfsAP0ThBpx8LlBnccLWrshYDI4Kd572l7LahBkxSCE//NK9AD/Sn0vNdoXEqW5
+Y/+8BZgBUZmeKBL6AHFKkdBb3mg0g4=
=rk5o
-----END PGP SIGNATURE-----

--3Pkeet7k5saMLTzn--
