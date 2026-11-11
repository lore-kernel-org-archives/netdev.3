Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357606;
	b=1uckXD1ziqqZ+UumCDh7mLhM4VUwC3TNvOaj27240u3Y8eOGnT7ClzZDcc0aGM4pLoqX
	 cvIKOeHmAQQQu++lKJrzwge4W4VB3VjPWGrtj2pYxa7ljZkGrFE66fA7saYxyjb2dnX7i
	 zNiPnnzXVUJMKeDKDX9ic93kxZTmH0pE1VEucvFi0/uc54C75/A7ShauuFvo37amB18Dz
	 JYLwjxe04B+EDPJIdmLYU28gGm05iEUBuB0/Ls3uQwxiuBtCXcQfe2ERXT4yOGb3YG0a9
	 BaEdJVZ+ImuKwpSEEWAQfPx0ixnrvY+0yo42sjXflUBWHNyulIz0wLbuHumk2bef+kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0STTFmcPyB/zsDerEBDy8+hogBiVW5QiFxOhEBovJXw=;
	b=LRGRDdpUpHt8kbEVuZrIhRpstHPHiR/LnHH1duV5TWtd335+LabjYZQ5ie+7TV6heWla
	 E170leKvS/LPh4l2G+FmGaBMeyelAJZvpiOcu3ec/r22d/PHfK2uRjQWUim+t/6mmUys5
	 iKbxiQLUhUk8t6jAcHcLv89B0+nQNdHkC1J53E0YL0LYoi9Q3DPkp5SRnwT5MvRQpjvoZ
	 6r8y51aSBV1sw9+WH81lypP3fms2DRlk5ijGWTBgY5MIUYY2IAJrMGOO83gaj3qEZJqCe
	 wJMl3Dmyz410xpEC+gMFIuBccqVfl/UwMqjyiNsZjbIejSvrkR5+C5rrijfuuOz5jxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6vNDG2f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F7606A320;
	Wed, 11 Nov 2026 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6vNDG2f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347671F00A04;
	Wed, 11 Nov 2026 00:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357606;
	bh=0STTFmcPyB/zsDerEBDy8+hogBiVW5QiFxOhEBovJXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L6vNDG2f1UXKj3eEU5GjBne/CqlHkc6udmt15sCFF5rpOyGbygsYEBW5rSlwR6o9/
	 xqIzgisZxLaKP7T24Qu/c+w2JZlecLwuFqt3QAs5DoQ7x7QkPMA4XXJzn8ToKYrE+j
	 KbuPZ9DDeGZtLE0C0SIgfUI29r7OGn8q7FbvZXJ0D3rj9tZh5VkpG6/tPgRlY/WsDB
	 Dm+Y0BLAIfe+I29//Yr7E5ol92bndIBpfkZikg5chkCRvyl1gU0qGIMC98jaLxYLL3
	 1T2XjqbSpGGiVJqbomCKKJdOa9iVVgPGmkEDlqlIt7l8KP5SIb1HJ2Qw528rYSwQbZ
	 sJp7ZelBw4xLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2103839E8A55;
	Wed, 11 Nov 2026 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: sfp: add quirk for OEM SFP+ONU-XGSPON
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435760493.139049.1251934787976228328.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:40:04 +0000
References: <20261106221836.3445-1-romit@romitsagu.com>
In-Reply-To: <20261106221836.3445-1-romit@romitsagu.com>
To: Romit Sagu <romit@romitsagu.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Nov 2026 22:18:29 +0000 you wrote:
> This XGS-PON ONU stick (vendor OEM, part SFP+ONU-XGSPON)
> needs the same handling as other Potron-based modules. Without it,
> the module fails to connect and the kernal shows these errors:
> sfp sfp1: module transmit fault indicated
> sfp sfp1: module persistently indicates fault, disabling
> 
> This module requires TX_FAULT/LOS behaviour and boot delay tuning.
> Add a quirk using the existing sfp_fixup_potron.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: sfp: add quirk for OEM SFP+ONU-XGSPON
    https://git.kernel.org/netdev/net-next/c/ed04b2020272

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


