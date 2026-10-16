Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BEF2E719B
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792111213; cv=none; b=lgAQsp9BFz1lQSn9RWPNTOi5YVINxFWviY7iWZ519FOK0fKEsSyXZFiDJy9rTi8hm9W6pG5TIMipzZok29bh3GrTY3Uqi/gTNaJn+AfIz7RTGGLZS5pIYuOu4Eobb1JFmzp+NnjXXaxnDCfqDpKgBLZDC1/FItqH+8Uzh23zeTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792111213; c=relaxed/simple;
	bh=M5zKPoTrmHkgjDCgT3mX8+0o2kiAzf9bGRTYZKwI0Wg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c+jOG+AiNaPQ3WbCQ9k25BLlMGpxKVS4HtFST86FoNOCYFzDPEqE5e5t6yufb+QmwNpiJLL7m7Ou/+VIPJFqBC/1rrDw20wpyNG7dg6PDOcLujwaDsdP/hqixKRo3+wLZlO1NIyr7IXwO+jTjCRYij7oXVdxguJWmxJhIbejdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+jqsKAb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+jqsKAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090A61F000C4;
	Fri, 16 Oct 2026 00:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792111212;
	bh=Xiy5ikkIpLDve+VNg4Fc6Ql5i7o/6h8hHNaGa5vXmnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E+jqsKAbhs9kDafoX4+M7ygc2ZhqSqXTcoUd5CmKjSrRFMC3qhmNBeWCJ/OpGND9v
	 QJSCGL9Bxy6fnw07kZNgW0TtLGIq8DXfv4Os25FJ2eHwh090s/C3hJnzY0kYXFqd3a
	 brzuAyqNHs4nm3zFp3me2fZj4kSCPK747JBa/LSNFwsrL7/9bgLDbYSoihhbZF8vQb
	 LPpGNt/z0/V+HW8i5QaUGC4ZarNwTPp6vl5Vc+nY1NWV1w54Gwx1Oo7HMbjcAqem3B
	 C6kEgey+UWvtZB0DJRA7Ho9rQDMROreHRzIctwyNdXRiPj5im4Tisfmg4SRfbAVa+D
	 LPAFiHSgo9s4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16233808209;
	Fri, 16 Oct 2026 00:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] net: phy: dp83td510: Add config phase
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211121051.4176565.8749139812361762632.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:40:10 +0000
References: <e9e0499a28a49e489fb623429c7487b8ece78d12.camel@sprinte.eu>
In-Reply-To: <e9e0499a28a49e489fb623429c7487b8ece78d12.camel@sprinte.eu>
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: netdev@vger.kernel.org, o.rempel@pengutronix.de, hkallweit1@gmail.com,
 kuba@kernel.org, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 9 Oct 2026 08:08:33 +0000 you wrote:
> Add a config phase for the Texas Instruments DP83TD510E ethernet PHY
> 
> The config phase currently sets the following properties from the
> device tree:
>   * RMII / RGMII mode (note : RMII master / slave can only be set
>     by straps and cannot be changed at runtime)
>   * RGMII delays. These delays can be enabled on the phy side, only
>     as a boolean. Delays are enabled if phy-mode is rgmii-id, or
>     rgmii-[rx|tx]id which enables only the corresponding delay.
>   * In case another mode is encountered, do nothing and return
>     success (keep old behavior)
> 
> [...]

Here is the summary with links:
  - [net-next,v6] net: phy: dp83td510: Add config phase
    https://git.kernel.org/netdev/net-next/c/b8aa6bedc5fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


