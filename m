Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66436488203;
	Thu,  1 Oct 2026 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860429; cv=pass; b=Zed8+KIpjvajXRMUra4npz9S3Nn/D3Y6BpoIdvnvILE1eK+dCFkBG0S+3bnGS4/1oHjMMHOirTGyrDP+IEp+xr+4y/zb7rJO4YzC3no7gWnxPbgLA/QKR7AgBRNYQZ9ULToJMcZoYSm6nRj5Gta1k0AzfQXmQT2p+x54OKSuuUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860429; c=relaxed/simple;
	bh=yb9TIGDgeZFCPu4ArY1ZqKK0e4HMHQgLsozLDps0YOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OnAAy2dCEjguXlOBgevm+vX1ystDcxLXSIVaylFRsRrU/BxIUbkNfhbpwsT4V359uGNaMTv/SO8xA6fAFrgBHJrZP2OClB7W4Da0gRV0t1qCidD/HTsNPziy0cT9+0pHJQpbwSY0GlNzwY+5uizIabyXANVb2fY6FqWjGrcV2CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=a85NZ1qL; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="a85NZ1qL"
ARC-Seal: i=1; a=rsa-sha256; t=1790860388; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bawph5s96Kai3wqlDMEC60ATyaNTKtJTHa0WO+6hfiOMm6Z4LC5gBkaYQsJ8vUb4OcuQY0q66/qYABrRwZItYGkYKf0FYu8ZssmmWs7qx6c2FWGZq4nBArYevF3fnU9HGoIOERlEkbWKh2AO4kgeIjAl0Qd6C6nNUbzofz8F6AQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790860388; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yb9TIGDgeZFCPu4ArY1ZqKK0e4HMHQgLsozLDps0YOQ=; 
	b=MXWI2QAx4o+nUgmIxyzuFOZLecMWCyIYAGgZnidZ1toI4t793Hk0clikWrmVf5dYsZJlbK3eFZVWXUeAelbSY/ffvfBDKdlf9ilmuv8lhd4kVuVl6x3mzg+NzyNzH0FIisF4ak+gWy5sgqcw124Ogu/CnctCZnTFhkH8SA9rehE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790860388;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=yb9TIGDgeZFCPu4ArY1ZqKK0e4HMHQgLsozLDps0YOQ=;
	b=a85NZ1qLDVPYiYMxWxaLgRqOmu87ciHLp0gysp+DDKvlqXXaRlL5iXwzDPMV1yci
	MNKcJvfJxCQhsqVM5wDwlg1IxICuhW9pXL8//s4w/SrlE4b+8TvkPS88pH49mtFpDoV
	O/YqR9Ez+PnW+S7mhSRNqmTZ5Qki9d/+sIgMGdDE=
Received: by smtp.zohomail.com with SMTPS id 1790860388058520.321937422743;
	Thu, 1 Oct 2026 06:13:08 -0700 (PDT)
Message-ID: <edfe9ef6680fd5de35de0c021302381e63d9e3de.camel@collabora.com>
Subject: Re: [PATCH net-next v2 1/7] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Biao Huang
 <biao.huang@mediatek.com>,  Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue	
 <alexandre.torgue@foss.st.com>, kernel@collabora.com,
 netdev@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Date: Thu, 01 Oct 2026 15:13:01 +0200
In-Reply-To: <20260929-shrewd-rampant-shark-98e87e@quoll>
References: <20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9@collabora.com>
	 <20260924-dwmac-mediatek-mt8189-v2-1-430bd74d5ef9@collabora.com>
	 <20260929-shrewd-rampant-shark-98e87e@quoll>
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

Hi Krzysztof,

On Tue, 2026-09-29 at 09:36 +0200, Krzysztof Kozlowski wrote:
> On Thu, Sep 24, 2026 at 09:23:24AM +0200, Louis-Alexis Eyraud wrote:
> > +=C2=A0 - if:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enu=
m:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - mediatek,mt8189-gmac
> > +=C2=A0=C2=A0=C2=A0 then:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: MAC Main clock
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: PTP clock
>=20
> snps,dwmac schema expects the second clock to be the pclk. Why is it
> missing? This should be explained in the commit msg.
>=20
> Best regards,
> Krzysztof
>=20
Indeed, there is something incorrect.

I looked again at the MT8189 datasheets and there does not seem to have
specific peripheral clock for Ethernet MAC in the SoC clock list. The
paragraph related to clocks also lists the mac main and ptp reference
clocks as the ones to turn on. There is also another RMII reference
clock, only needed for RMII case, but I removed from mt8189 clock list
in the bindings after v1 review ([1]).

But at the same time, the Ethernet MAC block diagram, present in the
datasheets, shows this IP is interconnected to the rest of SoC with AXI
and APB interfaces (and in MT8188 datasheet too).
There is no APB related clock that is specific to the IP in MT8189,
contrary to MT8188 or MT819. But since it is on an APB bus (likely
shared between multiple IPs), then there is a bus clock for peripheral
access. Describing the IP having it makes sense (and for AXI too).

So, in order to resolve this issue, would it be OK that I rework the
MT8189 clock list to add "axi" and "apb" clocks and reword the commit
message with additional details on clocks?

[1]:
https://lore.kernel.org/all/b810b9cd-8f5e-4c9d-8496-908aae55dac1@lunn.ch/

Best regards,
Louis-Alexis
