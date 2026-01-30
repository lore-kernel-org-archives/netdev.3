Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E15334C24;
	Fri, 30 Jan 2026 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741440; cv=none; b=tUyVtgr+eg84bFX6kemROQAjUE/TmOEekWf8RXNzxo80maeLPlbbqk0vnz2tUwuLKeW7C77bDIT1VHGu6UKQrsx6VOOd9oojbcD83j2Y9Q/FgMvdRed63y03nnc1P4cpzADKaOqxQsflmn90sC1G0V3YmbS389VY/5lWWnyfpxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741440; c=relaxed/simple;
	bh=fFgZmrixKo+SlJgXhkmwmrwWZxofEJUJAMLt9IoJXLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fFgJXCowUZwhnn7QadAc/F1KCNt7ukxQjlBAXe5zUZA2KcPVmaQ7TUNHdV+M1ITcdsg5EYEcMx/x+cpmgLK9SZLBv/rhZBh0e5V3U8SDgP1pUyTCzH9erBmGl9zTgIsRhvMrDRBvKzpPtOb+WrVrbldg3fSLOKMxlWX5HF6I3Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2J7m/XR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2J7m/XR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E027EC19422;
	Fri, 30 Jan 2026 02:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741439;
	bh=fFgZmrixKo+SlJgXhkmwmrwWZxofEJUJAMLt9IoJXLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C2J7m/XRRBFXSSXPheKz/iyRCfTpPfDgpBariyA+Ed38qU9AIFnqf+uemOUJV7ZPJ
	 8lFbJd43qu/LfhtLc+LUThihjkLCC5A7OqGJoe5ZMpVH5joczyBujzCai4ufGTV8gS
	 FOfq9QPg/bxK+vhFUU4AqS17KznsMHgguDXPCRI55IXdLg+ocV4E/9LIrpmyaUfTNO
	 H+V1h5r6bizUhIuKjd/vDeMh1H14NHrf6B7sJcxtKtYbLCIDTnZYLHV1tkV0pKj8Gt
	 4HCsgmtnHkLetkLL6Y18o6GQwzRDuYHEEJxGjRSuRlznRIfuzlEwzrr3ArhXEGrbCX
	 VgfNru9HDua9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8DB1380CEE0;
	Fri, 30 Jan 2026 02:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: qcom-ethqos: remove mac_base
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974143235.3149010.13136116647525256549.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:32 +0000
References: <E1vl39x-00000006uvc-0A3S@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vl39x-00000006uvc-0A3S@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com, vkoul@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 10:52:29 +0000 you wrote:
> In commit 9b443e58a896 ("net: stmmac: qcom-ethqos: remove MAC_CTRL_REG
> modification"), ethqos->mac_base is only written, never read. Let's
> remove it.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: qcom-ethqos: remove mac_base
    https://git.kernel.org/netdev/net-next/c/d414ed34a861

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


