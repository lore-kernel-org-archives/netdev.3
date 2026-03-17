Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C07F28134C
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717613; cv=none; b=Pv4+dcUi3mBAkLfp2YKCFnG2CcW1Yh7wEg/eVkzpwSnabWgK22jAAUW7F0lYLmUcBRREEfQQb5aq6Px7ueJJoVJsyvUCwrkoDQvARpEVtNTv7Mxf5t0f7sumiq4paWg07HljpsVXiIjR5mR2CDZUTqvd0mozqnpkEc/SJ8TWKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717613; c=relaxed/simple;
	bh=oqTNXqkviwDGTSDtH+rFg1gJ0FmxRCujky6kSluFiWI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aMOWpeyueVMHvUuEEeNJP7+RuhvGKShqHWJhaOZNNlRLO8JT4qXz7U+P8Oq4V3CRkp3DBcpH9kemgFEkBqxfZcmYcBDhFq6y0gOoMCk+Khf8f6UTlbYvswfJKqptRZK+KHGpNw873/SBJRNTxO0Sb36VzIDsLziGToO+CH+oi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQXeArL5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQXeArL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAF7C2BC9E;
	Tue, 17 Mar 2026 03:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773717612;
	bh=oqTNXqkviwDGTSDtH+rFg1gJ0FmxRCujky6kSluFiWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JQXeArL52++LQT2S5te0nBz+LQzVymVPFdk6vU15fjRo1jJlSzLUPCJzBMWjyFwr9
	 w6b6JPlMUh9+36KujHNzLWtbOFrrfhBYznJJ94GjadjQrps0MSqwuLJxiIGtCCKKCK
	 NQVYCpJFhvEQ4YiRYl+Bp6ufIbCtQUutWrwKtpsJMf2DXBk4UDNeCuEcmGEWUfVWCu
	 wW07bpy3LrEA5NgDvzB0d9wuk/BB5lnCz7SBC//SUCVPQA+3vcK+tQEcfJzJcOwVLp
	 nNf3XcpxxB8e2xS33KKSa8Xyu9SVjQNiLX4dy/hJ4Xi92fm1lnRFZp3wm0A4sN8lO/
	 NStLhyqW6g98g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EF23808200;
	Tue, 17 Mar 2026 03:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: Remove airoha_dev_stop() in
 airoha_remove()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371760554.3410412.10803597762901231446.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 03:20:05 +0000
References: 
 <20260313-airoha-remove-ndo_stop-remove-net-v2-1-67542c3ceeca@kernel.org>
In-Reply-To: 
 <20260313-airoha-remove-ndo_stop-remove-net-v2-1-67542c3ceeca@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 12:27:00 +0100 you wrote:
> Do not run airoha_dev_stop routine explicitly in airoha_remove()
> since ndo_stop() callback is already executed by unregister_netdev() in
> __dev_close_many routine if necessary and, doing so, we will end up causing
> an underflow in the qdma users atomic counters. Rely on networking subsystem
> to stop the device removing the airoha_eth module.
> 
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Remove airoha_dev_stop() in airoha_remove()
    https://git.kernel.org/netdev/net/c/d4a533ad249e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


