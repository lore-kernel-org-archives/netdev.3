Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD030F95C
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445905; cv=none; b=SeUTnTmBdbwv2YSoQSMoRQBNRPc6Aq4Uph3b602yf6N6eumbDz4Dvp/JWfhbjY+yLYQBAlY5i1VnQXjZ6bpISKLAC9mWm+eEkW49aDuZTy7O1gProNh3khzXS03NEI4XMx7vT1f7xoZJUf/VpKv9zsxxN3yzJeo8l2TSikuEdZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445905; c=relaxed/simple;
	bh=0DtD7aCXAFmq8zpD4aASbKZcLwmYMf4INu6Nbk8FWOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTTY4w2fYn4Z3fV0wmjwfTlnewSAIQtNL6KBSETvfzhn3q7VJIQPYWmWqaes0K/TDV9PaUP5exvCQR3QR2ymygDQv5zccRfc0a6Lx44k7sNor1xhEciDGjbyXwiAeqqbPwDHfSZlinoJv935qZ48QSGLpCkKGTK/d7a/2aD9aB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qz7s8XA1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qz7s8XA1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 84FEA1A102A;
	Sat, 26 Sep 2026 18:05:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A8D060749;
	Sat, 26 Sep 2026 18:05:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88ABA102F1E44;
	Sat, 26 Sep 2026 20:04:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790445900; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=q1dKRry95jBEQN3rtyfXV2niRUCwn8ksiLeX1nicnvU=;
	b=qz7s8XA1M82/yqqQr5peOeVqVxZ/Va9XhM6bSSh/JDqAuTUCBlr0s2+TRCmhEzhok1L2xE
	/QRs+UXVH8u58YD8McggTTIMWgHC9gi1w8Zg01TWKVd9pbYpqIxyba9OnQCRmoFTeLp1+I
	Jir+Csb5go1iWZyJUwZib95VLCxQ48jYzRuEwCTtnUBvR/pC8m45UU1ysRTkWIvC4fp6an
	rJx5B/dnNJsDsX7ZOS9J2fY3EtJmZlPALI1bjXVvqpcrXh4nD3CozwHd/LOXY3eAZiE8Ih
	7JRKOdw26jiUkQxfDqxWO30VTa87Zb8qi96BfrSpcZeldQDAIDH4VOFA1wFoVA==
Message-ID: <e5799072-8c7e-4b4c-86e0-414168d9796c@bootlin.com>
Date: Sat, 26 Sep 2026 20:04:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: ethtool: let tsconfig reach a PHY-only
 timestamp provider
To: Nicolai Buchwitz <nb@tipi-net.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260925135237.3432266-1-nb@tipi-net.de>
 <20260925135237.3432266-3-nb@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260925135237.3432266-3-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/25/26 15:52, Nicolai Buchwitz wrote:
> TSCONFIG_GET and TSCONFIG_SET reject a device that implements neither
> hwtstamp NDO, even when its PHY can serve the request. The ioctls they
> meant to replace handle it, so the two interfaces disagree on the same
> hardware and user space has to pick one.
> 
> Accept the default timestamping PHY and an already installed provider on
> both sides. On the set side the test moves into ethnl_set_tsconfig() as
> the validate callback runs without rtnl. On the get side it stays ahead
> of ethnl_ops_begin(), so a device that can serve nothing keeps failing
> with EOPNOTSUPP and a dump still skips it rather than stopping there.
> 
> A netdev provider needs ndo_hwtstamp_set to be programmed at all, so
> don't pick that source without it, and test for ndo_hwtstamp_get before
> calling it.
> 
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

