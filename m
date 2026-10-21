Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551012;
	b=HTVC13OhUAWN6cOcTgBhQZsTcHq3Og6ikweXkqvtnhgnf9Ng7kWA4ZNXTCIAIdKR4B3F
	 k0+7sHhUEWt00k8adWrX4yX+yT2GF8ZywvJNAV1wxtLnillns5rZdX6LPkeQ6LmkK6PQ4
	 YW32J17SRLdPNToEwqMWHkPgQmJxfc7ruse7P0q/eCK+sDD7EeVtPhNhLxHfq5q/JfUvX
	 d1L3NObDvQZ6m37ITEfnuiuRK8R+u74Pg/qaEjjMw4OvVcPEcK04Zwu0MPszPhG0+3Ji6
	 s9QMthPwgGcSgJWRwoJ7KaRw8x1+P0s962irmD4uChJe1KD0snmo32sDY6U1ClW2L9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551012;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ugcEjM+Zffc2p83YWbfwMX+zvra0v0JNG8Mbcujub0E=;
	b=a30AAZOcu1lXTn9uy3kzx1mc5TU47ESEJpVmTK57pUKBewI2qGvEjnUbcGA8HpSnbMWZ
	 4+fTkzOgJX8MBJ8kBo0EpZHFYC7symsJAxKU/eGZBpcoXAAfPo35h/Qw5Ccx85UgB/jTY
	 ucvvhBZtMoVJbPy1qBMNso7NjkdwBEVqCryQ65B7ayVs2PtR9HmlMrQrNblH3HR277TF6
	 tRkkeCVxNV1VpxPugU3/EoX7jGwZzXb3UtdyNU3eciB7ljk/Z0Tqk6LLmzmYF312/OJv5
	 ErESis8iHuKlZyqUMYBK94hHRpeQKki5NMF3LWn1myqaV4pFh3KCMAgMOKpoc+tcqUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6yXnwlN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF30606A322;
	Wed, 21 Oct 2026 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6yXnwlN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3D11F000CA;
	Wed, 21 Oct 2026 02:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551011;
	bh=ugcEjM+Zffc2p83YWbfwMX+zvra0v0JNG8Mbcujub0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h6yXnwlNeVpugnaAz+ZarxMmRqKnP1tSS+8d3uMEjzhKSr1iwKCZTRCWijxhQqqzP
	 HET/dFRzhxdzyODG+xRQt1auWtitqLzPdhECPRWUZod2JSSCUw+iua6CMG9wbfs9NW
	 Lpao5UDSGTKlHuM4qqeHpnGeG2bQDL+ngUraCsTmv1X6DT4EVwuo3rHBSm2EZWWpaP
	 9QxD9033yqzIcYbek8tZ9k+raxzp59foEzWN6V9RIY2A44QgU8gJGzcM6nktt9o1ls
	 3bzn6aExax/1gyUSHmkPHMA5Ev8HsIAcNucErCQ/7V5LfvEfIFMI25p3vsp4jZzwrO
	 PxfVHELWFpADQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45FF3809A18;
	Wed, 21 Oct 2026 02:50:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next 0/2] net: pse-pd: Plain I2C transport for Realtek
 Gen1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179255101027.346551.1097123393993834413.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 02:50:10 +0000
References: <20261018161248.376205-1-sander@svanheule.net>
In-Reply-To: <20261018161248.376205-1-sander@svanheule.net>
To: Sander Vanheule <sander@svanheule.net>
Cc: jelonek.jonas@gmail.com, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Oct 2026 18:12:46 +0200 you wrote:
> While for the Gen2 protocol both a plain I2C transport and an SMBus
> transport were provided, Gen1 only got SMBus. The Unifi Switch Lite 16
> PoE uses the Gen1 protocol to manage a single BCM59121, but does to
> using plain I2C.
> 
> These patches simply add a new compatible for the plain I2C transport
> and the associated match data. This is sufficient to let the existing
> code talk to the management MCU.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] dt-bindings: net: pse-pd: realtek,pse: add gen1 I2C transport
    https://git.kernel.org/netdev/net-next/c/9e6df8d57ee5
  - [net-next,2/2] net: pse-pd: realtek-pse-mcu: add gen1 I2C transport
    https://git.kernel.org/netdev/net-next/c/ca4bd46de863

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


