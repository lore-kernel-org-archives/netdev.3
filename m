Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852943749F5;
	Wed,  8 Jul 2026 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511121; cv=pass; b=eB4F+K9sfn5zmOTEzFN4iByKFIe8xuDzb0yJj+5a45MG+txy79SspVBS2HWCj1r+mxzE1swQoshBpsLDfpYyojIeZFMn3KXWM2DkYaMBHEPQS/t1L1KRDrf9en9fo9lsagLqupq/N84iIurQOYk6BHh84K8sZrjvgDTk8xqnegg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511121; c=relaxed/simple;
	bh=vG674cmrQhJjZlTsH72CkjCa0sAbuJq5pd0lZ9+z5lQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pqJp5S7QQb1a/n0p48L14nrFMVkkfdzlAxSEPNyf0EXwwTQyOAGQthAl8ydmy0cTycDzBuYP1edt0q9gqMGCpAX9vCELHswjK5sStMENaF7W0iEGAknlN5FCoFcNOjrf0sn0pLDhiitjBH9jtKouUYSstTo1LPXM2ZzgYIZ8Z10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=hHGodoC5; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="hHGodoC5"
ARC-Seal: i=1; a=rsa-sha256; t=1783511084; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BbzfzKxqbvPnrvyVyHOhzb8iD20zR3d66/NJqDevEdeclatBqZjVOp40FJJBVUGAkZDBYHC3ODWdArm/rrjpPI/IYXPshf4P9TSy6xjx5FerLYq09rVpkQAzZ0wtIsSdxbEgl7L1HfDSB20xpPNMSd/B5CoQVlqmup2BYQWPqWA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783511084; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=10jNbGRvZsPmWMGouxLK8UHxoLr85rz2aRkumx5Y9/A=; 
	b=LLI7sW882jTnhgaNd1popR55mSPsaxMbsW7mOffkw42FDSe0VycSQiGZ6O64cH0tHIQxND9to8OpnJaDzWBoOpCCdbMpAlocI3IZmYvw7TkOJqvBGqRvPyB3UW/jSL7WMfvBv+qkEAA9ROigdTLXPBOSp/QugRRqThk+tJqbR9E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783511084;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=10jNbGRvZsPmWMGouxLK8UHxoLr85rz2aRkumx5Y9/A=;
	b=hHGodoC5rNtt9ao4ZOa0g7TQj9LXm/mPnD0kmSkHKFrfpnRPy4Mnq1S3IQjvaToI
	LBIjBPD3bgr6htQpPURhrwg7UUMeCeGicaNuGHnfvGhRuM4zF2kDIcjqD0IrVq3NnNs
	mazulxdQPHJYyp46a0hAfQktOenapwaW2mdU/4ms=
Received: by mx.zohomail.com with SMTPS id 1783511083198326.6815554898435;
	Wed, 8 Jul 2026 04:44:43 -0700 (PDT)
Message-ID: <3c22fe68c08c414b789c79144ae569840e1ba6a9.camel@collabora.com>
Subject: Re: [PATCH net-next 2/6] net: stmmac: mediatek: add PERI_ETH_CTRLx
 register offset in platform data
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Biao Huang
 <biao.huang@mediatek.com>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk,
 kernel@collabora.com, 	netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Date: Wed, 08 Jul 2026 13:44:36 +0200
In-Reply-To: <3e135fe0-4ef9-45be-a962-d131c8a2e9e0@lunn.ch>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
	 <20260707-dwmac-mediatek-mt8189-v1-2-17f345eaaca3@collabora.com>
	 <3e135fe0-4ef9-45be-a962-d131c8a2e9e0@lunn.ch>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Andrew

On Tue, 2026-07-07 at 14:45 +0200, Andrew Lunn wrote:
> > +	.peri_eth_ctrl_offset =3D MT8195_PERI_ETH_CTRL_BASE,
>=20
> nitpick:
>=20
> Could the naming be more consistent? offset vs base?
>=20
> 	Andrew

Ack.=C2=A0

The commit description and subject also use offset terminology and not
base so better keep the consistency.

I'll rename this define to MT8195_PERI_ETH_CTRL_OFFSET in the v2
version and do the same for the MT8189 one in patch 6.

Regards,
Louis-Alexis
