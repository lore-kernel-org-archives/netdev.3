Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CD3F1046;
	Sun, 27 Sep 2026 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524857; cv=none; b=N4NMdYPlnc2NVP7WslGVZKcYc304XNzl4xzq/qB0erFk3QvJjVb9NtwyPDq+mG+qb6xAJRwoJaXbMxEbno6WgAwmVZpEyxV5uWLh2mY9xrv3NGC68aIf4VO4ZqWu8wP29fdOd1drOsWOpLfA4yrz6FDHjthaY7zTHW3/pc8okgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524857; c=relaxed/simple;
	bh=0EN09pLTmyaoaapVLMwrGusF6EJ7ush3ooTVUXErJCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0arOEuLx9Wx+GHC7lSA7kOwTgBFogF3DzQI+u+yliavGqlF5LDue1nntrogQtaRvIGsqI1AVPfc5uvThQySiY4u6yZRUno3YCYeAzC7lrTxuTN1AXdMhgLoPnmbqWGj415QiXBhWU4iSZa3zb/+oAVc6fH0xl0el7Gc4Bz4drc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=r2EcfDHE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="r2EcfDHE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0A4734E40ED6;
	Sun, 27 Sep 2026 16:00:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D1A5E604FF;
	Sun, 27 Sep 2026 16:00:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35B33102F1E7B;
	Sun, 27 Sep 2026 18:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790524851; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=RRLSL+GoK5LUxxlPufnEEW3D+B6EW5mhmoVlJqOBTWA=;
	b=r2EcfDHEwurSbi4m0BQBc+XfxX9OHN8jqgDDrr5QxaXA4HbvjWS4LTrk0uWn6EZXI8dLhk
	5dHe1aODDVYHfeYmX2/0bN5lPJeEZtrLGB8VIpIDqPngc40vY1BP9Wr9dOz3uhg7rYvI2b
	clXc7xVsZxdyjoe/2+4PtS4DjKo4sC464OVkMs3l25AV9dGxJu+CLzg1IGGW6KHEHda6mr
	knSHg+Hf/ZwvWKCyUUvWg2Ahhp9hfgZ0tO8tZ9rzDdOwIlHGZjpljcU1bZC9NX3CZPhHSw
	MLkwCx6T5wKl3BI156q3GNS2lv2aZjNVB4EFi2xC4fQGVQ48N7JeNWMGuWL4fA==
Message-ID: <7b5d8b3a-2c66-4e33-b5dc-2789d186a9a5@bootlin.com>
Date: Sun, 27 Sep 2026 18:00:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net v3 2/2] net: ethtool: let tsconfig reach a PHY-only
 timestamp provider
To: Nicolai Buchwitz <nb@tipi-net.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260925135237.3432266-1-nb@tipi-net.de>
 <20260925135237.3432266-3-nb@tipi-net.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260925135237.3432266-3-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



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

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

