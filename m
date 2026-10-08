Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ECE4F55DF
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484817; cv=none; b=iq8IxAk7fmWYuhhQTcVmYGADW3EKDSArOCIZWmXUei1LVmhmTorKU3SOHIQIP83kK0kO0r81hM/artiW9VqWU6iPKKqhQ3RW9OyYAGhUMGeBNGBIRKScZuLEOsrOOHzDn7SpC7R+lxskQ1m+rDcEPEQziFF0PxXlTE5glMgWneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484817; c=relaxed/simple;
	bh=r/WJJpMAwyB6A/FkLMBBgKdKCaUD+ACuvSGE7LpvsRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a8fgpLxFxQWQ4jQGALV49oOCigSH6/1FIhXVBYxsghfiBLTqsdipcJLlmfSe6S1hMQVHixD78LjhL8I3AKUB4IZcTl3WwlsPHPi+cwF/72jtnNPkUYFugffiQAcRDqUJXsr0ZJZsaEsV00jp7UvTYv3zwOE8nRFHpS6r+F5hKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7/2nOHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7/2nOHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BBB1F00893;
	Thu,  8 Oct 2026 18:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791484812;
	bh=Bnq7dhPsDUlgpTbWQYgC/7XvirYxPMHf6FU7llDLgNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K7/2nOHBIpcgmYWhmG5szRnX61eezaezIlzLQQf0VnMMtBrPhY9PAgiWI/glHMWHu
	 a0gCOTX38w5uRe28oGRsUvmigFvWp6Kow8I77MSOF1o4Ftfnu6EBkZghz2vO6tAuwY
	 8ihtnPN79FNA/wf+xVBzq1KXP9I/EcpVs+lGo/ifPVv4/IUXsLETPvYeHU/bC5NIhD
	 cZ62K+5O0+EC5Fp9NHzEnTqMt17qqe2RtFTXtEHJjZECNBKnCkAYtzSih3K6A1yY3t
	 /iZBjgT85sWULvl6NLNsx+qmQSis3NXUdCbRs/yihQcvODAa7By7ZPMsQNxSikdkKp
	 9NANEzFYsQPow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77B45380CEC8;
	Thu,  8 Oct 2026 18:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/packet: call packet_parse_headers after
 virtio_net_hdr_to_skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148481102.386807.4218183198287963387.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:40:11 +0000
References: <20261007175816.3138556-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20261007175816.3138556-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, mst@redhat.com, liuhangbin@gmail.com,
 wei.fang@nxp.com, willemb@google.com, zhangjn_dev@163.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Oct 2026 13:57:30 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> SOCK_RAW packet sockets incorrectly drop VLAN-tagged GSO packets
> without VIRTIO_NET_HDR_F_NEEDS_CSUM.
> 
> packet_parse_headers() sets skb->protocol to VLAN but advances
> skb->network_header past the VLAN tags. virtio_net_hdr_to_skb()
> then flow dissects these packets, which parses the network header as a
> VLAN tag, and fails.
> 
> [...]

Here is the summary with links:
  - [net] net/packet: call packet_parse_headers after virtio_net_hdr_to_skb
    https://git.kernel.org/netdev/net/c/513e23857a3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


