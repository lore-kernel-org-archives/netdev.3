Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00643D4105;
	Thu, 24 Sep 2026 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216482; cv=none; b=J6wK2fYrgusUPPzS2e65Mrc2lQdKe7Zya4plC90aEsjYwuU0XXntMYTda5OfJ5yL4ErKTs+2brSBQJ2NwULaPqx5PcWM7V0qJOm3zWJ5TUG/RhjYq+Bo/Ij8xduwUlVRcjaymNpGMDJrzz09gynAITOK5i6WX03aEC6F1J/uGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216482; c=relaxed/simple;
	bh=Sm6bnS2pV7Ag0KFzCgihKpk3lUjwWhQuR3iS6NSTK3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EcZvmgYrC4iYVVGN3OrrtXrBY1LED9hrI3RcgqHR7P2A/HemTzg+KE6DZZcSsw3vyrzgAhxbga22rkUCZLtNocSoh8gjRdXhsW0Vz9SKwHNVijKdmequUvWwcwMP+5RKhp7eXs2zjeM8l16t39veLhnmnjjGpYqxKtZDVkRjw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYJdmDB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYJdmDB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2FF1F0089A;
	Thu, 24 Sep 2026 02:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216481;
	bh=gyd5eF0E4AsniF6TDy3gHsIt1ARThOCPqrBkSs04BdQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jYJdmDB5ZiYjEtpLxV/XEhjWGwYUwFiGP3XI+qADKRg3JTUrhlN1fNHUSgilVvlx6
	 TeeO140UHvA519j2SjpWwfu/EVbovO4TbNIUY8TPFq2cH0eaiKBLNCnWEsxbZROJxQ
	 IHzP/ZY72LZ3122KCAeHzTLNqIJh1Bh6qCRZYkuiX/qcq8RgFwnuMQG2VadvgxtDY+
	 x0pwQS6WqAqtZ0Fnp4kmtAOedbxneg3IDd1yBYMYNNY44Cy9jiU4QPfc7k2N1Ox4E7
	 iH80tlPp8RFDvSd/eUcWKF+geB6uy6JCV7JOxkEu+soYseSuPNJaqZw+tK9gNJqHp5
	 Osh6utEt7oG2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199A639E9611;
	Thu, 24 Sep 2026 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ipv6: keep room for the mac header in
 dst_dev_overhead()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021641064.1281065.11687596089740883576.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:20:10 +0000
References: <20260922-seg6-maclen-headroom-v3-1-7b2f982ef79d@gmail.com>
In-Reply-To: <20260922-seg6-maclen-headroom-v3-1-7b2f982ef79d@gmail.com>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 justin.iurman@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 05:49:56 +0900 you wrote:
> The seg6, ioam6 and rpl lwtunnels size their skb_cow_head() request as
> the length they are about to push plus dst_dev_overhead(), then push the
> new headers and rebuild the mac header below them with
> skb_mac_header_rebuild().  That rebuild needs skb->mac_len of headroom,
> but dst_dev_overhead() leaves LL_RESERVED_SPACE() of the egress device,
> 16 bytes for plain Ethernet.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ipv6: keep room for the mac header in dst_dev_overhead()
    https://git.kernel.org/netdev/net/c/87cd6b717e40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


