Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5713B71D3
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563845; cv=none; b=T2fuoPd9yGPUZlDcBAcssWUvytSOGc8xT8ieUowH+swnmmLI4pCdGA6EOakTT36rOp00WWbUoAhqAH8Dwy/zDPdkuOY52zjh0UoPsOJIja1poRyAJ7c0f9yRQ0eTYBViPzVruibNIeNWSUxq8IQO3sZ7JG1LELpi0nNjCnd1CnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563845; c=relaxed/simple;
	bh=jxwMDcfX7TZO4aNaFsfWunNAeaJLT4uomM9+EeSuDjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VEMsp84p2Itvi8bgkOAEb56w/xIcVEIhFBLqprQbJgR5lFETGuSbyad4CKpbiVxtoIVEflW7XDwXLqjWvaQjPWQ54QSSRluz80FqL5/qPOKqiZ4UkAbD6EiujPkC4haHFhyOroUqOJ2pBJ9wJhThHaXY2A3eqsSJUM+4F8ljWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHa0eArA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHa0eArA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570A61F00A3A;
	Mon, 15 Jun 2026 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563844;
	bh=T57rr/fexxAyKKAD9vP64yQclmlYeocSTP22QwpKjPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HHa0eArAA6Ld0Zj3yp6vGoxUPOoQmUCKHXCnC0q5zrnsQm2Au5pVRe0UAmhnf5d3s
	 WAdzDrOqCd6R8F5ml/XISNZ6hMDpfSNg/KbovMbsghZlcHVvF+DvS6XBuOWnOi9vaD
	 q8PNpCTF7NFYMhaq2vAosnH6+K207slsGGmNq5SdIhGp1bkGgbzCE17E2hx5jx4d2A
	 48MNWhO90uBx2ao/SMxWin5SvbSeB3d53Q2tumhuluTTu2RVe069D1F11eLUVQO5Um
	 pnrLBUqb+zWiYeYD6DgJ7VyM7CC7ZlCIvnQ8FrM5yqvpOf/A9vNd7b2DrBqcfwZBEi
	 VYwbOqbEz96Aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938083839A08;
	Mon, 15 Jun 2026 22:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: airoha: Fix typos in comments and Kconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156383913.325968.10885453250477186810.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 22:50:39 +0000
References: <6a2ca74a.c5b1db4e.21a698.01e7@mx.google.com>
In-Reply-To: <6a2ca74a.c5b1db4e.21a698.01e7@mx.google.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jun 2026 08:41:16 +0800 you wrote:
> Fix several typos found during code review:
> - Kconfig: "Aiorha" -> "Airoha" in NET_AIROHA_FLOW_STATS help text
> - Comment: "CMD1" -> "CDM1" (Central DMA, not Command)
> - Comments: "GMD1/2/3/4" -> "GDM1/2/3/4" (Gigabit DMA, not GMD)
> 
> These are pure comment and documentation fixes with no functional impact.
> 
> [...]

Here is the summary with links:
  - net: airoha: Fix typos in comments and Kconfig
    https://git.kernel.org/netdev/net-next/c/a061dfb063fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


