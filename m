Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B032336826B;
	Thu, 23 Jul 2026 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830256; cv=none; b=KdkNqkqYGMVjqjoupgH3lxnhKG5F/JcJZo8+1CswjIGvdNl6D1+bR/XsB7UHuxj0J9iDJ3El432Wkixg9r6UFcjht2xqVLGt5PGWxg6ZGh2+SjHTdZGvYIFkPbX6IwIa0Xd26LV9QoPoedFLaF6iPBc1OpmqV2ANcBBdBqMC+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830256; c=relaxed/simple;
	bh=JgDiFGAqmySiu7s+CY1IZBEP7YMaH7ZhgvtgPb9sIyg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OzxD7vLq1edFcPBnmT/W0HaCqDhYuETXrat1qhlChT4uJjjLeh5KqwYYgmXefdzQbSUy0sZaw3dzd50XIlvAKna5I5VRnmr05XOE+mGrN7XpSINDoEyMVq48zOn4Oz6YivULa85OhwUShHqRJ5FiigPbitGAPzAZkdvkt8iUmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djq+8vfB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djq+8vfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D1D1F000E9;
	Thu, 23 Jul 2026 18:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784830255;
	bh=Hhny+AO2qQVtNMCAaXunuy4RKj8WapCG/g/pnXyf/jc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=djq+8vfB2spIfURLPH312K0s2fZ5+iDBo2ilSpmSSKkphaz+rQxkHzApAQCmhQllC
	 Cgnz7YIFBGNl9q+jrzo6xCYLOM7041kkBjZ5QcvtlkPQ9lGHTJBwLzsVTqwFzZn5hB
	 PqwL8Z059BJBDOIXFZZmv+Rj2quSwMjd0/09owRNAZnGKs6IJ2cDHhUkQddjcda+ci
	 geVUEKu4cyH82OtsKJVlV7UKIzFD2UNDEZJHpWGHXmkgaEfPtJQIxbtLUa22fDSu3E
	 GuMC0MI/VkZCu0P7jXkxNJXN3KNNCc4mTeE5WbUjp9qSqhD7codd+IPyrwFo/ZRKuF
	 YEazCCsap73Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D439244D2;
	Thu, 23 Jul 2026 18:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: drop_monitor: fix info leak in
 NET_DM_ATTR_PAYLOAD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178483021890.2811828.11947452770257106601.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 18:10:18 +0000
References: <20260722122817.5548-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20260722122817.5548-1-yhlee@isslab.korea.ac.kr>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: nhorman@tuxdriver.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, jiri@resnulli.us, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 21:28:17 +0900 you wrote:
> net_dm_packet_report_fill() and net_dm_hw_packet_report_fill() open code
> the NET_DM_ATTR_PAYLOAD attribute to avoid zeroing the packet payload
> before overwriting it with skb_copy_bits().
> 
> skb_put() reserves nla_total_size(payload_len), i.e. the header plus the
> NLA_ALIGN() padding, but only payload_len bytes are copied in. When
> payload_len is not a multiple of 4 the 1-3 padding bytes are never
> initialized and are leaked to user space inside the netlink message.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD
    https://git.kernel.org/netdev/net/c/5e9c8baee032

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


