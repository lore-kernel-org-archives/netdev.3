Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8447A87B
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478475; cv=none; b=K5yB0PR4ShAGX+LHYXeiazGozT6e7jBtz6XUFeSUSyI9veqoE0g0LTDGfGDlru9YAvbBCxcXuT5hJEuvLV3Vg2x3xjZjpK2r+37AnFULGsuGtf329bTZcen4AcTxH/MX+zvDQPEbkrdAGTlZ26bBQ6OiAdbZn/DguBQcPz3BERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478475; c=relaxed/simple;
	bh=8udZb70xrXvaqD0uK8be4PCq7GR7PadZKFmCEqH0HvI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rPMlUmESNyZNNhA4bhnSaOFfYB+WDdQeb2k5ZfZea8DhP+Gndt7IhDT+S5/s6lcbPGO+usN6S8XFH4Aqsj3uU9atpGQx8doPDAcoHPVw4mr4HJFkM9Jf3rG1vJEE5OHUbXRTstdwwC8WcaWuCofT7Adwq8DkS2EOcEzYm3Yuye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3m17NCh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3m17NCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8FC1F00899;
	Tue, 15 Sep 2026 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789478473;
	bh=YPg4GSuofNkNxJz0GB9mED5uObtd5fwUi0qZBM18H4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K3m17NChjiu1ODEGKAINOV/fak901uqw9YtkYEoybPiuSlALqchMmMjt5sjMDz6IS
	 e1/6QBj0jwW9+oYc9OuWwjeWikRM+rsPxgr+SGZNaxbIvQg2PwG/wjtqKUa55q2rVV
	 CbecNUhHDamkRqOCHyj9eNrIP8GD/ro9B+HM8sS1oSj4TzKzmAWpa3sC0dx0j/uCVW
	 Gp+TYgVP9nebXppoCL6ayLJf25pFRmUt0UIyL2w2MKR/36NJCV2YAOUXlz6t6KmcME
	 SS+dAJ4ztMlZS54ioWm6+FkOY2KAy9nAOQ5Xd4xJV7kec12QhLRP7Nir+97pynEKbS
	 9cLuEXo2of1Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E639263A5;
	Tue, 15 Sep 2026 13:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Don't call skb_clone_and_charge_r() for
 close()d
 listener in tcp_v6_do_rcv().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178947840749.1617434.5304253932380881350.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 13:20:07 +0000
References: <20260914011420.115556-1-kuniyu@google.com>
In-Reply-To: <20260914011420.115556-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org, tarasmadan@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 14 Sep 2026 01:14:01 +0000 you wrote:
> tcp_v6_do_rcv() no longer calls skb_clone_and_charge_r() for
> TCP_LISTEN since commit 073d89808c06 ("net: fix data-races around
> sk->sk_forward_alloc").
> 
> However, there is still a small race window between tcp_v6_rcv()
> and tcp_v6_do_rcv(), where concurrent close() changes TCP_LISTEN
> to TCP_CLOSE, causing skb_clone_and_charge_r() to be called
> locklessly and resulting in the splat below. [0]
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Don't call skb_clone_and_charge_r() for close()d listener in tcp_v6_do_rcv().
    https://git.kernel.org/netdev/net/c/8e759cd1f644

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


