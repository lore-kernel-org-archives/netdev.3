Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABE4A4987;
	Mon,  7 Sep 2026 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781696; cv=none; b=PeLgyRbSDOlFHaNd1lpni/z8SRu0GWdvUf+iDVDxT6MxqPneTgEhfswSs0K2EDoVQxASgfU2pvumQW9vv5bU8RLs2AnV+989QUez11syHYmI4d5I5Cy3Qc2T6VXtXnTKP6mzQY7bqBmN4EUG6uAfUYUjmuEdXEZyWLx6wV0O6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781696; c=relaxed/simple;
	bh=XvhgKk55OlQI9HFk85ohFGQVC1+2fsP3rubx4lhEhD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnfdAU61l6wuoQGh0PIam3ggODIYSSIlrcH4wcrbxLqxOPgtv/sBU+PPCvbLs5RptYaSpKFD488MyJvO2lUwg83TgByp7yWJUnbLoPyu07sTGQ1L/5tYnBKXqOJPB7mapDct5V4zrIH8k8mqf6x5Gi5Vh5yVmF+IZrUVZS9+6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SE0jBVwa; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SE0jBVwa"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 824424E41565;
	Mon,  7 Sep 2026 11:48:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 562CB60383;
	Mon,  7 Sep 2026 11:48:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86E5111C7A21B;
	Mon,  7 Sep 2026 13:48:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788781691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fGNYCWNaaifl4L31TWFkjKkylDh1BAcBuGtP8MSWGuA=;
	b=SE0jBVwaSwgZ9CLxKn6rT0b0oMih3vYka7JkHUNfgCVej8o4ER01h0G+/P2N6IKbLGn2eM
	CYe/ApGcc6IUBiYYiw2wiMhTHDQr1gEQz7Ea6Ze+hSc9henJmKpWMTilVAYXIIhjaecD6v
	U3CNlXJ2cvf1/X5ItESGGMRPUr6fGVh22NH1Y7Y2kRq4oKHY2N3vjZPbWFM9hzMCT2awEk
	CyMIaIWZ1SRJfDsG9BA96hqM8msweSOgmmGDwQr5gxbaUaE0o6o5EQ3t/I6V0adO7e7OQi
	OK0XWk/ffi5R2aJ0f9P1Hu07dzG12wCeqozUDRMnSQTygMY0y33Jv6vOo06eRg==
Message-ID: <ff98879d-4761-4343-89f8-060d81df39b0@bootlin.com>
Date: Mon, 7 Sep 2026 13:48:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] net: stmmac: Add UltraRISC DP1000 GMAC
 support
To: Jia Wang <wangjia@ultrarisc.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, Chen Wang <chen.wang@linux.dev>,
 Inochi Amaoto <inochiama@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, sophgo@lists.linux.dev
References: <20260907-dwmac-ultrarisc-v2-0-9a39bf8db313@ultrarisc.com>
 <20260907-dwmac-ultrarisc-v2-5-9a39bf8db313@ultrarisc.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260907-dwmac-ultrarisc-v2-5-9a39bf8db313@ultrarisc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/7/26 09:46, Jia Wang wrote:
> The UltraRISC DP1000 GMAC provides fixed internal delays on both TX and RX
> RGMII clock paths.
> 
> Add a platform glue driver and describe both delay capabilities through
> the common stmmac platform data. This lets the common RGMII delay handling
> adjust the interface mode passed to the PHY and reject incompatible RGMII
> modes.
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

