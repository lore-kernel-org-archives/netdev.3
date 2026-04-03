Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC0314D34;
	Fri,  3 Apr 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256026; cv=none; b=EuWzuV1kAR1Nr97xxqXP571RL3FJOQ5nU1ZG/pj4BPQ14BIvPUD+fM84cfef+h3nI2ekibCx46KWt1jiD7r3X/OD+F6cIW05Ipgz9pCB6NS7mgVZ32NrGIdy3xgThBjMgPctJTS30LveQxaJvdPt162Ayv2ih2BTCQTgUnMtiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256026; c=relaxed/simple;
	bh=NRwUQxbnX47EhQ/5fV/mrQtkLbjo3YGJ9fBU0uqRu5g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=suRyi5mGtUzUhNmKSquzkpFnYj14u2B8qhB1XQmVMfZRAnjFlanhUv21ZG4Fa9pPajocPXWUczokNR/AJap6lc/os3VMy1d3rzWBOeO+vE7FO+NCKUeViiNJLiIqQ46gHbNaCNEKqxw8M5QY2isamhhIP7MLuVGTvwkEQWsfsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXtpXNNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXtpXNNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE44C4CEF7;
	Fri,  3 Apr 2026 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775256026;
	bh=NRwUQxbnX47EhQ/5fV/mrQtkLbjo3YGJ9fBU0uqRu5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rXtpXNNHLPGRO5A19k0lxxFpMjAVhc+Mk89IHPgm2NFA7NemGO6/Q7g7Mae3iqWS2
	 awy2UJbya65l4YzNSc/d9Qj5Zy4pc65/2iEIB6sBSFfUT3lwikyxJvVHjTYTgpcJ+f
	 l0L8oIla7tkGrr5ZeWMRU2RosxewavWmK2D7WSMY51Gu2tyTnjk8uXxU7D9cXWfCwC
	 U05HwZU60KR0ECWJNMdbSomui/mpKEJ6uJHykTlOIZp06ljX5is4vk86zoble24D1k
	 5rfOQ2GZbuaLrl4A7X01/sqOPmdOQ6JtqcgKM3vpCi82lA5buaPBDiRqBLVTw9LH8l
	 F+OIxrJDxX0hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DDC3809A14;
	Fri,  3 Apr 2026 22:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525600728.1477337.10729716118426836101.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:40:07 +0000
References: <41a4833f368641218e444fdcff822039.security@1seal.org>
In-Reply-To: <41a4833f368641218e444fdcff822039.security@1seal.org>
To: Oleh Konko <security@1seal.org>
Cc: netdev@vger.kernel.org, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 2 Apr 2026 09:48:57 +0000 you wrote:
> The GRP_ACK_MSG handler in tipc_group_proto_rcv() currently decrements
> bc_ackers on every inbound group ACK, even when the same member has
> already acknowledged the current broadcast round.
> 
> Because bc_ackers is a u16, a duplicate ACK received after the last
> legitimate ACK wraps the counter to 65535. Once wrapped,
> tipc_group_bc_cong() keeps reporting congestion and later group
> broadcasts on the affected socket stay blocked until the group is
> recreated.
> 
> [...]

Here is the summary with links:
  - [net,v3] tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG
    https://git.kernel.org/netdev/net/c/48a5fe38772b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


