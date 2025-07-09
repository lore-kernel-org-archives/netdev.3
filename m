Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229C1C32FF
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026987; cv=none; b=K2KcIFx/5SPka6k6EjbGICecbpS5IHsNZigM6RKWIolChnExtlqlLXyahhHnjYJL9RdvLcV3YJJQPvMKe1X1OF5ap6ri9FB+NVb4YjMuCI+fEfhAaKh0ijX9u1UFgjqciCYV9fiUSsnvRR5eiUeYpwTDmd7S8YZlmbnRoOxwGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026987; c=relaxed/simple;
	bh=hdxhkV1fmdgs0tQhWjB3JJLKbKsBK3xOprwHbHEyo6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g1XOwp8PrYnxcIq1Z3h91Y2cv6VRkEZwm761QjuuMqhifYQGgY2dq1xLlpS6lMt/0Xd2HxVyDUypy2nBcB/BQOocl0gpK8dQjLrdsEPX5EFHOy3RwPvrGYEeudzMVCRx2qu9dPAWxWMrMQ0TptEAH5rcjl4C1t92xMv/X25Yzak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGuawhcz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGuawhcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0446BC4CEF5;
	Wed,  9 Jul 2025 02:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752026986;
	bh=hdxhkV1fmdgs0tQhWjB3JJLKbKsBK3xOprwHbHEyo6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LGuawhczub2/HRFNlmsBQj3duy0NAHTIZEZcdTpgbvByfR54USS1vrB0dBOZw9nrl
	 DiHkyB86RX8qcIFRYTyjQQz8kPEk+lwCta1JZV2P/UC25Jt8+55fwWabnOyEl5wTbc
	 IlMRjDzGV0v3T8h9G/ZjBQGtmvt3HtusuUJi3oqcFl6HFPtRXNiTQdatR7S60M9beu
	 bdDmCd2ZFt3UqrrAtqSEsDj+8TornDiM98+mFeDPHxFyW/y2zzacm2EwjBqA34tJSW
	 QO6MCWmGibTIkzhHU7+IkSd1157MrIhjg1MUrU36GtMByoH95xFOBNP0oKcic46poI
	 IbFVd7mMkef7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF93380DBEE;
	Wed,  9 Jul 2025 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp: remove udp_tunnel_gro_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175202700866.194427.11175081039575107183.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 02:10:08 +0000
References: <20250707091634.311974-1-edumazet@google.com>
In-Reply-To: <20250707091634.311974-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Jul 2025 09:16:34 +0000 you wrote:
> Use DEFINE_MUTEX() to initialize udp_tunnel_gro_type_lock.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/udp_offload.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Here is the summary with links:
  - [net-next] udp: remove udp_tunnel_gro_init()
    https://git.kernel.org/netdev/net-next/c/ea988b450690

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


