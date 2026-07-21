Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685841F7E1;
	Tue, 21 Jul 2026 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616782; cv=none; b=a84A6tNo5586RGn9XC6YokkbVM3V949ajjVxihnxbfbWeT1SdFyGWd/wo6gMhV/5B/Y5r/jfrfi+2ux9nn6LFdFUX0Tq5HjplqChL7yNyMGlftXaCa2U3sjGnozBTXLf+QhtUwB+cc6L7h2nCMBBpmO5p5Ha7LSjXFukrak1Q3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616782; c=relaxed/simple;
	bh=ZylqrtVQqZ12pKNcZs40ThfMGgMHBHZnInWYUnf1gxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGwYdYCtE6EBzM/EgG7QougxU2oSdV5lYD/pNe9jtCBptefo7NC2xMRS1R8fiDx9HGxl1vBuPKXSN1hKFTUHf+TYUT5pm2ttZbewJUSNNbBPmQEWp5rHS1wjJBvcEoWq8BWXsplPA9+wtTgdZQdOZ1A8qNUFuTXnMNvxAzpjnTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=led0votG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="led0votG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9B7D14E40E1B;
	Tue, 21 Jul 2026 06:52:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F7F760368;
	Tue, 21 Jul 2026 06:52:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BDA5711BD1290;
	Tue, 21 Jul 2026 08:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784616776; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KUCIPdRiN94gizW8iOcr39QKMHQLI4mrHTDjagqbncg=;
	b=led0votGbgbFR+40Cgpyo7HBCUFr7w4vyUrA4T/uCQenO0HF7NC2m94DWfPr4XeObIkcab
	3NQZK9g1i6OzukK53j6r0XxgcpGrdtut3Aej08gEGSb7wviob6zGdWzN9M6a9FJNtqx6ws
	GN3g+MKqpSdvLs3QjGxNvvF3wRG6EzagB0aRCjFecrjxUBHBTvCw9VKNvs1++eL8L4cbpq
	1TKFGtg40JDGrL4+wSux93UL5E9gND+AFullujlnshi40It5suEsjsUQ9iNhJkfYTwpbhL
	I/1HvxiOTotyH/Xk3f5KKAiCrNFdS0WjVDiLRXAqGyyttnGG53HI6fXChfHc6Q==
Message-ID: <da6e858e-328f-428b-8933-48b603debfbc@bootlin.com>
Date: Tue, 21 Jul 2026 08:52:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 1/5] net: phy: c45: add
 genphy_c45_pma_soft_reset()
To: javen <javen_xu@realsil.com.cn>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, freddy_gu@realsil.com.cn, nb@tipi-net.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org, vladimir.oltean@nxp.com
References: <20260721022410.1391-1-javen_xu@realsil.com.cn>
 <20260721022410.1391-2-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260721022410.1391-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/21/26 04:24, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic Clause 45 software reset helper. The helper sets the reset
> bit in the PMA/PMD control register and waits until the bit is cleared by
> hardware.
> 
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


