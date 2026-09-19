Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A738DC50;
	Sat, 19 Sep 2026 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779692; cv=none; b=HMPGZkzkA1+gZM0FV0za1f7VB+FlOpZfkV7IUwxhYp+7bavHEultK1eYaFIN8sVwjOyX2Gyq6w8ctJD9QJtkPie7mdsxYLdSWHCC2PjIIrwBnSB71b+ikLvUWIaOQaRx3B+8n/N+9hyZoFIJuq6HroMwFGqPENdhAzUo8hHbsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779692; c=relaxed/simple;
	bh=HWzXUAZiSudXtv+ysyemS4usfyUV9q4TgpEDa7hb46I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FrPQ2MUJd70mNB9bHK3yHu0mLJcN7BdAQUPD9GBdF9Za86Xkl4KeUUbL58hphfKkbv2ckoBKQ8rt0iHlUcwOvz4crcm5y4eO2GHJd7ALdq49wgCj5wtkjeXy+zVCw/6ax0YJbCdStdxu3iOUVKBauMYCsRibfrpSm8jtmhjAGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5BYy7QL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5BYy7QL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701201F00899;
	Sat, 19 Sep 2026 01:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779677;
	bh=BhWw07RB08Sq10ZxN4JWnZZQuiI8UGuDOAwR8QQWB4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I5BYy7QLi0Mgtff/H72pa4MuCNDA1UhLqISosU8jzd+Lz+OE9FX0OZkgoxZuYb6Kr
	 xyEb4jm2koopdWUXm6YjskY8Hxm7YZfPrw95hZqq8VL7HPfA5h1cqzd/mri5X37CR+
	 /m1yLKt5toVh5WfM1xz7Yn8xD1WZ27b7xrE5fpgCS+Gh87jX4vrz7bCbvAd9fFBjG5
	 FfOOgN5GvBcicnwyDDoyszlegDfp0H2DRKFN3gNScvnaoFfn27Ta5i6gWr1/XwMmYR
	 IxvgDgVd8GahQFmUtNGZxaIqzFUKQR8g77S11HWW3T0csfwkt2FryfRxZnil52PANT
	 aFXPj9xkcoupg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A043811978;
	Sat, 19 Sep 2026 01:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v15 0/4] net: dsa: microchip: Add support for
 KSZ8995XA/KS8995XA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977961014.1214202.126037338656223815.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 01:00:10 +0000
References: <20260916-ks8995-to-ksz8-v15-0-8825ff5fd4be@kernel.org>
In-Reply-To: <20260916-ks8995-to-ksz8-v15-0-8825ff5fd4be@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, Woojung.Huh@microchip.com,
 devicetree@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 12:20:57 +0200 you wrote:
> This series breaks with the dated attempt to polish the old
> KS8995 driver, and instead implement support for the KS8995XA
> in the KSZ driver, and after that delete the old KS8995 driver.
> 
> The hardware clearly has the same ancestry, the KSZ8995XA is
> just a rebrand of the much older Micrel KX8995XA switch.
> 
> [...]

Here is the summary with links:
  - [net-next,v15,1/4] dt-bindings: net: dsa: microchip: Add KSZ8995XA
    https://git.kernel.org/netdev/net-next/c/7a5e75f64916
  - [net-next,v15,2/4] net: dsa: tag_ks8995: Add the KS8995 tag handling
    https://git.kernel.org/netdev/net-next/c/ca30cd47fe7f
  - [net-next,v15,3/4] net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA
    https://git.kernel.org/netdev/net-next/c/a926dc2352a9
  - [net-next,v15,4/4] net: dsa: ks8995: Delete surplus driver
    https://git.kernel.org/netdev/net-next/c/744e0256c4a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


