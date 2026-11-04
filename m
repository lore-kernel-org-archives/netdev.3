Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803807;
	b=stVAzrOucLt3t8uNi8vdgAAoBLNS3Nw7w83h3tMM+b5imxTnzr8ACYMsnGSOehqbqotH
	 8AN48BUbpAC+7HuVqWlVhlu8vPVDDrTLwUIOKfboD2iZBYSQ0FTFIMDp0Y6TrvPgzujhQ
	 L3yY1IDDiEbPdvMRmpZyqmAuQss8N5IomDpJJBft7nt8yWpFPCiabjPrMl4C4xSK2rbqZ
	 oVnEPdYSJwp/YzQUHuEAIozKJABfcdtOmq+UJ/UEHm8x4AyFBL52XfHgCPzlDWEhA39uY
	 pFnQh5z8ZrGgGV70HPWCU05S3JTx13P5rT2yz1SEaekKIJESUiNlqoi8i73Svz7d/nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gYW4DXlbHV4R7NLPsq7QchRdN0rDVUNmWaF4xWASMHs=;
	b=hn1FaY90jdu8BJ6LGdfkxnXwX3aPiUSge4vJ7J7zlrvvhFlHubF67OjDYDfvDEWCKQjo
	 MKHvImMJ1EaB71xdMeXjkCwLBqEczRIiWV4OWAlYx69ITGJzkoniFWA9cIYKTQ+09tAAB
	 aYyHH7xdib7mXOhjpllHeKrPlHs4QO1uJtZnxN9/IVl+h8IBBD5zpgw6Wd63kKk4Xsae/
	 XlTV6MKD1JSVfcuzLa0cjJwT51tZHI+bCZr3rbIvhBvlwgh1ihvGIhSExJHfqr7Y4pHUr
	 AvDUCh3TxIO+SKREqI3Mzajfgau9DJ11BKNr1iyobpSB86ZtWLJb8cmxFQ4sFQxlTDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9rKKu+i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEB606A32F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9rKKu+i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B281F00A17;
	Wed,  4 Nov 2026 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803806;
	bh=gYW4DXlbHV4R7NLPsq7QchRdN0rDVUNmWaF4xWASMHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M9rKKu+iy4ekuAB17SwJDUjXFqs8EQ2WWRZbBDIvWbkKvB3+ogGG2egX0/OuNgTLS
	 fUp9jvIHgyexV2ttda9FFa7KP7/4vGOGW9gvciLNZ8526v5bO5EadlIgIXZRjttydU
	 rY6XUi+k+7r4vSZlearH7lkeGFVRceMsDoQejVMVi/wSU5sySA1SiT0sJlkLzjJyNW
	 b0Y2zmt/I+QG/jelbKLOfuZ0U9scHOqyQrA2yR2fRS74kmwASc0+6H3PQUrLVC/fG1
	 XGIOPdCEtV1Aqo1b/4hKJYubOm1sSzHbXFuTV4tHhR0Bk5YgIN2pnP/ZCF2SkOm2uE
	 2JuCdpfN3SqFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4020039E8A47;
	Wed,  4 Nov 2026 14:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: ipv6: do not read ireq->pktopts from
 tcp_v6_send_synack()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179380380505.2870837.10297269336036041200.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 14:50:05 +0000
References: <20261102075441.3771550-1-edumazet@kernel.org>
In-Reply-To: <20261102075441.3771550-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, permissiontogallop@gmail.com, x-professor@outlook.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Nov 2026 08:54:41 +0100 you wrote:
> When IPV6_FL_F_REFLECT is set on a listener, or the
> net.ipv6.flowlabel_reflect sysctl has FLOWLABEL_REFLECT_ESTABLISHED,
> tcp_v6_send_synack() reflects the flowlabel of the SYN packet,
> reading it from the skb stored in ireq->pktopts.
> 
> Since commit 079096f103fa ("tcp/dccp: install syn_recv requests
> into ehash table"), request sockets are processed without holding
> the listener lock. A cpu can then process a retransmitted SYN for a
> request socket, and send a SYNACK from tcp_check_req(), while another
> cpu receives the ACK completing the 3WHS. tcp_v6_syn_recv_sock()
> consumes ireq->pktopts when it wins the hashdance, and the first cpu
> reads a freed skb:
> 
> [...]

Here is the summary with links:
  - [net] tcp: ipv6: do not read ireq->pktopts from tcp_v6_send_synack()
    https://git.kernel.org/netdev/net/c/8e069fd3fd39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


