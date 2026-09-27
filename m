Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B77351C2E;
	Sun, 27 Sep 2026 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790499802; cv=none; b=IXhHL345+ODKbZe0z6GYRnXul/Yx7wQbgVEutfKdzqpjN/JtIe0TbRJEV+3MfLbkNhvPdf3VRwilag6p22vef5s+UyQY1LYbwZklV2f5XX5wPY+6agwqxN9MttI1z2y7Uj+6EwkxTIpazBgLbqRZ+j0cDOzb4REJ4lchkvSpdHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790499802; c=relaxed/simple;
	bh=axDBsYhYMhAamY6K11zG41j4l7m4d53B7svr24q3DZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhA4MqTJlxNwr5c/u/WaC+DFPsfCRlKbElX9ZNpIbJH35UhM5kml9heQhY48hGi/Hi6P9E+HKLuUwEyS4TTzaPhY2C3lgwebjmHXRNpUj9knf2S+NIUMQjp+r+dHnSasIKcMmo2ow7pot/JMN6Aolfxc7cUGAV1HUd4rhBia2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=LtBc2Liv; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=MuQRBScc; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="LtBc2Liv";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="MuQRBScc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790499799;
	bh=axDBsYhYMhAamY6K11zG41j4l7m4d53B7svr24q3DZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LtBc2LivQTcLsodJhkroMJ1P11EALoM3fr+oWjfzkd2SBvvlREMb2CNbMszuLFVe1
	 khQZvpkz07OFgL8Jyq/yRT0C7Nv8hBna0SinQOLbh/KitfKeLYqXF6d0H6XdEk8cvH
	 md385XwiX+6JkwlmZb1L9wkvoBWXKMo/xvUwo7EvlufTBbCeMJyrG6ioHfnebX1Qep
	 MQXyCPyCDppoimOQjrFBsHoglggJq8YceWPI9R0wcHto9tSzbUd96KHT0/iW/IiCAl
	 yc+8iej0CLBJYZUFYJdaI+bj1VVa/tZI9zvUgm0Oa9kHMvldio7ynsn5hiBvqlsrOS
	 Ja+iaYYYmQm1g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 03CB44130C; Sun, 27 Sep 2026 09:03:19 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790499798;
	bh=axDBsYhYMhAamY6K11zG41j4l7m4d53B7svr24q3DZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MuQRBSccFmzlqUYRnkrL5SL/ilyFwp3p+JsqYNHWf2bnB97jgcU028PGlE7XEE54w
	 PWO2VgXm+/z53DHdQueHNkDsmpBZx/tMMOMBT8yXeHt2W3zdbNwl2t23hE7pUaX2gN
	 YvDfJaDz7r39h1SX8AKnC9CE5Zz/I+5KHgQNvR5xR4ZWO64+2FlT7nslWkdepvhv+1
	 QfiNMtPUNIWXKjvi5RvK39dwSBW2v+b6Y+4ar7PBKSUSmGFIXJhoJTA4r11RELFGmN
	 H0f9SlUHvXrGRlTYA1cLrnjv5lCUlfwNJFRNnakkv6rAbSACovtBn2h2Pn9wAP8bEA
	 7Kqvg56qlghgQ==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id F3306412E0;
	Sun, 27 Sep 2026 09:03:17 +0000 (UTC)
Message-ID: <17164abd-05ec-4b6b-bc51-a017cc87047b@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:03:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 01/15] phylink: Add phylink_mac_interrupt
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-1-60c04c9924a2@birger-koblitz.de>
 <178968029017.22033.2874254681410388676@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968029017.22033.2874254681410388676@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/09/2026 11:24 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> - [Medium] `phylink_mac_interrupt()`
>    (drivers/net/phy/phylink.c:1621-1628) reads `pl->phydev` with no…

This does not look like an actual problem, as the interrupt is not 
really an IRQ, it is a call from the MAC layer, calling 
phy_mac_interrupt(phy) did the same in the past.

> - [Low] Claim that the newly exported `phylink_mac_interrupt()`
>    (drivers/net/phy/phylink.c) and its prototype…
See above.

> 
> --
> 
> phylink: Add phylink_mac_interrupt
> 
> This adds an exported phylink_mac_interrupt() helper which forwards a
> link-change interrupt received by the MAC to phylib by calling
> phy_mac_interrupt() on pl->phydev.  It is intended for drivers that want to
> avoid polling the PHY.
> 
> (no Link: tags in the commit header)

