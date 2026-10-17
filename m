Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D65350A0F;
	Sat, 17 Oct 2026 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792259201; cv=none; b=vFe7/veeZJgodu29z2k9RE1vahToCPdJ58UraupNQSH21Bpu5S+/usPRzDtY9HJE2O7fPaRNs9uq4fDtQVovJKdKR2OWIg906KT6pORvefMLY1r/AJP8yvIWmj2UVH9Tzx3Y8qoQ7eZrUQV0pLc2LkzARr77J8pb1AK1DnqnSSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792259201; c=relaxed/simple;
	bh=bZjHxjsAauUGUQBnmAL0rIzC1kDQWLvEk4j8mcjzJ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sx/ZadEWNEmposiluDS9s5HUDcsLjAqmSjgpqh+in2QLfJ2GNt4WZODtvpza+vWsWWV4C5CaiMppvIyEKsLe8Cpr9YAvOanDsXH/HE7X/Yvhu3vRhuq+Gu0Twf7S3V9nvSCp6hKZqZdVmT+gla9cIPlbVwDYbNkGLubqQisz5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1ccYreF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1ccYreF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF90C1F000C6;
	Sat, 17 Oct 2026 17:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792259199;
	bh=W0pT3v1bP5u5egIRZK8Pll14PDueEtMuF5Fy1J42OkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T1ccYreFRLXizIIFK9f+52h0P5q33zrnJPciwiNz7DB98X9XEcFb3C+pypdLey462
	 xL0UALMtlGysgv45uecuQEtImEA54aqWjcmLbLm2U5VlG8vOgYVYcSXI4MyY00N5gQ
	 Fu7RMxYhROAuvoI4RQ44m4X72KKHOp6cl48GEtqklQy0XZX5zPqkLf57tAHLl9+g7B
	 bzWVHvsrcWVGPPU6KoFCk9mWX/dA3SyiNJw1H82u4Hz6Nwk8i+0pf9VRjFPpZMAyX2
	 x7Hckhd7G1Rl9Yiy03KfH/p+ab6lEudh5HfE70jBE1JJOroTX4G4cc+as2IbJZ4u3V
	 HH6eMqZ9sLziA==
Date: Sat, 17 Oct 2026 19:46:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Biao Huang <biao.huang@mediatek.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Eric Dumazet <edumazet@kernel.org>, kernel@collabora.com, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v3 1/9] dt-bindings: net: mediatek-dwmac: fix
 unit in rx/tx delay property description
Message-ID: <20261017-imperious-prompt-wyvern-6cb00c@quoll>
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
 <20261016-dwmac-mediatek-mt8189-v3-1-25daf2bbcf35@collabora.com>
 <08b7abcf-a738-4ad8-956d-a6205046151e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08b7abcf-a738-4ad8-956d-a6205046151e@lunn.ch>

On Fri, Oct 16, 2026 at 05:33:42PM +0200, Andrew Lunn wrote:
> On Fri, Oct 16, 2026 at 12:31:05PM +0200, Louis-Alexis Eyraud wrote:
> > The "mediatek,rx-delay-ps" and "mediatek,tx-delay-ps" descriptions say
> > their values are in nanoseconds but their names with the "ps" suffix
> > suggest it is picoseconds.
> > They are in fact used in both driver and devicetree as picosecond.
> > So, modify the two properties unit description to fix their unit.
> > 
> > Fixes: 150b6adda6b1 ("net: dt-bindings: dwmac: Convert mediatek-dwmac to DT schema")
> > Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> 
> Maybe this patch should be for net, not net-next. Documentation fixes
> often are. Lets see what the Device Tree Maintainers say.

It has no real impact, because the schema is what matters, not open
text.

Anyway, regardless:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

