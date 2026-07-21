Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D737AA86;
	Tue, 21 Jul 2026 00:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593347; cv=none; b=AlDiiUdEPBq8qjLqGwK0FFw9J287ft6DsDjyI7lXV2QydNkt/ggeWIuOabQ6KbL+2iDL1X1oiWQKIcxtKu1egF0/+0myuzwUDNV/j+3QjAC0gAVECSxY1/6CtGRKyT56rKklnbTxiSefPd7zkNxH8rnXpRloTJxm4bvRysynkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593347; c=relaxed/simple;
	bh=Cge3HMDPmmRdr+Kv89IMZ/uZM+Yb9qwUgxKR2KKvMHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6+qW179IXgWnuwfEdGrKnCfcpTcoKmqxxXwmwlbIw7EUy/23XvwRP3HbtVrDCPSxzRCak5PztaQWYeZHlmp7C7JGi3PJcJJGtavDxIg3GgeLCHl4g2mw0phLtMxKMHSG1SyRTwU7rqrZiDDBr35wWyzSoxIVUk0gYSHeuSVGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd06UZj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd06UZj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF48E1F000E9;
	Tue, 21 Jul 2026 00:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784593345;
	bh=d3x6lkMjbpqW38S1ZhdC6Jgg2py16mplFkzcrr2EDRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bd06UZj1TKL4HlWQEYdKmAg+t5dpejrB3HJnUba8vTuIZgv25pDclUEhNSZ0cf5uV
	 XLtp3nrlpou9nwj6W1ZBbEEqTkJxoonZcuHCd/cMcVDY6df7uXPZCZP4eRc8LkgETc
	 sykAy4YvqNDirxFpXE5hkGtb0vUNGAuC1V+KnVis9meahhTWiLj+DG07ye8IFGg+23
	 qaGCoTLDBctYgYaQY4AIjg7xrE+6SzPgF7REfLkJguIvOLhT+wZ1HmJFWBBTDkpxQU
	 /vdId6cfM6CCLgkOLIRIJYv80mZIdyJoixdYmVdzNN6O+FyKAP/RyOjQWGwBZQhjZE
	 kekjUC0ZH9tUg==
Date: Mon, 20 Jul 2026 17:22:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek
 Vasut <marex@denx.de>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
Message-ID: <20260720172223.7492e28a@kernel.org>
In-Reply-To: <20260704-ks8995-to-ksz8-v7-4-2af0eaa545a8@kernel.org>
References: <20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org>
	<20260704-ks8995-to-ksz8-v7-4-2af0eaa545a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 04 Jul 2026 21:39:36 +0200 Linus Walleij wrote:
> This adds support for the Microchip KSZ8995XA also known as the
> Micrel KS8995XA switch to the KSZ driver.
> 
> Notice: there are also KSZ8995E and KSZ8995MA. These are BOTH
> different from the KSZ8995XA.
> 
> The helper macros are named ksz_is_ksz8995xa() to make it
> possible to add E and MA support in the future.

Clang says:

../drivers/net/dsa/microchip/ksz8.c:263:13: warning: variable 'reg_4q' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
  263 |         } else if (ksz_is_ksz8995xa(dev)) {
      |                    ^~~~~~~~~~~~~~~~~~~~~
../drivers/net/dsa/microchip/ksz8.c:288:29: note: uninitialized use occurs here
  288 |         ret = ksz_prmw8(dev, port, reg_4q, mask_4q, data_4q);
      |                                    ^~~~~~
../drivers/net/dsa/microchip/ksz8.c:263:9: note: remove the 'if' if its condition is always false
  263 |         } else if (ksz_is_ksz8995xa(dev)) {
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  264 |                 /* This switch has no 4way split support */
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  265 |                 mask_2q = KSZ8795_PORT_2QUEUE_SPLIT_EN;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  266 |                 reg_2q = REG_PORT_CTRL_0;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
  267 |         } else {
      |         ~~~~~~
../drivers/net/dsa/microchip/ksz8.c:237:11: note: initialize the variable 'reg_4q' to silence this warning
  237 |         u8 reg_4q, reg_2q;
      |                  ^
      |                   = '\0'
../drivers/net/dsa/microchip/ksz8.c:263:13: warning: variable 'mask_4q' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
  263 |         } else if (ksz_is_ksz8995xa(dev)) {
      |                    ^~~~~~~~~~~~~~~~~~~~~
../drivers/net/dsa/microchip/ksz8.c:288:37: note: uninitialized use occurs here
  288 |         ret = ksz_prmw8(dev, port, reg_4q, mask_4q, data_4q);
      |                                            ^~~~~~~
../drivers/net/dsa/microchip/ksz8.c:263:9: note: remove the 'if' if its condition is always false
  263 |         } else if (ksz_is_ksz8995xa(dev)) {
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  264 |                 /* This switch has no 4way split support */
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  265 |                 mask_2q = KSZ8795_PORT_2QUEUE_SPLIT_EN;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  266 |                 reg_2q = REG_PORT_CTRL_0;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
  267 |         } else {
      |         ~~~~~~
../drivers/net/dsa/microchip/ksz8.c:236:12: note: initialize the variable 'mask_4q' to silence this warning
  236 |         u8 mask_4q, mask_2q;
      |                   ^
      |                    = '\0'
