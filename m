Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A8B1A6824;
	Thu,  8 Oct 2026 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418810; cv=none; b=jOzvFrt6fBn2cdNnaxvWpZYLRyMALyDpLSGXyDbdX9/zwi/1PFQXG+whN5Hrd48PAjN7iifjfba8t8eTv/HRNyeatuFPxLyX3fvammupNgx16GEpc9BRC4UwvvQMPNGLB13KC1UewsBc8JMR1mbqFLwJZ764WG82fSa7H8zg2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418810; c=relaxed/simple;
	bh=7NiFGd3jodRQlBcgcq6xhkPjDUOTYMxlbgLGYLdazfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZY/m29wUBDmutmnRPVaxXiYqcsSMSumg1m8MuzZH+JY5iPFa0I5/g8v7upOuj3JaPUZB8sBxAdPwSlkDxZNuH/xOMb1V2AOjS8wc6NlsAUy5EPYFBIPABWWNUD/zxEmuKe9T+T12LiH+i24LgMdHWishds/oddD09vYEO47TScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba6B4PRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba6B4PRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB2E1F00893;
	Thu,  8 Oct 2026 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418808;
	bh=LG+AO0bI5edevSBynER8MEYx3vIHc56yU7gbXRaeaeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ba6B4PRAkvn+c6t6z7soV7VoCDJMgic8Ke8GhW2soBggzUtqdfauJajKzBeIfM7vX
	 DZsH83J56oXuDuloIIrTEsPpjCMrLJjLlAla2IjVk9Gl8aeNEY/19eM28fQnqkuK1t
	 KAGfbxohla3cd366TLiPROIYQPpitCybmc8wuuJIZNyvr/T1nB03MuAXocxVwsgxif
	 Hu4S/xmb+Gl8zmXZBXHkSrM+r5xVSs5K2uufVsNI7AZridw1ERoXH91vIfL4xf/BIC
	 0bIuj+yO23uBJ9Pz93hDQNuq4rYNSl1eCTakapCXoMQh3Eo5TYQladq8sooufIoCzv
	 P6f/aen4oNBfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B445C3809A08;
	Thu,  8 Oct 2026 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: bound the device MTU accepted for L2 bearers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179141880727.3746804.9812166172922423537.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 00:20:07 +0000
References: <20261003035018.397-1-shionthanatos@gmail.com>
In-Reply-To: <20261003035018.397-1-shionthanatos@gmail.com>
To: Yunpeng Tian <shionthanatos@gmail.com>
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, gmwgg05@gmail.com, npczmd@qq.com,
 xiao-yu.zhou@connect.polyu.hk, jupmouse@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Oct 2026 20:50:18 -0700 you wrote:
> struct tipc_bearer keeps the bearer MTU in a u32 while struct tipc_link
> keeps the link MTU in a u16.  tipc_enable_l2_media() and the
> NETDEV_CHANGEMTU notifier both do b->mtu = dev->mtu, tipc_link_create()
> assigns that into l->mtu, and tipc_link_set_queue_limits() divides by it:
> 
> 	int max_bulk = TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE);
> 
> [...]

Here is the summary with links:
  - [net] tipc: bound the device MTU accepted for L2 bearers
    https://git.kernel.org/netdev/net-next/c/592d0fdb02df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


