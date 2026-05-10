Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4E3B2FFC;
	Sun, 10 May 2026 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433070; cv=none; b=dZDZf0VCxK8F/zkizUmvUfiPllI7bx5QLUESno/thV9MrgjcJJoCC1qJzqvKz92Akb69Sds8eWl9LhLcs4dY2I/QYbSwEwjwnKaD0wB9eQmySaUpISryUpbpJq4TpYhDmes3pRUwmLIkioqnxjtK0xrDZgs0uO7AJ3SZk1v57Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433070; c=relaxed/simple;
	bh=LiXGg0EKChiwOfBnX7fyaxwtABxyYODIVhCgk32lz4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ifCH6h0q+aydOU8+YckuNYCl1bNXyXssp/SLmQq3x4Q6TBwGe7C8N3II+7V79H9s0j+9U1V3yKpRLZri2gedimFJ4nFAoXvcdqfKla24C3PX3Jo3NeahFOpGpc6rP9ZMkfrVXVF45gcfHT9q/n2860+aulP/QeuzhEfV24eZvSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdJrsmE2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdJrsmE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ECAC2BCB8;
	Sun, 10 May 2026 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778433070;
	bh=LiXGg0EKChiwOfBnX7fyaxwtABxyYODIVhCgk32lz4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PdJrsmE27cpr6Hs73KrnsDijKIYuuOoGUxojAXE8cl1vUl8QyVu4UDhbAZu3b2Xe3
	 z7Oq0/iSu5hoB739dR4PkygS2FJkhKQ2U2+2I8ry4BJHSFZTab3daMicnLG2AzgHQ9
	 jeM1fdohL46F/9smD9bRFoKpN9HWN2W7mGy+iwWhKlsMHrV0WZZmWg6iVtuBRMHUpd
	 BlY3ztsx85j2MKAEnhofFQ4JwQum6nCMkWxJqGMo2ynE6+gbMCbbMU8nbFRN4s8fta
	 Kl0vuCR6yVkRFm89qM2khM5pkZcT3pXhAxhDa1pZXMFjrFsOQ+fyGBHv9PM5pBRnpS
	 3aYCTmuk/da2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD32393001F;
	Sun, 10 May 2026 17:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ena: PHC: Fix potential use-after-free in
 get_timestamp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177843301804.1434286.13092957038989655883.git-patchwork-notify@kernel.org>
Date: Sun, 10 May 2026 17:10:18 +0000
References: <20260508062126.7273-1-akiyano@amazon.com>
In-Reply-To: <20260508062126.7273-1-akiyano@amazon.com>
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, edumazet@google.com, pabeni@redhat.com,
 dwmw2@infradead.org, tglx@linutronix.de, mlichvar@redhat.com,
 andrew+netdev@lunn.ch, guwen@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
 dwmw@amazon.com, ysarna@amazon.com, zorik@amazon.com, matua@amazon.com,
 saeedb@amazon.com, msw@amazon.com, aliguori@amazon.com, nafea@amazon.com,
 evgenys@amazon.com, netanel@amazon.com, alisaidi@amazon.com, benh@amazon.com,
 ndagan@amazon.com, darinzon@amazon.com, evostrov@amazon.com,
 ofirt@amazon.com, amitbern@amazon.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 8 May 2026 06:21:21 +0000 you wrote:
> Move the phc->active check and resp pointer assignment to after
> acquiring the spinlock. Previously, phc->active was checked without
> holding the lock, and resp was cached from ena_dev->phc.virt_addr
> before the lock was acquired.
> 
> If ena_com_phc_destroy() runs between the lockless active check and
> the lock acquisition, it sets active=false, releases the lock, frees
> the DMA memory, and sets virt_addr=NULL. The get_timestamp path would
> then read a NULL virt_addr and dereference it.
> 
> [...]

Here is the summary with links:
  - [net] net: ena: PHC: Fix potential use-after-free in get_timestamp
    https://git.kernel.org/netdev/net/c/e42c755582f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


