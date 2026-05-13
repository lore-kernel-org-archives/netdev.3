Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53315351C25
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643970; cv=none; b=ePddHEJhk2feCozmRN5ry/MNmBJ90UrijCcD5kSJLdmPVq9+kAA88yXXXrNXM75yoafFhQX9nBHQs6TquKduZHGbQ4LewEIAV1eYl1zWIY972BKnY2HsjHYWP+36CnJ9HWOTz+0wB46AsRG71ytnPSdh68SjGC1hOTgm8iZuxbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643970; c=relaxed/simple;
	bh=zR7j7CZrL+WaUbwULl98imuDq4uUCciikXbO1UKwj2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MpjBTO2pvn53TfuUK7i3rmwgvCsb9G9JRkHfLJ3cxiyeD/II0pXb3tC94ueWCkNbdHkYm67KCZoLwTKxiuPwsKACI9A0rg5GcRhsHPQQUIE8O/2u0AGXjZL6MBShJDXCeygV/YhjlrHAlJcgaeJUtatyHA05nLHjsD4QZ5mNEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0aLYNqG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0aLYNqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA828C2BCC7;
	Wed, 13 May 2026 03:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643969;
	bh=zR7j7CZrL+WaUbwULl98imuDq4uUCciikXbO1UKwj2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G0aLYNqG1q1CEKToJB6s9JI1EOqc6bh0Fxb34Cqx7c25dsrKMVGoS/LxzV01QzNn+
	 R/ZhTWfPo9sdym4oVzHz7hoMeeVYh5hcUI6eL9UGfxyQh5qdWBO++RzcbMHXPqIM0S
	 nt62eMa+/hyew3iOGZ2poZdhUMq2pPvhfWfliL47p5fRh+zRtwPfmtL1p6Y2pVhyUl
	 mJmZxJ8XqQ0Y3K4LscDTFSByEqQMM/lZgyqCtl/KUsiHST3oaINaokiQhLT1SsUuPN
	 1UVduCIaClS7T4Sr3CggnMyajcG9WM86GRgDw/0WH1uW9ocwfOr1SG7yDPuCLDyIet
	 Czqznx1l8/OrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EA53822D60;
	Wed, 13 May 2026 03:45:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] ethtool: fix ethnl_bitmap32_not_zero() bit interval
 semantics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864391554.3173643.17820946029425811910.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:15 +0000
References: <20260511014343.133328-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260511014343.133328-1-zhaochenguang@kylinos.cn>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, leitao@debian.org, horms@kernel.org,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 May 2026 09:43:43 +0800 you wrote:
> ethnl_bitmap32_not_zero() should return true if some bit in [start, end)
> is set:
> 
> - Fix inverted memchr_inv() sense: return true when the scan finds a
>   non-zero byte, not when the middle words are all zero.
> - Return false for an empty interval (end <= start).
> - When end is 32-bit aligned, indices in [start, end) do not include any
>   bits from map[end_word]; return false after earlier checks found no
>   non-zero data.
> 
> [...]

Here is the summary with links:
  - [v3] ethtool: fix ethnl_bitmap32_not_zero() bit interval semantics
    https://git.kernel.org/netdev/net/c/3d042592ebd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


