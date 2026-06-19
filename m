Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66D2E7BD6
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831425; cv=none; b=M+fjwxvbWIWLELy+e7vzo6ZZzo2UtWybqG/Np8id1Q1g5qS5Qgy8dJ5NqPmnISiPwSJty9RlxycoY6PLHJfx6adzOaLRJJVfucqPcF8+v3Zr0Iw8hyaVRr0L8lWKElEwPEv61KQ/6I1EJ/P+622NBC+HA8WLQZZ4CdB9GgkfKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831425; c=relaxed/simple;
	bh=xeUf5Fmw6QgO8dsPxVgIKo+zqTZdz1zP+nBJdPHZnrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MWXTFH3SrHsrLV78kPCCm0BHs9ct1NPUIuHuKfAD3tOYRxZLPMjXMBZzp7K/g6UBZrec8tGdwgoyKiyg8FjU/7zuZyHXsF/MW0L20SSerPsLYCAqplBuGbLY5G91DIiRF6aziAOUj5loojJc/aM6f/sqZ6CmOF2ycGqvEHcKJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUrONHy+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUrONHy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165311F000E9;
	Fri, 19 Jun 2026 01:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781831424;
	bh=JOln0UvL59U9cbeSPAanWAvcaPgZHKFV7CV3bDFVz6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PUrONHy+tIpQSiAZ/nV+RG94J+DrZh4UdL/3d5zY0yPex06I5FeHzOkgSmiA0Gueu
	 LpMfRfaIDgZ0UHqMxm6UCUul0hBvOa40UuzSAec61Y66I0unfzbW+GBFbNE6n4lWbw
	 PLoHKD+x7qExsuVTdagliZ4Fr/KbGdx9wZZvpGQhhcGhXXge0+hYXIxcg0RhlS/IUM
	 cI5A9QMUGOGtIViQnQb5G4hbp/fEK59YZJpQmdmEjSw8byjPXGhpvdNNgYGjauRDf1
	 5hBlQRLBBjdZHZFm0ow2I7emoNrpig3kAiZk51PZAiAOMmJjIl6TlqW50udhC71NzX
	 TYmizxXY2Iezw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939D43A78A7C;
	Fri, 19 Jun 2026 01:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] [net] net: airoha: fix foe_check_time allocation size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183141720.3148637.275902636532056591.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:10:17 +0000
References: <178161119471.2163752.14373384830691569758@gmail.com>
In-Reply-To: <178161119471.2163752.14373384830691569758@gmail.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 19:52:36 +0800 you wrote:
> foe_check_time is declared as u16 pointer but was allocated with
> only ppe_num_entries bytes instead of ppe_num_entries * sizeof(u16).
> 
> When airoha_ppe_foe_verify_entry() is called with hash >= ppe_num_entries/2,
> it writes beyond the allocated buffer, causing heap buffer overflow and
> potential kernel crash.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: airoha: fix foe_check_time allocation size
    https://git.kernel.org/netdev/net/c/5c121ee63568

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


