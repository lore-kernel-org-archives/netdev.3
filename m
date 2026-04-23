Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49023D7CE;
	Thu, 23 Apr 2026 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776981050; cv=none; b=UJ/X4gr4m/pU7k9urtrj3QmTp+min5Dkr8E8/ZdrBjE6xULY+CBKfM9qM1Z2mbg8ny2lmDyQgxzkXLW3Jd7kfYmpyRJCKaSiq5wLqaig13ojbWfhQ+CDpLxjSJuq8YlsK5h4f+L+s0AsRBfk9kbvjrSeU5Ib00CnALPrrCYc5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776981050; c=relaxed/simple;
	bh=XYuKr+eaOJj0h6C00DY+gStx8tqVxxnWPOfaL0ideFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o4FMsOoQUvbR408104n2lgwOku3TF1LV7EQU0W1cWNvHo1p8UzwjbJQe3zDioDecDi2Wh8PBHy0meAXz/Y5f2PQIXla22ahtJYbv/CDYDrR1aEimrDjlMBSuhCU+ql06CeCyB87geoa4N03FgRZcW6aFVLIOjwHY075VeI8irck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4JSeUjv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4JSeUjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CDFC2BCAF;
	Thu, 23 Apr 2026 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776981049;
	bh=XYuKr+eaOJj0h6C00DY+gStx8tqVxxnWPOfaL0ideFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n4JSeUjvAxQOaOZKSOuAOEhyZUagMglFLYbT7kJx+29PPFnKsb6tTP1EOg4u1H7EP
	 yXkBPNp/8ZRIzUs7Qq/yhSpolzWadXLwcKXGNfIWnCOwjUdV3ZxkOLvkTTf5/0h1/W
	 L4xCJ1j14PM0D5r6qPNc8SCRQBUfzES5Eu8ycMnjQNSWCAu1qwDDPuj8Rri1M2KRj7
	 Fu1IPdk+fYvXmeT+uvaY2yBNPueADw/Rstab0UUu5UDhpU1SS5YzwkYudvf54eOhQy
	 oRf93hINIew46E78/SdaylGufTbWb1lUXCC4vIqIfDOGMROxcla3p+Aj3lo/jRsERh
	 CdSaDpnAtFYSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DDE380A94F;
	Thu, 23 Apr 2026 21:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177698101049.775674.1567171164890583654.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 21:50:10 +0000
References: <20260423200909.3049438-1-dhowells@redhat.com>
In-Reply-To: <20260423200909.3049438-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, anderson@allelesecurity.com, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 21:09:05 +0100 you wrote:
> Here are some fixes for rxrpc, as found by Sashiko[1]:
> 
>  (1) Fix rxrpc_input_call_event() to only unshare DATA packets.
> 
>  (2) Fix re-decryption of RESPONSE packets where a partially decrypted
>      skbuff gets requeued if there was a failure due to ENOMEM.
> 
> [...]

Here is the summary with links:
  - [net,1/3] rxrpc: Fix rxrpc_input_call_event() to only unshare DATA packets
    https://git.kernel.org/netdev/net/c/55b2984c96c3
  - [net,2/3] rxrpc: Fix re-decryption of RESPONSE packets
    https://git.kernel.org/netdev/net/c/0422e7a4883f
  - [net,3/3] rxrpc: Fix error handling in rxgk_extract_token()
    https://git.kernel.org/netdev/net/c/3476c8bb960f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


