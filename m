Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C063632B100
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020192; cv=none; b=NAV0zkEW+xCYW67KpdFu1Flrism9ort9WWqkwxRm5PmVQHXKVShEZHJeqEu/6m3mFf4GkIJI+PuLoiG6pE8aMnW7TtpHUMSios1ifU+Wf9K2kFynGHISgAxmCngXZR6I5ArTE1xOy8oYIYIeNPj0Mo1yRZthyPus64522pfcygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020192; c=relaxed/simple;
	bh=WZ2FWZnT9dmDPMzlD5FMdwCiYfQY2yZo7icyCqbtwQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pa7kgGnqcR+HYN9V4J7hvcEXzVdMOfZIa2A7Ar4rHhx8++BaFC3hmjLBTH+jRVoOLjxNHSFpACnbuBVwE7TKlkRPsdsRrD/IrrHmI4m9/0VgzKcmik5NuK2R242e5zzU8vE7q+Cr44iCXhrbUiJ6CqlhQukIbcQ2bjiZ0ax/yw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Og+Gnu9V; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Og+Gnu9V"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C19964E40DA5;
	Tue, 14 Jul 2026 09:09:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 798D660346;
	Tue, 14 Jul 2026 09:09:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E13F511BD3B3A;
	Tue, 14 Jul 2026 11:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784020180; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ozSa3T9ij+0lBWz7LHW34zppRGNM+3YLXw6TADfiaAM=;
	b=Og+Gnu9VdoPhUouB0iDiUx5rU+l/y4uo9o2CPSCbqSpTi7WO54hAq6lCHBf48GQ7Wm5O9X
	wdCEx7ZL6RRNr+FRb3cxjISSBOJbJUUvLEesiTLGLztt8l5LbT1lmA+jCfFGPDbRdMLfwC
	JHQgRv2gQQk09rY5T6GrccVa00Y5lHWl1j9l+Curv7qypMsjhJ5G1Dy7OehMw3R5IjPv3O
	xcKKDYbJhkJi4PQ+L97zhGXbaEoTHlgp8l6LgjAHYqtVfIOv0GRJlgvPYGIphHIP7FPaVF
	WZA7DozlH35dYUfRAgg47CA4koWBCeuT3xLQXltVhEtw5s2rIlFlhJqzC5pxFw==
Message-ID: <222c0e2e-93b2-4209-b20e-0895090cf655@bootlin.com>
Date: Tue, 14 Jul 2026 11:09:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] net: stmmac: fix l3l4 filter rejecting
 unsupported offload requests
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
References: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260714023716.29865-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260714023716.29865-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/14/26 04:37, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The basic flow parser in tc_add_basic_flow() does not validate match
> keys before proceeding. Unsupported offload configurations such as
> partial protocol masks, non-IPv4 network proto, or non-TCP/UDP transport
> proto are silently accepted instead of returning -EOPNOTSUPP.
> 
> Add validation to return -EOPNOTSUPP early for:
> - No network or transport proto present in the key
> - Partial protocol mask (only full mask supported)
> - Network proto is not IPv4
> - Transport proto is not TCP or UDP
> 
> Each rejection includes an extack message so the user knows which part
> of the match is unsupported.
> 
> Also propagate -EOPNOTSUPP from tc_add_basic_flow() in tc_add_flow()
> by returning it directly rather than using break. The break was silently
> discarding the error for FLOW_CLS_REPLACE operations where entry->in_use
> is already true, causing tc_add_flow() to return 0 (success) for
> unsupported replace requests.
> 
> Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

