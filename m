Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48735AC0E;
	Thu, 17 Sep 2026 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605676; cv=none; b=sYbuRaUFX/zPKRkU1s+84nJypJtTgCGq3zy+GHwiG3Ga3B6xY++mQyVSBL/b504ASqgnZ+D9jy7DZy8Yd1CmNegv2YvioGrBuUPXiYbzJKYqVni6W0TATBLeQLI6oYWSkQWRD/uRXctQO1LGmJvnjKHl6fVgpmThGrME0xEe2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605676; c=relaxed/simple;
	bh=TMYrpy/+RZqUoXo/yVjHs13BjMWZ6p/GEKf3aFMKpbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HtSGL9hZwINo+id+WHGJaR7XB6FBviFBhGLM4GgTtdZqcH2tVqub0tEiECQlkPUFyJIGszHT6lDOapLXF6uwZMcoYea2vmnmTC52oF/zFA/I1aMYKGbTJQdv4gMDzEEyjloHF/SPU0CPhHPtfzuo27LVcoHCU4swN0TchD4tgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K57Fxd0y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K57Fxd0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8EC1F000FF;
	Thu, 17 Sep 2026 00:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605675;
	bh=UnADkelt0yYoNkuSuv/e2FHJ3nkCeLtPp+9a+Y1YXrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K57Fxd0yjrzw2dmwFQKiARHq0jo3UnX0xTgnPQUrTOi9jjNRgBS7HBF/7UjSMYxTF
	 uJzy+bw6/tIS2t9wSH0W/vcxxNlEBqYHzhJV+3ZNAPzf8xMxcgk6lVEl7SydMMRDap
	 LEyMQ/ncynYXMYAYp5yw/YEt8bWNZODfFPALObTbl2yA5xVCxrfS2h6mYqUEXJmj7o
	 WL9SPlR6x8/GAZESyPgKI/AfJlvxbtb9imAWVGFOiXImRHZW7HFOFei6lB/m0aT5i0
	 qqOoxlsFiZ4pcWCKPyX+hX+9wuOts5pvrRjrcGGAsfrFQMV3oZDEYiCG/hkuMkgVdi
	 NJY/UXjsP/rIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BA339E9601;
	Thu, 17 Sep 2026 00:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: netsec: fix device_node reference leak on
 phy_np
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960560887.3354472.8942406926487476518.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:40:08 +0000
References: <20260913064102.37452-1-yigejiang86@gmail.com>
In-Reply-To: <20260913064102.37452-1-yigejiang86@gmail.com>
To: Yige Jiang <yigejiang86@gmail.com>
Cc: netdev@vger.kernel.org, ilias.apalodimas@linaro.org,
 kojima.masahisa@socionext.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Sep 2026 14:41:02 +0800 you wrote:
> netsec_of_probe() takes a reference on the PHY device_node with
> of_parse_phandle() and stores it in priv->phy_np, but the driver never
> drops it.  One device_node reference is leaked per probe, on the success
> path as well as on every error path reached after netsec_of_probe().
> 
> Neither consumer takes ownership.  of_mdio_parse_addr() is a static
> inline taking a const struct device_node * that only reads the "reg"
> property.  of_phy_connect() borrows as well: of_phy_get_and_connect() in
> drivers/net/mdio/of_mdio.c brackets its own call with of_node_get() at
> :364 and of_node_put() at :373, which would be a double put if
> of_phy_connect() consumed the reference.
> 
> [...]

Here is the summary with links:
  - [net-next] net: netsec: fix device_node reference leak on phy_np
    https://git.kernel.org/netdev/net/c/5ae916fabca1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


