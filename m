Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9374FDE7B;
	Fri, 16 Oct 2026 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165253; cv=none; b=tDsQ+IKf9xTiE5EW6LhDp0gd6v4WVnI951BeVFM9cWj5ppOkqY9HLVEWP/3PLYGx3JwudqAyhxu00qjsgzFjFDWVeNoHESP4Jn6SsmxzSFoDLN2FPmHQyvNBMvOTFnKqY2O4cqBCqKt7GBedqSO1/inalrqjSlgkLWTqa/Estv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165253; c=relaxed/simple;
	bh=PWKkcdsBBgYQxSU2/GWGHlKuFkpH4PAl87IVc32ausk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZHJmcQH3uVe+vltRAKPfl7HHjmCn7nmKIB9rHgsQM6wZ9GFfkyRD4R2EEM/IKBQtjleZsp5kW1mtAqNGnYaCOoxsYi0XwSR/44jmnENLFbfgFHugHfPr6/XuN4wGRHYHspNIftKTGqBHMVsWjvMnLRHeglUs4PtYJz9T4Gkk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nW8dNfcx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nW8dNfcx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zV1tkuQVhB7asiK+J7N184oVAmpF7qz9rFGuGv/mKyw=; b=nW8dNfcxTDYiFECGGfWoIX/Ku7
	sNm/7PDt5sXWvnWyXzhpOQ2gJNbHyuDrk9MvdSwog/lwmUtPRdYxf/cY8s5vrupvCYCd5nLhfXZkc
	T+HCLAIsl4EYA1mG6U13D3Fg74Ln3knSk4rATAMC7bC7iRz98pywJkmpdcpg8OX3tMa0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHk2y-00BArn-3k; Fri, 16 Oct 2026 17:40:40 +0200
Date: Fri, 16 Oct 2026 17:40:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Biao Huang <biao.huang@mediatek.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@kernel.org>, kernel@collabora.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v3 2/9] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
Message-ID: <b4950f82-0163-4482-9799-a5e3c6eb5964@lunn.ch>
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
 <20261016-dwmac-mediatek-mt8189-v3-2-25daf2bbcf35@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-dwmac-mediatek-mt8189-v3-2-25daf2bbcf35@collabora.com>

> Finally, update "mediatek,rx-delay-ps" and "mediatek,tx-delay-ps" property
> description to add MT8189 RX/TX delay stage divider values, as they
> differ from existing supported SoC.

These should be mark deprecated and the standard rx-internal-delay-ps
and tx-internal-delay-ps used in there place for new devices.

> @@ -86,8 +85,10 @@ properties:
>        or will round down. Range 0~31*170.
>        For MT2712 RMII/MII interface, Allowed value need to be a multiple of 550,
>        or will round down. Range 0~31*550.
> -      For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a multiple of 290,
> -      or will round down. Range 0~31*290.
> +      For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a
> +      multiple of 290, or will round down. Range 0~31*290.
> +      For MT8189 RGMII/RMII/MII interface, Allowed value need to
> +      be a multiple of 180, or will round down. Range 0~31*180.

Please make this:

For MT8189 RGMII/RMII/MII interface, this property is not used, the
standard tx-internal-delay-ps should be used instead.

> @@ -96,8 +97,10 @@ properties:
>        or will round down. Range 0~31*170.
>        For MT2712 RMII/MII interface, Allowed value need to be a multiple of 550,
>        or will round down. Range 0~31*550.
> -      For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a multiple
> -      of 290, or will round down. Range 0~31*290.
> +      For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a
> +      multiple of 290, or will round down. Range 0~31*290.
> +      For MT8189 RGMII/RMII/MII interface, Allowed value need to
> +      be a multiple of 180, or will round down. Range 0~31*180.

Same here.

     Andrew
