Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922606;
	b=xemLOdK1OJhgtKEwq9fRKNmzItvCIx2z7Un/3CkkGq5l8Ta+PI/xHE47mz6YUwD2kfbo
	 1KA5KiH3a1y+Q/6WL8z3gv1NyJa+CB4AeUWRTqUssBF7C50Sm3m9oMy5F+oZOQHBNEts5
	 5YoOpFRYzKB9mcKUR055YYeBXkC8Y/HGgwJpYlrllf4fAKJI4SutY/90Byr+Fz4k2vtFM
	 je26LVVc/DO0ZoXV67YbLo6Ae6HrgC4iBMeotgk+EXXrn4Gwpr7YYhSpBMNww1wtn+fGt
	 mUX8C+RA/wYHVG4mTbgvtfsI6OP/63wwhGwbL3NBWXJLIs1W0CMnFV6UXgEDhI7WAnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=7iiR35x4lGpNQ0avK+S/KIS1SfMoxbs/VtZHBn/dnVM=;
	b=f9RtWqELcyQXq80KF248//coKJbkfocLnRKvO3J7W1MZm0vtDyxIo7fUKSwLOIpeJeq7
	 c1hgwAbyy+scBbmSgAhssnvPs4FSq35qGQisw1zOfoK4RmU9bC6Nv2J7HHfnydfr0CO09
	 2byFYbLofp153szL+gxLoSXNQZ4miD0VHHkXSFbe8lNhlzWsZPqE5Amu27Dt+uexmkCeA
	 a6OPGA68REg8eVl9CRSfnPOAjVdhcZE+2eauKamqWwy03TNgDtma30CxzB+xVR6rACBA4
	 mMLoJgJ4DodvCD+ixLzS9YaPJqcOU78h6L4BPNcPFHAhWVQgfCF+pMiK8uX/v90epFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7keFfd2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0073606A31B;
	Thu,  5 Nov 2026 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7keFfd2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7E91F0089F;
	Thu,  5 Nov 2026 23:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793922605;
	bh=7iiR35x4lGpNQ0avK+S/KIS1SfMoxbs/VtZHBn/dnVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R7keFfd2mAjnWwzITb8UnetvkolU7SeLPQKiZ/wHTFAu+Z7TdhpwuZHcBNnU9O++x
	 qhTl8dO2dCuqkw3QOmJTTVLNXwHOv2DLOetJF7dL3LStaB4uy/DYXP3RPNXAS7+6v8
	 o28/pPrWz0LAObfWBRhkU41d0q4h79bPNnc6lW81XjtRIRBX8QiLVtgdEfGnKt2icI
	 QVzf3Zt3lZeUWHRJZLVlg5vCCtwMBesth9v5YxfGPbAbB7ykUVybKGZELTIJNhycD4
	 YFxBvPXOYpRuFMdmLeDpzCSMBCsLzRw2cu2rCcUjLgB1X/ABrRmSCwsBhA1xEgbPIu
	 rlZ9tdtTegjsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E1D6391B1AB;
	Thu,  5 Nov 2026 23:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ipa: Drop unused qmi_elem_info arrays
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179392260418.243275.9113410895242562474.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 23:50:04 +0000
References: <20261102123653.151700-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261102123653.151700-2-krzysztof.kozlowski@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, elder@riscstar.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Nov 2026 13:36:54 +0100 you wrote:
> 'ipa_mem_array_ei' is not used anywhere, so can be dropped completely.
> 'ipa_mem_bounds_ei' and 'ipa_mem_range_ei' are not used outside of their
> units, so they can be narrowed to file-scope.
> 
> Reviewed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> [...]

Here is the summary with links:
  - [v2] net: ipa: Drop unused qmi_elem_info arrays
    https://git.kernel.org/netdev/net-next/c/303d91a15925

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


