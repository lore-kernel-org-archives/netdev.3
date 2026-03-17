Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655C3BF680;
	Tue, 17 Mar 2026 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751226; cv=none; b=m18CNCHCK1IgC7m83vQC7ZOxp1bm6F6H1CH8Ygbh4cZnbgQ13ebfvoewNlLiZINDygP++4/Ts3ZJUAyTfm7zE9372VZbdiW9ofrbA987pTJx+mXBP+mcskDBuqQFhWV4RDnDEwT1d8HHVB3HRp1cwl5MJlIqQBYcbnGDG8B9dfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751226; c=relaxed/simple;
	bh=2qeHWhAoF0G156DYTY3GFY5qLC4Mm2k2zxKaDF4DXlM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bVnz/BxGffUcP5bWQE7spYue3Cbclx+921sMMJuYyxoe6aH7cWxEiUZwRNvwPmNqp+LLRAwJva/l+pvHuVji2AAtRkaHJTqo8ahAIJGzRLlUdoqAF/IuqPw1ZA83arQEZqUoZ5JJt0S9K8xbyb1iAUWDltK/OKftsAMUBI29Tnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVcRrCPC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVcRrCPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5836FC19425;
	Tue, 17 Mar 2026 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773751226;
	bh=2qeHWhAoF0G156DYTY3GFY5qLC4Mm2k2zxKaDF4DXlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FVcRrCPCUXFqqM64gJVNBGDGZe4EARMgrXUgylvwoEgmE97NgoxXVkfKdGRzyj7C6
	 zXaA9WisVCcDrbwhbByUXfTfRQENmwXlUWy0YZmFM7pbyYxq9CHh6aUvLpNt40s9bL
	 c3VCbqAX/uIpS4qoVeVjVhUucv7SzCRCitHWWTae2fpqw7WzXIlo4L64KWkaKymtvO
	 ShtZ0yyNc3XUi058oT9pT83kEa9MESxZMtrRwUkOZIMX8NJ9WJEoiiOagtoxPpy2Rh
	 pFksavG+dBbHAVncNTEZ9k4GGLiQ5tmD5oWsE0Jl6HZF9WrtozxP5J7ydpSmOlhV/c
	 dvNOLznkRIC8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F2A3808200;
	Tue, 17 Mar 2026 12:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] Initial support for PIC64-HPSC/HX
 Ethernet
 endpoint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177375121878.3601019.14341430328492652693.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 12:40:18 +0000
References: <20260313140610.3681752-1-charles.perry@microchip.com>
In-Reply-To: <20260313140610.3681752-1-charles.perry@microchip.com>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Mar 2026 07:06:07 -0700 you wrote:
> Hello,
> 
> This series add basic support for Microchip "PIC64-HPSC" and "PIC64HX"
> Ethernet endpoint. Both SoCs contain 4 GEM IP with support for
> MII/RGMII/SGMII/USXGMII at rates of 10M to 10G. Only RGMII and SGMII at a
> rate of 1G is tested for now. Each GEM IP has 8 priority queues and the
> revision register reads 0x220c010e.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] dt-bindings: net: cdns,macb: add a compatible for Microchip pic64hpsc
    https://git.kernel.org/netdev/net-next/c/63e9d434ddc8
  - [net-next,v3,2/3] net: macb: add safeguards for jumbo frame larger than 10240
    https://git.kernel.org/netdev/net-next/c/363a99af19a7
  - [net-next,v3,3/3] net: macb: add support for Microchip pic64hpsc ethernet endpoint
    https://git.kernel.org/netdev/net-next/c/f45797fe02df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


