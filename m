Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9A51FCBF
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575635; cv=none; b=kvy45EMs3vduH/go38JfZORhgS4dFKc2PhWTn7IJNoK3185mhV5xJMeSYpS6KV7jvpgwkfdDDE+hbuGjr8A2vMGgSZf3U9tQdV3eTHWfymYxR5gWsoyU83LJACYqxp5FNE6Z+JZE3ucY+E496KjM5Zd9YdgelSPfVim0OkHZ83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575635; c=relaxed/simple;
	bh=HpbnWJEGL9NjihNHGwgBoO1lxp2f2aVoZ/arzsurXIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SnSiOBOC7F48GtsSy+ebwAlHsiXmeh2vE7C7OyEI4puYSQYZnuNukFAuXeFS6JrLNtWsF9Z3LUsygjddmngCUD4iRh91uUbtwP3JpR7UUrMssvHa5c/sFUDgz/smN9sBq4idiNvM2mLrYYblyiLYDnc415EvvOZZVj365x4lMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U4LHQ7LS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U4LHQ7LS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 726E54E4052B;
	Wed, 16 Sep 2026 16:20:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3936760337;
	Wed, 16 Sep 2026 16:20:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5F0D11C7B05C;
	Wed, 16 Sep 2026 18:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789575624; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HpbnWJEGL9NjihNHGwgBoO1lxp2f2aVoZ/arzsurXIo=;
	b=U4LHQ7LSkICNCO7ToQ5xHrfiLdcHnz2/ttaah0BkmBXIG3MqosnQEOR5X/7NxellbJcRGW
	xAG4jSZy8VuMGs7IKTOtPPE4SyaZQJvbp8ju4uZj6C1Mid42WZB71TsfaYB9eReILV5xt9
	dEjapsyZsOTgw6i3141Ykl6ja0onsTjXrNdltqKrdpZBCPJT065I174ymwoX/oDyH0vpk9
	MnsZ1VaSWZuuCxP4TbPJu8s+enkrl0MToPUlPS0+ZOIDuz1v7j+i9itsMm1iuGXBTz1f/r
	oY8nmD0cUWLykxhWvfRaeCudRkhWYXUAt2RuEXeMhPVXNZ8MGIuhYXAPo7ILIg==
Message-ID: <9609a821-c971-491c-9436-9346c48d2ee5@bootlin.com>
Date: Wed, 16 Sep 2026 18:20:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 00/12] net: pcs: Introduce support for fwnode
 PCS
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20260901083001.8044-1-ansuelsmth@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260901083001.8044-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christian,

On 9/1/26 10:29, Christian Marangi wrote:
> This series introduce a most awaited feature that is correctly
> provide PCS with fwnode without having to use specific export symbol
> and additional handling of PCS in phylink.

I tried to re-rerun the mvpp2 prototype conversion, but it looks like the
series doesn't apply cleanly on net-next anymore :(

Maxime

