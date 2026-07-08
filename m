Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDB42EED7;
	Wed,  8 Jul 2026 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783510642; cv=pass; b=cnWnq/3caKbfFkfixJbGgnycoqMnteUHKAtDgtMcE8crb2zoFptnvEGSvT0cUjEN5N3S3kuitrNNJOHcYuYpFyR1PHHV/KwCV5s6m/a2AhWijGYwsl3WfZFVl7mQ/BpiHq1cEM+osHS2VIMyYsgHsDpxXAVIWsk0iSU3tQlOSoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783510642; c=relaxed/simple;
	bh=MQjOHxd6PAl5dz6llEhjB7twiwDcwseiliYt9HRWP9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f8QhISYF2X5aqCHmwwptDH7JDoI8E6dSWbCFtcrKvCKmgXivqMhhdbcqv49GwAAQ8pcsooeBZ5NYynpZGebs9IV6L+M+UqBQZcaeGDgdMIJNRLHRLcA2zjTUExfzAZhfK11To6GWGdcGsc9dUpQQAyEuCdal3G8yyNUYNf61gbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=SgpZaz1L; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="SgpZaz1L"
ARC-Seal: i=1; a=rsa-sha256; t=1783510592; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fiM838OSJXxgoJdBoSWbg9eOpW3CqgvOWxKDidB7HrEtGzON8fr84bpH54/eWTMokKJGeHDcDC3nnYVk4PXKtWKRZ8YuoHs69TJbi8n1og/TFEs+dgzdDAJ2+0DE/KcqDXEHYoeEU9AYTGFqDed3+FOib+ScgGx/A8oJGBRFiak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783510592; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gcY7T0lP5le5CCNf+zhfFY+iI1N5QvSyJZnptU0Oys8=; 
	b=Gb1vx0D3oEAGSswxky62uf/lSq8w8KZrVtlO0xcj6NALwgSI8elGNHJix84Q3+ITAfHFzoZc9fEBQyukiWVOJkdmrVr0HuZauE7AYvG2itYZUaKYdFplRrq4EReb8NcMpzEkeZeiDqIab3npvRk3Fr2+SKleQLi0R6yMI711yaI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783510592;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=gcY7T0lP5le5CCNf+zhfFY+iI1N5QvSyJZnptU0Oys8=;
	b=SgpZaz1LyvYikKA5/5BCe443LYNenKVSqHw4XguZa+HpuQiaQYXH8hvKhF1ve3KN
	ZZoSo3RXdwCGd6wE8gqO29opjDcsyyTT+lqZyJ5l1iegYaA+7VTNePrzVIX43pIzAZs
	LmElpjbQ+VBGQ+Mc7vZhhZGbSXxNb2Y7Y6gzMLQI=
Received: by mx.zohomail.com with SMTPS id 1783510588746822.2863328296761;
	Wed, 8 Jul 2026 04:36:28 -0700 (PDT)
Message-ID: <8304b0a704c8db697767584b8c34388f07ba401d.camel@collabora.com>
Subject: Re: [PATCH net-next 1/6] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
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
Date: Wed, 08 Jul 2026 13:36:21 +0200
In-Reply-To: <b810b9cd-8f5e-4c9d-8496-908aae55dac1@lunn.ch>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
	 <20260707-dwmac-mediatek-mt8189-v1-1-17f345eaaca3@collabora.com>
	 <b810b9cd-8f5e-4c9d-8496-908aae55dac1@lunn.ch>
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

Hi Andrew,

On Tue, 2026-07-07 at 14:42 +0200, Andrew Lunn wrote:
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
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: RMII reference clock provided by MAC
>=20
> Since this is a MAC, it sounds like it is consuming its own clock?

In the driver ([1]), this clock is described as being only used and
needed in RMII when MAC provides the reference clock, and useless
otherwise (RGMII/MII or RMII when PHY provides the reference clock).

Its use and configuration also depends on the "mediatek,rmii-clk-from-
mac" vendor property ([2]) presence in devicetree.

Do you wish this clock description be reworded in the dt-bindings for
both occurrences?

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/dr=
ivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c#n480
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Do=
cumentation/devicetree/bindings/net/mediatek-dwmac.yaml#n108

Regards,
Louis-Alexis
>=20
> 	Andrew
