Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48A2D46B4
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772162405; cv=none; b=Hk/yjnHIirP/nZHPq/az4X5yDLGehzAi68tsks7R75bodGvCYosEizURLw4vgIyQgiso7XaAOxJ4KoNJaCFhcLdbrK3Xh05bcVOSksrJGOTKd1E+/3Yz1nwuYH7uJGIucpfCRjLhxWhmrTCtcMd50lc0K5poaKhOXgwUGahHwnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772162405; c=relaxed/simple;
	bh=3TKR4mkUshu0Q7D1XLUOqgK4XYIj3IXI0PcMxnAbXt0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QsrxX6NrwOtFyQl2f9oquQ7Fp0CI2zuoLu1UYTDIAw6akO88wARQ8NrzbubMgv+U41Ok5dM62AelzzsPSklMneaINZgyT+zBiIufuzRayobQM5/2HNUeV62Opji1lclSsqZoniLkJ8wBKAU6vbBUJ7nMaUFyzAHfD+yT+sCoQL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+dG+KII; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+dG+KII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A27FC19423;
	Fri, 27 Feb 2026 03:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772162405;
	bh=3TKR4mkUshu0Q7D1XLUOqgK4XYIj3IXI0PcMxnAbXt0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b+dG+KII/DWwhr3Rs7axWTf5jVhpejIoKm06c6WThhI9d1Rlggx+ygxkYPUhf1AWg
	 1gmTIkx5jQlSOopQdmMTEU9+RX6pja0UXebu7lgn3UjgjRW+bK5gztzr1sKLeewT4l
	 Qf4UT9PLBx1lWx5Yldpxgm2bCYbZHug53GBFi9Ai+hrRyTpFLPho1j2sOn7MX7OjW+
	 B5aaj8RV//VzFsvbi8vMO60uvJOqIbtdYST5BvCGrYyeFeL53rD42YUhdMphm79g+g
	 csQG0HikV7gvG9D3Kc70NHx90ti4SYlUOojkFBxZTnxHo/ichya4hs544nmf9uqq+w
	 /wthjBXqGvUGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE20393109B;
	Fri, 27 Feb 2026 03:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet: remove three EXPORT_SYMBOL()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177216240928.1956064.4293575334432989627.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 03:20:09 +0000
References: <20260225134023.1176738-1-edumazet@google.com>
In-Reply-To: <20260225134023.1176738-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 13:40:23 +0000 you wrote:
> inet_rcv_saddr_equal() and inet_csk_listen_stop() are not used
> from any modules.
> 
> inet_csk_accept() can use EXPORT_IPV6_MOD()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] inet: remove three EXPORT_SYMBOL()
    https://git.kernel.org/netdev/net-next/c/363c5108e4e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


