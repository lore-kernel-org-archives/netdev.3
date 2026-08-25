Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29C3890FC;
	Tue, 25 Aug 2026 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658808; cv=none; b=aOvM9ik+4loEmuwnSlmcdqzOirCgTp7s1p1OER6HEPe3zxsyEz/0kCRT/h2BoiVb54AEYdzGStk0WZ6kv/1i/tLiIICsDnngM3gwEQKApk+Do+MzdKCYlDp34A26bFut0Us0ZLTAX7ygr0tggrbK85ZUrDd267OejImSfCorEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658808; c=relaxed/simple;
	bh=Y/oy9nzDrB7Hrtgy0TezRLVnTArl0Q/7EwuhK+CZDUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mD1XXJCY1rfd3Mzi3yK5XWEDyKasOIUKshLqKVoJN2vN7R+BicNnnehf5yBQMqGkq/ej2NoA35f/iHAckZ0mECkX2Lo8eqGIFN8igWyf3srVYVMnBUVeH1bgMltFUFSaKfi1yxE/otPghA9G1tSTHgRUWUo3kRlu628HeYyGBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lupia5lq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lupia5lq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 93BEF1A180F;
	Tue, 25 Aug 2026 11:53:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 671DA604C4;
	Tue, 25 Aug 2026 11:53:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0718D11C79245;
	Tue, 25 Aug 2026 13:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787658797; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Y/oy9nzDrB7Hrtgy0TezRLVnTArl0Q/7EwuhK+CZDUE=;
	b=Lupia5lqrNdCEUgOHvh30PPbqWGwVkSPvGa6VHkkbajgyqpaDApj+l+16rCBiqtHjXOV/V
	EJwUrLI3jFzygz9VvXHnnzFrFmx6BZNR1IogaFT7nZwdb9/Ckati2A09dK/xlGV+H1bFqO
	xnT0AYg91napfNXs1jMnGG02+qHWzpl0iBReKHS2uWmlSggdcPVcVt8XV+CtNXgejaUx5S
	ucuXuW1nBy2tQvmMyOdx7mNSxAoCmpQopwyBUJKCNEj966sSLSkcVWe5cZt2joykB4wPT1
	ANYnj+QJezNG1RGedRACv7Er10u/V3khDQUyM/FolkaJzWmr5dOfvJNEQimShg==
Message-ID: <64f97732-6451-47d7-b517-922961b50071@bootlin.com>
Date: Tue, 25 Aug 2026 13:53:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: selftests: Pass the IP proto mask in the
 TC selftest
To: Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
 alexis.lothore@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 muhammad.nazim.amirul.nazle.asmade@altera.com
References: <20260822153245.423259-1-maxime.chevallier@bootlin.com>
 <20260825075145.34118-1-pabeni@redhat.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260825075145.34118-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/25/26 09:51, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/

> Would zero-initializing
> both structs ("= { }", as attr already does in the same function), and
> setting keys.bkey.n_proto = htons(ETH_P_IP) together with
> masks.bmask.n_proto = ETHER_TYPE_FULL_MASK given the injected frames are
> IPv4, make the result independent of the stack contents?

Is surely doesn't hurt to explicitely initialize these fields, will do in
V2.

Maxime
