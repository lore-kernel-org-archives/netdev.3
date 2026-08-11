Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC091445AEA;
	Tue, 11 Aug 2026 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456881; cv=none; b=nQQi5Ceo+ZsOlD3pVFKSxacRiCDD733BiMSmmqRZ8dKfd2n8q6/p6K0ln/EqkKEPPAXRp17i9a0+d8O3Bg1+Knld90GGzx2SkFIw+cK6Oooi78icIMDfzxHlhz+F9NZB9mn2mvQVJNPQiJxSBcQx8ZsTmB59nmI0UpCFUnljS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456881; c=relaxed/simple;
	bh=jqTs4iS8D7RGhw5yaVH4FgQaBl3+9PWxPBozsT6WBH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gEFghXcAFuoAWsgWC3rs7OlQ4MWFtFZBjLVDtD8zjEZ6/IOujH1TtZLlK6/py+3gIGIdsl4i6ef11ZoThOJ1eIGwnAGtGeCHAEcByEmPFWAflZc0IVnR04bB/zC8OclYi5Pa3cz3Gw7FxWlvI84Zx8u30KvEPKm+fVHyIep51W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8lA4PJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8lA4PJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BC01F000E9;
	Tue, 11 Aug 2026 14:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786456875;
	bh=QzyvIYOP2Mwj4NRGE/J6LThHaLgt9Izv3pfrsW6JwBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S8lA4PJsNjQFQJJ6JJM2rte3Mk7slQkhlCqlVeswoq6qGzr0eNg9xtXGEu25rYuS5
	 e03hsTdrDAB8aBu8+3T8XX8SxyZ98lpJiC+/JyT2Pc6OaOgOcBXTRkAFyvMo4ydlwm
	 4zAOKEuw3uug4VPBLt4qGzT9PXAyrduYkqtrL4ggDCkkIFbFwyfNSfDIH8CMkaOErE
	 s64ta+sd6ABZqeY1vsS0fmf6eMFC7iC884p240bul37bMagN93OA7goqa65LPJpN/D
	 VFuddR/xDHwfzeg961LGtcia1BiAc5CxSgkFdJdfzOkQuupUoEN9VoFFoco+qk7hAs
	 MsZnB3bWrRqSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1988A3810900;
	Tue, 11 Aug 2026 14:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tipc: read le->link under the node lock in
 tipc_node_link_down()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178645683164.537263.7714780493708130841.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 14:00:31 +0000
References: <20260810102147.48191-1-juny24602@gmail.com>
In-Reply-To: <20260810102147.48191-1-juny24602@gmail.com>
To: Jun Yang <juny24602@gmail.com>
Cc: netdev@vger.kernel.org, junvyyang@tencent.com, stable@kernel.org,
 corvus@tencent.com, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ying.xue@windriver.com, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Aug 2026 18:21:38 +0800 you wrote:
> From: Jun Yang <junvyyang@tencent.com>
> 
> tipc_node_link_down() caches the link pointer before taking n->lock:
> 
> 	struct tipc_link *l = le->link;		/* unlocked */
> 
> 	if (!l)
> 		return;
> 	tipc_node_write_lock(n);
> 	if (!tipc_link_is_establishing(l)) {	/* deref l */
> 	...
> 		tipc_link_reset(l);		/* write into l */
> 	if (delete) {
> 		kfree(l);
> 		le->link = NULL;
> 
> [...]

Here is the summary with links:
  - [net,v2] tipc: read le->link under the node lock in tipc_node_link_down()
    https://git.kernel.org/netdev/net/c/cba9ccb47e9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


