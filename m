Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789827;
	b=BcQzJNgInqxbHH+S0A4vFZsaHbvfKrIs5c9DVBZU5XwengFRkthoSu4GZhQg8ceMkxLB
	 oj56DslP5+jNqIN9ScPMaRTtOu8252a+lPsVwRUxtPN3Rg36EJjYz0mYQFLvP0HVKRH7D
	 OUzOleaS6z6wHhQu5grzypenMTByTnHcO6ufZHYtb53WdDiZ83V2vYXwjFyKzGcehPuRw
	 DkOggASXTh5VPTMoQdcAyVLcewKxR6k+JJVpc2wmOCXJaFB5C7OUCnodCG+7UL01tGnhS
	 fUvLHCDmnAygTgYn6+tZTiYaPTU6wp9CAZngRoz+NouP2x5PY+3nv1hpZnDVxgPtW7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789827;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2xX9iJgWUUUQL+Ex8TMZWoceQZkaiq4TOsPi12PIbz8=;
	b=J3QKgu5MrRptYtLfUFHlWGMYLuPfoTMoVgISq2lnYXWzsnEfiXp3229xEevBdMzyheUA
	 8M80gyjHiOCPq7NMpLsRpW9qjY4wzPnZO2CbTrgLgIn7fjlfDpyTUnKJinljWPWi1pW7F
	 bJ6h2DB4DEFppR0T+1GxexoEZS8OLpzIwiamarbE9GzRThUIADjduRZD7voGflT+P/VUj
	 U5Uv3lwsOWxrY2yPDdAUKLlb3ykHYPS+k5vSz7/ZIbtYFxqOIqqrpnJDNF/rv3I+KNGnM
	 ewHH9uMqchN+PpNuMs92Oidtm5e39rScy7+YaTSa2hZt2xy8s/vrbwo0B+JSvFTsCRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6mCxqST;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F6606A332;
	Wed,  4 Nov 2026 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6mCxqST
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE8A1F00A02;
	Wed,  4 Nov 2026 10:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793789826;
	bh=2xX9iJgWUUUQL+Ex8TMZWoceQZkaiq4TOsPi12PIbz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z6mCxqSTqunXa3wblksRl7na80ibmakppv+yxx/tiI6wOK5l6rTFAmDO7Bz79jHXA
	 4GLIcAg0/WGbOvCGWuIHVi1zInQVtTFYHRpfoIYUZwI73eOeGiPPUtZdb1Yu2/Nq2Y
	 WazMN+VfYs1j+TUvDG+WelwM7gwdN53OU4WW5WNKWehykINUEkur3l9UIyBzpSAGM1
	 5TSxKbI4U3aiQvGMSfwJ9PmB9pFZ7NFDD+DQDf+d6R/Yftk4V/zd1A52rfoWQXQK+o
	 Yt5cQmE8SyPLSeatcguU7zJeaWJ6fNuCvPl5p5t1o0cau8AaXXcQ++E602mBmRFHjC
	 ewrJd1KX0Q+EQ==
Date: Wed, 4 Nov 2026 11:57:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Biao Huang <biao.huang@mediatek.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Eric Dumazet <edumazet@kernel.org>, kernel@collabora.com, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v4 03/10] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
Message-ID: <20261104-passionate-illegal-wapiti-6591cd@quoll>
References: <20261103-dwmac-mediatek-mt8189-v4-0-c86c14fc50f4@collabora.com>
 <20261103-dwmac-mediatek-mt8189-v4-3-c86c14fc50f4@collabora.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-dwmac-mediatek-mt8189-v4-3-c86c14fc50f4@collabora.com>

On Tue, Nov 03, 2026 at 11:12:08AM +0100, Louis-Alexis Eyraud wrote:
> Add new compatible string and clock definitions for the Ethernet MAC
> IP found in MT8189 SoC.
> 
> Regarding the required clocks, the MT8189 datasheets list in the
> paragraph related to this IP clocks the mac main and ptp reference
> clocks as the ones to turn on.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

