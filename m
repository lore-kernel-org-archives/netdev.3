Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF318DF92
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674229; cv=none; b=LsJMjFvB1m+vcBCA55pHNqbbUBm0MoQbDofjtH0kozoP23SDANJZ/MbJsAYvpocUntP18XZbJhRM+uBpU/WAQyO9IhFaX5hbU3ZRnWibrvlUWIPo/8kD7h405O1SIDxJ3d39FWvfYenV0naXCfO7v9zJN1Czbuyy5dcPinNBBeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674229; c=relaxed/simple;
	bh=ADCg97cO1cvD3ZAOFwzpboJctnPsW3qn6SHcJX9EnaY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BlcPfsepQyqXdsLXE4SER9fzvbMkMmxzHXW2DgO9WjOAdEBZ8AYJNXtJMf6lda2hih6gZuYqZwk3L05Wa3XRO2g1GlmlMgbEZZKtdQrzqXu7sesroLEFv9AkOdmdAYNj2qIZ09KyNlMRcMB53jVuYV99dW2zsHUB3SzKI6BWFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIq3HLYb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIq3HLYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CC3C4CED8;
	Sun,  3 Nov 2024 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730674229;
	bh=ADCg97cO1cvD3ZAOFwzpboJctnPsW3qn6SHcJX9EnaY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FIq3HLYb6KCcJ0wvgY1bAY34eTeYiT828kTZTangSWG8vbI74x2EwZwK8Z8XCm6WM
	 rM/YzDOkKykoSjBBJd0s7roNF5lc1+9jGOF8DXArWqS6JnuhOgdNLPFu4nGQnDu4MC
	 U0t7XU/COjS81/I/8j62Tw9KCAI/ZCqH/icbxSx070oVmsr0WeeUcrW3LXqmGjxjxJ
	 PLes/fO/IdQfDmuIPSWZi+SJp/TY9oUg90lvM5bi139LVJoi6Q2HQteXiyg2cvUwWf
	 q0+tuKRu8MlGBCEVbqGtk5QPbR59G1LO4wBkGIV3r4fnc9rkvNrnNS5tYpMXI3P3jf
	 dkpTVLVuj4AYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B8038363C3;
	Sun,  3 Nov 2024 22:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipvlan: Prepare ipvlan_process_v4_outbound() to
 future .flowi4_tos conversion.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173067423774.3271988.16980771214131369723.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 22:50:37 +0000
References: <f48335504a05b3587e0081a9b4511e0761571ca5.1730292157.git.gnault@redhat.com>
In-Reply-To: <f48335504a05b3587e0081a9b4511e0761571ca5.1730292157.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Oct 2024 13:43:11 +0100 you wrote:
> Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
> dscp_t value to __u8 with inet_dscp_to_dsfield().
> 
> Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
> the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ipvlan: Prepare ipvlan_process_v4_outbound() to future .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/0c30d6eedd1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


