Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BEA30EF95;
	Fri, 24 Jul 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935260; cv=none; b=ROSyU+NVRA/xu5usaADQgPTFKowcu1dQEeGIBXSZZAVpK2ipTsnCJjZ5eq2XxCuOYWEl6wMnDeHtEmG9SaG2ECD+Gp0w6VEUkd+O6ylGwifTPhxWpF32NuWf5/XDbkpXaU7IAjPs+FGrs8zjpxW6ISYrUGQorSuilgJke9/TNzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935260; c=relaxed/simple;
	bh=Kr/ywd8KmnBAypdYdj6wpIdfJDqCV8vRtjGOHisBzHg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c+s2/DmwHFHdvH9gQvjQNazrYvuVR8MbRstxTYMnoAH+ojoDkolKF0qrm02sHzKwFRXmvDzgtxl/5lIwZWHFKRfA7S82NYVa3vc9GqfUr1Z7ohky1f+ancZFo+iQd39UtEQ3pZI68+gPz5VjbcslKQvyXNgYiGLepFnolMFJmms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHvqt4Z9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHvqt4Z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447071F000E9;
	Fri, 24 Jul 2026 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935259;
	bh=xSv/iAQx4qgkeUsu4S6uAMTYMaceizbXl8TuvXhHOZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bHvqt4Z9NjB8LJLEtmuM2IEHu1x4KUy6dF5U/gKCOppiouHbrcnCn12mYbJpWfLyG
	 KSunE56UtYH4yNN/tVaZy8rFl7wyv6cBcnwWbb7RW6JsySxa34edpY5XwDqS2LWlSO
	 W77Xu9b0/uzEWhP0fvqwxJN/bxyLMpWziB+maUfYLDYmylFatu0k+9HgiJieSkcXvD
	 zhPyGRuPCx0HpZd4D0slsKUd+1SoLvO1Kl6U9llGrrRZX0rcFNiBSBb3G5o3Ix5ITf
	 zpScxUBIeiS7QFC4lhb+/hqhJMYt6UyjElqeST8Y0JoEfEsg6gp6HsnG1msrHgPDe6
	 gZFAmGZHtvx+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B3C38111D8;
	Fri, 24 Jul 2026 23:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: add support for custom L2 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493522613.3348566.6579358640988949.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 23:20:26 +0000
References: <20260715072035.617544-1-nshettyj@marvell.com>
In-Reply-To: <20260715072035.617544-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 psatheesh@marvell.com, sgoutham@marvell.com, rkannoth@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jul 2026 12:50:34 +0530 you wrote:
> From: Satheesh Paul A <psatheesh@marvell.com>
> 
> Add packet parsing support for custom L2 headers. Also add support
> to include a field from the custom header for flow tag generation.
> 
> Introduce a new flow key type NIX_FLOW_KEY_TYPE_CH_LEN_90B which
> maps to the NPC_LT_LA_CUSTOM_L2_90B_ETHER layer type. This extracts
> a 2-byte field at a 24-byte offset in layer A to be used in flow
> tag generation.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: add support for custom L2 header
    https://git.kernel.org/netdev/net-next/c/e2834100751a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


