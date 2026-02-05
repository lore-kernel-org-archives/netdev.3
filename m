Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674112D739D;
	Thu,  5 Feb 2026 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259827; cv=none; b=IeeOKO0tEtQDl2N0TTbGXghJEaP7ERip+OJQb0zhBI70Bz9HxIL7ONMQSQ1kbd20d895997RBhk4d793wjnYJ3Z32x3qFV1SOFyJPca1s/js5jMoBhuuEg+d3/TPFxzApBu876dlcHqvyXfQmVRLLJUg1sku9YxYGOWY8wJGtYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259827; c=relaxed/simple;
	bh=5bzmJBBAl9LNtCSquPRU1rjB6z6i3JW/4hlRmDTvJ/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fotwb8kiYN8lj+RWL5/P57Q4nwBIU7DEfljYFfBqokh6JvTC0DiIm+CfThzYkEW8Bn9cShOn9Zo+ee3vLRWTTiKOCoslmIRmDqFAYRtYZrW4MeEBJH5UHLwu5mgCVw+TEteTsmKO1wIHi5CVbCLBe+hRyF9QNw/x2yQJBsAoRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDVL2CsM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDVL2CsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45627C4CEF7;
	Thu,  5 Feb 2026 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770259827;
	bh=5bzmJBBAl9LNtCSquPRU1rjB6z6i3JW/4hlRmDTvJ/o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VDVL2CsMx0aDRp9XaTcoNZb8btqbBBZ8CzuS3NN1GHMLQ8npk2iIJSEIdXVXbJf6n
	 NsLMLgFZi0UU9q/mhA+WvHRsqIUWijYGcWuHWUGsthOLmgokPwJ39vZxu5K53h8UxC
	 17DyNQTxdHEhmdepp/lZ1pQ3kKeRzqHlOAXKRSuC4vh4yGUCPWbssQT72zajdhzqZv
	 FYbjX85P7GoBtBfNzCUjlp8w7SsfZoUJi77mSdETeIgjT3JzyiQMTtJJIOVnhn5MJy
	 +gSM7cwMp4AF/HMxhqQp5N4ANAPxhqgOLuXovpm42i5vPxKG3u+Si67zfNaU/55E9M
	 DKCzq/RdD3AzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 852213808200;
	Thu,  5 Feb 2026 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: renesas,rzv2h-gbeth: Document
 Renesas RZ/G3L RMII{tx,rx} clocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177025982507.136386.1689531838024024546.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 02:50:25 +0000
References: <20260203104541.264759-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260203104541.264759-1-biju.das.jz@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Feb 2026 10:45:38 +0000 you wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> As per the RZ/G3L Hardware manual, CPG_CLKON_ETH register bits{12,13} are
> to control the RMII{tx, rx} clocks. Document the rmii{tx.rx} clocks for
> RZ/G3L SoC.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L RMII{tx,rx} clocks
    https://git.kernel.org/netdev/net-next/c/d2adcbdae5f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


