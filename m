Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9F3CB2FE;
	Tue, 29 Sep 2026 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649616; cv=none; b=Jrwcp0TpMzx3EKYxwhbUNJYF5nRTBkA0imDeITRZGNSUaJPlis6+6xsFYG6WUzakLqmYMxRRola42eVcCcwZpSmRlpmanclyWvSiP1I1HmNgGH1ry60N8jVc0guTR60lZb3GzbgUMZ9IieVicBbYgh/jIgN9HLzIgOBYMCAkTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649616; c=relaxed/simple;
	bh=l+v1uQRuVzqkNaJ18f5E0bV5cruDt4LJS3ISpZdZX0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KFGVfZvmdLDGUqA/ejmSoPcg840kRsyRzmnVXAgdZq+Iv1DcbQAFPMaJsJvlgKL/C0RK4q42Cr3F+WNjLx4EIgx0Sg5iE5laboLF28EgfZon2RHmLHtdbjqnqqYKrDDSfGVRDC8aoU17BvTDyAA8QNc7qqXoQO/1MZXJZKBaNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imEUgNbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imEUgNbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822E31F000FF;
	Tue, 29 Sep 2026 02:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790649615;
	bh=WyeLWSnB4WbT02iudh8HdAkq39YXMLxmMhxaDAhrK3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=imEUgNbPQXoyEXu4t7K0oZMGN5i64zILFFxZux6pV/q8pwdc5gjiS4MEIgMUGVyoh
	 4HOvvtfesf4049N/y6PQXbctri5Kr5n94roZ4lAPfs1UuRAeM0ta4aO8ifKLeyrHkp
	 1W6oQyS/zpWtkD2gRr4IvjJaMYwASCtHw8gpsLuZOx7b0WL08dNh30QG3Unpflnb1R
	 iXxvHNkukEPAZD4Rf2VUXzFHAVL3paAsmkl0yFSPW4s2RNqefHDJs4/D/XwrGdxcBJ
	 uoEOLM86+sFtPyJZeP+V6ofioj75KiTMe0jj5uqHJRtTpOrQAVHhhTi7pu6eovSgC7
	 XwZv6YwsAoNrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774723924FF2;
	Tue, 29 Sep 2026 02:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net: ethtool: reject an out of range hwtstamp
 provider index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064961404.229594.5490433720039637350.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 02:40:14 +0000
References: <20260925135237.3432266-2-nb@tipi-net.de>
In-Reply-To: <20260925135237.3432266-2-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kory.maincent@bootlin.com,
 vadim.fedorenko@linux.dev, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 15:52:35 +0200 you wrote:
> A provider index of 0xFFFFFFFF picks a provider on hardware that has
> none. phc_index is an int where -1 means no PHC, and the u32 from user
> space ends up as -1, so the two match.
> 
> TSINFO_GET uses -1 for "no provider requested" and answers with the
> default provider instead of an error.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: ethtool: reject an out of range hwtstamp provider index
    https://git.kernel.org/netdev/net-next/c/67da3009384f
  - [net,v3,2/2] net: ethtool: let tsconfig reach a PHY-only timestamp provider
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


