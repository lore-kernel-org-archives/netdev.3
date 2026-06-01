Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6523438BF;
	Mon,  1 Jun 2026 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349648; cv=none; b=VZ+8YbT4JxXuEnWUnF0PVkKJeBZ1t0ZT0UoHVMlcbC0JdumuGp7etQaUuf0Zs82fjyNmNMMZc0ubPZwpbKzNbUFxVDpQEqHyw1XyRbz33zu6QL0hk/Ab5RorGDohTdwyFH5ALgstMRQwkBQ9DThia4NKu6hOXuCBs1PwgYprpdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349648; c=relaxed/simple;
	bh=NRYlCpdmqzmlsxcy7X6opw6mtX5AoHH+z2H6+eNgAw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTl919pF0ktBRE8Nfu993XBH/tKuLsLbKaLfv2Qgd1cxXnMnAfvsx9AWIJzntTfrrgejIp8Rpj/OFuXStpQH6Njx7V0XXXkm0qHnxyMz7IQ2fF5/TDsGy6ePfgBiynz0HPwO/S0+yLVktkS+zhg1wXeen4zUc+CTATKQBHnyY44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ2RPfD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ2RPfD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE081F00893;
	Mon,  1 Jun 2026 21:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780349647;
	bh=ZKKpXcdBFmynzzVydkupi+5KRs0qIrPSOPaKc+4iIZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZJ2RPfD8I4UwelLYMFUHasUL6X6gINo4dvCqshX6JQ8A3Yhvrh56X5YFTKHXarAiG
	 Lfmleo4yrJFdVn1+0/6g5vu93BaTnUWPKfd6GZKSa0iF7bxWgp+m4yySl821cCg/xb
	 XPMihgYXdAGgoQcu6P80cX6a4CBgEjjbV1SBwDE8y0RyDHptTR8ltvFgI00R/M0ic5
	 VkbCNE7y9avDSzTb1lNq5bSIZBNJ62/GJX9XLo0Wcka95YKLkHEav7/kqRZnAWeAgp
	 NECb4Mass4UmFriQlCB79gTW/LAvHpkjGQu0LLyUj+DHzNg4UXTOroGyNYGHJjpbYn
	 IxqX5ON7R5QAA==
Date: Mon, 1 Jun 2026 16:34:06 -0500
From: Rob Herring <robh@kernel.org>
To: lizhi2@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com, sashiko-bot@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH net v2] dt-bindings: ethernet: eswin: fix hsp-sp-csr
 backward compatibility
Message-ID: <20260601213406.GA26933-robh@kernel.org>
References: <20260601032852.961-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601032852.961-1-lizhi2@eswincomputing.com>

On Mon, Jun 01, 2026 at 11:28:52AM +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> c36069c6f46c added two optional cells to eswin,hsp-sp-csr, but
> omitted minItems: 4.

Please run checkpatch.pl and fix the issue it reports with the commit 
reference.

> 
> As a result, dt-schema implicitly required all 6 cells, which
> broke backward compatibility with existing 4-cell device trees.
> 
> Add minItems: 4 to preserve backward compatibility.
> 
> Fixes: c36069c6f46c ("dt-bindings: ethernet: eswin: add optional TXD and RXD delay register offsets")
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260519022334.35742C2BCB7@smtp.kernel.org/
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---
> Changes in v2:
>   - Reference c36069c6f46c explicitly instead of "previous change".
>   - Improve commit message formatting and line wrapping.
>   - No functional change.
>   - Link to v1:
>     https://lore.kernel.org/lkml/20260525052441.1637-1-lizhi2@eswincomputing.com/
> ---
>  Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> index b66ae6300faf..65882ff79d8d 100644
> --- a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> +++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> @@ -84,7 +84,8 @@ properties:
>        This reference is provided for background information only.
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
> -      - items:
> +      - minItems: 4
> +        items:
>            - description: Phandle to HSP(High-Speed Peripheral) device
>            - description: Offset of phy control register for internal
>                           or external clock selection
> -- 
> 2.25.1
> 
> 
