Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AC47A88C;
	Wed, 23 Sep 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160586; cv=pass; b=Y+zvzuGhfZ1sGPveiTwtkXUH/NEqu5v3V8AxRO7UDRVZ9Icq0TdZ9m+6x4WVpf9Jo095CMoZ49RbVeiUQZCH13OXL5QrnGEUQN8JJExvL9Irfxscg/Tl4KazzEDVG+1ZcVb7f0kyqu3SOhaw1pCAC+0GbL138BTTe2zrJQzTyYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160586; c=relaxed/simple;
	bh=0ta1gj6fwaYOVU9PpSfSsCZn3orkTbOVs+NGRtgFYO0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dpRloTdbSHe00rL8kuOe/wwCcxBl8kYK1Fy3e49SKZRoewPz3OWgQPxdqBDgZNDGuq2XVQo0t+1fxvJvpUdZ6VH85qucAlIMXFTB2vruBEhi1U904nU17rTDoZgjsxukB3a9r1/007hYadazaCV8E1n9EjjTp4f99ApKW1uA3G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=ES763K8e; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="ES763K8e"
ARC-Seal: i=1; a=rsa-sha256; t=1790160504; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FygdenF/a3cqko2v1rNYJGgc3uugEJLQnWzFHloFqqxc1H/pLjBxY4bBdoqXPAHy6lXi7FA7lZwb6bf4RW2VKg4JuZiT6sGDbtLIn6A96htNbISnIFZtzheMDj1ErNJFJfzFBV4elrJT/VYKP/McQg00MeDlADIDCEFjKbIm8m4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790160504; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mIg+mGPTkJrwKZp7jh3Yx1UEWvB7j/FRVm3hT3LKHP0=; 
	b=SkIH6qhXY6y8z7JgEy5AYF96UL8JZCp1C2PchQjedzrY+BKBq95nm107sll5GyYF+0KSf55Lintw2y4TU1BjKh5+5LWEtbcycAAd2N3aYIk4sMMv9SVhIxmSng0voD/wDIFcoPtXoOXXmTLk9TLHpJCE12f9Wmxoct51pfN6Eec=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790160504;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=mIg+mGPTkJrwKZp7jh3Yx1UEWvB7j/FRVm3hT3LKHP0=;
	b=ES763K8e7KJG7NL47SgY7vc05zHwXHwoNSAQS9VFTb7dYKFHRvNpmI3nYs8BQ9wD
	taFNsy/YIBgdS5RfE/4ACVbJkpqcJreLXdQGUtRvPHzCvg9fvA6vkhaBmsFmYzAaNW+
	fmrKephj8NJSd8ik//DrNaedeGo0yFDlNhIk6tc0=
Received: by smtp.zohomail.com with SMTPS id 1790160499035326.40614265928457;
	Wed, 23 Sep 2026 03:48:19 -0700 (PDT)
Message-ID: <7ebad26d21afabbf02e39d25c4491b1815a18865.camel@collabora.com>
Subject: Re: [PATCH net-next 5/6] net: stmmac: mediatek: add support for TX
 deallocation adjustment feature
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
Date: Wed, 23 Sep 2026 12:48:08 +0200
In-Reply-To: <e390664dc439043a43b6ded3c50c9a2bb5bbd2f6.camel@collabora.com>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
		 <20260707-dwmac-mediatek-mt8189-v1-5-17f345eaaca3@collabora.com>
		 <2a421449-01eb-4066-8c19-d554ff8e4f6e@bootlin.com>
	 <e390664dc439043a43b6ded3c50c9a2bb5bbd2f6.camel@collabora.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Maxime,

On Wed, 2026-07-08 at 14:28 +0200, Louis-Alexis Eyraud wrote:
> Hi Maxime,
>=20
> On Tue, 2026-07-07 at 11:11 +0200, Maxime Chevallier wrote:
> > Hi,
> >=20
> > On 7/7/26 10:21, Louis-Alexis Eyraud wrote:
> > > The MT8189 SoC has in the Ethernet control 0 register from the
> > > peripheral configuration (pericfg) additional bits to adjust the
> > > TX
> > > deallocation.
> > >=20
> > > In preparation of MT8189 SoC support, add its definition, use in
> > > the
> > > set_delay_v2 callback, and a support flag in the platform data.
> >=20
> > Can you elaborate a bit on this ? I don't quite get what you mean
> > by
> > "tx deallocation", this seems to have to do with RGMII timings from
> > the register access pattern, but the local boolean flag for the
> > feature
> > is named "use_stage_fine", I'm failing to connect all the dots here
> > with the different terminology in use :(
> >=20
> The data sheets I have, don't have info regarding this register, so
> I'll try to get more and improve commit and/or code description.
>=20
> I'll also check if the register definition name is consistent
> (downstream driver and upstream u-boot use this stage fine term).
> use TXC phase shift control bit (bit 22, MT8195_RGMII_TXC_PHASE_CTRL)
> to insert the 2ns delay=20
> The use_stage_fine feature flag could be renamed anyway to match what
> it does.
>=20
Sorry for the delay on this topic.=C2=A0
I did not get answers from Mediatek on this register until very
recently and as you have suspected, the description I got on these bits
the first time was incorrect and their usage was also incorrect.

These bits allow to insert a delay on TXC signal, to adjust the RGMII
timings. The bits 6 to 10 are used to value step (100ps per step) and
bit 11 to enable. So this patch inserts unconditionally this TX delay
with max value in MT8189 case and that is wrong.

There is an alternative way to insert this delay, as the MT8195 SoC
also provides a different set of bits (bits 0 to 5) which support is
already implemented in the driver (represented by
MT8195_DLY_GTXC_ENABLE and MT8195_DLY_GTXC_STAGES definitions). The
difference with the stage fine ones lies in the stage step value (280ps
per stage for MT8195), thus the fine term use for the new bits.
The MT8189 SoC also has these bits too but the stage step value is
different for this SoC (180ps per stage). The equivalent bits for
inserting a delay on RXC signal also have this same new stage
step value.

After discussing about these register bits use with a Mediatek
engineer, I was recommended not to use these new stage fine bits but
rather use the coarse ones (bit 0 to 5). I was also advised, that in
RGMII cases, when the link speed is 1Gbits, to prefer the use of TXC
phase shift control bit (bit 22, MT8195_RGMII_TXC_PHASE_CTRL) to insert
a fixed 2ns delay, and use the tx delay bits otherwise (for 10M/100M).
So, I'll drop this patch for v2.

Instead, I'll add new patches to rework the TX and RX delay handling,
to allow variants stage step values (the MT8195 stage step value use is
hardcoded in the MT8195 callbacks), and add the TXC phase shift control
use too.

Regards,
Louis-Alexis

> > >=20
> > > Signed-off-by: Louis-Alexis Eyraud
> > > <louisalexis.eyraud@collabora.com>
> > > ---
> > > =C2=A0.../net/ethernet/stmicro/stmmac/dwmac-mediatek.c=C2=A0=C2=A0 | =
25
> > > ++++++++++++++++------
> > > =C2=A01 file changed, 19 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > > b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > > index bcc0baef3f71..6b0a42b5839f 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > > @@ -37,7 +37,8 @@
> > > =C2=A0#define ETH_FINE_DLY_RXC	BIT(0)
> > > =C2=A0
> > > =C2=A0/* Peri Configuration register for mt8189 */
> > > -#define MT8189_CTRL0_TXC_OUT_OP		BIT(20)
> > > +#define MT8189_CTRL0_TXC_OUT_OP			BIT(20)
> >=20
> > Extra whitespace inserted here :)
> >=20
> Oops, to be fixed in v2
>=20
> Regards,
> Louis-Alexis
>=20
> > Thanks,
> >=20
> > Maxime
