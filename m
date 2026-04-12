Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7543147;
	Sun, 12 Apr 2026 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776033032; cv=none; b=A4HoxF2BNFbNaWbfHCSXkvlOG0AgWW63sx8Dng4YQGbLHSkNXiS0meZrGgJA4Bb528/kZkSwVTz/i6sPVTO/+9v5w84S8mNQzY+lg2g0JvUS9gnY63rdK6msAFsatpLCP5LrfMLUcHmdjrHhRiEIZsygAmaYtlQpyVhWk+gsZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776033032; c=relaxed/simple;
	bh=Vkbqz7zSnWjuc4pCYjwiNLsgGE+7Xgk1fU+bplSwK2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q+zzUr2KRUl2cG5z8mcXLR+vsbKo7xHyqefbabC7E/ncyIBXz023EHVSyRQCJSAQaU5T7kODZhbVmzbdlHo7JE2Z6D2PqAyxeHwTFwTDEnQ6ijHJc+DHRwSv3Qx40W9zaqmRz5VotiFEyBZ95yiWjhptXWUV1NK6FnCiaTIvA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7raTKe8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7raTKe8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F039C19424;
	Sun, 12 Apr 2026 22:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776033032;
	bh=Vkbqz7zSnWjuc4pCYjwiNLsgGE+7Xgk1fU+bplSwK2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A7raTKe8zc8OvdXJU8zSKq+zNvse90ovHrWigUqCsBUMRLoc9pKghuGwdsqo+jI2u
	 IlgcW4V5Ac3ntYWPOX0ecHFsQj6cYLonurfiTldpPIODcyKZ06At4sWrEiG2WD/Wwe
	 llH/5OGJtN2IxSv+Ibrv3I0GQDfLAdvHb1CNVlcSCQ4ydwPuwWuzKyXv6WzWwQhWvo
	 9RVehWeezjdo/eQPZ1+VBvBU+MiI1UV4RGamAEh9O6ntTcCSLzobZZfJ/Ui16xogxe
	 cU7kOlfQA9xjw/jl93YBO6BvlB02UbTfy0vkWHc0fkyKV7HfgCn5p/1y31w4IS/Jg1
	 K/JLCRYIWA8xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C793809A8C;
	Sun, 12 Apr 2026 22:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: initialize PPE
 per-tag-layer MTU registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177603300480.3841629.11936598519296387626.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 22:30:04 +0000
References: 
 <ec995ab8ce8be423267a1cc093147a74d2eb9d82.1775789829.git.daniel@makrotopia.org>
In-Reply-To: 
 <ec995ab8ce8be423267a1cc093147a74d2eb9d82.1775789829.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 pablo@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 03:57:52 +0100 you wrote:
> The PPE enforces output frame size limits via per-tag-layer VLAN_MTU
> registers that the driver never initializes. The hardware defaults do
> not account for PPPoE overhead, causing the PPE to punt encapsulated
> frames back to the CPU instead of forwarding them.
> 
> Initialize the registers at PPE start and on MTU changes using the
> maximum GMAC MTU. This is a conservative approximation -- the actual
> per-PPE requirement depends on egress path, but using the global
> maximum ensures the limits are never too small.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: mtk_eth_soc: initialize PPE per-tag-layer MTU registers
    https://git.kernel.org/netdev/net/c/2dddb34dd0d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


