Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619607;
	b=iYRDm/kiam3z9KP2rFSflrxO4/4G1GA1FrNoba4iO4GsCAEvgLwXBe82/HKDJIworVT6
	 7cY0UoEn5I+BJiV0q9/4EFD1A9lZ7FQX+3E5HLP+U3nVn8dgYoo9FBJTvCwPcS1zxBVgk
	 0+czyandXCHwEPWRGlNUarIRryAi6nwpsb9OzxNb1X22e+mwOFRw1bIqXKRPHRjpDmYzp
	 R3Kpbd33U9ehNnfAVDWS6F8nJgD5Xc0MqRcpir8WDyPDVX0mfpA9/jA78gNKxU0/rHnFz
	 ZmwJ68X0xVTr3cyJLtkELN0FPzPrRsP4eaLpkQUbeMRBUanvSZYePy2jNcnD9TOVHyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619607;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PGaY0Pa3HUYVclQJqjBeSI20mWGTsICDiHVjhHNeV1I=;
	b=HfgtmnE+M9/3CYrdLn13wXflmdSAWUewclmceu2wfSmnVk1DVzYPZNd4IdriTjNigjz1
	 BG1tbcXed7l5nuvIkn29N+OMFk9UMwC6zIOv6SBl/0Bgw2NScg9u2z5qKnUt3QKq4Sepg
	 95nz3K+A5XGWmcnhov8QPKmzyu5r/L+4OxzgdDiipaPnqSf+rTFC1rLMIvOQwu9lW6Piv
	 Lzg15vtYcDe1EAnRKH+rPMFQ3PmqR5b7lgTsg3PGFgiVaurGUMvmX4iga8cOSgRhIwmGr
	 DT/H840qJbRxnXUO1LDbKb8dDiFcU7hu6OGaMIdlPlLUCwIzucDCiNYfaDe2rXCjgRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxhzywtJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2B606A326;
	Mon,  2 Nov 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxhzywtJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8761F00A21;
	Mon,  2 Nov 2026 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619606;
	bh=PGaY0Pa3HUYVclQJqjBeSI20mWGTsICDiHVjhHNeV1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MxhzywtJBHiisWhAANnkA8vgHE9oI5DEKKmoc/nAm5eLjve7s+fjBjbY3sJi+iMVk
	 513dCavz/UvlAVM+dYF87jXDBwrmV4AY9r/xfuDry/43mW11avQyQtaUBN/mNachnL
	 VUj1BE2lmHejeUaAfvF8cRfwsnq0HtAxRQtXnPrqJm9g6RD3TibbGg5Nsft22QIOcw
	 By7RHFA807z9xRshcCcKZEiIe660/h9MLluJp4ekrksYbR2q9XZfztahkzBZxAggW7
	 DBeJdb4EEPNJYJ8wFDp9UkUxaTo/0EzB+XzzDDbc/kxOaQP35dADO1Kkpfa4HfxTgQ
	 gOPxz4D5mcCBg==
Date: Mon, 2 Nov 2026 12:40:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhila Kavi <akavi@axiado.com>
Cc: Sammai Chakravarthy <schakravarthy@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tzu-Hao Wei <twei@axiado.com>, Karthikeyan Mitran <kmitran@axiado.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Add Axiado AX3005 IRoT
 MCTP transport
Message-ID: <20261102-nightingale-of-legal-superiority-fda313@quoll>
References: <20261101-mctp-transport-irot-ax3005-v1-0-36ceb822f01e@axiado.com>
 <20261101-mctp-transport-irot-ax3005-v1-1-36ceb822f01e@axiado.com>
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
In-Reply-To: <20261101-mctp-transport-irot-ax3005-v1-1-36ceb822f01e@axiado.com>

On Sun, Nov 01, 2026 at 06:00:57AM -0800, Akhila Kavi wrote:
> The Axiado AX3005 SoC has an integrated root-of-trust (IRoT)
> co-processor next to the application processor. The two exchange MCTP
> packets through a no-map carve-out in DRAM, and use one channel in each
> direction of the AX3005 mailbox controller as doorbells.
> 
> Add a binding for this link. The node has no registers of its own. It
> describes the fixed pairing of a TX and an RX mailbox channel with the
> reserved-memory carve-out that the IRoT places its packet windows in.
> The IRoT firmware chooses the window addresses inside the carve-out and
> reports them at runtime, so they are not described in the devicetree.
> 
> Also add a MAINTAINERS entry covering the binding.
> 
> Signed-off-by: Akhila Kavi <akavi@axiado.com>
> ---
>  .../bindings/net/axiado,ax3005-mctp-irot.yaml      | 60 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 68 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

