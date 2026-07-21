Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C9417BEE;
	Tue, 21 Jul 2026 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660496; cv=none; b=jEeuENsgRpJhV8fJOOLcijAPlZR+Q33eE2dtlFtWnoHiASwFBXFjHHi5fUlYmEpUYRfA+LV2nTXRVY1KyQ3ApcPq7q1pebuKjdtark1BbHPo0+3gIb/ZGv84Zl4HwMDjTqUhuT+GpEC1+j3DSmESfN/dm3daIDEPvqeeQJq4Ebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660496; c=relaxed/simple;
	bh=CW5+0EzLmUxsSBWYXEC3e+1nr8R6aL0/zmtAWzmyLdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ub7tgPOOg+WPEvPPvRk3j7VM77ZQ2B2XDmtdylGY6OR40p9bKjt3VrJoovjbl8HpN+MkVgtNsaJ/OoQDLV8x0ZS0tIla1yoNNDZZQhmldq1gD2fkwfxAnHvByAQYUJp/2gzQ4xNJuu5RuIFD/KGAzqxWbrbCzu5QEpoRO9IPhrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFU0CSn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFU0CSn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1021F0155E;
	Tue, 21 Jul 2026 19:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660454;
	bh=bQSABD/2rJ6W7C3c6D6E6WjIjrxlZdBoBTjyEkJr59E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dFU0CSn4R5T9SyAgmo4I2ncaDWdKFxMZaB2b/B2j49MriRqp0jGSYXnOf6tch0+2g
	 diz2fccrB8zOqOps7i2MygivYfJWI7bZwYALnNRKNtI6OVO3UP5Hbr2LfHSo1b+Ga8
	 RVPBMlH0YGZvX9ub6o9ut+zB/NyO3CecaqTfZrJEQemhBIF+7dPik1oPVmX2sh887A
	 JicIU004upSpFpNyVUv5RTK/42eBE3etqpJ5vEM5e2yDHoW/x/2FdijbmR1jSDANFM
	 djPMgM43bLBbff7A+rCELxIFzdUx7w85pjAfxVfgl9l4vy0jyrJG3/u+u+V5HbhVxy
	 8SEl8++YDQeww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197EB39253F6;
	Tue, 21 Jul 2026 19:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 0/3] net: fix stale TX skb pointers on DMA map
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466042363.954483.3439100889511482165.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:00:23 +0000
References: <20260710090527.58354-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260710090527.58354-1-xuanqiang.luo@linux.dev>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, luoxuanqiang@kylinos.cn, rmody@marvell.com,
 skalluru@marvell.com, GR-Linux-NIC-Dev@marvell.com, gongfan1@huawei.com,
 guoxin09@huawei.com, gur.stavi@huawei.com, shaojijie@huawei.com,
 shenjian15@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ivecera@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Jul 2026 17:05:21 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> While I was backporting commit 1a303baa715e6 ("ice: fix double-free of
> tx_buf skb"), an AI-assisted scan identified several suspected TX error
> paths. I reviewed the results and found this issue in the three drivers
> fixed here.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/3] bna: fix use-after-free on DMA mapping failure
    https://git.kernel.org/netdev/net-next/c/be9381d5776c
  - [net,v1,2/3] hinic3: fix use-after-free on DMA mapping failure
    https://git.kernel.org/netdev/net-next/c/dd5de39af5ef
  - [net,v1,3/3] net: hibmcge: fix double-free of tx skb on DMA mapping failure
    https://git.kernel.org/netdev/net-next/c/569595dc92e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


