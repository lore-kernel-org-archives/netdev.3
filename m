Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94221DB13A;
	Thu,  6 Aug 2026 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785981648; cv=none; b=Gsplv5xWbzCeDVHXxHBQJqtRtI5Wjf9EGAjJhFfHAdFvd1nOx1e81j3xtTSEqc3On959FrFuIjSLH4AsP9POpFuojNSrzXvyFWXoMJZteAUhcfFktyV+NQR0tX6at+4LGviKv1stJV0HIcLeMckP/u8U73c5Uyw4d2oyMET/j0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785981648; c=relaxed/simple;
	bh=LM0t99cssIWfzcWFPeFgwd8kqgSUNsujrhKSoXQTrWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OjDfdOdgM3Gyr/m2MzuE8bXCcc4VuSUWR5houmE6dyNNORlOi1SFruPfG/OrvfRTl7SjSPbzAaqSkDBdDUJNKXp9ADuGJaHAukK9Iz0bKfw9HCm3+T741y2iWlzrWsRteIYevb/HrU2oTVkZeGInmQk/Lp7/pt4HtbzdsrfieYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB2o86Kf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB2o86Kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377B51F000E9;
	Thu,  6 Aug 2026 02:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785981647;
	bh=yCUbiY2CWjoVPpcrkTaZNjYNk+r/aktmTyecImUtKOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EB2o86KfBfBqOtK86+fLPUWelAx3ll3riQx1T2K1CZVVNlSOqvjpGHodaCWe3Bn6K
	 MV6uVSJrBd2i7zVBPkKLsD7e2fcTDlOW35zYwbxay+tJYne7mOwwen/Z11Y1nGVTif
	 C6vc9jfDZ0gXQ+kOwSTnWRGD/uWPE3Nm701j6YUlBZ/WaVcjXtNrGgYSKBCrKdQFTh
	 CR0/qOQQtdLIA3KgQmfCmyqLweImBT7j2MkjETGmxw905Y9SBUYu9yyTzSokAC4BCG
	 ZWKUx6A8m0lwonZuSpdIAHBCF0OiGtlJYJb3TkOFp0n96OaiaBy7BR5Yi+uiulQjCC
	 5r3xSQ4InRFcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1982B392FFF5;
	Thu,  6 Aug 2026 02:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add myself as a maintainer for Hisilicon
 Network Subsystem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178598160676.605015.9744952869209495856.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 02:00:06 +0000
References: <20260804130554.871716-1-shaojijie@huawei.com>
In-Reply-To: <20260804130554.871716-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 yangshuaisong@h-partners.com, ningwei15@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Aug 2026 21:05:54 +0800 you wrote:
> I am already listed as a maintainer for the HNS3 and HIBMCGE drivers,
> but not for the broader Hisilicon Network Subsystem entry, whose file
> pattern covers drivers/net/ethernet/hisilicon/ (e.g. the legacy hns
> driver). As a result, patches to those files are not CC'd to me.
> 
> Add myself alongside Jian Shen to help maintain these legacy Hisilicon
> ethernet drivers and ensure patches in this tree are routed to me.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add myself as a maintainer for Hisilicon Network Subsystem
    https://git.kernel.org/netdev/net/c/44871eadd07a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


