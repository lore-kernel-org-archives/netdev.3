Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6CD3F23B1;
	Fri,  9 Oct 2026 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535140; cv=none; b=BW8bNVPEetzcyAA8y4XFg8pxvvRO5IswgVNXtLyw0odyoPAi+lk/4RCDGrq8EwvlKyZ/BTMtwGEygd31WA5KDI7TZoOqEOZytpgR/NZbn7yJlr7P9EvV7fjhO0G6FH28LfzjqU9MBNP/HsKfTzKRmJ8Dk0paP86dEGjoksIZsDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535140; c=relaxed/simple;
	bh=7+Cf/AaTxbLmYEDtCQE75GxCYmkqk4cDoNDIVdmLi6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPhSzavZRPQ/q4P4ULm4V27xcPlNlOl8IAz6/jkFQr/twMrmVZGZrhEhbnl/plV2JN3d+RNnPpIdQGJ3DSJREDmZ2wWtbIvaoPplArG8RZkhl6wPEI4NQkrneRmVvSUqa9Hx2HEch1M5B/FZgTYQjIbOjJfzOge5l1PAKcoBLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGi2EQj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGi2EQj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02221F000FF;
	Fri,  9 Oct 2026 08:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791535138;
	bh=+2ksSPu2eoUDNq7v3hNGID9sRvWeLXBxpAnRk+ghzc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KGi2EQj9uJW1bEBhGD3f55CNQiBag4bypMM0sRPe+8cIMtR7ApAfXtNGtcauzSlHK
	 T+g3E//fO8i3L4sntZeheIBunZGzyfTSa2IIZ1o0h8wlCLYolBGetDQAHqwyN2KP0A
	 kOzReBm82yNTKojrQOa8LRFjKozr00qpFY1UL6Jt+e6flKs6QH0x1gXIE6im2bz8L6
	 wEyxt5EgaI9OV78UmR2nJ8y0GEiuYRndlVnGdqHoqGZtQCaTXKwmFigej6TS9Dklz/
	 CEh6mgIFwXm/zi4S+C/YfHgJinGRCjtBfgF+oMCxE5VJ46y5wFN5oaPOJez/wZ5ufi
	 MlQgRswb0wxLw==
Date: Fri, 9 Oct 2026 10:38:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, Luo Jie <jie.luo@oss.qualcomm.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lei Wei <quic_leiwei@quicinc.com>, Suruchi Agarwal <quic_suruchia@quicinc.com>, 
	Pavithra R <quic_pavir@quicinc.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] dt-bindings: net: qcom,ipq9574-ppe: Add
 IPQ5332 support
Message-ID: <20261009-practical-wildebeest-of-conversion-7c0e59@quoll>
References: <20261005152915.101780-1-mail@tk154.de>
 <20261005152915.101780-4-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005152915.101780-4-mail@tk154.de>

On Mon, Oct 05, 2026 at 05:29:14PM +0200, Til Kaiser wrote:
> IPQ5332 uses the same PPE architecture as IPQ9574, but has two front
> panel ports instead of six and four interconnect paths instead of seven.
> 
> Add the qcom,ipq5332-ppe compatible and constrain the interconnects
> and port nodes per SoC: IPQ5332 takes four interconnects and only
> ethernet-port@1 and ethernet-port@2, while IPQ9574 keeps seven
> interconnects.
> 
> The PPE core, EDMA and MAC clock functions are shared, but IPQ5332 also
> needs the GCC IM sleep clock. The PPE core uses one reset and each MAC
> uses three resets on both SoCs. IPQ5332 EDMA needs separate system and
> configuration resets; IPQ9574 uses one combined reset. Constrain the
> clock and reset counts accordingly. Keep EDMA resets positional, with
> the system reset first and the configuration reset second on IPQ5332,
> consistent with the existing unnamed IPQ9574 reset.
> 
> IPQ5332 EDMA has 24 TX/completion rings, 16 RX descriptor rings and eight
> RX fill rings, so the full EDMA interrupt set comprises 49 interrupts.
> Constrain the interrupt counts and ring names per SoC as well.
> 
> The IPQ5332 clock and reset functions are described by Qualcomm's NSSCC

How is clock relevant to this device? This is PPE, no?

> driver submission. Its sleep clock is also listed in Qualcomm's
> PPE DTS submission. The ring limits come from QSDK 14.0.1595.1665,
> qca-nss-dp hal/soc_ops/ipq53xx/nss_ipq53xx.h.
> 
> Link: https://lore.kernel.org/r/20240829082830.56959-7-quic_varada@quicinc.com
> Link: https://lore.kernel.org/r/20240110112059.2498-3-quic_luoj@quicinc.com

I do not understand how these clock patches are relevant here.

Drop links and paragraph not relevant to this code.

With this:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

