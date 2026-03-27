Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4712848AF;
	Fri, 27 Mar 2026 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574422; cv=none; b=SfQwJ5PNguJepj118T0x2JTrNjKdXlSdl5TFxrcFUQDOVxzeBoNlY/GO53Yh8kYloIkkCo8hkJXu4c9B13pDKjRE4cpGAOQB0H3SRw6+jdU9hS8VmuTTAO47R/2jibt83CRmv8WKo7jU8jxHb8e7i6WS2TebHL3cbVrD9wgvmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574422; c=relaxed/simple;
	bh=+mbG3eLMPAF0Yt2+SNkDC2ssfDgwkGm8vxuXyXfcop4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GqCREhyQ3Y6SCyYFEpHEBdiNj43fF0/hIr2g5wyhens2YWj3xvX3EOd5vwUr85/yYzGyp2nKm5qQVM4tHbAQLN7p2jSHPCxoahTwdSmMlPpmh1T2EbBeGb05g764k1NSdLd3Z9Z+8vw70VTWPKZMk+MyHHJ4DFmy0k1BOYorzNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCfhDqzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCfhDqzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B446DC116C6;
	Fri, 27 Mar 2026 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574421;
	bh=+mbG3eLMPAF0Yt2+SNkDC2ssfDgwkGm8vxuXyXfcop4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iCfhDqzkhmcNkYGWkj09iFJq6rCEDt1dbAqTatJbEGc1rBoXetzKDZOXuLpBFjiME
	 a9P8LcR9NdgAj8rW2IuLq3wUmWDVOgSGvBI3IBLemkAhxfETD+8YAB5qMQUx0mXxQQ
	 Z1KX0X7a0FY5C/oSovuXJUNuz+9HL9vMTvfhtdmSwUO6tI3WhvJ9uUYU1trF5TKJ1U
	 iq0MgVZUAAMKnMtahTCAX/2yMy7tmHEqIv/Bb+X3JWttgSheCwjeNIi2kSQ0wu+ypW
	 49ihEaPrekoIUMIhBS9G/ZYoXAGC2NF/9eFI+t9r0qQjQGVlVbbvT4QGfSW740gtBt
	 XrNoUx3Y3OyPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF6E3809A07;
	Fri, 27 Mar 2026 01:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v15 0/3] Add support for Nuvoton MA35D1 GMAC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177457440804.3248049.2435571505438713021.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 01:20:08 +0000
References: <20260323101756.81849-1-a0987203069@gmail.com>
In-Reply-To: <20260323101756.81849-1-a0987203069@gmail.com>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Mar 2026 18:17:53 +0800 you wrote:
> This patch series is submitted to add GMAC support for Nuvoton MA35D1
> SoC platform. This work involves implementing a GMAC driver glue layer
> based on Synopsys DWMAC driver framework to leverage MA35D1's dual GMAC
> interface capabilities.
> 
> Overview:
>   1. Added a GMAC driver glue layer for MA35D1 SoC, providing support for
>   the platform's two GMAC interfaces.
>   2. Added device tree settings, with specific configurations for our
>   development boards:
>     a. SOM board: Configured for two RGMII interfaces.
>     b. IoT board: Configured with one RGMII and one RMII interface.
>   3. Added dt-bindings for the GMAC interfaces.
> 
> [...]

Here is the summary with links:
  - [net-next,v15,1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton MA35 family GMAC
    https://git.kernel.org/netdev/net-next/c/8454478ef9ab
  - [net-next,v15,2/3] arm64: dts: nuvoton: Add Ethernet nodes
    (no matching commit)
  - [net-next,v15,3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family
    https://git.kernel.org/netdev/net-next/c/4d7c557f58ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


