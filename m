Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF82DF716
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198043; cv=none; b=lXTLHmfr0Amh0eIMDAZK2JWCbppSA7wAcQsnnu9IHWE78r96zvzWgi+8QoR2S791X6b+ORiNq3Q/bkMx0NdGSP4mZoswSLdf0RGRk8zWsINVMM7y7ufxbqXrbxK8W5tLLtJqNqbFJgAh+z3K1x6PHK8nVIDEJreHKLlc7rE65OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198043; c=relaxed/simple;
	bh=uHW78qfhdeL0wkW3eo7UHbN0sHcO8qzdL/fqq2sd4qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4/+MrU+gSp9Wskz6FQgyEVH+m+xHEBiRnFHH6Pzi5ZextpYCH0mLY9GqBAHn8i3xAZANiqvf5/8e9zroG7kQjz5k4XjTVkotPJL7zGISjfpd1JIc/UZmWmAYXLp2GaopwU3NY++nQCHtTnXYAl39UKLPiDKjkxQtSnySPEyZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YcEfykjX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YcEfykjX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A61901A2BE4;
	Wed,  4 Feb 2026 09:40:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7B2EF60745;
	Wed,  4 Feb 2026 09:40:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CB8A119A8891;
	Wed,  4 Feb 2026 10:40:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770198040; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CbZ3/1BB0R3fIOnjdn9+/O/4gxYQSf4wBm/5qZB9Ab4=;
	b=YcEfykjXjfUnEj/V+GCSXXATK+5n6pkoQakgNrClBQ4O24EbmZrdGgjSobKehGYAPt3cyN
	qbm6DNCohk8Z9HgIC7XIt+TWiu1Fsg8V6Rttwpki9Z2F/dD4xG1vaY0n3BH/T5sFCcTATy
	DkbVWks0R8EAvlJgmlCEslxeYQeOV8EHB6lwR1p3hrhTOb9GsJ21btWLIiU7XXGGdAdhKY
	6oJKhtSCIXEWth1iZKyVvv3xjBYRTikTNkRHZaF0uNH09JiKSunVutfwHBr47dhSCxqE/h
	dsn+UYeV74i7kGH8LRrcyUaWgcjnV4sS8x1YZ4hL3v0isvmXXTOb8Ws1J+o8pA==
Message-ID: <8f1d4def-6a15-4573-9ee6-15300a63447a@bootlin.com>
Date: Wed, 4 Feb 2026 10:40:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] net: stmmac: rk: replace empty set_to_rmii()
 with supports_rmii
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYxq-00000007hor-3yXt@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vnYxq-00000007hor-3yXt@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 04/02/2026 10:14, Russell King (Oracle) wrote:
> Rather than providing a now-empty set_to_rmii() method to indicate
> that RMII is supported, switch to setting ops->supports_rmii instead.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

