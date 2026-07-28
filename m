Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE325B095
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201641; cv=none; b=krZxwa3kAnaFFDYd78JK7eIZgs3lHw/Xun1p7gJ5MMkDBzlNUsKmWqB7uRsXKCTjjta2RC5XwoABFXAZ/VffALWv33FQPWBxk59IYHTpSKMcGzjANGMxzz+iECglv4jk0WciNTSdmJmHl1T90UrlTvwrp9gwD3kW9bwON/Dp0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201641; c=relaxed/simple;
	bh=pYZK3I+YghE0JVpZlD7O5C5mJQY6mVr4PQlO6YVYc+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sDPYw9owYebFvuRVxotjKfPzzWqGNtwzvFfelhsnVkVo8QaxbaBXBDAeUcbXvbXZXLwWV4cQCGxe0Lv90r7QonaUPWP774fQaj5KGYtKoSK0MhrHmooIl8JBdhJmbx7ss+PBzuV0oqB/MfXGTmkFq3VvmcxEQNExwpN4AopUyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Occawr3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Occawr3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6321F000E9;
	Tue, 28 Jul 2026 01:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785201640;
	bh=72TtMrxmAimG2WpG/zlvlXUmkDIIk2Do/oT4fPFFg4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Occawr3eAgT1LQA27jGQgmTvYA1cvWVuqx+myaj29tSZbfl3X2hDouR2MlyTGZa/8
	 RyXblJx9cc2oEN5XiK4ZuYHxwMTaRAYx7iRLmWqWL2/y7bQhuLRUNyh5gZcyO3/vBq
	 eTxUe34zf/GTIeKd+cMxbuBxjayz64UJhefWb8QAmtwzuAz8FlOcV4/KHyiaN/NMZ3
	 azd3AyMazuuEJuDyX4HlIonY0/Jtp96/TyJBLzR9fpZmE9FA6m6y3X9CXErC/SjkyT
	 HftkangqEccjevesqUnSNBnntXdlhGdNzKdGv7pizhZWhlN24aOpYP+W/WdhbH+y+N
	 xGcr/+lKMl5xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08DD380CED9;
	Tue, 28 Jul 2026 01:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rtase: fix double free of multi-frag skb on DMA map
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178520160564.1489434.12071644807967111296.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 01:20:05 +0000
References: <20260721023836.6691-1-luyun_611@163.com>
In-Reply-To: <20260721023836.6691-1-luyun_611@163.com>
To: luyun <luyun_611@163.com>
Cc: justinlai0215@realtek.com, larry.chiu@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jul 2026 10:38:36 +0800 you wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> In rtase_start_xmit(), when the head buffer DMA mapping fails after
> rtase_xmit_frags() has mapped all fragments, the error path clears
> the fragment descriptors with rtase_tx_clear_range(), which frees
> the skb through the last-frag slot and accounts tx_dropped. Control
> then falls through to the common error label, which frees the same
> skb a second time and counts it again.
> 
> [...]

Here is the summary with links:
  - rtase: fix double free of multi-frag skb on DMA map failure
    https://git.kernel.org/netdev/net/c/6fb7b769d6ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


