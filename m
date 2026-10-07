Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0558296BAF;
	Wed,  7 Oct 2026 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791333614; cv=none; b=I/OUCb7FkZ/oN9+b1EtPqKaMsEgfeelfPCinQPGhmVi42ogVLOYr/4dsIAore6/gVdf5mNFdZUMjoJgOriQiBjEojb7jjdlNJIvPHTp4PyKSwRX223+IXhbRnuwqC6+mmOLayGo0ecajAvOzOckBFaow73xEMpHwLHMsDgN5wy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791333614; c=relaxed/simple;
	bh=eKf9xsbTDbWvaU4egHpIPhvP0YzQX3RKRMqad0ZCFZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I0oPE1on4eR8NQRTUpoM4toUDAMT1ga6V7/7qeBse+FQrA7oESuzwp7w6WbXDVL10A5+cMFoGGx5r1WoXdpNUVNpm82WCXijxChY0bFOsYShPXQEPJt8+L+rfUZ9UOwAGNtZQED6RJWWzUWLHTBQiPNa4K2XvOy9ZEbHVzL9Bz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBRLO4HW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBRLO4HW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065881F0089B;
	Wed,  7 Oct 2026 00:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791333613;
	bh=uIfI3EKVVS67AtbGylghRcmwN8dPTKMq9dbk+JnPzKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oBRLO4HWyP+G/cTB5p0l5szM6S+g5n4e04Z4h0WXYoxB5d43mcXooBAG6vu2xhUTt
	 o/fa9eAtYciyvcE97+WuoZY4PA1YOsEPfzMzvfRiCldHnnqZaRqdzp4eFKWBnFfWJK
	 HKiG/RkQBfre5rWrIKFQ4VmJfD4uTGHE+777gV2OBsV1x1dxHeGzBQbuWkU3FFTXr7
	 se3teq9/X5EOAXk5oc1aKaI/xvh+2B87mn+5E8MSBXvXTW1mtAy7S1dhfWhV14B/9/
	 UN1QgS2PH5cT45XZkJlIjH7RzrOMwkmMnHfK/dCqoTV3b1e5R6BX+7tXoTQ+4QYd8M
	 fdAhmkB3ElgZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13AB3806541;
	Wed,  7 Oct 2026 00:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: devmem: use page_pool_put_netmem_bulk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133361153.2844451.4477572064762956408.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 00:40:11 +0000
References: <20261001224054.1525365-1-kaifengw@google.com>
In-Reply-To: <20261001224054.1525365-1-kaifengw@google.com>
To: Kaifeng Wang <kaifengw@google.com>
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com,
 kuniyu@google.com, pabeni@redhat.com, willemb@google.com,
 davem@davemloft.net, kuba@kernel.org, horms@kernel.org, sdf@fomichev.me,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 22:40:54 +0000 you wrote:
> Instead of looping over napi_pp_put_page() and repeatedly acquiring the
> page_pool producer lock in sock_devmem_dontneed(), use
> page_pool_put_netmem_bulk() to return the netmem references in batches.
> 
> This reduces the number of lock acquisitions on the page pool ring
> producer lock when releasing user tokens.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: devmem: use page_pool_put_netmem_bulk
    https://git.kernel.org/netdev/net-next/c/388e1d3a179f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


