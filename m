Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD83A5E77;
	Tue, 29 Sep 2026 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667378; cv=none; b=MJ6PjkeScQJsxQZv1B8pNoC0ITc5YDPiZCjY6ipZaenj4mOIgzRvjlqpVDDwq3yQBz8PXjvtH6s8LXN6+bwOFlT8/WqfWw/7tGIA13MtMLpSRgRTFGX1tXZqzNzV9v8yBWX3/dMjOmC4XjZc2rz6BTg+vhgbelvs5dAxzDKAFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667378; c=relaxed/simple;
	bh=litOp2fgRmVYfKgCF6rOcWxj25Dc3iLSfAmpKYVqr9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRZpaYNsOVB0B7owCoZUM+UUknUC7PFwAWz6F64j65nU7Gz+709BMLXOxTNen3uf79ZHNdpVnoringWYQZIPiAKjqjoORSHp5hKFe/vCV1CxYBCl98Wr64Dvk2JemHnVsmtvhiAqZ8pRP4nGwqlTDjhNRsJUsoFbOEoTIjmFGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsD8jJ/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsD8jJ/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6861F000FF;
	Tue, 29 Sep 2026 07:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790667377;
	bh=VZVSFmMbuJ+Z0Kk8DUTwclrZMS7jCzgzpFtuI2vVojw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XsD8jJ/MLcyAEHp06qf20kH1KRgaZNob7ijuZiJWqFCh10pJhSeq4RXgvcbV7Ap0D
	 xfNUM/T1T7hGjFuhEIIZX3i9cttdsKKJkwmTMWD5DFpOFbMM+ak/npEdZOavVkE9bV
	 eEWPJHQWjOK2wWRdLeNtwr3HJagt7rlZzh3MTJf6hniSDAQs4NEF7xcd7ZHuq18gPl
	 8RZbx5Y4L43EZRG0AfNPqXeVRbFR8wkVQH3OkCRwxfm31vDciRsxetcd1Ad4S5wK4m
	 MMgI1z4AHaGfV6tfV7+D2NGXcW4XweB3mtCC8ee0hhLUKYtafTs2f+QW8UKlQlDttN
	 ARBNZhE9AbMBw==
Date: Tue, 29 Sep 2026 09:36:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Biao Huang <biao.huang@mediatek.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, kernel@collabora.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v2 1/7] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
Message-ID: <20260929-shrewd-rampant-shark-98e87e@quoll>
References: <20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9@collabora.com>
 <20260924-dwmac-mediatek-mt8189-v2-1-430bd74d5ef9@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260924-dwmac-mediatek-mt8189-v2-1-430bd74d5ef9@collabora.com>

On Thu, Sep 24, 2026 at 09:23:24AM +0200, Louis-Alexis Eyraud wrote:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8189-gmac
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: MAC Main clock
> +            - description: PTP clock

snps,dwmac schema expects the second clock to be the pclk. Why is it
missing? This should be explained in the commit msg.

Best regards,
Krzysztof

