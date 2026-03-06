Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DED338593;
	Fri,  6 Mar 2026 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832023; cv=none; b=If7Olnj7a6YXupyOub4uQH8gMEQWUrPZ+hVya8aA7Ig+3+yljsinUd7ZHEQhqcYQhUhaGN2xmxbP+WYtfb+VtbjsetAjHvOB0LSIT7nge6cEnoB6NTRcl3IvG2kcsZPzfxZ5awTGJ2ckddC2ajtUFwjpgQCHcBvHXvMfJW1dDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832023; c=relaxed/simple;
	bh=GZ/ygIcwWtxKFPVtGSauyZHiwaOCKHQp9L15wr76PXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SsQqzjV3Q6d0TJr4VNIMCBOIn2n36nz4iE21GEPtd8eGQkeBBrboCNsaDq/hyFBx9IZLmd11f2shVPmZ0g2YGHqO3tqwvlzMSid3qmFyTfiBUQW2BfPIp9t/WnDqWDQCTfGDV6ejIuua2i5pizGjP+4uG5yH6YpUXvNLye0m9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfwUlWir; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfwUlWir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E2BC4CEF7;
	Fri,  6 Mar 2026 21:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772832022;
	bh=GZ/ygIcwWtxKFPVtGSauyZHiwaOCKHQp9L15wr76PXc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gfwUlWirFaRa4Tq4U0uIxAcUdhmEO9I4b3vfV+90XByE4gVFiqh/vdHFwKMNqmFLu
	 SHwwJfj8V+bnyhyBnGLIYgeEjlGaM36zEguGXJVIZmxWrDLCbnjbYVhH15lVu17ufW
	 UaXq/RSSD+tkT74MDH8sPgyj+63iuWa53ywW2I7/RYcAT/u/UkA3zJy81pOUDEUvF0
	 oV2tRpx/jMZo7Q6LgMRnQpGmOzmbDWIuBv1V/x1C1F39EdGiUPykX03AqVqzmtA2XT
	 qppfAJlK1re89MFlSHCoANB8VAvon7EGwF7/hDMwE1yhXbTNorQGD0xwL8KrShglXs
	 EPB+MFLtTb82Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE0F3808200;
	Fri,  6 Mar 2026 21:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: netdev: refine netdevsim testing guidance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177283202179.56009.42532879715986545.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 21:20:21 +0000
References: <20260304151647.2770466-1-kuba@kernel.org>
In-Reply-To: <20260304151647.2770466-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 07:16:46 -0800 you wrote:
> The library to create tests for both NIC HW and netdevsim has existed
> for almost a year. netdevsim-only tests we get increasingly feel like
> a waste, we should try to write tests that work both on netdevsim and
> real HW. Refine the guidance accordingly.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] docs: netdev: refine netdevsim testing guidance
    https://git.kernel.org/netdev/net-next/c/8e235bc43326

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


