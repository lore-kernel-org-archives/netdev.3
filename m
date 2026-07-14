Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE943B487;
	Tue, 14 Jul 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019892; cv=none; b=FJ8nzhTOgExQ7VxuGqMuxJ4StFdHPCY0dVTADnyEi2mny4BmmccPwJcDGRENKhrAvj7rYrF6EdA4Z/LorBJ7vlcy+7NkAHrir7QlZgudllaXXZxISyag2j8PWdJAHj8W+xKP2IRmkT0Vf+wcvu7Ew1raydv9B4U71/QZ1SO6WcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019892; c=relaxed/simple;
	bh=oRByiWfGruDdSgJtOt0rL3FUefdta81krT/kXEtgg/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SY7EWaC5K8YQhlOpBzkmwaPkMH/j1sQj9NwW5ASJypG17UYwHBoc2evxmpculgvbj7XuFllrkShhbW8X8+v/hW9v2raT19a+kr7QD/qudueYfqVIzqGcQWQpmEyygpNwq01pi+C1bRn7rgWlVxo8kfQv7ZGO1gxXrhV1z7rgndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KSK9X1XL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KSK9X1XL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EC5E81A0FC7;
	Tue, 14 Jul 2026 09:04:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A949C60346;
	Tue, 14 Jul 2026 09:04:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EA7811BD3B3D;
	Tue, 14 Jul 2026 11:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784019886; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cQlJfUIF2xj1GC2K3C4deNAjDGGPV5piEIHcT4ELsas=;
	b=KSK9X1XLWbs7gZKLmsCEdM20CoQn5wIxTDfWsCSPYgg+ywR2z3odgD9QJVIhv0IbuQDoWz
	eJGhbpZQUe0ySgmcqwi4TjwARa8LH5UYN0QJ5znP6Fm/gYWuh16SU9C0eCKlECL/x8J0d/
	n34wEyprkXAZ+DB000vxRqDb+2sA53yyhasF2h1lxZerQBChsa+RMHw4RfuSlr44dBCeLX
	p+7e6OB889D82LH5S53fQPZEpnV4MH4YLpiPCJ8KjyLUfu8ozKLPO5jjTIJp33wwLwyzIt
	WeYwRAtvOe2f4w9aIdjIS5lp6ng0FdSOJVfbMGxRf/LOCyXl1VM9VGKB+ftgBg==
Message-ID: <d6101afa-ca8f-468b-9dd6-f64eb94669e3@bootlin.com>
Date: Tue, 14 Jul 2026 11:04:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net: stmmac: xgmac: fix l4 filter port
 overwrite on register update
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
References: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260714023716.29865-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260714023716.29865-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 7/14/26 04:37, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The XGMAC_L4_ADDR register holds both source and destination port
> match values. The current implementation overwrites the entire register
> when configuring either port, so setting one silently erases the other.
> 
> Fix this by reading the register first, then masking and updating only
> the relevant field before writing back.
> 
> Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

