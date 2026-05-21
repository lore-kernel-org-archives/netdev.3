Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB22248A8
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330032; cv=none; b=Ot5nXVKJ8Wm0gnHDa3nU5WQ7nr0Jx1SeL6dVYDFtVge1SGJWOHgHG7jpJ+uOGEE3EK2Jgdm9KS+rYN0oRiZmU0TB9kQB3jradIL7PquzxyM/H7GSD5IjMJw4ACLaOk5WwHE5qmJhRbLmDJzo9oetcKU/vx+/iGt5yxmsGBkjyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330032; c=relaxed/simple;
	bh=dj9KUPgmeG02wtgN2suKyNNLboKGOEinRr2BQ3djaLw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cCxLYvXIgwRKPX6vkwmv2WqfN/HEJbyif7AW0g/B1kWhGf9YSsu6VY90TEpffBzepHdFk+DQFY5ZTYMEJvN6DEGf3XFTTsz6VSuYZePREe6Ftg4du9LM1ULp6sIOEtzZ+b+7uZEA12FGbWJw0UQZaUMcyxTeuS4bPThvwvijq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP8/13EU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP8/13EU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9571F00A3D;
	Thu, 21 May 2026 02:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779330016;
	bh=eclFaddiSPeFdufrtqOqMVr2qRu72pUnwN6vdbbdn3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aP8/13EU+D5VGa519bZo8zK2R4UpAL15Ez5OBZhkVJeO1IWZHuSuy1DFJIHWp9sDI
	 mzS3QXpqmIAOwhcnL6tJVVI7GTDUZ8lpe4yaQEieFP+2uQXgRN6HQx7sHSdc6LOWIi
	 5AwV9q86eepF+9KlMvtBMXaFFwzkQPMk9NFuFOT7IRTYgN5CMKBrwTai0sM97AB/Sy
	 iUfEWbn2MOSxXpg12fFp+p03JJlk6RzhOTqgHg8wKHV/LHeOt9g1ZRg3+x/wW4tOX3
	 XFvR0hH+D/tblNckmb/nJ2PsQ6M8/KAtCXPKpcNLIZ+Z7a+jLeosEpbqWYSY3kZlzW
	 i3xr92XxQgU0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BB3930C38;
	Thu, 21 May 2026 02:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/5] udp_tunnel: Speed up UDP tunnel device
 destruction (Part II)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177933002613.3834961.2285430082658789103.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:20:26 +0000
References: <20260518050726.318824-1-kuniyu@google.com>
In-Reply-To: <20260518050726.318824-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 May 2026 05:07:07 +0000 you wrote:
> Most of the UDP tunnel devices called synchronize_rcu() twice
> during destruction, for example, vxlan had
> 
>   1) synchronize_rcu() in udp_tunnel_sock_release()
> 
>   2) synchronize_net() in vxlan_sock_release()
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/5] vxlan: Remove synchronize_net() in vxlan_sock_release().
    https://git.kernel.org/netdev/net-next/c/425e30577f17
  - [v1,net-next,2/5] geneve: Remove synchronize_net() in geneve_sock_release().
    https://git.kernel.org/netdev/net-next/c/2f7f86db1675
  - [v1,net-next,3/5] geneve: Remove synchronize_net() in geneve_unquiesce().
    https://git.kernel.org/netdev/net-next/c/567dbca22b37
  - [v1,net-next,4/5] bareudp: Remove synchronize_net() in bareudp_sock_release().
    https://git.kernel.org/netdev/net-next/c/d38be9217277
  - [v1,net-next,5/5] bareudp: Use rtnl_dereference() in bareudp_sock_release().
    https://git.kernel.org/netdev/net-next/c/e6409584dec6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


