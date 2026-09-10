Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71E408614;
	Thu, 10 Sep 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053680; cv=none; b=tzAuIYUBsfcTtAaPBa8DSV9/CRvymwyl22GDUuAB+97BT9N83ENYl5BQhn1rioLPPjI+isnkr/cItxImUmmjETGtXizSSSb7u7+qnbbDi+zjR5gAN8SZW+zGQO1/qfviS3t+RZ8/rdW+a5Ji1vVQygtRkv/my97WkE1MM93de/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053680; c=relaxed/simple;
	bh=7cfZkiKJwmCEA3BDbBejz2Td9xjhbgbOaRYLlnKaWl4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sca8Pd1C9lixksBNfxiYzKCYueCIPry41y+0vpO4yCR5ornlX2cAy1S3UyfNbTALl0N+07lqSFwvp4o1zBwk3k7EfCbwUsbjT8wCetb4I+wDMDg67+hk3HmbR3qZ9epG6m/OG9BjQoY6lFeZ3hwCstNsnjGL2t5zSpPEeSK2mJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGEU4Hs5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGEU4Hs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DE91F00899;
	Thu, 10 Sep 2026 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053672;
	bh=QBTCkpTfJ/RsxTsPfeDu6QW4Q9j7khudyRmxhb82B7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IGEU4Hs5zCeOAx8VPt8MBvmSFUQgWjoIUn1m6B/zpyZ55cQjEQw3q86VyxfD+paLf
	 wYGKf+jjUl8noWdt0ZbAs6Ryk/lksSF3xeECzBdNbeGNEF0OZ5lC/EG6MhBDVpYVdO
	 7S56A1JVAmP5paQX6w/RZI9ztussmYuvUXI4QLxIR08jzjjGx/jdIsDHqf2tErNBa+
	 TATN96NkNT95YSW4/1SfYNC1dImUhZ2g/Ot10bh0tMZInInu6WXYSgLi+lETCMujkY
	 AumnoTJ+yX9Q2bGIOUh02ESMHO7IwxSl+J/e/q3tIJe0tCoWsrT8we1NNscDr8+qji
	 qBWYsos0iCLlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A19380CEF8;
	Thu, 10 Sep 2026 15:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net: phy: handle the active-high LED polarity
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178905360938.1492964.9209925630234806744.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 15:20:09 +0000
References: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, daniel@makrotopia.org, o.rempel@pengutronix.de,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Sep 2026 19:59:56 +0900 you wrote:
> Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
> LEDs") let a device tree LED node request PHY_LED_ACTIVE_HIGH, but a
> ->led_polarity_set() that only handles PHY_LED_ACTIVE_LOW returns -EINVAL
> for it. of_phy_leds() propagates that, phy_probe() fails, the mdio device
> is left unbound, and phy_attach_direct() falls back to the genphy driver,
> so the PHY loses its driver-specific configuration. Three in-tree drivers
> still have that gap; each already programs active high as its default, so
> the fix is one case label per driver.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net: phy: dp83867: handle the active-high LED polarity mode
    https://git.kernel.org/netdev/net/c/36a45facedd5
  - [net,v3,2/3] net: phy: dp83td510: handle the active-high LED polarity mode
    (no matching commit)
  - [net,v3,3/3] net: phy: qca808x: handle the active-high LED polarity mode
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


