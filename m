Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B15284665
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377625; cv=none; b=pW5n1fGIfSkRgefPsyXGu5SU7I7xbAmg+qQ9ORlbBWRv87enu8kee0EmT+HPXbhICDuoBZ1v/gDd7rWPqDeC5eCa4g2NMIQyHrcuSl2icJ1AVs+b2o8AeUyTS0Fw+Qby4my8ZafmQhPlxE/C2FNO3lUMK8I0kwUqc/ZQfU4D+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377625; c=relaxed/simple;
	bh=nHVpOmQMRMhWr2IgXDXLhTq352iqEVSQ6/n3E/vK+lg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hg+M61XrEmqxgADoSRlj6+K0O11mwHzCSl857krN6OZyCzHeFxTCSXqwnojli7ssjim2ZEMEHqIRY7O+NOMe4vhCtH2cw+RbValywTzT5PnlQM+iML4w2WcMheMUA071FezpzzYLC6YDmFK5ry7vNO82/lO/49tM7xEJ8k9pRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYmYlyGo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYmYlyGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AA7C4CEF7;
	Wed, 18 Feb 2026 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377625;
	bh=nHVpOmQMRMhWr2IgXDXLhTq352iqEVSQ6/n3E/vK+lg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jYmYlyGonjDm5ANhgved1V6JxNKfgWXm45/xSEwL6jcjrYyZiRoG2cPoBenNd0fsV
	 EwXts7G89Afg+MvXua3hudeZKKlycGyzfpw7gghZ1/A+wYwQdyKGNutZG8py4DTZat
	 w3kc42QE70PRK2E45vmzk+sPunSUVRGKcET7XxDJig3bi1R94XGaZVHIZQptJBhLar
	 KQSBPwCOGjAgDO2XfGq2gfBxmDk6q5wDnqDDyuaKe4c3q7H77VR3yWqt92aj6c9oQg
	 y8wjK3qgjLXUXPc6IH/fh80w8NPSJFogbQn8BnuR5uvzngnks+Qg0US4zBfVZm4PgL
	 WSU+3KxQN4JDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 84FD63806667;
	Wed, 18 Feb 2026 01:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ping: annotate data-races in ping_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137761707.765825.17845226541522243431.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:20:17 +0000
References: <20260216100149.3319315-1-edumazet@google.com>
In-Reply-To: <20260216100149.3319315-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Feb 2026 10:01:49 +0000 you wrote:
> isk->inet_num, isk->inet_rcv_saddr and sk->sk_bound_dev_if
> are read locklessly in ping_lookup().
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> The race on isk->inet_rcv_saddr is probably coming from IPv6 support,
> but does not deserve a specific backport.
> 
> [...]

Here is the summary with links:
  - [net] ping: annotate data-races in ping_lookup()
    https://git.kernel.org/netdev/net/c/ad5dfde2a573

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


