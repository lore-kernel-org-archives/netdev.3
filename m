Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9EF36F90D;
	Thu, 24 Sep 2026 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217089; cv=none; b=uC10sJKDMj2XfM1LS3r2mul3Tvv3phZYH4wH1m2ehh+uA45D+bZVmPOZpAZFzv6ffkFyLWz/CTUNT33hsnITkWFICqs6kFncrFVGEN5OCFBtwQnzfrWUBbXleYjahF8bO+HNWsZtcUTCgaJmFYCadp4dtxhSAEsISB1AMMLqxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217089; c=relaxed/simple;
	bh=EXHg4ommNVcSZh3J/iZL3YSAAq4htTlH6shAdGdTJvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W/2WoelOYb0Kqv/G92n1QgMP5O3BjH697eTmP5ECoS5P4NG/T3hi6OFHRFRglmT63Dq2R2spniPXMI6Pn7Jh2PXONJMYTPE/AmrIuDg3nNRsuZZ0F+kvD6xu0ZE9FTFTWzwgo2a9JjwesRq5zP3kRQTsbFqLP6q2eOQk8PMwWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPxZd5Yh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPxZd5Yh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF681F000FF;
	Thu, 24 Sep 2026 02:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790217087;
	bh=55GGryoCDMP4Y7cSWD2RtdYrDJviw1dhfO7sG5gq2vc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UPxZd5YhKbXUm/KYaZaFe0I038I6oI9oxfmA5NoJ+K3ckCAMa8sheVmvGOucZu8F7
	 x/zUOCRLhL972cHlu5PsPNWbl/ScdbTpuSelq+F49IxrBa7JRyKDq+xI3pd4nkaHCz
	 IWwWz/cxJeMfkYva+ctygsfA+re86G3OZghKrBynGc1yP/PHSRh48cbsRtPLZMwQvA
	 YQyGW9a1FH9ul5b7vm3Nv6dwOOy4CPuySl44hKbTWsc5I+r4jxiFlDohJYofGXlJSt
	 Ek7ohipvZXC7NfeWUnIhjjsa8cSmFY++2VlLCOUibM5YbpXuCioRo4DT9mxAHXQ1/c
	 4MIw65Hu9mWHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569DD39E9611;
	Thu, 24 Sep 2026 02:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ip_gre: Reject enabling collect metadata through
 changelink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021701687.1285615.13328439472257551280.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:30:16 +0000
References: <20260921031859.9283-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260921031859.9283-1-xuanqiang.luo@linux.dev>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, tgraf@suug.ch, pshelar@nicira.com,
 linux-kernel@vger.kernel.org, luoxuanqiang@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 11:18:59 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> ipgre_netlink_parms() can enable collect_md on an existing GRE, GRETAP
> or ERSPAN device. Unlike newlink, changelink does not enforce metadata
> tunnel uniqueness. Converting a non-metadata device can therefore
> replace the metadata receive entry for another device of the same type
> in the same netns. Deleting either device then clears the shared entry,
> breaking metadata receive lookup for the surviving device.
> 
> [...]

Here is the summary with links:
  - [net,v2] ip_gre: Reject enabling collect metadata through changelink
    https://git.kernel.org/netdev/net/c/a3f315be9d30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


