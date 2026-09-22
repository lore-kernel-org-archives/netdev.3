Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36494F4CEB;
	Tue, 22 Sep 2026 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075475; cv=none; b=CtbAF+u1BmqmsuUqmaEH6VwyOsL+OkoMB0XdBpRSb5Oou1ZxuHCRdXrkJAph67Fks7El2e1kO8cJ5I5f42YjS9Vtn05x5ZM9WBSqWXe7w9DHcxxIcTIRtx4f/x8DRAJgLE78e5qalShudHcUA7FF9FYujtPVZ1sMH+Wesqa9kfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075475; c=relaxed/simple;
	bh=Kgacg9jBlmh7+zqq8hiLRtoK4DFcKmqESc82gwqWfFg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aA6x/6yW6AWLeKPq28FYdkStJcFWiYaPrPL76QcDUHX8xZsN9Peid1duzrzEZ0LIgeh4K7SbizO3TU4Ykqmi6/z7OkAMznvsl7rvUnAYmIdmRQ1cN1S9kdFIZMHnW0RWfqjJi3DexQTtjYhjOtbSXkmZBhzfOu4XNVV5AO2NatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+nqkf8+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+nqkf8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A86C1F000FF;
	Tue, 22 Sep 2026 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790075474;
	bh=Yo4DbP1rUrgJKNQZZVx5WiS2VPmNEonEX8L/QUf2zlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R+nqkf8+Zg1UgDm/DOnryDmO1aYIaxSTkRJTlyinOUqb2dP2DrOW3UqZ+Nh3NSQcK
	 cApXu65RxpCd/WySkAMWxsibjsviAp/QcCWzXqtNM9b3pGDUX4FaslpdShQXWpltZv
	 vSaE6uPjotyVfnqryVROnf+eiys1nWBchEyU4NOlbjKD8hUzSjjiCAjE9I6x8K+r6u
	 i9gCFPkiYLvtEuFoMtOeaU41oRft/6AjreuJavEnlSfDdN/PdhmDhQv80Vkwdv+Zlr
	 lBUeDgLl8YGmQsDrCDBc1l0Y+QEGp2nN9AnWkkmVFiTxqh/pR+kjfMJxjlrKplQ/PU
	 /NpSObRNebwBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AA738119DF;
	Tue, 22 Sep 2026 11:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: spacemit: clear TX descriptor on fragment mapping
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179007540539.3561948.7697429220017921744.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 11:10:05 +0000
References: <20260919191937.271202-1-meatuni001@gmail.com>
In-Reply-To: <20260919191937.271202-1-meatuni001@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dlan@kernel.org, wangruikang@iscas.ac.cn,
 vadim.fedorenko@linux.dev, maxime.chevallier@bootlin.com,
 troy.mitchell@linux.spacemit.com, netdev@vger.kernel.org,
 linux-riscv@infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 20 Sep 2026 00:19:37 +0500 you wrote:
> emac_tx_mem_map() writes TX_DESC_0_OWN into the ring descriptor for
> every slot beyond old_head as soon as that slot's memset()'d local
> copy is committed with "*tx_desc_addr = tx_desc", i.e. before the
> buffers for that slot have necessarily all been mapped successfully.
> If emac_tx_map_frag() then fails on a later fragment, the err_free_skb
> path calls emac_free_tx_buf() to unmap and drop the skb, but leaves
> the already-written descriptor memory untouched, and tx_ring->head is
> never advanced past old_head (the "tx_ring->head = head" store is
> skipped by the goto).
> 
> [...]

Here is the summary with links:
  - net: spacemit: clear TX descriptor on fragment mapping failure
    https://git.kernel.org/netdev/net/c/2d14720beb58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


