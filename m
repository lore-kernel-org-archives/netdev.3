Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9908404882;
	Thu, 10 Sep 2026 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036275; cv=none; b=feEYqHDGc7ZMCXMotfdrj/KMz/o3Mxd48DdaPDusjzFYkxtM0YtGs5/3LVGrvWtRxcpURH/Mw2oaJymu127mra8ZWTFr22DkoqJBZMk2IHb5yf9zWEXKAzPhydGEQEzAek9QeSip2PRHjpeIVqt56ZSNbqLlfQl5HvGTelBkzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036275; c=relaxed/simple;
	bh=N7NSmMhv3TmJHHz2QQsNpwQUuCTic9XR7kV0I+dj4us=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GcU9U+KkVa9aTx7KDyXC/2UHtZQjhW0yC7WwrlSqbSJT8BqQgkIOquKJUA7bm2P2kpRRXDYf+iYB9IJkqAm3vB0c5odk9aAsrxakqfnY9lt9O/Lxk9OAyYr/GOcJW0zyqm13Dw8eLNXuSSyTMH778IpBkcdZp5fzepJWqy6iM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QppWOwvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QppWOwvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9821F00898;
	Thu, 10 Sep 2026 10:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789036266;
	bh=ngeAR8nmnQ0Bc2ebzsIpljyhkLc6DyhYxhTSjNVk2zI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QppWOwvT8CbJuDDL78HkWLbFoDm4TnrcU4ovfDLFqzRsY/+oO5MqRzwqyveC/e3m0
	 u3smXptaDLBM3Ar39aeqC0x62j5xNy5ifwytnRxqXIl4wlSRI4VUqtGWXiyyHrpBai
	 TNJKlDKxHHblz98tca6C/mAmZQUZdhIw8zHuSa0f8UTWV/+CSH5K+W8qmKurf2OhvF
	 y+G9K7ueua3/CVlauRugeWsULoeQW779u70qbSbbdfYip/G8zaFrOqAFO9svyggcip
	 FXuc1ybDyhSRkUGAjJQ+gK7RgKCTW3c4fLtHDM58qrDl+YwOnRrMuXB5E9uyjKuycZ
	 eu9J9+O4sXzmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C9B380CFE4;
	Thu, 10 Sep 2026 10:30:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sun4i-emac: fix missing of_node_put() for phy_node
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178903620363.1343389.14128399627262253233.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 10:30:03 +0000
References: <20260904080758.2432748-1-dayou5941@163.com>
In-Reply-To: <20260904080758.2432748-1-dayou5941@163.com>
To: =?utf-8?b?5p2O5L2R6bi/IDxkYXlvdTU5NDFAMTYzLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, wens@kernel.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, liyouhong@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  4 Sep 2026 16:07:58 +0800 you wrote:
> From: Li Youhong <liyouhong@kylinos.cn>
> 
> of_parse_phandle() returns a node pointer with an elevated refcount.
> Add the missing of_node_put() on the probe error path after
> register_netdev() fails and in emac_remove().
> 
> Fixes: 492205050d77 ("net: Add EMAC ethernet driver found on Allwinner A10 SoC's")
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - net: sun4i-emac: fix missing of_node_put() for phy_node
    https://git.kernel.org/netdev/net/c/af406abfecad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


