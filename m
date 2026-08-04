Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A043BDC4;
	Tue,  4 Aug 2026 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832654; cv=none; b=hposmlyvGED8VRIVHKl/gObLo0wMGGN8di6pceK04swZT8Yzuq0ibuv2WxSsb/IO/B7Q9zMqt646JCDJlMGJ4CVW14s2G2DJry6IEmRUXYCCvLM2FF7/x/RT2xwHd378WxjLGhX2B7nuUQOf/CJ8j01MkKRSB2KmtW+bAaZ0LyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832654; c=relaxed/simple;
	bh=Lt76thffd3mZtnsdCnCRHOUu6kFT/MlDL6+XbH1L9KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1Q3N7FKA/3oSOD43te7qeUq0hrEDRabivRcj6ZmKzcLrsPHjC4hOlgFiND3Mx1JzWGAORUHYsY87Irm6xCSYGCjDkUtBlR6y71ux7e2YFMi83rpj37icwIZH64hEmn2Izt0Y5oJNr5xVY49Vw38Ckoic8aqLSHYW7PVynDkCBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtt2kBIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtt2kBIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C519D1F000E9;
	Tue,  4 Aug 2026 08:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785832652;
	bh=/ANnNwuiKBF/aUFgJD9FvGP3u4zzcHHdF0EpQ0x5UgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gtt2kBIhV3IyXP1DQGKF2N6rh6iIS22g9uuMsXVt7URhuA5T+0CpX2lrV5HuMDKqj
	 Yxxj/tLJVdPywodJfjSp89XLs0ftGK4dnDH6Jo+kxPhvuLt7Oa8tdIYb2OxQA37TLx
	 452MnF2bSu854nnBVJY40Gm7QEEEzku0u5DTVcqYR9qNElthY/bJPzMvCjjmwVR4Uh
	 03bWlh70gQUHJ2nUTSKzoLlbYEQcbEgAHYgR993YYJ3RZ1yM9dLQwUKKgZzn+K7HUr
	 m9zGQjx1o2O4lecj6dRSik2sVF9OjwbPakxv4+qWlrP3q7vYRntg7715QHX2mxWuBY
	 zp5pNnlza8byA==
Date: Tue, 4 Aug 2026 10:37:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	dinguyen@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, 
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: snps,dwmac: Add
 snps,pagepool-tx-buf-quirk
Message-ID: <20260804-proficient-competent-wyvern-30ec60@quoll>
References: <20260803070513.4657-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260803070513.4657-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803070513.4657-2-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Mon, Aug 03, 2026 at 12:05:11AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Add a DT flag to enable use of page pool buffers instead of streaming
> skb buffers for transmit. This avoids IOMMU invalidate wait time on
> platforms where that cost is high, with the trade-off of copying data
> from the skb into dma-mapped page pool buffers.
> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 2449311c6d28..73045511446f 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -545,6 +545,14 @@ properties:
>        Enables the TSO feature otherwise it will be managed by MAC HW capability
>        register.
>  
> +  snps,pagepool-tx-buf-quirk:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:

You described the desired Linux feature or behavior, not the actual
hardware. The bindings are about the latter, so instead you need to
rephrase the property and its description to match actual hardware
capabilities/features/configuration etc.

> +      Enable use of page pool buffers instead of streaming buffers for transmit.
> +      This avoids IOMMU invalidate wait time on platforms where that cost is
> +      high, with the trade-off of copying data from the skb into dma-mapped

Best regards,
Krzysztof

