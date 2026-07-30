Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DDC476CC7;
	Thu, 30 Jul 2026 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453643; cv=none; b=PhyL6k/asP9A5ULRRpOp/Ie4P28V6hpyLhGUGKaEeEI0sfrFwF/+83lKoUKQKB65F2TgMUQ7IDntEXc9A+7DeWNgnz3+zNPJbtaGvkBQQ79xcJ/y0eAVQUf2QZLAPVKqG+4j58Qja/+DJHD9z+Bg9kIywJFKwyo/jmYkN87owI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453643; c=relaxed/simple;
	bh=5pYHdW/vBRFXy0w1l4Y1ylAPmxkZ0eI2vT7NgL5li0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vCF+addUX4wI8aywgdjjpAe6fTFbh8J5Ox8FR+I7p9fH6bB68cST4iTYq5chgo6bDYdf7Qbax/BfcSYK5PDPYGx3w6Y6ACP1CqfNEgnPJUswpVeyPwVIZY0UE8X80gKMT1YM1tmtuJ3AeyHu39O3xQo+ruoNI4sKSv3rTNlEQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec7xmj7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec7xmj7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098781F000E9;
	Thu, 30 Jul 2026 23:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785453642;
	bh=d2TacTZDef2/EL0R0VBY9nN8vUB2OwHHUhV0sLOuzHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ec7xmj7r53GG2rZhsfwmXRZuVrmU/2es20jGMbhDCDU7B5nxQfRQuV1Qcv30h2YiJ
	 RaebAonsEzy6AJKi98y0gE1upM8JInGjOn2B8TQK+F9QI7t0jvKMrYNqRJd69bgC6e
	 5DVhm/KDyNita/Ni0IWrtXE37LrvF1vHBwbuippeGZwMv8i9OObQQ5JNuJD8rv8dsD
	 ideremtm0Q11CGunDzrxPXolEEhwNQnIDJvlRz92r7SaKh8G/YUG42RlQlqqyg/W9F
	 KhzvswEEkuBSo0pa46j3c3Ys5sadPOJBFiH2QgiT3tlmq/oXuzm/0UcgDES4HCJLod
	 UF9VwrQCOHg0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CEA392445F;
	Thu, 30 Jul 2026 23:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] Revert "net: thunderbolt: Enable end-to-end flow
 control also in transmit"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545360506.33420.2965947923440784665.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 23:20:05 +0000
References: <20260727123002.25225-1-fy15309206903@gmail.com>
In-Reply-To: <20260727123002.25225-1-fy15309206903@gmail.com>
To: Fan Ye <fy15309206903@gmail.com>
Cc: westeri@kernel.org, YehezkelShB@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangjianrong5@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 12:29:48 +0000 you wrote:
> This reverts commit a8065af3346ebd7c76ebc113451fb3ba94cf7769.
> 
> Per the USB4 spec, a Transmit Descriptor Ring with E2E flow control
> disabled does not require any credits to be available before the Host
> Interface Adapter Layer transmits a tunneled packet from it. Once E2E is
> enabled on that ring the controller must first obtain end-to-end
> credits.
> 
> [...]

Here is the summary with links:
  - [net,v2] Revert "net: thunderbolt: Enable end-to-end flow control also in transmit"
    https://git.kernel.org/netdev/net/c/1881f2efbf7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


