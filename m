Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE83FB7E1
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851809; cv=none; b=K1KVWL8lzNtpdngM2ErynR5OdNu0WPXqk0NGzmavx69jHSL0cjbDLj4C56/Rx/KnGRcUcJV8xqqudAW6JJHl53TRlVu783kK2M2T7cgxlDnwN1ocRDPMF27GRx9fJ1NbFCcGaghdX7uVw/dnTy6a17JoOvsiaNOuJ9Wy/wMThTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851809; c=relaxed/simple;
	bh=opJGwfMVEaQZsovxx0BHYyQd3XCglf04xMSgN5euqvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JYXRDtQciyStSbGdG+M4HqGgJeBFC8DYCQgqAFlXdYB+pevqdZ/iDakNAJHgCJXhfsJpfbs3qsMeArakoS3m3SRjdxDLr8k3VOMY04drV/M8Dt+5MzuAakQj03OQDDyUaPf4AHn4xZyGtXW0dbW7wiqJTCyjJkTuvzrS5R7wp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGC434sU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGC434sU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065241F000FF;
	Thu,  1 Oct 2026 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851806;
	bh=CbdhKuiph+weZ08ZwmXCo8ihmRtR2AEI07mZXvOrqWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VGC434sUpSOBf/8IsyKM/zJWWCOIncGZrzjsUGDjf5RSn+nkxp7fbI1B63gLgfe1z
	 SMPMvmUdMUyj/t5QQDDXBURZsSiCXT0IzyJuR4+YDg7FJJKozloUyLM+hqE5aO5L8L
	 rDNOeJUplTHP2P5QJQ1G+XOzZsM5CANd8kMdNjjtAH7HPxbPirs0/tJgjsSmkFzrQj
	 bpWsoTUDtknPKxJV1PNYjOgAr/y5t1i7WWRiKS8xR59H03g+KP3CEPxxGRhxqw5cNr
	 VLnG4D9Ql6XuYrZRIOnyoV/J5rxCYM0NXDScFWma+FRk8e2FIJr0M2p0oSUPq3ljYa
	 vB/Fm3UvmjPCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14DF380DBDC;
	Thu,  1 Oct 2026 10:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: only give queue leasing devices a separate
 instance lock class
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179085180478.2388649.13175657054038445798.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 10:50:04 +0000
References: <20260929191543.3295633-1-kuba@kernel.org>
In-Reply-To: <20260929191543.3295633-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, razor@blackwall.org, dw@davidwei.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 29 Sep 2026 12:15:43 -0700 you wrote:
> Commit b6f74dff6d26 ("net: use two lockdep classes for the netdev
> instance lock") put every device without a parent in the virtual class.
> It also restricted the locking order for the virtual class, because
> queue leasing has hard requirements on the exact order.
> 
> This bites us back on bond, which is "virtual" and needs to be taken
> before taking the locks of the lowers. NIPA hit the following on the
> new test I recently posted for XDP+bond:
> 
> [...]

Here is the summary with links:
  - [net-next] net: only give queue leasing devices a separate instance lock class
    https://git.kernel.org/netdev/net-next/c/ddef4c2d6d07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


