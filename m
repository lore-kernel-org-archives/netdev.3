Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133D1A38F9
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672461; cv=none; b=LbNr+fKIqBJ6phE+txeJY8R90SRcmOtEBBOoDvj5SqxlHg2RZ6Mdas8e0gI6OZ7FQRYnGU+fyd1da2cbMxDtTqIrJI7QumCTRkISRjoLPCqAJkxvamnHNFF9j/UpRIe9KCMnUmmmzlwkJYSI4rAKjn+RNdnEgQIXejcvf0A3MSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672461; c=relaxed/simple;
	bh=MTtDnm3jYUI2VaDwgIo+RSUd9ml7UD3KKQtZ19GwWBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SgOumq01HtXOdl79AuC8tVMb8QxoCEBIyFepjB8B8dXG7mbbIVeL6pgSBZTw6MlW7ytEcmglGx9h33VcO+1WHUgUJa3/5Y4P0NUnkpFm7Crjbo5xDWlLrDRFImMzScWG4Qth3stzsJhI6jHzXdTb5hjxS58N1eQ6O82iUAoeBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+bipLKS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+bipLKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCF6C4CEF7;
	Thu,  5 Mar 2026 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772672460;
	bh=MTtDnm3jYUI2VaDwgIo+RSUd9ml7UD3KKQtZ19GwWBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C+bipLKSDPiPPSpId3MlY8wtN7TMP/NzQecDAbKJR25AZy3918HGsbZ9YK8TUji5u
	 cVf04QxvCXs+5cnYCTjThDQOlP75AH0Ftyy588mu5ZLIySkS/7j6VBYJuTwF9HGPzG
	 XBnqF+H7kzlZ3SGzLoQ+ONkROkReSwGsHx1LMP9qXv68n5TmWJMhWFVYVAjKSFBBrZ
	 497rZA0dIvrOGS6mGci6P5tJx2IRzH88S0T3BTzFX3BJIL65cLxbv407vWuZ2k3sS0
	 zAGuYDakkYpbCgLX5eBWVZ8iibjtKhrVdjbAoFvdWwMYYrLYMPrEi8CskF96z6wBCm
	 le8ZsGJE4GZTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDCD3808200;
	Thu,  5 Mar 2026 01:01:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fix off-by-one in udp_flow_src_port() /
 psp_write_headers()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267246075.2463633.14284718831138812661.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 01:01:00 +0000
References: <20260302163933.1754393-1-edumazet@google.com>
In-Reply-To: <20260302163933.1754393-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 16:39:33 +0000 you wrote:
> udp_flow_src_port() and psp_write_headers() use ip_local_port_range.
> 
> ip_local_port_range is inclusive : all ports between min and max
> can be used.
> 
> Before this patch, if ip_local_port_range was set to 40000-40001
> 40001 would not be used as a source port.
> 
> [...]

Here is the summary with links:
  - [net-next] net: fix off-by-one in udp_flow_src_port() / psp_write_headers()
    https://git.kernel.org/netdev/net-next/c/c26b8c4e291c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


