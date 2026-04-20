Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC103CF67A
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722420; cv=none; b=IjAIkSGSB/+N3ShoezW/y1PE/L83roRRfNMiFuGG5ly3Mzh47MCXOMsS7EjSqXnzkDTf926m3GgW1mvbCYh1eiSu06g0rYvzR3S85AZBKzJLB13iEujEPFSm8arLxd+xvEETBvjaz6DkcIPogzWtuKJs5I6A0x5y0OtmGXvU8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722420; c=relaxed/simple;
	bh=2OTjQoOKAo/XYCCFu/T9EswGB1BwfWLV14g6stBgW4s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YkCqIUsNAJlkp+yiyPS20jeNwQMq1HELCUqA0sHWX7XMAzWk+DTvlK/XO1n1tLD/OGqQt7WbBbAbt0qSPb8cO/9fWP+g6BQoAkhSNU+ABsXc3EqrKlu0kpe1ONb0R5pH3ztrb1529kxSD23rSzTRbxTAkasp93kR4mQiTSxGDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHRWocUG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHRWocUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AE3C2BCB4;
	Mon, 20 Apr 2026 22:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722420;
	bh=2OTjQoOKAo/XYCCFu/T9EswGB1BwfWLV14g6stBgW4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KHRWocUGI7WEASlXrPO/GeJvaQWQYxIhEUdTdoxcJTIcaDqUa412+UeBhPDFunuy4
	 LdIzd9s+IiVf8Rm9yHAWH+OniTYNjNYxtEXaRLSTDOFfdv1FZ2An7uaGt4Ih9ZsH0C
	 46eHeaboPrmwImHGjgpA6xtxOsxZvs/oM7A81AY+ZUz6NOha4E6wUGT+hWkjeDhscD
	 ImVjH+NT3IrjHb5rTXrrzPulqwnamMJSGwS+Y26ckwZjC5xhPAkL4d9/q9+pqabaXG
	 YFpQGc09gqh0nlXBmUx+ww9Fsjoq7X6bASLyhLv52u2XE5Iq44TPNUHmDqQz9hsVbj
	 NZysCvwaskADw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BB62E3930022;
	Mon, 20 Apr 2026 21:59:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: Fix possible TX queue stall in
 airoha_qdma_tx_napi_poll()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177672238429.1802062.15152793515416215321.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 21:59:44 +0000
References: <20260416-airoha-txq-potential-stall-v2-1-42c732074540@kernel.org>
In-Reply-To: 
 <20260416-airoha-txq-potential-stall-v2-1-42c732074540@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Apr 2026 12:30:12 +0200 you wrote:
> Since multiple net_device TX queues can share the same hw QDMA TX queue,
> there is no guarantee we have inflight packets queued in hw belonging to a
> net_device TX queue stopped in the xmit path because hw QDMA TX queue
> can be full. In this corner case the net_device TX queue will never be
> re-activated. In order to avoid any potential net_device TX queue stall,
> we need to wake all the net_device TX queues feeding the same hw QDMA TX
> queue in airoha_qdma_tx_napi_poll routine.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Fix possible TX queue stall in airoha_qdma_tx_napi_poll()
    https://git.kernel.org/netdev/net/c/b94769eb2f30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


