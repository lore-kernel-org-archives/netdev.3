Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161B2F60B2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038279; cv=none; b=DTy5MgK0+3dk9zDOS3dTI0AWpP5wcDPygiEBjx5UDjTLpVh50WYV/dnA39C474y5rFOeyexYHpZxFkUUkzat+YzJXIhP4zwgWCJu8ALrwpGk/jIX48c5X9AbDdQ3iEtPvckcDP7NnAMvrutRCV9Zb7+IIDhNMuuaIcNrSfVeVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038279; c=relaxed/simple;
	bh=pYyRGwbHzWyIHM0PVc3pQ09Axy5u2RYGJjWaMk77kUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JagdPpM7D0eORkhlmhG+7i/f2/UfTIAic18oK9MxxACCGi+brEakYBEPECB8E+IVVWLV24PBpAUlBgjg+gmG1BEk95AV3lV/8B1i8iKMASlXQkSs4g2WBi2D9wAaZ1Hhla92u2JzFcqcpWBOIaQf2uyCCmJ7qHkPpTFxq0Swdq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St0NHDnH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St0NHDnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C67F1F000FF;
	Tue, 22 Sep 2026 00:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038278;
	bh=xFXIc8XHJPvkndyIgvNrz/aM5wVMsDlJRub7YScUbX4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=St0NHDnHqg5dIlzuU0uvEaD8XMUveAYfeTuO0tRpLSAVnBZQvAvhWYFW0t2rimllL
	 sSqNGqrWLFqtiblqmWNOjU/SI4PSmK1x2Zo2CCYvf/6kraCuSxa4UMpUjhQZpcEXXT
	 PqIMaaMqPy6nGRXWAa+DgifK9I6zWACzUV3KdE7DR/Ry9deP5n2GdbxwIu4IB862Y0
	 u+arwjPeZSA1e4CG2v2VLTAzCXHz49ADgvhi4funJnhU+47+Gr8bTKdp5b5TrjbwvY
	 bZqtONb00VGTgaP6itq1EU0C0lZQpWaVa7BDrd/+wHuyMKg0beqx8ejGwf+hUhJ3+l
	 YMzYM6DqxHSkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198313930205;
	Tue, 22 Sep 2026 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: remove dev_hold() and dev_put() in
 __netlink_deliver_tap_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003820964.3312649.8706518471915925994.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 00:50:09 +0000
References: <20260921093947.477658-1-edumazet@google.com>
In-Reply-To: <20260921093947.477658-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 09:39:47 +0000 you wrote:
> __netlink_deliver_tap_skb() is called from netlink_deliver_tap()
> under rcu_read_lock().
> 
> dev_queue_xmit() does not require the caller to hold a device reference
> count, and the device lifetime is already protected by RCU (the netlink tap
> is unlinked and waited for via grace periods prior to device destruction).
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: remove dev_hold() and dev_put() in __netlink_deliver_tap_skb()
    https://git.kernel.org/netdev/net-next/c/c7a2a8c0c9ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


