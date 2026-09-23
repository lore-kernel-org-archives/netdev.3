Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6FC44C4E3
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150342; cv=none; b=abvT0MO7qgAcofStUXegGFSAGs2aqFeUCcdfKusg16eodor2D1zPC5nuUj4b8Q1SGy5DMTSs5dJbEDzBxSNHrhOoXFRG2CX6B0p127aqyn7vs+cbMH9PfQs0xzhBNZCzUZ4rynL8Wl6PaKac9HHEyqCuKC/JqVfBrtUufpQJ2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150342; c=relaxed/simple;
	bh=CrTkpX1jb3t9EdJPwlYFXHlEGi3K+zCttIQK0ZMVLzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igltL8Muu7+4tewlqkF47Kb0FCfBbkMzRTjNC+xodkjJvmvb4ozIqjSuVznGEQmLZbbdnwIRnWi4N4L9S86XtdXYSDY1QomsWbEZQEQlG7R97wdIksyWm09y5jEQEtu8IaPNr1TCyRbwRje+gBDdnfMb3Ji7el6E3sWr7U8jfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dCM901zo; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dCM901zo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 183A21A0FF1;
	Wed, 23 Sep 2026 07:58:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF59A60580;
	Wed, 23 Sep 2026 07:58:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3089C103293C0;
	Wed, 23 Sep 2026 09:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790150336; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6azq8rMkmU2LnFPBdQxdKY1s1+p/LlK0UMMwQ7YndoE=;
	b=dCM901zo7/aqDAmS5m+K8CbOeD++D6SYnbn7MzgmNNPmIcqJjRa/E/+LV+4JptrzgP2x8p
	ubhk3Mo81CdfrpZBERJcEoH0H6Ay/TdJfi8642jgwye60ZWcswlT6PHBW48NerzHTplVMC
	LMvn1z4gJt2LZQs7k7zCqRDd/LqgkWIY5q8Ty9HM9uYozKyuyH1HqouUpDpjwNbZC/rnFt
	N6x9mnSVf4/pnJuxSuonW0y69PGY2ppB+pTt4PsC014BOTej1MxGkLM0jd5+6Ih4dd0iAw
	6Sl4zjuSsy78ilE5BbPChK+jdx20AKpjh+6K+aZEy5QfFeFT+6pXtElnp0YHvw==
Message-ID: <71f81115-2fef-40e3-a6d8-64ec66567fa8@bootlin.com>
Date: Wed, 23 Sep 2026 09:58:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net] net: ethtool: let tsconfig reach a PHY-only timestamp
 provider
To: Nicolai Buchwitz <nb@tipi-net.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: James Clark <jjc@jclark.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260922070813.1458713-1-nb@tipi-net.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260922070813.1458713-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 9/22/26 09:08, Nicolai Buchwitz wrote:
> TSCONFIG_GET and TSCONFIG_SET reject a device that implements neither
> hwtstamp NDO, even when its PHY can serve the request. The ioctls they
> meant to replace handle it, so the two interfaces disagree on the same
> hardware and user space has to pick one.
> 
> Drop both checks and let the phylib helpers decide, like the ioctls do.
> 
> As this makes a netdev provider reachable without ndo_hwtstamp_get, test
> for the callback before calling it.
> 
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

