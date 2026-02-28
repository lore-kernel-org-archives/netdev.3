Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1533D6EA;
	Sat, 28 Feb 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247011; cv=none; b=eJpVfAEsr8lMwQydNBNNUKAHv2iiw1f92Agw4F4RX752EHzMJi+wFckLuIWH3QhLOZKfrSwaSFf9pfjAlNw00i97BwlSl9V8h+Oiy1cgfeAv8df0NpmrrFLIkQN3UbexQvfgSoBu5ykaG5tAJnB4HGvRPV8+EnAKaV61vqsODKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247011; c=relaxed/simple;
	bh=YFCDTXqu+rdhmgSl/brixRAljHEqsiMrOla/ZyzeDLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XxwAlnsmuY5uaitCn595zmiLRtI7XD85ECGiBAVIssTUuBSBlwpK7OQIdJWyv1fY7Y9iimyV6LnqFSv+BW+/FimLROGFV8N08RYq9BVTYnZjKLsZBJHUOT059zQkHe16ijK5XLk6Tf11RXPB1MfQrIWR7W70XC2PEAdw1Fw/1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkAQzIMR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkAQzIMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839C4C116C6;
	Sat, 28 Feb 2026 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772247010;
	bh=YFCDTXqu+rdhmgSl/brixRAljHEqsiMrOla/ZyzeDLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qkAQzIMRvRIusJtux8TGilwkUWH7gJGUbb9+D6qpej3yulb3eOcsgCfAT6lFPQp/M
	 XB6WQTM/7kEprJJG9zDde/wKQaQPjEQA0imOMEwuhpu60PjEmhqBWcXrM/naE+YKhd
	 194Q+Iz1NfQsABAdFgxy/1QkSZ8HUrDjCwZb3NxaV5mKIC0XmCowlBs6Fu82XWfvzD
	 hpU4LEY4PTDuKnGx1iuNCgf6XYQoZIsVqEu8t3D/FDz5Pcp18mXKA4h3eBEGhqh0ua
	 7l/Nb2DRSWEsAKcFugE7vgNpQhE0c3ZoDLESKhAJd9GWEC3ehCineVz6FZLQV7M7Kh
	 hl9MbF0efIZXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE6539EF96C;
	Sat, 28 Feb 2026 02:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] vmxnet3: Suppress page allocation warning for massive
 Rx
 Data ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224701379.2846847.10608754934612408646.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 02:50:13 +0000
References: <20260226163121.4045808-1-atomlin@atomlin.com>
In-Reply-To: <20260226163121.4045808-1-atomlin@atomlin.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: ronak.doshi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, da.anzani@gmail.com, sean@ashe.io,
 mproche@gmail.com, chjohnst@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 11:31:21 -0500 you wrote:
> The vmxnet3 driver supports an Rx Data ring (rx-mini) to optimise the
> processing of small packets. The size of this ring's DMA-coherent memory
> allocation is determined by the product of the primary Rx ring size and
> the data ring descriptor size:
> 
>     sz = rq->rx_ring[0].size * rq->data_ring.desc_size;
> 
> [...]

Here is the summary with links:
  - [v2] vmxnet3: Suppress page allocation warning for massive Rx Data ring
    https://git.kernel.org/netdev/net-next/c/c31770c49348

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


