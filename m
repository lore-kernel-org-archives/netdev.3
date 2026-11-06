Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003608;
	b=iDKMy/fv5QBKu26uHGBStAvckZ6mNqbt1H63lhbf55oj2s99NHqzft4SBcYCiPGXu6BC
	 GDHaQeFZxMqJzW0etlE8lpnjWb0NUZiMRuyUJyqsaJMWhDrX7yvyKx/oslO6CoygGib+n
	 F1s56xMMyy32HJwllB7g5PsOEDBP8AZ+b0JKMcq4LvCXqtqbOs5F450I2wEfUlR7DuL5M
	 Z1CMc6SW1d5wjQUhJkaQXGcRJWyiFH/GQNBH7Px6RwG0/Kpl2/43JeAINzNIsMd4yOj5H
	 v2m47QGHnEDV4AHtUaL8tvGAl2X/4/nbcECTvWutdE/pMbRHacyYGD6MUxk72saZnfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+upI4eL2SKr6lAl/QsE/AzRsHDvN+KDapj3zz0AN5+I=;
	b=XMImMa7eQwqAvAyUsPOQfAVpqKIfPIu3vJ65HCesBf7O1EHxbfYIRluQXJrWU4ryOGdD
	 XvNi39I0tK+tSTcHtGfjjTXrmsyr0+4L6xpoA6UtP0RDbpwNzg393DbkfTdJ3QqqJGTSb
	 XUsZxEJimhCgyzR0YRLsZuckrKvkCLBZkH3MR+1hPJgjtz28u+ee2V2NGdliuTn7k28fD
	 0WqCQH5ajBdiIvwxy/wHA0vcDaRwAhre+8mzwz54TKOTkW9nf7rjVC2lFCk/+Hv6m5zZz
	 m+yjsZ6mccNOF+gM8twe5F2eRjOvNV9lmuA4VD4E3vAOJ3rC/tFTAYzzfzKYSZLkRbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AYfdX/cw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95854606A331
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYfdX/cw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9511F0089F;
	Fri,  6 Nov 2026 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794003608;
	bh=+upI4eL2SKr6lAl/QsE/AzRsHDvN+KDapj3zz0AN5+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AYfdX/cwCfLhEACqYqRJHXHRkvmLGfgOJGnF9ifnz5Jb8SytQnbkNIAIy0Wj0ncyC
	 oaiNWkzdPYcwNxL/IjwuDqygr5nDXCzBbgjxmAUipCPlG6aWt1JMpvUOWbrTfd6tKn
	 OAJlZK9el6LjkSQkMj7wire2dqvJZ872p7py6N6n8PNekhXmmoHR9dhQG3vPu67Zeh
	 YG+SHy5ojxU8h1FkViAxpUMvxc6sLyprFoBQ2QXjoKly6I2RCKQZXTr665DblCuJZt
	 snxK4bHa0E3COqGPRyxUFNXH7RzdrKuFhZbY3OXmT45gCfmsMbnnCm4aSd2UpPROyJ
	 W6JFUV4ULfy9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20FBD3A54A01;
	Fri,  6 Nov 2026 22:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/ipv4: check RTNH_F_LINKDOWN before
 ip_ignore_linkdown()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179400360667.903397.15277401887179950479.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 22:20:06 +0000
References: <20261102231456.965943-1-vincent@bernat.ch>
In-Reply-To: <20261102231456.965943-1-vincent@bernat.ch>
To: Vincent Bernat <vincent@bernat.ch>
Cc: dsahern@kernel.org, idosch@nvidia.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 00:13:30 +0100 you wrote:
> In commit c0c5a60f0f13 ("net: evaluate
> net.ipvX.conf.all.ignore_routes_with_linkdown"), I introduced a small
> performance regression of about 5 cycles per lookup by adding several
> dependent memory loads through `IN_DEV_ORCONF`.
> 
> This patch cancels this regression in the most common case where an
> interface is not down.
> 
> [...]

Here is the summary with links:
  - net/ipv4: check RTNH_F_LINKDOWN before ip_ignore_linkdown()
    https://git.kernel.org/netdev/net-next/c/5fe3653f13b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


