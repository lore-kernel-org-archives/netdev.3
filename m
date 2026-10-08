Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025313A640C;
	Thu,  8 Oct 2026 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426615; cv=none; b=QeKq32Yz20u0wzYDN6a0I2wiMqPyvb02pHTrhkm3c2+wnAxkJN7ZqAzOH3efqE9zo4YKGnurcHrRIWvR+f+HM+N9dm1r4hnsgk0Le+vdJiqMsWIv/SA5g3kkQ+wadtkIwujFFfqcQUt/pQI7/+cOicMorS0zYImhNrYwIwMmIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426615; c=relaxed/simple;
	bh=UG65C4IDU3VlyKRnlkmfRa2dC5KPK4ySDU3A8ry9JDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uiHeRx+po1lWwD7dm0VYf+yIs9u5VeUFhkv5KNpSRqmLF3ixTtoZZnJ8G8BdkszfMg6X/uP1qLKNbwqqrdUbQwK1G31bhTgVCeTGK1PTiyP2+xbVQvQxBQJzOGE+U+OKWcskI5KY9PO4IFYDDJrO8g4rxTMAsDQPfps3sFBKAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8asDnF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8asDnF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422101F000FF;
	Thu,  8 Oct 2026 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791426612;
	bh=UjBPjN42LTuc2WEP64HAaVsRMJ76g1tba9cFhSCdN0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T8asDnF9D50sVRcdaKdXWqSl1r2ki1Td1LLloAIzTnWiAEeNPXp71nCtOSUmmv13/
	 uOYljS6uRrYwKFBDtD+RbYtEmcTvuCd5iGnoh/s0KSWLBmVTTkOtQLVRWIh9k6TvGo
	 exh2tb5FKLCWPrH/HWo7S6y9gKH9rcMHSjOhtYtmZ9CmBeEMa7akFdS3FnR+o3lOHd
	 wG7Egg0NP9VPp5SNpKatZkT05wb6QZuHIwW+ZAO6VDUvaq37pf/3p/p442GIgcRvoM
	 OoD+g3466fIGGqDesJsxp3aaBqAtZ7zj+uYiKwxPaRjohQ5s2kKyapaPDgL1WXgbSy
	 shIBrMRQzB43A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A27C3809A09;
	Thu,  8 Oct 2026 02:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: sierra_net: reject short firmware attribute
 reads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179142661078.3776717.16561807411140979685.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 02:30:10 +0000
References: <20261005155920.27735-1-xinsheng.zhu.ny@gmail.com>
In-Reply-To: <20261005155920.27735-1-xinsheng.zhu.ny@gmail.com>
To: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 rfiler@sierrawireless.com, epasheva@sierrawireless.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 11:59:20 -0400 you wrote:
> sierra_net_get_fw_attr() only checks usbnet_read_cmd() for negative
> return values before converting attrdata and storing it in *datap.
> A zero-length or one-byte response leaves attrdata wholly or partially
> uninitialized.
> 
> Although sierra_net_bind() rejects responses of unexpected length, its
> dev_dbg() call uses fwattr before that check. When the debug message is
> enabled, the incomplete value may therefore be used in the debug output.
> 
> [...]

Here is the summary with links:
  - [net] net: usb: sierra_net: reject short firmware attribute reads
    https://git.kernel.org/netdev/net-next/c/8df0638138d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


