Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED03B28D;
	Wed, 28 Jan 2026 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568615; cv=none; b=i7xAYJ3+pEtjEFeaVAhJIBDJKVMGLqQcfkDUI/gYxS6tOtBW7rE1vMxiUyv+ej4OdbE84duFul11AHfPH6tznqg1cIuN2Jrk15JewUz8ZMqoMwXmsH8t4h4bCTfRu3SimGcXuQTFJYnP8grJCX3P181ZiJyo+SfL00h504T/RE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568615; c=relaxed/simple;
	bh=/lJBRbUw2FgOeu9CUWj5XDqNlE5oJrvnM3fCy6xORvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tCC7KcADTfHaBey4h1YbGGa9jgg3upwDGSplmA7QIeNAbf6mKzbv89oDasDJaAwtom+3Vpx06gOqcY2KQfyaW2k3SQY7I53dqkgyOW6tQAjSRPTejzpWuCSKS3+DHcsceFxYHisA492KB0d0MlBHS8OhaOuvzLsLWCCjt9Xz1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfD381Ia; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfD381Ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2947DC116C6;
	Wed, 28 Jan 2026 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769568615;
	bh=/lJBRbUw2FgOeu9CUWj5XDqNlE5oJrvnM3fCy6xORvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OfD381IaIQUZjrCMbXeaxVJ+CRcD6Z9F7HmYQSjZ+B8ltOaPVcrI5axo42cl1bEQq
	 7pnaoDpBa6AKgfzmP6kuISS35Hlp8qhc9FOeslp48ZC+6o/RaOrSuRmglqDN9g9CYK
	 MQcVhcw1+Hhx6/LZQbD31bJBJrAdbyhyChWvk6oIn/d3fZGLUKxNPywg5OEfuzTD61
	 ZAWqX75NyJa8fAuIVyo4SJ0p1udb/LnSqOp7om+Ou9AJ817SVCe0dF2KUagB1PoQSx
	 m0LYDfT0LE5SmDLzP0jPSi6XRZ6Pz65ujyi7ROl3lS7ittstt/e6/8m59z7f6pgCEO
	 Oey6xKHcjp1ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 119E43809A15;
	Wed, 28 Jan 2026 02:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: fix probe failure if clock read fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176956860860.1489558.7327500062965937708.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 02:50:08 +0000
References: <20260127010210.969823-1-hramamurthy@google.com>
In-Reply-To: <20260127010210.969823-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, willemb@google.com, pkaligineedi@google.com,
 ziweixiao@google.com, jordanrhee@google.com, nktgrg@google.com,
 thostet@google.com, horms@kernel.org, yyd@google.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, shacharr@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 01:02:10 +0000 you wrote:
> From: Jordan Rhee <jordanrhee@google.com>
> 
> If timestamping is supported, GVE reads the clock during probe,
> which can fail for various reasons. Previously, this failure would
> abort the driver probe, rendering the device unusable. This behavior
> has been observed on production GCP VMs, causing driver initialization
> to fail completely.
> 
> [...]

Here is the summary with links:
  - [net] gve: fix probe failure if clock read fails
    https://git.kernel.org/netdev/net/c/a040afa3bca4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


