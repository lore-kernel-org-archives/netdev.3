Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13E3E9C0D;
	Thu, 25 Jun 2026 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404459; cv=none; b=YWaKILpD6TEd/iA+swy81JyXFXA1h9AJf4g8kGRpMih0xzxn5qaS54Rh8ncV52TDFchhHd7ZCF0I2/FL17AAy+Wa9DDm7rdZyWxFCuaWL3rQSSEGxrNVl+xxXSHML3ml1SWpnoj/iWhNkSzAtyvP18mZBcDaoUrIoQ1+7JlWx1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404459; c=relaxed/simple;
	bh=PyA4plxj583nZMg8ywn3b/6u1umbzejsqv5xdNWZYyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ImM18JA6WR0IqY4dmBt9aM9P84Y37kP+kq59WeECKPpZTZkhPQ5i+QCyJ7V20Lz6d9YiO+YzE50qMWqaUuSM2GUWEdViikP2WTwxHmyks7euIz99OMnCkSX+aF3T85CqW99KGYgKp28ptkBBLQvuXrtbukUS5EeV0acvAxiC9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQij92u3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQij92u3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1F51F000E9;
	Thu, 25 Jun 2026 16:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404458;
	bh=YnOEdrhE8PbeI5c0ZTwijZlZ0s9gdc7IcvrR/PDp1gw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VQij92u3t6jsWuhCsPSKXS3FIamMztGsI3QFMXwVVReQw7EQXLpQm1evV+nNmgL8z
	 JHny3O01YuVyBZIE+yRUmeaqSBwdDNSEyjYS4kb1t59clEoRA8WN43hSRlDzuIWzJQ
	 IHaxfrRnebK5G9Vfe1M7tFCD6sWWSCI/RPmUO+u8iVqWdSxwVLMJQBSOmxxZwWwo+L
	 RayGTdbmrR489w8YM4lj2H9ZhT4ps6Q7VqVduAV+/nBWMZc238jM79VEwppzc8Uy2m
	 f3EqA/+7h9BGzq8D6goQRPrPK7qmKaLXvz5GvNUNTSXASw7VXrUqGSmCKP9JA9pEtQ
	 xpcnC1NSX3DOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569303AD449A;
	Thu, 25 Jun 2026 16:20:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/4] net: hns3: fix configuration deadlocks and
 refactor link setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240444587.3803792.3747401243392694669.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:45 +0000
References: <20260624141319.271439-1-shaojijie@huawei.com>
In-Reply-To: <20260624141319.271439-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 22:13:15 +0800 you wrote:
> This patch series addresses a sequence of link configuration deadlocks
> and parameter contamination issues in the hns3 network driver, which
> typically occur during hardware resets or driver initialization under
> specific user-configured scenarios.
> 
> The bugs root from asynchronous discrepancies between the MAC state
> machine and cached user requests during sudden hardware resets, leading
> to invalid parameter combos or frozen registers.
> 
> [...]

Here is the summary with links:
  - [V2,net,1/4] net: hns3: unify copper port ksettings configuration path
    https://git.kernel.org/netdev/net/c/d77e98f8b2b3
  - [V2,net,2/4] net: hns3: refactor MAC autoneg and speed configuration
    https://git.kernel.org/netdev/net/c/c01f6e6bdc1c
  - [V2,net,3/4] net: hns3: fix permanent link down deadlock after reset
    https://git.kernel.org/netdev/net/c/c711f6d1cee9
  - [V2,net,4/4] net: hns3: differentiate autoneg default values between copper and fiber
    https://git.kernel.org/netdev/net/c/d9d349c4e8a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


