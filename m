Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F71C3F0C;
	Thu,  8 Oct 2026 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426008; cv=none; b=a7zywBIaYKENjyg9Ocp1RRVNc7/osIZ7TmRbamriGU63nvVy+KFyR3wy6qz9TLLTLPmF8f30yXGIeoVz7lvt+UhuM8cLTAdV9BTgPWGSlPj6u3ppRAU+I6Ms44oQlc+FYxlNR/t8NFLI9h4+nubhvmTnkKd/MWzRPK+rGX0n/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426008; c=relaxed/simple;
	bh=pJ9ZN9decBTjYUKpIMugqhf+yAISG/CVyAPi4RcFB6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FgdF1Vza1E5GWKAx3F3EezjPZRu25KESGwCMe2OOPTNI8QQsVOOqhk2/LI2mdmch3iIdFR39ePCtZ/I7CV1GmsLKdaDFVXC78UwVL2iSoVzJs2mrlHTW5HlA6dCOB7rix8ElTb0GHHBR0Z+SbkY4u2Qc3vPMW1uKX3XtFJwC2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+9IMIqw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+9IMIqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0C71F000FF;
	Thu,  8 Oct 2026 02:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791426006;
	bh=9grHoptU0Y48OUptOq7hw8mMj7jMVGAm6ycrAwpsfH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=a+9IMIqwZAOEZMWCEnX/3Tc9MvsfHZHeUGCIYvOcAzO5rwIhsOVuKvXXi4U9Ff0eL
	 MPrN2FYW2afHe51ryJwo0riEf4Qgkbm2ujqH8NlJfhIZcWybDpfRkdwDu8LUCN4jNd
	 sarCMbSwhCLPzTGsdE4YtxsILYPnP7oFq505hAT5i/M9Ij1gvfy+uK7BafwFEEXZce
	 K8lgMq4NmPNOyp6Jzrgoc79Gp3d/oT6I9YPJgmzdm+iKy3JHbZoLvABxpNnkriHXMU
	 pH8Jut6uUbsX5/O7AkLe2/9vvE9YfAznCxI++sWxOBF+G7/27z0CW3IxnAefs8ypaF
	 KWdf/Q5S8tH5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775903809A09;
	Thu,  8 Oct 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bareudp: set the inner protocol to the protocol of
 the
 packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179142600528.3774554.3439949291486078894.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 02:20:05 +0000
References: <20261002153039.462663-1-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20261002153039.462663-1-yanhaishuang@cmss.chinamobile.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, martin.varghese@nokia.com, willemb@google.com,
 alice.kernel@fastmail.im, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Oct 2026 23:30:39 +0800 you wrote:
> bareudp_xmit_skb() sets the inner protocol of the skb to the configured
> ethertype, and bareudp6_xmit_skb() does not set it at all. The inner
> protocol is used by skb_udp_tunnel_segment() to segment the inner packet
> when GSO has to be done in software, for instance when the lower device
> does not offload the checksum.
> 
> With multiproto, an IPv4 device also carries IPv6, so the IPv6 header
> is parsed as an IPv4 one. With IPv6 underlay, the inner protocol is
> whatever the skb had before. In both cases segmentation fails and the
> packets are dropped. With veth tx checksum offload disabled, iperf3 TCP
> over bareudp gets about 10 Mbit/s with thousands of retransmits instead
> of about 700 Mbit/s for IPv6 over IPv4 and for both families over IPv6,
> while IPv4 over IPv4 works.
> 
> [...]

Here is the summary with links:
  - [net] bareudp: set the inner protocol to the protocol of the packet
    https://git.kernel.org/netdev/net/c/c57b2e60d4bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


