Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09553BA23F;
	Wed,  5 Aug 2026 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895255; cv=none; b=CyBsB3nw0ecF9OYX6s1MCCkAuFw1aTjGxs1lqO4xgWIsxE1axursSOCYd8wFLauiXLJgI3YYHHQbVZAnsnkfzdUZGPiS10KNSsKPAn0aPyswoJL1aOI09c2//qj3004AE5MjUJWIk09tMKsRVkjPga2SayDLY/KurOARXKmU/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895255; c=relaxed/simple;
	bh=4j7wBWvO4dwHV5bU303NTw5YB+i8yKF604yzkfTz7i8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YJugLYEzxp+Eom762GSSh9bAVmZ1z2AK1yCTqI9WV8pWxyvmcHIxoXYVBvxg3SCV3TIBc9hVgv20oEGJeHPNQYE76F5ixEf6EnQwBHqx+Z/NyB/TfDDvQQroHn7yBIeu4dHM7DMRSDfefgz+VDuoJCQJrWADqEWu0RwpnffOR5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaIVwbtS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaIVwbtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9595B1F000E9;
	Wed,  5 Aug 2026 02:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895254;
	bh=sVmC8lBwQ2rfwI7kqWdXhASE5AFIPpK9OEJn2omwU+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KaIVwbtSxw9Cv79VSnFbMDIgWvEwdFoDJvqcLQ/J78vhNIkgcofAUi3RCKukoCGQx
	 hqg/LzWOAcBwe6BoNtC5TnA84ZOPpGlzJL0efmrX5eCY9TNIscb7aeBHeLB2wsM3gr
	 2k5mf5gWz9ufeOo8Xj0oTCevkCZiqEe6Jwky9LZmCJlRN7uTRDCVXmoUefc7g3Jh4d
	 a73QrBOKmMNT7QwqPjY6iFc+AmfoXIUQtQ8ygAn3RNlOt8yKhVU3ZsOV10Nd8OXpm2
	 0DlPVVXse3sfcOhmPri3WfIVE9VZhnPm/N2dLSXsInTw3x162K258F1K/8F8KAdM4o
	 9CLRCV5ksKdnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E03926667;
	Wed,  5 Aug 2026 02:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macvlan: check register_netdevice_notifier()
 error
 in macvlan_init_module()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589521464.3873994.18186364661522939721.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 02:00:14 +0000
References: <20260803085950.142325-1-heminhong@kylinos.cn>
In-Reply-To: <20260803085950.142325-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 16:59:50 +0800 you wrote:
> macvlan_init_module() ignores register_netdevice_notifier() errors and
> continues module initialization, which can leave macvlan loaded without
> its netdev notifier registered.
> 
> Check the error and fail module initialization early.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net] net: macvlan: check register_netdevice_notifier() error in macvlan_init_module()
    https://git.kernel.org/netdev/net-next/c/82167f2f0fde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


