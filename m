Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACD1C84A2;
	Mon, 21 Sep 2026 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004679; cv=none; b=W0E6VuCUl0A8eeY5ON177fj06KJwISkms8Sdu9f1psjtY3U4HGzX1rtbjhBxLOyDDkpgq90VyaXtCLtpVHkYpQASAHKfStogd/q8hhcjiat2qCCorv3KGQEENYmTUuDONtOKBpp5I3m4rsAQpM/iXETrmMbM1VJb9aqgj4dHkRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004679; c=relaxed/simple;
	bh=JBxZa7ECxemIyq8dlOwFYNpgISRTtG32z9tiXkMyBGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DThKYrirarYqVA/t/CiWmk09VgFBt/lff9a4ueXBGcIvFAWHOlFwDqe6ZMRUMnLQ/9v9DLPB6GWo0SA+ssyH2cSxR7hCur4ixAvDEFSl7hl9lkwnvKWm+EfWFjaUeFpujuYBg/D9Xc9jQr7d72CNJmMycYA/Lq/lYHubC471BXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=RwoVCf/h; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="RwoVCf/h"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2634D3ED37;
	Mon, 21 Sep 2026 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790004675; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=kndgaOttwPZ+kUaDtO0GHPyUH+YzrYrUKKHJTYtyiQY=;
	b=RwoVCf/h+yvoX2rgU2FuL49s6IqwbVluLjp6FwqoDogg+j7BBbYiLTK2v7Z0aQsb1KToNA
	1LgZKTPRafvJeZQgXd0BxWIyBsfW6pa3WXk8MDk85A0dQJLmpJnOXB1VC4tjTd0WIj4H55
	0nqQvgfSTyebM7QLAWEYlq6HI8OQMsyM82FHiRN8jgnulMlIUd9N44RUMpOGAdzGfbKNd4
	YD8/xf1k+Ngutl57XMNtUndW/DZMQ5upwRyUyXE6lb+i3l/HVkC8Q4rs95S1ND2X33qyDd
	dxTyRh9weQnhfgpu93tr75PLZ72JWuzQle+VyFuFOop+2LEGXqiZwPmlYfGIuA==
Date: Mon, 21 Sep 2026 17:31:11 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Message-ID: <20260921153111.GA473474@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260921-wiznet-link-gpio-v10-0-5874a7a147a2@marmottus.net>
 <20260921-wiznet-link-gpio-v10-3-5874a7a147a2@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260921-wiznet-link-gpio-v10-3-5874a7a147a2@marmottus.net>
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTFk3EfQn6dh5Bsj+M9TyimFVXuktxuO0nReL/UPfGv+6oQvqWasbV+IaeMW0iL0Vyyu+a37201ZBX4ak89sSK4J02MmlDrOnt112hJTDGhWzR5PU9+rT4OFwFSDLlqWK+eHX281VsymAkNbDqngCco5Q6ItcUcGQtL3YGnMmy9r+wva5tNRDObd2tdVNZ1+sFrGEJ8WgJt0Jl9P6Ftc02Ge7cPLjHK6GPHULLgaA4QGGpOBJVViFyWb/wi/NI0lwj9KmhswyBSGoFlkT9FraymFkWj25poLbxMhz2tNx38+0R2WKGKf6jcHZo54szt96cpLPwpFHFg0p9CKBfyWpL1puCHsbygGEsGbjQubyAlvEtIfMUkBax00sDthytIt+WBMZjw/hpkJrMU0aStqCQoLkPWHK9hz7sb9uKVkbePdUMiSQ607AwcfgLvfUkDxb4bsKMT6KffueDK4VSWQHi/PT4BZVuB1lv46D9IU7/2goHa4g1HSieotCdGGZikEOKfNjouAZi4dG/YXpR9/o2XLPzCgPkxb6GHAeFqHUdxt+02qJlprj5dowZd/T07KdJ77+niNfukic5JFqUUS6r8d5p5tmyOVW//dnlNPf8g1kOkaIKBOLlbyKlUM9tdHayRjpsUNtQKXByxFm+UvcliefkrE+JqLwCrdEIsL3rlQWQ
X-GND-State: clean
X-GND-Score: -100

On Mon, Sep 21, 2026 at 12:52:51PM +0200, Arthur Crepin Leblond wrote:
>@@ -794,22 +923,44 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
>
> 	if (ops->may_sleep) {
> 		err = request_threaded_irq(priv->irq, NULL, w5100_interrupt,
>-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>-					   netdev_name(ndev), ndev);
>+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
>+					   IRQF_NO_AUTOEN,
>+					   dev_name(dev), ndev);
> 	} else {
> 		err = request_irq(priv->irq, w5100_interrupt,
>-				  IRQF_TRIGGER_LOW, netdev_name(ndev), ndev);
>+				  IRQF_TRIGGER_LOW | IRQF_NO_AUTOEN, dev_name(dev), ndev);
> 	}

Oh, I exceeded 80 columns here...

Arthur
