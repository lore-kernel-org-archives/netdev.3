Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C333B7A8;
	Thu,  6 Aug 2026 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021254; cv=none; b=Ev32dXYHPlaX29peWSz2Zm58VA33N9iCeHAAD0/Vt15th3QLueLlRnu8tkXPBYLsGUMt3rxLA8JWuJaqgvR0vppOyFM/6RVtbJ7UcWX+JStDiPEGEEJmO4iyuJWgg4+CrV0S5oGbDMy80PIzgUqfL1/5n8R2uM1y4kh/b+ck6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021254; c=relaxed/simple;
	bh=/fa8VdIPaUqPEhTTsUX4HkD6atlDUaZ3c1JsGwtA/mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gf6GYQgnes4YosgivG9w/Ll9jxUM/g/pfSt1NeOHywdrsb+O4CUddBXyS8OoN0Un+BPHOw2H9w6H7dO2qmaju+eeaeCMlJHvPomsHKbMLhm9Npt8iOI9jn2977xmyURa1tnBAEcp8jL99N2uJ8hJUjRZxLHiiuW3e/JdIep2S/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYUZNsGv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYUZNsGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD5A1F000E9;
	Thu,  6 Aug 2026 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021246;
	bh=wRqcmRy7CLmoDyS66+DULYDtYqTbfNYO5q1iOPEcNYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eYUZNsGv2UZWGZfDy6Oz+I73UkNuXk1aYveudLWQY0vkzi2dMjOr1VAf1+Wa9leO1
	 iB+qt+rnmzt3p006n8vvQqioNqea2c+YOBdPo/yrnvBypuze0ZSXraY+oNG9JGsmsP
	 xNP1nYEzFk3fyt9wyA6n7PVR7j0B9slXKuONM+qyTbo441Tp/GrhR+6Npu/neTChqu
	 G/nDcHJFInnzW3jzTj8O7NE+ofy9gCLFGMjares//hYn7N6GbfIGBtqFfR5QkH5koo
	 gz/iZeuBjz+0tEors4Do0au04Z1IBycIYHjdZHcODuKmqvMJvMXDUeDKwMeURy8icd
	 9JiSwGrvyiXCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19862380820D;
	Thu,  6 Aug 2026 13:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: mediatek: fix TX blink masks using the RX
 bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178602120563.832117.16144265633708146287.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 13:00:05 +0000
References: <20260804113511.3371248-1-naseefkm@gmail.com>
In-Reply-To: <20260804113511.3371248-1-naseefkm@gmail.com>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew@lunn.ch,
 angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 matthias.bgg@gmail.com, pabeni@redhat.com, dqfext@gmail.com,
 linux@armlinux.org.uk, SkyLake.Huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  4 Aug 2026 15:35:11 +0400 you wrote:
> MTK_GPHY_LED_TX_BLINK_SET and MTK_2P5GPHY_LED_TX_BLINK_SET are built
> from the RX blink bits instead of the TX ones, so both TX masks are
> identical to their RX counterparts. The TX bits they should be using,
> MTK_PHY_LED_BLINK_{10,100,1000,2500}TX, are otherwise only referenced
> by the per-speed branch of mtk_phy_led_hw_ctrl_set().
> 
> A TX trigger selected without a link trigger therefore programs the RX
> blink bits, and the LED blinks on received traffic. The masks are also
> used to decode the blink register in mtk_phy_led_hw_ctrl_get(), which
> as a result cannot tell the two triggers apart: an RX-only
> configuration reads back as RX and TX, and a TX-only configuration
> reads back as neither.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: mediatek: fix TX blink masks using the RX bits
    https://git.kernel.org/netdev/net/c/f684c514f796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


