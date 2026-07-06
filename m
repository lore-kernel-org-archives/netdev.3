Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F63E51F8
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336227; cv=none; b=plBGgegKlV331beA8CWUIIbVl0hSFILQVD+XTiTZl8qvhrbp7YPY6U6CoR0Ip2rsuo+0Kk0ZQg4en1ir9JT5z0+gtcnkkoQ8KWvx0LVAkLOyk3dKLLVU9xn+b7EWimPRX4jzj3EhCTMzT5xwoRrodOSkPFd09wMJ9ut1/1Vu7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336227; c=relaxed/simple;
	bh=ul0i/2isspZkOqKoHRNlHoaDUSJoAVKPAiZZcUeSr8k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b2kGa08gjQ2uPGC9DghHE/RhLVSGiBzuHRKE4ZHNG8I/wOO9Ce2Wly89OVIQI4U2b2OV2fa7En6T/ghGz5g6awQXWafwWH4MllaEcnSikCl6vQ7zvXqr3RxRqfHuXo9hymN2dkm6ujMTUsmPhQRlO4BEokdud+0UcIQ2ilkKj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEIE2wXF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEIE2wXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842671F000E9;
	Mon,  6 Jul 2026 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783336224;
	bh=QffKILYnQN9YcSEpazTh7cROVqHGRU+/X5uqZkNYzVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OEIE2wXFWuccP8Q7dOyia0TkQPWcwCW4iaBInM77fBCLSlSWLTjHLdYLQq/0BYZ5r
	 YzbUmIjpaQqi7vNPM3o/3MitvXaM7lMdFv8biEbGPCi1FRydru/V8VR4r6g04/l00c
	 shwYJtWbEyVnRmzt70cjMhJi6MB3+SaLXZSJSxU61n1xKNaYO9sbn1q3RMXhXkeVuf
	 dCtbfDqNmMEO4hRAm2/aQ9DVOF/X5mb4apYWZzVbQDTZWPuSLNirfzaK+PWhbq6otO
	 U3+kmx7etc7AzaBU17ZbQjxhgr1AbKkfAUJPDBQY6qDPHj1TSjX2jVSX4ujhJDF3qU
	 7pyqajO+W075g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569533ABD2A5;
	Mon,  6 Jul 2026 11:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] amt: fix size calculation in amt_get_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333620514.508475.18254456357684697437.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 11:10:05 +0000
References: <20260701122329.3562825-1-edumazet@google.com>
In-Reply-To: <20260701122329.3562825-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 12:23:29 +0000 you wrote:
> amt_get_size() incorrectly used sizeof(struct iphdr) for the sizes of
> IFLA_AMT_DISCOVERY_IP, IFLA_AMT_REMOTE_IP, and IFLA_AMT_LOCAL_IP.
> These attributes contain IPv4 addresses (__be32), not full IP headers.
> 
> Replace sizeof(struct iphdr) with sizeof(__be32) to avoid over-allocating
> netlink message space.
> 
> [...]

Here is the summary with links:
  - [net] amt: fix size calculation in amt_get_size()
    https://git.kernel.org/netdev/net/c/9e05e91a9a84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


