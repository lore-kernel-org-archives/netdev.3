Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F38392803
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202408; cv=none; b=f3wkozBw7mNBLUMUEx/cCV6WYMSbWh6NztC1edD/UPbKf6jKaE0hjbz8wZz6lJ/TeW1YA1PoHGTiwngd+9qImmaCpIQb9u8D/ibnQU2wGughKahACCPGyNAHl3sFRsg8+1pHMifiluU0vXitHBWgt9KIEEV0ptr0t3cQaoOlZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202408; c=relaxed/simple;
	bh=+CfSOosUEiOEYTAu/d/8myrqtESZLoCQp1qKLnTVJZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lZXRTjKH8NY2aAfnBEWbA1RtherZcqoEg/SHCmJB7kySwuHYNfmVFygJiqgn/ifyVSRc3LLqyBKu9JIHX3m+R+DtxtlaGUmeHtGPRgYEvZCAGXZ0DGo0uYJYXsgw5berGV2EF4wTdep4RQy3YYzfpZ0XJ6ccmNTjdHR73QSkX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG0ege6I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG0ege6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C129F1F000C4;
	Sat, 17 Oct 2026 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202406;
	bh=N11DTlnkYl2QXYGPYxwb4rksL0kX2HcxVC/nbWJK5m0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XG0ege6IFQ6OKaEp9dm/4KesLXEwAUsQARSWygXPjJPEw2bEFo5GrZkAXVQPmdheZ
	 vKUAf2VS2YmAbEGMyO6QMgtL8Sz5f4QSB4l4WQtSSADGNkaxsmIVD3i2BPbmPd7Ji+
	 fWYstFjps6T5+RjDql1pydsyz/yfO2Vgplysr8UdfhJVANYWclxoMrQ5Ft6IdxO/2M
	 3gbiDJVZg7q9mhtxWuIV7trkm8GsUpG8OEbOc2sEOJuzmNmQBWSuySKpVegvDXw2fT
	 F3xqnlc9R2mua7rdvndQMt3SFxCsqJeqCcOSOlG0EnLz5jvJKVVp77Tc9hw9OMajE5
	 z8esjfiCI+zCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B42CC380CEDA;
	Sat, 17 Oct 2026 02:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] ipv4: Remove netns argument from
 fib_table_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179220240552.1058620.10450295801123957981.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 02:00:05 +0000
References: <20261014082612.1280756-1-idosch@nvidia.com>
In-Reply-To: <20261014082612.1280756-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, dsahern@kernel.org, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Oct 2026 11:26:10 +0300 you wrote:
> Commit c436a624f89e ("ipv4: Pass netns to fib_table_lookup()") added the
> network namespace as an argument of fib_table_lookup() so that it could
> be passed to the fib_table_lookup tracepoint. As noted by Paolo [1], the
> function is called in the data path where the additional argument is
> unnecessary overhead, as the namespace is only needed when the
> tracepoint is enabled.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ipv4: Store netns in FIB table
    https://git.kernel.org/netdev/net-next/c/1b82d5ce3ba9
  - [net-next,2/2] ipv4: Do not pass netns to fib_table_lookup()
    https://git.kernel.org/netdev/net-next/c/a25a51258acf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


