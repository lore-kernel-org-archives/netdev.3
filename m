Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148535E953
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605677; cv=none; b=fM9dFTJipvw4wH743KFQOPJ5ISBocDelkuEAES6oWsKNQHJV9bhfGfYSEu7iAQU0awyrLH/y7XRzACNTN3DEHd1oF7+J+nxltaXWuum3JqA1CYy9cCc9wazfb+LhdlsXjllWYNm03NS0gXwaApMIBWmV8dDMwxuGQViH8PVSE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605677; c=relaxed/simple;
	bh=UGBjZHUbzLe4RpbM3e1kMA74F/eeUqAqEgHFAIYGToU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qxbtAtVGwYmOeG5sjnldiKt/9WRvGuyWfZ4gHS7NvD4We1T94H91n1PyckS6YuJ6UCaM/pn60vobp6lA+qePq3aVS5odhpKUsLN867OqQ5tVMHLXR02KAlrQ9sFa5SDz1QCWePFSWEAxm5gZPyp87Tz5vAa8LZ+bBYXurSr2ahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/mQXRMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/mQXRMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B727D1F00893;
	Thu, 17 Sep 2026 00:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605676;
	bh=yylvFiBxkPHrcVg/cuvR+3wJAZGklvGvDHmCS2k26lQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K/mQXRMZsH1YdBmHVwyb5CSDSGqouQptsX55NygOFpUzubaCs+XUIU5jokt/DixP6
	 k8I1V0Vl9gXy8jNVJ76x0J8xgf2yyaq8olSpGxVmZ+1Ka569b1jh8mTALx0TQ8FJFH
	 g2xF9gkiQP8ni3D3AIUuHY/XKuEH/L0adC6tQgLNZTb+mMU3IWDV50tfGg3Dzq1RwX
	 q8e3EpyupZjuEkGQDjSfTHGIyDOJV2uJhCtbRjMnUcGI1oHSr4DovWOXxFGfoMcAup
	 CfyOqlB2IGDsyZ0QDr/l/XjenGzvhFPOlSRGRizuKU1VBBpRMud6J6bVFUlLjsRvhV
	 F0P62KA201Jow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A7A39E9601;
	Thu, 17 Sep 2026 00:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: ring the doorbell if a burst ends in a
 drop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960561037.3354472.15026253707073838985.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:40:10 +0000
References: <20260915022327.913218-1-kuba@kernel.org>
In-Reply-To: <20260915022327.913218-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@fb.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 19:23:27 -0700 you wrote:
> fbnic_tx_map() skips the doorbell write, and the completion request,
> for every packet handed to it with xmit_more set, counting on the
> packet which ends the burst to publish them all. When that packet is
> dropped instead - skb_put_padto(), skb_cow_head() or a DMA mapping
> failure - nothing rings. The descriptors of the preceding packets stay
> invisible to the HW until the next transmit on that queue, which for a
> burst-then-idle workload may never come.
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: ring the doorbell if a burst ends in a drop
    https://git.kernel.org/netdev/net/c/490599ab2313

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


