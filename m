Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF4320CAD;
	Thu, 21 May 2026 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329424; cv=none; b=Qex693ndHvWISOp9APzv5FHqI79otyOejzRdohBSOVoxwdAz7OSIz3E5G+wNyQTIrWwNhFZrye0xEMO0oH9YhSRHYoagdU7QEPNCCwD9eYZeLdbke4b+lwYpw0ElGs6ukFOwSZlBrCa8hYxBi9oj6f5AE530CJQavyrQMJirdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329424; c=relaxed/simple;
	bh=014hLeXWRzkfyG843Oofxxk18hhNyosmXM2+9JA6TUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lWEYpAq4JGpEvKOyIAS+kLLsiL4el+nLyzGj88/sfBv+tr24poptEbYQYuzdpkthN/+wEwlVRMuMQ9af9L2kVLjUUhB/u6l+2bPfkxgpyfsFZrI9/tHCLdr04Jgbm88zZIiQkpPsWHmAXl+FBRRU6WEbhfpSRNnxCIDSiOXQrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geubAXDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geubAXDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ED51F00A3B;
	Thu, 21 May 2026 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329422;
	bh=1fkM5RJG2Va62IbGFRxE0s4BRMstUCnWwxlmqbrKOrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=geubAXDfpsgJtUPC3q7ZX8aCxQTQdrH1zmu5sHiqCROPhbNxmiKsPI4AMfXJC05C1
	 3WwSj6hmtSasqw6f+F9i81G3O8c36ni/RL4h8VmR012Hkpi5vqDXNpAI4bWa5hKMri
	 +HuL18rML4+Fml4NG3JQHgSGpPT1oZGPUz3acmGebgk3Dw3bwH8DNfo3egntw3JK0E
	 5OozcKgbphzqGdYul+lfMsShVWZLwyDqU6F30k7/0+vfPyZSyyLPS4/ViDhV9CDlb1
	 8qyBPf7/0rWqOtdPEkIJMUHqBxZOEcWwn4vqQSSHHMNX1H6nMoiJ2kll83xWIKyHXx
	 m2zeFzDX20fnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E53930C38;
	Thu, 21 May 2026 02:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] mlxsw: minimal: Use named initializers for
 struct
 i2c_device_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932943265.3832404.360063047381979287.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:10:32 +0000
References: <20260519160721.1597568-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260519160721.1597568-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 18:07:21 +0200 you wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> This patch doesn't modify the compiled array, only its representation in
> source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] mlxsw: minimal: Use named initializers for struct i2c_device_id
    https://git.kernel.org/netdev/net-next/c/e2664271503c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


