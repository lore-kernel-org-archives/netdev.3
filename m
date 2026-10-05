Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891444534AC;
	Mon,  5 Oct 2026 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243616; cv=none; b=nutlWvJ7LyqszwiXUlWCrubOLlvc0GA/1vOUBduNU9jOTdlM04XFtqiSnOOtsxkZe1ozXn7h0w0wYsk+AUh9Rdyyn9C7SEeM/g2G+ZYxlHnd2bOyCancc5tCwX0IcLNgieBmqG+iV13hJiiKB00YutKCWbLADAvWAFiFBCbiZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243616; c=relaxed/simple;
	bh=mJZ5GAuIcYhr4L7+Ht3Ql4RNWmKnVSzLPW/rpLX2rTY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BZzwP7M9EtPlr7t4XEq6e23ZwYXz4Sn3s1eNF0fUEUFjOD9hZusAb/d1gH7IFWB+NRIPEnGLbGzRplqgZ5n4LS+aj5BAK9Z0+mxNwhBG6JZej/LdjU0ydNB67IXrohpGw+hFCfDrPnZmlmsXh7xORMoyxP13EvPYKytNmw+hxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ++SCuG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ++SCuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442751F00893;
	Mon,  5 Oct 2026 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791243615;
	bh=pYbJempch2MXdr+lyUrz2A7WTsBgdsxwddCNAtpjtGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jZ++SCuGRQu6GSzIgx50e3fLwocHn/jCVDe45vAJv7oCqU+GAOfxoi0lCH5K8Gscu
	 Jaqa2QhRhQPgh8nYht6dcw76nC891sXg+MN2QD0127qG6vpLvPUd+adQytkgx5ynYe
	 sAmIjJBHDNBmIXddzyfZ0e6L/QKD8i0UH4cIloVxh0LZVyGVlA2bvw3rjG7lPcUZ0f
	 kJ78AI2OXez9HWUqe4Y4r5IwQi2mtKWL58n4hEMlsb1+rei2TiwZZ3Qg1gyXZHYSQO
	 tbc9NQKzFOqbeXqMjYq0DXxvMc/GsstYFb+VpiO+PtTREQITO23m4Dkuq5vihzfHm4
	 oukiGI0BC+NOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2EB392667F;
	Mon,  5 Oct 2026 23:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: dsa: mxl-gsw1xx: force internal PHYs
 into a
 known reset state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124361377.1939764.6488226653644134516.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 23:40:13 +0000
References: <20260929125143.2890583-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20260929125143.2890583-1-alexander.sverdlin@siemens.com>
To: A. Sverdlin <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, hauke@hauke-m.de,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Sep 2026 14:51:41 +0200 you wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> When bootstrapped with PS_NOWAIT = 0 the internal PHYs stay held in
> reset, so the driver only worked with PS_NOWAIT = 1 where they are
> released automatically.
> 
> Add a ->setup() hook, run before the MDIO bus is registered so PHY IDs
> are readable during the bus scan, that programs the RST_REQ PHY reset
> lines: release the PHYs of used ports and hold all other internal PHYs
> in reset. Driving both directions yields the same state regardless of
> the PS_NOWAIT bootstrap and keeps unused PHYs from staying powered.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: dsa: mxl-gsw1xx: force internal PHYs into a known reset state
    https://git.kernel.org/netdev/net-next/c/82e2c7db0830

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


