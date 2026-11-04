Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789752;
	b=Yo0NDjdNMgEW3apqt9URwxfBLWLUfdiX5R+RltML808HFMvz22BwO/Ydu1TY93qbpDYR
	 AyI44Bxjy/OmN/PG5L+ajAWTaQQfeXipeSi+LQxMW7A3Nz5RworFPsBTdjSHsv88lIuY6
	 xLewlS6Q/jUbjwQrd1NgvR+Bgbynx2JVleJpDlIn+mzxes9k0S2OwDDcHnDuLGBXy5GrV
	 NfpRIxmuuu2EcBgA3DrP7oUY8TMM+2qL5qSEZRcRX5GNk6+u/r3DaSlHCD9tTtz2L1Ve9
	 n1XAe8o0edNa5lGaQ7v53Ir8pDg0xgiKrLZoKxEwocqifPCqg3J4Qr+693i92oV5L8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789752;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZmxlQbjY666CB2DpfDGRCp8x+UD5CCdq+P/PXnNUKNg=;
	b=VKOFL0w7BCwmwwLcx0Z0sMEs64Srs74Np1mfpR5hAcODYx+1bQQ06EQqjU513Wv3i6g8
	 HL7KuNOYVC3NBAMs/p4oMjxJum0E3hnpPNyG83OlB43kTzWclwgi4CwGuUfHChJ5OfyHk
	 O4f4o92rusVd0BiK+rakpiPCT66JDWIQ5/TpgJTxQIaJJhcwveYNDHYWekBVOr/c+8IfH
	 frWhh8xsnRCtDNnocjUb6TL7GFW9Po9uraw9NT5qvZMDVr0J+rSuLAEeJZHjTQG6O8wj2
	 cPFw5iYpNQ/52OlL0wgqjQmiOO8eBQLlotOOU2ULSVykgsovZVNjgIKOkiMj6w6ihlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4tv6X1+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA17606A31B;
	Wed,  4 Nov 2026 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4tv6X1+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0C51F000C1;
	Wed,  4 Nov 2026 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793789752;
	bh=ZmxlQbjY666CB2DpfDGRCp8x+UD5CCdq+P/PXnNUKNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N4tv6X1+fuRnzcFWc7kFqvNw1R/k3c5ZOX6VF/gvjliL25lWCLvp1ly3mk/hsSILr
	 5jbE824NhPu4esLW+cDfVZbZM9is5IPDBMpC+nkPe4VYYdavglPO44FG8HkQUtRQ8m
	 mWe+B6lpTfbuC4ssp6a3RS8x36Gb0eXjGg21MGQCaLlg1i4VQQar9BgvkU1LwgX0DN
	 cuNECgFq5NQfSvh/e8689Fr0/X0SK6tVY5BSlw2M0+0et4TI9pAg3WsBuabyOSmK74
	 g2JL0gM4lqnx+sPUTyiynnb7Qxxm08kbxCd/L/hQfFjLVQoRB9AQHPjOoM/QNKp1Gw
	 W8OnbjgUPT8GA==
Date: Wed, 4 Nov 2026 11:55:48 +0100
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
Subject: Re: [PATCH net-next v4 02/10] dt-bindings: net: mediatek-dwmac:
 deprecate rx/tx delay vendor properties
Message-ID: <20261104-glistening-woodoo-narwhal-ebb587@quoll>
References: <20261103-dwmac-mediatek-mt8189-v4-0-c86c14fc50f4@collabora.com>
 <20261103-dwmac-mediatek-mt8189-v4-2-c86c14fc50f4@collabora.com>
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
In-Reply-To: <20261103-dwmac-mediatek-mt8189-v4-2-c86c14fc50f4@collabora.com>

On Tue, Nov 03, 2026 at 11:12:07AM +0100, Louis-Alexis Eyraud wrote:
> The mediatek-dwmac bindings provides the 'mediatek,rx-delay-ps' and
> 'mediatek,tx-delay-ps' vendor properties for describing the internal
> RX and TX clock delays.
> 
> The generic Ethernet controller bindings also provides standard
> properties to describe the same kind of property with the same unit
> (picoseconds)
> 
> So, ddd deprecated flag to these vendor properties and update their

typo add/ddd, but entire three paragraphs can be simpler:

"Deprecate foo bar, because they duplicate standard properties from
generic Ethernet controller bindings". This has benefits, because you
start everything with clear action what you are doing here shortly
followed by "why".

With commit msg fixed:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

