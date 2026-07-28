Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E041B36C;
	Tue, 28 Jul 2026 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229842; cv=none; b=uIxOnmqFOvs2dv9ArtJ6oQt0TJdyWcWoKEPzOaNNg3ydeOVWzAsHDVUQ4FEbuYeOe53EITQdeAByI7had+3EcFQesKqOJBC0HwKEcOSxuLSPwozsBwcDGkIGfcmCXnMXOTYOljp6eKCpGGz4TizjD05XZNRBe2Sj2rl4dieFAsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229842; c=relaxed/simple;
	bh=c1uEoHVgDUSfk3oO+6IP2fHlCA1oV0ilLaMz2L7nMnY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bJzbiQfToXzYRBZ3gqNfmJEn0th5lttNCBQU0BUnyYni44q8eRYefvC4shNkz61hN+sXQ/pxvi1Ysqry/J0i06j+MsnnKU99xf2o1IhqaVvJ+bXzDJQFnlT2/f7OlrPAuntbPwUaa/cdA0XfbD4WXuSfaXrMk/Ug6EEzo/oGFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFftk4R7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFftk4R7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6071F00A3A;
	Tue, 28 Jul 2026 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785229840;
	bh=fb5H+uW5djIuvCZ+RWdaFrKbLl4JcJ9yUIoVFMWH010=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lFftk4R7Q8gzEBe3aa8sMRs/Ap6cwqyhzB3RY1w6weWkoXj+qmcKamc7z+HgToPEo
	 oR09QwtnlknLzxhijxfflvX9flvXtwhB9VwtJTPZncyO3h/V00apLupYY8cDNx8u0q
	 su1hZYxZQ62f3+VahcLfJ+EL1FOYDd8OfpyayyXtForOjTci3lfdCvZH6M2f3Zx8Ys
	 o40S/7PHh4VpBsRGbZnRO4p2sSvNBOZlDPV0W953Dmplg/qfxa/H89bQrGdHnVpkqv
	 onyYp+tYz4dkA9HLhtqPV42V7ZhsgcfluCjrHKhYP2H7PbRRg4M/YY/U+JU70Rtzrz
	 ufhkjSyBhqNUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CB0380CFE4;
	Tue, 28 Jul 2026 09:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] octeontx2-af: npc: Warn on NPC_IPSEC_SPI key
 overlap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178522980539.1632925.12437378828639231868.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 09:10:05 +0000
References: <20260721070303.986740-1-rkannoth@marvell.com>
In-Reply-To: <20260721070303.986740-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 Jul 2026 12:33:03 +0530 you wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
> 
> When scanning the MKEX profile to determine supported NPC features, warn
> if the SPI extraction field overlaps with other key fields. AH and ESP
> may legitimately use the same key offset for SPI, so continue to
> advertise NPC_IPSEC_SPI via npc_is_field_present() instead of treating
> the overlap as a hard failure.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] octeontx2-af: npc: Warn on NPC_IPSEC_SPI key overlap
    https://git.kernel.org/netdev/net-next/c/72207e1b15d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


