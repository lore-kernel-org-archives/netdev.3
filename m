Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99D31E106
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553612; cv=none; b=fJQdcz/qkzx1Y7hfQkUvj2n5V769p17qf9t45vj92F5rgFUOF7tOd7cSZNfUblQCswC1BU/J4hrQmZUoFNhWh+V6TtW8Yw8h7ZL7e+Pe9a5EButwWQ4E1aj1kFuYrLgN861PbL1iKmWlsyZ0Jc9C/d+9ZpFrmhtNK0U1pjKJMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553612; c=relaxed/simple;
	bh=ELHbhRUMqgbc91OYQejyiB48+XwjNjhcJ1wo6GB4MsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YanPUWGoRAg7Unpi8jzL9SqjN6vyb2Umz4QB++cbaktNLpHl2BqNV9NcCu8pmSdwTLeLupyZMlQKMMDfdIqozYvp8WGGkJLeEMKZ7qTXvNtA6k0Wm+fPUIfzsNqYdNt57ytgTZMlVv0/eSQJuYr9o7uzAteJ6A8utoU0DW4kykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AexXUxI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AexXUxI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B931F000E9;
	Mon, 15 Jun 2026 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553611;
	bh=ZSlPBQgCCyjZetRsD0IOO8PwMyhCB+1BS4cIArHHAco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AexXUxI/JByrDGFTIOmNYislfvY9E4bdOfN5ZVBNPRf4QSkZEOxDsk4MwSqlohf/M
	 pjAadbzYJbq/XKU0h/nJ0c8+WUk2ip8hIT3dL7zzOP1HhKvTDEctkzDaYway8EKyZa
	 ixT31kAObMW5qqePvJLKp5wl8n4SgxFNWtz357cv+bPHEufPCOy8YuLQFeTpYANKPS
	 9KUthzvmWmPXXBR5wrSjvnTlTQ6AlOLdDGYnFjEZF4rHc9li7JCBfvVg7Yp5peZgkc
	 pCJHpH8ZjTsdWgscQfbuYtcU6U2djXzqcAXo/rlAtkouspHAXuZTeT/OiixT6e8ko5
	 l0LZJEWZeqHyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A623839A06;
	Mon, 15 Jun 2026 20:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: ipv6: clamp default adverting MSS to avoid
 GSO_BY_FRAGS (0xFFFF)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155360639.272818.5043247062078863651.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 20:00:06 +0000
References: <20260612162517.83394-1-edumazet@google.com>
In-Reply-To: <20260612162517.83394-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+ebdb22d461c904fc3cb2@syzkaller.appspotmail.com,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 16:25:17 +0000 you wrote:
> When MTU is large, ip6_default_advmss() can return IPV6_MAXPLEN (65535).
> This is interpreted by TCP as mss_clamp, allowing the MSS to reach 65535.
> 
> However, 0xFFFF is also used as a magic value GSO_BY_FRAGS in the kernel.
> If a TCP packet with gso_size=0xFFFF is passed to skb_segment(), it will
> be mistakenly treated as GSO_BY_FRAGS, leading to a NULL pointer
> dereference because local TCP packets do not use frag_list.
> 
> [...]

Here is the summary with links:
  - [net] tcp: ipv6: clamp default adverting MSS to avoid GSO_BY_FRAGS (0xFFFF)
    https://git.kernel.org/netdev/net/c/2bf43d0e2e6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


