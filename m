Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA839C637;
	Sat,  1 Aug 2026 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785547244; cv=none; b=PUcA1KvAJvKLyWeXa0ga50dSFeEymOuOFcac9mpyjuFMvEVM2gOkbAYJrUkp6sYB5+c276S49LiURMn8leiXGCrMZDj8OS1ZLKVlpY4vSqOPJB9u0eBZr5yofi7BV6M57G0F+0XuUwvNZE4geMn9xmEJIkM3OhXQs33n6cki260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785547244; c=relaxed/simple;
	bh=YPvrBJ5VSZQCEUUjbTfi5LTypgpCEtW6gU+tU5nqVuw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AycWHA5cb5ABGoMbURe3OqnJvo3xDBjD8j0kznmiIEp2NCwUr+JJibk8QJ4jr4hUJqmSketnCg12RSrZd9pzv+EPSlMC5TkP1zMWy/eJD0VDt+d24yjJVii7iaVf2R4DnjvQRvsrzz1c3c0vxil/xO5SnBtjW2It1FFq/ISm82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fECt2sos; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fECt2sos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB931F00AC4;
	Sat,  1 Aug 2026 01:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785547243;
	bh=d11fSQEQFogtbzH0dmaqaPYRbYKHXc6Q3i3u7oYGjQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fECt2sosmh4ROO2Y3BCXYZoDpX0xI8UZNkT6YV36P5JBWW5WV8SbdMnGbqLaaQp0U
	 HFQpJ/uG/+19atkhItiKzag5ettNT9lNpfb7U2ZOkf4JqdD3zhYIBSBOMLG63zCtkr
	 U+g4Vv8o3zmKFaUBAXKat98qulyaXWzdzOiv8Bm8olCu84zKQZDP4QVRkn7Z0iT252
	 4IVSd0insGXNhEzwAKdddUreRJ6iFvrG6iYUGG6z5WfKv1IEZzd1/tuLUusvXplV4Y
	 /RQVq7UqcvBHbbPdq1D7i2HR5zWoxjTilN//PO/Z/zC8Rpkl4icgsKNLl1UnjLPTAs
	 QLw4RtrgE/JNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C51392665F;
	Sat,  1 Aug 2026 01:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: hisilicon: hix5hd2_gmac: remove redundant
 NAPI
 delete
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178554720539.976178.2093637779745787216.git-patchwork-notify@kernel.org>
Date: Sat, 01 Aug 2026 01:20:05 +0000
References: <tencent_5FFD37A252B4FEA6A80AD25B17C8E904F005@qq.com>
In-Reply-To: <tencent_5FFD37A252B4FEA6A80AD25B17C8E904F005@qq.com>
To: Jiawen Liu <1298662399@qq.com>
Cc: shenjian15@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Jul 2026 12:17:10 +0400 you wrote:
> hix5hd2_dev_remove() calls netif_napi_del() before unregister_netdev().
> This is not needed because unregister_netdev() deletes all NAPI instances
> attached to the net_device.
> 
> Remove the redundant call and let the networking core tear down the NAPI
> instance during unregister_netdev(). The probe error path still keeps its
> explicit netif_napi_del(), because the device has not been registered
> there.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: hisilicon: hix5hd2_gmac: remove redundant NAPI delete
    https://git.kernel.org/netdev/net/c/f307a7dc3209

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


