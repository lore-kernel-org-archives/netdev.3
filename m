Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43436242D83;
	Sun, 25 Jan 2026 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769382612; cv=none; b=MO0+j9RSeayCSjhSjYZEeoZbFwZWz0dam+96cdXoX6AZhdQsvr0v3VtuaoZfowEI7FETfx5ebYVeZUkjvvGafa7q4jbH+fMB+PKRQzc130Ul6yme9vvYng79eOCrg4cuLJE5fJdzUTa8fWWJUJEFIwITs+qW2+phOQ2Go9FuujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769382612; c=relaxed/simple;
	bh=usF3GVlsQ2xPlcq+cwwpyed+pOlcIXjwHXsB3hM2QFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=drLybiZ3sW8AXJ1CigUayU1fih3VTnnXS5UMs0l/AFAvoAICGUfbBfF0QBeZL8CIBHPRQZjYlZs0E88bXmnPydUwBemWgj60RXv12yXXjKUdntcW2oWQZe/pihyia7Dxwe367Y72+REgVuRFKytKWkT9lPDI8VPmRwjui3OVRlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq/zd6Hx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq/zd6Hx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ABFC4CEF1;
	Sun, 25 Jan 2026 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769382611;
	bh=usF3GVlsQ2xPlcq+cwwpyed+pOlcIXjwHXsB3hM2QFE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pq/zd6Hx8XN4VHUyCExaNqECvqq5xI+o6Esg5XnlTuy0FVuhcBpXqJ6PxY2X5ky+Y
	 /BjZYkPgppbJLSyFv9oL3QcjO13sJm54cZUfMHL06T/O2UafkVfs5XzlUZQAuc2rRL
	 tqcnq229dRPn3i0qOVsIaiEbP+XdjhN3IuyaqtYQKAF3ahxNfuhTY73+LMzU+xocPu
	 1jSY+08JBWHvlPLNLVcglVMY848hbhw3OQZB3XGb3HdibXdoxwtsvjcNhpkGW21LQ9
	 RInoJSkAtfVANxHpLygqQmwBZi04bhNB64OseYSIK3EVOZtxFI0KDpLs8H6gJnegjl
	 JzC3fJBvmjgfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D983809A15;
	Sun, 25 Jan 2026 23:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: sr9700: use ETH_ALEN instead of magic
 number
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176938260661.4008633.3333016632246304761.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 23:10:06 +0000
References: <20260123070645.56434-1-enelsonmoore@gmail.com>
In-Reply-To: <20260123070645.56434-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 peter@korsgaard.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 23:06:39 -0800 you wrote:
> The driver hardcodes the number 6 as the number of bytes to write to
> the SR_PAR register, which stores the MAC address. Use ETH_ALEN instead
> to make the code clearer.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/usb/sr9700.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: usb: sr9700: use ETH_ALEN instead of magic number
    https://git.kernel.org/netdev/net-next/c/c2e99887807e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


