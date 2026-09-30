Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AAA2F2914;
	Wed, 30 Sep 2026 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728818; cv=none; b=Bs9jdXQnJDJKqP7uHgoWIeIZu1qq8LA3CKpKCxxLDWuHzCfmCgb5mWU5cC/NhONmj25Big6p5A/is55Tz02qTnT+P/hawd3Y/Fvqnx5n1Ji2V49UCo5s19V9j8yjIDTQrmy54ORyrbegK7d1bRfcT8JYhJoptAkkXTKtciIeVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728818; c=relaxed/simple;
	bh=iwIAte3wH3TRU/Z7IG+hwZul50wYmNRo9ylFiGcs/KA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f63AHUSMUVehuRFzPnTNRsKeMO4oufvgC4FT6dBCUmPUyxuUxran0ln7UpP0Hvv6+niH/i1wiOIorHP+ir713QQ2u2q+iwpiOHplniJr7XlF8AaGEXNM5v4GZtMoYzUgE2Ts0itdiXbmstl6o0QKygagxSvZWV4wDD6c9payPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIKJYApV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIKJYApV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471481F00898;
	Wed, 30 Sep 2026 00:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728809;
	bh=TdUEA3tV1zufmSy07/bt31Wbr9Axb8y9qnC+ULUNUYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hIKJYApVsKXmQ5A2+skSxxURrLzdmxwVdlWbrtY3QoLG/Vtnfju5Q94W4u+RaRIyl
	 /mmPR39OlNqwvGUF1IhCXDqNaOokQKFA6igiE4iIrlhFWBT4AnKKGWWg3Oaq16j3pP
	 0N1jQUl1rW2HSCNAOlMCTNQDCHRTiV+vCNz2ct6S2aRsF0vlfeH/19Sjteq6U6nJU5
	 3VM1CH62yj88lZbLHHHbrczyTIyi1f62JfF+o04Vl/4c2teZ99lgNNeC+pf1n1lVoO
	 hq7wzACO50XAOJRBe5cd/ObpdWWeIB04AP5VwIY9OyVJ6hsOKmhw3RIO1iNUaJy+xA
	 4alCciXi4zRgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4983924FEA;
	Wed, 30 Sep 2026 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/3] w5100: restore GPIO-based link detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179072880777.1183624.15268647911165769785.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 00:40:07 +0000
References: <20260924-wiznet-link-gpio-v11-0-42a332517b30@marmottus.net>
In-Reply-To: <20260924-wiznet-link-gpio-v11-0-42a332517b30@marmottus.net>
To: Arthur Crepin Leblond <arthur@marmottus.net>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@oss.qualcomm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 11:48:10 +0200 you wrote:
> Hi,
> 
> In the previous version of the w5100 driver, the LINKLED pin could be
> wired to a GPIO to detect the link status changes via an interrupt.
> This only works on w5500 as it is the only one documenting its LINKLED
> pin to hold the link status (on w5100 the LINKLED pin is changing with
> RX/TX activity).
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/3] dt-bindings: net: wiznet,w5100: convert to DT schema
    https://git.kernel.org/netdev/net-next/c/be15d99d8ebc
  - [net-next,v11,2/3] dt-bindings: net: wiznet,w5100: add link status interrupt
    https://git.kernel.org/netdev/net-next/c/50c4bbaa0d36
  - [net-next,v11,3/3] w5100: detect carrier state using link status bit and optional interrupt
    https://git.kernel.org/netdev/net-next/c/323767fa31a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


