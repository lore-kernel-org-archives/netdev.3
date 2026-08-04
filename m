Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8046A61C
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852054; cv=none; b=rthfiFi+3Mr7CS4tRIr6VreVNV6sAeLPjAUIX16IalEg4VSTpMNLzRZ0YNDBeqpwVHO6mLYUcj/ao4EsBWUMw9Glmmb7TLn3Cm/KkoDBfseoA78abMeAAjLr5iFup5DncpamcmIiObMQKg3FsAM0ZCFWNF0abLZDR+MAXo8X0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852054; c=relaxed/simple;
	bh=awLNbBUM1fpSscM1IhQ/q6xdDpdGVLAQaMA3UEMkFQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rAfMe96iCTzKGUDGZF1wET8RIH+QrnsTrgB2n0nH7Bg6vUrlEKWXIATP/KyNg0/0/Pvu58B6TG50mPEyb2FOnwCbwHXGxnw7OG/+4KCyO2GXSArafwuWAtjHjuTFC7v9GZdJfiJiwdEt00NN8PNiPGawntA982LWTKhmo+3Tqm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbWPJiK8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbWPJiK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4534A1F00A3A;
	Tue,  4 Aug 2026 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785852053;
	bh=FhDuG6mCg4ErOPSIUhBG0hqhXTR1TwlMB8tUZiwKkeI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QbWPJiK8irHr4OT0AnKc8o0Bv5HOANhvPyZlR3ng+KWkfc9lBu2sEBqyxO2Cr1tMN
	 XuWcA1mEjfKhZHSxwRj+xaS1ZBtfsoOOfbNVMJ/A792KHuKlhuj3LVhwIIAh5IS1U7
	 i02sui+a81DTphf70V9pnHbKfUaAXWZsCcJn9OB+OT9JngKyj8/KJlqt6NJZrqTqpI
	 cCXClL2EkD5GDU0TPMwBo/B0lhGOQRJFIoki9QAbHoFdCXgvbxTa0fhNhuPNWyrT6Y
	 +kDxMDXl+W2lkrlat4tT2zXHHrrL3AuDuAG+nUp7b+eslTM50KTYibHeORbP/WtpyL
	 p8slmCUzo26uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198F339253CB;
	Tue,  4 Aug 2026 14:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/3] geneve: Support per-netns device
 unregistration.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178585201363.3168424.1619703184127764039.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 14:00:13 +0000
References: <20260731164612.2148830-1-kuniyu@google.com>
In-Reply-To: <20260731164612.2148830-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 31 Jul 2026 16:45:52 +0000 you wrote:
> Patch 1 is a prep patch to make patch 2 clean, which
> adds a per-netns mutex for geneve linked lists.
> 
> Patch 3 supports per-netns netdev unreg by using
> unregister_netdevice_queue_net().
> 
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/3] geneve: Unlink geneve->sock[46].hlist[46].hlist in __geneve_sock_release().
    https://git.kernel.org/netdev/net-next/c/cf31c7f186ed
  - [v1,net-next,2/3] geneve: Protect geneve_net and geneve_sock with per-netns mutex.
    https://git.kernel.org/netdev/net-next/c/7df47efd6db1
  - [v1,net-next,3/3] geneve: Support per-netns netdev unregistration.
    https://git.kernel.org/netdev/net-next/c/ccb161b71a1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


