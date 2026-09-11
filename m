Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE8493D37;
	Fri, 11 Sep 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142228; cv=none; b=UBeR4WBUEhWU+ChaS1uFhZLv6d+sQKdUgJxt1RVK4rTFUceaFWOEU+KgHFBw1UmEPqASHQmo+cWw3ou/PsftDFtg7BsOXDpkXuEqP2Qj/K3GDSsLrD64oae+bClKcNV4cdTilC36DqyLBtwtxbNnFYkDGqzQa5esmMJjXA2j3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142228; c=relaxed/simple;
	bh=nEcTvLu+k18d1hRUpJWufqfN+bwvM+IxOHQj4EafRvs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePHxg5DsxdxV1NfsvU6OQMGTLCnSpWkVcaMmPp6vXKHwP0xuxqpaZ/sPi3RAEiYCpm3QRPJfis6aG1G25O0hhsGT57OHVar4WyWBkGkVK+JkS2nPHrYKL0ud5BcthmU36bXO5ySO9JfpmUJHbgHg2ACBI5pb5rJuSrsV0Ws5bQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=g+fuztgb; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="g+fuztgb"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E18243EDB0;
	Fri, 11 Sep 2026 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789142223; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=U6Uyil1BKKeEyc6ra/UxHlW3xO4ewl39s/DeYDLNNgE=;
	b=g+fuztgbqQ6F7ZOhJDhBL20UUTVdhRFaFtBDk9DsdPPkFmnzOv7droXKOJU9g3hSHn1JkY
	bS+oyWy9QdC0JWxNtkZx2f4A4NefX+54m2GuUya1BvKH4Xy3itXg4dzbtbzX/HAJttPlBf
	DNZ6MxLBPUMwkaONuv81G6lNXct8+HvU2S7vS/eFBeRWPrD20wfOn3+kSB5GvPKc5BAws3
	5p6dD+ZO837fSWbqpvnkF8AQJstEwiPxIKDI8G4iOzhKdgon6BAJ5pKbjJguCVzQx8jl5z
	8weiEpd36KUSflko3PD24hdFN4WuBFNrVsYVV10HQh1XF2NVkwVWCsH7yM/4nA==
Date: Fri, 11 Sep 2026 17:56:59 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com
Subject: Re: [PATCH net-next v7 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Message-ID: <20260911155659.GA32745@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260904-wiznet-link-gpio-v7-2-69f01b70c96f@marmottus.net>
 <178895754004.219967.902137420360139647@kernel.org>
 <20260911153325.GB9585@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260911153325.GB9585@marmottus.net>
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: 0
X-GND-Cause: dmFkZTGCKCepkROQ6Ut0n5AAcNt5583BVqXmeqbkCcKk0QQr6S3GR74ATnFnxdmhJExv3OEBUnq+OkEyFSIayRT1Ips1HzSle96eQeGfodcyefYdQcslT3JkhItA+z1cR8y9H+ZoJW3ew/AxSMR7tTMwkOo+FWBVjwhtk8RmMJ+lh652wBs8LIxZA0AymrGDCkcNZfsN95D7nVxZZdI8GtC3Vno8ySbCFHc5kDa26OtFQNWT3eqYK2VyJ/FiRYUw3HEmfKguPqmgqvRLsSCK/tkHr0x24V7wYrLDtDMkE8tgBYiJIVw0ytkrNSGmy4rksOBu9YfuzZB28niFurLT0cy+uWXCbnGp4955XlCWMfyQRWwNYkvTt0rBr0lD8oKWAit/C3Pf0G+w54yu/tCnbujOAjc/uHF1N0hEmNJvW8x2r3peqw8RvxQB+ctTMc8Go43fwuzJzPrArUJQHQXy5STyZTxz6ZRvCGLH/Qagp3ErFD5fWWQuVBJTPSsQHO6FCrpw5HRMqxYcS4WCDPpg8LIUHXx0Wp92fQHRFWSXCxxR32ZV6U8IDOc3Vb4DC9K0wn/DXhkjG/EYBOsF9+ZUE4NeZkzPYjJUFOhd7Lu0ypbyUqdxPbEkqFlUAlCi4XaD52dbQWwKeR++EpDd744WAFgK/GVA3RYVDpdEsCzejWUhuPpbcA
X-GND-State: clean

On Fri, Sep 11, 2026 at 05:33:35PM +0200, Arthur Crepin Leblond wrote:
>On Wed, Sep 09, 2026 at 12:39:00PM +0000, netdev-bot+sashiko@kernel.org wrote:
>>Should the item count be tied to the compatible string, for example:
>>
>> allOf:
>>   - if:
>>       properties:
>>         compatible:
>>           contains:
>>             enum:
>>               - wiznet,w5100
>>               - wiznet,w5200
>>     then:
>>       properties:
>>         interrupts:
>>           maxItems: 1
>>
>>The driver side of the series treats index 1 as w5500-only:
>>
>>drivers/net/ethernet/wiznet/w5100.c:w5100_probe() {
>>   ...
>>   priv->link_irq = ops->chip_id == W5500 ?
>>                    fwnode_irq_get(dev_fwnode(dev), 1) : -ENODEV;
>>   ...
>>}
>>
>>with w5100_get_link() returning a hardcoded 1 for the parts that have no
>>PHYCFGR link-status register.  So for w5100/w5200 a second interrupt in DT
>>would validate but then be silently ignored, since fwnode_irq_get() is
>>never called for index 1 on those chip ids.
>
>Let me update this and have it conditional and re-request a review
>from the devicetree people.
>
>Arthur

Or maybe updating the description of the top level interrupts is
enough, the same way it is done in example-schema.yaml?

Arthur
