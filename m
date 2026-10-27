Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136899;
	b=1Qtf9443GStjyaMutCFxdj46t9WSO0hqQ+8Myg5eDabB8UJ9rKLlbeVPExHeECWbpymS
	 xM1puGBg3+VHSyd5EnWfXGefGrEm8G3BV5TNa9iaWV0D+puYRM02I+IshefSKKVAcqJxd
	 RMOF7ytUcF0V48RuRv+4Isy4OeF13z5WnMJ3gmRYz6NJCD1Jyfqy2tuHXJPYjKZpWQigV
	 ahtgRhliVkkwIy5Wu4CeYcEf2xbUmbHKfDhvkwJ8+mmhUgCfzxrrPJAWqpaMwG6CtDLQv
	 KNM+nGzj7I1zbtnpF3wKxDggb4+hbhb8dSNuQlIG7viIduqWFjHVIDTUy9LtRfO/3xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136899;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IkSHzh93Di3WR58ZIGoCZg1d3wUWxexlPDz7KBUjFFw=;
	b=MZOoKaWPk0hiQXglHAXgT5N+6FYF/eOBTNGCm+MkLbTUYLmGpKfHu0nW1PE58Ti5wXra
	 mC6Xbw5j1MCaNAhedJfpZw28QlT/LMIM84DCokFPzbBExLY+Y3VnE5fKDPrXdi8vtbKdi
	 dus1u3Na77Imsd1simHGYBlp2MWvqTeoUiY5dmhaL3+DgH6UU0tsr8XzxvSEOcwKFZKAP
	 O5E8KTe99JhPT0MnOSK8f+a62vC/uM3wum+Na1DDcnkQsTc6Btcx0ecKWtpF2fsoQ6iyO
	 3keXQrqblg5v2w2Ior8DQkgGc9ZFuylXmKqmR+pyiVXHzIJ5jTIqpNLIMdCue+fs/Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbenW9WV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774E606A31A;
	Tue, 27 Oct 2026 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbenW9WV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B60E1F01825;
	Tue, 27 Oct 2026 21:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136898;
	bh=IkSHzh93Di3WR58ZIGoCZg1d3wUWxexlPDz7KBUjFFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JbenW9WVAuMCJndPsNDXWqqr/ewlpQbZ+nusWoYAiHmf8cIRQipdpBCNsLrld6ihw
	 cQMDWWIH5AsYW3juytsl2A6oRXwhKVG9vMhel/qkdSShIgPtMLLcO46YLiAxMqI4Mm
	 j5GiXthk+UjZ++AAwfOpAY9bsD2aeFdBvSCI1SsHanyBmb6PKL5t49O9PNeHx53DDy
	 785yJAF0zUi/nZT+cvB5d+PfiSQLkNZvyGFkfs/NPGl6zjoPq/gZV6ieOJuNfp/INr
	 x2NtTF8fHAMKPn7YSkU5ghJuqPoGUjanGyJc4OPtWTbTd9wqPF/0KAE4WmV7igabLq
	 44UIDYCMUvBgQ==
Date: Tue, 27 Oct 2026 16:34:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: krzk@kernel.org, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stefandoesinger@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	arnd@arndb.de, Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 14/24] dt-bindings: net: Add ZTE ZX279128S MDIO
 controller
Message-ID: <179313689400.1210044.5259450629503672556.robh@kernel.org>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-15-ghahramani.navid@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014072109.1759502-15-ghahramani.navid@gmail.com>


On Wed, 14 Oct 2026 08:20:54 +0100, Navid Ghahremani wrote:
> Describe the MDIO register block and its work/register clocks. External-
> PHY pin selections use pinctrl rather than direct syscon writes.
> 
> Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
> ---
>  .../bindings/net/zte,zx279128s-mdio.yaml      | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/zte,zx279128s-mdio.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

