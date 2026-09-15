Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDF453A54
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504413; cv=none; b=GuVrUYYGG4+gXCL5yVgMQAf/L5F/jjLy+U165IKQhf3Tm74ZuJvjBmGqvGAJNgOwN1ktP0/zhRJmUG+Le7En1i616eo59awUstMQAhDUweoExmF148Ew4OR/VGNRbgHKC8ydVMbzr5QLHul5qU+M9bykEVMG74FpqQ5RFytmlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504413; c=relaxed/simple;
	bh=45/eohNmGxzgetiRK5lMcxh9V1IsBJwlnwaJid+CtAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKwJ0wpRnKfEihNn3G0ZjNsOfwhe3Hb7lch3BZLJv9Ndwlt3tLzrrOE6aM/Xqm4PVbKzHPXH4rsRMrqbtQ6fT7cEytQ49tg+BTfceypbeaPI3dqfXWmsP8EFz/LW/8eVNkM6rxdSuy1WtIK3BdUBKWYPhWX00BA24tT2NDkpdzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jb/LzoNA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jb/LzoNA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0CDD9C5CD53;
	Tue, 15 Sep 2026 20:34:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 400E2602B0;
	Tue, 15 Sep 2026 20:33:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8614A11C7AFE5;
	Tue, 15 Sep 2026 22:33:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789504403; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EaTBQSFDY9HqCiNlkTKbGEfGfiR2jHJYb7QJIPYFUTU=;
	b=jb/LzoNA59kiYJnRzas+LoinY1Sw+b4PsE7rgm/n6GJvhG2pg9BnzQ2sLKCzTIcRpQnuAA
	sA4Jc9hJuw3g/bDDXcCb/voAubto6tXDlnvtwVKMfwXTj4pwh4kXh4VdKoJ+tA9CeUz0ZC
	AbgcFPqQbmWWkdJ2hWRvBxJUqnfZyak+cOKHTrkm308yid/SB83QA73zL4rn14Ubjz4HUu
	Ba+WqXLrxosE10orHQzNUG8XMXsJF7Lkb633gTRGy8EfgzQzwyCV6wagjtLXSuiDoIsJX3
	07g+4RG/qkRjf8a+62XVeiBEb6c8/ku0OM+PIfdNCTPxi0PpEcqVCv6URgfE+g==
Message-ID: <5df35a3e-d2c6-4576-868f-d3194de3deb0@bootlin.com>
Date: Tue, 15 Sep 2026 22:33:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: allwinner: add H616 EMAC1
To: James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260915-submit-h616-emac1-v1-v1-0-195de0bb1f8a@gmail.com>
 <20260915-submit-h616-emac1-v1-v1-1-195de0bb1f8a@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260915-submit-h616-emac1-v1-v1-1-195de0bb1f8a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James,

On 9/15/26 21:03, James Hilliard wrote:
> The H616 secondary EMAC uses a separate system-control clock register
> and supports only RMII at 10/100 Mbps. Add its distinct compatible
> without an older fallback, since using the primary EMAC clock register
> would not work.
> 
> Constrain the PHY interface mode to RMII, matching the hardware. The
> EMAC1 clock register also retains the three-bit TX and five-bit RX delay
> chains, so allow the existing Allwinner delay properties for this
> compatible.

I don't think there's such a thing as RMII delays. RMII has a single
clock, contrary to RGMII that has a TX and a RX clock with a 2ns delay
between clock and data.

I think it's just a leftover in this IP from the other variants that
can do RGMII ? You should just be able to drop the comment changes here,
and same goes for the dwmac patch.

Maxime

