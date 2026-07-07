Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456E1C84AB;
	Tue,  7 Jul 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414532; cv=none; b=E0ohfKxTRqCnVfy616QF3vRLpvUjh0ILCmio64luuBzbr1rw3EfAzWffBB1Bm8ZIXf9J9HB6O6xT4MZ6Y3TRC4E7JqDRKogtpAepSzkl6NWoXNjiVG8xr5cgCTNQL25x5jiR/2zLH+qWAyzAjQH2PV/+jsOGFe6Pd/CuIoIZCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414532; c=relaxed/simple;
	bh=uvtc+WFA6u5kax9V+i4pYXkE0YgxopxgREj1b4EkHEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVzQwezGxsvjrJsa7IHhoYSZZYyiwlvufTQ7SNL/ungDsqvJFOeNbc5pblzAUD6GRYAxR/CkMSzVmxyuG6vZijP4rIgJJkssdMFsqEoxQStLOI4EMfhEKZDfUgMLM2G+B53e4y7Dv51r8/j1TvaZWZkrqU2Bhi6c/LMHPFG+RvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b/VO1cmq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b/VO1cmq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3221F1A0EB1;
	Tue,  7 Jul 2026 08:55:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 01A19601A3;
	Tue,  7 Jul 2026 08:55:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C9BA11BC10CC;
	Tue,  7 Jul 2026 10:55:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783414526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ARJtStOd24SeMWn03WDpYKksjNNKhxE1nVOumgSWP60=;
	b=b/VO1cmq/Czd+9zsONRk1F/8fNp1QhwKz8ivy0AO00vPAXxiD76Bc/4MxdJT/ex0s+1aLF
	cVUHDrc08l23sld4CMhIhm2y4E4gkkFKPoTKJbDbt3Z8m/K3iw6DJSg7GkqvQT2Htq4gz6
	xPgBrCDeDlCJX/Ym+qSs315h42bTU2V03cK3G6fljAuBJeEaHm9NRll9Dkov2z4l9wO6Bw
	TSSGBtocNor6F1+COt/mMABpv3e4ku3NJWSOeMoSoDvwM4FazT/fxWTA/txj6Q4tX9cGMl
	ZPQGtcNr3alezZ+mPXtZaorON0rtaB3igCSBjXLGiAj9K+FZ3At2aAMNEhf4Rw==
Message-ID: <f416b487-5bac-4391-aead-61fd4d2f16ae@bootlin.com>
Date: Tue, 7 Jul 2026 10:55:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] net: stmmac: mediatek: add PERI_ETH_CTRLx
 register offset in platform data
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Biao Huang <biao.huang@mediatek.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: rmk+kernel@armlinux.org.uk, kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
 <20260707-dwmac-mediatek-mt8189-v1-2-17f345eaaca3@collabora.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260707-dwmac-mediatek-mt8189-v1-2-17f345eaaca3@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/7/26 10:21, Louis-Alexis Eyraud wrote:
> In preparation of newer SoC support, that use like MT8195 the Ethernet
> control registers from the peripheral configuration syscon but at a
> different base offset, add a new base offset in the variant platform
> data to access the PERI_ETH_CTRLx registers and use it in implemented
> methods.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
