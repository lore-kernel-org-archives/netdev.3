Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162E1E633C;
	Sat,  2 May 2026 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777741854; cv=none; b=HMqci64CUIZ2ab1bpZI6kEw0YO/IsV4FtF9Bt0L/g/AHX91GrH8d7E70ZJ6g4KFq6Fg+H6EPK6tjhiOpjsV8ckdzufLc1Y9v+qpAi45g5VVpbBE6ImFKRyEctw5dZ9rHH3hQlgUZ8R/+aghpaZJH1oVwwkUG5w6i6w6zcr7ITiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777741854; c=relaxed/simple;
	bh=Q2UAvw0yGNcWrp8SQTns4X1NqSMN/8gpGltWrh/7v/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XNPSpNAG0eTtvrgczGTjy0DioRGNjtfWLLm2P/mj7NHg4+sfvLtd/jglWbimhP15NntrKpMrbvZGZI0r9WIaJI1BTNTwn9ssS6WLiix1AI3Tu1MxBr9EmYj46+RAM8HwgUd6wxqNgV0GcmTy2H3Xg1ifuJqhSo1AiKbkGXXaWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq+sNesR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq+sNesR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A4BC19425;
	Sat,  2 May 2026 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777741854;
	bh=Q2UAvw0yGNcWrp8SQTns4X1NqSMN/8gpGltWrh/7v/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aq+sNesR/PyWpq0DW9hDbtyOl+Wdcir74VRXvlN5c4tbpJj4ke82ICc+HTfsntPwd
	 5A7hYXnnrLqGJiQymlxQQFNI/JWSt0R+vTaeexzriHILf0PskZDw8uRwkJwkzsAyUP
	 56lNhVMPfCTJmieMNH18YiLtemWWT2Kd09hf0mnWRJwvYkKv/R/+WYxW6vldwdYND7
	 vFVEV7ZjC5eHrbgAeYZTC4sS0a7uTCR+dIlgYu/lTV96EBxGj9T5hoqW+X5uRFcvKq
	 Roam+zI6wn4pJtk98NjH09pyzECavx/dm9DfMaQLGZUvzEptCy5KUsx/JSxv3fesEm
	 GfuO38GuLkBXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC0380CEFF;
	Sat,  2 May 2026 17:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: MAINTAINERS: Add self for the DEC LANCE network driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177774180657.3887389.13042106508247378444.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 17:10:06 +0000
References: <alpine.DEB.2.21.2604271113520.28583@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2604271113520.28583@angie.orcam.me.uk>
To: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Apr 2026 11:23:35 +0100 (BST) you wrote:
> Like with the rest of DECstation and TURBOchannel hardware I have been
> handling the DEC LANCE network driver for some 25 years now anyway.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
>  MAINTAINERS |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Add self for the DEC LANCE network driver
    https://git.kernel.org/netdev/net/c/ddca6da148b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


