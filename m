Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0105470123
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662847; cv=none; b=q12iJCc9zNXriGnmoXP3aYi7Vbsfpu7y7r6R6XaY+7ssrWkVzHlSQ7vmkyC8mD6noD96bmR8HiVjFG9cO4kO/vYdq9bQqMREacSR+uafpvooIgXE+E/cX5X9PngKQSC/N53pxEFO4VgtlZXQ026g6T6o/TxhnKh+YiPRzScWpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662847; c=relaxed/simple;
	bh=sznzWvADSxv5gT3bdNf+J5HkQ99FMZVie8Ud8XW/aM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cHqz8qhjro3SyUhFgQNcOr6BSM2Yjfu3aVN8IJoUknrB6bUIsAcXWIkin/GetOX6XhgRoXk7EX0MF27+EO19w57OgRIE1NRXPfCprLHSDAmAspVo95aZG9bf9ozZqYb0GboBnC0VRbpWuyoHGkaLV9uFcpsHAswhuAg1VXVO00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLzzehx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLzzehx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8901F000E9;
	Tue, 21 Jul 2026 19:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662846;
	bh=V2NZbmYY/LRF+mQs7I/ehwqFeBVsl2fSZE/PaML5xXI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LLzzehx9Wkti++EdX96xSLuhHlvvc4W/9NfrZ7cF8nqkpehgUuEXJ111L8kGeBzj/
	 7cXD03/qsnMjs8jxX/tjK5HBatlmLJF0qvJriLGUZTl9SWlOde6QSN08uBEvT1g3W1
	 /l8DfgEGfbBH3wuPPUY4UdZJ/1v2v35rGbZ2vAbcjw8T/ljxq+tsMAT1Y0mep8SApc
	 1L6Egszk4x5hcZblTwEp3mXudrrCt+2Vd0mWXmwC8oT635fk+JMN5Vtnhc3fr047gJ
	 yvXwOi1XKTlGChDH2tStl8Zz8ZTGDnAHpxMK0mj9dkLveNVKXN8m/zTpzySxvl8Fzo
	 jK44hyZieAmpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A0339253FD;
	Tue, 21 Jul 2026 19:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mailmap: fix wrong canonical name for mgr@kernel.org
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466281588.1001510.16225654709028602176.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:40:15 +0000
References: <20260713-mailmap-v1-1-cb40979cb190@kernel.org>
In-Reply-To: <20260713-mailmap-v1-1-cb40979cb190@kernel.org>
To: Michael Grzeschik <mgr@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jul 2026 00:51:03 +0200 you wrote:
> After picking up some pending patches for the kernel to work on, I
> realized my name in the mailmap file somehow got mixed up. When
> switching to my kernel.org Address some time ago, I had never the
> intention to use a scrambled variant of Polish and German used for my
> first name to be found in this file. However, so here we are. Lets fix
> it for good.
> 
> [...]

Here is the summary with links:
  - mailmap: fix wrong canonical name for mgr@kernel.org
    https://git.kernel.org/netdev/net/c/defd52c1eab2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


