Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083E45038
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517474; cv=none; b=hjr7bIQTIKdksTg4INvSeeLIXs+IjrlcOYInPlA9w9mp2RhRYMZEQfsZTT9CX2dFAEoJrIhzPr6RYxw/3waaLoUB9bDLC16ayvxXjEQJqqQE1ajrVuAO/Wz/mZ468u7rxIFT586ZjJeGoSu7CZP4s5xfGZEt1KNmjCuxO8QK9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517474; c=relaxed/simple;
	bh=DvSJPM8Myr+ypEnm01zJe9A/N1cGi1lYBCZvyml1hUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cuqJuRYCsWenSeuzvlI3fVXZ1+dYg8sxza1Keejho8n+nCAjGaKZpfpOlWRlgvvqjBZCOpXLf4aUa4dBFlNI9BcC3NstFhZHy5S5a1KbgC3JXd+4WiC2n/Q9XbeAB3wIZvqRp6PTq3S81cg0XJfiPpRfJanJ1wqBgGbgLrou8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG0Di4Z+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG0Di4Z+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDB41F00893;
	Wed, 16 Sep 2026 00:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789517472;
	bh=IHaN2gWi1wmMGuSk7FDz+nB9y4UxJZOxrSjuldSnjBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YG0Di4Z+3lgq/WUoHH8rRU1zB8+fJ4ai/NjsNswUqxLb0/CsTRVORoOqv4x3FOu0D
	 o1kBzfGyaV3kTW0a+iNg5uGKRKlSEAfC+mkzdeaB/s6cMai0zq88OvbSTY7e+0xT/J
	 Az/UUn/DJnDCqf4K2MI1TA4zM87OvolpS6mQ/dWrJRgu8GVq+jfU2OnSsAmnUKthMF
	 XSsgrMAiThIy0OtcFpKXh5LefBo827vAqzClhEdIrUSex6Vr1ZxYyz4RpRTZfjMrFR
	 B2vneFdB3Mm9S4gtT1jddINuyzILMLfLMxuHAHfkd5mzdkOxKuNvkMVPnEWOAuIhPJ
	 4ml4Oimex0vFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 937B9392706C;
	Wed, 16 Sep 2026 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] pppoatm: ensure a writable skb header and linear
 data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178951740612.2328807.2734322587316636220.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 00:10:06 +0000
References: <20260912233048.3977192-1-edumazet@google.com>
In-Reply-To: <20260912233048.3977192-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, mitch@sfgoth.com,
 3chas3@gmail.com, qingfang.deng@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Sep 2026 23:30:48 +0000 you wrote:
> In pppoatm_send(), LLC encapsulation checks whether there is sufficient
> headroom for the 4-byte LLC header, but does not ensure that the skb header
> is writable.
> 
> Normal transmit packets passing through ppp_start_xmit() have their header
> unshared via skb_cow_head(). However, packets can also reach pppoatm_send()
> via PPP channel bridging (PPPIOCBRIDGECHAN) without going through
> ppp_start_xmit().
> 
> [...]

Here is the summary with links:
  - [v2,net] pppoatm: ensure a writable skb header and linear data
    https://git.kernel.org/netdev/net/c/ecc7253683a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


