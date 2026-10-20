Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504809;
	b=hTaSb2dJbZb5YHndR6MXdsApJRgDp1kb2BVu6DqU9qV/4o3r3myATjVO1poUvF/qiL/l
	 wHQb02YR4ohx7oy1yp3KjmabS1SCjo8GPLRYySIfqKZm6uON2kozKO4DhdvYnFJ11LEla
	 C9BDUnmmo3z7W1vjaoGIjc3wv/bhc/r5YrZOBBckj1hzLovbxX+jobWLxryZXTBkrEOOG
	 WuyImxsv4smj63UU8OdIH2BhA0GyRrXHXly6SigrRsG/hOtIorgjfsUWTceR8T3RIy3fI
	 hCSnN1ZiQs+7lfqDGkTC8UUuO6kv0BYAk+HYTjBvu6gn0xQSaKhgvQlQpe+O54hw9iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=L2eGtHUGnzzO9epK47Pma4jOia1R+ecV8u3hnLDUFu0=;
	b=pZecn75ZTOQhjfDjzUwQTPt62XQjMX+84q9EvFRhsp7uhDnb0grAbvBGkjf++LORYc5J
	 TiJQR7m9cah8AvoO8dk8E3dUlU9wjgyt0PmakDaWhWdal33pW7rQ54kmfAmqEfm/aJyg1
	 NRB98MjbQrktaD7ExNCELYFvuus+7RmTpmJcSD5rAH11MOcg5phAPH8Zt5NKHmgdFBZm3
	 6mKlEd9K9uRPSVtcbxw0cJpNqwiUEcNufKPnuTFl9TLbMAQtR1qOh3YVvjgH6yo6jfLFZ
	 Lw/JxbMU+vqluf/Uox2wEvvpDO4EIvJAzs2kgf0Qv4ooH5i0IO4kTPFzZAu56b8224w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqXTZICB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483A60A2615;
	Tue, 20 Oct 2026 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqXTZICB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A21B1F000C4;
	Tue, 20 Oct 2026 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792504808;
	bh=L2eGtHUGnzzO9epK47Pma4jOia1R+ecV8u3hnLDUFu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FqXTZICB510Pb3vwXhMbQLNw7owJUKI49QhSd1TaVVXBLzTywCc0YbAtHgvTKQxOd
	 ZB7Sez3XCpro3CurfHpOnj5VLMuGHasxlPb6l9xez4GG/YWQM+ZrCrKvFljpMpJV6b
	 ehdJjk+MedBt7pwY5qD/5vJWIaMcSR/a2W2ViXvxnNYcy0kIRtvDUKzvCAuXWnmP86
	 vwDJjw6veLP6XLKs5p/XVDv+ew9qFslumimMwMQJV3wnSJGym1/ulWVmHSeneyHLXq
	 Mw8zv4k8e8xh07em1+mcgCjXmYXx/anymQnAevi8IfQI/9wHJJsoXD3WxFW43pGR0k
	 gBziCp4w6pwoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3E33808209;
	Tue, 20 Oct 2026 14:00:08 +0000 (UTC)
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
Subject: Re: [PATCH net-next v3 0/2] Support unaligned RTL8224 PHY packages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179250480675.3753996.13961192946834391780.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 14:00:06 +0000
References: <20261013185635.1412452-1-oskari@lemmela.net>
In-Reply-To: <20261013185635.1412452-1-oskari@lemmela.net>
To: Oskari Lemmela <oskari@lemmela.net>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, daniel@makrotopia.org,
 vladimir.oltean@nxp.com, maxime.chevallier@bootlin.com, olek2@wp.pl,
 javen_xu@realsil.com.cn, marek.vasut@mailbox.org, ih@simonwunderlich.de,
 amadeus@jmu.edu.cn, jan@3e8.eu, f.fainelli@gmail.com, linux@armlinux.org.uk,
 andrew@lunn.ch, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mensi@mensi.ch, dam.dejean@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Oct 2026 21:56:33 +0300 you wrote:
> RTL8224 packages contain four PHYs at consecutive MDIO addresses, but
> their first address need not be a multiple of four. The Hasivo
> S1100WP-8GT-2S+ uses two such packages at addresses 1-4 and 5-8.
> 
> This series adds a dedicated realtek,rtl8224-package binding and extends
> the driver to use the explicit package base when provided. The
> package-relative port index selects the MDI pair order and polarity
> fields. Existing configurations without a package node retain the
> aligned-address assumption.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: realtek: add RTL8224 package binding
    https://git.kernel.org/netdev/net-next/c/9f902fbc955e
  - [net-next,v3,2/2] net: phy: realtek: support unaligned RTL8224 PHY packages
    https://git.kernel.org/netdev/net-next/c/8f3a933fa1a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


