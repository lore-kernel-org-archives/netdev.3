Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002B280A58
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194811; cv=none; b=ZzPYgybDQBAKDp0s4CXUsBcWaLwHYnCuzmrj6eYlYyjOaYp8ifLvYvyyN3k1DgSBd4SnU0HfQ5vgPcvSwH36YrU3/PKXcHAD1yXfl/Ci6oxY4ef7Ij04hzaq+J5jR5wX6i8aPP92uJcCiiL7HfEgmwyepEWii3L48+SzhdV7KIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194811; c=relaxed/simple;
	bh=6ZlSmw3+0Gi+KfWcFbEdYCu/eLYX0UoNj3aYLLzXFBg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IyYktACr0jSv24AgorqpmeKYJAzRv1PTW0/0mEa/1gqC4MTldgTPpVZ4b84TyyweOPyBFkGnVe1D7aJ1GrLdryOwqYjpOpgAx0WRIAHmc02M38ESg+hW/MZ2a/F+Z2v9j5J8a507KtmKYSidBsW933CjUVS6Ff2/0kYkGBi38d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8S7pVi/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8S7pVi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8096CC4CEF1;
	Fri, 23 Jan 2026 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194810;
	bh=6ZlSmw3+0Gi+KfWcFbEdYCu/eLYX0UoNj3aYLLzXFBg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q8S7pVi/JvTtYSUX5NzOe2a0OAhby/30eDGtsPKnizGZebWH19umxh+2BahCG7Ev/
	 hMHzc19BDC0d6hGdZyCVUr38wsjduDV24RihqjquJJRZYcrS6qtnx7qV0VQ1+82vm4
	 4UP1EiUcek7TN+1ysGeZ3hGCQIsuhddRhWmol3JZhPcGZKOgOCmC+6d4GL57UM7HWF
	 O1yLZtYMJu6d5LMdzPY/QMRIG7x455h/z1mZeiSJnfo35pxNOVVAuNn6dEFyxjh7tA
	 L3kUWYpMV3LIjpTUUsDyxGkzwDT9lOEPri3OOh6SIQuA5yj4k04bHfbj+xZ/xtkOkX
	 IgarlmB9OaVow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BD203808200;
	Fri, 23 Jan 2026 19:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bcmasp: fix early exit leak with fixed phy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176919480636.2680587.7223132808988495649.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 19:00:06 +0000
References: <20260122194001.1098859-1-justin.chen@broadcom.com>
In-Reply-To: <20260122194001.1098859-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 11:40:01 -0800 you wrote:
> We are not deregistering the fixed phy link when hitting the early
> exit condition. Add the correct early exit sequence.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - net: bcmasp: fix early exit leak with fixed phy
    https://git.kernel.org/netdev/net/c/6de4436bf369

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


