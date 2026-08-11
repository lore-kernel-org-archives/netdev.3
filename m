Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B463BBA0E;
	Tue, 11 Aug 2026 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457119; cv=none; b=LxmeicwMxbTgbGHbEurHCTOpZIq0Pjd6HHLwbg8jIjc3Wkz0JwAaHmX5D8F1SQu2cSNE/a+bNrCJG++9lTC9McecbzLZUqGERdDvsSoWRWZW5K1y7ltyQfYkxA4/W6rFtELGDua2cLo2Z+3K57kxgLXC+rvNGVuYZkrtLyXssfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457119; c=relaxed/simple;
	bh=s1ldxihmBBwEekfbtgcXzeBxN9SQBtRevr4lPnLkUBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl3k/ASOi/tG9B/vrfQmYNfnbYPy2v8XEpCUf4uKWKtQJ9CJ7rWRtkkNnzEYT2N5kcX0rWi9qRv689ZyJ1v1+C3U9wozAeOKDTIQa9Ep6j1Zp2qzKy8kT0SEIBiWLbMG79S9ZLUz08N9lHclxAEd+rNXI28QFnfbGR4grlbKWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1URbrD1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1URbrD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E651F00A3E;
	Tue, 11 Aug 2026 14:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786457117;
	bh=5CMmNJw8xFbOYotNubdIBdGOFgRK52FMbuu+80aIZG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M1URbrD1gMdJG5zlyokh+QQOnDsI/n7YqbM4QtIEp3ghle3Pzw6gUlcr5ITVnZQva
	 yx7HJ8OC+6kcFQSaEYf00wuGA96E+PTAKSBUHPtDfHfzM/enA38tNhmYYm+pcwPPt5
	 25Ze8FJf6DVLepBT6boyvz6RnEPXB89I8Qprnxi4imwSJD2wXtHO1mTUpUEXhHpQq5
	 mgksTZ7uSJ02gf+GMFFlP+FKm+hOAYI9PyVhikZ6adgOl4tpjSX1jpj41wtUBFc4PX
	 ydFgIb+ksRzINpTjBz43qoNxbTyI109utnJQNyQZ++OZZ9qzNywE/75t9a4+4+iNXl
	 SPWPUdIeM1d4Q==
Date: Tue, 11 Aug 2026 09:05:16 -0500
From: Rob Herring <robh@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: devicetree@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mailing List <devicetree-spec@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: net: add nvmem-consumer reference to
 network-class
Message-ID: <20260811140516.GA2090384-robh@kernel.org>
References: <20260802214354.490074-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802214354.490074-1-rosenp@gmail.com>

On Sun, Aug 02, 2026 at 02:43:54PM -0700, Rosen Penev wrote:
> The nvmem-cells and nvmem-cell-names properties are used to supply MAC
> addresses to both wired and wireless network controllers. The wired
> hierarchy already allows them through ethernet-controller.yaml, but the
> wireless hierarchy (wireless-controller.yaml -> network-class.yaml)
> does not. As a result, brcm,bcm4329-fmac nodes using nvmem (e.g.
> bcm4709-linksys-ea9200.dts) failed dtbs_check with:
> 
>     Unevaluated properties are not allowed ('nvmem-cell-names',
>     'nvmem-cells' were unexpected)
> 
> Each wireless driver otherwise has to add the nvmem-consumer reference
> individually (qca,ath9k and mediatek,mt76 already declare their own
> nvmem-cells/nvmem-cell-names).
> 
> Add the nvmem-consumer reference to network-class.yaml so all network
> nodes inherit the properties at once. Wired controllers keep the tighter
> single-cell, mac-address-only constraints via ethernet-controller.yaml,
> which still apply alongside the relaxed class-level properties.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/network-class.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/network-class.yaml b/Documentation/devicetree/bindings/net/network-class.yaml
> index 06461fb92eb8..f7c8e24016f7 100644
> --- a/Documentation/devicetree/bindings/net/network-class.yaml
> +++ b/Documentation/devicetree/bindings/net/network-class.yaml
> @@ -43,4 +43,7 @@ properties:
>        maximum frame size (there\'s contradiction in the Devicetree
>        Specification).
>  
> +allOf:
> +  - $ref: /schemas/nvmem/nvmem-consumer.yaml#

This is not correct as I explained in the prior patch.

Rob
