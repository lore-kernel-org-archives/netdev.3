Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27B2C11C6;
	Wed, 21 Jan 2026 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965021; cv=none; b=VBxG52tbWqH30tMTI/DzOkgegNUW+3xYpIwkOskFkGEqrm3ybPVxy9uQHwNUYlulDMdlObORa6Q1JJOnjv9YhSpSXhPdcIfmsEkkjvTlBfMdKOSzosSbywDDK+OHw/JitQPoUP7JnVY3FYxp2D41O55mnqbNCZYI0rBPNearDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965021; c=relaxed/simple;
	bh=f7AydYBx4SPiHo1koUuT3OwlbucmmijlbV0mjURGmn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Chm6ITFzLKERjNOftPMjhFe8VssIBrNDjFinjBWaKdns70M/BFpw1kgz5el4z+AOhjjkXsRsFIrQ6QBjHtuLGSja+ODHpodJOr9I1l5scLmPoxTIQRcTDTYi49jHAvZsKypL9y2FcUeOsZudn4a5+LA5Nmx3pC2LwnGi8HeI3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s56GyUwn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s56GyUwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2312C16AAE;
	Wed, 21 Jan 2026 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768965021;
	bh=f7AydYBx4SPiHo1koUuT3OwlbucmmijlbV0mjURGmn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s56GyUwndFUELgFCMLXlVTAHfXfjADF2aoI5CMv+CeIDHy0ThpJv39VhmwxfYLRbi
	 wBbXXza/q3+rkwZvrxwiiHmsg0mB9wG5VlrxRMDkGoYyMFicE4w5yURGIbXTUSt718
	 eWoiQL0ENIL0RCPtdRaiChu6qVrNK2PZzhTQ4FoPdLKK0r8V57A49MzzhahY10HL50
	 mPaF7dz7BepamQLiIeK3Pt2PSQYGLutYpau/KYQTFS+fBNWcWQEHF6xS1kz1YtKxFN
	 l7hPRF4BhmxWBwCkTwAxNToBBy8RnoHJgy6YY1vU3u+zPMLifXCN7Uz2Dchc8S1Thh
	 8o7eWK9Pd+UxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BEBF380820D;
	Wed, 21 Jan 2026 03:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] Fix typos in network driver code comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896501809.707355.13836126888255208430.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 03:10:18 +0000
References: <20260118121001.136806-1-yiconghui@gmail.com>
In-Reply-To: <20260118121001.136806-1-yiconghui@gmail.com>
To: Yicong Hui <yiconghui@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Jan 2026 12:09:58 +0000 you wrote:
> Fix various minor typos and mispellings in 3 different driver
> subdirectories in drivers/net/ethernet
> 
> ---
> v2:
> * Separate patch into patch-set of 3 separated by subdirectory
> * Fix all typos in the subdirectory rather than just "Software"
> * Sent to net-next rather than net
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net/benet: Fix typos in driver code comments
    https://git.kernel.org/netdev/net-next/c/1cbc1fe0a434
  - [net-next,v2,2/3] net/micrel: Fix typos in micrel driver code comments
    https://git.kernel.org/netdev/net-next/c/c2b733da93bf
  - [net-next,v2,3/3] net/xen-netback: Fix mispelling of "Software" as "Softare"
    https://git.kernel.org/netdev/net-next/c/f117205ad70b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


