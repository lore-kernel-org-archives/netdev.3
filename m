Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819C1A38F9;
	Thu,  5 Mar 2026 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672462; cv=none; b=B2nztdOPu7BPUaV8dcVbdm+A0Q6Dl4NHa7idx9OmDepqft+TY5MahgPbYen8b4Kcu0PJAS11GeCJFkMoRJN/6Q0I7HWXwuEmxcuLwWATkTvq4ahSSJJn1ThyLL+N661/bi6jMKzfIaPl/7OtzO1Q6nrGgi6mK1jPdju5Cf2QXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672462; c=relaxed/simple;
	bh=H2xwvKsgVFhd+ecvBtd7mF5jRpGF1S9aU65V28D3sfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kmQC/GuGmMe+bhfjF4mhkPHoGx8/W/aVgWbANyAfKbLWI+3BZb1rI8JEtFvB2qO1GRLFWRHNiatqV4EDYhsi9c663rU1MRMAwxM7g43xVzeOIv8HG05GEPE0d4wbU1Z7jH9C7cl7C3WP/6cEcLDJdx98EeJ6L0UmRxeQQcplSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqvhlITc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqvhlITc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A935C4CEF7;
	Thu,  5 Mar 2026 01:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772672462;
	bh=H2xwvKsgVFhd+ecvBtd7mF5jRpGF1S9aU65V28D3sfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QqvhlITcI9EqxbqjWg7iiqEdzDMu0xzVoDUPaWqgZWsc7yvlAAkTQD6J2nWHRpkP2
	 s9ZfzDqQ7U5Y7dcu1xp2zijeujyCRMIF/wLC8Qi9h1KsnRX6UDydCqWA1P2s/275UA
	 s2YZh5Xpa239a1O11b6TaFcCyXT7Nk0yClajxCXn84RckToF2rAITuJAH4/6zL+kn7
	 MdN9CHnI25/IahdhrzyTArlO/yPqS0gI+z6sn1mdFqFntkmx0Oc2Z2tpRKEsWqCel3
	 plenAAadmGN5Qggfq/VU6Nv9DTKOQGFiqOB+3xZFafyUFqUMSaVOftN55Q5yYppGb6
	 YTAxuaK3yADxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EF43808200;
	Thu,  5 Mar 2026 01:01:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: maxlinear,mxl862xx:
 remove
 port label
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267246247.2463633.1521027409296541089.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 01:01:02 +0000
References: 
 <61579de297eb636ec5f1e6c97d453e26abb0625d.1772507210.git.daniel@makrotopia.org>
In-Reply-To: 
 <61579de297eb636ec5f1e6c97d453e26abb0625d.1772507210.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Mar 2026 03:16:23 +0000 you wrote:
> The ports in the example device tree should not have a 'label'
> property. Labels for all user ports have been removed from an earlier
> submission, but this was overlooked in the case of the CPU port.
> 
> Remove 'cpu' port label from the example.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: dsa: maxlinear,mxl862xx: remove port label
    https://git.kernel.org/netdev/net-next/c/8838bb185ef3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


