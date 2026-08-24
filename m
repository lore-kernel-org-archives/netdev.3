Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447D384233;
	Mon, 24 Aug 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598666; cv=none; b=UBn4lweeXbsPAfGirAZQLcZJayV8+hpp1fy4Z6mq342L1pzJj9J4IPcS+AYTV2PQB/P4zJtxTUn3+15c9rJyoqRtt1T4uA0qWZl1NiAuJ27kvZYVyZwGzrTIHEhjcMO+h5ea8xQ1FYuUAQUN9acWdA8hI51nL2Tp6tLz2vIhW9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598666; c=relaxed/simple;
	bh=nYixrdxVJ2L8Nk58QVXXpIR3wu2xsLEfTPvayqwmgU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=beqLNIQIczJPsbKJQaB+q0T1Cdd4RfMbklA0hXmvxKl61clpBTqKzlJ0ttp+2sCK++YSUEQfZi2m3KLlJ2KQB7o8BhiQkphnvQJR67iU6ML/Xw2DxuTxuonheyOu6kDbde9Kplnq43xk3OB4B/BZ9N+Ty/jmfzJNEZBlQhJfNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U24c39yW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U24c39yW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3841F1F00A3A;
	Mon, 24 Aug 2026 19:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787598665;
	bh=dFDeIeIG8pYRr73lwTgzBmOcJDN2tRawXXttGEO4JLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U24c39yWOwKaTn+Xt8qLICHj3687FOwtMFOkbT8AaGuX4unk6XcRSBXCILzxsn368
	 tzTeNyIbFYwkN2wLzwhwFERlhh2FxQtYqiQbGNmGCTiOOT9Mlwm65w2EQLSsIVVG8p
	 JDrXzbUvvaMRdq0fW3bHSWYNntJMGZ56ITqdTjmbmRJH/8CwdQB7QxJrDRnwDu9E1l
	 ouhuggqLTeTh+ydFFVnsk3vt35P04ydmOGr6gnD0/9QPaiy6E8UiAHlIZXehekv5eQ
	 /5NkUMrkGnmb0d2DaODsTm5m9Y+qx5AJTc9rkGd1LWUfU3JtawFKSjP75AN96rrzoh
	 L/sKVzxepKKsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EA8093924A4C;
	Mon, 24 Aug 2026 19:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759861288.3069565.17735518402578185304.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 19:10:12 +0000
References: <6a882352.ee10049a.267d65.7a31@mx.google.com>
In-Reply-To: <6a882352.ee10049a.267d65.7a31@mx.google.com>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: yoshihiro.shimoda.uh@renesas.com, michael.dege@renesas.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On 21 Aug 2026 15:37:14 +0530 you wrote:
> On an of_property_read_u32() failure, rswitch_get_port_node() set port
> to NULL and jumped to the out label before releasing the reference the
> for_each_available_child_of_node() iterator was holding on it. Once
> port was overwritten with NULL, that reference could never be
> released since out: only put "ports", the parent node.
> 
> Rework the function around for_each_available_child_of_node_scoped()
> instead of adding a manual of_node_put(), so the iterator's reference
> is dropped automatically on every exit path. Since port is the
> function's return value, take an explicit reference with of_node_get()
> on the match before breaking out of the loop.
> 
> [...]

Here is the summary with links:
  - [v4] net: ethernet: renesas: rswitch: fix device_node refcount leak in rswitch_get_port_node()
    https://git.kernel.org/netdev/net/c/5c07193ebe47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


