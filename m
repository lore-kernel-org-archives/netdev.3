Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFF439004;
	Wed,  8 Jul 2026 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512363; cv=pass; b=WYP9O3qh2HSVKh5ptHe/CE2pdHf9PXEarZIXu3xMby5cWuPYca5KUgItN1eH+4bCMQFf+SAK6WRG4q+mJA+AEKeUO8lNtzplnKzpDyRMBbn7anAYS4tgG7AY6O8zF1xUAz1ri91r9QMOq2bxoKK3skEjCKac4st5VqDJuFhC4eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512363; c=relaxed/simple;
	bh=6MsS/5ImLavNv/BfJxFCPsCrHDT6SeV4eEKuOQYGJ/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3KEBofqGP0Wgk+wsydoAXU6XWPMHaH4RmDCCC131ylgVUSeIP721iNmTHxC5Uc0wMvckEyaQTbPzKJ9+pv3fP/6rrGox9J3soudBcUyAAISnv4xI5AmhjO9e2g9LPo6zjAajJB6oxVFBQl+15h9OWVGaWCPLaIeZqQ+nYDyhWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=EL8T/+B7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="EL8T/+B7"
ARC-Seal: i=1; a=rsa-sha256; t=1783512307; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KvgWjgnVrtF6+ZkBWicFziVYuQdsIssCDuicOCsak8yQIYN7+5NGdf+ouUluqMO+Ev9SpCAtLa9UAT0ZMlgXiSB9fnXQvS3VTwuC0nWRDjuzSKl2xyNx2lP4/AACMn9OXW18m83oYXQSvoABm1Md5du7KWpgypvrj/KL/C/BvOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783512307; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wGYZTikwg2rXaLxaDX2K7Y9au6mX/qYf21+84FQdF+0=; 
	b=i+SFhQOt8b7X+gb4HX6jliFLSEB9iWLysvFJn85UUCNPBSUlqm6LfKn81LjB2ZHGWpqst9XokiDCZIokBV4eByx9ip9FUP+H/CCPbfSzyqN+p47WVR2x96GqZ1hz6NZyIuQ+FKj317l4DDPoEhyS7bJN1g38dA+n5857+d9hjZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783512307;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=wGYZTikwg2rXaLxaDX2K7Y9au6mX/qYf21+84FQdF+0=;
	b=EL8T/+B7liCUlfZVaMPg9+sHHWJLi6JR1rw48kEi/26KZG9GVaSE91tpGn8QaUwq
	zOQx89xA1YldfIIOlBnXMApdwV0+nR1dNcGKgWuVRwjL5ACuITyd4pP7q5KXz7I3mqp
	3q+Jp1BO50LeAAOOYScLmdFpi7obyJAdCFf/uy1o=
Received: by mx.zohomail.com with SMTPS id 1783512305076652.4555392247563;
	Wed, 8 Jul 2026 05:05:05 -0700 (PDT)
Message-ID: <658a04060e5c415af97dcc84284ab8962d1b7348.camel@collabora.com>
Subject: Re: [PATCH net-next 3/6] net: stmmac: mediatek: rename MT2712 and
 MT8195 variant methods
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran	 <richardcochran@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Biao Huang
 <biao.huang@mediatek.com>, Maxime Coquelin	 <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: rmk+kernel@armlinux.org.uk, kernel@collabora.com,
 netdev@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Date: Wed, 08 Jul 2026 14:04:59 +0200
In-Reply-To: <5dbd217b-8df5-42cd-9197-36e0fb91ffe7@bootlin.com>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
	 <20260707-dwmac-mediatek-mt8189-v1-3-17f345eaaca3@collabora.com>
	 <5dbd217b-8df5-42cd-9197-36e0fb91ffe7@bootlin.com>
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

Hi Maxime,

On Tue, 2026-07-07 at 11:05 +0200, Maxime Chevallier wrote:
>=20
>=20
> On 7/7/26 10:21, Louis-Alexis Eyraud wrote:
> > In preparation of newer SoC support, rename MT2712 and MT8195
> > variant
> > methods and sub functions to more generic names.
> >=20
> > Signed-off-by: Louis-Alexis Eyraud
> > <louisalexis.eyraud@collabora.com>
> > ---
> > =C2=A0.../net/ethernet/stmicro/stmmac/dwmac-mediatek.c=C2=A0=C2=A0 | 32
> > +++++++++++-----------
> > =C2=A01 file changed, 16 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > index 0cabab4fd89a..28e87990b0a1 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > @@ -110,7 +110,7 @@ static const char * const mt8195_dwmac_clk_l[]
> > =3D {
> > =C2=A0	"axi", "apb", "mac_cg", "mac_main", "ptp_ref"
> > =C2=A0};
> > =C2=A0
> > -static int mt2712_set_interface(struct mediatek_dwmac_plat_data
> > *plat,
> > +static int set_phy_interface_v1(struct mediatek_dwmac_plat_data
> > *plat,
> > =C2=A0				u8 phy_intf_sel)
>=20
> What does this naming of "v1 / v2" refer to ?
>=20
> I personally don't find it much better than the current one prefixed
> by the SoC
> name. You still end-up using registers that have the "MT8195_" prefix
> in their
> names in the 'v2' variants of these functions, so it still sound SoC-
> family specific :)
>=20
I agree.

In a work in progress version of this series, I had renamed all
register definitions as well (to remove the mt8195_ prefix) but dropped
the changes because too much difference for little gain.
I kept this patch but it does not really improve the code.

> I'd say you can keep the original names as-is, or if you really want
> a rename,
> maybe use the mt81xx_ prefix for MT8195 and MT8189 ?
I'll drop this patch in v2 to keep the existing names (and smaller
changes).

Regards,
Louis-Alexis

> Maxime
