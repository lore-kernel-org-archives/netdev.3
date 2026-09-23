Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6943385AC;
	Wed, 23 Sep 2026 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128883; cv=none; b=e6kqWlwDeh1SnpDeJXPKvzvy+veg0ZCg2rLDECg2/PHi1tLNwsK6+p/QPIPkSnjzGOd+HWNAAtsTrsoBfwDmXdN3HeFXi+le5MJlHDLE/B4mWwP+TKs5GWaneTgTMMEU6Yv5CTdPzqgFB8QGVWQzyrz0qBURuHg/7GJUqFrAS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128883; c=relaxed/simple;
	bh=Yanw0PgBXVI66R2jt8ALqdiFch7Tt516aKB9QFIE3Hc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KzV7IXTe2D2P7hjdys5YrXMne5SYpk6RgWSEC5RK1GU54prMxuPExU6EVPOAFMRzPJk9euLs+HDUPIBlYqmh6bnV4kw38lZ43g775nus/zD5dJRXSdMm5CfehMARR90Y3H42dqw6Xapsg/33+/NKovq6EmtX57hq7HkAsVeB77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQRPL8Cw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQRPL8Cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084181F0089B;
	Wed, 23 Sep 2026 02:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128882;
	bh=ajVWnCh+smWOfUT/3GFHCbKnD/lu4pvqAIePdc9STDk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VQRPL8CwgO/cN509rfkkehm+GJ6frw0aze/y5b8/6xgmGVAYtI77Kva0iI+sls0vs
	 rRKte8xQGRMm2i8L9DZ7vUevJ1uhbqAdWPDEDevDZ9pP4kj7O57y0Ix86STGdA8DBl
	 1EjeGPRIH+lqZxw75VCduYS370/fmQg5Cd2LcJgLzKC3UhYKB6sKmh9hQvUoT/BpXT
	 yPmgwSXAZ3Y7teRjTqdEUBzYPgHJUbVxZ2+CsRSEnTidCsxXlXYwprvEH0HEBmsNic
	 ahB+4DuJ3SKpf2JOjXY2TJawQUt+F2iO46+SMvdueZyfb8Pn3WOhj/2FQe5NsSdlcQ
	 Q4cOs8Na5Bd+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C5E3924472;
	Wed, 23 Sep 2026 02:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: devmem: document that bind-tx is
 unprivileged by design
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012881239.173471.10725387644005775356.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 02:00:12 +0000
References: <20260921195545.493253-1-almasrymina@google.com>
In-Reply-To: <20260921195545.493253-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, razor@blackwall.org,
 daniel@iogearbox.net, bobbyeshleman@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 19:54:12 +0000 you wrote:
> Unlike bind-rx, which configures shared NIC RX queues to steer incoming
> traffic into the caller's dmabuf and requires CAP_NET_ADMIN
> (uns-admin-perm), bind-tx only DMA-maps the caller's dmabuf so the caller
> can transmit from it on their own sockets without affecting other traffic
> or device configuration.
> 
> Add a comment in netdev.yaml and above netdev_nl_bind_tx_doit() to make it
> explicit that NETDEV_CMD_BIND_TX is unprivileged by design.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: devmem: document that bind-tx is unprivileged by design
    https://git.kernel.org/netdev/net/c/73b3fc67a493

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


