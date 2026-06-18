Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7038D3E9
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771051; cv=none; b=m79jymgGutrtv+rjYg/OxQGtFIoY7H+xw+fNc3AXsy/AfxxyOusZcY2R6hc8H5+0+cLYPxTjdznDh0+Sth8w9R+x+6vEA81trOELRlrKnLYZklRGcjEVosNrOOvQANhbGqXhjgp741CexEvk9mQbhPuSgZOYadOqM9qkhSyCHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771051; c=relaxed/simple;
	bh=Jr8MuSN0f1khlBWhNBWG9mP/rjBRDgaRgJESu0THHwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kTAAWhWkbePFbpuIBnZEib4BRQm96LValolwsUDy0SOt2OiMpvCkuVGZBu1FiJ5xto81X/4t0m1OvGxRzUaAJaZTLEiA3sGB781dKNDlf/crXiRFm8+ePSuzu7MF9iVtM8QInlylF+DeNadl/z7Ym4C9SFxeYH9DuZ18cjE8wAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p9vw+VG0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p9vw+VG0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C3C211A39F6;
	Thu, 18 Jun 2026 08:18:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 896215FF03;
	Thu, 18 Jun 2026 08:18:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C99A106C88AD;
	Thu, 18 Jun 2026 10:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781770700; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=lRVKmEoMOHx3NUrr6vG//IJN/FXejwsmjpLhQB0fvl4=;
	b=p9vw+VG02qJbJO1ZMpkg1Z310QH86FPGFwlV7WPw4gzLnnWQ+iaabmNvdP0UgWG2UIbAbi
	p4lgLFLb3ZxbBeYpXjEZWw7n4ttXGq/q5tsLwNWGq+oVsscEz6uGeyZx/C8cfQue0ikBtS
	0mgUNr61RC6ZxZZOBsV4fi4Y8/NKDfSe/jKgxecyAZtex71nFAJtIcP8mJip/Ck6BVvosb
	+TD9xN1dm0kWqk3Y+KlJnXP+SYT+lJOUNhOUbC5Z45o5EYKZJpJ8QGfBtyoNMdbqqMdgQk
	AX4SWYSrDYV0BptsHQhP1St8pc2SC0qHjwL/OdaUF5uhmiM0jFovv60F0Q5EVQ==
Message-ID: <e3d95562-a036-4e12-8a03-6ddf9d5c612b@bootlin.com>
Date: Thu, 18 Jun 2026 10:18:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: marvell: prestera: initialize err in
 prestera_port_sfp_bind
To: Ruoyu Wang <ruoyuw560@gmail.com>,
 Taras Chornyi <taras.chornyi@plvision.eu>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>,
 Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
 Yevhen Orlov <yevhen.orlov@plvision.eu>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260617193228.1653582-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260617193228.1653582-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 6/17/26 21:32, Ruoyu Wang wrote:
> prestera_port_sfp_bind() returns err after walking the ports node. If no
> child node matches the port's front-panel id, err is never assigned.
> 
> Initialize err to 0 because absence of a matching optional port device
> tree node is not an error. In that case no phylink is created and port
> creation should continue with port->phy_link left NULL. Errors from
> malformed matched nodes and phylink_create() still propagate.
> 
> Fixes: 52323ef75414 ("net: marvell: prestera: add phylink support")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Sorry for the grumpiness, but Andrew did ask you to read :

  https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

and one of the first things it says it to wait 24h before a repost :/

The patch in itself LGTM, so :

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Please wait 24h next time,

Maxime

