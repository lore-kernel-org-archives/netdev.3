Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890922A4E9;
	Thu, 18 Jun 2026 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742068; cv=none; b=IUwUbQIgAxPyV+JDAnFfnQrW0Q4S4tJWyNa+Gej/4xBEtG0ZfxI5+6R7p0UBPzUo7FCLXYRTHZZIc24dVN2pzxj6moFY241snxNxCVI72ubyLNf5paUty+a8/lr4kGg1aRuVl/Ue7Q6L+LzQ57+3TVaDd6xrkEzo2BT+Ohodixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742068; c=relaxed/simple;
	bh=2WTT98E8KEoPReZ2/+asMGTMUPQhF/L4h31pG0Cy4X0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZLtkK3KIWQXz/uKnludGpfw4kDWEIcCQsts7gHNVRyFbibRwbSEAwBx1R0WNrvXMRZ0QZl2yUyksG97F5G/mZxCL9t754hLyKNC/ZUXAkimyfZnA0DobW/RshUufepAnUO/+RrbkyvjAobEfG/REhZPEj11ii8hANbSDpsAQ+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BChSyLT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BChSyLT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045881F00A3A;
	Thu, 18 Jun 2026 00:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742063;
	bh=CnKc1zxzJjxcITgZCrAm3/6g/nQ2f5tDa/Lj4Rv/hCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BChSyLT4znkxzPl0YIrG3FRYyo9G+LpL2zJeS5ESSc8kqal7hUCnce8Y1GhEc99Av
	 P9WotLaFKnyUr5McSLqY6tB3sSXHMNR7KRzOvd6fjkOxllY0gBPrI3unmbayl3LY7d
	 yry2sjmVWPqjckhPRBqDXzoqmvRlF/P/CZDLM3L3sfRvEVGESkQFj0Hoy19GLHL4vV
	 1mg6fDe8YgEmM/UpGN2VRvG020MSvENMiVCbrXpsGFRGW8C3V0MfkrFG9xR/B2u9dG
	 FrhhNwYbjJ9PKFKzp0V1/vVdJNd31FbAgFTAuGACrCCkzRVrYBqxVnlzISpwHapLKb
	 WODcoCi1f7RrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AC5393102B;
	Thu, 18 Jun 2026 00:20:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ehea: unwind probe_port sysfs file on failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174205663.1875263.17327894166816318407.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:56 +0000
References: <20260615070033.43461-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260615070033.43461-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kees@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 15:00:31 +0800 you wrote:
> ehea_create_device_sysfs() creates probe_port and then remove_port. If
> the second device_create_file() fails, the helper returns the error but
> leaves probe_port installed even though probe treats the sysfs setup as
> failed.
> 
> Remove probe_port on the remove_port creation failure path so the helper
> leaves no partial sysfs state behind.
> 
> [...]

Here is the summary with links:
  - net: ehea: unwind probe_port sysfs file on failure
    https://git.kernel.org/netdev/net/c/1c4b39746c4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


