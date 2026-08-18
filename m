Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9547798B;
	Tue, 18 Aug 2026 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061668; cv=none; b=Mbi5iANuqZt66uDxCmWJ3GRRuER4QETP+zNT5DeWVnsHemZcZbRVUMHeOmjMTclirFfTBxcig7SnpTnHsc2CT1E3DD0VHx0DjLNwzHAVFKTxTwxdXhQxIDf+PPJ7WKikt/pIsNiLsZz9qh26CGXL5MC6Hpby8OG64ShyU44eKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061668; c=relaxed/simple;
	bh=kHqoQyHKTXYCPImww1kP5mykFd0tBgY+F4BS1HTHSjQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ragsqyb4DCZNc1/+J/M431Berb96ppbgRb0pEolDjNXqBZ/MC3qNGhD+hZmvAquHEtTiTwO7bfTTFLNZKoSOXTStiP3UEVQ+zMyQruOJ0Udy0fGJUBqFFqBOCB/DjGENOLKzMLIedOCJ0zy8f6fyP0bwV3oFgusyDNbpnjBhgxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn9OR13e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn9OR13e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B381F000E9;
	Tue, 18 Aug 2026 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787061667;
	bh=uB1QT2C8nr7ifapomJ/U84HM76gxlWvTaHFZe9sk8hw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mn9OR13etJROrDRzkrRY2isT+zSxrXpbc+vxr+20vUSRUz7yGIt8I2r655NTQIOxw
	 cDhlhJlRfDQsWgv67JAE17v6B/5BsNKOsUyXq/Obl9tVI26F4RVpu8C0rXD3pu6ZkX
	 9gdTtX8wo0bDQ72Z9NCSvYVjeQUEugV8rR7B1sxAoyXk2sB1jS/9drXZKidgr1Ncld
	 aqJco192LmD4xh66lbbSsKeH1M36OGesnoq7lk4qnRs2RwhjUpCAjmLyqIEya08GzL
	 FUvSYQcbvOahxsGPXuDmJDnDD5JT0f0Ch0H4Q8wAW0npKOPecJbhpy4tCb8ASs6QSK
	 GtEEquvXLRNSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09283926667;
	Tue, 18 Aug 2026 14:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/4] net: dsa: mt7628 embedded switch initial
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178706161843.2100761.1929422486260844993.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 14:00:18 +0000
References: <20260813190241.789323-1-joey@tinyisr.com>
In-Reply-To: <20260813190241.789323-1-joey@tinyisr.com>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com,
 andrew@lunn.ch, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, arinc.unal@arinc9.com,
 Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
 daniel@makrotopia.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Aug 2026 22:02:37 +0300 you wrote:
> This patch series adds initial support for the MediaTek MT7628 Embedded
> Switch.
> 
> The driver implements the basic functionality required to operate the
> switch using DSA. The hardware provides five internal Fast Ethernet user
> ports and one Gigabit port connected internally to the CPU MAC.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/4] dt-bindings: net: dsa: add MT7628 ESW
    https://git.kernel.org/netdev/net-next/c/2873d364f408
  - [net-next,v7,2/4] net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet PHYs
    https://git.kernel.org/netdev/net-next/c/c9c235775bc4
  - [net-next,v7,3/4] net: dsa: initial MT7628 tagging driver
    https://git.kernel.org/netdev/net-next/c/44204fd425af
  - [net-next,v7,4/4] net: dsa: initial support for MT7628 embedded switch
    https://git.kernel.org/netdev/net-next/c/15062bb05e16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


