Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED7370D69
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713419; cv=none; b=h5g1C2sJrM1upXyyIrfs8ooVGnbcH4Fl89idWpl+SfmK2UP1ESW0xwqAmV3Cp3BrcwdkVwyEV2ImnUxtFtdikD8ECcAosN4ilCf8VDwXgGpFQvEVDJZE+3Iz3rD1HKhD1tdtJlQbBKooVlpe3Uf4t4owgYE7i2gY5fXva4T6z6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713419; c=relaxed/simple;
	bh=O1huewYL1PNuCkIhyClw7hLbhunZb5skF7+0QTpYPQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQornRXCrBRX6Sy7VmyP2wzQimjhLQIywShbF/RfITMCIoyA3ME6qHjoKWMz/4HZcGtZoIWwBJbq+XLNU2LeRd40+V7so8m8qq4UNxv7EvOu/Pni8PxaS0nMBkOHqbvC4l40HekqwSdOLgZJ2DgNkbmmp68BHvUoJ5ZJSzzefYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AQNRWxM8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AQNRWxM8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0D6C91A0975;
	Fri, 18 Sep 2026 06:36:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C239260649;
	Fri, 18 Sep 2026 06:36:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B918B11C7B021;
	Fri, 18 Sep 2026 08:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789713414; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=b/kwg8xPzvU7ZBW6GaseA/nQW9nV0VK1cq3pTvwDMsI=;
	b=AQNRWxM8MSps0slHhOxR5WAwPa4wIYOQiM7D/Z/E7cAcmFmQ06vOBeqH96ZAsj2QT6KAak
	SVIa9tT/KfgEUoyBGjjgNCV0blH2+c/gYJg/GX3myRvkO/2M2UXyDV4cpMpEBqK15tB9hi
	vhGELJV8XKPegOPsMzraCmFhnwrVaZJ2rCXqQJktbRj8h2URJsTPbE3FIlY5VzlaVtVqhh
	L2uOHoiyES021YhiuDepdnZBuuqHZJSmX9gH7DrayLW9M0s9qhjG77e1pSZBlZOcP5NTam
	Y8Dilcw/R/IkeukLXLMCJ7NCfMMDlNAvpNCv+9gtsW1nzklG5T/CbjX/5bSBHQ==
Message-ID: <7023523b-fcca-401d-a876-18960a9d75fd@bootlin.com>
Date: Fri, 18 Sep 2026 08:36:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] net: stmmac: add Allwinner H616 EMAC1
 support
To: Alastair D'Silva <alastair@d-silva.org>,
 James Hilliard <james.hilliard1@gmail.com>,
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
References: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
 <9cd900993fc385ccffcf743f629e87071be9820a.camel@d-silva.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <9cd900993fc385ccffcf743f629e87071be9820a.camel@d-silva.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alastair,


> Confirmed working on the Mellow Fly C5 when brought in as a module and
> backported to 6.18, tested in the Armbian environment, along with the
> recommended PWM patch:
> https://lore.kernel.org/all/20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.com/T/
> 
Thanks a lot for testing, this is great :)

Can you add you Tested-by tag ?

Thanks,

Maxime
