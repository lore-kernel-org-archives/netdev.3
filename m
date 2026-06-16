Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DC3A7186
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647900; cv=none; b=hZhxPG0gAUeIKqgFnBQWEmNdq6bxuJrnciGIm3n+fntkzjbNvmFl4frI1z0L3wCImFRssmgrSadnvO5+oo+i6ZI83uM0/g9Y78WVk3D3ZoLfEXAFA5bhSfW+8rvSqEv+BMEZu7ApsDAfDQVL3V4D6coyPgXJaoy3RsK7iD9luio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647900; c=relaxed/simple;
	bh=qXfdMR2/sv4YBtwsShrng4036IsJNjwyr0eLQQfPPF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OwxgUdnrUSX2X9xceIEMu6WoF6xS/yocEzmne5o23lJOouQghFH/nUYcOvnRSnBV9AvyQD5sMSt9hUVw9eGUq4BXO/ybvl4iG9zecREruk8sS4EeitAhEXalaVv98Au4m5fWeenHK2ruyk3C9tbRisSJIrBtdpWp+RthsooB7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqNcDhSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqNcDhSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687561F000E9;
	Tue, 16 Jun 2026 22:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781647899;
	bh=pHw0aVCwFWx/V7j5QiDaAmPjq2DsGJ1d+d++pb2rzB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oqNcDhSvheRZ0rVVxvm4Ftgs7gWXT4j8FvnkzIIkUzhs6GabADqZsJTWqWmYqjtzh
	 ghMhxXMflJk6lN6Qt5FkaWChshwIGHzZnf5jjj6fpyEcD1SAto2EcC4XIrtifbyYBQ
	 s9+NRRJTD+Tk00lKKeqvfemxAwXR9qSdXtZIU2zAwdUc1hTZFptkRgjB088pgN/Al/
	 T/sherzVfWN26TWMehesWszd7xvfOVY8v7MPuoY52lbQCROZ7bDd5fCDgHUkPpnY/1
	 oexK705xt/yuvJDTB3SjvwMPtxMSmpNo5OkYZhe5kuU9ks9SYUV4yqrnOsdJV/z3ES
	 MBm+oZnXjy8yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198383930C2B;
	Tue, 16 Jun 2026 22:11:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: airoha: Fix QoS counter configuration for Tx-fwd
 channels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178164789356.1259509.14649095510823015681.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 22:11:33 +0000
References: <178160712947.2156222.3765685889775458986@gmail.com>
In-Reply-To: <178160712947.2156222.3765685889775458986@gmail.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 18:50:29 +0800 you wrote:
> In airoha_qdma_init_qos_stats(), the Tx-fwd counter was incorrectly
> using register index (i << 1) instead of ((i << 1) + 1). This caused
> the Tx-fwd configuration to overwrite the Tx-cpu configuration for
> each QoS channel, resulting in incorrect QoS statistics.
> 
> Fix by using the correct register index ((i << 1) + 1) for Tx-fwd
> counter configuration.
> 
> [...]

Here is the summary with links:
  - net: airoha: Fix QoS counter configuration for Tx-fwd channels
    https://git.kernel.org/netdev/net-next/c/1402ecccf563

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


