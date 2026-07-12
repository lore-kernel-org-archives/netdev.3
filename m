Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4EA23183C;
	Sun, 12 Jul 2026 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783867022; cv=none; b=VW+U7q7MKHoRaylTZDHPMEV0kLU//4tb6nszy20Jqzd+rzgfUdsBW3MkIb/yinopdjSrQxb6LzvvtD1eIszVvy9+OeKGHn1g7pFRFd72psvyU2fWeWYuseQ3lAJJA3GQJair7BTpxnj6rW1Lg2I6DRhgDfslRplpNrl27+5GDWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783867022; c=relaxed/simple;
	bh=NOlCmulerS36hLuK8ycqNlA8BWE/5+xrSWghSmc91gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRzC7h3AQhlpEKv43i3gyRqFOVMiEvXiNOJ27aGxgmFrssF5o/tJoD7Afll/yyyHFYJ/VZ+fpo8HbZRpliFG9Vp3XpVDCKEQBzuFuOysPqhUnlBnB3Gpi/dQs+pqyCIrMbtBxn925z6j9xWCM16UP6g2CWR5jRxE6hW8s9CVqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li45TgA1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li45TgA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389BD1F000E9;
	Sun, 12 Jul 2026 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783867021;
	bh=pmSC34Df9sJwJgpBvXLUH1wyBX5cNGCOC9TM/UI+Np4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Li45TgA1la4VR8WDqwbcAj0SQ5f4lweEms7CnWe3laFL93TiZ5RXcogkxFVgPrty4
	 Kw5+PmjOq0Ot7YLkvUXW4aGOKGLAK8/2y9UJEU09fkVO46mZaDaRrUKmLhhQcdwaYl
	 Ooc1WQWcparey8ZxSRyvu505PmhPOcE+alU9ANihp0w0C0+nRuVsyeDLstBFc658cL
	 /WD/7PM+xXxIQ87PzDlQurkduAexHnBLOqZER7EEPjMBRzhigeRmRnHjqHc1jNMlV8
	 UnxG0i+8p6qO1XbdB0uCZjRQQfSWcqyoBkQTjIAwsjZwdeRsrKbHCmfmH9rlPwkDct
	 PuT3uDhw3s/dA==
Date: Sun, 12 Jul 2026 16:36:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org, 
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	"David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, 
	DENG Qingfang <dqfext@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Landen Chao <Landen.Chao@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sean Wang <sean.wang@mediatek.com>, 
	Vladimir Oltean <olteanv@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: dsa: mediatek,mt7530:
 add econet,en7528-switch
Message-ID: <20260712-hysterical-thistle-prawn-9c81b5@quoll>
References: <cover.1783770059.git.naseefkm@gmail.com>
 <2133035bb22eacc8a0e21f86c0c800a45023ee01.1783770059.git.naseefkm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2133035bb22eacc8a0e21f86c0c800a45023ee01.1783770059.git.naseefkm@gmail.com>

On Sat, Jul 11, 2026 at 03:41:00PM +0400, Ahmed Naseef wrote:
> The EcoNet EN7528 MIPS SoC integrates an MT7530 Gigabit switch,
> memory-mapped in the SoC register space like the built-in switches of
> the MediaTek MT7988 and Airoha EN7581/AN7583 SoCs. Its four user ports
> are connected to integrated Gigabit PHYs and its CPU port is connected
> internally to the SoC Ethernet MAC.
> 
> Those three switches are MT7531-based, whereas the EN7528 has a genuine
> MT7530 switch core (its chip revision register reads 0x7530). The two
> generations differ in their register programming - for example the CPU
> port is selected through the MT7530-style MFC register rather than the
> MT7531 CFC register - so the EN7528 is not compatible with the existing
> switch compatibles and cannot fall back to one of them.
> 
> Add the econet,en7528-switch compatible, with the same constraints as
> the other built-in switches.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

