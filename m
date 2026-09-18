Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4E31E857;
	Fri, 18 Sep 2026 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714995; cv=none; b=ffseEx7BoiLJ7/kVuWkFVA/iYEegIBlj3y8BsoRe5zwo8idV31rTtlc4bcQc5jvqwA5fbbKYy0OgLYHZTmuPK4ZydNRtDjDopdjlRI2UmosH7ZnuXiiGk9anIYM1M/DQ5OiW16T939yCupQ/FG4uGyqiLm+l7QOEy04LsML1ya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714995; c=relaxed/simple;
	bh=qKgn4VfjpM1+mtgs8P9dnXzjLcJPeaMJrhazv9TUqVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAvjLp7Prglyectl+VlF0QxIpJT834REG6Qot66msGAa9zaL0kZ2yuJ3JYMJOWgY/DIagqzsDv8+TXo+s/r8wcdFHFByjW3C2BmYz5fRtN1FuKr6Kfn7QyNwkizwrkcotI3UxgwlYDck1gqBroQx5tiG8lGYxtfchmMqnrVAI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=FYDKqqzf; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="FYDKqqzf"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B41E3EF8B;
	Fri, 18 Sep 2026 07:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789714985; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=GumGYp+cZSxuCV/vggU6CfFLl2osu3Yi7rq4u6xZB40=;
	b=FYDKqqzfI1/+QmURCALbya+IA+a2XFEbhIRo17LICNpQ+8wkEYGhLoXcW5ctzp8bIv3PwZ
	vOxVHg4bGmUqag6GP+/ZICgNNDxINxWJHtO+iAqGBnx13n59SX4a9U//0yoWUEXicpR1m8
	+Hf9v/1T5WmdPB7pHMTYKWUVZyNYuKxfI01J3Lgg1asJKwIVOQbmOvC3HGHPcCuo9VzsC8
	LFLTW7+EyoIGjmzV5B1X0iqotxwjSVRSrQXQW4lJE3j1lmVhYslcZCOFeXHutAgLrx8AD0
	Me65WlIVo49WJWaDDgW05RUMTyq5SiLyVoGCrRwmBg9MSiD+Tp3reticC6b31g==
Date: Fri, 18 Sep 2026 09:03:01 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
Message-ID: <20260918070301.GA21010@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260915-wiznet-link-gpio-v8-1-d173622474cc@marmottus.net>
 <178967572953.22033.7825853149442957564@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <178967572953.22033.7825853149442957564@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTG0WQYNJKjuTrZ7Jv8Q2MRe38byAzd4dVJebt3ZtAEPlfpgKrYdTS91pVnnM3Y85X9cS0VNpaaXXoocY/wzwmeDfS+MW5oBHdtRnUCADAqUuBVYUjKEzA3fVW+lcMOwVjvbC1C3lFKpq2s2kQjLvddX/w1Y3ulQmvZJR2O6wAIf/SBJ0PqWih2LJ1pOg0O3TYuLAfobQV3Sm6CApjYlU7F8CAI4y0eWcZ3yhP41mrrQgariGskOoByt6FlxiPUweaMaNc5z4N6cJK+h3gbVvSTOh/5ye7AFcNmIeN4C2Nkq4AQZJ3c37NCphFuMWg4xpcnpjZDctOaeqO5zvutgiEgmpLKctVwhNnZLm1+w1jNB2kAUmaM6UYUn3IuwnZG932HDvW9VBhOAV9KglywrEU5SoHlcv34P9sQ+1cc/iFGmcQ2KJz2PmMO7VU0hNnN2CBS7rjlEwY9Bp+YUE9HdMz8QJ1DbFmCHyJ8j8Jk2n+5JNiK8fePH++TwjTro/AuCLjcyuVe14Y5wlAFo+x2D3MVugFVv42yMSy24tnpTRNxuj0lFest6lhJX2NIzAwkMDOtW4T5DHKjJYlr9ndgDbmF6gZkfvd6lYXAyptk5OH8uSC/2S/W1E861nBM85i1/Evf9gWPTByjjmK8QdtV9PNHqEWacLnsdf803IQmKy58WVg

On Thu, Sep 17, 2026 at 08:08:49PM +0000, netdev-bot+sashiko@kernel.org wrote:
>[Severity: Low]
>The description says the 14 MHz limit applies only to w5100 while 80 MHz
>applies to w5200/w5500, but the single maximum: 80000000 is applied to all
>three compatibles.  Should the w5100 limit be expressed as a conditional so
>dt_binding_check can enforce it?
>

The user should know which SPI speed to use here. I don't think
leaving the scheme open to higher speeds is a real issue.

>[Severity: Low]
>This changes the recommended trigger type from IRQ_TYPE_EDGE_FALLING in the
>removed .txt binding to IRQ_TYPE_LEVEL_LOW, and the deleted text also
>claimed "w5x00 natively generates falling edge interrupts".  Could the
>commit message mention this correction?
>
>The new value agrees with the driver, which requests the device interrupt
>level-low in w5100_probe():
>
>    err = request_threaded_irq(priv->irq, NULL, w5100_interrupt,
>                               IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>                               netdev_name(ndev), ndev);
>
>The commit message body only says the binding is converted from plain text
>to DT schema.  The only record of the trigger change is the v8 changelog
>line "Change edge-falling to level-low" below the --- separator, which git
>does not keep.
>

Nitpicky but I can add a line in the commit body.

Arthur
