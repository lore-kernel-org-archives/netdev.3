Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290272E8DEB;
	Tue, 29 Sep 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649008; cv=none; b=udVhL8ImbBTonAbVvI5ntDUmifnkYWNCwQlaQ2VuCip0lE1yfiVeErFJ/YWl3jyTPu8EBh6XbcT4vMhljnE5fHLTJtzSRWM62hgXXjYvpz/476wtA2cHidTneKYPKKZ8XaJIow7f/SB9Wos1zq/E4DQvx+etL1mYf6A311R1l/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649008; c=relaxed/simple;
	bh=V5732wuxqR2F8fZN7ToBpH9iXDg/wOIt3mj5uTLjyVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pAhTJnpHJ6aIKpe1J9Wv8YH18TB57jC0Km8EkadYGFzNorN1IPLMwLi+GbQ/VOqTwLTJivg2kgiSxzslmR1ZXb2yUXBKeVowRxkJuHHeYtQp/N+3B5D1S88h8LdW6x3/vj53+B0g77iCVTXGFyjE1VMI1NS7hGjwR9VfMiW1rSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4Psqwrn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4Psqwrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD40A1F000FF;
	Tue, 29 Sep 2026 02:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790649006;
	bh=Z0oYgeWubUn+pi3frAFWNd2jX0YOGl7/2AAhjT7/vpM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H4PsqwrnBM+Pz5o11v0roeNcNzvnLDugrbtTFgOc+tSkZYWSkwQGsRTzu+ynbJMo3
	 MP+lwDX7zncmp20iq/8lFBEvXU6FU/Lg+K03JupqaxhxDWHC83KHvtG2J6G8WdWd7n
	 2mh87pSPlQ0jpEl8mhLHyYRfqKNqatlNRbR1JNXpOgM+kK8evLyfSDCcbU3mYC/LvZ
	 k+xWMjVsp4xRxNO/CZXHJuJBGx2frStGp/ewrHqf+xEm8aZstVLkhmZGRKl1WzUvj4
	 vc0W4A6gA4nxKcTJnd3m6+XICAv423x/gF8aS4BYodRdabGf4tTEMOLD/JSWAYK2zV
	 40S/m/U8aky8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44683924FF2;
	Tue, 29 Sep 2026 02:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] seg6: ensure packet data is writable before modifying
 SRH
 and IPv6 DA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064900553.226715.8573504515470539551.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 02:30:05 +0000
References: <20260925133807.32-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20260925133807.32-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.lebrun@uclouvain.be, hangbin.liu@linux.dev, stefano.salsano@uniroma2.it

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 15:38:07 +0200 you wrote:
> advance_nextseg() modifies the SRH Segments Left field and the IPv6
> destination address without ensuring the packet data is writable.
> seg6_next_csid_advance_arg() has the same problem when it advances the
> NEXT-C-SID argument in the destination address.
> 
> The skb may be cloned, for example by an AF_PACKET socket receiving on
> the ingress device. advance_nextseg() and seg6_next_csid_advance_arg()
> then write into the packet data shared with the clone. A read from that
> socket can return the modified packet instead of the received one. The
> simplified path below shows this for advance_nextseg():
> 
> [...]

Here is the summary with links:
  - [net] seg6: ensure packet data is writable before modifying SRH and IPv6 DA
    https://git.kernel.org/netdev/net/c/8ae3f4067ba4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


