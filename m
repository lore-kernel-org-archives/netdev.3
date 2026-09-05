Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F237E2459EA;
	Sat,  5 Sep 2026 01:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570675; cv=none; b=TqW9l+7xfy/0Jx8U1sh7t+0U6WGjIR7WPmQbiq3UmDsibnAIg+9/ojqmJyjVSB/7CdjulnoaYQDLNJp963iAlg9ZNc94YeCUVPJUig4M/plKQ7z9/iURLDbuTjmggryKNIEadaITxIh9162vl1RfdsWBDBoaEvRVzJmvxpAxEGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570675; c=relaxed/simple;
	bh=DObh0bhxchINFzCdCch8hAytuM+fDC3O6uWJdtvn3p0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TIxisccbFRbHpmPWyuMhRKnuArDwqeuhAOHS1lc8imnPguXqOV3qLaeI9HHTuCRw1i6dKGkKpl47cm4UnlknOkHmsT3xal917aPRhLQXlkVLIVb0g+/7mnkmSEQb+x9XmxjL0GIGP311MgwP9Q9tbVxGiFoWhc8cXUzUgTMFJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7j+u8RI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7j+u8RI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B481F00A3D;
	Sat,  5 Sep 2026 01:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570673;
	bh=d7cfKCnUtikvVVDDboKxwvhfseWrrDeV4PaiCJ7rJ/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=a7j+u8RIR1CEP7BEWLeOFl/Y8hx1ElLgf74KGQdWaFxIx0D5M2ezqg+HKZh7Oix+p
	 U/foVZ4p96KSGubJRBCVlTKSgs+AFhVyxQ+DZr81GK3Aj/UvWmi73OP0oTdQpX6xxx
	 fC9pAFhCyFfbkQLKCIqP32EZwlMz7dbuu4ITpOJHr1YUfWXy7MEcJB8fJEoNrw1LSP
	 xMJl2pkEEVdISgiB+rfqNRZojrAJsUEvCNzhV6+5/1IaYfPlP9pfRdNuBg0zyFoixm
	 18dxc3ETgBGJIjCbBWpp9LrjIcC0wM0tLqhVYRmTOiMOw+KqoH+WXEncbKXmkjNS1c
	 xd3Seen8UKKnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568EE3924FC0;
	Sat,  5 Sep 2026 01:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: Show DMAC filter drop count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178857061389.1044635.8541013262312747792.git-patchwork-notify@kernel.org>
Date: Sat, 05 Sep 2026 01:10:13 +0000
References: <20260901042503.1182121-1-nshettyj@marvell.com>
In-Reply-To: <20260901042503.1182121-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hkelam@marvell.com,
 sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Sep 2026 09:55:02 +0530 you wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
> 
> Show the number of packets dropped by DMAC filters in the CGX/RPM
> debugfs mac_filter entry.
> 
> CGX uses RX_STAT4 for this counter, while RPM/RPM2 use RX_STAT2.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Show DMAC filter drop count
    https://git.kernel.org/netdev/net-next/c/5cce5d29273c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


