Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721935AC05;
	Thu, 21 May 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375007; cv=none; b=FpmvcCuDjC6rB55MiDQnmv9ZstIBY/fTh0VKXFlp6oUCAS9vx/zTs0qFqpDcXfFByV4R6ltnNUYpIKEBhlOt+pg8mWi3g6V0XHiISktTXIE8d74udDRqjH1azOUuSvRhrYqtA5QWCHDhRruiLXkWRa871K5UjBWpUdRLEJ/kojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375007; c=relaxed/simple;
	bh=f1DD2BEaNtR5IkdxDUC4BBHSwH/ZfaUMCCTbtSPoRNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BLQTumwQfLx2Bu2uBSkkDXI975XDg3TkYk7nFUhTL0uoRcGupZtkNppLKqe/36kDuHD4L6+RWZaYj0lETWICXbwYmSF/l0myYbKa/M0DpxIkmm8zZYkcConYaKjDXKpBpaZYSuhec2xxI/awN+Rn1OR1yALBXpShit0Fv8jfH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWAK1PHg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWAK1PHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409281F00A3D;
	Thu, 21 May 2026 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375006;
	bh=gmgfjOyV4Mi/6Zy6L+i83wcb5YH9eQ1KGG+Soz1ozDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZWAK1PHgfXvkDsC+1NYjIhsuDYfskI69vxvyCHt2Xu1KybG881XnwhbfxMy7vffst
	 z9hj/rRerhHYCjllZZJl2O3l8KIL6R1LmYulj+26PqtHkEmttF00euBL124kzed/53
	 rtn+CAa1MqJxtDogdJpbNMyOfFYanGYvYrFcR4oklM+/0Ero7iQUPVWfdxbKhcss79
	 fWHmWSkAiyBIy2MhVtF2KtwBXeFI1udDBJNrNNLauKjXW/NRXelc+Ih5WQbPyepSXj
	 a91ztnr//c0qIN1wQgS65sL0jet4dA9Z9sJEF+/PJsi16YkAj9V43lvIN4AaLqxxgK
	 F88qasXJ7Gqfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568BF3930DF1;
	Thu, 21 May 2026 14:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] ipv6: route: Unregister netdevice notifier on BPF init
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937501589.361786.2063480592208858854.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 14:50:15 +0000
References: <20260520030329.1061183-1-dbgh9129@gmail.com>
In-Reply-To: <20260520030329.1061183-1-dbgh9129@gmail.com>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 23:03:28 -0400 you wrote:
> ip6_route_init() registers ip6_route_dev_notifier before registering the
> IPv6 route BPF iterator target. If bpf_iter_register() fails after the
> notifier has been registered, the error path currently jumps to
> out_register_late_subsys and unwinds the RTNL handlers and pernet route
> state without removing the notifier from the netdevice notifier chain.
> 
> This leaves ip6_route_dev_notify() callable after the IPv6 route state it
> uses has been torn down. Add a separate unwind label for the BPF iterator
> failure path and unregister the netdevice notifier before continuing with
> the existing cleanup.
> 
> [...]

Here is the summary with links:
  - [v3] ipv6: route: Unregister netdevice notifier on BPF init failure
    https://git.kernel.org/netdev/net/c/1341db322417

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


