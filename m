Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6041A6835
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721068; cv=none; b=bBs6PwWW9a2DGXJ4U0E2DZC9BBNBu9fMLdnZ4cagx36kR15b/PIlwYCL++Y4fGpQ7wbR2zvhEEaObkYxcZCTc454v8eHUlGqulcfuPeNQDJUdtz2z1AEw5vXvsQvjC+Fk5d491+LepjRh1MqzcxWmXhqaHxowNJxWxr/maDV1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721068; c=relaxed/simple;
	bh=d/2jPCrC+5aSuu9PbvfeZ+4yl3VgiLImJ1mvR6ZYaNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H0LqZW71nIpjpZRPt/1LsusOdqaTQBCtRGS1kKxPjk/jeGhJepgnuezYMIChtr2t1ZmxQbH8j2EtwYJmNvdfBcHJKAeVr6so/0MOxYL8/Lne38QLflQNxSWACk5Q5XDOgqtMx453FLhQVgZmTL+zPSzbQKfJe1D6b+BlhTkKczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn/9PlqO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn/9PlqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5A5C19425;
	Thu, 14 May 2026 01:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778721068;
	bh=d/2jPCrC+5aSuu9PbvfeZ+4yl3VgiLImJ1mvR6ZYaNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rn/9PlqO5XEnUWL161v8IJ4gve0bahhw5CWa1QgRqyqLVDm+b5kMyVdCC7t6+kQTj
	 tL5hC7P6izwK+TDVMGLWyp5ZYXkgoyaUgHQCc6JeOQ+bJq0G98qH1IUG3MiktuzJXn
	 myXIxzWuMEz2WppOCILFS+ePb3hStWQCQz0FduHOzFQdrYLlKntnLAP1eOUThP2kyl
	 7bh5S/e4pcgTqsO25ThmrertaufoEOR+vXWRQ4rmBhoZyDmkwp03V6DN5RRKMlXvvQ
	 rsTvvA7JsL6H9EPu9Smq4If/XV9bQUfymr7v8YBF8MZS3ZHIkUKbx/6Lgwog78okfb
	 vE8ekWGWA9tAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE53393088E;
	Thu, 14 May 2026 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipvlan: use netif_receive_skb() in
 ipvlan_process_multicast()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177872101330.3905490.4199302955949492356.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 01:10:13 +0000
References: <20260512042019.3300975-1-edumazet@google.com>
In-Reply-To: <20260512042019.3300975-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 04:20:19 +0000 you wrote:
> ipvlan_process_multicast() runs from process context, there is no
> risk of stack overflow if we call netif_receive_skb() instead
> of netif_rx().
> 
> This avoids some overhead adding/removing skbs to/from a per-cpu
> backlog and raising/processing NET_RX softirqs.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipvlan: use netif_receive_skb() in ipvlan_process_multicast()
    https://git.kernel.org/netdev/net-next/c/d0273dbe8be1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


