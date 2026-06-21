Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859C37104C;
	Sun, 21 Jun 2026 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078022; cv=none; b=OvkzNEXBivE6J0dFHMnFx72uXRq24DYmGGvvUVuOOG/nerryX53vqV90/RTJ7tm+bQN6VN9GqGEjCcMOavHi9Ce8c2ygenb4I98g+9Fxzbsayl6UjoCmBqY+uBzWXYqSV5ff1S/f5PDJUklWw7CDHzAoBCDW5YDjIbsGyUX3Jok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078022; c=relaxed/simple;
	bh=atf0PITLwZ+8sNB37QLxiy0Hi7KAV8ua4O0y2YqujYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MmNWIWF6xsnewc2Lp/ca7xQGQKIP5n+vcftnU0sn12v2DiQk9OxJc1iW11h+KVLRx3cK2rxBx1BvN1R3m5cGnBot6WPbVGUZYI5AuL32M9x9ES1Wyf8CscryxwtTZeVRHy9l0xnEj4vATgTzLSxyn4r+ESScptZuIVBY6WGePyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGP0Tgu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGP0Tgu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2E81F000E9;
	Sun, 21 Jun 2026 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078021;
	bh=PtCUX3BHVHVA2XJOFt5eDGDcY5JTEY+XynH4T68oSeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BGP0Tgu/epk9BgkFi12OsW66AzB7JYPMHZrkcqmzSrI0E36VSQ4k4bbni28Okm4Km
	 Ay2W5aiPehGcDt6NHIavYhK/75V6OTyXQaEfqxCQWh/vUb1cumzj77Xqife+9D3xSt
	 AYrQHCM6uYuAsq1YRLWb/UkpKHYOUcoH0hKcUSKKKeytbL/pYc0we9NXcMqsO0Eel8
	 wZRUAYUrZL+3+MRtRoTXvpg7PduvoA8PkFtoOZhmFqbzkYqRzPpWeFIaHtV+lIKXVn
	 ZBkmTKxXjM7h7/tZEfsLvMebYH3efahiM4zkTJWLQdNYJXmMy8PJqcZW6be3AMAbNM
	 V8KWOZnDMZ6+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A443AAA6E4;
	Sun, 21 Jun 2026 21:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tipc: fix use-after-free of the discoverer in
 tipc_disc_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207801247.510072.8510116277574588342.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 21:40:12 +0000
References: <20260617135744.3383175-3-bestswngs@gmail.com>
In-Reply-To: <20260617135744.3383175-3-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ying.xue@windriver.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, xmei5@asu.edu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 21:57:45 +0800 you wrote:
> bearer_disable() frees b->disc with tipc_disc_delete()'s plain kfree(),
> but tipc_disc_rcv() still dereferences b->disc in RX softirq under
> rcu_read_lock() (tipc_udp_recv -> tipc_rcv -> tipc_disc_rcv).
> 
> L2 bearers are safe thanks to the synchronize_net() in
> tipc_disable_l2_media(), but the UDP bearer defers that call to the
> cleanup_bearer() workqueue, so the discoverer is freed with no grace
> period:
> 
> [...]

Here is the summary with links:
  - [net,v3] tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
    https://git.kernel.org/netdev/net/c/1579342d7113

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


