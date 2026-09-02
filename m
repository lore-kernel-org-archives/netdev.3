Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5808D427F97;
	Wed,  2 Sep 2026 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387841; cv=none; b=sm3roKN/l4aKPDnJWPXbMDYC/WpKaOSkg/eOkm+stXNxWxpIBpIj3E7pYJ4ZnMiuPfJ6COXsVgTsz19bp/zi9RloD7lqX5h8LA2uvjm5ZfAALV6UaWT+AOODTIJlORBFwMF1qc6mLzaJ+Pw6xNTOqb47BqpWm9BLfO+kQe/RuYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387841; c=relaxed/simple;
	bh=j0kYsDUyALLBzdSNLrhdvb/SXxUjq/U8MNmuqyoqFkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJ0g/cJ62pBLgmcSkB/QgE6lwPCZD0o8JlsnrMuhUIMu0G2/3CxH5czkkxDUHz7nO5YRRUFaheW9KzNnKJ5Ar7rJPPsRZUW5uyDkVjdCH+i23AjbuQrrSdjQ9KvGlAXZF+4yra3a/P6urnw09fs+Se+G5ekcee+bQ59FRCvv0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hsl907Rx; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hsl907Rx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A2C411A1968;
	Wed,  2 Sep 2026 22:23:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 682F45FF79;
	Wed,  2 Sep 2026 22:23:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C898611C795A7;
	Thu,  3 Sep 2026 00:23:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788387828; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=WYk4FNP1vreOpbsIcYyMXKlgV124hwvOajDLIuuzHrM=;
	b=Hsl907RxhvM5OKbp5zT4sP1a5g1yLrMhcO+HShZown8lOdBH+BnT0SyRlBMlk8hUOY1krb
	JIqR4LmjtpWkXVSS1VqEP5Gp0ZCx8h/jn3O9ntVTZ8pPUTQahIY1/MZRNht9hm74AA/gSk
	Bi6Vchv25i8u2PZqgqny+GrTEzPf+XkuMTuLRx1xWl/meYF+lhgG3ETQoJRh5r0Ci15Gjq
	AueIB5XXKGt0H4MoWuOyCH3FPDvM8XpSPa4m30H5b1DWFRV65ZVHYy587IJobAMW0yjkae
	oDKR0TFuC8yYm26+U/DJwCRXXS3pT7mst8eLn2+qQLzABqCqO3ULLB+Lhu8LIw==
Message-ID: <50fdfff1-1597-48bb-b164-116d5ca4e865@bootlin.com>
Date: Thu, 3 Sep 2026 00:23:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/10] net: stmmac: move XPCS lifetime
 management to platform drivers
To: Coia Prant <coiaprant@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>,
 David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org
References: <20260901150111.141037-1-coiaprant@gmail.com>
 <20260901150111.141037-2-coiaprant@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260901150111.141037-2-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/1/26 17:01, Coia Prant wrote:
> The current XPCS creation logic in stmmac_pcs_setup() is problematic
> for several reasons.

[...]

> 
> Existing platform drivers (intel, rzn1, socfpga) are updated to use
> the new callbacks by moving their XPCS creation and cleanup logic into
> pcs_init() and pcs_exit(). In their pcs_exit() implementations, the
> pointer to the destroyed PCS is explicitly set to NULL to avoid
> dangling pointer references.

Hopefully this covers all the glues out there, fingers crossed for
the qualcomm one. On Socfpga at least, no breakage reported :)

Romain may be able to run some tests on rzn1 at some point, but I
suspect this is fine as well.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

