Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6394825B2;
	Thu, 10 Sep 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044682; cv=none; b=sA2U/GCWhHrajdxHCSiIDsz+PvAuotEmwDxjZWtuD+SuAkK/XAzL9DW0h0NwYnz7fv1zM3Hv7h5DirXqe7whtN4YHun/RnrpVfazmGJpH9r4xefjV7V0z0r780Xj5TKDE9hLU1j8uec6/E3zkTWCl3TbnS+kqzXOJ1XCNbyf3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044682; c=relaxed/simple;
	bh=dyGq7n9+Tzs91Why7K+gRpI+00H0/CRz8SjK3MFXmzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KjbclQfS8pJ2d9nJYJB7+S9qeFpHOLPip4xfAk3vwpyWg2Z+ruuXMf1c+3uOlMDXeNI/kD9aSjzmWDzOG8zX225xftkZ86hlpE9RH5Ef8limCBzykt4a3VVkYrQQM4hYSQ2S98DeTIjEp2Jak/llgH0gZKsiGa6aTPtvKgHkcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4BBfE6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4BBfE6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1B91F00893;
	Thu, 10 Sep 2026 12:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044681;
	bh=wdDuwrNT5nqbnggT94bNnBal0P0MT94FqQjiRpDuoes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=k4BBfE6N9JhgZmKsYJCrLKT/4Kamlq6xyP9VaFLhV/nWH+q4kAcV8GbMRy2B28mEF
	 4j1HBYtvEdO0cDfHz5p6MJ9dipXxOOFpV5GR/P9lE/uR9gzg42ib9Wy96guE6ScnEb
	 ZCbGT18R+cZxOlNcG5R7U/7XiRQC+RsVMPvMs4ig5TAd/N3FOgV12yRpRfptAEK52I
	 rZgPZBCl1tvaJvF0K0MrFFrRW/m93+0N3qFOgN2tT7p2H7nwgMdkx99AiLFwDnz+p6
	 EGqtK0VvftGy6WjM06VGIz26Cv8kb3C3gAMuWM22koJbFbrysXNhxpw7gD+G9GFmZA
	 JlH/1Zy66QQRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A04380CFEE;
	Thu, 10 Sep 2026 12:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: phy: mediatek-ge: disable EEE on the MT7530
 PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178904461843.1411984.6387257251091474222.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 12:50:18 +0000
References: <20260908145213.3976508-1-vladislav.karmanov.dev@gmail.com>
In-Reply-To: <20260908145213.3976508-1-vladislav.karmanov.dev@gmail.com>
To: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, daniel@makrotopia.org,
 dqfext@gmail.com, SkyLake.Huang@mediatek.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
 sean.wang@mediatek.com, olteanv@gmail.com, yangshiji66@outlook.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  8 Sep 2026 17:52:13 +0300 you wrote:
> The MT7530 internal GE PHY advertises EEE by hardware default, but its
> EEE support is defective: with EEE advertised, some link partners fail
> to establish a stable link. On a 2-pair (4-wire) cable where both ends
> advertise gigabit, 1000BASE-T training cannot succeed, and instead of
> falling back to 100 Mbps the port loops, so no link or DHCP lease is
> ever obtained. MediaTek confirms the hardware is the root cause (Landen
> Chao, 2021): "EEE of the 10-year-old MT7530 internal gephy has many IOT
> problems, so it is recommended to disable its EEE."
> 
> [...]

Here is the summary with links:
  - [net,v4] net: phy: mediatek-ge: disable EEE on the MT7530 PHY
    https://git.kernel.org/netdev/net/c/ccbe7540e4aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


